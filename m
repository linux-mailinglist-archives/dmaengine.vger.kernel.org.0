Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61B23162832
	for <lists+dmaengine@lfdr.de>; Tue, 18 Feb 2020 15:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgBRObb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Feb 2020 09:31:31 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51794 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgBRObb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Feb 2020 09:31:31 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01IEVPjP025588;
        Tue, 18 Feb 2020 08:31:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582036285;
        bh=ZWrJ/XIahjrIwG+gzMKwhtC6EazRH8LVcmkCkeqM874=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UjHPO/QtY+SlEIvtuPLb4Ns6nUwd4wJqgjtzYdMlqH9oD9L6L33ZOD+rlroDhdv0n
         Y6Zz0gkL3BLQyahXc+kUj6QGa9jtZC1GTrvRt6wMQ1nBfMxxF52fuWNtGK9Q20ClrB
         1Cb3Es+ffuL3pYwZ1bICqErHVCC6RvM6zKkexLVo=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01IEVP8f045057
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Feb 2020 08:31:25 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 18
 Feb 2020 08:31:25 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 18 Feb 2020 08:31:25 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01IEVHXL098737;
        Tue, 18 Feb 2020 08:31:23 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <grygorii.strashko@ti.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 2/2] dmaengine: ti: k3-udma: Implement support for atype (for virtualization)
Date:   Tue, 18 Feb 2020 16:31:26 +0200
Message-ID: <20200218143126.11361-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200218143126.11361-1-peter.ujfalusi@ti.com>
References: <20200218143126.11361-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The DT for virtualized hosts have dma-cells == 2 where the second parameter
is the ATYPE for the channel.

In case of dma-cells == 1 we can configure the ATYPE as 0 (reset value).

