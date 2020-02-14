Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AADA15D47C
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2020 10:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgBNJOq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Feb 2020 04:14:46 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54402 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbgBNJOp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 14 Feb 2020 04:14:45 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01E9Egqw041694;
        Fri, 14 Feb 2020 03:14:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581671682;
        bh=y78xSIuHzdAwwROj7T1USmG5wMQgDcQjT7ar5Rw9eCk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=okVPyoMVQsB9qfQ9oehBkVJDhPnsXyf6QXWCuyra+4yGWSlvNdbhREngSAcjhwVu6
         uzULwHO14TUZxcWdnAd4YPZ6EPaKo7SfENxm5o4QRORijvtPw04cPyL6xq3N5S+h2L
         qFN2RGz9TZBhU+7dGMQZqqAGwyKUG3eoUVffWxMc=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01E9Eg4V013478
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Feb 2020 03:14:42 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 14
 Feb 2020 03:14:42 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 14 Feb 2020 03:14:42 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01E9Ea3w043021;
        Fri, 14 Feb 2020 03:14:40 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <grygorii.strashko@ti.com>,
        <vigneshr@ti.com>
Subject: [PATCH v2 2/6] dmaengine: ti: k3-udma: Workaround for RX teardown with stale data in peer
Date:   Fri, 14 Feb 2020 11:14:37 +0200
Message-ID: <20200214091441.27535-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214091441.27535-1-peter.ujfalusi@ti.com>
References: <20200214091441.27535-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When a channel is asked to be stopped (teardown) and we do not have active
descriptor to receive stale data buffered on the remote side then the
teardown will not complete as UDMA needs a descriptor to be able to flush
out the DMA pipe.
The peer is trying to push the data to UDMA in teardown, but UDMA is
pushing back because it has no descriptor which would allow it to drain the
data.

The workaround is to create 1K 'trashcan' to receive the discarded data and
set up descriptors for packet and TR mode channels.
When a channel is stopped and there is no active descriptor then a
descriptor is pushed to the ring for UDMA before the teardown is initiated.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 168 +++++++++++++++++++++++++++++++++++----
 1 file changed, 151 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index fb59c869a6a7..cb9259e104b4 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -97,6 +97,24 @@ struct udma_match_data {
 	u32 level_start_idx[];
 };
 
