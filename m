Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF3F27A48A
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jul 2019 11:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbfG3Jgk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Jul 2019 05:36:40 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58612 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731547AbfG3JgB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Jul 2019 05:36:01 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6U9ZqHl060051;
        Tue, 30 Jul 2019 04:35:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1564479352;
        bh=AyEZ4iZajnfl7x+165XabqDdHdIOP3AV4K+iesTBVmw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dOhK6Qwx7O5MZb+otpZQRH0LQxEivUaQRzOBf44l+bfmoMdGCNHRGzwcBIMjaMc7/
         r9A5ugWwQfAZLon/BIvOEKV5mTpR9XZg4BGh5n2Gce1JHgkrDHxgoVAOGM5FpONCfx
         bea+w/lWEMmAlfQlJKKSfc0nrRGrvqPabYYLt8xc=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6U9Zqfg054620
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Jul 2019 04:35:52 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 30
 Jul 2019 04:35:51 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 30 Jul 2019 04:35:51 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6U9YkU7027547;
        Tue, 30 Jul 2019 04:35:48 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
Subject: [PATCH v2 10/14] dmaengine: ti: New driver for K3 UDMA - split#3: alloc/free chan_resources
Date:   Tue, 30 Jul 2019 12:34:46 +0300
Message-ID: <20190730093450.12664-11-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730093450.12664-1-peter.ujfalusi@ti.com>
References: <20190730093450.12664-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Split patch for review containing: channel rsource allocation and free
functions.

DMA driver for
Texas Instruments K3 NAVSS Unified DMA – Peripheral Root Complex (UDMA-P)

The UDMA-P is intended to perform similar (but significantly upgraded) functions
as the packet-oriented DMA used on previous SoC devices. The UDMA-P module
supports the transmission and reception of various packet types. The UDMA-P is
architected to facilitate the segmentation and reassembly of SoC DMA data
structure compliant packets to/from smaller data blocks that are natively
compatible with the specific requirements of each connected peripheral. Multiple
Tx and Rx channels are provided within the DMA which allow multiple segmentation
or reassembly operations to be ongoing. The DMA controller maintains state
information for each of the channels which allows packet segmentation and
reassembly operations to be time division multiplexed between channels in order
to share the underlying DMA hardware. An external DMA scheduler is used to
control the ordering and rate at which this multiplexing occurs for Transmit
operations. The ordering and rate of Receive operations is indirectly controlled
by the order in which blocks are pushed into the DMA on the Rx PSI-L interface.

The UDMA-P also supports acting as both a UTC and UDMA-C for its internal
channels. Channels in the UDMA-P can be configured to be either Packet-Based or
Third-Party channels on a channel by channel basis.

