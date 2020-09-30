Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719C627E4C5
	for <lists+dmaengine@lfdr.de>; Wed, 30 Sep 2020 11:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbgI3JPN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Sep 2020 05:15:13 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35288 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbgI3JPL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Sep 2020 05:15:11 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08U9EoRJ035171;
        Wed, 30 Sep 2020 04:14:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601457290;
        bh=lsEimC7eojBl1Mg3DwJv4372XumRMA4wh9uPpcjRSQA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Gw3UtgvNsWP+BfNHAUW3KcBUBBP6OJd4YrsuUinzxU5JVdzhpck+NRIoNrKdWMd+B
         ufvF9gAbp087dN12mDEp3WnR4hs7UDknd/WgVGfXSv7l6NbMOUYFaDRVbqv8i8Kip0
         Y0Fzxr9vtmaRdB04oC+Fl05IH+VDd/o9A+UzAbfo=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08U9EoDC050005
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 04:14:50 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 04:14:49 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 04:14:49 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08U9DuJo116385;
        Wed, 30 Sep 2020 04:14:47 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <robh+dt@kernel.org>, <vigneshr@ti.com>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <lokeshvutla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
Subject: [PATCH 17/18] dmaengine: ti: k3-udma: Initial support for K3 PKTDMA
Date:   Wed, 30 Sep 2020 12:14:11 +0300
Message-ID: <20200930091412.8020-18-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930091412.8020-1-peter.ujfalusi@ti.com>
References: <20200930091412.8020-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

One of the DMAs introduced with AM64 is the Packet DMA (PKTDMA).
It serves similar purpose as K3 UDMAP channels in packet mode, but with
notable differences, like tflow support and channels being allocated to
service specific peripherals.
The rings for the PKTDMA is integrated within the DMA itself instead of
using rings from the general purpose ringacc.

PKTDMA can be used to service PSI-L peripherals, similarly to
K3 UDMA channels.

Most of the driver code can be reused for PKTDMA tchan/rchan support but
new setup and allocation functions are needed to handle the differences
between the DMAs.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma-private.c |   9 +
 drivers/dma/ti/k3-udma.c         | 546 +++++++++++++++++++++++++++++--
 drivers/dma/ti/k3-udma.h         |   4 +
 3 files changed, 534 insertions(+), 25 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-private.c b/drivers/dma/ti/k3-udma-private.c
index 8ff7a264be03..f0cecd29cff1 100644
--- a/drivers/dma/ti/k3-udma-private.c
+++ b/drivers/dma/ti/k3-udma-private.c
@@ -82,6 +82,9 @@ EXPORT_SYMBOL(xudma_free_gp_rflow_range);
 
 bool xudma_rflow_is_gp(struct udma_dev *ud, int id)
 {
+	if (!ud->rflow_gp_map)
+		return false;
+
 	return !test_bit(id, ud->rflow_gp_map);
 }
 EXPORT_SYMBOL(xudma_rflow_is_gp);
@@ -113,6 +116,12 @@ void xudma_rflow_put(struct udma_dev *ud, struct udma_rflow *p)
 }
 EXPORT_SYMBOL(xudma_rflow_put);
 
