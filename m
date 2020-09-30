Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDB727E4C2
	for <lists+dmaengine@lfdr.de>; Wed, 30 Sep 2020 11:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbgI3JPO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Sep 2020 05:15:14 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53234 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729334AbgI3JPO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Sep 2020 05:15:14 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08U9Erq3067506;
        Wed, 30 Sep 2020 04:14:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601457293;
        bh=sxnhla0ZiGcwmF3+OurG7ESfOVoCPHYxeMR2b0fot0w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tLnnhTTT5YuF8LTSInU8hF2phjrROsnMtJR57k72sPkjU0ZHGkl+TTbmuJcKedMLv
         HRSxUuY28apjXQllIcqN8n63u31CWQyNdfRcwln+bi3SAYGk1D1lmYuW1AVg8NHY60
         rIa0jVkxQYIzRSJ2bMo9/esYlMx+JcY3/jEp11Uw=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08U9ErNh122457;
        Wed, 30 Sep 2020 04:14:53 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 04:14:52 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 04:14:52 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08U9DuJp116385;
        Wed, 30 Sep 2020 04:14:50 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <robh+dt@kernel.org>, <vigneshr@ti.com>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <lokeshvutla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
Subject: [PATCH 18/18] dmaengine: ti: k3-udma-glue: Add support for K3 PKTDMA
Date:   Wed, 30 Sep 2020 12:14:12 +0300
Message-ID: <20200930091412.8020-19-peter.ujfalusi@ti.com>
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

From: Vignesh Raghavendra <vigneshr@ti.com>