The initial driver supports:
- MEM_TO_MEM (TR mode)
- DEV_TO_MEM (Packet / TR mode)
- MEM_TO_DEV (Packet / TR mode)
- Cyclic (Packet / TR mode)
- Metadata for descriptors

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 780 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 780 insertions(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 52ccc6d46de9..0de38db03b8d 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -1039,6 +1039,786 @@ static irqreturn_t udma_udma_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static struct udma_rflow *__udma_reserve_rflow(struct udma_dev *ud,
+					       enum udma_tp_level tpl, int id)
+{
+	DECLARE_BITMAP(tmp, K3_UDMA_MAX_RFLOWS);
+
+	if (id >= 0) {
+		if (test_bit(id, ud->rflow_map)) {
+			dev_err(ud->dev, "rflow%d is in use\n", id);
+			return ERR_PTR(-ENOENT);
+		}
+	} else {
+		bitmap_or(tmp, ud->rflow_map, ud->rflow_map_reserved,
+			  ud->rflow_cnt);
+
+		id = find_next_zero_bit(tmp, ud->rflow_cnt, ud->rchan_cnt);
+		if (id >= ud->rflow_cnt)
+			return ERR_PTR(-ENOENT);
+	}
+
+	set_bit(id, ud->rflow_map);
+	return &ud->rflows[id];
+}
+
+#define UDMA_RESERVE_RESOURCE(res)					\
+static struct udma_##res *__udma_reserve_##res(struct udma_dev *ud,	\
+					       enum udma_tp_level tpl,	\
+					       int id)			\
+{									\
+	if (id >= 0) {							\
+		if (test_bit(id, ud->res##_map)) {			\
+			dev_err(ud->dev, "res##%d is in use\n", id);	\
+			return ERR_PTR(-ENOENT);			\
+		}							\
+	} else {							\
+		int start;						\
+									\
+		if (tpl >= ud->match_data->tpl_levels)			\
+			tpl = ud->match_data->tpl_levels - 1;		\
+									\
+		start = ud->match_data->level_start_idx[tpl];		\
+									\
+		id = find_next_zero_bit(ud->res##_map, ud->res##_cnt,	\
+					start);				\
+		if (id == ud->res##_cnt) {				\
+			return ERR_PTR(-ENOENT);			\
+		}							\
+	}								\
+									\
+	set_bit(id, ud->res##_map);					\
+	return &ud->res##s[id];						\
+}
+
+UDMA_RESERVE_RESOURCE(tchan);
+UDMA_RESERVE_RESOURCE(rchan);
+
+static int udma_get_tchan(struct udma_chan *uc)
+{
+	struct udma_dev *ud = uc->ud;
+
+	if (uc->tchan) {
+		dev_dbg(ud->dev, "chan%d: already have tchan%d allocated\n",
+			uc->id, uc->tchan->id);
+		return 0;
+	}
+
+	uc->tchan = __udma_reserve_tchan(ud, uc->channel_tpl, -1);
+	if (IS_ERR(uc->tchan))
+		return PTR_ERR(uc->tchan);
+
+	return 0;
+}
+
+static int udma_get_rchan(struct udma_chan *uc)
+{
+	struct udma_dev *ud = uc->ud;
+
+	if (uc->rchan) {
+		dev_dbg(ud->dev, "chan%d: already have rchan%d allocated\n",
+			uc->id, uc->rchan->id);
+		return 0;
+	}
+
+	uc->rchan = __udma_reserve_rchan(ud, uc->channel_tpl, -1);
+	if (IS_ERR(uc->rchan))
+		return PTR_ERR(uc->rchan);
+
+	return 0;
+}
+
+static int udma_get_chan_pair(struct udma_chan *uc)
+{
+	struct udma_dev *ud = uc->ud;
+	const struct udma_match_data *match_data = ud->match_data;
+	int chan_id, end;
+
+	if ((uc->tchan && uc->rchan) && uc->tchan->id == uc->rchan->id) {
+		dev_info(ud->dev, "chan%d: already have %d pair allocated\n",
+			 uc->id, uc->tchan->id);
+		return 0;
+	}
+
+	if (uc->tchan) {
+		dev_err(ud->dev, "chan%d: already have tchan%d allocated\n",
+			uc->id, uc->tchan->id);
+		return -EBUSY;
+	} else if (uc->rchan) {
+		dev_err(ud->dev, "chan%d: already have rchan%d allocated\n",
+			uc->id, uc->rchan->id);
+		return -EBUSY;
+	}
+
+	/* Can be optimized, but let's have it like this for now */
+	end = min(ud->tchan_cnt, ud->rchan_cnt);
+	/* Try to use the highest TPL channel pair for MEM_TO_MEM channels */
+	chan_id = match_data->level_start_idx[match_data->tpl_levels - 1];
+	for (; chan_id < end; chan_id++) {
+		if (!test_bit(chan_id, ud->tchan_map) &&
+		    !test_bit(chan_id, ud->rchan_map))
+			break;
+	}
+
+	if (chan_id == end)
+		return -ENOENT;
+
+	set_bit(chan_id, ud->tchan_map);
+	set_bit(chan_id, ud->rchan_map);
+	uc->tchan = &ud->tchans[chan_id];
+	uc->rchan = &ud->rchans[chan_id];
+
+	return 0;
+}
+
+static int udma_get_rflow(struct udma_chan *uc, int flow_id)
+{
+	struct udma_dev *ud = uc->ud;
+
+	if (uc->rflow) {
+		dev_dbg(ud->dev, "chan%d: already have rflow%d allocated\n",
+			uc->id, uc->rflow->id);
+		return 0;
+	}
+
+	if (!uc->rchan)
+		dev_warn(ud->dev, "chan%d: does not have rchan??\n", uc->id);
+
+	uc->rflow = __udma_reserve_rflow(ud, uc->channel_tpl, flow_id);
+	if (IS_ERR(uc->rflow))
+		return PTR_ERR(uc->rflow);
+
+	return 0;
+}
+
+static void udma_put_rchan(struct udma_chan *uc)
+{
+	struct udma_dev *ud = uc->ud;
+
+	if (uc->rchan) {
+		dev_dbg(ud->dev, "chan%d: put rchan%d\n", uc->id,
+			uc->rchan->id);
+		clear_bit(uc->rchan->id, ud->rchan_map);
+		uc->rchan = NULL;
+	}
+}
+
+static void udma_put_tchan(struct udma_chan *uc)
+{
+	struct udma_dev *ud = uc->ud;
+
+	if (uc->tchan) {
+		dev_dbg(ud->dev, "chan%d: put tchan%d\n", uc->id,
+			uc->tchan->id);
+		clear_bit(uc->tchan->id, ud->tchan_map);
+		uc->tchan = NULL;
+	}
+}
+
+static void udma_put_rflow(struct udma_chan *uc)
+{
+	struct udma_dev *ud = uc->ud;
+
+	if (uc->rflow) {
+		dev_dbg(ud->dev, "chan%d: put rflow%d\n", uc->id,
+			uc->rflow->id);
+		clear_bit(uc->rflow->id, ud->rflow_map);
+		uc->rflow = NULL;
+	}
+}
+
+static void udma_free_tx_resources(struct udma_chan *uc)
+{
+	if (!uc->tchan)
+		return;
+
+	k3_ringacc_ring_free(uc->tchan->t_ring);
+	k3_ringacc_ring_free(uc->tchan->tc_ring);
+	uc->tchan->t_ring = NULL;
+	uc->tchan->tc_ring = NULL;
+
+	udma_put_tchan(uc);
+}
+
+static int udma_alloc_tx_resources(struct udma_chan *uc)
+{
+	struct k3_ring_cfg ring_cfg;
+	struct udma_dev *ud = uc->ud;
+	int ret;
+
+	ret = udma_get_tchan(uc);
+	if (ret)
+		return ret;
+
+	uc->tchan->t_ring = k3_ringacc_request_ring(ud->ringacc,
+						    uc->tchan->id, 0);
+	if (!uc->tchan->t_ring) {
+		ret = -EBUSY;
+		goto err_tx_ring;
+	}
+
+	uc->tchan->tc_ring = k3_ringacc_request_ring(ud->ringacc, -1, 0);
+	if (!uc->tchan->tc_ring) {
+		ret = -EBUSY;
+		goto err_txc_ring;
+	}
+
+	memset(&ring_cfg, 0, sizeof(ring_cfg));
+	ring_cfg.size = K3_UDMA_DEFAULT_RING_SIZE;
+	ring_cfg.elm_size = K3_RINGACC_RING_ELSIZE_8;
+	ring_cfg.mode = K3_RINGACC_RING_MODE_MESSAGE;
+
+	ret = k3_ringacc_ring_cfg(uc->tchan->t_ring, &ring_cfg);
+	ret |= k3_ringacc_ring_cfg(uc->tchan->tc_ring, &ring_cfg);
+
+	if (ret)
+		goto err_ringcfg;
+
+	return 0;
+
+err_ringcfg:
+	k3_ringacc_ring_free(uc->tchan->tc_ring);
+	uc->tchan->tc_ring = NULL;
+err_txc_ring:
+	k3_ringacc_ring_free(uc->tchan->t_ring);
+	uc->tchan->t_ring = NULL;
+err_tx_ring:
+	udma_put_tchan(uc);
+
+	return ret;
+}
+
+static void udma_free_rx_resources(struct udma_chan *uc)
+{
+	if (!uc->rchan)
+		return;
+
+	if (uc->dir != DMA_MEM_TO_MEM) {
+		k3_ringacc_ring_free(uc->rchan->fd_ring);
+		k3_ringacc_ring_free(uc->rchan->r_ring);
+		uc->rchan->fd_ring = NULL;
+		uc->rchan->r_ring = NULL;
+
+		udma_put_rflow(uc);
+	}
+
+	udma_put_rchan(uc);
+}
+
+static int udma_alloc_rx_resources(struct udma_chan *uc)
+{
+	struct k3_ring_cfg ring_cfg;
+	struct udma_dev *ud = uc->ud;
+	int fd_ring_id;
+	int ret;
+
+	ret = udma_get_rchan(uc);
+	if (ret)
+		return ret;
+
+	/* For MEM_TO_MEM we don't need rflow or rings */
+	if (uc->dir == DMA_MEM_TO_MEM)
+		return 0;
+
+	ret = udma_get_rflow(uc, uc->rchan->id);
+	if (ret) {
+		ret = -EBUSY;
+		goto err_rflow;
+	}
+
+	fd_ring_id = ud->tchan_cnt + ud->echan_cnt + uc->rchan->id;
+	uc->rchan->fd_ring = k3_ringacc_request_ring(ud->ringacc,
+						     fd_ring_id, 0);
+	if (!uc->rchan->fd_ring) {
+		ret = -EBUSY;
+		goto err_rx_ring;
+	}
+
+	uc->rchan->r_ring = k3_ringacc_request_ring(ud->ringacc, -1, 0);
+	if (!uc->rchan->r_ring) {
+		ret = -EBUSY;
+		goto err_rxc_ring;
+	}
+
+	memset(&ring_cfg, 0, sizeof(ring_cfg));
+
+	if (uc->pkt_mode)
+		ring_cfg.size = SG_MAX_SEGMENTS;
+	else
+		ring_cfg.size = K3_UDMA_DEFAULT_RING_SIZE;
+
+	ring_cfg.elm_size = K3_RINGACC_RING_ELSIZE_8;
+	ring_cfg.mode = K3_RINGACC_RING_MODE_MESSAGE;
+
+	ret = k3_ringacc_ring_cfg(uc->rchan->fd_ring, &ring_cfg);
+	ring_cfg.size = K3_UDMA_DEFAULT_RING_SIZE;
+	ret |= k3_ringacc_ring_cfg(uc->rchan->r_ring, &ring_cfg);
+
+	if (ret)
+		goto err_ringcfg;
+
+	return 0;
+
+err_ringcfg:
+	k3_ringacc_ring_free(uc->rchan->r_ring);
+	uc->rchan->r_ring = NULL;
+err_rxc_ring:
+	k3_ringacc_ring_free(uc->rchan->fd_ring);
+	uc->rchan->fd_ring = NULL;
+err_rx_ring:
+	udma_put_rflow(uc);
+err_rflow:
+	udma_put_rchan(uc);
+
+	return ret;
+}
+
+static int udma_tisci_channel_config(struct udma_chan *uc)
+{
+	struct udma_dev *ud = uc->ud;
+	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
+	const struct ti_sci_rm_udmap_ops *tisci_ops = tisci_rm->tisci_udmap_ops;
+	struct udma_tchan *tchan = uc->tchan;
+	struct udma_rchan *rchan = uc->rchan;
+	int ret = 0;
+
+	if (uc->dir == DMA_MEM_TO_MEM) {
+		/* Non synchronized - mem to mem type of transfer */
+		int tc_ring = k3_ringacc_get_ring_id(tchan->tc_ring);
+		struct ti_sci_msg_rm_udmap_tx_ch_cfg req_tx = { 0 };
+		struct ti_sci_msg_rm_udmap_rx_ch_cfg req_rx = { 0 };
+
+		req_tx.valid_params =
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_FILT_EINFO_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_FILT_PSWORDS_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_CHAN_TYPE_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_SUPR_TDPKT_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_FETCH_SIZE_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_CQ_QNUM_VALID;
+
+		req_tx.nav_id = tisci_rm->tisci_dev_id;
+		req_tx.index = tchan->id;
+		req_tx.tx_pause_on_err = 0;
+		req_tx.tx_filt_einfo = 0;
+		req_tx.tx_filt_pswords = 0;
+		req_tx.tx_chan_type = TI_SCI_RM_UDMAP_CHAN_TYPE_3RDP_BCOPY_PBRR;
+		req_tx.tx_supr_tdpkt = 0;
+		req_tx.tx_fetch_size = sizeof(struct cppi5_desc_hdr_t) >> 2;
+		req_tx.txcq_qnum = tc_ring;
+
+		ret = tisci_ops->tx_ch_cfg(tisci_rm->tisci, &req_tx);
+		if (ret) {
+			dev_err(ud->dev, "tchan%d cfg failed %d\n",
+				tchan->id, ret);
+			return ret;
+		}
+
+		req_rx.valid_params =
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_FETCH_SIZE_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_CQ_QNUM_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_CHAN_TYPE_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_IGNORE_SHORT_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_IGNORE_LONG_VALID;
+
+		req_rx.nav_id = tisci_rm->tisci_dev_id;
+		req_rx.index = rchan->id;
+		req_rx.rx_fetch_size = sizeof(struct cppi5_desc_hdr_t) >> 2;
+		req_rx.rxcq_qnum = tc_ring;
+		req_rx.rx_pause_on_err = 0;
+		req_rx.rx_chan_type = TI_SCI_RM_UDMAP_CHAN_TYPE_3RDP_BCOPY_PBRR;
+		req_rx.rx_ignore_short = 0;
+		req_rx.rx_ignore_long = 0;
+
+		ret = tisci_ops->rx_ch_cfg(tisci_rm->tisci, &req_rx);
+		if (ret) {
+			dev_err(ud->dev, "rchan%d alloc failed %d\n",
+				rchan->id, ret);
+			return ret;
+		}
+	} else {
+		/* Slave transfer */
+		u32 mode, fetch_size;
+
+		if (uc->pkt_mode) {
+			mode = TI_SCI_RM_UDMAP_CHAN_TYPE_PKT_PBRR;
+			fetch_size = cppi5_hdesc_calc_size(uc->needs_epib,
+							   uc->psd_size, 0);
+		} else {
+			mode = TI_SCI_RM_UDMAP_CHAN_TYPE_3RDP_PBRR;
+			fetch_size = sizeof(struct cppi5_desc_hdr_t);
+		}
+
+		if (uc->dir == DMA_MEM_TO_DEV) {
+			/* TX */
+			int tc_ring = k3_ringacc_get_ring_id(tchan->tc_ring);
+			struct ti_sci_msg_rm_udmap_tx_ch_cfg req_tx = { 0 };
+
+			req_tx.valid_params =
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_FILT_EINFO_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_FILT_PSWORDS_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_CHAN_TYPE_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_SUPR_TDPKT_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_FETCH_SIZE_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_CQ_QNUM_VALID;
+
+			req_tx.nav_id = tisci_rm->tisci_dev_id;
+			req_tx.index = tchan->id;
+			req_tx.tx_pause_on_err = 0;
+			req_tx.tx_filt_einfo = 0;
+			req_tx.tx_filt_pswords = 0;
+			req_tx.tx_chan_type = mode;
+			req_tx.tx_supr_tdpkt = 0;
+			req_tx.tx_fetch_size = fetch_size >> 2;
+			req_tx.txcq_qnum = tc_ring;
+
+			ret = tisci_ops->tx_ch_cfg(tisci_rm->tisci, &req_tx);
+			if (ret) {
+				dev_err(ud->dev, "tchan%d cfg failed %d\n",
+					tchan->id, ret);
+				return ret;
+			}
+		} else {
+			/* RX */
+			int fd_ring = k3_ringacc_get_ring_id(rchan->fd_ring);
+			int rx_ring = k3_ringacc_get_ring_id(rchan->r_ring);
+			struct ti_sci_msg_rm_udmap_rx_ch_cfg req_rx = { 0 };
+			struct ti_sci_msg_rm_udmap_flow_cfg flow_req = { 0 };
+
+			req_rx.valid_params =
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_FETCH_SIZE_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_CQ_QNUM_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_CHAN_TYPE_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_IGNORE_SHORT_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_IGNORE_LONG_VALID;
+
+			req_rx.nav_id = tisci_rm->tisci_dev_id;
+			req_rx.index = rchan->id;
+			req_rx.rx_fetch_size =  fetch_size >> 2;
+			req_rx.rxcq_qnum = rx_ring;
+			req_rx.rx_pause_on_err = 0;
+			req_rx.rx_chan_type = mode;
+			req_rx.rx_ignore_short = 0;
+			req_rx.rx_ignore_long = 0;
+
+			ret = tisci_ops->rx_ch_cfg(tisci_rm->tisci, &req_rx);
+			if (ret) {
+				dev_err(ud->dev, "rchan%d cfg failed %d\n",
+					rchan->id, ret);
+				return ret;
+			}
+
+			flow_req.valid_params =
+			TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_EINFO_PRESENT_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_PSINFO_PRESENT_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_ERROR_HANDLING_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_DESC_TYPE_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_DEST_QNUM_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_SRC_TAG_HI_SEL_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_SRC_TAG_LO_SEL_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_DEST_TAG_HI_SEL_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_DEST_TAG_LO_SEL_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_FDQ0_SZ0_QNUM_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_FDQ1_QNUM_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_FDQ2_QNUM_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_FDQ3_QNUM_VALID;
+
+			flow_req.nav_id = tisci_rm->tisci_dev_id;
+			flow_req.flow_index = rchan->id;
+
+			if (uc->needs_epib)
+				flow_req.rx_einfo_present = 1;
+			else
+				flow_req.rx_einfo_present = 0;
+			if (uc->psd_size)
+				flow_req.rx_psinfo_present = 1;
+			else
+				flow_req.rx_psinfo_present = 0;
+			flow_req.rx_error_handling = 1;
+			flow_req.rx_desc_type = 0;
+			flow_req.rx_dest_qnum = rx_ring;
+			flow_req.rx_src_tag_hi_sel = 2;
+			flow_req.rx_src_tag_lo_sel = 4;
+			flow_req.rx_dest_tag_hi_sel = 5;
+			flow_req.rx_dest_tag_lo_sel = 4;
+			flow_req.rx_fdq0_sz0_qnum = fd_ring;
+			flow_req.rx_fdq1_qnum = fd_ring;
+			flow_req.rx_fdq2_qnum = fd_ring;
+			flow_req.rx_fdq3_qnum = fd_ring;
+
+			ret = tisci_ops->rx_flow_cfg(tisci_rm->tisci,
+						     &flow_req);
+
+			if (ret) {
+				dev_err(ud->dev, "flow%d config failed: %d\n",
+					rchan->id, ret);
+				return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int udma_alloc_chan_resources(struct dma_chan *chan)
+{
+	struct udma_chan *uc = to_udma_chan(chan);
+	struct udma_dev *ud = to_udma_dev(chan->device);
+	const struct udma_match_data *match_data = ud->match_data;
+	struct k3_ring *irq_ring;
+	u32 irq_udma_idx;
+	int ret;
+
+	if (uc->pkt_mode || uc->dir == DMA_MEM_TO_MEM) {
+		uc->use_dma_pool = true;
+		/* in case of MEM_TO_MEM we have maximum of two TRs */
+		if (uc->dir == DMA_MEM_TO_MEM) {
+			uc->hdesc_size = cppi5_trdesc_calc_size(
+					sizeof(struct cppi5_tr_type15_t), 2);
+			uc->pkt_mode = false;
+		}
+	}
+
+	if (uc->use_dma_pool) {
+		uc->hdesc_pool = dma_pool_create(uc->name, ud->ddev.dev,
+						 uc->hdesc_size, ud->desc_align,
+						 0);
+		if (!uc->hdesc_pool) {
+			dev_err(ud->ddev.dev,
+				"Descriptor pool allocation failed\n");
+			uc->use_dma_pool = false;
+			return -ENOMEM;
+		}
+	}
+
+	pm_runtime_get_sync(ud->ddev.dev);
+
+	/*
+	 * Make sure that the completion is in a known state:
+	 * No teardown, the channel is idle
+	 */
+	reinit_completion(&uc->teardown_completed);
+	complete_all(&uc->teardown_completed);
+	uc->state = UDMA_CHAN_IS_IDLE;
+
+	switch (uc->dir) {
+	case DMA_MEM_TO_MEM:
+		/* Non synchronized - mem to mem type of transfer */
+		dev_dbg(uc->ud->dev, "%s: chan%d as MEM-to-MEM\n", __func__,
+			uc->id);
+
+		ret = udma_get_chan_pair(uc);
+		if (ret)
+			return ret;
+
+		ret = udma_alloc_tx_resources(uc);
+		if (ret)
+			return ret;
+
+		ret = udma_alloc_rx_resources(uc);
+		if (ret) {
+			udma_free_tx_resources(uc);
+			return ret;
+		}
+
+		uc->src_thread = ud->psil_base + uc->tchan->id;
+		uc->dst_thread = (ud->psil_base + uc->rchan->id) |
+				 UDMA_PSIL_DST_THREAD_ID_OFFSET;
+
+		irq_ring = uc->tchan->tc_ring;
+		irq_udma_idx = uc->tchan->id;
+		break;
+	case DMA_MEM_TO_DEV:
+		/* Slave transfer synchronized - mem to dev (TX) trasnfer */
+		dev_dbg(uc->ud->dev, "%s: chan%d as MEM-to-DEV\n", __func__,
+			uc->id);
+
+		ret = udma_alloc_tx_resources(uc);
+		if (ret) {
+			uc->remote_thread_id = -1;
+			return ret;
+		}
+
+		uc->src_thread = ud->psil_base + uc->tchan->id;
+		uc->dst_thread = uc->remote_thread_id;
+		uc->dst_thread |= UDMA_PSIL_DST_THREAD_ID_OFFSET;
+
+		irq_ring = uc->tchan->tc_ring;
+		irq_udma_idx = uc->tchan->id;
+		break;
+	case DMA_DEV_TO_MEM:
+		/* Slave transfer synchronized - dev to mem (RX) trasnfer */
+		dev_dbg(uc->ud->dev, "%s: chan%d as DEV-to-MEM\n", __func__,
+			uc->id);
+
+		ret = udma_alloc_rx_resources(uc);
+		if (ret) {
+			uc->remote_thread_id = -1;
+			return ret;
+		}
+
+		uc->src_thread = uc->remote_thread_id;
+		uc->dst_thread = (ud->psil_base + uc->rchan->id) |
+				 UDMA_PSIL_DST_THREAD_ID_OFFSET;
+
+		irq_ring = uc->rchan->r_ring;
+		irq_udma_idx = match_data->rchan_oes_offset + uc->rchan->id;
+		break;
+	default:
+		/* Can not happen */
+		dev_err(uc->ud->dev, "%s: chan%d invalid direction (%u)\n",
+			__func__, uc->id, uc->dir);
+		return -EINVAL;
+	}
+
+	/* Configure channel(s), rflow via tisci */
+	ret = udma_tisci_channel_config(uc);
+	if (ret)
+		goto err_res_free;
+
+	if (udma_is_chan_running(uc)) {
+		dev_warn(ud->dev, "chan%d: is running!\n", uc->id);
+		udma_stop(uc);
+		if (udma_is_chan_running(uc)) {
+			dev_err(ud->dev, "chan%d: won't stop!\n", uc->id);
+			goto err_res_free;
+		}
+	}
+
+	/* PSI-L pairing */
+	ret = navss_psil_pair(ud, uc->src_thread, uc->dst_thread);
+	if (ret) {
+		dev_err(ud->dev, "PSI-L pairing failed: 0x%04x -> 0x%04x\n",
+			uc->src_thread, uc->dst_thread);
+		goto err_res_free;
+	}
+
+	uc->psil_paired = true;
+
+	uc->irq_num_ring = k3_ringacc_get_ring_irq_num(irq_ring);
+	if (uc->irq_num_ring <= 0) {
+		dev_err(ud->dev, "Failed to get ring irq (index: %u)\n",
+			k3_ringacc_get_ring_id(irq_ring));
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
+	/* Event from UDMA (TR events) only needed for slave TR mode channels */
+	if (is_slave_direction(uc->dir) && !uc->pkt_mode) {
+		uc->irq_num_udma = ti_sci_inta_msi_get_virq(ud->dev,
+							    irq_udma_idx);
+		if (uc->irq_num_udma <= 0) {
+			dev_err(ud->dev, "Failed to get udma irq (index: %u)\n",
+				irq_udma_idx);
+			free_irq(uc->irq_num_ring, uc);
+			ret = -EINVAL;
+			goto err_irq_free;
+		}
+
+		ret = request_irq(uc->irq_num_udma, udma_udma_irq_handler, 0,
+				  uc->name, uc);
+		if (ret) {
+			dev_err(ud->dev, "chan%d: UDMA irq request failed\n",
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
+	return 0;
+
+err_irq_free:
+	uc->irq_num_ring = 0;
+	uc->irq_num_udma = 0;
+err_psi_free:
+	navss_psil_unpair(ud, uc->src_thread, uc->dst_thread);
+	uc->psil_paired = false;
+err_res_free:
+	udma_free_tx_resources(uc);
+	udma_free_rx_resources(uc);
+
+	uc->remote_thread_id = -1;
+	uc->dir = DMA_MEM_TO_MEM;
+	uc->pkt_mode = false;
+	uc->static_tr_type = 0;
+	uc->enable_acc32 = 0;
+	uc->enable_burst = 0;
+	uc->channel_tpl = 0;
+	uc->psd_size = 0;
+	uc->metadata_size = 0;
+	uc->hdesc_size = 0;
+
+	if (uc->use_dma_pool) {
+		dma_pool_destroy(uc->hdesc_pool);
+		uc->use_dma_pool = false;
+	}
+
+	return ret;
+}
+
+static void udma_free_chan_resources(struct dma_chan *chan)
+{
+	struct udma_chan *uc = to_udma_chan(chan);
+	struct udma_dev *ud = to_udma_dev(chan->device);
+
+	udma_terminate_all(chan);
+
+	if (uc->irq_num_ring > 0) {
+		free_irq(uc->irq_num_ring, uc);
+
+		uc->irq_num_ring = 0;
+	}
+	if (uc->irq_num_udma > 0) {
+		free_irq(uc->irq_num_udma, uc);
+
+		uc->irq_num_udma = 0;
+	}
+
+	/* Release PSI-L pairing */
+	if (uc->psil_paired) {
+		navss_psil_unpair(ud, uc->src_thread, uc->dst_thread);
+		uc->psil_paired = false;
+	}
+
+	vchan_free_chan_resources(&uc->vc);
+	tasklet_kill(&uc->vc.task);
+
+	pm_runtime_put(ud->ddev.dev);
+
+	udma_free_tx_resources(uc);
+	udma_free_rx_resources(uc);
+
+	uc->remote_thread_id = -1;
+	uc->dir = DMA_MEM_TO_MEM;
+	uc->pkt_mode = false;
+	uc->static_tr_type = 0;
+	uc->enable_acc32 = 0;
+	uc->enable_burst = 0;
+	uc->channel_tpl = 0;
+	uc->psd_size = 0;
+	uc->metadata_size = 0;
+	uc->hdesc_size = 0;
+
+	if (uc->use_dma_pool) {
+		dma_pool_destroy(uc->hdesc_pool);
+		uc->use_dma_pool = false;
+	}
+}
+
 static struct platform_driver udma_driver;
 
 static bool udma_slave_thread_is_packet_mode(struct udma_chan *uc)
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