+int xudma_get_rflow_ring_offset(struct udma_dev *ud)
+{
+	return ud->tflow_cnt;
+}
+EXPORT_SYMBOL(xudma_get_rflow_ring_offset);
+
 #define XUDMA_GET_RESOURCE_ID(res)					\
 int xudma_##res##_get_id(struct udma_##res *p)				\
 {									\
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 69f2c43354d4..bcec3d5c7be1 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -59,6 +59,7 @@ struct udma_chan;
 enum k3_dma_type {
 	DMA_TYPE_UDMA = 0,
 	DMA_TYPE_BCDMA,
+	DMA_TYPE_PKTDMA,
 };
 
 enum udma_mmr {
@@ -82,6 +83,8 @@ struct udma_tchan {
 	int id;
 	struct k3_ring *t_ring; /* Transmit ring */
 	struct k3_ring *tc_ring; /* Transmit Completion ring */
+	int tflow_id; /* applicable only for PKTDMA */
+
 };
 
 #define udma_bchan udma_tchan
@@ -109,6 +112,10 @@ struct udma_oes_offsets {
 	u32 bcdma_tchan_ring;
 	u32 bcdma_rchan_data;
 	u32 bcdma_rchan_ring;
+
+	/* PKTDMA Output Event Offsets */
+	u32 pktdma_tchan_flow;
+	u32 pktdma_rchan_flow;
 };
 
 #define UDMA_FLAG_PDMA_ACC32		BIT(0)
@@ -179,12 +186,14 @@ struct udma_dev {
 	int echan_cnt;
 	int rchan_cnt;
 	int rflow_cnt;
+	int tflow_cnt;
 	unsigned long *bchan_map;
 	unsigned long *tchan_map;
 	unsigned long *rchan_map;
 	unsigned long *rflow_gp_map;
 	unsigned long *rflow_gp_map_allocated;
 	unsigned long *rflow_in_use;
+	unsigned long *tflow_map;
 
 	struct udma_bchan *bchans;
 	struct udma_tchan *tchans;
@@ -249,6 +258,11 @@ struct udma_chan_config {
 
 	u32 tr_trigger_type;
 
+	/* PKDMA mapped channel */
+	int mapped_channel_id;
+	/* PKTDMA default tflow or rflow for mapped channel */
+	int default_flow_id;
+
 	enum dma_transfer_direction dir;
 };
 
@@ -426,6 +440,8 @@ static void udma_reset_uchan(struct udma_chan *uc)
 {
 	memset(&uc->config, 0, sizeof(uc->config));
 	uc->config.remote_thread_id = -1;
+	uc->config.mapped_channel_id = -1;
+	uc->config.default_flow_id = -1;
 	uc->state = UDMA_CHAN_IS_IDLE;
 }
 
@@ -815,10 +831,16 @@ static void udma_start_desc(struct udma_chan *uc)
 {
 	struct udma_chan_config *ucc = &uc->config;
 
-	if (ucc->pkt_mode && (uc->cyclic || ucc->dir == DMA_DEV_TO_MEM)) {
+	if (uc->ud->match_data->type == DMA_TYPE_UDMA && ucc->pkt_mode &&
+	    (uc->cyclic || ucc->dir == DMA_DEV_TO_MEM)) {
 		int i;
 
-		/* Push all descriptors to ring for packet mode cyclic or RX */
+		/*
+		 * UDMA only: Push all descriptors to ring for packet mode
+		 * cyclic or RX
+		 * PKTDMA supports pre-linked descriptor and cyclic is not
+		 * supported
+		 */
 		for (i = 0; i < uc->desc->sglen; i++)
 			udma_push_to_ring(uc, i);
 	} else {
@@ -1250,10 +1272,12 @@ static struct udma_rflow *__udma_get_rflow(struct udma_dev *ud, int id)
 	if (test_bit(id, ud->rflow_in_use))
 		return ERR_PTR(-ENOENT);
 
-	/* GP rflow has to be allocated first */
-	if (!test_bit(id, ud->rflow_gp_map) &&
-	    !test_bit(id, ud->rflow_gp_map_allocated))
-		return ERR_PTR(-EINVAL);
+	if (ud->rflow_gp_map) {
+		/* GP rflow has to be allocated first */
+		if (!test_bit(id, ud->rflow_gp_map) &&
+		    !test_bit(id, ud->rflow_gp_map_allocated))
+			return ERR_PTR(-EINVAL);
+	}
 
 	dev_dbg(ud->dev, "get rflow%d\n", id);
 	set_bit(id, ud->rflow_in_use);
@@ -1343,9 +1367,39 @@ static int udma_get_tchan(struct udma_chan *uc)
 		return 0;
 	}
 
-	uc->tchan = __udma_reserve_tchan(ud, uc->config.channel_tpl, -1);
+	/*
+	 * mapped_channel_id is -1 for UDMA, BCDMA and PKTDMA unmapped channels.
+	 * For PKTDMA mapped channels it is configured to a channel which must
+	 * be used to service the peripheral.
+	 */
+	uc->tchan = __udma_reserve_tchan(ud, uc->config.channel_tpl,
+					 uc->config.mapped_channel_id);
+	if (IS_ERR(uc->tchan))
+		return PTR_ERR(uc->tchan);
+
+	if (ud->tflow_cnt) {
+		int tflow_id;
+
+		/* Only PKTDMA have support for tx flows */
+		if (uc->config.default_flow_id >= 0)
+			tflow_id = uc->config.default_flow_id;
+		else
+			tflow_id = uc->tchan->id;
+
+		if (test_bit(tflow_id, ud->tflow_map)) {
+			dev_err(ud->dev, "tflow%d is in use\n", tflow_id);
+			clear_bit(uc->tchan->id, ud->tchan_map);
+			uc->tchan = NULL;
+			return -ENOENT;
+		}
+
+		uc->tchan->tflow_id = tflow_id;
+		set_bit(tflow_id, ud->tflow_map);
+	} else {
+		uc->tchan->tflow_id = -1;
+	}
 
-	return PTR_ERR_OR_ZERO(uc->tchan);
+	return 0;
 }
 
 static int udma_get_rchan(struct udma_chan *uc)
@@ -1358,7 +1412,13 @@ static int udma_get_rchan(struct udma_chan *uc)
 		return 0;
 	}
 
-	uc->rchan = __udma_reserve_rchan(ud, uc->config.channel_tpl, -1);
+	/*
+	 * mapped_channel_id is -1 for UDMA, BCDMA and PKTDMA unmapped channels.
+	 * For PKTDMA mapped channels it is configured to a channel which must
+	 * be used to service the peripheral.
+	 */
+	uc->rchan = __udma_reserve_rchan(ud, uc->config.channel_tpl,
+					 uc->config.mapped_channel_id);
 
 	return PTR_ERR_OR_ZERO(uc->rchan);
 }
@@ -1405,6 +1465,9 @@ static int udma_get_chan_pair(struct udma_chan *uc)
 	uc->tchan = &ud->tchans[chan_id];
 	uc->rchan = &ud->rchans[chan_id];
 
+	/* UDMA does not use tx flows */
+	uc->tchan->tflow_id = -1;
+
 	return 0;
 }
 
@@ -1461,6 +1524,10 @@ static void udma_put_tchan(struct udma_chan *uc)
 		dev_dbg(ud->dev, "chan%d: put tchan%d\n", uc->id,
 			uc->tchan->id);
 		clear_bit(uc->tchan->id, ud->tchan_map);
+
+		if (uc->tchan->tflow_id >= 0)
+			clear_bit(uc->tchan->tflow_id, ud->tflow_map);
+
 		uc->tchan = NULL;
 	}
 }
@@ -1561,7 +1628,10 @@ static int udma_alloc_tx_resources(struct udma_chan *uc)
 		return ret;
 
 	tchan = uc->tchan;