This commit adds support for PKTDMA in k3-udma glue driver. Use new
psil_endpoint_config struct to get static data for a given channel or a
flow during setup.  Make sure that the RX flows being mapped to a RX
channel is within the range of flows that is been allocated to that RX
channel.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma-glue.c    | 272 ++++++++++++++++++++++++++-----
 drivers/dma/ti/k3-udma-private.c |  24 +++
 drivers/dma/ti/k3-udma.h         |   4 +
 include/linux/dma/k3-udma-glue.h |   8 +
 4 files changed, 270 insertions(+), 38 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index f39825ce288a..6730bc296043 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -22,6 +22,7 @@
 
 struct k3_udma_glue_common {
 	struct device *dev;
+	struct device chan_dev;
 	struct udma_dev *udmax;
 	const struct udma_tisci_rm *tisci_rm;
 	struct k3_ringacc *ringacc;
@@ -32,7 +33,8 @@ struct k3_udma_glue_common {
 	bool epib;
 	u32  psdata_size;
 	u32  swdata_size;
-	u32  atype;
+	u32  atype_asel;
+	struct psil_endpoint_config *ep_config;
 };
 
 struct k3_udma_glue_tx_channel {
@@ -53,6 +55,8 @@ struct k3_udma_glue_tx_channel {
 	bool tx_filt_einfo;
 	bool tx_filt_pswords;
 	bool tx_supr_tdpkt;
+
+	int udma_tflow_id;
 };
 
 struct k3_udma_glue_rx_flow {
@@ -104,7 +108,6 @@ static int of_k3_udma_glue_parse_chn(struct device_node *chn_np,
 		const char *name, struct k3_udma_glue_common *common,
 		bool tx_chn)
 {
-	struct psil_endpoint_config *ep_config;
 	struct of_phandle_args dma_spec;
 	u32 thread_id;
 	int ret = 0;
@@ -121,15 +124,26 @@ static int of_k3_udma_glue_parse_chn(struct device_node *chn_np,
 				       &dma_spec))
 		return -ENOENT;
 
+	ret = of_k3_udma_glue_parse(dma_spec.np, common);
+	if (ret)
+		goto out_put_spec;
+
 	thread_id = dma_spec.args[0];
 	if (dma_spec.args_count == 2) {
-		if (dma_spec.args[1] > 2) {
+		if (dma_spec.args[1] > 2 && !xudma_is_pktdma(common->udmax)) {
 			dev_err(common->dev, "Invalid channel atype: %u\n",
 				dma_spec.args[1]);
 			ret = -EINVAL;
 			goto out_put_spec;
 		}
-		common->atype = dma_spec.args[1];
+		if (dma_spec.args[1] > 15 && xudma_is_pktdma(common->udmax)) {
+			dev_err(common->dev, "Invalid channel asel: %u\n",
+				dma_spec.args[1]);
+			ret = -EINVAL;
+			goto out_put_spec;
+		}
+
+		common->atype_asel = dma_spec.args[1];
 	}
 
 	if (tx_chn && !(thread_id & K3_PSIL_DST_THREAD_ID_OFFSET)) {
@@ -143,25 +157,23 @@ static int of_k3_udma_glue_parse_chn(struct device_node *chn_np,
 	}
 
 	/* get psil endpoint config */
-	ep_config = psil_get_ep_config(thread_id);
-	if (IS_ERR(ep_config)) {
+	common->ep_config = psil_get_ep_config(thread_id);
+	if (IS_ERR(common->ep_config)) {
 		dev_err(common->dev,
 			"No configuration for psi-l thread 0x%04x\n",
 			thread_id);
-		ret = PTR_ERR(ep_config);
+		ret = PTR_ERR(common->ep_config);
 		goto out_put_spec;
 	}
 
-	common->epib = ep_config->needs_epib;
-	common->psdata_size = ep_config->psd_size;
+	common->epib = common->ep_config->needs_epib;
+	common->psdata_size = common->ep_config->psd_size;
 
 	if (tx_chn)
 		common->dst_thread = thread_id;
 	else
 		common->src_thread = thread_id;
 
-	ret = of_k3_udma_glue_parse(dma_spec.np, common);
-
 out_put_spec:
 	of_node_put(dma_spec.np);
 	return ret;
@@ -227,7 +239,7 @@ static int k3_udma_glue_cfg_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
 		req.tx_supr_tdpkt = 1;
 	req.tx_fetch_size = tx_chn->common.hdesc_size >> 2;
 	req.txcq_qnum = k3_ringacc_get_ring_id(tx_chn->ringtxcq);
-	req.tx_atype = tx_chn->common.atype;
+	req.tx_atype = tx_chn->common.atype_asel;
 
 	return tisci_rm->tisci_udmap_ops->tx_ch_cfg(tisci_rm->tisci, &req);
 }
@@ -259,8 +271,14 @@ struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
 						tx_chn->common.psdata_size,
 						tx_chn->common.swdata_size);
 
+	if (xudma_is_pktdma(tx_chn->common.udmax))
+		tx_chn->udma_tchan_id = tx_chn->common.ep_config->mapped_channel_id;
+	else
+		tx_chn->udma_tchan_id = -1;
+
 	/* request and cfg UDMAP TX channel */
-	tx_chn->udma_tchanx = xudma_tchan_get(tx_chn->common.udmax, -1);
+	tx_chn->udma_tchanx = xudma_tchan_get(tx_chn->common.udmax,
+					      tx_chn->udma_tchan_id);
 	if (IS_ERR(tx_chn->udma_tchanx)) {
 		ret = PTR_ERR(tx_chn->udma_tchanx);
 		dev_err(dev, "UDMAX tchanx get err %d\n", ret);
@@ -268,11 +286,33 @@ struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
 	}
 	tx_chn->udma_tchan_id = xudma_tchan_get_id(tx_chn->udma_tchanx);
 
+	tx_chn->common.chan_dev.parent = xudma_get_device(tx_chn->common.udmax);
+	dev_set_name(&tx_chn->common.chan_dev, "tchan%d-0x%04x",
+		     tx_chn->udma_tchan_id, tx_chn->common.dst_thread);
+	ret = device_register(&tx_chn->common.chan_dev);
+	if (ret) {
+		dev_err(dev, "Channel Device registration failed %d\n", ret);
+		tx_chn->common.chan_dev.parent = NULL;
+		goto err;
+	}
+
+	if (xudma_is_pktdma(tx_chn->common.udmax)) {
+		/* prepare the channel device as coherent */
+		tx_chn->common.chan_dev.dma_coherent = true;
+		dma_coerce_mask_and_coherent(&tx_chn->common.chan_dev,
+					     DMA_BIT_MASK(48));
+	}
+
 	atomic_set(&tx_chn->free_pkts, cfg->txcq_cfg.size);
 
+	if (xudma_is_pktdma(tx_chn->common.udmax))
+		tx_chn->udma_tflow_id = tx_chn->common.ep_config->default_flow_id;
+	else
+		tx_chn->udma_tflow_id = tx_chn->udma_tchan_id;
+
 	/* request and cfg rings */
 	ret =  k3_ringacc_request_rings_pair(tx_chn->common.ringacc,
-					     tx_chn->udma_tchan_id, -1,
+					     tx_chn->udma_tflow_id, -1,
 					     &tx_chn->ringtx,
 					     &tx_chn->ringtxcq);
 	if (ret) {
@@ -284,6 +324,12 @@ struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
 	cfg->tx_cfg.dma_dev = k3_udma_glue_tx_get_dma_device(tx_chn);
 	cfg->txcq_cfg.dma_dev = cfg->tx_cfg.dma_dev;
 
+	/* Set the ASEL value for DMA rings of PKTDMA */
+	if (xudma_is_pktdma(tx_chn->common.udmax)) {
+		cfg->tx_cfg.asel = tx_chn->common.atype_asel;
+		cfg->txcq_cfg.asel = tx_chn->common.atype_asel;
+	}
+
 	ret = k3_ringacc_ring_cfg(tx_chn->ringtx, &cfg->tx_cfg);
 	if (ret) {
 		dev_err(dev, "Failed to cfg ringtx %d\n", ret);
@@ -348,6 +394,11 @@ void k3_udma_glue_release_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
 
 	if (tx_chn->ringtx)
 		k3_ringacc_ring_free(tx_chn->ringtx);
+
+	if (tx_chn->common.chan_dev.parent) {
+		device_unregister(&tx_chn->common.chan_dev);
+		tx_chn->common.chan_dev.parent = NULL;
+	}
 }
 EXPORT_SYMBOL_GPL(k3_udma_glue_release_tx_chn);
 
@@ -441,13 +492,10 @@ void k3_udma_glue_reset_tx_chn(struct k3_udma_glue_tx_channel *tx_chn,
 			       void *data,
 			       void (*cleanup)(void *data, dma_addr_t desc_dma))
 {
+	struct device *dev = tx_chn->common.dev;
 	dma_addr_t desc_dma;
 	int occ_tx, i, ret;
 
-	/* reset TXCQ as it is not input for udma - expected to be empty */
-	if (tx_chn->ringtxcq)
-		k3_ringacc_ring_reset(tx_chn->ringtxcq);
-
 	/*
 	 * TXQ reset need to be special way as it is input for udma and its
 	 * state cached by udma, so:
@@ -456,17 +504,20 @@ void k3_udma_glue_reset_tx_chn(struct k3_udma_glue_tx_channel *tx_chn,
 	 * 3) reset TXQ in a special way
 	 */
 	occ_tx = k3_ringacc_ring_get_occ(tx_chn->ringtx);
-	dev_dbg(tx_chn->common.dev, "TX reset occ_tx %u\n", occ_tx);
+	dev_dbg(dev, "TX reset occ_tx %u\n", occ_tx);
 
 	for (i = 0; i < occ_tx; i++) {
 		ret = k3_ringacc_ring_pop(tx_chn->ringtx, &desc_dma);
 		if (ret) {
-			dev_err(tx_chn->common.dev, "TX reset pop %d\n", ret);
+			if (ret != -ENODATA)
+				dev_err(dev, "TX reset pop %d\n", ret);
 			break;
 		}
 		cleanup(data, desc_dma);
 	}
 
+	/* reset TXCQ as it is not input for udma - expected to be empty */
+	k3_ringacc_ring_reset(tx_chn->ringtxcq);
 	k3_ringacc_ring_reset_dma(tx_chn->ringtx, occ_tx);
 }
 EXPORT_SYMBOL_GPL(k3_udma_glue_reset_tx_chn);
@@ -485,7 +536,12 @@ EXPORT_SYMBOL_GPL(k3_udma_glue_tx_get_txcq_id);
 
 int k3_udma_glue_tx_get_irq(struct k3_udma_glue_tx_channel *tx_chn)
 {
-	tx_chn->virq = k3_ringacc_get_ring_irq_num(tx_chn->ringtxcq);
+	if (xudma_is_pktdma(tx_chn->common.udmax)) {
+		tx_chn->virq = xudma_pktdma_tflow_get_irq(tx_chn->common.udmax,
+							  tx_chn->udma_tflow_id);
+	} else {
+		tx_chn->virq = k3_ringacc_get_ring_irq_num(tx_chn->ringtxcq);
+	}
 
 	return tx_chn->virq;
 }
@@ -494,10 +550,36 @@ EXPORT_SYMBOL_GPL(k3_udma_glue_tx_get_irq);
 struct device *
 	k3_udma_glue_tx_get_dma_device(struct k3_udma_glue_tx_channel *tx_chn)
 {
+	if (xudma_is_pktdma(tx_chn->common.udmax) &&
+	    (tx_chn->common.atype_asel == 14 || tx_chn->common.atype_asel == 15))
+		return &tx_chn->common.chan_dev;
+
 	return xudma_get_device(tx_chn->common.udmax);
 }
 EXPORT_SYMBOL_GPL(k3_udma_glue_tx_get_dma_device);
 
+void k3_udma_glue_tx_dma_to_cppi5_addr(struct k3_udma_glue_tx_channel *tx_chn,
+				       dma_addr_t *addr)
+{
+	if (!xudma_is_pktdma(tx_chn->common.udmax) ||
+	    !tx_chn->common.atype_asel)
+		return;
+
+	*addr |= (u64)tx_chn->common.atype_asel << K3_ADDRESS_ASEL_SHIFT;
+}
+EXPORT_SYMBOL_GPL(k3_udma_glue_tx_dma_to_cppi5_addr);
+
+void k3_udma_glue_tx_cppi5_to_dma_addr(struct k3_udma_glue_tx_channel *tx_chn,
+				       dma_addr_t *addr)
+{
+	if (!xudma_is_pktdma(tx_chn->common.udmax) ||
+	    !tx_chn->common.atype_asel)
+		return;
+
+	*addr &= (u64)GENMASK(K3_ADDRESS_ASEL_SHIFT - 1, 0);
+}
+EXPORT_SYMBOL_GPL(k3_udma_glue_tx_cppi5_to_dma_addr);
+
 static int k3_udma_glue_cfg_rx_chn(struct k3_udma_glue_rx_channel *rx_chn)
 {
 	const struct udma_tisci_rm *tisci_rm = rx_chn->common.tisci_rm;
@@ -509,8 +591,6 @@ static int k3_udma_glue_cfg_rx_chn(struct k3_udma_glue_rx_channel *rx_chn)
 	req.valid_params = TI_SCI_MSG_VALUE_RM_UDMAP_CH_FETCH_SIZE_VALID |
 			   TI_SCI_MSG_VALUE_RM_UDMAP_CH_CQ_QNUM_VALID |
 			   TI_SCI_MSG_VALUE_RM_UDMAP_CH_CHAN_TYPE_VALID |
-			   TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_FLOWID_START_VALID |
-			   TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_FLOWID_CNT_VALID |
 			   TI_SCI_MSG_VALUE_RM_UDMAP_CH_ATYPE_VALID;
 
 	req.nav_id = tisci_rm->tisci_dev_id;
@@ -522,13 +602,16 @@ static int k3_udma_glue_cfg_rx_chn(struct k3_udma_glue_rx_channel *rx_chn)
 	 * req.rxcq_qnum = k3_ringacc_get_ring_id(rx_chn->flows[0].ringrx);
 	 */
 	req.rxcq_qnum = 0xFFFF;
-	if (rx_chn->flow_num && rx_chn->flow_id_base != rx_chn->udma_rchan_id) {
+	if (!xudma_is_pktdma(rx_chn->common.udmax) && rx_chn->flow_num &&
+	    rx_chn->flow_id_base != rx_chn->udma_rchan_id) {
 		/* Default flow + extra ones */
+		req.valid_params |= TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_FLOWID_START_VALID |
+				    TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_FLOWID_CNT_VALID;
 		req.flowid_start = rx_chn->flow_id_base;
 		req.flowid_cnt = rx_chn->flow_num;
 	}
 	req.rx_chan_type = TI_SCI_RM_UDMAP_CHAN_TYPE_PKT_PBRR;
-	req.rx_atype = rx_chn->common.atype;
+	req.rx_atype = rx_chn->common.atype_asel;
 
 	ret = tisci_rm->tisci_udmap_ops->rx_ch_cfg(tisci_rm->tisci, &req);
 	if (ret)
@@ -582,10 +665,18 @@ static int k3_udma_glue_cfg_rx_flow(struct k3_udma_glue_rx_channel *rx_chn,
 		goto err_rflow_put;
 	}
 
+	if (xudma_is_pktdma(rx_chn->common.udmax)) {
+		rx_ring_id = flow->udma_rflow_id +
+			     xudma_get_rflow_ring_offset(rx_chn->common.udmax);
+		rx_ringfdq_id = 0;
+	} else {
+		rx_ring_id = flow_cfg->ring_rxq_id;
+		rx_ringfdq_id = flow_cfg->ring_rxfdq0_id;
+	}
+
 	/* request and cfg rings */
 	ret =  k3_ringacc_request_rings_pair(rx_chn->common.ringacc,
-					     flow_cfg->ring_rxfdq0_id,
-					     flow_cfg->ring_rxq_id,
+					     rx_ringfdq_id, rx_ring_id,
 					     &flow->ringrxfdq,
 					     &flow->ringrx);
 	if (ret) {
@@ -597,6 +688,12 @@ static int k3_udma_glue_cfg_rx_flow(struct k3_udma_glue_rx_channel *rx_chn,
 	flow_cfg->rx_cfg.dma_dev = k3_udma_glue_rx_get_dma_device(rx_chn);
 	flow_cfg->rxfdq_cfg.dma_dev = flow_cfg->rx_cfg.dma_dev;
 
+	/* Set the ASEL value for DMA rings of PKTDMA */
+	if (xudma_is_pktdma(rx_chn->common.udmax)) {
+		flow_cfg->rx_cfg.asel = rx_chn->common.atype_asel;
+		flow_cfg->rxfdq_cfg.asel = rx_chn->common.atype_asel;
+	}
+
 	ret = k3_ringacc_ring_cfg(flow->ringrx, &flow_cfg->rx_cfg);
 	if (ret) {
 		dev_err(dev, "Failed to cfg ringrx %d\n", ret);
@@ -755,6 +852,7 @@ k3_udma_glue_request_rx_chn_priv(struct device *dev, const char *name,
 				 struct k3_udma_glue_rx_channel_cfg *cfg)
 {
 	struct k3_udma_glue_rx_channel *rx_chn;
+	struct psil_endpoint_config *ep_cfg;
 	int ret, i;
 
 	if (cfg->flow_id_num <= 0)
@@ -782,8 +880,16 @@ k3_udma_glue_request_rx_chn_priv(struct device *dev, const char *name,
 						rx_chn->common.psdata_size,
 						rx_chn->common.swdata_size);
 
+	ep_cfg = rx_chn->common.ep_config;
+
+	if (xudma_is_pktdma(rx_chn->common.udmax))
+		rx_chn->udma_rchan_id = ep_cfg->mapped_channel_id;
+	else
+		rx_chn->udma_rchan_id = -1;
+
 	/* request and cfg UDMAP RX channel */
-	rx_chn->udma_rchanx = xudma_rchan_get(rx_chn->common.udmax, -1);
+	rx_chn->udma_rchanx = xudma_rchan_get(rx_chn->common.udmax,
+					      rx_chn->udma_rchan_id);
 	if (IS_ERR(rx_chn->udma_rchanx)) {
 		ret = PTR_ERR(rx_chn->udma_rchanx);
 		dev_err(dev, "UDMAX rchanx get err %d\n", ret);
@@ -791,12 +897,47 @@ k3_udma_glue_request_rx_chn_priv(struct device *dev, const char *name,
 	}
 	rx_chn->udma_rchan_id = xudma_rchan_get_id(rx_chn->udma_rchanx);
 
-	rx_chn->flow_num = cfg->flow_id_num;
-	rx_chn->flow_id_base = cfg->flow_id_base;
+	rx_chn->common.chan_dev.parent = xudma_get_device(rx_chn->common.udmax);
+	dev_set_name(&rx_chn->common.chan_dev, "rchan%d-0x%04x",
+		     rx_chn->udma_rchan_id, rx_chn->common.src_thread);
+	ret = device_register(&rx_chn->common.chan_dev);
+	if (ret) {
+		dev_err(dev, "Channel Device registration failed %d\n", ret);
+		rx_chn->common.chan_dev.parent = NULL;
+		goto err;
+	}
 
-	/* Use RX channel id as flow id: target dev can't generate flow_id */
-	if (cfg->flow_id_use_rxchan_id)
-		rx_chn->flow_id_base = rx_chn->udma_rchan_id;
+	if (xudma_is_pktdma(rx_chn->common.udmax)) {
+		/* prepare the channel device as coherent */
+		rx_chn->common.chan_dev.dma_coherent = true;
+		dma_coerce_mask_and_coherent(&rx_chn->common.chan_dev,
+					     DMA_BIT_MASK(48));
+	}
+
+	if (xudma_is_pktdma(rx_chn->common.udmax)) {
+		int flow_start = cfg->flow_id_base;
+		int flow_end;
+
+		if (flow_start == -1)
+			flow_start = ep_cfg->flow_start;
+
+		flow_end = flow_start + cfg->flow_id_num - 1;
+		if (flow_start < ep_cfg->flow_start ||
+		    flow_end > (ep_cfg->flow_start + ep_cfg->flow_num - 1)) {
+			dev_err(dev, "Invalid flow range requested\n");
+			ret = -EINVAL;
+			goto err;
+		}
+		rx_chn->flow_id_base = flow_start;
+	} else {
+		rx_chn->flow_id_base = cfg->flow_id_base;
+
+		/* Use RX channel id as flow id: target dev can't generate flow_id */
+		if (cfg->flow_id_use_rxchan_id)
+			rx_chn->flow_id_base = rx_chn->udma_rchan_id;
+	}
+
+	rx_chn->flow_num = cfg->flow_id_num;
 
 	rx_chn->flows = devm_kcalloc(dev, rx_chn->flow_num,
 				     sizeof(*rx_chn->flows), GFP_KERNEL);
@@ -899,6 +1040,23 @@ k3_udma_glue_request_remote_rx_chn(struct device *dev, const char *name,
 		goto err;
 	}
 
+	rx_chn->common.chan_dev.parent = xudma_get_device(rx_chn->common.udmax);
+	dev_set_name(&rx_chn->common.chan_dev, "rchan_remote-0x%04x",
+		     rx_chn->common.src_thread);
+	ret = device_register(&rx_chn->common.chan_dev);
+	if (ret) {
+		dev_err(dev, "Channel Device registration failed %d\n", ret);
+		rx_chn->common.chan_dev.parent = NULL;
+		goto err;
+	}
+
+	if (xudma_is_pktdma(rx_chn->common.udmax)) {
+		/* prepare the channel device as coherent */
+		rx_chn->common.chan_dev.dma_coherent = true;
+		dma_coerce_mask_and_coherent(&rx_chn->common.chan_dev,
+					     DMA_BIT_MASK(48));
+	}
+
 	ret = k3_udma_glue_allocate_rx_flows(rx_chn, cfg);
 	if (ret)
 		goto err;
@@ -951,6 +1109,11 @@ void k3_udma_glue_release_rx_chn(struct k3_udma_glue_rx_channel *rx_chn)
 	if (!IS_ERR_OR_NULL(rx_chn->udma_rchanx))
 		xudma_rchan_put(rx_chn->common.udmax,
 				rx_chn->udma_rchanx);
+
+	if (rx_chn->common.chan_dev.parent) {
+		device_unregister(&rx_chn->common.chan_dev);
+		rx_chn->common.chan_dev.parent = NULL;
+	}
 }
 EXPORT_SYMBOL_GPL(k3_udma_glue_release_rx_chn);
 
@@ -1143,12 +1306,10 @@ void k3_udma_glue_reset_rx_chn(struct k3_udma_glue_rx_channel *rx_chn,
 	/* reset RXCQ as it is not input for udma - expected to be empty */
 	occ_rx = k3_ringacc_ring_get_occ(flow->ringrx);
 	dev_dbg(dev, "RX reset flow %u occ_rx %u\n", flow_num, occ_rx);
-	if (flow->ringrx)
-		k3_ringacc_ring_reset(flow->ringrx);
 
 	/* Skip RX FDQ in case one FDQ is used for the set of flows */
 	if (skip_fdq)
-		return;
+		goto do_reset;
 
 	/*
 	 * RX FDQ reset need to be special way as it is input for udma and its
@@ -1163,13 +1324,17 @@ void k3_udma_glue_reset_rx_chn(struct k3_udma_glue_rx_channel *rx_chn,
 	for (i = 0; i < occ_rx; i++) {
 		ret = k3_ringacc_ring_pop(flow->ringrxfdq, &desc_dma);
 		if (ret) {
-			dev_err(dev, "RX reset pop %d\n", ret);
+			if (ret != -ENODATA)
+				dev_err(dev, "RX reset pop %d\n", ret);
 			break;
 		}
 		cleanup(data, desc_dma);
 	}
 
 	k3_ringacc_ring_reset_dma(flow->ringrxfdq, occ_rx);
+
+do_reset:
+	k3_ringacc_ring_reset(flow->ringrx);
 }
 EXPORT_SYMBOL_GPL(k3_udma_glue_reset_rx_chn);
 
@@ -1199,7 +1364,12 @@ int k3_udma_glue_rx_get_irq(struct k3_udma_glue_rx_channel *rx_chn,
 
 	flow = &rx_chn->flows[flow_num];
 
-	flow->virq = k3_ringacc_get_ring_irq_num(flow->ringrx);
+	if (xudma_is_pktdma(rx_chn->common.udmax)) {
+		flow->virq = xudma_pktdma_rflow_get_irq(rx_chn->common.udmax,
+							flow->udma_rflow_id);
+	} else {
+		flow->virq = k3_ringacc_get_ring_irq_num(flow->ringrx);
+	}
 
 	return flow->virq;
 }
@@ -1208,6 +1378,32 @@ EXPORT_SYMBOL_GPL(k3_udma_glue_rx_get_irq);
 struct device *
 	k3_udma_glue_rx_get_dma_device(struct k3_udma_glue_rx_channel *rx_chn)
 {
+	if (xudma_is_pktdma(rx_chn->common.udmax) &&
+	    (rx_chn->common.atype_asel == 14 || rx_chn->common.atype_asel == 15))
+		return &rx_chn->common.chan_dev;
+
 	return xudma_get_device(rx_chn->common.udmax);
 }
 EXPORT_SYMBOL_GPL(k3_udma_glue_rx_get_dma_device);
+
+void k3_udma_glue_rx_dma_to_cppi5_addr(struct k3_udma_glue_rx_channel *rx_chn,
+				       dma_addr_t *addr)
+{
+	if (!xudma_is_pktdma(rx_chn->common.udmax) ||
+	    !rx_chn->common.atype_asel)
+		return;
+
+	*addr |= (u64)rx_chn->common.atype_asel << K3_ADDRESS_ASEL_SHIFT;
+}
+EXPORT_SYMBOL_GPL(k3_udma_glue_rx_dma_to_cppi5_addr);
+
+void k3_udma_glue_rx_cppi5_to_dma_addr(struct k3_udma_glue_rx_channel *rx_chn,
+				       dma_addr_t *addr)
+{
+	if (!xudma_is_pktdma(rx_chn->common.udmax) ||
+	    !rx_chn->common.atype_asel)
+		return;
+
+	*addr &= (u64)GENMASK(K3_ADDRESS_ASEL_SHIFT - 1, 0);
+}
+EXPORT_SYMBOL_GPL(k3_udma_glue_rx_cppi5_to_dma_addr);
diff --git a/drivers/dma/ti/k3-udma-private.c b/drivers/dma/ti/k3-udma-private.c
index f0cecd29cff1..cef4890cfa42 100644
--- a/drivers/dma/ti/k3-udma-private.c
+++ b/drivers/dma/ti/k3-udma-private.c
@@ -151,3 +151,27 @@ void xudma_##res##rt_write(struct udma_##res *p, int reg, u32 val)	\
 EXPORT_SYMBOL(xudma_##res##rt_write)
 XUDMA_RT_IO_FUNCTIONS(tchan);
 XUDMA_RT_IO_FUNCTIONS(rchan);
+
+int xudma_is_pktdma(struct udma_dev *ud)
+{
+	return ud->match_data->type == DMA_TYPE_PKTDMA;
+}
+EXPORT_SYMBOL(xudma_is_pktdma);
+
+int xudma_pktdma_tflow_get_irq(struct udma_dev *ud, int udma_tflow_id)
+{
+	const struct udma_oes_offsets *oes = &ud->soc_data->oes;
+
+	return ti_sci_inta_msi_get_virq(ud->dev, udma_tflow_id +
+					oes->pktdma_tchan_flow);
+}
+EXPORT_SYMBOL(xudma_pktdma_tflow_get_irq);
+
+int xudma_pktdma_rflow_get_irq(struct udma_dev *ud, int udma_rflow_id)
+{
+	const struct udma_oes_offsets *oes = &ud->soc_data->oes;
+
+	return ti_sci_inta_msi_get_virq(ud->dev, udma_rflow_id +
+					oes->pktdma_rchan_flow);
+}
+EXPORT_SYMBOL(xudma_pktdma_rflow_get_irq);
diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
index 078cc3aa4126..c02080bb5866 100644
--- a/drivers/dma/ti/k3-udma.h
+++ b/drivers/dma/ti/k3-udma.h
@@ -156,4 +156,8 @@ void xudma_rchanrt_write(struct udma_rchan *rchan, int reg, u32 val);
 bool xudma_rflow_is_gp(struct udma_dev *ud, int id);
 int xudma_get_rflow_ring_offset(struct udma_dev *ud);
 
+int xudma_is_pktdma(struct udma_dev *ud);
+
+int xudma_pktdma_tflow_get_irq(struct udma_dev *ud, int udma_tflow_id);
+int xudma_pktdma_rflow_get_irq(struct udma_dev *ud, int udma_rflow_id);
 #endif /* K3_UDMA_H_ */
diff --git a/include/linux/dma/k3-udma-glue.h b/include/linux/dma/k3-udma-glue.h
index d7c12f31377c..e443be4d3b4b 100644
--- a/include/linux/dma/k3-udma-glue.h
+++ b/include/linux/dma/k3-udma-glue.h
@@ -43,6 +43,10 @@ u32 k3_udma_glue_tx_get_txcq_id(struct k3_udma_glue_tx_channel *tx_chn);
 int k3_udma_glue_tx_get_irq(struct k3_udma_glue_tx_channel *tx_chn);
 struct device *
 	k3_udma_glue_tx_get_dma_device(struct k3_udma_glue_tx_channel *tx_chn);
+void k3_udma_glue_tx_dma_to_cppi5_addr(struct k3_udma_glue_tx_channel *tx_chn,
+				       dma_addr_t *addr);
+void k3_udma_glue_tx_cppi5_to_dma_addr(struct k3_udma_glue_tx_channel *tx_chn,
+				       dma_addr_t *addr);
 
 enum {
 	K3_UDMA_GLUE_SRC_TAG_LO_KEEP = 0,
@@ -134,5 +138,9 @@ int k3_udma_glue_rx_flow_disable(struct k3_udma_glue_rx_channel *rx_chn,
 				 u32 flow_idx);
 struct device *
 	k3_udma_glue_rx_get_dma_device(struct k3_udma_glue_rx_channel *rx_chn);
+void k3_udma_glue_rx_dma_to_cppi5_addr(struct k3_udma_glue_rx_channel *rx_chn,
+				       dma_addr_t *addr);
+void k3_udma_glue_rx_cppi5_to_dma_addr(struct k3_udma_glue_rx_channel *rx_chn,
+				       dma_addr_t *addr);
 
 #endif /* K3_UDMA_GLUE_H_ */
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