The ATYPE defined for j721e are:
0: pointers are physical addresses (no translation)
1: pointers are intermediate addresses (PVU)
2: pointers are virtual addresses (SMMU)

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma-glue.c | 18 +++++++++++--
 drivers/dma/ti/k3-udma.c      | 50 +++++++++++++++++++++++++++++------
 2 files changed, 58 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index c1511298ece2..dbccdc7c0ed5 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -32,6 +32,7 @@ struct k3_udma_glue_common {
 	bool epib;
 	u32  psdata_size;
 	u32  swdata_size;
+	u32  atype;
 };
 
 struct k3_udma_glue_tx_channel {
@@ -121,6 +122,15 @@ static int of_k3_udma_glue_parse_chn(struct device_node *chn_np,
 		return -ENOENT;
 
 	thread_id = dma_spec.args[0];
+	if (dma_spec.args_count == 2) {
+		if (dma_spec.args[1] > 2) {
+			dev_err(common->dev, "Invalid channel atype: %u\n",
+				dma_spec.args[1]);
+			ret = -EINVAL;
+			goto out_put_spec;
+		}
+		common->atype = dma_spec.args[1];
+	}
 
 	if (tx_chn && !(thread_id & K3_PSIL_DST_THREAD_ID_OFFSET)) {
 		ret = -EINVAL;
@@ -202,7 +212,8 @@ static int k3_udma_glue_cfg_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
 			TI_SCI_MSG_VALUE_RM_UDMAP_CH_CHAN_TYPE_VALID |
 			TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_SUPR_TDPKT_VALID |
 			TI_SCI_MSG_VALUE_RM_UDMAP_CH_FETCH_SIZE_VALID |
-			TI_SCI_MSG_VALUE_RM_UDMAP_CH_CQ_QNUM_VALID;
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_CQ_QNUM_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_ATYPE_VALID;
 	req.nav_id = tisci_rm->tisci_dev_id;
 	req.index = tx_chn->udma_tchan_id;
 	if (tx_chn->tx_pause_on_err)
@@ -216,6 +227,7 @@ static int k3_udma_glue_cfg_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
 		req.tx_supr_tdpkt = 1;
 	req.tx_fetch_size = tx_chn->common.hdesc_size >> 2;
 	req.txcq_qnum = k3_ringacc_get_ring_id(tx_chn->ringtxcq);
+	req.tx_atype = tx_chn->common.atype;
 
 	return tisci_rm->tisci_udmap_ops->tx_ch_cfg(tisci_rm->tisci, &req);
 }
@@ -502,7 +514,8 @@ static int k3_udma_glue_cfg_rx_chn(struct k3_udma_glue_rx_channel *rx_chn)
 			   TI_SCI_MSG_VALUE_RM_UDMAP_CH_CQ_QNUM_VALID |
 			   TI_SCI_MSG_VALUE_RM_UDMAP_CH_CHAN_TYPE_VALID |
 			   TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_FLOWID_START_VALID |
-			   TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_FLOWID_CNT_VALID;
+			   TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_FLOWID_CNT_VALID |
+			   TI_SCI_MSG_VALUE_RM_UDMAP_CH_ATYPE_VALID;
 
 	req.nav_id = tisci_rm->tisci_dev_id;
 	req.index = rx_chn->udma_rchan_id;
@@ -519,6 +532,7 @@ static int k3_udma_glue_cfg_rx_chn(struct k3_udma_glue_rx_channel *rx_chn)
 		req.flowid_cnt = rx_chn->flow_num;
 	}
 	req.rx_chan_type = TI_SCI_RM_UDMAP_CHAN_TYPE_PKT_PBRR;
+	req.rx_atype = rx_chn->common.atype;
 
 	ret = tisci_rm->tisci_udmap_ops->rx_ch_cfg(tisci_rm->tisci, &req);
 	if (ret)
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 0536866a58ce..5e076e5680f4 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -149,6 +149,7 @@ struct udma_dev {
 
 	struct udma_chan *channels;
 	u32 psil_base;
+	u32 atype;
 };
 
 struct udma_desc {
@@ -192,6 +193,7 @@ struct udma_chan_config {
 	u32 hdesc_size; /* Size of a packet descriptor in packet mode */
 	bool notdpkt; /* Suppress sending TDC packet */
 	int remote_thread_id;
+	u32 atype;
 	u32 src_thread;
 	u32 dst_thread;
 	enum psil_endpoint_type ep_type;
@@ -1569,7 +1571,8 @@ static int udma_alloc_rx_resources(struct udma_chan *uc)
 	TI_SCI_MSG_VALUE_RM_UDMAP_CH_CHAN_TYPE_VALID |		\
 	TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_SUPR_TDPKT_VALID |	\
 	TI_SCI_MSG_VALUE_RM_UDMAP_CH_FETCH_SIZE_VALID |		\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_CQ_QNUM_VALID)
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_CQ_QNUM_VALID |		\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_ATYPE_VALID)
 
 #define TISCI_RCHAN_VALID_PARAMS (				\
 	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |	\
@@ -1579,7 +1582,8 @@ static int udma_alloc_rx_resources(struct udma_chan *uc)
 	TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_IGNORE_SHORT_VALID |	\
 	TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_IGNORE_LONG_VALID |	\
 	TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_FLOWID_START_VALID |	\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_FLOWID_CNT_VALID)
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_FLOWID_CNT_VALID |	\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_ATYPE_VALID)
 
 static int udma_tisci_m2m_channel_config(struct udma_chan *uc)
 {
@@ -1601,6 +1605,7 @@ static int udma_tisci_m2m_channel_config(struct udma_chan *uc)
 	req_tx.tx_chan_type = TI_SCI_RM_UDMAP_CHAN_TYPE_3RDP_BCOPY_PBRR;
 	req_tx.tx_fetch_size = sizeof(struct cppi5_desc_hdr_t) >> 2;
 	req_tx.txcq_qnum = tc_ring;
+	req_tx.tx_atype = ud->atype;
 
 	ret = tisci_ops->tx_ch_cfg(tisci_rm->tisci, &req_tx);
 	if (ret) {
@@ -1614,6 +1619,7 @@ static int udma_tisci_m2m_channel_config(struct udma_chan *uc)
 	req_rx.rx_fetch_size = sizeof(struct cppi5_desc_hdr_t) >> 2;
 	req_rx.rxcq_qnum = tc_ring;
 	req_rx.rx_chan_type = TI_SCI_RM_UDMAP_CHAN_TYPE_3RDP_BCOPY_PBRR;
+	req_rx.rx_atype = ud->atype;
 
 	ret = tisci_ops->rx_ch_cfg(tisci_rm->tisci, &req_rx);
 	if (ret)
@@ -1649,6 +1655,7 @@ static int udma_tisci_tx_channel_config(struct udma_chan *uc)
 	req_tx.tx_supr_tdpkt = uc->config.notdpkt;
 	req_tx.tx_fetch_size = fetch_size >> 2;
 	req_tx.txcq_qnum = tc_ring;
+	req_tx.tx_atype = uc->config.atype;
 
 	ret = tisci_ops->tx_ch_cfg(tisci_rm->tisci, &req_tx);
 	if (ret)
@@ -1685,6 +1692,7 @@ static int udma_tisci_rx_channel_config(struct udma_chan *uc)
 	req_rx.rx_fetch_size =  fetch_size >> 2;
 	req_rx.rxcq_qnum = rx_ring;
 	req_rx.rx_chan_type = mode;
+	req_rx.rx_atype = uc->config.atype;
 
 	ret = tisci_ops->rx_ch_cfg(tisci_rm->tisci, &req_rx);
 	if (ret) {
@@ -3063,13 +3071,18 @@ static void udma_free_chan_resources(struct dma_chan *chan)
 
 static struct platform_driver udma_driver;
 
+struct udma_filter_param {
+	int remote_thread_id;
+	u32 atype;
+};
+
 static bool udma_dma_filter_fn(struct dma_chan *chan, void *param)
 {
 	struct udma_chan_config *ucc;
 	struct psil_endpoint_config *ep_config;
+	struct udma_filter_param *filter_param;
 	struct udma_chan *uc;
 	struct udma_dev *ud;
-	u32 *args;
 
 	if (chan->device->dev->driver != &udma_driver.driver)
 		return false;
@@ -3077,9 +3090,16 @@ static bool udma_dma_filter_fn(struct dma_chan *chan, void *param)
 	uc = to_udma_chan(chan);
 	ucc = &uc->config;
 	ud = uc->ud;
-	args = param;
+	filter_param = param;
+
+	if (filter_param->atype > 2) {
+		dev_err(ud->dev, "Invalid channel atype: %u\n",
+			filter_param->atype);
+		return false;
+	}
 
-	ucc->remote_thread_id = args[0];
+	ucc->remote_thread_id = filter_param->remote_thread_id;
+	ucc->atype = filter_param->atype;
 
 	if (ucc->remote_thread_id & K3_PSIL_DST_THREAD_ID_OFFSET)
 		ucc->dir = DMA_MEM_TO_DEV;
@@ -3092,6 +3112,7 @@ static bool udma_dma_filter_fn(struct dma_chan *chan, void *param)
 			ucc->remote_thread_id);
 		ucc->dir = DMA_MEM_TO_MEM;
 		ucc->remote_thread_id = -1;
+		ucc->atype = 0;
 		return false;
 	}
 
@@ -3130,13 +3151,20 @@ static struct dma_chan *udma_of_xlate(struct of_phandle_args *dma_spec,
 {
 	struct udma_dev *ud = ofdma->of_dma_data;
 	dma_cap_mask_t mask = ud->ddev.cap_mask;
+	struct udma_filter_param filter_param;
 	struct dma_chan *chan;
 
-	if (dma_spec->args_count != 1)
+	if (dma_spec->args_count != 1 && dma_spec->args_count != 2)
 		return NULL;
 
-	chan = __dma_request_channel(&mask, udma_dma_filter_fn,
-				     &dma_spec->args[0], ofdma->of_node);
+	filter_param.remote_thread_id = dma_spec->args[0];
+	if (dma_spec->args_count == 2)
+		filter_param.atype = dma_spec->args[1];
+	else
+		filter_param.atype = 0;
+
+	chan = __dma_request_channel(&mask, udma_dma_filter_fn, &filter_param,
+				     ofdma->of_node);
 	if (!chan) {
 		dev_err(ud->dev, "get channel fail in %s.\n", __func__);
 		return ERR_PTR(-EINVAL);
@@ -3519,6 +3547,12 @@ static int udma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = of_property_read_u32(navss_node, "ti,udma-atype", &ud->atype);
+	if (!ret && ud->atype > 2) {
+		dev_err(dev, "Invalid atype: %u\n", ud->atype);
+		return -EINVAL;
+	}
+
 	ud->tisci_rm.tisci_udmap_ops = &ud->tisci_rm.tisci->ops.rm_udmap_ops;
 	ud->tisci_rm.tisci_psil_ops = &ud->tisci_rm.tisci->ops.rm_psil_ops;
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