-	ring_idx = ud->bchan_cnt + tchan->id;
+	if (tchan->tflow_id >= 0)
+		ring_idx = tchan->tflow_id;
+	else
+		ring_idx = ud->bchan_cnt + tchan->id;
 
 	ret = k3_ringacc_request_rings_pair(ud->ringacc, ring_idx, -1,
 					    &tchan->t_ring,
@@ -1638,15 +1708,23 @@ static int udma_alloc_rx_resources(struct udma_chan *uc)
 	if (uc->config.dir == DMA_MEM_TO_MEM)
 		return 0;
 
-	ret = udma_get_rflow(uc, uc->rchan->id);
+	if (uc->config.default_flow_id >= 0)
+		ret = udma_get_rflow(uc, uc->config.default_flow_id);
+	else
+		ret = udma_get_rflow(uc, uc->rchan->id);
+
 	if (ret) {
 		ret = -EBUSY;
 		goto err_rflow;
 	}
 
 	rflow = uc->rflow;
-	fd_ring_id = ud->bchan_cnt + ud->tchan_cnt + ud->echan_cnt +
-		     uc->rchan->id;
+	if (ud->tflow_cnt)
+		fd_ring_id = ud->tflow_cnt + rflow->id;
+	else
+		fd_ring_id = ud->bchan_cnt + ud->tchan_cnt + ud->echan_cnt +
+			     uc->rchan->id;
+
 	ret = k3_ringacc_request_rings_pair(ud->ringacc, fd_ring_id, -1,
 					    &rflow->fd_ring, &rflow->r_ring);
 	if (ret) {
@@ -1862,6 +1940,8 @@ static int bcdma_tisci_tx_channel_config(struct udma_chan *uc)
 	return ret;
 }
 
+#define pktdma_tisci_tx_channel_config bcdma_tisci_tx_channel_config
+
 static int udma_tisci_rx_channel_config(struct udma_chan *uc)
 {
 	struct udma_dev *ud = uc->ud;
@@ -1963,6 +2043,52 @@ static int bcdma_tisci_rx_channel_config(struct udma_chan *uc)
 	return ret;
 }
 
+static int pktdma_tisci_rx_channel_config(struct udma_chan *uc)
+{
+	struct udma_dev *ud = uc->ud;
+	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
+	const struct ti_sci_rm_udmap_ops *tisci_ops = tisci_rm->tisci_udmap_ops;
+	struct ti_sci_msg_rm_udmap_rx_ch_cfg req_rx = { 0 };
+	struct ti_sci_msg_rm_udmap_flow_cfg flow_req = { 0 };
+	int ret = 0;
+
+	req_rx.valid_params = TISCI_BCDMA_RCHAN_VALID_PARAMS;
+	req_rx.nav_id = tisci_rm->tisci_dev_id;
+	req_rx.index = uc->rchan->id;
+
+	ret = tisci_ops->rx_ch_cfg(tisci_rm->tisci, &req_rx);
+	if (ret) {
+		dev_err(ud->dev, "rchan%d cfg failed %d\n", uc->rchan->id, ret);
+		return ret;
+	}
+
+	flow_req.valid_params =
+		TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_EINFO_PRESENT_VALID |
+		TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_PSINFO_PRESENT_VALID |
+		TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_ERROR_HANDLING_VALID;
+
+	flow_req.nav_id = tisci_rm->tisci_dev_id;
+	flow_req.flow_index = uc->rflow->id;
+
+	if (uc->config.needs_epib)
+		flow_req.rx_einfo_present = 1;
+	else
+		flow_req.rx_einfo_present = 0;
+	if (uc->config.psd_size)
+		flow_req.rx_psinfo_present = 1;
+	else
+		flow_req.rx_psinfo_present = 0;
+	flow_req.rx_error_handling = 1;
+
+	ret = tisci_ops->rx_flow_cfg(tisci_rm->tisci, &flow_req);
+
+	if (ret)
+		dev_err(ud->dev, "flow%d config failed: %d\n", uc->rflow->id,
+			ret);
+
+	return ret;
+}
+
 static int udma_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct udma_chan *uc = to_udma_chan(chan);
@@ -2381,6 +2507,157 @@ static int bcdma_router_config(struct dma_chan *chan)
 	return router_data->set_event(router_data->priv, trigger_event);
 }
 
