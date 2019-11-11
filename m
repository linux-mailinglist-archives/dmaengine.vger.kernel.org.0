Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C05DF75A0
	for <lists+dmaengine@lfdr.de>; Mon, 11 Nov 2019 14:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfKKNxO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Nov 2019 08:53:14 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56700 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbfKKNxO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Nov 2019 08:53:14 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xABDqxip090615;
        Mon, 11 Nov 2019 07:52:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573480379;
        bh=9AGdJcw7fOzhufR98QHZE1RS5n8CGsJPCOXuNS34ZSw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=h9A3Do4rS361yAUprN6GPwYMnoEoJ5K7maxOi1rexvr2JbkFcLDFmZ8eWcMLqpIz6
         qgopirjOhYUo1LGWg4ukd8cD701T8rEJw4YAknMriyztjhKhbIS+jXfU9r+f1EX5Gw
         dvx3HLl7Ogbk16sgVYHjrK+9UBrjrvj1/sPnde3E=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xABDqxrX111738
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Nov 2019 07:52:59 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 11
 Nov 2019 07:52:42 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 11 Nov 2019 07:52:42 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xABDqE8w097668;
        Mon, 11 Nov 2019 07:52:55 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
Subject: [PATCH v5 11/15] dmaengine: ti: New driver for K3 UDMA - split#3: alloc/free chan_resources
Date:   Mon, 11 Nov 2019 15:53:26 +0200
Message-ID: <20191111135330.8235-12-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111135330.8235-1-peter.ujfalusi@ti.com>
References: <20191111135330.8235-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Split patch for review containing: channel resource allocation and free
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
 drivers/dma/ti/k3-udma.c | 771 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 771 insertions(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 44f1d8f53778..11cef765ef8e 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -1046,6 +1046,777 @@ static irqreturn_t udma_udma_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static struct udma_rflow *__udma_get_rflow(struct udma_dev *ud, int id)
+{
+	/*
+	 * Attempt to request rflow by ID can be made for any rflow
+	 * if not in use with assumption that caller knows what's doing.
+	 * TI-SCI FW will perform additional permission check ant way, it's
+	 * safe
+	 */
+
+	if (id < 0 || id >= ud->rflow_cnt)
+		return ERR_PTR(-ENOENT);
+
+	if (test_bit(id, ud->rflow_in_use))
+		return ERR_PTR(-ENOENT);
+
+	/* GP rflow has to be allocated first */
+	if (!test_bit(id, ud->rflow_gp_map) &&
+	    !test_bit(id, ud->rflow_gp_map_allocated))
+		return ERR_PTR(-EINVAL);
+
+	dev_dbg(ud->dev, "get rflow%d\n", id);
+	set_bit(id, ud->rflow_in_use);
+	return &ud->rflows[id];
+}
+
+static void __udma_put_rflow(struct udma_dev *ud, struct udma_rflow *rflow)
+{
+	if (!test_bit(rflow->id, ud->rflow_in_use)) {
+		dev_err(ud->dev, "attempt to put unused rflow%d\n", rflow->id);
+		return;
+	}
+
+	dev_dbg(ud->dev, "put rflow%d\n", rflow->id);
+	clear_bit(rflow->id, ud->rflow_in_use);
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
+	if (!uc->rchan) {
+		dev_err(ud->dev, "chan%d: does not have rchan??\n", uc->id);
+		return -EINVAL;
+	}
+
+	if (uc->rflow) {
+		dev_dbg(ud->dev, "chan%d: already have rflow%d allocated\n",
+			uc->id, uc->rflow->id);
+		return 0;
+	}
+
+	uc->rflow = __udma_get_rflow(ud, flow_id);
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
+		__udma_put_rflow(ud, uc->rflow);
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
+	if (uc->rflow) {
+		struct udma_rflow *rflow = uc->rflow;
+
+		k3_ringacc_ring_free(rflow->fd_ring);
+		k3_ringacc_ring_free(rflow->r_ring);
+		rflow->fd_ring = NULL;
+		rflow->r_ring = NULL;
+
+		udma_put_rflow(uc);
+	}
+
+	udma_put_rchan(uc);
+}
+
+static int udma_alloc_rx_resources(struct udma_chan *uc)
+{
+	struct udma_dev *ud = uc->ud;
+	struct k3_ring_cfg ring_cfg;
+	struct udma_rflow *rflow;
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
+	rflow = uc->rflow;
+	fd_ring_id = ud->tchan_cnt + ud->echan_cnt + uc->rchan->id;
+	rflow->fd_ring = k3_ringacc_request_ring(ud->ringacc, fd_ring_id, 0);
+	if (!rflow->fd_ring) {
+		ret = -EBUSY;
+		goto err_rx_ring;
+	}
+
+	rflow->r_ring = k3_ringacc_request_ring(ud->ringacc, -1, 0);
+	if (!rflow->r_ring) {
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
+	ret = k3_ringacc_ring_cfg(rflow->fd_ring, &ring_cfg);
+	ring_cfg.size = K3_UDMA_DEFAULT_RING_SIZE;
+	ret |= k3_ringacc_ring_cfg(rflow->r_ring, &ring_cfg);
+
+	if (ret)
+		goto err_ringcfg;
+
+	return 0;
+
+err_ringcfg:
+	k3_ringacc_ring_free(rflow->r_ring);
+	rflow->r_ring = NULL;
+err_rxc_ring:
+	k3_ringacc_ring_free(rflow->fd_ring);
+	rflow->fd_ring = NULL;
+err_rx_ring:
+	udma_put_rflow(uc);
+err_rflow:
+	udma_put_rchan(uc);
+
+	return ret;
+}
+
+#define TISCI_TCHAN_VALID_PARAMS (				\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |	\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_FILT_EINFO_VALID |	\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_FILT_PSWORDS_VALID |	\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_CHAN_TYPE_VALID |		\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_SUPR_TDPKT_VALID |	\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_FETCH_SIZE_VALID |		\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_CQ_QNUM_VALID)
+
+#define TISCI_RCHAN_VALID_PARAMS (				\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |	\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_FETCH_SIZE_VALID |		\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_CQ_QNUM_VALID |		\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_CHAN_TYPE_VALID |		\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_IGNORE_SHORT_VALID |	\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_IGNORE_LONG_VALID |	\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_FLOWID_START_VALID |	\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_FLOWID_CNT_VALID)
+
+static int udma_tisci_m2m_channel_config(struct udma_chan *uc)
+{
+	struct udma_dev *ud = uc->ud;
+	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
+	const struct ti_sci_rm_udmap_ops *tisci_ops = tisci_rm->tisci_udmap_ops;
+	struct udma_tchan *tchan = uc->tchan;
+	struct udma_rchan *rchan = uc->rchan;
+	int ret = 0;
+
+	/* Non synchronized - mem to mem type of transfer */
+	int tc_ring = k3_ringacc_get_ring_id(tchan->tc_ring);
+	struct ti_sci_msg_rm_udmap_tx_ch_cfg req_tx = { 0 };
+	struct ti_sci_msg_rm_udmap_rx_ch_cfg req_rx = { 0 };
+
+	req_tx.valid_params = TISCI_TCHAN_VALID_PARAMS;
+	req_tx.nav_id = tisci_rm->tisci_dev_id;
+	req_tx.index = tchan->id;
+	req_tx.tx_chan_type = TI_SCI_RM_UDMAP_CHAN_TYPE_3RDP_BCOPY_PBRR;
+	req_tx.tx_fetch_size = sizeof(struct cppi5_desc_hdr_t) >> 2;
+	req_tx.txcq_qnum = tc_ring;
+
+	ret = tisci_ops->tx_ch_cfg(tisci_rm->tisci, &req_tx);
+	if (ret) {
+		dev_err(ud->dev, "tchan%d cfg failed %d\n", tchan->id, ret);
+		return ret;
+	}
+
+	req_rx.valid_params = TISCI_RCHAN_VALID_PARAMS;
+	req_rx.nav_id = tisci_rm->tisci_dev_id;
+	req_rx.index = rchan->id;
+	req_rx.rx_fetch_size = sizeof(struct cppi5_desc_hdr_t) >> 2;
+	req_rx.rxcq_qnum = tc_ring;
+	req_rx.rx_chan_type = TI_SCI_RM_UDMAP_CHAN_TYPE_3RDP_BCOPY_PBRR;
+
+	ret = tisci_ops->rx_ch_cfg(tisci_rm->tisci, &req_rx);
+	if (ret)
+		dev_err(ud->dev, "rchan%d alloc failed %d\n", rchan->id, ret);
+
+	return ret;
+}
+
+static int udma_tisci_tx_channel_config(struct udma_chan *uc)
+{
+	struct udma_dev *ud = uc->ud;
+	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
+	const struct ti_sci_rm_udmap_ops *tisci_ops = tisci_rm->tisci_udmap_ops;
+	struct udma_tchan *tchan = uc->tchan;
+	int tc_ring = k3_ringacc_get_ring_id(tchan->tc_ring);
+	struct ti_sci_msg_rm_udmap_tx_ch_cfg req_tx = { 0 };
+	u32 mode, fetch_size;
+	int ret = 0;
+
+	if (uc->pkt_mode) {
+		mode = TI_SCI_RM_UDMAP_CHAN_TYPE_PKT_PBRR;
+		fetch_size = cppi5_hdesc_calc_size(uc->needs_epib, uc->psd_size,
+						   0);
+	} else {
+		mode = TI_SCI_RM_UDMAP_CHAN_TYPE_3RDP_PBRR;
+		fetch_size = sizeof(struct cppi5_desc_hdr_t);
+	}
+
+	req_tx.valid_params = TISCI_TCHAN_VALID_PARAMS;
+	req_tx.nav_id = tisci_rm->tisci_dev_id;
+	req_tx.index = tchan->id;
+	req_tx.tx_chan_type = mode;
+	req_tx.tx_supr_tdpkt = uc->notdpkt;
+	req_tx.tx_fetch_size = fetch_size >> 2;
+	req_tx.txcq_qnum = tc_ring;
+	if (uc->ep_type == PSIL_EP_PDMA_XY) {
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
+static int udma_tisci_rx_channel_config(struct udma_chan *uc)
+{
+	struct udma_dev *ud = uc->ud;
+	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
+	const struct ti_sci_rm_udmap_ops *tisci_ops = tisci_rm->tisci_udmap_ops;
+	struct udma_rchan *rchan = uc->rchan;
+	int fd_ring = k3_ringacc_get_ring_id(uc->rflow->fd_ring);
+	int rx_ring = k3_ringacc_get_ring_id(uc->rflow->r_ring);
+	struct ti_sci_msg_rm_udmap_rx_ch_cfg req_rx = { 0 };
+	struct ti_sci_msg_rm_udmap_flow_cfg flow_req = { 0 };
+	u32 mode, fetch_size;
+	int ret = 0;
+
+	if (uc->pkt_mode) {
+		mode = TI_SCI_RM_UDMAP_CHAN_TYPE_PKT_PBRR;
+		fetch_size = cppi5_hdesc_calc_size(uc->needs_epib,
+						   uc->psd_size, 0);
+	} else {
+		mode = TI_SCI_RM_UDMAP_CHAN_TYPE_3RDP_PBRR;
+		fetch_size = sizeof(struct cppi5_desc_hdr_t);
+	}
+
+	req_rx.valid_params = TISCI_RCHAN_VALID_PARAMS;
+	req_rx.nav_id = tisci_rm->tisci_dev_id;
+	req_rx.index = rchan->id;
+	req_rx.rx_fetch_size =  fetch_size >> 2;
+	req_rx.rxcq_qnum = rx_ring;
+	req_rx.rx_chan_type = mode;
+
+	ret = tisci_ops->rx_ch_cfg(tisci_rm->tisci, &req_rx);
+	if (ret) {
+		dev_err(ud->dev, "rchan%d cfg failed %d\n", rchan->id, ret);
+		return ret;
+	}
+
+	flow_req.valid_params =
+		TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_EINFO_PRESENT_VALID |
+		TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_PSINFO_PRESENT_VALID |
+		TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_ERROR_HANDLING_VALID |
+		TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_DESC_TYPE_VALID |
+		TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_DEST_QNUM_VALID |
+		TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_SRC_TAG_HI_SEL_VALID |
+		TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_SRC_TAG_LO_SEL_VALID |
+		TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_DEST_TAG_HI_SEL_VALID |
+		TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_DEST_TAG_LO_SEL_VALID |
+		TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_FDQ0_SZ0_QNUM_VALID |
+		TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_FDQ1_QNUM_VALID |
+		TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_FDQ2_QNUM_VALID |
+		TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_FDQ3_QNUM_VALID;
+
+	flow_req.nav_id = tisci_rm->tisci_dev_id;
+	flow_req.flow_index = rchan->id;
+
+	if (uc->needs_epib)
+		flow_req.rx_einfo_present = 1;
+	else
+		flow_req.rx_einfo_present = 0;
+	if (uc->psd_size)
+		flow_req.rx_psinfo_present = 1;
+	else
+		flow_req.rx_psinfo_present = 0;
+	flow_req.rx_error_handling = 1;
+	flow_req.rx_dest_qnum = rx_ring;
+	flow_req.rx_src_tag_hi_sel = UDMA_RFLOW_SRCTAG_NONE;
+	flow_req.rx_src_tag_lo_sel = UDMA_RFLOW_SRCTAG_SRC_TAG;
+	flow_req.rx_dest_tag_hi_sel = UDMA_RFLOW_DSTTAG_DST_TAG_HI;
+	flow_req.rx_dest_tag_lo_sel = UDMA_RFLOW_DSTTAG_DST_TAG_LO;
+	flow_req.rx_fdq0_sz0_qnum = fd_ring;
+	flow_req.rx_fdq1_qnum = fd_ring;
+	flow_req.rx_fdq2_qnum = fd_ring;
+	flow_req.rx_fdq3_qnum = fd_ring;
+
+	ret = tisci_ops->rx_flow_cfg(tisci_rm->tisci, &flow_req);
+
+	if (ret)
+		dev_err(ud->dev, "flow%d config failed: %d\n", rchan->id, ret);
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
+				 K3_PSIL_DST_THREAD_ID_OFFSET;
+
+		irq_ring = uc->tchan->tc_ring;
+		irq_udma_idx = uc->tchan->id;
+
+		ret = udma_tisci_m2m_channel_config(uc);
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
+		uc->dst_thread |= K3_PSIL_DST_THREAD_ID_OFFSET;
+
+		irq_ring = uc->tchan->tc_ring;
+		irq_udma_idx = uc->tchan->id;
+
+		ret = udma_tisci_tx_channel_config(uc);
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
+				 K3_PSIL_DST_THREAD_ID_OFFSET;
+
+		irq_ring = uc->rflow->r_ring;
+		irq_udma_idx = match_data->rchan_oes_offset + uc->rchan->id;
+
+		ret = udma_tisci_rx_channel_config(uc);
+		break;
+	default:
+		/* Can not happen */
+		dev_err(uc->ud->dev, "%s: chan%d invalid direction (%u)\n",
+			__func__, uc->id, uc->dir);
+		return -EINVAL;
+	}
+
+	/* check if the channel configuration was successful */
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
+	udma_free_tx_resources(uc);
+	udma_free_rx_resources(uc);
+	udma_reset_uchan(uc);
+
+	if (uc->use_dma_pool) {
+		dma_pool_destroy(uc->hdesc_pool);
+		uc->use_dma_pool = false;
+	}
+}
+
 static struct platform_driver udma_driver;
 
 static bool udma_dma_filter_fn(struct dma_chan *chan, void *param)
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

