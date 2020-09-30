Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA19527E4B7
	for <lists+dmaengine@lfdr.de>; Wed, 30 Sep 2020 11:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgI3JPB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Sep 2020 05:15:01 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53166 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728673AbgI3JO6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Sep 2020 05:14:58 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08U9Ei97067445;
        Wed, 30 Sep 2020 04:14:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601457284;
        bh=SX2/H+r0fVDD4nVg6wc+mvkVZ3G2+nIGKs/M4uC+qzg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=nIz+XjXuzsV2MeXIS/misEyG9GpvlGgy/ZEQp/QE4/jEcpX1agqxWyWpyip6RInnM
         qU9+7AihFY1bMN6IfOSLlOcqmf+50IYcwm2cCNyAQebpJgAE40Ba/u0mnI2aoj/mtQ
         wZG1AZT/aX9ePBFB3xEHy4r/2vfiSXs14TBuoTUU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08U9EiW4100136
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 04:14:44 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 04:14:44 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 04:14:43 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08U9DuJm116385;
        Wed, 30 Sep 2020 04:14:41 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <robh+dt@kernel.org>, <vigneshr@ti.com>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <lokeshvutla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
Subject: [PATCH 15/18] dmaengine: ti: k3-udma: Initial support for K3 BCDMA
Date:   Wed, 30 Sep 2020 12:14:09 +0300
Message-ID: <20200930091412.8020-16-peter.ujfalusi@ti.com>
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

One of the DMAs introduced with AM64 is the Block Copy DMA (BCDMA).
It serves similar purpose as K3 UDMAP channels in TR mode.

The rings for the BCDMA is integrated within the DMA itself instead of
using rings from the general purpose ringacc.

A BCDMA have two different type of channels:
- Block Copy Channels (bchan)
- Split Channels (tchan and rchan)

tchan and rchan can be used to service PSI-L peripherals, similarly to
K3 UDMA channels.

bchan can be only used for block copy operation (TR type15) like the
paired K3 UDMA tchan/rchan configured in block copy mode.
bchans can be also used to service peripherals directly if an external
trigger is selected for the channel.

Most of the driver code can be reused for BCDMA bchan/tchan/rchan support
but new setup and allocation functions are needed to handle the
differences between the DMAs.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 1386 ++++++++++++++++++++++++++++++++++----
 drivers/dma/ti/k3-udma.h |   12 +-
 2 files changed, 1247 insertions(+), 151 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 1ae5d09e2059..a342e89a4bae 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -26,6 +26,7 @@
 #include <linux/soc/ti/k3-ringacc.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
 #include <linux/soc/ti/ti_sci_inta_msi.h>
+#include <linux/dma/k3-event-router.h>
 #include <linux/dma/ti-cppi5.h>
 
 #include "../virt-dma.h"