+static int pktdma_alloc_chan_resources(struct dma_chan *chan)
+{
+	struct udma_chan *uc = to_udma_chan(chan);
+	struct udma_dev *ud = to_udma_dev(chan->device);
+	const struct udma_oes_offsets *oes = &ud->soc_data->oes;
+	u32 irq_ring_idx;
+	int ret;
+
+	/*
+	 * Make sure that the completion is in a known state:
+	 * No teardown, the channel is idle
+	 */
+	reinit_completion(&uc->teardown_completed);
+	complete_all(&uc->teardown_completed);
+	uc->state = UDMA_CHAN_IS_IDLE;
+
+	switch (uc->config.dir) {
+	case DMA_MEM_TO_DEV:
+		/* Slave transfer synchronized - mem to dev (TX) trasnfer */
+		dev_dbg(uc->ud->dev, "%s: chan%d as MEM-to-DEV\n", __func__,
+			uc->id);
+
+		ret = udma_alloc_tx_resources(uc);
+		if (ret) {
+			uc->config.remote_thread_id = -1;
+			return ret;
+		}
+
+		uc->config.src_thread = ud->psil_base + uc->tchan->id;
+		uc->config.dst_thread = uc->config.remote_thread_id;
+		uc->config.dst_thread |= K3_PSIL_DST_THREAD_ID_OFFSET;
+
+		irq_ring_idx = uc->tchan->tflow_id + oes->pktdma_tchan_flow;
+
+		ret = pktdma_tisci_tx_channel_config(uc);
+		break;
+	case DMA_DEV_TO_MEM:
+		/* Slave transfer synchronized - dev to mem (RX) trasnfer */
+		dev_dbg(uc->ud->dev, "%s: chan%d as DEV-to-MEM\n", __func__,
+			uc->id);
+
+		ret = udma_alloc_rx_resources(uc);
+		if (ret) {
+			uc->config.remote_thread_id = -1;
+			return ret;
+		}
+
+		uc->config.src_thread = uc->config.remote_thread_id;
+		uc->config.dst_thread = (ud->psil_base + uc->rchan->id) |
+					K3_PSIL_DST_THREAD_ID_OFFSET;
+
+		irq_ring_idx = uc->rflow->id + oes->pktdma_rchan_flow;
+
+		ret = pktdma_tisci_rx_channel_config(uc);
+		break;
+	default:
+		/* Can not happen */
+		dev_err(uc->ud->dev, "%s: chan%d invalid direction (%u)\n",
+			__func__, uc->id, uc->config.dir);
+		return -EINVAL;
+	}
+
+	/* check if the channel configuration was successful */
+	if (ret)
+		goto err_res_free;
+
+	if (udma_is_chan_running(uc)) {
+		dev_warn(ud->dev, "chan%d: is running!\n", uc->id);
+		udma_reset_chan(uc, false);
+		if (udma_is_chan_running(uc)) {
+			dev_err(ud->dev, "chan%d: won't stop!\n", uc->id);
+			ret = -EBUSY;
+			goto err_res_free;
+		}
+	}
+
+	uc->dma_dev = dmaengine_get_dma_device(chan);
+	uc->hdesc_pool = dma_pool_create(uc->name, uc->dma_dev,
+					 uc->config.hdesc_size, ud->desc_align,
+					 0);
+	if (!uc->hdesc_pool) {
+		dev_err(ud->ddev.dev,
+			"Descriptor pool allocation failed\n");
+		uc->use_dma_pool = false;
+		ret = -ENOMEM;
+		goto err_res_free;
+	}
+
+	uc->use_dma_pool = true;
+
+	/* PSI-L pairing */
+	ret = navss_psil_pair(ud, uc->config.src_thread, uc->config.dst_thread);
+	if (ret) {
+		dev_err(ud->dev, "PSI-L pairing failed: 0x%04x -> 0x%04x\n",
+			uc->config.src_thread, uc->config.dst_thread);
+		goto err_res_free;
+	}
+
+	uc->psil_paired = true;
+
+	uc->irq_num_ring = ti_sci_inta_msi_get_virq(ud->dev, irq_ring_idx);
+	if (uc->irq_num_ring <= 0) {
+		dev_err(ud->dev, "Failed to get ring irq (index: %u)\n",
+			irq_ring_idx);
+		ret = -EINVAL;
+		goto err_psi_free;
+	}
+
+	ret = request_irq(uc->irq_num_ring, udma_ring_irq_handler,
+			  IRQF_TRIGGER_HIGH, uc->name, uc);
+	if (ret) {
+		dev_err(ud->dev, "chan%d: ring irq request failed\n", uc->id);
+		goto err_irq_free;
+	}
+
+	uc->irq_num_udma = 0;
+
+	udma_reset_rings(uc);
+
+	INIT_DELAYED_WORK_ONSTACK(&uc->tx_drain.work,
+				  udma_check_tx_completion);
+
+	if (uc->tchan)
+		dev_dbg(ud->dev,
+			"chan%d: tchan%d, tflow%d, Remote thread: 0x%04x\n",
+			uc->id, uc->tchan->id, uc->tchan->tflow_id,
+			uc->config.remote_thread_id);
+	else if (uc->rchan)
+		dev_dbg(ud->dev,
+			"chan%d: rchan%d, rflow%d, Remote thread: 0x%04x\n",
+			uc->id, uc->rchan->id, uc->rflow->id,
+			uc->config.remote_thread_id);
+	return 0;
+
+err_irq_free:
+	uc->irq_num_ring = 0;
+err_psi_free:
+	navss_psil_unpair(ud, uc->config.src_thread, uc->config.dst_thread);
+	uc->psil_paired = false;
+err_res_free:
+	udma_free_tx_resources(uc);
+	udma_free_rx_resources(uc);
+
+	udma_reset_uchan(uc);
+
+	dma_pool_destroy(uc->hdesc_pool);
+	uc->use_dma_pool = false;
+
+	return ret;
+}
+
 static int udma_slave_config(struct dma_chan *chan,
 			     struct dma_slave_config *cfg)
 {
@@ -2859,6 +3136,7 @@ udma_prep_slave_sg_pkt(struct udma_chan *uc, struct scatterlist *sgl,
 	struct udma_desc *d;
 	u32 ring_id;
 	unsigned int i;
+	u64 asel;
 
 	d = kzalloc(struct_size(d, hwdesc, sglen), GFP_NOWAIT);
 	if (!d)
@@ -2872,6 +3150,11 @@ udma_prep_slave_sg_pkt(struct udma_chan *uc, struct scatterlist *sgl,
 	else
 		ring_id = k3_ringacc_get_ring_id(uc->tchan->tc_ring);
 
+	if (uc->ud->match_data->type == DMA_TYPE_UDMA)
+		asel = 0;
+	else
+		asel = (u64)uc->config.asel << K3_ADDRESS_ASEL_SHIFT;
+
 	for_each_sg(sgl, sgent, sglen, i) {
 		struct udma_hwdesc *hwdesc = &d->hwdesc[i];
 		dma_addr_t sg_addr = sg_dma_address(sgent);
@@ -2906,14 +3189,16 @@ udma_prep_slave_sg_pkt(struct udma_chan *uc, struct scatterlist *sgl,
 		}
 
 		/* attach the sg buffer to the descriptor */
+		sg_addr |= asel;
 		cppi5_hdesc_attach_buf(desc, sg_addr, sg_len, sg_addr, sg_len);
 
 		/* Attach link as host buffer descriptor */
 		if (h_desc)
 			cppi5_hdesc_link_hbdesc(h_desc,
-						hwdesc->cppi5_desc_paddr);
+						hwdesc->cppi5_desc_paddr | asel);
 
-		if (dir == DMA_MEM_TO_DEV)
+		if (uc->ud->match_data->type == DMA_TYPE_PKTDMA ||
+		    dir == DMA_MEM_TO_DEV)
 			h_desc = desc;
 	}
 
@@ -3192,6 +3477,9 @@ udma_prep_dma_cyclic_pkt(struct udma_chan *uc, dma_addr_t buf_addr,
 	else
 		ring_id = k3_ringacc_get_ring_id(uc->tchan->tc_ring);
 
+	if (uc->ud->match_data->type != DMA_TYPE_UDMA)
+		buf_addr |= (u64)uc->config.asel << K3_ADDRESS_ASEL_SHIFT;
+
 	for (i = 0; i < periods; i++) {
 		struct udma_hwdesc *hwdesc = &d->hwdesc[i];
 		dma_addr_t period_addr = buf_addr + (period_len * i);
@@ -3708,6 +3996,7 @@ static void udma_free_chan_resources(struct dma_chan *chan)
 
 static struct platform_driver udma_driver;
 static struct platform_driver bcdma_driver;
+static struct platform_driver pktdma_driver;
 
 struct udma_filter_param {
 	int remote_thread_id;
@@ -3725,7 +4014,8 @@ static bool udma_dma_filter_fn(struct dma_chan *chan, void *param)
 	struct udma_dev *ud;
 
 	if (chan->device->dev->driver != &udma_driver.driver &&
-	    chan->device->dev->driver != &bcdma_driver.driver)
+	    chan->device->dev->driver != &bcdma_driver.driver &&
+	    chan->device->dev->driver != &pktdma_driver.driver)
 		return false;
 
 	uc = to_udma_chan(chan);
@@ -3787,6 +4077,15 @@ static bool udma_dma_filter_fn(struct dma_chan *chan, void *param)
 	ucc->notdpkt = ep_config->notdpkt;
 	ucc->ep_type = ep_config->ep_type;
 
+	if (ud->match_data->type == DMA_TYPE_PKTDMA &&
+	    ep_config->mapped_channel_id >= 0) {
+		ucc->mapped_channel_id = ep_config->mapped_channel_id;
+		ucc->default_flow_id = ep_config->default_flow_id;
+	} else {
+		ucc->mapped_channel_id = -1;
+		ucc->default_flow_id = -1;
+	}
+
 	if (ucc->ep_type != PSIL_EP_NATIVE) {
 		const struct udma_match_data *match_data = ud->match_data;
 
@@ -3903,6 +4202,14 @@ static struct udma_match_data am64_bcdma_data = {
 	.statictr_z_mask = GENMASK(23, 0),
 };
 
+static struct udma_match_data am64_pktdma_data = {
+	.type = DMA_TYPE_PKTDMA,
+	.psil_base = 0x1000,
+	.enable_memcpy_support = false, /* PKTDMA does not support MEM_TO_MEM */
+	.flags = UDMA_FLAG_PDMA_ACC32 | UDMA_FLAG_PDMA_BURST | UDMA_FLAG_TDTYPE,
+	.statictr_z_mask = GENMASK(23, 0),
+};
+
 static const struct of_device_id udma_of_match[] = {
 	{
 		.compatible = "ti,am654-navss-main-udmap",
@@ -3929,6 +4236,14 @@ static const struct of_device_id bcdma_of_match[] = {
 	{ /* Sentinel */ },
 };
 
+static const struct of_device_id pktdma_of_match[] = {
+	{
+		.compatible = "ti,am64-dmss-pktdma",
+		.data = &am64_pktdma_data,
+	},
+	{ /* Sentinel */ },
+};
+
 static struct udma_soc_data am654_soc_data = {
 	.oes = {
 		.udma_rchan = 0x200,
@@ -3955,6 +4270,8 @@ static struct udma_soc_data am64_soc_data = {
 		.bcdma_tchan_ring = 0x2a00,
 		.bcdma_rchan_data = 0x2e00,
 		.bcdma_rchan_ring = 0x3000,
+		.pktdma_tchan_flow = 0x1200,
+		.pktdma_rchan_flow = 0x1600,
 	},
 	.bcdma_trigger_event_offset = 0xc400,
 };
@@ -3970,7 +4287,7 @@ static const struct soc_device_attribute k3_soc_devices[] = {
 static int udma_get_mmrs(struct platform_device *pdev, struct udma_dev *ud)
 {
 	struct resource *res;
-	u32 cap2, cap3;
+	u32 cap2, cap3, cap4;
 	int i;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
@@ -3994,6 +4311,13 @@ static int udma_get_mmrs(struct platform_device *pdev, struct udma_dev *ud)
 		ud->tchan_cnt = BCDMA_CAP2_TCHAN_CNT(cap2);
 		ud->rchan_cnt = BCDMA_CAP2_RCHAN_CNT(cap2);
 		break;
+	case DMA_TYPE_PKTDMA:
+		cap4 = udma_read(ud->mmrs[MMR_GCFG], 0x30);
+		ud->tchan_cnt = UDMA_CAP2_TCHAN_CNT(cap2);
+		ud->rchan_cnt = UDMA_CAP2_RCHAN_CNT(cap2);
+		ud->rflow_cnt = UDMA_CAP3_RFLOW_CNT(cap3);
+		ud->tflow_cnt = PKTDMA_CAP4_TFLOW_CNT(cap4);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -4031,7 +4355,8 @@ static const char * const range_names[] = {
 	[RM_RANGE_BCHAN] = "ti,sci-rm-range-bchan",
 	[RM_RANGE_TCHAN] = "ti,sci-rm-range-tchan",
 	[RM_RANGE_RCHAN] = "ti,sci-rm-range-rchan",
-	[RM_RANGE_RFLOW] = "ti,sci-rm-range-rflow"
+	[RM_RANGE_RFLOW] = "ti,sci-rm-range-rflow",
+	[RM_RANGE_TFLOW] = "ti,sci-rm-range-tflow",
 };
 
 static int udma_setup_resources(struct udma_dev *ud)
@@ -4106,7 +4431,7 @@ static int udma_setup_resources(struct udma_dev *ud)
 
 	/* Get resource ranges from tisci */
 	for (i = 0; i < RM_RANGE_LAST; i++) {
-		if (i == RM_RANGE_BCHAN)
+		if (i == RM_RANGE_BCHAN || i == RM_RANGE_TFLOW)
 			continue;
 
 		tisci_rm->rm_ranges[i] =
@@ -4256,7 +4581,7 @@ static int bcdma_setup_resources(struct udma_dev *ud)
 
 	/* Get resource ranges from tisci */
 	for (i = 0; i < RM_RANGE_LAST; i++) {
-		if (i == RM_RANGE_RFLOW)
+		if (i == RM_RANGE_RFLOW || i == RM_RANGE_TFLOW)
 			continue;
 		if (i == RM_RANGE_BCHAN && ud->bchan_cnt == 0)
 			continue;
@@ -4362,6 +4687,135 @@ static int bcdma_setup_resources(struct udma_dev *ud)
 	return 0;
 }
 
+static int pktdma_setup_resources(struct udma_dev *ud)
+{
+	int ret, i, j;
+	struct device *dev = ud->dev;
+	struct ti_sci_resource *rm_res, irq_res;
+	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
+	const struct udma_oes_offsets *oes = &ud->soc_data->oes;
+	u32 cap3;
+
+	/* Set up the throughput level start indexes */
+	cap3 = udma_read(ud->mmrs[MMR_GCFG], 0x2c);
+	if (UDMA_CAP3_UCHAN_CNT(cap3)) {
+		ud->tchan_tpl.levels = 3;
+		ud->tchan_tpl.start_idx[1] = UDMA_CAP3_UCHAN_CNT(cap3);
+		ud->tchan_tpl.start_idx[0] = ud->tchan_tpl.start_idx[1] +
+					       UDMA_CAP3_HCHAN_CNT(cap3);
+	} else if (UDMA_CAP3_HCHAN_CNT(cap3)) {
+		ud->tchan_tpl.levels = 2;
+		ud->tchan_tpl.start_idx[0] = UDMA_CAP3_HCHAN_CNT(cap3);
+	} else {
+		ud->tchan_tpl.levels = 1;
+	}
+
+	ud->tchan_tpl.levels = ud->tchan_tpl.levels;
+	ud->tchan_tpl.start_idx[0] = ud->tchan_tpl.start_idx[0];
+	ud->tchan_tpl.start_idx[1] = ud->tchan_tpl.start_idx[1];
+
+	ud->tchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->tchan_cnt),
+					   sizeof(unsigned long), GFP_KERNEL);
+	ud->tchans = devm_kcalloc(dev, ud->tchan_cnt, sizeof(*ud->tchans),
+				  GFP_KERNEL);
+	ud->rchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->rchan_cnt),
+					   sizeof(unsigned long), GFP_KERNEL);
+	ud->rchans = devm_kcalloc(dev, ud->rchan_cnt, sizeof(*ud->rchans),
+				  GFP_KERNEL);
+	ud->rflow_in_use = devm_kcalloc(dev, BITS_TO_LONGS(ud->rflow_cnt),
+					sizeof(unsigned long),
+					GFP_KERNEL);
+	ud->rflows = devm_kcalloc(dev, ud->rflow_cnt, sizeof(*ud->rflows),
+				  GFP_KERNEL);
+	ud->tflow_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->tflow_cnt),
+					   sizeof(unsigned long), GFP_KERNEL);
+
+	if (!ud->tchan_map || !ud->rchan_map || !ud->tflow_map || !ud->tchans ||
+	    !ud->rchans || !ud->rflows || !ud->rflow_in_use)
+		return -ENOMEM;
+
+	/* Get resource ranges from tisci */
+	for (i = 0; i < RM_RANGE_LAST; i++) {
+		if (i == RM_RANGE_BCHAN)
+			continue;
+
+		tisci_rm->rm_ranges[i] =
+			devm_ti_sci_get_of_resource(tisci_rm->tisci, dev,
+						    tisci_rm->tisci_dev_id,
+						    (char *)range_names[i]);
+	}
+
+	/* tchan ranges */
+	rm_res = tisci_rm->rm_ranges[RM_RANGE_TCHAN];
+	if (IS_ERR(rm_res)) {
+		bitmap_zero(ud->tchan_map, ud->tchan_cnt);
+	} else {
+		bitmap_fill(ud->tchan_map, ud->tchan_cnt);
+		for (i = 0; i < rm_res->sets; i++)
+			udma_mark_resource_ranges(ud, ud->tchan_map,
+						  &rm_res->desc[i], "tchan");
+	}
+
+	/* rchan ranges */
+	rm_res = tisci_rm->rm_ranges[RM_RANGE_RCHAN];
+	if (IS_ERR(rm_res)) {
+		bitmap_zero(ud->rchan_map, ud->rchan_cnt);
+	} else {
+		bitmap_fill(ud->rchan_map, ud->rchan_cnt);
+		for (i = 0; i < rm_res->sets; i++)
+			udma_mark_resource_ranges(ud, ud->rchan_map,
+						  &rm_res->desc[i], "rchan");
+	}
+
+	/* rflow ranges */
+	rm_res = tisci_rm->rm_ranges[RM_RANGE_RFLOW];
+	if (IS_ERR(rm_res)) {
+		/* all rflows are assigned exclusively to Linux */
+		bitmap_zero(ud->rflow_in_use, ud->rflow_cnt);
+	} else {
+		bitmap_fill(ud->rflow_in_use, ud->rflow_cnt);
+		for (i = 0; i < rm_res->sets; i++)
+			udma_mark_resource_ranges(ud, ud->rflow_in_use,
+						  &rm_res->desc[i], "rflow");
+	}
+	irq_res.sets = rm_res->sets;
+
+	/* tflow ranges */
+	rm_res = tisci_rm->rm_ranges[RM_RANGE_TFLOW];
+	if (IS_ERR(rm_res)) {
+		/* all tflows are assigned exclusively to Linux */
+		bitmap_zero(ud->tflow_map, ud->tflow_cnt);
+	} else {
+		bitmap_fill(ud->tflow_map, ud->tflow_cnt);
+		for (i = 0; i < rm_res->sets; i++)
+			udma_mark_resource_ranges(ud, ud->tflow_map,
+						  &rm_res->desc[i], "tflow");
+	}
+	irq_res.sets += rm_res->sets;
+
+	irq_res.desc = kcalloc(irq_res.sets, sizeof(*irq_res.desc), GFP_KERNEL);
+	rm_res = tisci_rm->rm_ranges[RM_RANGE_TFLOW];
+	for (i = 0; i < rm_res->sets; i++) {
+		irq_res.desc[i].start = rm_res->desc[i].start +
+					oes->pktdma_tchan_flow;
+		irq_res.desc[i].num = rm_res->desc[i].num;
+	}
+	rm_res = tisci_rm->rm_ranges[RM_RANGE_RFLOW];
+	for (j = 0; j < rm_res->sets; j++, i++) {
+		irq_res.desc[i].start = rm_res->desc[j].start +
+					oes->pktdma_rchan_flow;
+		irq_res.desc[i].num = rm_res->desc[j].num;
+	}
+	ret = ti_sci_inta_msi_domain_alloc_irqs(ud->dev, &irq_res);
+	kfree(irq_res.desc);
+	if (ret) {
+		dev_err(ud->dev, "Failed to allocate MSI interrupts\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static int setup_resources(struct udma_dev *ud)
 {
 	struct device *dev = ud->dev;
@@ -4374,6 +4828,9 @@ static int setup_resources(struct udma_dev *ud)
 	case DMA_TYPE_BCDMA:
 		ret = bcdma_setup_resources(ud);
 		break;
+	case DMA_TYPE_PKTDMA:
+		ret = pktdma_setup_resources(ud);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -4417,6 +4874,14 @@ static int setup_resources(struct udma_dev *ud)
 			 ud->rchan_cnt - bitmap_weight(ud->rchan_map,
 						       ud->rchan_cnt));
 		break;
+	case DMA_TYPE_PKTDMA:
+		dev_info(dev,
+			 "Channels: %d (tchan: %u, rchan: %u)\n",
+			 ch_count,
+			 ud->tchan_cnt - bitmap_weight(ud->tchan_map,
+						       ud->tchan_cnt),
+			 ud->rchan_cnt - bitmap_weight(ud->rchan_map,
+						       ud->rchan_cnt));
 	default:
 		break;
 	}
@@ -4547,10 +5012,14 @@ static void udma_dbg_summary_show_chan(struct seq_file *s,
 	case DMA_DEV_TO_MEM:
 		seq_printf(s, "rchan%d [0x%04x -> 0x%04x], ", uc->rchan->id,
 			   ucc->src_thread, ucc->dst_thread);
+		if (uc->ud->match_data->type == DMA_TYPE_PKTDMA)
+			seq_printf(s, "rflow%d, ", uc->rflow->id);
 		break;
 	case DMA_MEM_TO_DEV:
 		seq_printf(s, "tchan%d [0x%04x -> 0x%04x], ", uc->tchan->id,
 			   ucc->src_thread, ucc->dst_thread);
+		if (uc->ud->match_data->type == DMA_TYPE_PKTDMA)
+			seq_printf(s, "tflow%d, ", uc->tchan->tflow_id);
 		break;
 	default:
 		seq_printf(s, ")\n");
@@ -4613,8 +5082,10 @@ static int udma_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	match = of_match_node(udma_of_match, dev->of_node);
-	if (!match) {
+	if (!match)
 		match = of_match_node(bcdma_of_match, dev->of_node);
+	if (!match) {
+		match = of_match_node(pktdma_of_match, dev->of_node);
 		if (!match) {
 			dev_err(dev, "No compatible match found\n");
 			return -ENODEV;
@@ -4678,8 +5149,14 @@ static int udma_probe(struct platform_device *pdev)
 
 		ring_init_data.tisci = ud->tisci_rm.tisci;
 		ring_init_data.tisci_dev_id = ud->tisci_rm.tisci_dev_id;
-		ring_init_data.num_rings = ud->bchan_cnt + ud->tchan_cnt +
-					   ud->rchan_cnt;
+		if (ud->match_data->type == DMA_TYPE_BCDMA) {
+			ring_init_data.num_rings = ud->bchan_cnt +
+						   ud->tchan_cnt +
+						   ud->rchan_cnt;
+		} else {
+			ring_init_data.num_rings = ud->rflow_cnt +
+						   ud->tflow_cnt;
+		}
 
 		ud->ringacc = k3_ringacc_dmarings_init(pdev, &ring_init_data);
 	}
@@ -4695,11 +5172,14 @@ static int udma_probe(struct platform_device *pdev)
 	}
 
 	dma_cap_set(DMA_SLAVE, ud->ddev.cap_mask);
-	dma_cap_set(DMA_CYCLIC, ud->ddev.cap_mask);
+	/* cyclic operation is not supported via PKTDMA */
+	if (ud->match_data->type != DMA_TYPE_PKTDMA) {
+		dma_cap_set(DMA_CYCLIC, ud->ddev.cap_mask);
+		ud->ddev.device_prep_dma_cyclic = udma_prep_dma_cyclic;
+	}
 
 	ud->ddev.device_config = udma_slave_config;
 	ud->ddev.device_prep_slave_sg = udma_prep_slave_sg;
-	ud->ddev.device_prep_dma_cyclic = udma_prep_dma_cyclic;
 	ud->ddev.device_issue_pending = udma_issue_pending;
 	ud->ddev.device_tx_status = udma_tx_status;
 	ud->ddev.device_pause = udma_pause;
@@ -4720,6 +5200,10 @@ static int udma_probe(struct platform_device *pdev)
 					bcdma_alloc_chan_resources;
 		ud->ddev.device_router_config = bcdma_router_config;
 		break;
+	case DMA_TYPE_PKTDMA:
+		ud->ddev.device_alloc_chan_resources =
+					pktdma_alloc_chan_resources;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -4798,6 +5282,8 @@ static int udma_probe(struct platform_device *pdev)
 		uc->tchan = NULL;
 		uc->rchan = NULL;
 		uc->config.remote_thread_id = -1;
+		uc->config.mapped_channel_id = -1;
+		uc->config.default_flow_id = -1;
 		uc->config.dir = DMA_MEM_TO_MEM;
 		uc->name = devm_kasprintf(dev, GFP_KERNEL, "%s chan%d",
 					  dev_name(dev), i);
@@ -4847,5 +5333,15 @@ static struct platform_driver bcdma_driver = {
 };
 builtin_platform_driver(bcdma_driver);
 
+static struct platform_driver pktdma_driver = {
+	.driver = {
+		.name	= "ti-pktdma",
+		.of_match_table = pktdma_of_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe		= udma_probe,
+};
+builtin_platform_driver(pktdma_driver);
+
 /* Private interfaces to UDMA */
 #include "k3-udma-private.c"
diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
index 8cb32681afaf..078cc3aa4126 100644
--- a/drivers/dma/ti/k3-udma.h
+++ b/drivers/dma/ti/k3-udma.h
@@ -55,6 +55,8 @@
 #define BCDMA_CAP4_HTCHAN_CNT(val)	(((val) >> 16) & 0xff)
 #define BCDMA_CAP4_UTCHAN_CNT(val)	(((val) >> 24) & 0xff)
 
+#define PKTDMA_CAP4_TFLOW_CNT(val)	((val) & 0x3fff)
+
 /* UDMA_CHAN_RT_CTL_REG */
 #define UDMA_CHAN_RT_CTL_EN		BIT(31)
 #define UDMA_CHAN_RT_CTL_TDOWN		BIT(30)
@@ -105,6 +107,7 @@ enum udma_rm_range {
 	RM_RANGE_TCHAN,
 	RM_RANGE_RCHAN,
 	RM_RANGE_RFLOW,
+	RM_RANGE_TFLOW,
 	RM_RANGE_LAST,
 };
 
@@ -151,5 +154,6 @@ void xudma_tchanrt_write(struct udma_tchan *tchan, int reg, u32 val);
 u32 xudma_rchanrt_read(struct udma_rchan *rchan, int reg);
 void xudma_rchanrt_write(struct udma_rchan *rchan, int reg, u32 val);
 bool xudma_rflow_is_gp(struct udma_dev *ud, int id);
+int xudma_get_rflow_ring_offset(struct udma_dev *ud);
 
 #endif /* K3_UDMA_H_ */
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

