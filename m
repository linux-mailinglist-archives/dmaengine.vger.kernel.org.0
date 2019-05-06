Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 308C4149DD
	for <lists+dmaengine@lfdr.de>; Mon,  6 May 2019 14:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfEFMge (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 May 2019 08:36:34 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54344 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfEFMge (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 May 2019 08:36:34 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x46CZiQl059387;
        Mon, 6 May 2019 07:35:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1557146144;
        bh=FCReqwUjH9d/EC/LMfWazkETQfyQRMFUMSkP34NiMc4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=eVDuHb9O+B9eAqmue/hYiglfzd990zM8kcPbroUg+lTS3VBqBSRIx/XvMk5oFTKYg
         O7OIvF7Pk6Zf1JpFnJjv0YDf5LzwcolLX4J2gE6KC1jsM66u8rCXHGsPkWUrzcI2fo
         zZ2m5TyXjRdsCczis6N2TMRo2iQnsjWppxdz8K/M=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x46CZiYv024922
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 May 2019 07:35:44 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 6 May
 2019 07:35:43 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 6 May 2019 07:35:43 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x46CYpUM110286;
        Mon, 6 May 2019 07:35:41 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>
Subject: [PATCH 16/16] dmaengine: ti: k3-udma: Add glue layer for non DMAengine users
Date:   Mon, 6 May 2019 15:34:56 +0300
Message-ID: <20190506123456.6777-17-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506123456.6777-1-peter.ujfalusi@ti.com>
References: <20190506123456.6777-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

Certain users can not use right now the DMAengine API due to missing
features in the core. Prime example is Networking.

These users can use the glue layer interface to avoid misuse of DMAengine
API and when the core gains the needed features they can be converted to
use generic API.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/Kconfig           |    9 +
 drivers/dma/ti/Makefile          |    1 +
 drivers/dma/ti/k3-udma-glue.c    | 1039 ++++++++++++++++++++++++++++++
 drivers/dma/ti/k3-udma-private.c |  124 ++++
 drivers/dma/ti/k3-udma.c         |   61 ++
 drivers/dma/ti/k3-udma.h         |   30 +
 include/linux/dma/k3-udma-glue.h |  123 ++++
 7 files changed, 1387 insertions(+)
 create mode 100644 drivers/dma/ti/k3-udma-glue.c
 create mode 100644 drivers/dma/ti/k3-udma-private.c
 create mode 100644 include/linux/dma/k3-udma-glue.h

diff --git a/drivers/dma/ti/Kconfig b/drivers/dma/ti/Kconfig
index 4542eae64cf2..f08097023eb4 100644
--- a/drivers/dma/ti/Kconfig
+++ b/drivers/dma/ti/Kconfig
@@ -46,5 +46,14 @@ config TI_K3_UDMA
 	  Enable support for the TI UDMA (Unified DMA) controller. This
 	  DMA engine is used in AM65x.
 
+config TI_K3_UDMA_GLUE_LAYER
+	tristate "Texas Instruments UDMA Glue layer for non DMAengine users"
+	depends on ARCH_K3 || COMPILE_TEST
+	depends on TI_K3_UDMA
+	default y
+	help
+	  Say y here to support the K3 NAVSS DMA glue interface
+	  If unsure, say N.
+
 config TI_DMA_CROSSBAR
 	bool
diff --git a/drivers/dma/ti/Makefile b/drivers/dma/ti/Makefile
index ebd4822e064e..fc6e0a2c7ce9 100644
--- a/drivers/dma/ti/Makefile
+++ b/drivers/dma/ti/Makefile
@@ -3,4 +3,5 @@ obj-$(CONFIG_TI_CPPI41) += cppi41.o
 obj-$(CONFIG_TI_EDMA) += edma.o
 obj-$(CONFIG_DMA_OMAP) += omap-dma.o
 obj-$(CONFIG_TI_K3_UDMA) += k3-udma.o
+obj-$(CONFIG_TI_K3_UDMA_GLUE_LAYER) += k3-udma-glue.o
 obj-$(CONFIG_TI_DMA_CROSSBAR) += dma-crossbar.o
diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
new file mode 100644
index 000000000000..43284ccb52f4
--- /dev/null
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -0,0 +1,1039 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * K3 NAVSS DMA glue interface
+ *
+ * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
+ *
+ */
+
+#include <linux/atomic.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <dt-bindings/dma/k3-udma.h>
+#include <linux/soc/ti/k3-ringacc.h>
+#include <linux/dma/ti-cppi5.h>
+#include <linux/dma/k3-udma-glue.h>
+
+#include "k3-udma.h"
+
+struct k3_udma_glue_common {
+	struct device *dev;
+	struct udma_dev *udmax;
+	const struct udma_tisci_rm *tisci_rm;
+	struct k3_ringacc *ringacc;
+	u32 src_thread;
+	u32 dst_thread;
+
+	u32  hdesc_size;
+	bool epib;
+	u32  psdata_size;
+	u32  swdata_size;
+};
+
+struct k3_udma_glue_tx_channel {
+	struct k3_udma_glue_common common;
+
+	struct udma_tchan *udma_tchanx;
+	int udma_tchan_id;
+	bool need_tisci_free;
+
+	struct k3_ring *ringtx;
+	struct k3_ring *ringtxcq;
+
+	bool psil_paired;
+
+	int virq;
+
+	atomic_t free_pkts;
+	bool tx_pause_on_err;
+	bool tx_filt_einfo;
+	bool tx_filt_pswords;
+	bool tx_supr_tdpkt;
+};
+
+/**
+ * k3_udma_glue_rx_flow - UDMA RX flow context data
+ *
+ */
+struct k3_udma_glue_rx_flow {
+	struct udma_rflow *udma_rflow;
+	int udma_rflow_id;
+	struct k3_ring *ringrx;
+	struct k3_ring *ringrxfdq;
+
+	int virq;
+};
+
+struct k3_udma_glue_rx_channel {
+	struct k3_udma_glue_common common;
+
+	struct udma_rchan *udma_rchanx;
+	int udma_rchan_id;
+	bool need_tisci_free;
+
+	bool psil_paired;
+
+	u32  swdata_size;
+	int  flow_id_base;
+
+	struct k3_udma_glue_rx_flow *flows;
+	u32 flow_num;
+	u32 flows_ready;
+};
+
+#define K3_UDMAX_TDOWN_TIMEOUT_US 1000
+
+static int of_k3_udma_glue_parse(struct device_node *udmax_np,
+				 struct k3_udma_glue_common *common)
+{
+	common->ringacc = of_k3_ringacc_get_by_phandle(udmax_np,
+						       "ti,ringacc");
+	if (IS_ERR(common->ringacc))
+		return PTR_ERR(common->ringacc);
+
+	common->udmax = of_xudma_dev_get(udmax_np, NULL);
+	if (IS_ERR(common->udmax))
+		return PTR_ERR(common->udmax);
+
+	common->tisci_rm = xudma_dev_get_tisci_rm(common->udmax);
+
+	return 0;
+}
+
+static int of_k3_udma_glue_parse_chn(struct device_node *chn_np,
+		const char *name, struct k3_udma_glue_common *common,
+		bool tx_chn)
+{
+	struct device_node *psil_cfg_node;
+	struct device_node *ch_cfg_node;
+	struct of_phandle_args dma_spec;
+	int index, ret = 0;
+	char prop[50];
+	u32 val;
+
+	if (unlikely(!name))
+		return -EINVAL;
+
+	index = of_property_match_string(chn_np, "dma-names", name);
+	if (index < 0)
+		return index;
+
+	if (of_parse_phandle_with_args(chn_np, "dmas", "#dma-cells", index,
+				       &dma_spec))
+		return -ENOENT;
+
+	if (tx_chn && dma_spec.args[2] != UDMA_DIR_TX) {
+		ret = -EINVAL;
+		goto out_put_spec;
+	}
+
+	if (!tx_chn && dma_spec.args[2] != UDMA_DIR_RX) {
+		ret = -EINVAL;
+		goto out_put_spec;
+	}
+
+	/* get psil cfg node */
+	psil_cfg_node = of_find_node_by_phandle(dma_spec.args[0]);
+	if (!psil_cfg_node) {
+		ret = -ENOENT;
+		goto out_put_spec;
+	}
+
+	snprintf(prop, sizeof(prop), "ti,psil-config%u", dma_spec.args[1]);
+	ch_cfg_node = of_find_node_by_name(psil_cfg_node, prop);
+	if (!ch_cfg_node) {
+		dev_err(common->dev,
+			"Channel %u configuration node is missing\n",
+			dma_spec.args[1]);
+		goto out_put_psil_cfg;
+	}
+
+	common->epib = of_property_read_bool(ch_cfg_node, "ti,needs-epib");
+
+	if (!of_property_read_u32(ch_cfg_node, "ti,psd-size", &val))
+		common->psdata_size = val;
+
+	ret = of_property_read_u32(psil_cfg_node, "ti,psil-base", &val);
+	if (ret) {
+		dev_err(common->dev, "ti,psil-base is missing %d\n", ret);
+		goto out_ch_cfg;
+	}
+
+	if (tx_chn)
+		common->dst_thread = val + dma_spec.args[1];
+	else
+		common->src_thread = val + dma_spec.args[1];
+	ret = of_k3_udma_glue_parse(dma_spec.np, common);
+
+out_ch_cfg:
+	of_node_put(ch_cfg_node);
+out_put_psil_cfg:
+	of_node_put(psil_cfg_node);
+out_put_spec:
+	of_node_put(dma_spec.np);
+	return ret;
+};
+
+static void k3_udma_glue_dump_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
+{
+	struct device *dev = tx_chn->common.dev;
+
+	dev_dbg(dev, "dump_tx_chn:\n"
+		"udma_tchan_id: %d\n"
+		"src_thread: %08x\n"
+		"dst_thread: %08x\n",
+		tx_chn->udma_tchan_id,
+		tx_chn->common.src_thread,
+		tx_chn->common.dst_thread);
+}
+
+static void k3_udma_glue_dump_tx_rt_chn(struct k3_udma_glue_tx_channel *chn,
+					char *mark)
+{
+	struct device *dev = chn->common.dev;
+
+	dev_dbg(dev, "=== dump ===> %s\n", mark);
+	dev_dbg(dev, "0x%08X: %08X\n", UDMA_TCHAN_RT_CTL_REG,
+		xudma_tchanrt_read(chn->udma_tchanx, UDMA_TCHAN_RT_CTL_REG));
+	dev_dbg(dev, "0x%08X: %08X\n", UDMA_TCHAN_RT_PEER_RT_EN_REG,
+		xudma_tchanrt_read(chn->udma_tchanx,
+				   UDMA_TCHAN_RT_PEER_RT_EN_REG));
+	dev_dbg(dev, "0x%08X: %08X\n", UDMA_TCHAN_RT_PCNT_REG,
+		xudma_tchanrt_read(chn->udma_tchanx, UDMA_TCHAN_RT_PCNT_REG));
+	dev_dbg(dev, "0x%08X: %08X\n", UDMA_TCHAN_RT_BCNT_REG,
+		xudma_tchanrt_read(chn->udma_tchanx, UDMA_TCHAN_RT_BCNT_REG));
+	dev_dbg(dev, "0x%08X: %08X\n", UDMA_TCHAN_RT_SBCNT_REG,
+		xudma_tchanrt_read(chn->udma_tchanx, UDMA_TCHAN_RT_SBCNT_REG));
+}
+
+static int k3_udma_glue_cfg_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
+{
+	const struct udma_tisci_rm *tisci_rm = tx_chn->common.tisci_rm;
+	struct ti_sci_msg_rm_udmap_tx_ch_cfg req;
+
+	memset(&req, 0, sizeof(req));
+
+	req.valid_params = TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_FILT_EINFO_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_FILT_PSWORDS_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_CHAN_TYPE_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_SUPR_TDPKT_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_FETCH_SIZE_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_CQ_QNUM_VALID;
+	req.nav_id = tisci_rm->tisci_dev_id;
+	req.index = tx_chn->udma_tchan_id;
+	if (tx_chn->tx_pause_on_err)
+		req.tx_pause_on_err = 1;
+	if (tx_chn->tx_filt_einfo)
+		req.tx_filt_einfo = 1;
+	if (tx_chn->tx_filt_pswords)
+		req.tx_filt_pswords = 1;
+	req.tx_chan_type = TI_SCI_RM_UDMAP_CHAN_TYPE_PKT_PBRR;
+	if (tx_chn->tx_supr_tdpkt)
+		req.tx_supr_tdpkt = 1;
+	req.tx_fetch_size = tx_chn->common.hdesc_size >> 2;
+	req.txcq_qnum = k3_ringacc_get_ring_id(tx_chn->ringtxcq);
+
+	return tisci_rm->tisci_udmap_ops->tx_ch_cfg(tisci_rm->tisci, &req);
+}
+
+struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
+		const char *name, struct k3_udma_glue_tx_channel_cfg *cfg)
+{
+	struct k3_udma_glue_tx_channel *tx_chn;
+	int ret;
+
+	tx_chn = devm_kzalloc(dev, sizeof(*tx_chn), GFP_KERNEL);
+	if (!tx_chn)
+		return ERR_PTR(-ENOMEM);
+
+	tx_chn->common.dev = dev;
+	tx_chn->common.swdata_size = cfg->swdata_size;
+	tx_chn->tx_pause_on_err = cfg->tx_pause_on_err;
+	tx_chn->tx_filt_einfo = cfg->tx_filt_einfo;
+	tx_chn->tx_filt_pswords = cfg->tx_filt_pswords;
+	tx_chn->tx_supr_tdpkt = cfg->tx_supr_tdpkt;
+
+	/* parse of udmap channel */
+	ret = of_k3_udma_glue_parse_chn(dev->of_node, name,
+					&tx_chn->common, true);
+	if (ret)
+		goto err;
+
+	tx_chn->common.hdesc_size = cppi5_hdesc_calc_size(tx_chn->common.epib,
+						tx_chn->common.psdata_size,
+						tx_chn->common.swdata_size);
+
+	/* request and cfg UDMAP TX channel */
+	tx_chn->udma_tchanx = xudma_tchan_get(tx_chn->common.udmax, -1);
+	if (IS_ERR(tx_chn->udma_tchanx)) {
+		ret = PTR_ERR(tx_chn->udma_tchanx);
+		dev_err(dev, "UDMAX tchanx get err %d\n", ret);
+		goto err;
+	}
+	tx_chn->udma_tchan_id = xudma_tchan_get_id(tx_chn->udma_tchanx);
+
+	atomic_set(&tx_chn->free_pkts, cfg->txcq_cfg.size);
+
+	/* request and cfg rings */
+	tx_chn->ringtx = k3_ringacc_request_ring(tx_chn->common.ringacc,
+						 tx_chn->udma_tchan_id, 0);
+	if (!tx_chn->ringtx) {
+		ret = -ENODEV;
+		dev_err(dev, "Failed to get TX ring %u\n",
+			tx_chn->udma_tchan_id);
+		goto err;
+	}
+
+	tx_chn->ringtxcq = k3_ringacc_request_ring(tx_chn->common.ringacc,
+						   -1, 0);
+	if (!tx_chn->ringtxcq) {
+		ret = -ENODEV;
+		dev_err(dev, "Failed to get TXCQ ring\n");
+		goto err;
+	}
+
+	ret = k3_ringacc_ring_cfg(tx_chn->ringtx, &cfg->tx_cfg);
+	if (ret) {
+		dev_err(dev, "Failed to cfg ringtx %d\n", ret);
+		goto err;
+	}
+
+	ret = k3_ringacc_ring_cfg(tx_chn->ringtxcq, &cfg->txcq_cfg);
+	if (ret) {
+		dev_err(dev, "Failed to cfg ringtx %d\n", ret);
+		goto err;
+	}
+
+	/* request and cfg psi-l */
+	tx_chn->common.src_thread =
+			xudma_dev_get_psil_base(tx_chn->common.udmax) +
+			tx_chn->udma_tchan_id;
+
+	tx_chn->need_tisci_free = false;
+	ret = k3_udma_glue_cfg_tx_chn(tx_chn);
+	if (ret) {
+		dev_err(dev, "Failed to cfg tchan %d\n", ret);
+		goto err;
+	}
+
+	tx_chn->need_tisci_free = true;
+
+	ret = xudma_navss_psil_pair(tx_chn->common.udmax,
+				    tx_chn->common.src_thread,
+				    tx_chn->common.dst_thread);
+	if (ret) {
+		dev_err(dev, "PSI-L request err %d\n", ret);
+		goto err;
+	}
+
+	tx_chn->psil_paired = true;
+
+	k3_udma_glue_dump_tx_chn(tx_chn);
+
+	return tx_chn;
+
+err:
+	k3_udma_glue_release_tx_chn(tx_chn);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(k3_udma_glue_request_tx_chn);
+
+void k3_udma_glue_release_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
+{
+	if (tx_chn->psil_paired) {
+		xudma_navss_psil_unpair(tx_chn->common.udmax,
+					tx_chn->common.src_thread,
+					tx_chn->common.dst_thread);
+		tx_chn->psil_paired = false;
+	}
+
+	if (!IS_ERR_OR_NULL(tx_chn->common.udmax)) {
+		if (tx_chn->need_tisci_free)
+			tx_chn->need_tisci_free = false;
+
+		if (!IS_ERR_OR_NULL(tx_chn->udma_tchanx))
+			xudma_tchan_put(tx_chn->common.udmax,
+					tx_chn->udma_tchanx);
+
+		xudma_dev_put(tx_chn->common.udmax);
+	}
+
+	if (tx_chn->ringtxcq)
+		k3_ringacc_ring_free(tx_chn->ringtxcq);
+
+	if (tx_chn->ringtx)
+		k3_ringacc_ring_free(tx_chn->ringtx);
+}
+EXPORT_SYMBOL_GPL(k3_udma_glue_release_tx_chn);
+
+int k3_udma_glue_push_tx_chn(struct k3_udma_glue_tx_channel *tx_chn,
+			     struct cppi5_host_desc_t *desc_tx,
+			     dma_addr_t desc_dma)
+{
+	u32 ringtxcq_id;
+
+	if (!atomic_add_unless(&tx_chn->free_pkts, -1, 0))
+		return -ENOMEM;
+
+	ringtxcq_id = k3_ringacc_get_ring_id(tx_chn->ringtxcq);
+	cppi5_desc_set_retpolicy(&desc_tx->hdr, 0, ringtxcq_id);
+
+	return k3_ringacc_ring_push(tx_chn->ringtx, &desc_dma);
+}
+EXPORT_SYMBOL_GPL(k3_udma_glue_push_tx_chn);
+
+int k3_udma_glue_pop_tx_chn(struct k3_udma_glue_tx_channel *tx_chn,
+			    dma_addr_t *desc_dma)
+{
+	int ret;
+
+	ret = k3_ringacc_ring_pop(tx_chn->ringtxcq, desc_dma);
+	if (!ret)
+		atomic_inc(&tx_chn->free_pkts);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(k3_udma_glue_pop_tx_chn);
+
+int k3_udma_glue_enable_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
+{
+	u32 txrt_ctl;
+
+	txrt_ctl = UDMA_PEER_RT_EN_ENABLE;
+	xudma_tchanrt_write(tx_chn->udma_tchanx,
+			    UDMA_TCHAN_RT_PEER_RT_EN_REG,
+			    txrt_ctl);
+
+	txrt_ctl = xudma_tchanrt_read(tx_chn->udma_tchanx,
+				      UDMA_TCHAN_RT_CTL_REG);
+	txrt_ctl |= UDMA_CHAN_RT_CTL_EN;
+	xudma_tchanrt_write(tx_chn->udma_tchanx, UDMA_TCHAN_RT_CTL_REG,
+			    txrt_ctl);
+
+	k3_udma_glue_dump_tx_rt_chn(tx_chn, "txchn en");
+	return 0;
+}
+EXPORT_SYMBOL_GPL(k3_udma_glue_enable_tx_chn);
+
+void k3_udma_glue_disable_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
+{
+	k3_udma_glue_dump_tx_rt_chn(tx_chn, "txchn dis1");
+
+	xudma_tchanrt_write(tx_chn->udma_tchanx, UDMA_TCHAN_RT_CTL_REG, 0);
+
+	xudma_tchanrt_write(tx_chn->udma_tchanx,
+			    UDMA_TCHAN_RT_PEER_RT_EN_REG, 0);
+	k3_udma_glue_dump_tx_rt_chn(tx_chn, "txchn dis2");
+}
+EXPORT_SYMBOL_GPL(k3_udma_glue_disable_tx_chn);
+
+void k3_udma_glue_tdown_tx_chn(struct k3_udma_glue_tx_channel *tx_chn,
+			       bool sync)
+{
+	int i = 0;
+	u32 val;
+
+	k3_udma_glue_dump_tx_rt_chn(tx_chn, "txchn tdown1");
+
+	xudma_tchanrt_write(tx_chn->udma_tchanx, UDMA_TCHAN_RT_CTL_REG,
+			    UDMA_CHAN_RT_CTL_EN | UDMA_CHAN_RT_CTL_TDOWN);
+
+	val = xudma_tchanrt_read(tx_chn->udma_tchanx, UDMA_TCHAN_RT_CTL_REG);
+
+	while (sync && (val & UDMA_CHAN_RT_CTL_EN)) {
+		val = xudma_tchanrt_read(tx_chn->udma_tchanx,
+					 UDMA_TCHAN_RT_CTL_REG);
+		udelay(1);
+		if (i > K3_UDMAX_TDOWN_TIMEOUT_US) {
+			dev_err(tx_chn->common.dev, "TX tdown timeout\n");
+			break;
+		}
+		i++;
+	}
+
+	val = xudma_tchanrt_read(tx_chn->udma_tchanx,
+				 UDMA_TCHAN_RT_PEER_RT_EN_REG);
+	if (sync && (val & UDMA_PEER_RT_EN_ENABLE))
+		dev_err(tx_chn->common.dev, "TX tdown peer not stopped\n");
+	k3_udma_glue_dump_tx_rt_chn(tx_chn, "txchn tdown2");
+}
+EXPORT_SYMBOL_GPL(k3_udma_glue_tdown_tx_chn);
+
+void k3_udma_glue_reset_tx_chn(struct k3_udma_glue_tx_channel *tx_chn,
+			       void *data,
+			       void (*cleanup)(void *data, dma_addr_t desc_dma))
+{
+	dma_addr_t desc_dma;
+	int occ_tx, i, ret;
+
+	/* reset TXCQ as it is not input for udma - expected to be empty */
+	if (tx_chn->ringtxcq)
+		k3_ringacc_ring_reset(tx_chn->ringtxcq);
+
+	/*
+	 * TXQ reset need to be special way as it is input for udma and its
+	 * state cached by udma, so:
+	 * 1) save TXQ occ
+	 * 2) clean up TXQ and call callback .cleanup() for each desc
+	 * 3) reset TXQ in a special way
+	 */
+	occ_tx = k3_ringacc_ring_get_occ(tx_chn->ringtx);
+	dev_dbg(tx_chn->common.dev, "TX reset occ_tx %u\n", occ_tx);
+
+	for (i = 0; i < occ_tx; i++) {
+		ret = k3_ringacc_ring_pop(tx_chn->ringtx, &desc_dma);
+		if (ret) {
+			dev_err(tx_chn->common.dev, "TX reset pop %d\n", ret);
+			break;
+		}
+		cleanup(data, desc_dma);
+	}
+
+	k3_ringacc_ring_reset_dma(tx_chn->ringtx, occ_tx);
+}
+EXPORT_SYMBOL_GPL(k3_udma_glue_reset_tx_chn);
+
+u32 k3_udma_glue_tx_get_hdesc_size(struct k3_udma_glue_tx_channel *tx_chn)
+{
+	return tx_chn->common.hdesc_size;
+}
+EXPORT_SYMBOL_GPL(k3_udma_glue_tx_get_hdesc_size);
+
+u32 k3_udma_glue_tx_get_txcq_id(struct k3_udma_glue_tx_channel *tx_chn)
+{
+	return k3_ringacc_get_ring_id(tx_chn->ringtxcq);
+}
+EXPORT_SYMBOL_GPL(k3_udma_glue_tx_get_txcq_id);
+
+int k3_udma_glue_tx_get_irq(struct k3_udma_glue_tx_channel *tx_chn)
+{
+	tx_chn->virq = k3_ringacc_get_ring_irq_num(tx_chn->ringtxcq);
+
+	return tx_chn->virq;
+}
+EXPORT_SYMBOL_GPL(k3_udma_glue_tx_get_irq);
+
+static int k3_udma_glue_cfg_rx_chn(struct k3_udma_glue_rx_channel *rx_chn)
+{
+	const struct udma_tisci_rm *tisci_rm = rx_chn->common.tisci_rm;
+	struct ti_sci_msg_rm_udmap_rx_ch_cfg req;
+	int ret;
+
+	memset(&req, 0, sizeof(req));
+
+	req.valid_params = TI_SCI_MSG_VALUE_RM_UDMAP_CH_FETCH_SIZE_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_CQ_QNUM_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_CHAN_TYPE_VALID;
+
+	req.nav_id = tisci_rm->tisci_dev_id;
+	req.index = rx_chn->udma_rchan_id;
+	req.rx_fetch_size = rx_chn->common.hdesc_size >> 2;
+	/*
+	 * TODO: we can't support rxcq_qnum/RCHAN[a]_RCQ cfg with current sysfw
+	 * and udmax impl, so just configure it to invalid value.
+	 * req.rxcq_qnum = k3_ringacc_get_ring_id(rx_chn->flows[0].ringrx);
+	 */
+	req.rxcq_qnum = 0xFFFF;
+	if (rx_chn->flow_num && rx_chn->flow_id_base != rx_chn->udma_rchan_id) {
+		/* Default flow + extra ones */
+		req.flowid_start = rx_chn->flow_id_base;
+		req.flowid_cnt = rx_chn->flow_num;
+		req.valid_params |=
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_FLOWID_START_VALID |
+			TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_FLOWID_CNT_VALID;
+	}
+	req.rx_chan_type = TI_SCI_RM_UDMAP_CHAN_TYPE_PKT_PBRR;
+
+	ret = tisci_rm->tisci_udmap_ops->rx_ch_cfg(tisci_rm->tisci, &req);
+	if (ret)
+		dev_err(rx_chn->common.dev, "rchan%d cfg failed %d\n",
+			rx_chn->udma_rchan_id, ret);
+
+	return ret;
+}
+
+static void k3_udma_glue_release_rx_flow(struct k3_udma_glue_rx_channel *rx_chn,
+					 u32 flow_num)
+{
+	struct k3_udma_glue_rx_flow *flow = &rx_chn->flows[flow_num];
+
+	if (IS_ERR_OR_NULL(flow->udma_rflow))
+		return;
+
+	if (flow->ringrxfdq)
+		k3_ringacc_ring_free(flow->ringrxfdq);
+
+	if (flow->ringrx)
+		k3_ringacc_ring_free(flow->ringrx);
+
+	xudma_rflow_put(rx_chn->common.udmax, flow->udma_rflow);
+	rx_chn->flows_ready--;
+}
+
+static int k3_udma_glue_cfg_rx_flow(struct k3_udma_glue_rx_channel *rx_chn,
+				    u32 flow_idx,
+				    struct k3_udma_glue_rx_flow_cfg *flow_cfg)
+{
+	struct k3_udma_glue_rx_flow *flow = &rx_chn->flows[flow_idx];
+	const struct udma_tisci_rm *tisci_rm = rx_chn->common.tisci_rm;
+	struct device *dev = rx_chn->common.dev;
+	struct ti_sci_msg_rm_udmap_flow_cfg req;
+	int rx_ring_id;
+	int rx_ringfdq_id;
+	int ret = 0;
+
+	flow->udma_rflow = xudma_rflow_get(rx_chn->common.udmax,
+					   flow->udma_rflow_id);
+	if (IS_ERR(flow->udma_rflow)) {
+		ret = PTR_ERR(flow->udma_rflow);
+		dev_err(dev, "UDMAX rflow get err %d\n", ret);
+		goto err;
+	}
+
+	if (flow->udma_rflow_id != xudma_rflow_get_id(flow->udma_rflow)) {
+		xudma_rflow_put(rx_chn->common.udmax, flow->udma_rflow);
+		return -ENODEV;
+	}
+
+	/* request and cfg rings */
+	flow->ringrx = k3_ringacc_request_ring(rx_chn->common.ringacc,
+					       flow_cfg->ring_rxq_id, 0);
+	if (!flow->ringrx) {
+		ret = -ENODEV;
+		dev_err(dev, "Failed to get RX ring\n");
+		goto err;
+	}
+
+	flow->ringrxfdq = k3_ringacc_request_ring(rx_chn->common.ringacc,
+						  flow_cfg->ring_rxfdq0_id, 0);
+	if (!flow->ringrxfdq) {
+		ret = -ENODEV;
+		dev_err(dev, "Failed to get RXFDQ ring\n");
+		goto err;
+	}
+
+	ret = k3_ringacc_ring_cfg(flow->ringrx, &flow_cfg->rx_cfg);
+	if (ret) {
+		dev_err(dev, "Failed to cfg ringrx %d\n", ret);
+		goto err;
+	}
+
+	ret = k3_ringacc_ring_cfg(flow->ringrxfdq, &flow_cfg->rxfdq_cfg);
+	if (ret) {
+		dev_err(dev, "Failed to cfg ringrxfdq %d\n", ret);
+		goto err;
+	}
+
+	rx_ring_id = k3_ringacc_get_ring_id(flow->ringrx);
+	rx_ringfdq_id = k3_ringacc_get_ring_id(flow->ringrxfdq);
+
+	memset(&req, 0, sizeof(req));
+
+	req.valid_params =
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
+	req.nav_id = tisci_rm->tisci_dev_id;
+	req.flow_index = flow->udma_rflow_id;
+	if (rx_chn->common.epib)
+		req.rx_einfo_present = 1;
+	if (rx_chn->common.psdata_size)
+		req.rx_psinfo_present = 1;
+	if (flow_cfg->rx_error_handling)
+		req.rx_error_handling = 1;
+	req.rx_desc_type = 0;
+	req.rx_dest_qnum = rx_ring_id;
+	req.rx_src_tag_hi_sel = 0;
+	req.rx_src_tag_lo_sel = flow_cfg->src_tag_lo_sel;
+	req.rx_dest_tag_hi_sel = 0;
+	req.rx_dest_tag_lo_sel = 0;
+	req.rx_fdq0_sz0_qnum = rx_ringfdq_id;
+	req.rx_fdq1_qnum = rx_ringfdq_id;
+	req.rx_fdq2_qnum = rx_ringfdq_id;
+	req.rx_fdq3_qnum = rx_ringfdq_id;
+
+	ret = tisci_rm->tisci_udmap_ops->rx_flow_cfg(tisci_rm->tisci, &req);
+	if (ret) {
+		dev_err(dev, "flow%d config failed: %d\n", flow->udma_rflow_id,
+			ret);
+		goto err;
+	}
+
+	rx_chn->flows_ready++;
+
+	return 0;
+err:
+	k3_udma_glue_release_rx_flow(rx_chn, flow_idx);
+	return ret;
+}
+
+static void k3_udma_glue_dump_rx_chn(struct k3_udma_glue_rx_channel *chn)
+{
+	struct device *dev = chn->common.dev;
+
+	dev_dbg(dev, "dump_rx_chn:\n"
+		"udma_rchan_id: %d\n"
+		"src_thread: %08x\n"
+		"dst_thread: %08x\n"
+		"epib: %d\n"
+		"hdesc_size: %u\n"
+		"psdata_size: %u\n"
+		"swdata_size: %u\n"
+		"flow_id_base: %d\n"
+		"flow_num: %d\n",
+		chn->udma_rchan_id,
+		chn->common.src_thread,
+		chn->common.dst_thread,
+		chn->common.epib,
+		chn->common.hdesc_size,
+		chn->common.psdata_size,
+		chn->common.swdata_size,
+		chn->flow_id_base,
+		chn->flow_num);
+}
+
+static void k3_udma_glue_dump_rx_rt_chn(struct k3_udma_glue_rx_channel *chn,
+					char *mark)
+{
+	struct device *dev = chn->common.dev;
+
+	dev_dbg(dev, "=== dump ===> %s\n", mark);
+	dev_dbg(dev, "0x%08X: %08X\n", UDMA_RCHAN_RT_CTL_REG,
+		xudma_rchanrt_read(chn->udma_rchanx, UDMA_RCHAN_RT_CTL_REG));
+	dev_dbg(dev, "0x%08X: %08X\n", UDMA_RCHAN_RT_PEER_RT_EN_REG,
+		xudma_rchanrt_read(chn->udma_rchanx,
+				   UDMA_RCHAN_RT_PEER_RT_EN_REG));
+	dev_dbg(dev, "0x%08X: %08X\n", UDMA_RCHAN_RT_PCNT_REG,
+		xudma_rchanrt_read(chn->udma_rchanx, UDMA_RCHAN_RT_PCNT_REG));
+	dev_dbg(dev, "0x%08X: %08X\n", UDMA_RCHAN_RT_BCNT_REG,
+		xudma_rchanrt_read(chn->udma_rchanx, UDMA_RCHAN_RT_BCNT_REG));
+	dev_dbg(dev, "0x%08X: %08X\n", UDMA_RCHAN_RT_SBCNT_REG,
+		xudma_rchanrt_read(chn->udma_rchanx, UDMA_RCHAN_RT_SBCNT_REG));
+}
+
+struct k3_udma_glue_rx_channel *k3_udma_glue_request_rx_chn(struct device *dev,
+		const char *name, struct k3_udma_glue_rx_channel_cfg *cfg)
+{
+	struct k3_udma_glue_rx_channel *rx_chn;
+	int ret, i;
+
+	if (cfg->flow_id_num <= 0)
+		return ERR_PTR(-EINVAL);
+
+	if (cfg->flow_id_num != 1 &&
+	    (cfg->def_flow_cfg || cfg->flow_id_use_rxchan_id))
+		return ERR_PTR(-EINVAL);
+
+	rx_chn = devm_kzalloc(dev, sizeof(*rx_chn), GFP_KERNEL);
+	if (!rx_chn)
+		return ERR_PTR(-ENOMEM);
+
+	rx_chn->common.dev = dev;
+	rx_chn->common.swdata_size = cfg->swdata_size;
+
+	/* parse of udmap channel */
+	ret = of_k3_udma_glue_parse_chn(dev->of_node, name,
+					&rx_chn->common, false);
+	if (ret)
+		goto err;
+
+	rx_chn->common.hdesc_size = cppi5_hdesc_calc_size(rx_chn->common.epib,
+						rx_chn->common.psdata_size,
+						rx_chn->common.swdata_size);
+
+	/* request and cfg UDMAP RX channel */
+	rx_chn->udma_rchanx = xudma_rchan_get(rx_chn->common.udmax, -1);
+	if (IS_ERR(rx_chn->udma_rchanx)) {
+		ret = PTR_ERR(rx_chn->udma_rchanx);
+		dev_err(dev, "UDMAX rchanx get err %d\n", ret);
+		goto err;
+	}
+	rx_chn->udma_rchan_id = xudma_rchan_get_id(rx_chn->udma_rchanx);
+
+	rx_chn->flow_num = cfg->flow_id_num;
+	rx_chn->flow_id_base = cfg->flow_id_base;
+
+	/* Use RX channel id as flow id: target dev can't generate flow_id */
+	if (cfg->flow_id_use_rxchan_id)
+		rx_chn->flow_id_base = rx_chn->udma_rchan_id;
+
+	rx_chn->flows = devm_kcalloc(dev, rx_chn->flow_num,
+				     sizeof(*rx_chn->flows), GFP_KERNEL);
+	if (!rx_chn->flows) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	/* Reserve range of RX flows */
+	if (!cfg->flow_id_use_rxchan_id) {
+		ret = xudma_reserve_rflow_range(rx_chn->common.udmax,
+						rx_chn->flow_id_base,
+						rx_chn->flow_num);
+		if (ret < 0) {
+			dev_err(dev, "UDMAX reserve_rflow get err %d\n", ret);
+			goto err;
+		}
+		rx_chn->flow_id_base = ret;
+	}
+
+	for (i = 0; i < rx_chn->flow_num; i++)
+		rx_chn->flows[i].udma_rflow_id = rx_chn->flow_id_base + i;
+
+	/* request and cfg psi-l */
+	rx_chn->common.dst_thread =
+			xudma_dev_get_psil_base(rx_chn->common.udmax) +
+			rx_chn->udma_rchan_id;
+
+	rx_chn->need_tisci_free = false;
+	ret = k3_udma_glue_cfg_rx_chn(rx_chn);
+	if (ret) {
+		dev_err(dev, "Failed to cfg rchan %d\n", ret);
+		goto err;
+	}
+	rx_chn->need_tisci_free = true;
+
+	/* init default RX flow only if flow_num = 1 */
+	if (cfg->def_flow_cfg) {
+		ret = k3_udma_glue_cfg_rx_flow(rx_chn, 0, cfg->def_flow_cfg);
+		if (ret)
+			goto err;
+	}
+
+	if (!cfg->skip_psil) {
+		ret = xudma_navss_psil_pair(rx_chn->common.udmax,
+					    rx_chn->common.src_thread,
+					    rx_chn->common.dst_thread);
+		if (ret) {
+			dev_err(dev, "PSI-L request err %d\n", ret);
+			goto err;
+		}
+
+		rx_chn->psil_paired = true;
+	}
+
+	k3_udma_glue_dump_rx_chn(rx_chn);
+
+	return rx_chn;
+
+err:
+	k3_udma_glue_release_rx_chn(rx_chn);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(k3_udma_glue_request_rx_chn);
+
+void k3_udma_glue_release_rx_chn(struct k3_udma_glue_rx_channel *rx_chn)
+{
+	int i;
+
+	if (rx_chn->psil_paired) {
+		xudma_navss_psil_unpair(rx_chn->common.udmax,
+					rx_chn->common.src_thread,
+					rx_chn->common.dst_thread);
+		rx_chn->psil_paired = false;
+	}
+
+	if (IS_ERR_OR_NULL(rx_chn->common.udmax))
+		return;
+
+	for (i = 0; i < rx_chn->flow_num; i++)
+		k3_udma_glue_release_rx_flow(rx_chn, i);
+
+	if (rx_chn->need_tisci_free)
+		rx_chn->need_tisci_free = false;
+
+	xudma_free_rflow_range(rx_chn->common.udmax,
+			       rx_chn->flow_id_base, rx_chn->flow_num);
+
+	if (!IS_ERR_OR_NULL(rx_chn->udma_rchanx))
+		xudma_rchan_put(rx_chn->common.udmax,
+				rx_chn->udma_rchanx);
+
+	xudma_dev_put(rx_chn->common.udmax);
+}
+EXPORT_SYMBOL_GPL(k3_udma_glue_release_rx_chn);
+
+int k3_udma_glue_rx_flow_init(struct k3_udma_glue_rx_channel *rx_chn,
+			      u32 flow_idx,
+			      struct k3_udma_glue_rx_flow_cfg *flow_cfg)
+{
+	if (flow_idx >= rx_chn->flow_num)
+		return -EINVAL;
+
+	return k3_udma_glue_cfg_rx_flow(rx_chn, flow_idx, flow_cfg);
+}
+EXPORT_SYMBOL_GPL(k3_udma_glue_rx_flow_init);
+
+u32 k3_udma_glue_rx_flow_get_fdq_id(struct k3_udma_glue_rx_channel *rx_chn,
+				    u32 flow_idx)
+{
+	struct k3_udma_glue_rx_flow *flow;
+
+	if (flow_idx >= rx_chn->flow_num)
+		return -EINVAL;
+
+	flow = &rx_chn->flows[flow_idx];
+
+	return k3_ringacc_get_ring_id(flow->ringrxfdq);
+}
+EXPORT_SYMBOL_GPL(k3_udma_glue_rx_flow_get_fdq_id);
+
+u32 k3_udma_glue_rx_get_flow_id_base(struct k3_udma_glue_rx_channel *rx_chn)
+{
+	return rx_chn->flow_id_base;
+}
+EXPORT_SYMBOL_GPL(k3_udma_glue_rx_get_flow_id_base);
+
+int k3_udma_glue_enable_rx_chn(struct k3_udma_glue_rx_channel *rx_chn)
+{
+	u32 rxrt_ctl;
+
+	if (rx_chn->flows_ready < rx_chn->flow_num)
+		return -EINVAL;
+
+	rxrt_ctl = xudma_rchanrt_read(rx_chn->udma_rchanx,
+				      UDMA_RCHAN_RT_CTL_REG);
+	rxrt_ctl |= UDMA_CHAN_RT_CTL_EN;
+	xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_RCHAN_RT_CTL_REG,
+			    rxrt_ctl);
+
+	xudma_rchanrt_write(rx_chn->udma_rchanx,
+			    UDMA_RCHAN_RT_PEER_RT_EN_REG,
+			    UDMA_PEER_RT_EN_ENABLE);
+
+	k3_udma_glue_dump_rx_rt_chn(rx_chn, "rxrt en");
+	return 0;
+}
+EXPORT_SYMBOL_GPL(k3_udma_glue_enable_rx_chn);
+
+void k3_udma_glue_disable_rx_chn(struct k3_udma_glue_rx_channel *rx_chn)
+{
+	k3_udma_glue_dump_rx_rt_chn(rx_chn, "rxrt dis1");
+
+	xudma_rchanrt_write(rx_chn->udma_rchanx,
+			    UDMA_RCHAN_RT_PEER_RT_EN_REG,
+			    0);
+	xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_RCHAN_RT_CTL_REG, 0);
+
+	k3_udma_glue_dump_rx_rt_chn(rx_chn, "rxrt dis2");
+}
+EXPORT_SYMBOL_GPL(k3_udma_glue_disable_rx_chn);
+
+void k3_udma_glue_tdown_rx_chn(struct k3_udma_glue_rx_channel *rx_chn,
+			       bool sync)
+{
+	int i = 0;
+	u32 val;
+
+	k3_udma_glue_dump_rx_rt_chn(rx_chn, "rxrt tdown1");
+
+	xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_RCHAN_RT_PEER_RT_EN_REG,
+			    UDMA_PEER_RT_EN_ENABLE | UDMA_PEER_RT_EN_TEARDOWN);
+
+	val = xudma_rchanrt_read(rx_chn->udma_rchanx, UDMA_RCHAN_RT_CTL_REG);
+
+	while (sync && (val & UDMA_CHAN_RT_CTL_EN)) {
+		val = xudma_rchanrt_read(rx_chn->udma_rchanx,
+					 UDMA_RCHAN_RT_CTL_REG);
+		udelay(1);
+		if (i > K3_UDMAX_TDOWN_TIMEOUT_US) {
+			dev_err(rx_chn->common.dev, "RX tdown timeout\n");
+			break;
+		}
+		i++;
+	}
+
+	val = xudma_rchanrt_read(rx_chn->udma_rchanx,
+				 UDMA_RCHAN_RT_PEER_RT_EN_REG);
+	if (sync && (val & UDMA_PEER_RT_EN_ENABLE))
+		dev_err(rx_chn->common.dev, "TX tdown peer not stopped\n");
+	k3_udma_glue_dump_rx_rt_chn(rx_chn, "rxrt tdown2");
+}
+EXPORT_SYMBOL_GPL(k3_udma_glue_tdown_rx_chn);
+
+void k3_udma_glue_reset_rx_chn(struct k3_udma_glue_rx_channel *rx_chn,
+		u32 flow_num, void *data,
+		void (*cleanup)(void *data, dma_addr_t desc_dma), bool skip_fdq)
+{
+	struct k3_udma_glue_rx_flow *flow = &rx_chn->flows[flow_num];
+	struct device *dev = rx_chn->common.dev;
+	dma_addr_t desc_dma;
+	int occ_rx, i, ret;
+
+	/* reset RXCQ as it is not input for udma - expected to be empty */
+	if (flow->ringrx)
+		k3_ringacc_ring_reset(flow->ringrx);
+
+	/* Skip RX FDQ in case one FDQ is used for the set of flows */
+	if (skip_fdq)
+		return;
+
+	/*
+	 * RX FDQ reset need to be special way as it is input for udma and its
+	 * state cached by udma, so:
+	 * 1) save RX FDQ occ
+	 * 2) clean up RX FDQ and call callback .cleanup() for each desc
+	 * 3) reset RX FDQ in a special way
+	 */
+	occ_rx = k3_ringacc_ring_get_occ(flow->ringrxfdq);
+	dev_dbg(dev, "RX reset flow %u occ_tx %u\n", flow_num, occ_rx);
+
+	for (i = 0; i < occ_rx; i++) {
+		ret = k3_ringacc_ring_pop(flow->ringrxfdq, &desc_dma);
+		if (ret) {
+			dev_err(dev, "RX reset pop %d\n", ret);
+			break;
+		}
+		cleanup(data, desc_dma);
+	}
+
+	k3_ringacc_ring_reset_dma(flow->ringrxfdq, occ_rx);
+}
+EXPORT_SYMBOL_GPL(k3_udma_glue_reset_rx_chn);
+
+int k3_udma_glue_push_rx_chn(struct k3_udma_glue_rx_channel *rx_chn,
+			     u32 flow_num, struct cppi5_host_desc_t *desc_rx,
+			     dma_addr_t desc_dma)
+{
+	struct k3_udma_glue_rx_flow *flow = &rx_chn->flows[flow_num];
+
+	return k3_ringacc_ring_push(flow->ringrxfdq, &desc_dma);
+}
+EXPORT_SYMBOL_GPL(k3_udma_glue_push_rx_chn);
+
+int k3_udma_glue_pop_rx_chn(struct k3_udma_glue_rx_channel *rx_chn,
+			    u32 flow_num, dma_addr_t *desc_dma)
+{
+	struct k3_udma_glue_rx_flow *flow = &rx_chn->flows[flow_num];
+
+	return k3_ringacc_ring_pop(flow->ringrx, desc_dma);
+}
+EXPORT_SYMBOL_GPL(k3_udma_glue_pop_rx_chn);
+
+int k3_udma_glue_rx_get_irq(struct k3_udma_glue_rx_channel *rx_chn,
+			    u32 flow_num)
+{
+	struct k3_udma_glue_rx_flow *flow;
+
+	flow = &rx_chn->flows[flow_num];
+
+	flow->virq = k3_ringacc_get_ring_irq_num(flow->ringrx);
+
+	return flow->virq;
+}
+EXPORT_SYMBOL_GPL(k3_udma_glue_rx_get_irq);
diff --git a/drivers/dma/ti/k3-udma-private.c b/drivers/dma/ti/k3-udma-private.c
new file mode 100644
index 000000000000..2b75f9d0af10
--- /dev/null
+++ b/drivers/dma/ti/k3-udma-private.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
+ *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
+ */
+
+int xudma_navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread)
+{
+	return navss_psil_pair(ud, src_thread, dst_thread);
+}
+EXPORT_SYMBOL(xudma_navss_psil_pair);
+
+int xudma_navss_psil_unpair(struct udma_dev *ud, u32 src_thread, u32 dst_thread)
+{
+	return navss_psil_unpair(ud, src_thread, dst_thread);
+}
+EXPORT_SYMBOL(xudma_navss_psil_unpair);
+
+struct udma_dev *of_xudma_dev_get(struct device_node *np, const char *property)
+{
+	struct device_node *udma_node = np;
+	struct platform_device *pdev;
+	struct udma_dev *ud;
+
+	if (property) {
+		udma_node = of_parse_phandle(np, property, 0);
+		if (!udma_node) {
+			pr_err("UDMA node is not found\n");
+			return ERR_PTR(-ENODEV);
+		}
+	}
+
+	pdev = of_find_device_by_node(udma_node);
+	if (!pdev) {
+		pr_err("UDMA device not found\n");
+		return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	if (np != udma_node)
+		of_node_put(udma_node);
+
+	ud = platform_get_drvdata(pdev);
+	if (!ud) {
+		pr_err("UDMA has not been proped\n");
+		return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	pm_runtime_get_sync(&pdev->dev);
+
+	return ud;
+}
+EXPORT_SYMBOL(of_xudma_dev_get);
+
+void xudma_dev_put(struct udma_dev *ud)
+{
+	pm_runtime_put_sync(ud->ddev.dev);
+}
+EXPORT_SYMBOL(xudma_dev_put);
+
+u32 xudma_dev_get_psil_base(struct udma_dev *ud)
+{
+	return ud->psil_base;
+}
+EXPORT_SYMBOL(xudma_dev_get_psil_base);
+
+struct udma_tisci_rm *xudma_dev_get_tisci_rm(struct udma_dev *ud)
+{
+	return &ud->tisci_rm;
+}
+EXPORT_SYMBOL(xudma_dev_get_tisci_rm);
+
+int xudma_reserve_rflow_range(struct udma_dev *ud, int from, int cnt)
+{
+	return __udma_reserve_rflow_range(ud, from, cnt);
+}
+EXPORT_SYMBOL(xudma_reserve_rflow_range);
+
+int xudma_free_rflow_range(struct udma_dev *ud, int from, int cnt)
+{
+	return __udma_free_rflow_range(ud, from, cnt);
+}
+EXPORT_SYMBOL(xudma_free_rflow_range);
+
+#define XUDMA_GET_PUT_RESOURCE(res)					\
+struct udma_##res *xudma_##res##_get(struct udma_dev *ud, int id)	\
+{									\
+	return __udma_reserve_##res(ud, false, id);			\
+}									\
+EXPORT_SYMBOL(xudma_##res##_get);					\
+									\
+void xudma_##res##_put(struct udma_dev *ud, struct udma_##res *p)	\
+{									\
+	clear_bit(p->id, ud->res##_map);				\
+}									\
+EXPORT_SYMBOL(xudma_##res##_put)
+XUDMA_GET_PUT_RESOURCE(tchan);
+XUDMA_GET_PUT_RESOURCE(rchan);
+XUDMA_GET_PUT_RESOURCE(rflow);
+
+#define XUDMA_GET_RESOURCE_ID(res)					\
+int xudma_##res##_get_id(struct udma_##res *p)				\
+{									\
+	return p->id;							\
+}									\
+EXPORT_SYMBOL(xudma_##res##_get_id)
+XUDMA_GET_RESOURCE_ID(tchan);
+XUDMA_GET_RESOURCE_ID(rchan);
+XUDMA_GET_RESOURCE_ID(rflow);
+
+/* Exported register access functions */
+#define XUDMA_RT_IO_FUNCTIONS(res)					\
+u32 xudma_##res##rt_read(struct udma_##res *p, int reg)			\
+{									\
+	return udma_##res##rt_read(p, reg);				\
+}									\
+EXPORT_SYMBOL(xudma_##res##rt_read);					\
+									\
+void xudma_##res##rt_write(struct udma_##res *p, int reg, u32 val)	\
+{									\
+	udma_##res##rt_write(p, reg, val);				\
+}									\
+EXPORT_SYMBOL(xudma_##res##rt_write)
+XUDMA_RT_IO_FUNCTIONS(tchan);
+XUDMA_RT_IO_FUNCTIONS(rchan);
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index be5714872f57..aca2f6ca7d4b 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -1007,6 +1007,64 @@ static irqreturn_t udma_udma_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+/**
+ * __udma_reserve_rflow_range - reserve range of flow ids
+ * @ud: UDMA device
+ * @from: Start the search from this flow id number
+ * @cnt: Number of consecutive flow ids to allocate
+ *
+ * Reserve range of flow ids for future use, those flows can be allocated
+ * only using explicit flow id number. if @from is set to -1 it will try to find
+ * first free range. if @from is positive value it will force allocation only
+ * of the specified range of flows.
+ *
+ * Returns -ENOMEM if can't find free range.
+ * -EEXIST if requested range is busy.
+ * -EINVAL if wrong input values passed.
+ * Returns flow id on success.
+ */
+static int __udma_reserve_rflow_range(struct udma_dev *ud, int from, int cnt)
+{
+	int start, tmp_from;
+	DECLARE_BITMAP(tmp, K3_UDMA_MAX_RFLOWS);
+
+	tmp_from = from;
+	if (tmp_from < 0)
+		tmp_from = ud->rchan_cnt;
+	/* default flows can't be reserved and accessible only by id */
+	if (tmp_from < ud->rchan_cnt)
+		return -EINVAL;
+
+	if (tmp_from + cnt > ud->rflow_cnt)
+		return -EINVAL;
+
+	bitmap_or(tmp, ud->rflow_map, ud->rflow_map_reserved,
+		  ud->rflow_cnt);
+
+	start = bitmap_find_next_zero_area(tmp,
+					   ud->rflow_cnt,
+					   tmp_from, cnt, 0);
+	if (start >= ud->rflow_cnt)
+		return -ENOMEM;
+
+	if (from >= 0 && start != from)
+		return -EEXIST;
+
+	bitmap_set(ud->rflow_map_reserved, start, cnt);
+	return start;
+}
+
+static int __udma_free_rflow_range(struct udma_dev *ud, int from, int cnt)
+{
+	if (from < ud->rchan_cnt)
+		return -EINVAL;
+	if (from + cnt > ud->rflow_cnt)
+		return -EINVAL;
+
+	bitmap_clear(ud->rflow_map_reserved, from, cnt);
+	return 0;
+}
+
 static struct udma_rflow *__udma_reserve_rflow(struct udma_dev *ud,
 					       enum udma_tp_level tpl, int id)
 {
@@ -3262,6 +3320,9 @@ static struct platform_driver udma_driver = {
 
 module_platform_driver(udma_driver);
 
+/* Private interfaces to UDMA */
+#include "k3-udma-private.c"
+
 MODULE_ALIAS("platform:ti-udma");
 MODULE_DESCRIPTION("TI K3 DMA driver for CPPI 5.0 compliant devices");
 MODULE_AUTHOR("Peter Ujfalusi <peter.ujfalusi@ti.com>");
diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
index 9704cb6ac855..4004373262e4 100644
--- a/drivers/dma/ti/k3-udma.h
+++ b/drivers/dma/ti/k3-udma.h
@@ -126,4 +126,34 @@ struct udma_tisci_rm {
 	struct ti_sci_resource *rm_ranges[RM_RANGE_LAST];
 };
 
+/* Direct access to UDMA low lever resources for the glue layer */
+int xudma_navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread);
+int xudma_navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
+			    u32 dst_thread);
+
+struct udma_dev *of_xudma_dev_get(struct device_node *np, const char *property);
+void xudma_dev_put(struct udma_dev *ud);
+u32 xudma_dev_get_psil_base(struct udma_dev *ud);
+struct udma_tisci_rm *xudma_dev_get_tisci_rm(struct udma_dev *ud);
+
+int xudma_reserve_rflow_range(struct udma_dev *ud, int from, int cnt);
+int xudma_free_rflow_range(struct udma_dev *ud, int from, int cnt);
+
+struct udma_tchan *xudma_tchan_get(struct udma_dev *ud, int id);
+struct udma_rchan *xudma_rchan_get(struct udma_dev *ud, int id);
+struct udma_rflow *xudma_rflow_get(struct udma_dev *ud, int id);
+
+void xudma_tchan_put(struct udma_dev *ud, struct udma_tchan *p);
+void xudma_rchan_put(struct udma_dev *ud, struct udma_rchan *p);
+void xudma_rflow_put(struct udma_dev *ud, struct udma_rflow *p);
+
+int xudma_tchan_get_id(struct udma_tchan *p);
+int xudma_rchan_get_id(struct udma_rchan *p);
+int xudma_rflow_get_id(struct udma_rflow *p);
+
+u32 xudma_tchanrt_read(struct udma_tchan *tchan, int reg);
+void xudma_tchanrt_write(struct udma_tchan *tchan, int reg, u32 val);
+u32 xudma_rchanrt_read(struct udma_rchan *rchan, int reg);
+void xudma_rchanrt_write(struct udma_rchan *rchan, int reg, u32 val);
+
 #endif /* K3_UDMA_H_ */
diff --git a/include/linux/dma/k3-udma-glue.h b/include/linux/dma/k3-udma-glue.h
new file mode 100644
index 000000000000..340d3eccf912
--- /dev/null
+++ b/include/linux/dma/k3-udma-glue.h
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
+ */
+
+#ifndef K3_UDMA_GLUE_H_
+#define K3_UDMA_GLUE_H_
+
+#include <linux/soc/ti/k3-ringacc.h>
+
+struct k3_udma_glue_tx_channel_cfg {
+	struct k3_ring_cfg tx_cfg;
+	struct k3_ring_cfg txcq_cfg;
+
+	bool tx_pause_on_err;
+	bool tx_filt_einfo;
+	bool tx_filt_pswords;
+	bool tx_supr_tdpkt;
+	u32  swdata_size;
+};
+
+struct k3_udma_glue_tx_channel;
+
+struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
+		const char *name, struct k3_udma_glue_tx_channel_cfg *cfg);
+
+void k3_udma_glue_release_tx_chn(struct k3_udma_glue_tx_channel *tx_chn);
+int k3_udma_glue_push_tx_chn(struct k3_udma_glue_tx_channel *tx_chn,
+			     struct cppi5_host_desc_t *desc_tx,
+			     dma_addr_t desc_dma);
+int k3_udma_glue_pop_tx_chn(struct k3_udma_glue_tx_channel *tx_chn,
+			    dma_addr_t *desc_dma);
+int k3_udma_glue_enable_tx_chn(struct k3_udma_glue_tx_channel *tx_chn);
+void k3_udma_glue_disable_tx_chn(struct k3_udma_glue_tx_channel *tx_chn);
+void k3_udma_glue_tdown_tx_chn(struct k3_udma_glue_tx_channel *tx_chn,
+			       bool sync);
+void k3_udma_glue_reset_tx_chn(struct k3_udma_glue_tx_channel *tx_chn,
+		void *data, void (*cleanup)(void *data, dma_addr_t desc_dma));
+u32 k3_udma_glue_tx_get_hdesc_size(struct k3_udma_glue_tx_channel *tx_chn);
+u32 k3_udma_glue_tx_get_txcq_id(struct k3_udma_glue_tx_channel *tx_chn);
+int k3_udma_glue_tx_get_irq(struct k3_udma_glue_tx_channel *tx_chn);
+
+enum {
+	K3_NAV_UDMAX_SRC_TAG_LO_KEEP = 0,
+	K3_NAV_UDMAX_SRC_TAG_LO_USE_FLOW_REG = 1,
+	K3_NAV_UDMAX_SRC_TAG_LO_USE_REMOTE_FLOW_ID = 2,
+	K3_NAV_UDMAX_SRC_TAG_LO_USE_REMOTE_SRC_TAG = 4,
+};
+
+/**
+ * k3_udma_glue_rx_flow_cfg - UDMA RX flow cfg
+ *
+ * @rx_cfg:		RX ring configuration
+ * @rxfdq_cfg:		RX free Host PD ring configuration
+ * @ring_rxq_id:	RX ring id (or -1 for any)
+ * @ring_rxfdq0_id:	RX free Host PD ring (FDQ) if (or -1 for any)
+ * @rx_error_handling:	Rx Error Handling Mode (0 - drop, 1 - re-try)
+ * @src_tag_lo_sel:	Rx Source Tag Low Byte Selector in Host PD
+ */
+struct k3_udma_glue_rx_flow_cfg {
+	struct k3_ring_cfg rx_cfg;
+	struct k3_ring_cfg rxfdq_cfg;
+	int ring_rxq_id;
+	int ring_rxfdq0_id;
+	bool rx_error_handling;
+	int src_tag_lo_sel;
+};
+
+/**
+ * k3_udma_glue_rx_channel_cfg - UDMA RX channel cfg
+ *
+ * @psdata_size:	SW Data is present in Host PD of @swdata_size bytes
+ * @flow_id_base:	first flow_id used by channel.
+ *			if @flow_id_base = -1 - flow ids range will be allocated
+ *			dynamically.
+ * @flow_id_num:	number of RX flows used by channel
+ * @flow_id_use_rxchan_id:	use RX channel id as flow id,
+ *				used only if @flow_id_num = 1
+ * @def_flow_cfg	default RX flow configuration,
+ *			used only if @flow_id_num = 1
+ */
+struct k3_udma_glue_rx_channel_cfg {
+	u32  swdata_size;
+	int  flow_id_base;
+	int  flow_id_num;
+	bool flow_id_use_rxchan_id;
+	bool skip_psil;
+
+	struct k3_udma_glue_rx_flow_cfg *def_flow_cfg;
+};
+
+struct k3_udma_glue_rx_channel;
+
+struct k3_udma_glue_rx_channel *k3_udma_glue_request_rx_chn(
+		struct device *dev,
+		const char *name,
+		struct k3_udma_glue_rx_channel_cfg *cfg);
+
+void k3_udma_glue_release_rx_chn(struct k3_udma_glue_rx_channel *rx_chn);
+int k3_udma_glue_enable_rx_chn(struct k3_udma_glue_rx_channel *rx_chn);
+void k3_udma_glue_disable_rx_chn(struct k3_udma_glue_rx_channel *rx_chn);
+void k3_udma_glue_tdown_rx_chn(struct k3_udma_glue_rx_channel *rx_chn,
+			       bool sync);
+int k3_udma_glue_push_rx_chn(struct k3_udma_glue_rx_channel *rx_chn,
+		u32 flow_num, struct cppi5_host_desc_t *desc_tx,
+		dma_addr_t desc_dma);
+int k3_udma_glue_pop_rx_chn(struct k3_udma_glue_rx_channel *rx_chn,
+		u32 flow_num, dma_addr_t *desc_dma);
+int k3_udma_glue_rx_flow_init(struct k3_udma_glue_rx_channel *rx_chn,
+		u32 flow_idx, struct k3_udma_glue_rx_flow_cfg *flow_cfg);
+u32 k3_udma_glue_rx_flow_get_fdq_id(struct k3_udma_glue_rx_channel *rx_chn,
+				    u32 flow_idx);
+u32 k3_udma_glue_rx_get_flow_id_base(struct k3_udma_glue_rx_channel *rx_chn);
+int k3_udma_glue_rx_get_irq(struct k3_udma_glue_rx_channel *rx_chn,
+			    u32 flow_num);
+void k3_udma_glue_rx_put_irq(struct k3_udma_glue_rx_channel *rx_chn,
+			     u32 flow_num);
+void k3_udma_glue_reset_rx_chn(struct k3_udma_glue_rx_channel *rx_chn,
+		u32 flow_num, void *data,
+		void (*cleanup)(void *data, dma_addr_t desc_dma),
+		bool skip_fdq);
+
+#endif /* K3_UDMA_GLUE_H_ */
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