+struct udma_hwdesc {
+	size_t cppi5_desc_size;
+	void *cppi5_desc_vaddr;
+	dma_addr_t cppi5_desc_paddr;
+
+	/* TR descriptor internal pointers */
+	void *tr_req_base;
+	struct cppi5_tr_resp_t *tr_resp_base;
+};
+
+struct udma_rx_flush {
+	struct udma_hwdesc hwdescs[2];
+
+	size_t buffer_size;
+	void *buffer_vaddr;
+	dma_addr_t buffer_paddr;
+};
+
 struct udma_dev {
 	struct dma_device ddev;
 	struct device *dev;
@@ -113,6 +131,8 @@ struct udma_dev {
 	struct list_head desc_to_purge;
 	spinlock_t lock;
 
+	struct udma_rx_flush rx_flush;
+
 	int tchan_cnt;
 	int echan_cnt;
 	int rchan_cnt;
@@ -131,16 +151,6 @@ struct udma_dev {
 	u32 psil_base;
 };
 
-struct udma_hwdesc {
-	size_t cppi5_desc_size;
-	void *cppi5_desc_vaddr;
-	dma_addr_t cppi5_desc_paddr;
-
-	/* TR descriptor internal pointers */
-	void *tr_req_base;
-	struct cppi5_tr_resp_t *tr_resp_base;
-};
-
 struct udma_desc {
 	struct virt_dma_desc vd;
 
@@ -552,12 +562,17 @@ static void udma_sync_for_device(struct udma_chan *uc, int idx)
 	}
 }
 
+static inline dma_addr_t udma_get_rx_flush_hwdesc_paddr(struct udma_chan *uc)
+{
+	return uc->ud->rx_flush.hwdescs[uc->config.pkt_mode].cppi5_desc_paddr;
+}
+
 static int udma_push_to_ring(struct udma_chan *uc, int idx)
 {
 	struct udma_desc *d = uc->desc;
-
 	struct k3_ring *ring = NULL;
-	int ret = -EINVAL;
+	dma_addr_t paddr;
+	int ret;
 
 	switch (uc->config.dir) {
 	case DMA_DEV_TO_MEM:
@@ -568,21 +583,37 @@ static int udma_push_to_ring(struct udma_chan *uc, int idx)
 		ring = uc->tchan->t_ring;
 		break;
 	default:
-		break;
+		return -EINVAL;
 	}
 
-	if (ring) {
-		dma_addr_t desc_addr = udma_curr_cppi5_desc_paddr(d, idx);
+	/* RX flush packet: idx == -1 is only passed in case of DEV_TO_MEM */
+	if (idx == -1) {
+		paddr = udma_get_rx_flush_hwdesc_paddr(uc);
+	} else {
+		paddr = udma_curr_cppi5_desc_paddr(d, idx);
 
 		wmb(); /* Ensure that writes are not moved over this point */
 		udma_sync_for_device(uc, idx);
-		ret = k3_ringacc_ring_push(ring, &desc_addr);
-		uc->in_ring_cnt++;
 	}
 
+	ret = k3_ringacc_ring_push(ring, &paddr);
+	if (!ret)
+		uc->in_ring_cnt++;
+
 	return ret;
 }
 
+static bool udma_desc_is_rx_flush(struct udma_chan *uc, dma_addr_t addr)
+{
+	if (uc->config.dir != DMA_DEV_TO_MEM)
+		return false;
+
+	if (addr == udma_get_rx_flush_hwdesc_paddr(uc))
+		return true;
+
+	return false;
+}
+
 static int udma_pop_from_ring(struct udma_chan *uc, dma_addr_t *addr)
 {
 	struct k3_ring *ring = NULL;
@@ -611,6 +642,10 @@ static int udma_pop_from_ring(struct udma_chan *uc, dma_addr_t *addr)
 		if (cppi5_desc_is_tdcm(*addr))
 			return ret;
 
+		/* Check for flush descriptor */
+		if (udma_desc_is_rx_flush(uc, *addr))
+			return -ENOENT;
+
 		d = udma_udma_desc_from_paddr(uc, *addr);
 
 		if (d)
@@ -891,6 +926,9 @@ static int udma_stop(struct udma_chan *uc)
 
 	switch (uc->config.dir) {
 	case DMA_DEV_TO_MEM:
+		if (!uc->cyclic && !uc->desc)
+			udma_push_to_ring(uc, -1);
+
 		udma_rchanrt_write(uc->rchan, UDMA_RCHAN_RT_PEER_RT_EN_REG,
 				   UDMA_PEER_RT_EN_ENABLE |
 				   UDMA_PEER_RT_EN_TEARDOWN);
@@ -3274,6 +3312,98 @@ static int udma_setup_resources(struct udma_dev *ud)
 	return ch_count;
 }
 
+static int udma_setup_rx_flush(struct udma_dev *ud)
+{
+	struct udma_rx_flush *rx_flush = &ud->rx_flush;
+	struct cppi5_desc_hdr_t *tr_desc;
+	struct cppi5_tr_type1_t *tr_req;
+	struct cppi5_host_desc_t *desc;
+	struct device *dev = ud->dev;
+	struct udma_hwdesc *hwdesc;
+	size_t tr_size;
+
+	/* Allocate 1K buffer for discarded data on RX channel teardown */
+	rx_flush->buffer_size = SZ_1K;
+	rx_flush->buffer_vaddr = devm_kzalloc(dev, rx_flush->buffer_size,
+					      GFP_KERNEL);
+	if (!rx_flush->buffer_vaddr)
+		return -ENOMEM;
+
+	rx_flush->buffer_paddr = dma_map_single(dev, rx_flush->buffer_vaddr,
+						rx_flush->buffer_size,
+						DMA_TO_DEVICE);
+	if (dma_mapping_error(dev, rx_flush->buffer_paddr))
+		return -ENOMEM;
+
+	/* Set up descriptor to be used for TR mode */
+	hwdesc = &rx_flush->hwdescs[0];
+	tr_size = sizeof(struct cppi5_tr_type1_t);
+	hwdesc->cppi5_desc_size = cppi5_trdesc_calc_size(tr_size, 1);
+	hwdesc->cppi5_desc_size = ALIGN(hwdesc->cppi5_desc_size,
+					ud->desc_align);
+
+	hwdesc->cppi5_desc_vaddr = devm_kzalloc(dev, hwdesc->cppi5_desc_size,
+						GFP_KERNEL);
+	if (!hwdesc->cppi5_desc_vaddr)
+		return -ENOMEM;
+
+	hwdesc->cppi5_desc_paddr = dma_map_single(dev, hwdesc->cppi5_desc_vaddr,
+						  hwdesc->cppi5_desc_size,
+						  DMA_TO_DEVICE);
+	if (dma_mapping_error(dev, hwdesc->cppi5_desc_paddr))
+		return -ENOMEM;
+
+	/* Start of the TR req records */
+	hwdesc->tr_req_base = hwdesc->cppi5_desc_vaddr + tr_size;
+	/* Start address of the TR response array */
+	hwdesc->tr_resp_base = hwdesc->tr_req_base + tr_size;
+
+	tr_desc = hwdesc->cppi5_desc_vaddr;
+	cppi5_trdesc_init(tr_desc, 1, tr_size, 0, 0);
+	cppi5_desc_set_pktids(tr_desc, 0, CPPI5_INFO1_DESC_FLOWID_DEFAULT);
+	cppi5_desc_set_retpolicy(tr_desc, 0, 0);
+
+	tr_req = hwdesc->tr_req_base;
+	cppi5_tr_init(&tr_req->flags, CPPI5_TR_TYPE1, false, false,
+		      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
+	cppi5_tr_csf_set(&tr_req->flags, CPPI5_TR_CSF_SUPR_EVT);
+
+	tr_req->addr = rx_flush->buffer_paddr;
+	tr_req->icnt0 = rx_flush->buffer_size;
+	tr_req->icnt1 = 1;
+
+	/* Set up descriptor to be used for packet mode */
+	hwdesc = &rx_flush->hwdescs[1];
+	hwdesc->cppi5_desc_size = ALIGN(sizeof(struct cppi5_host_desc_t) +
+					CPPI5_INFO0_HDESC_EPIB_SIZE +
+					CPPI5_INFO0_HDESC_PSDATA_MAX_SIZE,
+					ud->desc_align);
+
+	hwdesc->cppi5_desc_vaddr = devm_kzalloc(dev, hwdesc->cppi5_desc_size,
+						GFP_KERNEL);
+	if (!hwdesc->cppi5_desc_vaddr)
+		return -ENOMEM;
+
+	hwdesc->cppi5_desc_paddr = dma_map_single(dev, hwdesc->cppi5_desc_vaddr,
+						  hwdesc->cppi5_desc_size,
+						  DMA_TO_DEVICE);
+	if (dma_mapping_error(dev, hwdesc->cppi5_desc_paddr))
+		return -ENOMEM;
+
+	desc = hwdesc->cppi5_desc_vaddr;
+	cppi5_hdesc_init(desc, 0, 0);
+	cppi5_desc_set_pktids(&desc->hdr, 0, CPPI5_INFO1_DESC_FLOWID_DEFAULT);
+	cppi5_desc_set_retpolicy(&desc->hdr, 0, 0);
+
+	cppi5_hdesc_attach_buf(desc,
+			       rx_flush->buffer_paddr, rx_flush->buffer_size,
+			       rx_flush->buffer_paddr, rx_flush->buffer_size);
+
+	dma_sync_single_for_device(dev, hwdesc->cppi5_desc_paddr,
+				   hwdesc->cppi5_desc_size, DMA_TO_DEVICE);
+	return 0;
+}
+
 #define TI_UDMAC_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_3_BYTES) | \
@@ -3387,6 +3517,10 @@ static int udma_probe(struct platform_device *pdev)
 	if (ud->desc_align < dma_get_cache_alignment())
 		ud->desc_align = dma_get_cache_alignment();
 
+	ret = udma_setup_rx_flush(ud);
+	if (ret)
+		return ret;
+
 	for (i = 0; i < ud->tchan_cnt; i++) {
 		struct udma_tchan *tchan = &ud->tchans[i];
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