@@ -55,14 +56,25 @@ struct udma_static_tr {
 
 struct udma_chan;
 
+enum k3_dma_type {
+	DMA_TYPE_UDMA = 0,
+	DMA_TYPE_BCDMA,
+};
+
 enum udma_mmr {
 	MMR_GCFG = 0,
+	MMR_BCHANRT,
 	MMR_RCHANRT,
 	MMR_TCHANRT,
 	MMR_LAST,
 };
 
-static const char * const mmr_names[] = { "gcfg", "rchanrt", "tchanrt" };
+static const char * const mmr_names[] = {
+	[MMR_GCFG] = "gcfg",
+	[MMR_BCHANRT] = "bchanrt",
+	[MMR_RCHANRT] = "rchanrt",
+	[MMR_TCHANRT] = "tchanrt",
+};
 
 struct udma_tchan {
 	void __iomem *reg_rt;
@@ -72,6 +84,8 @@ struct udma_tchan {
 	struct k3_ring *tc_ring; /* Transmit Completion ring */
 };
 
+#define udma_bchan udma_tchan
+
 struct udma_rflow {
 	int id;
 	struct k3_ring *fd_ring; /* Free Descriptor ring */
@@ -84,11 +98,25 @@ struct udma_rchan {
 	int id;
 };
 
+struct udma_oes_offsets {
+	/* K3 UDMA Output Event Offset */
+	u32 udma_rchan;
+
+	/* BCDMA Output Event Offsets */
+	u32 bcdma_bchan_data;
+	u32 bcdma_bchan_ring;
+	u32 bcdma_tchan_data;
+	u32 bcdma_tchan_ring;
+	u32 bcdma_rchan_data;
+	u32 bcdma_rchan_ring;
+};
+
 #define UDMA_FLAG_PDMA_ACC32		BIT(0)
 #define UDMA_FLAG_PDMA_BURST		BIT(1)
 #define UDMA_FLAG_TDTYPE		BIT(2)
 
 struct udma_match_data {
+	enum k3_dma_type type;
 	u32 psil_base;
 	bool enable_memcpy_support;
 	u32 flags;
@@ -96,7 +124,8 @@ struct udma_match_data {
 };
 
 struct udma_soc_data {
-	u32 rchan_oes_offset;
+	struct udma_oes_offsets oes;
+	u32 bcdma_trigger_event_offset;
 };
 
 struct udma_hwdesc {
@@ -139,16 +168,19 @@ struct udma_dev {
 
 	struct udma_rx_flush rx_flush;
 
+	int bchan_cnt;
 	int tchan_cnt;
 	int echan_cnt;
 	int rchan_cnt;
 	int rflow_cnt;
+	unsigned long *bchan_map;
 	unsigned long *tchan_map;
 	unsigned long *rchan_map;
 	unsigned long *rflow_gp_map;
 	unsigned long *rflow_gp_map_allocated;
 	unsigned long *rflow_in_use;
 
+	struct udma_bchan *bchans;
 	struct udma_tchan *tchans;
 	struct udma_rchan *rchans;
 	struct udma_rflow *rflows;
@@ -156,6 +188,7 @@ struct udma_dev {
 	struct udma_chan *channels;
 	u32 psil_base;
 	u32 atype;
+	u32 asel;
 };
 
 struct udma_desc {
@@ -200,6 +233,7 @@ struct udma_chan_config {
 	bool notdpkt; /* Suppress sending TDC packet */
 	int remote_thread_id;
 	u32 atype;
+	u32 asel;
 	u32 src_thread;
 	u32 dst_thread;
 	enum psil_endpoint_type ep_type;
@@ -207,6 +241,8 @@ struct udma_chan_config {
 	bool enable_burst;
 	enum udma_tp_level channel_tpl; /* Channel Throughput Level */
 
+	u32 tr_trigger_type;
+
 	enum dma_transfer_direction dir;
 };
 
@@ -214,11 +250,13 @@ struct udma_chan {
 	struct virt_dma_chan vc;
 	struct dma_slave_config	cfg;
 	struct udma_dev *ud;
+	struct device *dma_dev;
 	struct udma_desc *desc;
 	struct udma_desc *terminated_desc;
 	struct udma_static_tr static_tr;
 	char *name;
 
+	struct udma_bchan *bchan;
 	struct udma_tchan *tchan;
 	struct udma_rchan *rchan;
 	struct udma_rflow *rflow;
@@ -354,6 +392,30 @@ static int navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
 						src_thread, dst_thread);
 }
 
+static void k3_configure_chan_coherency(struct dma_chan *chan, u32 asel)
+{
+	struct device *chan_dev = &chan->dev->device;
+
+	if (asel == 0) {
+		/* No special handling for the channel */
+		chan->dev->chan_dma_dev = false;
+
+		chan_dev->dma_coherent = false;
+		chan_dev->dma_parms = NULL;
+	} else if (asel == 14 || asel == 15) {
+		chan->dev->chan_dma_dev = true;
+
+		chan_dev->dma_coherent = true;
+		dma_coerce_mask_and_coherent(chan_dev, DMA_BIT_MASK(48));
+		chan_dev->dma_parms = chan_dev->parent->dma_parms;
+	} else {
+		dev_warn(chan->device->dev, "Invalid ASEL value: %u\n", asel);
+
+		chan_dev->dma_coherent = false;
+		chan_dev->dma_parms = NULL;
+	}
+}
+
 static void udma_reset_uchan(struct udma_chan *uc)
 {
 	memset(&uc->config, 0, sizeof(uc->config));
@@ -440,9 +502,7 @@ static void udma_free_hwdesc(struct udma_chan *uc, struct udma_desc *d)
 			d->hwdesc[i].cppi5_desc_vaddr = NULL;
 		}
 	} else if (d->hwdesc[0].cppi5_desc_vaddr) {
-		struct udma_dev *ud = uc->ud;
-
-		dma_free_coherent(ud->dev, d->hwdesc[0].cppi5_desc_size,
+		dma_free_coherent(uc->dma_dev, d->hwdesc[0].cppi5_desc_size,
 				  d->hwdesc[0].cppi5_desc_vaddr,
 				  d->hwdesc[0].cppi5_desc_paddr);
 
@@ -671,8 +731,10 @@ static void udma_reset_counters(struct udma_chan *uc)
 		val = udma_tchanrt_read(uc, UDMA_CHAN_RT_PCNT_REG);
 		udma_tchanrt_write(uc, UDMA_CHAN_RT_PCNT_REG, val);
 
-		val = udma_tchanrt_read(uc, UDMA_CHAN_RT_PEER_BCNT_REG);
-		udma_tchanrt_write(uc, UDMA_CHAN_RT_PEER_BCNT_REG, val);
+		if (!uc->bchan) {
+			val = udma_tchanrt_read(uc, UDMA_CHAN_RT_PEER_BCNT_REG);
+			udma_tchanrt_write(uc, UDMA_CHAN_RT_PEER_BCNT_REG, val);
+		}
 	}
 
 	if (uc->rchan) {
@@ -1235,6 +1297,42 @@ static struct udma_##res *__udma_reserve_##res(struct udma_dev *ud,	\
 UDMA_RESERVE_RESOURCE(tchan);
 UDMA_RESERVE_RESOURCE(rchan);
 
+static struct udma_bchan *__bcdma_reserve_bchan(struct udma_dev *ud, int id)
+{
+	if (id >= 0) {
+		if (test_bit(id, ud->bchan_map)) {
+			dev_err(ud->dev, "bchan%d is in use\n", id);
+			return ERR_PTR(-ENOENT);
+		}
+	} else {
+		id = find_next_zero_bit(ud->bchan_map, ud->bchan_cnt, 0);
+		if (id == ud->bchan_cnt)
+			return ERR_PTR(-ENOENT);
+	}
+
+	set_bit(id, ud->bchan_map);
+	return &ud->bchans[id];
+}
+
+static int bcdma_get_bchan(struct udma_chan *uc)
+{
+	struct udma_dev *ud = uc->ud;
+
+	if (uc->bchan) {
+		dev_dbg(ud->dev, "chan%d: already have bchan%d allocated\n",
+			uc->id, uc->bchan->id);
+		return 0;
+	}
+
+	uc->bchan = __bcdma_reserve_bchan(ud, -1);
+	if (IS_ERR(uc->bchan))
+		return PTR_ERR(uc->bchan);
+
+	uc->tchan = uc->bchan;
+
+	return 0;
+}
+
 static int udma_get_tchan(struct udma_chan *uc)
 {
 	struct udma_dev *ud = uc->ud;
@@ -1327,6 +1425,19 @@ static int udma_get_rflow(struct udma_chan *uc, int flow_id)
 	return PTR_ERR_OR_ZERO(uc->rflow);
 }
 
+static void bcdma_put_bchan(struct udma_chan *uc)
+{
+	struct udma_dev *ud = uc->ud;
+
+	if (uc->bchan) {
+		dev_dbg(ud->dev, "chan%d: put bchan%d\n", uc->id,
+			uc->bchan->id);
+		clear_bit(uc->bchan->id, ud->bchan_map);
+		uc->bchan = NULL;
+		uc->tchan = NULL;
+	}
+}
+
 static void udma_put_rchan(struct udma_chan *uc)
 {
 	struct udma_dev *ud = uc->ud;
@@ -1363,6 +1474,65 @@ static void udma_put_rflow(struct udma_chan *uc)
 	}
 }
 
+static void bcdma_free_bchan_resources(struct udma_chan *uc)
+{
+	if (!uc->bchan)
+		return;
+
+	k3_ringacc_ring_free(uc->bchan->tc_ring);
+	k3_ringacc_ring_free(uc->bchan->t_ring);
+	uc->bchan->tc_ring = NULL;
+	uc->bchan->t_ring = NULL;
+	k3_configure_chan_coherency(&uc->vc.chan, 0);
+
+	bcdma_put_bchan(uc);
+}
+
+static int bcdma_alloc_bchan_resources(struct udma_chan *uc)
+{
+	struct k3_ring_cfg ring_cfg;
+	struct udma_dev *ud = uc->ud;
+	int ret;
+
+	ret = bcdma_get_bchan(uc);
+	if (ret)
+		return ret;
+
+	ret = k3_ringacc_request_rings_pair(ud->ringacc, uc->bchan->id, -1,
+					    &uc->bchan->t_ring,
+					    &uc->bchan->tc_ring);
+	if (ret) {
+		ret = -EBUSY;
+		goto err_ring;
+	}
+
+	memset(&ring_cfg, 0, sizeof(ring_cfg));
+	ring_cfg.size = K3_UDMA_DEFAULT_RING_SIZE;
+	ring_cfg.elm_size = K3_RINGACC_RING_ELSIZE_8;
+	ring_cfg.mode = K3_RINGACC_RING_MODE_RING;
+
+	k3_configure_chan_coherency(&uc->vc.chan, ud->asel);
+	ring_cfg.asel = ud->asel;
+	ring_cfg.dma_dev = dmaengine_get_dma_device(&uc->vc.chan);
+
+	ret = k3_ringacc_ring_cfg(uc->bchan->t_ring, &ring_cfg);
+	if (ret)
+		goto err_ringcfg;
+
+	return 0;
+
+err_ringcfg:
+	k3_ringacc_ring_free(uc->bchan->tc_ring);
+	uc->bchan->tc_ring = NULL;
+	k3_ringacc_ring_free(uc->bchan->t_ring);
+	uc->bchan->t_ring = NULL;
+	k3_configure_chan_coherency(&uc->vc.chan, 0);
+err_ring:
+	bcdma_put_bchan(uc);
+
+	return ret;
+}
+
 static void udma_free_tx_resources(struct udma_chan *uc)
 {
 	if (!uc->tchan)
@@ -1380,15 +1550,19 @@ static int udma_alloc_tx_resources(struct udma_chan *uc)
 {
 	struct k3_ring_cfg ring_cfg;
 	struct udma_dev *ud = uc->ud;
-	int ret;
+	struct udma_tchan *tchan;
+	int ring_idx, ret;
 
 	ret = udma_get_tchan(uc);
 	if (ret)
 		return ret;
 
-	ret = k3_ringacc_request_rings_pair(ud->ringacc, uc->tchan->id, -1,
-					    &uc->tchan->t_ring,
-					    &uc->tchan->tc_ring);
+	tchan = uc->tchan;
+	ring_idx = ud->bchan_cnt + tchan->id;
+
+	ret = k3_ringacc_request_rings_pair(ud->ringacc, ring_idx, -1,
+					    &tchan->t_ring,
+					    &tchan->tc_ring);
 	if (ret) {
 		ret = -EBUSY;
 		goto err_ring;
@@ -1397,10 +1571,18 @@ static int udma_alloc_tx_resources(struct udma_chan *uc)
 	memset(&ring_cfg, 0, sizeof(ring_cfg));
 	ring_cfg.size = K3_UDMA_DEFAULT_RING_SIZE;
 	ring_cfg.elm_size = K3_RINGACC_RING_ELSIZE_8;
-	ring_cfg.mode = K3_RINGACC_RING_MODE_MESSAGE;
+	if (ud->match_data->type == DMA_TYPE_UDMA) {
+		ring_cfg.mode = K3_RINGACC_RING_MODE_MESSAGE;
+	} else {
+		ring_cfg.mode = K3_RINGACC_RING_MODE_RING;
+
+		k3_configure_chan_coherency(&uc->vc.chan, uc->config.asel);
+		ring_cfg.asel = uc->config.asel;
+		ring_cfg.dma_dev = dmaengine_get_dma_device(&uc->vc.chan);
+	}
 
-	ret = k3_ringacc_ring_cfg(uc->tchan->t_ring, &ring_cfg);
-	ret |= k3_ringacc_ring_cfg(uc->tchan->tc_ring, &ring_cfg);
+	ret = k3_ringacc_ring_cfg(tchan->t_ring, &ring_cfg);
+	ret |= k3_ringacc_ring_cfg(tchan->tc_ring, &ring_cfg);
 
 	if (ret)
 		goto err_ringcfg;
@@ -1460,7 +1642,8 @@ static int udma_alloc_rx_resources(struct udma_chan *uc)
 	}
 
 	rflow = uc->rflow;
-	fd_ring_id = ud->tchan_cnt + ud->echan_cnt + uc->rchan->id;
+	fd_ring_id = ud->bchan_cnt + ud->tchan_cnt + ud->echan_cnt +
+		     uc->rchan->id;
 	ret = k3_ringacc_request_rings_pair(ud->ringacc, fd_ring_id, -1,
 					    &rflow->fd_ring, &rflow->r_ring);
 	if (ret) {
@@ -1470,15 +1653,25 @@ static int udma_alloc_rx_resources(struct udma_chan *uc)
 
 	memset(&ring_cfg, 0, sizeof(ring_cfg));
 
-	if (uc->config.pkt_mode)
-		ring_cfg.size = SG_MAX_SEGMENTS;
-	else
+	ring_cfg.elm_size = K3_RINGACC_RING_ELSIZE_8;
+	if (ud->match_data->type == DMA_TYPE_UDMA) {
+		if (uc->config.pkt_mode)
+			ring_cfg.size = SG_MAX_SEGMENTS;
+		else
+			ring_cfg.size = K3_UDMA_DEFAULT_RING_SIZE;
+
+		ring_cfg.mode = K3_RINGACC_RING_MODE_MESSAGE;
+	} else {
 		ring_cfg.size = K3_UDMA_DEFAULT_RING_SIZE;
+		ring_cfg.mode = K3_RINGACC_RING_MODE_RING;
 
-	ring_cfg.elm_size = K3_RINGACC_RING_ELSIZE_8;
-	ring_cfg.mode = K3_RINGACC_RING_MODE_MESSAGE;
+		k3_configure_chan_coherency(&uc->vc.chan, uc->config.asel);
+		ring_cfg.asel = uc->config.asel;
+		ring_cfg.dma_dev = dmaengine_get_dma_device(&uc->vc.chan);
+	}
 
 	ret = k3_ringacc_ring_cfg(rflow->fd_ring, &ring_cfg);
+
 	ring_cfg.size = K3_UDMA_DEFAULT_RING_SIZE;
 	ret |= k3_ringacc_ring_cfg(rflow->r_ring, &ring_cfg);
 
@@ -1500,7 +1693,18 @@ static int udma_alloc_rx_resources(struct udma_chan *uc)
 	return ret;
 }
 
-#define TISCI_TCHAN_VALID_PARAMS (				\
+#define TISCI_BCDMA_BCHAN_VALID_PARAMS (			\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |	\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_EXTENDED_CH_TYPE_VALID)
+
+#define TISCI_BCDMA_TCHAN_VALID_PARAMS (			\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |	\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_SUPR_TDPKT_VALID)
+
+#define TISCI_BCDMA_RCHAN_VALID_PARAMS (			\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID)
+
+#define TISCI_UDMA_TCHAN_VALID_PARAMS (				\
 	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |	\
 	TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_FILT_EINFO_VALID |	\
 	TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_FILT_PSWORDS_VALID |	\
@@ -1510,7 +1714,7 @@ static int udma_alloc_rx_resources(struct udma_chan *uc)
 	TI_SCI_MSG_VALUE_RM_UDMAP_CH_CQ_QNUM_VALID |		\
 	TI_SCI_MSG_VALUE_RM_UDMAP_CH_ATYPE_VALID)
 
-#define TISCI_RCHAN_VALID_PARAMS (				\
+#define TISCI_UDMA_RCHAN_VALID_PARAMS (				\
 	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |	\
 	TI_SCI_MSG_VALUE_RM_UDMAP_CH_FETCH_SIZE_VALID |		\
 	TI_SCI_MSG_VALUE_RM_UDMAP_CH_CQ_QNUM_VALID |		\
@@ -1535,7 +1739,7 @@ static int udma_tisci_m2m_channel_config(struct udma_chan *uc)
 	struct ti_sci_msg_rm_udmap_tx_ch_cfg req_tx = { 0 };
 	struct ti_sci_msg_rm_udmap_rx_ch_cfg req_rx = { 0 };
 
-	req_tx.valid_params = TISCI_TCHAN_VALID_PARAMS;
+	req_tx.valid_params = TISCI_UDMA_TCHAN_VALID_PARAMS;
 	req_tx.nav_id = tisci_rm->tisci_dev_id;
 	req_tx.index = tchan->id;
 	req_tx.tx_chan_type = TI_SCI_RM_UDMAP_CHAN_TYPE_3RDP_BCOPY_PBRR;
@@ -1549,7 +1753,7 @@ static int udma_tisci_m2m_channel_config(struct udma_chan *uc)
 		return ret;
 	}
 
-	req_rx.valid_params = TISCI_RCHAN_VALID_PARAMS;
+	req_rx.valid_params = TISCI_UDMA_RCHAN_VALID_PARAMS;
 	req_rx.nav_id = tisci_rm->tisci_dev_id;
 	req_rx.index = rchan->id;
 	req_rx.rx_fetch_size = sizeof(struct cppi5_desc_hdr_t) >> 2;
@@ -1564,6 +1768,27 @@ static int udma_tisci_m2m_channel_config(struct udma_chan *uc)
 	return ret;
 }
 
+static int bcdma_tisci_m2m_channel_config(struct udma_chan *uc)
+{
+	struct udma_dev *ud = uc->ud;
+	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
+	const struct ti_sci_rm_udmap_ops *tisci_ops = tisci_rm->tisci_udmap_ops;
+	struct ti_sci_msg_rm_udmap_tx_ch_cfg req_tx = { 0 };
+	struct udma_bchan *bchan = uc->bchan;
+	int ret = 0;
+
+	req_tx.valid_params = TISCI_BCDMA_BCHAN_VALID_PARAMS;
+	req_tx.nav_id = tisci_rm->tisci_dev_id;
+	req_tx.extended_ch_type = TI_SCI_RM_BCDMA_EXTENDED_CH_TYPE_BCHAN;
+	req_tx.index = bchan->id;
+
+	ret = tisci_ops->tx_ch_cfg(tisci_rm->tisci, &req_tx);
+	if (ret)
+		dev_err(ud->dev, "bchan%d cfg failed %d\n", bchan->id, ret);
+
+	return ret;
+}
+
 static int udma_tisci_tx_channel_config(struct udma_chan *uc)
 {
 	struct udma_dev *ud = uc->ud;
@@ -1584,7 +1809,7 @@ static int udma_tisci_tx_channel_config(struct udma_chan *uc)
 		fetch_size = sizeof(struct cppi5_desc_hdr_t);
 	}
 
-	req_tx.valid_params = TISCI_TCHAN_VALID_PARAMS;
+	req_tx.valid_params = TISCI_UDMA_TCHAN_VALID_PARAMS;
 	req_tx.nav_id = tisci_rm->tisci_dev_id;
 	req_tx.index = tchan->id;
 	req_tx.tx_chan_type = mode;
@@ -1607,6 +1832,33 @@ static int udma_tisci_tx_channel_config(struct udma_chan *uc)
 	return ret;
 }
 
+static int bcdma_tisci_tx_channel_config(struct udma_chan *uc)
+{
+	struct udma_dev *ud = uc->ud;
+	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
+	const struct ti_sci_rm_udmap_ops *tisci_ops = tisci_rm->tisci_udmap_ops;
+	struct udma_tchan *tchan = uc->tchan;
+	struct ti_sci_msg_rm_udmap_tx_ch_cfg req_tx = { 0 };
+	int ret = 0;
+
+	req_tx.valid_params = TISCI_BCDMA_TCHAN_VALID_PARAMS;
+	req_tx.nav_id = tisci_rm->tisci_dev_id;
+	req_tx.index = tchan->id;
+	req_tx.tx_supr_tdpkt = uc->config.notdpkt;
+	if (ud->match_data->flags & UDMA_FLAG_TDTYPE) {
+		/* wait for peer to complete the teardown for PDMAs */
+		req_tx.valid_params |=
+				TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_TDTYPE_VALID;
+		req_tx.tx_tdtype = 1;
+	}
+
+	ret = tisci_ops->tx_ch_cfg(tisci_rm->tisci, &req_tx);
+	if (ret)
+		dev_err(ud->dev, "tchan%d cfg failed %d\n", tchan->id, ret);
+
+	return ret;
+}
+
 static int udma_tisci_rx_channel_config(struct udma_chan *uc)
 {
 	struct udma_dev *ud = uc->ud;
@@ -1629,7 +1881,7 @@ static int udma_tisci_rx_channel_config(struct udma_chan *uc)
 		fetch_size = sizeof(struct cppi5_desc_hdr_t);
 	}
 
-	req_rx.valid_params = TISCI_RCHAN_VALID_PARAMS;
+	req_rx.valid_params = TISCI_UDMA_RCHAN_VALID_PARAMS;
 	req_rx.nav_id = tisci_rm->tisci_dev_id;
 	req_rx.index = rchan->id;
 	req_rx.rx_fetch_size =  fetch_size >> 2;
@@ -1688,6 +1940,26 @@ static int udma_tisci_rx_channel_config(struct udma_chan *uc)
 	return 0;
 }
 
+static int bcdma_tisci_rx_channel_config(struct udma_chan *uc)
+{
+	struct udma_dev *ud = uc->ud;
+	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
+	const struct ti_sci_rm_udmap_ops *tisci_ops = tisci_rm->tisci_udmap_ops;
+	struct udma_rchan *rchan = uc->rchan;
+	struct ti_sci_msg_rm_udmap_rx_ch_cfg req_rx = { 0 };
+	int ret = 0;
+
+	req_rx.valid_params = TISCI_BCDMA_RCHAN_VALID_PARAMS;
+	req_rx.nav_id = tisci_rm->tisci_dev_id;
+	req_rx.index = rchan->id;
+
+	ret = tisci_ops->rx_ch_cfg(tisci_rm->tisci, &req_rx);
+	if (ret)
+		dev_err(ud->dev, "rchan%d cfg failed %d\n", rchan->id, ret);
+
+	return ret;
+}
+
 static int udma_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct udma_chan *uc = to_udma_chan(chan);
@@ -1697,6 +1969,8 @@ static int udma_alloc_chan_resources(struct dma_chan *chan)
 	u32 irq_udma_idx;
 	int ret;
 
+	uc->dma_dev = ud->dev;
+
 	if (uc->config.pkt_mode || uc->config.dir == DMA_MEM_TO_MEM) {
 		uc->use_dma_pool = true;
 		/* in case of MEM_TO_MEM we have maximum of two TRs */
@@ -1792,7 +2066,7 @@ static int udma_alloc_chan_resources(struct dma_chan *chan)
 					K3_PSIL_DST_THREAD_ID_OFFSET;
 
 		irq_ring = uc->rflow->r_ring;
-		irq_udma_idx = soc_data->rchan_oes_offset + uc->rchan->id;
+		irq_udma_idx = soc_data->oes.udma_rchan + uc->rchan->id;
 
 		ret = udma_tisci_rx_channel_config(uc);
 		break;
@@ -1892,81 +2166,293 @@ static int udma_alloc_chan_resources(struct dma_chan *chan)
 	return ret;
 }
 
-static int udma_slave_config(struct dma_chan *chan,
-			     struct dma_slave_config *cfg)
+static int bcdma_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct udma_chan *uc = to_udma_chan(chan);
+	struct udma_dev *ud = to_udma_dev(chan->device);
+	const struct udma_oes_offsets *oes = &ud->soc_data->oes;
+	u32 irq_udma_idx, irq_ring_idx;
+	int ret;
 
-	memcpy(&uc->cfg, cfg, sizeof(uc->cfg));
+	/* Only TR mode is supported */
+	uc->config.pkt_mode = false;
 
-	return 0;
-}
+	/*
+	 * Make sure that the completion is in a known state:
+	 * No teardown, the channel is idle
+	 */
+	reinit_completion(&uc->teardown_completed);
+	complete_all(&uc->teardown_completed);
+	uc->state = UDMA_CHAN_IS_IDLE;
 
-static struct udma_desc *udma_alloc_tr_desc(struct udma_chan *uc,
-					    size_t tr_size, int tr_count,
-					    enum dma_transfer_direction dir)
-{
-	struct udma_hwdesc *hwdesc;
-	struct cppi5_desc_hdr_t *tr_desc;
-	struct udma_desc *d;
-	u32 reload_count = 0;
-	u32 ring_id;
+	switch (uc->config.dir) {
+	case DMA_MEM_TO_MEM:
+		/* Non synchronized - mem to mem type of transfer */
+		dev_dbg(uc->ud->dev, "%s: chan%d as MEM-to-MEM\n", __func__,
+			uc->id);
 
-	switch (tr_size) {
-	case 16:
-	case 32:
-	case 64:
-	case 128:
-		break;
-	default:
-		dev_err(uc->ud->dev, "Unsupported TR size of %zu\n", tr_size);
-		return NULL;
-	}
+		ret = bcdma_alloc_bchan_resources(uc);
+		if (ret)
+			return ret;
 
-	/* We have only one descriptor containing multiple TRs */
-	d = kzalloc(sizeof(*d) + sizeof(d->hwdesc[0]), GFP_NOWAIT);
-	if (!d)
-		return NULL;
+		irq_ring_idx = uc->bchan->id + oes->bcdma_bchan_ring;
+		irq_udma_idx = uc->bchan->id + oes->bcdma_bchan_data;
 
-	d->sglen = tr_count;
+		ret = bcdma_tisci_m2m_channel_config(uc);
+		break;
+	case DMA_MEM_TO_DEV:
+		/* Slave transfer synchronized - mem to dev (TX) trasnfer */
+		dev_dbg(uc->ud->dev, "%s: chan%d as MEM-to-DEV\n", __func__,
+			uc->id);
 
-	d->hwdesc_count = 1;
-	hwdesc = &d->hwdesc[0];
+		ret = udma_alloc_tx_resources(uc);
+		if (ret) {
+			uc->config.remote_thread_id = -1;
+			return ret;
+		}
 
-	/* Allocate memory for DMA ring descriptor */
-	if (uc->use_dma_pool) {
-		hwdesc->cppi5_desc_size = uc->config.hdesc_size;
-		hwdesc->cppi5_desc_vaddr = dma_pool_zalloc(uc->hdesc_pool,
-						GFP_NOWAIT,
-						&hwdesc->cppi5_desc_paddr);
-	} else {
-		hwdesc->cppi5_desc_size = cppi5_trdesc_calc_size(tr_size,
-								 tr_count);
-		hwdesc->cppi5_desc_size = ALIGN(hwdesc->cppi5_desc_size,
-						uc->ud->desc_align);
-		hwdesc->cppi5_desc_vaddr = dma_alloc_coherent(uc->ud->dev,
-						hwdesc->cppi5_desc_size,
-						&hwdesc->cppi5_desc_paddr,
-						GFP_NOWAIT);
-	}
+		uc->config.src_thread = ud->psil_base + uc->tchan->id;
+		uc->config.dst_thread = uc->config.remote_thread_id;
+		uc->config.dst_thread |= K3_PSIL_DST_THREAD_ID_OFFSET;
 
-	if (!hwdesc->cppi5_desc_vaddr) {
-		kfree(d);
-		return NULL;
-	}
+		irq_ring_idx = uc->tchan->id + oes->bcdma_tchan_ring;
+		irq_udma_idx = uc->tchan->id + oes->bcdma_tchan_data;
 
-	/* Start of the TR req records */
-	hwdesc->tr_req_base = hwdesc->cppi5_desc_vaddr + tr_size;
-	/* Start address of the TR response array */
-	hwdesc->tr_resp_base = hwdesc->tr_req_base + tr_size * tr_count;
+		ret = bcdma_tisci_tx_channel_config(uc);
+		break;
+	case DMA_DEV_TO_MEM:
+		/* Slave transfer synchronized - dev to mem (RX) trasnfer */
+		dev_dbg(uc->ud->dev, "%s: chan%d as DEV-to-MEM\n", __func__,
+			uc->id);
 
-	tr_desc = hwdesc->cppi5_desc_vaddr;
+		ret = udma_alloc_rx_resources(uc);
+		if (ret) {
+			uc->config.remote_thread_id = -1;
+			return ret;
+		}
 
-	if (uc->cyclic)
-		reload_count = CPPI5_INFO0_TRDESC_RLDCNT_INFINITE;
+		uc->config.src_thread = uc->config.remote_thread_id;
+		uc->config.dst_thread = (ud->psil_base + uc->rchan->id) |
+					K3_PSIL_DST_THREAD_ID_OFFSET;
 
-	if (dir == DMA_DEV_TO_MEM)
-		ring_id = k3_ringacc_get_ring_id(uc->rflow->r_ring);
+		irq_ring_idx = uc->rchan->id + oes->bcdma_rchan_ring;
+		irq_udma_idx = uc->rchan->id + oes->bcdma_rchan_data;
+
+		ret = bcdma_tisci_rx_channel_config(uc);
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
+	if (uc->config.dir == DMA_MEM_TO_MEM  && !uc->config.tr_trigger_type) {
+		uc->config.hdesc_size = cppi5_trdesc_calc_size(
+					sizeof(struct cppi5_tr_type15_t), 2);
+
+		uc->hdesc_pool = dma_pool_create(uc->name, ud->ddev.dev,
+						 uc->config.hdesc_size,
+						 ud->desc_align,
+						 0);
+		if (!uc->hdesc_pool) {
+			dev_err(ud->ddev.dev,
+				"Descriptor pool allocation failed\n");
+			uc->use_dma_pool = false;
+			return -ENOMEM;
+		}
+
+		uc->use_dma_pool = true;
+	} else if (uc->config.dir != DMA_MEM_TO_MEM) {
+		/* PSI-L pairing */
+		ret = navss_psil_pair(ud, uc->config.src_thread,
+				      uc->config.dst_thread);
+		if (ret) {
+			dev_err(ud->dev,
+				"PSI-L pairing failed: 0x%04x -> 0x%04x\n",
+				uc->config.src_thread, uc->config.dst_thread);
+			goto err_res_free;
+		}
+
+		uc->psil_paired = true;
+	}
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
+	/* Event from BCDMA (TR events) only needed for slave channels */
+	if (is_slave_direction(uc->config.dir)) {
+		uc->irq_num_udma = ti_sci_inta_msi_get_virq(ud->dev,
+							    irq_udma_idx);
+		if (uc->irq_num_udma <= 0) {
+			dev_err(ud->dev, "Failed to get bcdma irq (index: %u)\n",
+				irq_udma_idx);
+			free_irq(uc->irq_num_ring, uc);
+			ret = -EINVAL;
+			goto err_irq_free;
+		}
+
+		ret = request_irq(uc->irq_num_udma, udma_udma_irq_handler, 0,
+				  uc->name, uc);
+		if (ret) {
+			dev_err(ud->dev, "chan%d: BCDMA irq request failed\n",
+				uc->id);
+			free_irq(uc->irq_num_ring, uc);
+			goto err_irq_free;
+		}
+	} else {
+		uc->irq_num_udma = 0;
+	}
+
+	udma_reset_rings(uc);
+
+	INIT_DELAYED_WORK_ONSTACK(&uc->tx_drain.work,
+				  udma_check_tx_completion);
+	return 0;
+
+err_irq_free:
+	uc->irq_num_ring = 0;
+	uc->irq_num_udma = 0;
+err_psi_free:
+	if (uc->psil_paired)
+		navss_psil_unpair(ud, uc->config.src_thread,
+				  uc->config.dst_thread);
+	uc->psil_paired = false;
+err_res_free:
+	bcdma_free_bchan_resources(uc);
+	udma_free_tx_resources(uc);
+	udma_free_rx_resources(uc);
+
+	udma_reset_uchan(uc);
+
+	if (uc->use_dma_pool) {
+		dma_pool_destroy(uc->hdesc_pool);
+		uc->use_dma_pool = false;
+	}
+
+	return ret;
+}
+
+static int bcdma_router_config(struct dma_chan *chan)
+{
+	struct k3_event_route_data *router_data = chan->route_data;
+	struct udma_chan *uc = to_udma_chan(chan);
+	u32 trigger_event;
+
+	if (!uc->bchan)
+		return -EINVAL;
+
+	if (uc->config.tr_trigger_type != 1 && uc->config.tr_trigger_type != 2)
+		return -EINVAL;
+
+	trigger_event = uc->ud->soc_data->bcdma_trigger_event_offset;
+	trigger_event += (uc->bchan->id * 2) + uc->config.tr_trigger_type - 1;
+
+	return router_data->set_event(router_data->priv, trigger_event);
+}
+
+static int udma_slave_config(struct dma_chan *chan,
+			     struct dma_slave_config *cfg)
+{
+	struct udma_chan *uc = to_udma_chan(chan);
+
+	memcpy(&uc->cfg, cfg, sizeof(uc->cfg));
+
+	return 0;
+}
+
+static struct udma_desc *udma_alloc_tr_desc(struct udma_chan *uc,
+					    size_t tr_size, int tr_count,
+					    enum dma_transfer_direction dir)
+{
+	struct udma_hwdesc *hwdesc;
+	struct cppi5_desc_hdr_t *tr_desc;
+	struct udma_desc *d;
+	u32 reload_count = 0;
+	u32 ring_id;
+
+	switch (tr_size) {
+	case 16:
+	case 32:
+	case 64:
+	case 128:
+		break;
+	default:
+		dev_err(uc->ud->dev, "Unsupported TR size of %zu\n", tr_size);
+		return NULL;
+	}
+
+	/* We have only one descriptor containing multiple TRs */
+	d = kzalloc(sizeof(*d) + sizeof(d->hwdesc[0]), GFP_NOWAIT);
+	if (!d)
+		return NULL;
+
+	d->sglen = tr_count;
+
+	d->hwdesc_count = 1;
+	hwdesc = &d->hwdesc[0];
+
+	/* Allocate memory for DMA ring descriptor */
+	if (uc->use_dma_pool) {
+		hwdesc->cppi5_desc_size = uc->config.hdesc_size;
+		hwdesc->cppi5_desc_vaddr = dma_pool_zalloc(uc->hdesc_pool,
+						GFP_NOWAIT,
+						&hwdesc->cppi5_desc_paddr);
+	} else {
+		hwdesc->cppi5_desc_size = cppi5_trdesc_calc_size(tr_size,
+								 tr_count);
+		hwdesc->cppi5_desc_size = ALIGN(hwdesc->cppi5_desc_size,
+						uc->ud->desc_align);
+		hwdesc->cppi5_desc_vaddr = dma_alloc_coherent(uc->ud->dev,
+						hwdesc->cppi5_desc_size,
+						&hwdesc->cppi5_desc_paddr,
+						GFP_NOWAIT);
+	}
+
+	if (!hwdesc->cppi5_desc_vaddr) {
+		kfree(d);
+		return NULL;
+	}
+
+	/* Start of the TR req records */
+	hwdesc->tr_req_base = hwdesc->cppi5_desc_vaddr + tr_size;
+	/* Start address of the TR response array */
+	hwdesc->tr_resp_base = hwdesc->tr_req_base + tr_size * tr_count;
+
+	tr_desc = hwdesc->cppi5_desc_vaddr;
+
+	if (uc->cyclic)
+		reload_count = CPPI5_INFO0_TRDESC_RLDCNT_INFINITE;
+
+	if (dir == DMA_DEV_TO_MEM)
+		ring_id = k3_ringacc_get_ring_id(uc->rflow->r_ring);
 	else
 		ring_id = k3_ringacc_get_ring_id(uc->tchan->tc_ring);
 
@@ -2036,6 +2522,7 @@ udma_prep_slave_sg_tr(struct udma_chan *uc, struct scatterlist *sgl,
 	size_t tr_size;
 	int num_tr = 0;
 	int tr_idx = 0;
+	u64 asel;
 
 	/* estimate the number of TRs we will need */
 	for_each_sg(sgl, sgent, sglen, i) {
@@ -2053,6 +2540,11 @@ udma_prep_slave_sg_tr(struct udma_chan *uc, struct scatterlist *sgl,
 
 	d->sglen = sglen;
 
+	if (uc->ud->match_data->type == DMA_TYPE_UDMA)
+		asel = 0;
+	else
+		asel = (u64)uc->config.asel << K3_ADDRESS_ASEL_SHIFT;
+
 	tr_req = d->hwdesc[0].tr_req_base;
 	for_each_sg(sgl, sgent, sglen, i) {
 		dma_addr_t sg_addr = sg_dma_address(sgent);
@@ -2071,6 +2563,7 @@ udma_prep_slave_sg_tr(struct udma_chan *uc, struct scatterlist *sgl,
 			      false, CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
 		cppi5_tr_csf_set(&tr_req[tr_idx].flags, CPPI5_TR_CSF_SUPR_EVT);
 
+		sg_addr |= asel;
 		tr_req[tr_idx].addr = sg_addr;
 		tr_req[tr_idx].icnt0 = tr0_cnt0;
 		tr_req[tr_idx].icnt1 = tr0_cnt1;
@@ -2100,6 +2593,205 @@ udma_prep_slave_sg_tr(struct udma_chan *uc, struct scatterlist *sgl,
 	return d;
 }
 
+static struct udma_desc *
+udma_prep_slave_sg_triggered_tr(struct udma_chan *uc, struct scatterlist *sgl,
+				unsigned int sglen,
+				enum dma_transfer_direction dir,
+				unsigned long tx_flags, void *context)
+{
+	struct scatterlist *sgent;
+	struct cppi5_tr_type15_t *tr_req = NULL;
+	enum dma_slave_buswidth dev_width;
+	u16 tr_cnt0, tr_cnt1;
+	dma_addr_t dev_addr;
+	struct udma_desc *d;
+	unsigned int i;
+	size_t tr_size, sg_len;
+	int num_tr = 0;
+	int tr_idx = 0;
+	u32 burst, trigger_size, port_window;
+	u64 asel;
+
+	if (dir == DMA_DEV_TO_MEM) {
+		dev_addr = uc->cfg.src_addr;
+		dev_width = uc->cfg.src_addr_width;
+		burst = uc->cfg.src_maxburst;
+		port_window = uc->cfg.src_port_window_size;
+	} else if (dir == DMA_MEM_TO_DEV) {
+		dev_addr = uc->cfg.dst_addr;
+		dev_width = uc->cfg.dst_addr_width;
+		burst = uc->cfg.dst_maxburst;
+		port_window = uc->cfg.dst_port_window_size;
+	} else {
+		dev_err(uc->ud->dev, "%s: bad direction?\n", __func__);
+		return NULL;
+	}
+
+	if (!burst)
+		burst = 1;
+
+	if (port_window) {
+		if (port_window != burst) {
+			dev_err(uc->ud->dev,
+				"The burst must be equal to port_window\n");
+			return NULL;
+		}
+
+		tr_cnt0 = dev_width * port_window;
+		tr_cnt1 = 1;
+	} else {
+		tr_cnt0 = dev_width;
+		tr_cnt1 = burst;
+	}
+	trigger_size = tr_cnt0 * tr_cnt1;
+
+	/* estimate the number of TRs we will need */
+	for_each_sg(sgl, sgent, sglen, i) {
+		sg_len = sg_dma_len(sgent);
+
+		if (sg_len % trigger_size) {
+			dev_err(uc->ud->dev,
+				"Not aligned SG entry (%zu for %u)\n", sg_len,
+				trigger_size);
+			return NULL;
+		}
+
+		if (sg_len / trigger_size < SZ_64K)
+			num_tr++;
+		else
+			num_tr += 2;
+	}
+
+	/* Now allocate and setup the descriptor. */
+	tr_size = sizeof(struct cppi5_tr_type15_t);
+	d = udma_alloc_tr_desc(uc, tr_size, num_tr, dir);
+	if (!d)
+		return NULL;
+
+	d->sglen = sglen;
+
+	if (uc->ud->match_data->type == DMA_TYPE_UDMA) {
+		asel = 0;
+	} else {
+		asel = (u64)uc->config.asel << K3_ADDRESS_ASEL_SHIFT;
+		dev_addr |= asel;
+	}
+
+	tr_req = d->hwdesc[0].tr_req_base;
+	for_each_sg(sgl, sgent, sglen, i) {
+		u16 tr0_cnt2, tr0_cnt3, tr1_cnt2;
+		dma_addr_t sg_addr = sg_dma_address(sgent);
+
+		sg_len = sg_dma_len(sgent);
+		num_tr = udma_get_tr_counters(sg_len / trigger_size, 0,
+					      &tr0_cnt2, &tr0_cnt3, &tr1_cnt2);
+		if (num_tr < 0) {
+			dev_err(uc->ud->dev, "size %zu is not supported\n",
+				sg_len);
+			udma_free_hwdesc(uc, d);
+			kfree(d);
+			return NULL;
+		}
+
+		cppi5_tr_init(&tr_req[tr_idx].flags, CPPI5_TR_TYPE15, false,
+			      true, CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
+		cppi5_tr_csf_set(&tr_req[tr_idx].flags, CPPI5_TR_CSF_SUPR_EVT);
+		cppi5_tr_set_trigger(&tr_req[tr_idx].flags,
+				     uc->config.tr_trigger_type,
+				     CPPI5_TR_TRIGGER_TYPE_ICNT2_DEC, 0, 0);
+
+		sg_addr |= asel;
+		if (dir == DMA_DEV_TO_MEM) {
+			tr_req[tr_idx].addr = dev_addr;
+			tr_req[tr_idx].icnt0 = tr_cnt0;
+			tr_req[tr_idx].icnt1 = tr_cnt1;
+			tr_req[tr_idx].icnt2 = tr0_cnt2;
+			tr_req[tr_idx].icnt3 = tr0_cnt3;
+			tr_req[tr_idx].dim1 = (-1) * tr_cnt0;
+
+			tr_req[tr_idx].daddr = sg_addr;
+			tr_req[tr_idx].dicnt0 = tr_cnt0;
+			tr_req[tr_idx].dicnt1 = tr_cnt1;
+			tr_req[tr_idx].dicnt2 = tr0_cnt2;
+			tr_req[tr_idx].dicnt3 = tr0_cnt3;
+			tr_req[tr_idx].ddim1 = tr_cnt0;
+			tr_req[tr_idx].ddim2 = trigger_size;
+			tr_req[tr_idx].ddim3 = trigger_size * tr0_cnt2;
+		} else {
+			tr_req[tr_idx].addr = sg_addr;
+			tr_req[tr_idx].icnt0 = tr_cnt0;
+			tr_req[tr_idx].icnt1 = tr_cnt1;
+			tr_req[tr_idx].icnt2 = tr0_cnt2;
+			tr_req[tr_idx].icnt3 = tr0_cnt3;
+			tr_req[tr_idx].dim1 = tr_cnt0;
+			tr_req[tr_idx].dim2 = trigger_size;
+			tr_req[tr_idx].dim3 = trigger_size * tr0_cnt2;
+
+			tr_req[tr_idx].daddr = dev_addr;
+			tr_req[tr_idx].dicnt0 = tr_cnt0;
+			tr_req[tr_idx].dicnt1 = tr_cnt1;
+			tr_req[tr_idx].dicnt2 = tr0_cnt2;
+			tr_req[tr_idx].dicnt3 = tr0_cnt3;
+			tr_req[tr_idx].ddim1 = (-1) * tr_cnt0;
+		}
+
+		tr_idx++;
+
+		if (num_tr == 2) {
+			cppi5_tr_init(&tr_req[tr_idx].flags, CPPI5_TR_TYPE15,
+				      false, true,
+				      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
+			cppi5_tr_csf_set(&tr_req[tr_idx].flags,
+					 CPPI5_TR_CSF_SUPR_EVT);
+			cppi5_tr_set_trigger(&tr_req[tr_idx].flags,
+					     uc->config.tr_trigger_type,
+					     CPPI5_TR_TRIGGER_TYPE_ICNT2_DEC,
+					     0, 0);
+
+			sg_addr += trigger_size * tr0_cnt2 * tr0_cnt3;
+			if (dir == DMA_DEV_TO_MEM) {
+				tr_req[tr_idx].addr = dev_addr;
+				tr_req[tr_idx].icnt0 = tr_cnt0;
+				tr_req[tr_idx].icnt1 = tr_cnt1;
+				tr_req[tr_idx].icnt2 = tr1_cnt2;
+				tr_req[tr_idx].icnt3 = 1;
+				tr_req[tr_idx].dim1 = (-1) * tr_cnt0;
+
+				tr_req[tr_idx].daddr = sg_addr;
+				tr_req[tr_idx].dicnt0 = tr_cnt0;
+				tr_req[tr_idx].dicnt1 = tr_cnt1;
+				tr_req[tr_idx].dicnt2 = tr1_cnt2;
+				tr_req[tr_idx].dicnt3 = 1;
+				tr_req[tr_idx].ddim1 = tr_cnt0;
+				tr_req[tr_idx].ddim2 = trigger_size;
+			} else {
+				tr_req[tr_idx].addr = sg_addr;
+				tr_req[tr_idx].icnt0 = tr_cnt0;
+				tr_req[tr_idx].icnt1 = tr_cnt1;
+				tr_req[tr_idx].icnt2 = tr1_cnt2;
+				tr_req[tr_idx].icnt3 = 1;
+				tr_req[tr_idx].dim1 = tr_cnt0;
+				tr_req[tr_idx].dim2 = trigger_size;
+
+				tr_req[tr_idx].daddr = dev_addr;
+				tr_req[tr_idx].dicnt0 = tr_cnt0;
+				tr_req[tr_idx].dicnt1 = tr_cnt1;
+				tr_req[tr_idx].dicnt2 = tr1_cnt2;
+				tr_req[tr_idx].dicnt3 = 1;
+				tr_req[tr_idx].ddim1 = (-1) * tr_cnt0;
+			}
+			tr_idx++;
+		}
+
+		d->residue += sg_len;
+	}
+
+	cppi5_tr_csf_set(&tr_req[tr_idx - 1].flags,
+			 CPPI5_TR_CSF_SUPR_EVT | CPPI5_TR_CSF_EOP);
+
+	return d;
+}
+
 static int udma_configure_statictr(struct udma_chan *uc, struct udma_desc *d,
 				   enum dma_slave_buswidth dev_width,
 				   u16 elcnt)
@@ -2341,7 +3033,8 @@ udma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	struct udma_desc *d;
 	u32 burst;
 
-	if (dir != uc->config.dir) {
+	if (dir != uc->config.dir &&
+	    (uc->config.dir == DMA_MEM_TO_MEM && !uc->config.tr_trigger_type)) {
 		dev_err(chan->device->dev,
 			"%s: chan%d is for %s, not supporting %s\n",
 			__func__, uc->id,
@@ -2367,9 +3060,12 @@ udma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	if (uc->config.pkt_mode)
 		d = udma_prep_slave_sg_pkt(uc, sgl, sglen, dir, tx_flags,
 					   context);
-	else
+	else if (is_slave_direction(uc->config.dir))
 		d = udma_prep_slave_sg_tr(uc, sgl, sglen, dir, tx_flags,
 					  context);
+	else
+		d = udma_prep_slave_sg_triggered_tr(uc, sgl, sglen, dir,
+						    tx_flags, context);
 
 	if (!d)
 		return NULL;
@@ -2423,7 +3119,12 @@ udma_prep_dma_cyclic_tr(struct udma_chan *uc, dma_addr_t buf_addr,
 		return NULL;
 
 	tr_req = d->hwdesc[0].tr_req_base;
-	period_addr = buf_addr;
+	if (uc->ud->match_data->type == DMA_TYPE_UDMA)
+		period_addr = buf_addr;
+	else
+		period_addr = buf_addr |
+			((u64)uc->config.asel << K3_ADDRESS_ASEL_SHIFT);
+
 	for (i = 0; i < periods; i++) {
 		int tr_idx = i * num_tr;
 
@@ -2629,6 +3330,11 @@ udma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 	d->tr_idx = 0;
 	d->residue = len;
 
+	if (uc->ud->match_data->type != DMA_TYPE_UDMA) {
+		src |= (u64)uc->ud->asel << K3_ADDRESS_ASEL_SHIFT;
+		dest |= (u64)uc->ud->asel << K3_ADDRESS_ASEL_SHIFT;
+	}
+
 	tr_req = d->hwdesc[0].tr_req_base;
 
 	cppi5_tr_init(&tr_req[0].flags, CPPI5_TR_TYPE15, false, true,
@@ -2986,6 +3692,7 @@ static void udma_free_chan_resources(struct dma_chan *chan)
 	vchan_free_chan_resources(&uc->vc);
 	tasklet_kill(&uc->vc.task);
 
+	bcdma_free_bchan_resources(uc);
 	udma_free_tx_resources(uc);
 	udma_free_rx_resources(uc);
 	udma_reset_uchan(uc);
@@ -2997,10 +3704,13 @@ static void udma_free_chan_resources(struct dma_chan *chan)
 }
 
 static struct platform_driver udma_driver;
+static struct platform_driver bcdma_driver;
 
 struct udma_filter_param {
 	int remote_thread_id;
 	u32 atype;
+	u32 asel;
+	u32 tr_trigger_type;
 };
 
 static bool udma_dma_filter_fn(struct dma_chan *chan, void *param)
@@ -3011,7 +3721,8 @@ static bool udma_dma_filter_fn(struct dma_chan *chan, void *param)
 	struct udma_chan *uc;
 	struct udma_dev *ud;
 
-	if (chan->device->dev->driver != &udma_driver.driver)
+	if (chan->device->dev->driver != &udma_driver.driver &&
+	    chan->device->dev->driver != &bcdma_driver.driver)
 		return false;
 
 	uc = to_udma_chan(chan);
@@ -3025,13 +3736,25 @@ static bool udma_dma_filter_fn(struct dma_chan *chan, void *param)
 		return false;
 	}
 
+	if (filter_param->asel > 15) {
+		dev_err(ud->dev, "Invalid channel asel: %u\n",
+			filter_param->asel);
+		return false;
+	}
+
 	ucc->remote_thread_id = filter_param->remote_thread_id;
 	ucc->atype = filter_param->atype;
+	ucc->asel = filter_param->asel;
+	ucc->tr_trigger_type = filter_param->tr_trigger_type;
 
-	if (ucc->remote_thread_id & K3_PSIL_DST_THREAD_ID_OFFSET)
+	if (ucc->tr_trigger_type) {
+		ucc->dir = DMA_MEM_TO_MEM;
+		goto triggered_bchan;
+	} else if (ucc->remote_thread_id & K3_PSIL_DST_THREAD_ID_OFFSET) {
 		ucc->dir = DMA_MEM_TO_DEV;
-	else
+	} else {
 		ucc->dir = DMA_DEV_TO_MEM;
+	}
 
 	ep_config = psil_get_ep_config(ucc->remote_thread_id);
 	if (IS_ERR(ep_config)) {
@@ -3040,6 +3763,19 @@ static bool udma_dma_filter_fn(struct dma_chan *chan, void *param)
 		ucc->dir = DMA_MEM_TO_MEM;
 		ucc->remote_thread_id = -1;
 		ucc->atype = 0;
+		ucc->asel = 0;
+		return false;
+	}
+
+	if (ud->match_data->type == DMA_TYPE_BCDMA &&
+	    ep_config->pkt_mode) {
+		dev_err(ud->dev,
+			"Only TR mode is supported (psi-l thread 0x%04x)\n",
+			ucc->remote_thread_id);
+		ucc->dir = DMA_MEM_TO_MEM;
+		ucc->remote_thread_id = -1;
+		ucc->atype = 0;
+		ucc->asel = 0;
 		return false;
 	}
 
@@ -3071,6 +3807,13 @@ static bool udma_dma_filter_fn(struct dma_chan *chan, void *param)
 		ucc->remote_thread_id, dmaengine_get_direction_text(ucc->dir));
 
 	return true;
+
+triggered_bchan:
+	dev_dbg(ud->dev, "chan%d: triggered channel (type: %u)\n", uc->id,
+		ucc->tr_trigger_type);
+
+	return true;
+
 }
 
 static struct dma_chan *udma_of_xlate(struct of_phandle_args *dma_spec,
@@ -3081,14 +3824,33 @@ static struct dma_chan *udma_of_xlate(struct of_phandle_args *dma_spec,
 	struct udma_filter_param filter_param;
 	struct dma_chan *chan;
 
-	if (dma_spec->args_count != 1 && dma_spec->args_count != 2)
-		return NULL;
+	if (ud->match_data->type == DMA_TYPE_BCDMA) {
+		if (dma_spec->args_count != 3)
+			return NULL;
 
-	filter_param.remote_thread_id = dma_spec->args[0];
-	if (dma_spec->args_count == 2)
-		filter_param.atype = dma_spec->args[1];
-	else
+		filter_param.tr_trigger_type = dma_spec->args[0];
+		filter_param.remote_thread_id = dma_spec->args[1];
+		filter_param.asel = dma_spec->args[2];
 		filter_param.atype = 0;
+	} else {
+		if (dma_spec->args_count != 1 && dma_spec->args_count != 2)
+			return NULL;
+
+		filter_param.remote_thread_id = dma_spec->args[0];
+		filter_param.tr_trigger_type = 0;
+		if (dma_spec->args_count == 2) {
+			if (ud->match_data->type == DMA_TYPE_UDMA) {
+				filter_param.atype = dma_spec->args[1];
+				filter_param.asel = 0;
+			} else {
+				filter_param.atype = 0;
+				filter_param.asel = dma_spec->args[1];
+			}
+		} else {
+			filter_param.atype = 0;
+			filter_param.asel = 0;
+		}
+	}
 
 	chan = __dma_request_channel(&mask, udma_dma_filter_fn, &filter_param,
 				     ofdma->of_node);
@@ -3101,18 +3863,21 @@ static struct dma_chan *udma_of_xlate(struct of_phandle_args *dma_spec,
 }
 
 static struct udma_match_data am654_main_data = {
+	.type = DMA_TYPE_UDMA,
 	.psil_base = 0x1000,
 	.enable_memcpy_support = true,
 	.statictr_z_mask = GENMASK(11, 0),
 };
 
 static struct udma_match_data am654_mcu_data = {
+	.type = DMA_TYPE_UDMA,
 	.psil_base = 0x6000,
 	.enable_memcpy_support = false,
 	.statictr_z_mask = GENMASK(11, 0),
 };
 
 static struct udma_match_data j721e_main_data = {
+	.type = DMA_TYPE_UDMA,
 	.psil_base = 0x1000,
 	.enable_memcpy_support = true,
 	.flags = UDMA_FLAG_PDMA_ACC32 | UDMA_FLAG_PDMA_BURST | UDMA_FLAG_TDTYPE,
@@ -3120,12 +3885,21 @@ static struct udma_match_data j721e_main_data = {
 };
 
 static struct udma_match_data j721e_mcu_data = {
+	.type = DMA_TYPE_UDMA,
 	.psil_base = 0x6000,
 	.enable_memcpy_support = false, /* MEM_TO_MEM is slow via MCU UDMA */
 	.flags = UDMA_FLAG_PDMA_ACC32 | UDMA_FLAG_PDMA_BURST | UDMA_FLAG_TDTYPE,
 	.statictr_z_mask = GENMASK(23, 0),
 };
 
+static struct udma_match_data am64_bcdma_data = {
+	.type = DMA_TYPE_BCDMA,
+	.psil_base = 0x2000, /* for tchan and rchan, not applicable to bchan */
+	.enable_memcpy_support = true, /* Supported via bchan */
+	.flags = UDMA_FLAG_PDMA_ACC32 | UDMA_FLAG_PDMA_BURST | UDMA_FLAG_TDTYPE,
+	.statictr_z_mask = GENMASK(23, 0),
+};
+
 static const struct of_device_id udma_of_match[] = {
 	{
 		.compatible = "ti,am654-navss-main-udmap",
@@ -3144,31 +3918,91 @@ static const struct of_device_id udma_of_match[] = {
 	{ /* Sentinel */ },
 };
 
+static const struct of_device_id bcdma_of_match[] = {
+	{
+		.compatible = "ti,am64-dmss-bcdma",
+		.data = &am64_bcdma_data,
+	},
+	{ /* Sentinel */ },
+};
+
 static struct udma_soc_data am654_soc_data = {
-	.rchan_oes_offset = 0x200,
+	.oes = {
+		.udma_rchan = 0x200,
+	},
 };
 
 static struct udma_soc_data j721e_soc_data = {
-	.rchan_oes_offset = 0x400,
+	.oes = {
+		.udma_rchan = 0x400,
+	},
 };
 
 static struct udma_soc_data j7200_soc_data = {
-	.rchan_oes_offset = 0x80,
+	.oes = {
+		.udma_rchan = 0x80,
+	},
+};
+
+static struct udma_soc_data am64_soc_data = {
+	.oes = {
+		.bcdma_bchan_data = 0x2200,
+		.bcdma_bchan_ring = 0x2400,
+		.bcdma_tchan_data = 0x2800,
+		.bcdma_tchan_ring = 0x2a00,
+		.bcdma_rchan_data = 0x2e00,
+		.bcdma_rchan_ring = 0x3000,
+	},
+	.bcdma_trigger_event_offset = 0xc400,
 };
 
 static const struct soc_device_attribute k3_soc_devices[] = {
 	{ .family = "AM65X", .data = &am654_soc_data },
 	{ .family = "J721E", .data = &j721e_soc_data },
 	{ .family = "J7200", .data = &j7200_soc_data },
+	{ .family = "AM64", .data = &am64_soc_data },
 	{ /* sentinel */ }
 };
 
 static int udma_get_mmrs(struct platform_device *pdev, struct udma_dev *ud)
 {
 	struct resource *res;
+	u32 cap2, cap3;
 	int i;
 
-	for (i = 0; i < MMR_LAST; i++) {
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+					   mmr_names[MMR_GCFG]);
+	ud->mmrs[MMR_GCFG] = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(ud->mmrs[MMR_GCFG]))
+		return PTR_ERR(ud->mmrs[MMR_GCFG]);
+
+	cap2 = udma_read(ud->mmrs[MMR_GCFG], 0x28);
+	cap3 = udma_read(ud->mmrs[MMR_GCFG], 0x2c);
+
+	switch (ud->match_data->type) {
+	case DMA_TYPE_UDMA:
+		ud->rflow_cnt = UDMA_CAP3_RFLOW_CNT(cap3);
+		ud->tchan_cnt = UDMA_CAP2_TCHAN_CNT(cap2);
+		ud->echan_cnt = UDMA_CAP2_ECHAN_CNT(cap2);
+		ud->rchan_cnt = UDMA_CAP2_RCHAN_CNT(cap2);
+		break;
+	case DMA_TYPE_BCDMA:
+		ud->bchan_cnt = BCDMA_CAP2_BCHAN_CNT(cap2);
+		ud->tchan_cnt = BCDMA_CAP2_TCHAN_CNT(cap2);
+		ud->rchan_cnt = BCDMA_CAP2_RCHAN_CNT(cap2);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	for (i = 1; i < MMR_LAST; i++) {
+		if (i == MMR_BCHANRT && ud->bchan_cnt == 0)
+			continue;
+		if (i == MMR_TCHANRT && ud->tchan_cnt == 0)
+			continue;
+		if (i == MMR_RCHANRT && ud->rchan_cnt == 0)
+			continue;
+
 		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 						   mmr_names[i]);
 		ud->mmrs[i] = devm_ioremap_resource(&pdev->dev, res);
@@ -3190,27 +4024,23 @@ static void udma_mark_resource_ranges(struct udma_dev *ud, unsigned long *map,
 		rm_desc->num_sec);
 }
 
+static const char * const range_names[] = {
+	[RM_RANGE_BCHAN] = "ti,sci-rm-range-bchan",
+	[RM_RANGE_TCHAN] = "ti,sci-rm-range-tchan",
+	[RM_RANGE_RCHAN] = "ti,sci-rm-range-rchan",
+	[RM_RANGE_RFLOW] = "ti,sci-rm-range-rflow"
+};
+
 static int udma_setup_resources(struct udma_dev *ud)
 {
+	int ret, i, j;
 	struct device *dev = ud->dev;
-	int ch_count, ret, i, j;
-	u32 cap2, cap3;
 	struct ti_sci_resource *rm_res, irq_res;
 	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
-	static const char * const range_names[] = { "ti,sci-rm-range-tchan",
-						    "ti,sci-rm-range-rchan",
-						    "ti,sci-rm-range-rflow" };
-
-	cap2 = udma_read(ud->mmrs[MMR_GCFG], UDMA_CAP_REG(2));
-	cap3 = udma_read(ud->mmrs[MMR_GCFG], UDMA_CAP_REG(3));
-
-	ud->rflow_cnt = UDMA_CAP3_RFLOW_CNT(cap3);
-	ud->tchan_cnt = UDMA_CAP2_TCHAN_CNT(cap2);
-	ud->echan_cnt = UDMA_CAP2_ECHAN_CNT(cap2);
-	ud->rchan_cnt = UDMA_CAP2_RCHAN_CNT(cap2);
-	ch_count  = ud->tchan_cnt + ud->rchan_cnt;
+	u32 cap3;
 
 	/* Set up the throughput level start indexes */
+	cap3 = udma_read(ud->mmrs[MMR_GCFG], 0x2c);
 	if (of_device_is_compatible(dev->of_node,
 				    "ti,am654-navss-main-udmap")) {
 		ud->tpl_levels = 2;
@@ -3268,11 +4098,15 @@ static int udma_setup_resources(struct udma_dev *ud)
 	bitmap_set(ud->rflow_gp_map, 0, ud->rflow_cnt);
 
 	/* Get resource ranges from tisci */
-	for (i = 0; i < RM_RANGE_LAST; i++)
+	for (i = 0; i < RM_RANGE_LAST; i++) {
+		if (i == RM_RANGE_BCHAN)
+			continue;
+
 		tisci_rm->rm_ranges[i] =
 			devm_ti_sci_get_of_resource(tisci_rm->tisci, dev,
 						    tisci_rm->tisci_dev_id,
 						    (char *)range_names[i]);
+	}
 
 	/* tchan ranges */
 	rm_res = tisci_rm->rm_ranges[RM_RANGE_TCHAN];
@@ -3310,12 +4144,12 @@ static int udma_setup_resources(struct udma_dev *ud)
 	for (j = 0; j < rm_res->sets; j++, i++) {
 		if (rm_res->desc[j].num) {
 			irq_res.desc[i].start = rm_res->desc[j].start +
-					ud->soc_data->rchan_oes_offset;
+					ud->soc_data->oes.udma_rchan;
 			irq_res.desc[i].num = rm_res->desc[j].num;
 		}
 		if (rm_res->desc[j].num_sec) {
 			irq_res.desc[i].start_sec = rm_res->desc[j].start_sec +
-					ud->soc_data->rchan_oes_offset;
+					ud->soc_data->oes.udma_rchan;
 			irq_res.desc[i].num_sec = rm_res->desc[j].num_sec;
 		}
 	}
@@ -3338,6 +4172,174 @@ static int udma_setup_resources(struct udma_dev *ud)
 						  &rm_res->desc[i], "gp-rflow");
 	}
 
+	return 0;
+}
+
+static int bcdma_setup_resources(struct udma_dev *ud)
+{
+	int ret, i, j;
+	struct device *dev = ud->dev;
+	struct ti_sci_resource *rm_res, irq_res;
+	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
+	const struct udma_oes_offsets *oes = &ud->soc_data->oes;
+
+	ud->bchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->bchan_cnt),
+					   sizeof(unsigned long), GFP_KERNEL);
+	ud->bchans = devm_kcalloc(dev, ud->bchan_cnt, sizeof(*ud->bchans),
+				  GFP_KERNEL);
+	ud->tchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->tchan_cnt),
+					   sizeof(unsigned long), GFP_KERNEL);
+	ud->tchans = devm_kcalloc(dev, ud->tchan_cnt, sizeof(*ud->tchans),
+				  GFP_KERNEL);
+	ud->rchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->rchan_cnt),
+					   sizeof(unsigned long), GFP_KERNEL);
+	ud->rchans = devm_kcalloc(dev, ud->rchan_cnt, sizeof(*ud->rchans),
+				  GFP_KERNEL);
+	/* BCDMA do not really have flows, but the driver expect it */
+	ud->rflow_in_use = devm_kcalloc(dev, BITS_TO_LONGS(ud->rchan_cnt),
+					sizeof(unsigned long),
+					GFP_KERNEL);
+	ud->rflows = devm_kcalloc(dev, ud->rchan_cnt, sizeof(*ud->rflows),
+				  GFP_KERNEL);
+
+	if (!ud->bchan_map || !ud->tchan_map || !ud->rchan_map ||
+	    !ud->rflow_in_use || !ud->bchans || !ud->tchans || !ud->rchans ||
+	    !ud->rflows)
+		return -ENOMEM;
+
+	/* TPL is not yet supported for BCDMA */
+	ud->tpl_levels = 1;
+
+	/* Get resource ranges from tisci */
+	for (i = 0; i < RM_RANGE_LAST; i++) {
+		if (i == RM_RANGE_RFLOW)
+			continue;
+		if (i == RM_RANGE_BCHAN && ud->bchan_cnt == 0)
+			continue;
+		if (i == RM_RANGE_TCHAN && ud->tchan_cnt == 0)
+			continue;
+		if (i == RM_RANGE_RCHAN && ud->rchan_cnt == 0)
+			continue;
+
+		tisci_rm->rm_ranges[i] =
+			devm_ti_sci_get_of_resource(tisci_rm->tisci, dev,
+						    tisci_rm->tisci_dev_id,
+						    (char *)range_names[i]);
+	}
+
+	irq_res.sets = 0;
+
+	/* bchan ranges */
+	if (ud->bchan_cnt) {
+		rm_res = tisci_rm->rm_ranges[RM_RANGE_BCHAN];
+		if (IS_ERR(rm_res)) {
+			bitmap_zero(ud->bchan_map, ud->bchan_cnt);
+		} else {
+			bitmap_fill(ud->bchan_map, ud->bchan_cnt);
+			for (i = 0; i < rm_res->sets; i++)
+				udma_mark_resource_ranges(ud, ud->bchan_map,
+							  &rm_res->desc[i],
+							  "bchan");
+		}
+		irq_res.sets += rm_res->sets;
+	}
+
+	/* tchan ranges */
+	if (ud->tchan_cnt) {
+		rm_res = tisci_rm->rm_ranges[RM_RANGE_TCHAN];
+		if (IS_ERR(rm_res)) {
+			bitmap_zero(ud->tchan_map, ud->tchan_cnt);
+		} else {
+			bitmap_fill(ud->tchan_map, ud->tchan_cnt);
+			for (i = 0; i < rm_res->sets; i++)
+				udma_mark_resource_ranges(ud, ud->tchan_map,
+							  &rm_res->desc[i],
+							  "tchan");
+		}
+		irq_res.sets += rm_res->sets * 2;
+	}
+
+	/* rchan ranges */
+	if (ud->rchan_cnt) {
+		rm_res = tisci_rm->rm_ranges[RM_RANGE_RCHAN];
+		if (IS_ERR(rm_res)) {
+			bitmap_zero(ud->rchan_map, ud->rchan_cnt);
+		} else {
+			bitmap_fill(ud->rchan_map, ud->rchan_cnt);
+			for (i = 0; i < rm_res->sets; i++)
+				udma_mark_resource_ranges(ud, ud->rchan_map,
+							  &rm_res->desc[i],
+							  "rchan");
+		}
+		irq_res.sets += rm_res->sets * 2;
+	}
+
+	irq_res.desc = kcalloc(irq_res.sets, sizeof(*irq_res.desc), GFP_KERNEL);
+	if (ud->bchan_cnt) {
+		rm_res = tisci_rm->rm_ranges[RM_RANGE_BCHAN];
+		for (i = 0; i < rm_res->sets; i++) {
+			irq_res.desc[i].start = rm_res->desc[i].start +
+						oes->bcdma_bchan_ring;
+			irq_res.desc[i].num = rm_res->desc[i].num;
+		}
+	}
+	if (ud->tchan_cnt) {
+		rm_res = tisci_rm->rm_ranges[RM_RANGE_TCHAN];
+		for (j = 0; j < rm_res->sets; j++, i += 2) {
+			irq_res.desc[i].start = rm_res->desc[j].start +
+						oes->bcdma_tchan_data;
+			irq_res.desc[i].num = rm_res->desc[j].num;
+
+			irq_res.desc[i + 1].start = rm_res->desc[j].start +
+						oes->bcdma_tchan_ring;
+			irq_res.desc[i + 1].num = rm_res->desc[j].num;
+		}
+	}
+	if (ud->rchan_cnt) {
+		rm_res = tisci_rm->rm_ranges[RM_RANGE_RCHAN];
+		for (j = 0; j < rm_res->sets; j++, i += 2) {
+			irq_res.desc[i].start = rm_res->desc[j].start +
+						oes->bcdma_rchan_data;
+			irq_res.desc[i].num = rm_res->desc[j].num;
+
+			irq_res.desc[i + 1].start = rm_res->desc[j].start +
+						oes->bcdma_rchan_ring;
+			irq_res.desc[i + 1].num = rm_res->desc[j].num;
+		}
+	}
+
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
+static int setup_resources(struct udma_dev *ud)
+{
+	struct device *dev = ud->dev;
+	int ch_count, ret;
+
+	switch (ud->match_data->type) {
+	case DMA_TYPE_UDMA:
+		ret = udma_setup_resources(ud);
+		break;
+	case DMA_TYPE_BCDMA:
+		ret = bcdma_setup_resources(ud);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (ret)
+		return ret;
+
+	ch_count  = ud->bchan_cnt + ud->tchan_cnt + ud->rchan_cnt;
+	if (ud->bchan_cnt)
+		ch_count -= bitmap_weight(ud->bchan_map, ud->bchan_cnt);
 	ch_count -= bitmap_weight(ud->tchan_map, ud->tchan_cnt);
 	ch_count -= bitmap_weight(ud->rchan_map, ud->rchan_cnt);
 	if (!ch_count)
@@ -3348,12 +4350,32 @@ static int udma_setup_resources(struct udma_dev *ud)
 	if (!ud->channels)
 		return -ENOMEM;
 
-	dev_info(dev, "Channels: %d (tchan: %u, rchan: %u, gp-rflow: %u)\n",
-		 ch_count,
-		 ud->tchan_cnt - bitmap_weight(ud->tchan_map, ud->tchan_cnt),
-		 ud->rchan_cnt - bitmap_weight(ud->rchan_map, ud->rchan_cnt),
-		 ud->rflow_cnt - bitmap_weight(ud->rflow_gp_map,
-					       ud->rflow_cnt));
+	switch (ud->match_data->type) {
+	case DMA_TYPE_UDMA:
+		dev_info(dev,
+			 "Channels: %d (tchan: %u, rchan: %u, gp-rflow: %u)\n",
+			 ch_count,
+			 ud->tchan_cnt - bitmap_weight(ud->tchan_map,
+						       ud->tchan_cnt),
+			 ud->rchan_cnt - bitmap_weight(ud->rchan_map,
+						       ud->rchan_cnt),
+			 ud->rflow_cnt - bitmap_weight(ud->rflow_gp_map,
+						       ud->rflow_cnt));
+		break;
+	case DMA_TYPE_BCDMA:
+		dev_info(dev,
+			 "Channels: %d (bchan: %u, tchan: %u, rchan: %u)\n",
+			 ch_count,
+			 ud->bchan_cnt - bitmap_weight(ud->bchan_map,
+						       ud->bchan_cnt),
+			 ud->tchan_cnt - bitmap_weight(ud->tchan_map,
+						       ud->tchan_cnt),
+			 ud->rchan_cnt - bitmap_weight(ud->rchan_map,
+						       ud->rchan_cnt));
+		break;
+	default:
+		break;
+	}
 
 	return ch_count;
 }
@@ -3462,10 +4484,19 @@ static void udma_dbg_summary_show_chan(struct seq_file *s,
 
 	seq_printf(s, " %-13s| %s", dma_chan_name(chan),
 		   chan->dbg_client_name ?: "in-use");
-	seq_printf(s, " (%s, ", dmaengine_get_direction_text(uc->config.dir));
+	if (ucc->tr_trigger_type)
+		seq_puts(s, " (triggered, ");
+	else
+		seq_printf(s, " (%s, ",
+			   dmaengine_get_direction_text(uc->config.dir));
 
 	switch (uc->config.dir) {
 	case DMA_MEM_TO_MEM:
+		if (uc->ud->match_data->type == DMA_TYPE_BCDMA) {
+			seq_printf(s, "bchan%d)\n", uc->bchan->id);
+			return;
+		}
+
 		seq_printf(s, "chan%d pair [0x%04x -> 0x%04x], ", uc->tchan->id,
 			   ucc->src_thread, ucc->dst_thread);
 		break;
@@ -3537,6 +4568,23 @@ static int udma_probe(struct platform_device *pdev)
 	if (!ud)
 		return -ENOMEM;
 
+	match = of_match_node(udma_of_match, dev->of_node);
+	if (!match) {
+		match = of_match_node(bcdma_of_match, dev->of_node);
+		if (!match) {
+			dev_err(dev, "No compatible match found\n");
+			return -ENODEV;
+		}
+	}
+	ud->match_data = match->data;
+
+	soc = soc_device_match(k3_soc_devices);
+	if (!soc) {
+		dev_err(dev, "No compatible SoC found\n");
+		return -ENODEV;
+	}
+	ud->soc_data = soc->data;
+
 	ret = udma_get_mmrs(pdev, ud);
 	if (ret)
 		return ret;
@@ -3560,16 +4608,38 @@ static int udma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = of_property_read_u32(dev->of_node, "ti,udma-atype", &ud->atype);
-	if (!ret && ud->atype > 2) {
-		dev_err(dev, "Invalid atype: %u\n", ud->atype);
-		return -EINVAL;
+	if (ud->match_data->type == DMA_TYPE_UDMA) {
+		ret = of_property_read_u32(dev->of_node, "ti,udma-atype",
+					   &ud->atype);
+		if (!ret && ud->atype > 2) {
+			dev_err(dev, "Invalid atype: %u\n", ud->atype);
+			return -EINVAL;
+		}
+	} else {
+		ret = of_property_read_u32(dev->of_node, "ti,asel",
+					   &ud->asel);
+		if (!ret && ud->asel > 15) {
+			dev_err(dev, "Invalid asel: %u\n", ud->asel);
+			return -EINVAL;
+		}
 	}
 
 	ud->tisci_rm.tisci_udmap_ops = &ud->tisci_rm.tisci->ops.rm_udmap_ops;
 	ud->tisci_rm.tisci_psil_ops = &ud->tisci_rm.tisci->ops.rm_psil_ops;
 
-	ud->ringacc = of_k3_ringacc_get_by_phandle(dev->of_node, "ti,ringacc");
+	if (ud->match_data->type == DMA_TYPE_UDMA) {
+		ud->ringacc = of_k3_ringacc_get_by_phandle(dev->of_node, "ti,ringacc");
+	} else {
+		struct k3_ringacc_init_data ring_init_data;
+
+		ring_init_data.tisci = ud->tisci_rm.tisci;
+		ring_init_data.tisci_dev_id = ud->tisci_rm.tisci_dev_id;
+		ring_init_data.num_rings = ud->bchan_cnt + ud->tchan_cnt +
+					   ud->rchan_cnt;
+
+		ud->ringacc = k3_ringacc_dmarings_init(pdev, &ring_init_data);
+	}
+
 	if (IS_ERR(ud->ringacc))
 		return PTR_ERR(ud->ringacc);
 
@@ -3580,24 +4650,9 @@ static int udma_probe(struct platform_device *pdev)
 		return -EPROBE_DEFER;
 	}
 
-	match = of_match_node(udma_of_match, dev->of_node);
-	if (!match) {
-		dev_err(dev, "No compatible match found\n");
-		return -ENODEV;
-	}
-	ud->match_data = match->data;
-
-	soc = soc_device_match(k3_soc_devices);
-	if (!soc) {
-		dev_err(dev, "No compatible SoC found\n");
-		return -ENODEV;
-	}
-	ud->soc_data = soc->data;
-
 	dma_cap_set(DMA_SLAVE, ud->ddev.cap_mask);
 	dma_cap_set(DMA_CYCLIC, ud->ddev.cap_mask);
 
-	ud->ddev.device_alloc_chan_resources = udma_alloc_chan_resources;
 	ud->ddev.device_config = udma_slave_config;
 	ud->ddev.device_prep_slave_sg = udma_prep_slave_sg;
 	ud->ddev.device_prep_dma_cyclic = udma_prep_dma_cyclic;
@@ -3611,7 +4666,21 @@ static int udma_probe(struct platform_device *pdev)
 	ud->ddev.dbg_summary_show = udma_dbg_summary_show;
 #endif
 
+	switch (ud->match_data->type) {
+	case DMA_TYPE_UDMA:
+		ud->ddev.device_alloc_chan_resources =
+					udma_alloc_chan_resources;
+		break;
+	case DMA_TYPE_BCDMA:
+		ud->ddev.device_alloc_chan_resources =
+					bcdma_alloc_chan_resources;
+		ud->ddev.device_router_config = bcdma_router_config;
+		break;
+	default:
+		return -EINVAL;
+	}
 	ud->ddev.device_free_chan_resources = udma_free_chan_resources;
+
 	ud->ddev.src_addr_widths = TI_UDMAC_BUSWIDTHS;
 	ud->ddev.dst_addr_widths = TI_UDMAC_BUSWIDTHS;
 	ud->ddev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
@@ -3619,7 +4688,8 @@ static int udma_probe(struct platform_device *pdev)
 	ud->ddev.copy_align = DMAENGINE_ALIGN_8_BYTES;
 	ud->ddev.desc_metadata_modes = DESC_METADATA_CLIENT |
 				       DESC_METADATA_ENGINE;
-	if (ud->match_data->enable_memcpy_support) {
+	if (ud->match_data->enable_memcpy_support &&
+	    !(ud->match_data->type == DMA_TYPE_BCDMA && ud->bchan_cnt == 0)) {
 		dma_cap_set(DMA_MEMCPY, ud->ddev.cap_mask);
 		ud->ddev.device_prep_dma_memcpy = udma_prep_dma_memcpy;
 		ud->ddev.directions |= BIT(DMA_MEM_TO_MEM);
@@ -3632,7 +4702,7 @@ static int udma_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&ud->ddev.channels);
 	INIT_LIST_HEAD(&ud->desc_to_purge);
 
-	ch_count = udma_setup_resources(ud);
+	ch_count = setup_resources(ud);
 	if (ch_count <= 0)
 		return ch_count;
 
@@ -3647,6 +4717,13 @@ static int udma_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	for (i = 0; i < ud->bchan_cnt; i++) {
+		struct udma_bchan *bchan = &ud->bchans[i];
+
+		bchan->id = i;
+		bchan->reg_rt = ud->mmrs[MMR_BCHANRT] + i * 0x1000;
+	}
+
 	for (i = 0; i < ud->tchan_cnt; i++) {
 		struct udma_tchan *tchan = &ud->tchans[i];
 
@@ -3673,6 +4750,7 @@ static int udma_probe(struct platform_device *pdev)
 		uc->ud = ud;
 		uc->vc.desc_free = udma_desc_free;
 		uc->id = i;
+		uc->bchan = NULL;
 		uc->tchan = NULL;
 		uc->rchan = NULL;
 		uc->config.remote_thread_id = -1;
@@ -3715,5 +4793,15 @@ static struct platform_driver udma_driver = {
 };
 builtin_platform_driver(udma_driver);
 
+static struct platform_driver bcdma_driver = {
+	.driver = {
+		.name	= "ti-bcdma",
+		.of_match_table = bcdma_of_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe		= udma_probe,
+};
+builtin_platform_driver(bcdma_driver);
+
 /* Private interfaces to UDMA */
 #include "k3-udma-private.c"
diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
index d1cace0cb43b..bf78ad94354a 100644
--- a/drivers/dma/ti/k3-udma.h
+++ b/drivers/dma/ti/k3-udma.h
@@ -18,7 +18,7 @@
 #define UDMA_RX_FLOW_ID_FW_OES_REG	0x80
 #define UDMA_RX_FLOW_ID_FW_STATUS_REG	0x88
 
-/* TCHANRT/RCHANRT registers */
+/* BCHANRT/TCHANRT/RCHANRT registers */
 #define UDMA_CHAN_RT_CTL_REG		0x0
 #define UDMA_CHAN_RT_SWTRIG_REG		0x8
 #define UDMA_CHAN_RT_STDATA_REG		0x80
@@ -45,6 +45,10 @@
 #define UDMA_CAP3_HCHAN_CNT(val)	(((val) >> 14) & 0x1ff)
 #define UDMA_CAP3_UCHAN_CNT(val)	(((val) >> 23) & 0x1ff)
 
+#define BCDMA_CAP2_BCHAN_CNT(val)	((val) & 0x1ff)
+#define BCDMA_CAP2_TCHAN_CNT(val)	(((val) >> 9) & 0x1ff)
+#define BCDMA_CAP2_RCHAN_CNT(val)	(((val) >> 18) & 0x1ff)
+
 /* UDMA_CHAN_RT_CTL_REG */
 #define UDMA_CHAN_RT_CTL_EN		BIT(31)
 #define UDMA_CHAN_RT_CTL_TDOWN		BIT(30)
@@ -82,13 +86,17 @@
  */
 #define PDMA_STATIC_TR_Z(x, mask)	((x) & (mask))
 
+/* Address Space Select */
+#define K3_ADDRESS_ASEL_SHIFT		48
+
 struct udma_dev;
 struct udma_tchan;
 struct udma_rchan;
 struct udma_rflow;
 
 enum udma_rm_range {
-	RM_RANGE_TCHAN = 0,
+	RM_RANGE_BCHAN = 0,
+	RM_RANGE_TCHAN,
 	RM_RANGE_RCHAN,
 	RM_RANGE_RFLOW,
 	RM_RANGE_LAST,
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

