Return-Path: <dmaengine+bounces-5030-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86489A9E922
	for <lists+dmaengine@lfdr.de>; Mon, 28 Apr 2025 09:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 994903AB45D
	for <lists+dmaengine@lfdr.de>; Mon, 28 Apr 2025 07:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8431F463A;
	Mon, 28 Apr 2025 07:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cBx64ppD"
X-Original-To: dmaengine@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDF81E9B04;
	Mon, 28 Apr 2025 07:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745824908; cv=none; b=l0NhsB5Gpzo/+bs9Rz/F5/+KK5wZDy5yxoW5cVizBtjwxUwVAS8Tyc5hoEB1//yKt8AbTx0nL6vEH9FxxIZPafXzRk69QUJPPjzeY8Cy4z3W5QNrjRHP52rwmYmk7qvteidBqqGLc8qUgtzh2bZeYt608giPo0a33Djak9xJmsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745824908; c=relaxed/simple;
	bh=9QIsBgJpumkpCS/3IBMZvkRjF8Ope94HemVtN3JBdmw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OAma/nqm5hu6h5wJaTZMmrpbeKalJet7AnFVXagVh1YfXOViB+rk9+WhOOJSGjk5U5opGjnRzqb4VSMcBKbR34V9153/0gTD/bOHYrcpP48twnmMHBfyqJjkeQy6xAt/V2XoFHIBVwPNuxA9yo52rnV5RMXiP43KiW1cM7+XE0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cBx64ppD; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53S7Ld9L2714025
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 02:21:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745824899;
	bh=WARFXUGJtQhHRkobO2Jt9PhPdz2OjBnXVVYXvYthk2U=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=cBx64ppDg50BmUdjKDgbTwgqAwnllsq2Sh8xyvhNwLdjjWWGKWnO4l65LekGp8aZY
	 7cM9WIUwZeEEAa6G4polt4AJxt/Ft9ZjHpQlP9H2wVR3KBT///dmpxCypRnEu9Ehz9
	 46hYKHpm0h6khB8Bxx0JOjz+y1ZRcby2Ysy5B2k0=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53S7LdUb121754
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Apr 2025 02:21:39 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Apr 2025 02:21:39 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Apr 2025 02:21:39 -0500
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.227.7])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53S7KdMh068873;
	Mon, 28 Apr 2025 02:21:34 -0500
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>, <s-adivi@ti.com>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <praneeth@ti.com>,
        <vigneshr@ti.com>, <u-kumar1@ti.com>, <a-chavda@ti.com>
Subject: [PATCH 8/8] dmaengine: ti: k3-udma-v2: Update glue layer to support PKTDMA V2
Date: Mon, 28 Apr 2025 12:50:32 +0530
Message-ID: <20250428072032.946008-9-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250428072032.946008-1-s-adivi@ti.com>
References: <20250428072032.946008-1-s-adivi@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Update glue layer to support PKTDMA V2 for non DMAengine users.

The updates include
- Handling absence of TISCI
- Direct IRQs
- Autopair: Lack of PSIL pair.

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 drivers/dma/ti/k3-udma-glue.c    | 91 ++++++++++++++++++++++----------
 drivers/dma/ti/k3-udma-private.c | 48 +++++++++++++++--
 drivers/dma/ti/k3-udma.h         |  2 +
 3 files changed, 110 insertions(+), 31 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index f87d244cc2d67..886d57dadacae 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -244,6 +244,9 @@ static int k3_udma_glue_cfg_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
 	const struct udma_tisci_rm *tisci_rm = tx_chn->common.tisci_rm;
 	struct ti_sci_msg_rm_udmap_tx_ch_cfg req;
 
+	if (!tisci_rm->tisci)
+		return 0;
+
 	memset(&req, 0, sizeof(req));
 
 	req.valid_params = TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |
@@ -502,21 +505,26 @@ int k3_udma_glue_enable_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
 {
 	int ret;
 
-	ret = xudma_navss_psil_pair(tx_chn->common.udmax,
-				    tx_chn->common.src_thread,
-				    tx_chn->common.dst_thread);
-	if (ret) {
-		dev_err(tx_chn->common.dev, "PSI-L request err %d\n", ret);
-		return ret;
-	}
+	if (tx_chn->common.udmax->match_data->type == DMA_TYPE_PKTDMA_V2) {
+		xudma_tchanrt_write(tx_chn->udma_tchanx, UDMA_CHAN_RT_CTL_REG,
+				UDMA_CHAN_RT_CTL_AUTOPAIR | UDMA_CHAN_RT_CTL_EN);
+	} else {
+		ret = xudma_navss_psil_pair(tx_chn->common.udmax,
+					    tx_chn->common.src_thread,
+					    tx_chn->common.dst_thread);
+		if (ret) {
+			dev_err(tx_chn->common.dev, "PSI-L request err %d\n", ret);
+			return ret;
+		}
 
-	tx_chn->psil_paired = true;
+		tx_chn->psil_paired = true;
 
-	xudma_tchanrt_write(tx_chn->udma_tchanx, UDMA_CHAN_RT_PEER_RT_EN_REG,
-			    UDMA_PEER_RT_EN_ENABLE);
+		xudma_tchanrt_write(tx_chn->udma_tchanx, UDMA_CHAN_RT_PEER_RT_EN_REG,
+				UDMA_PEER_RT_EN_ENABLE);
 
-	xudma_tchanrt_write(tx_chn->udma_tchanx, UDMA_CHAN_RT_CTL_REG,
-			    UDMA_CHAN_RT_CTL_EN);
+		xudma_tchanrt_write(tx_chn->udma_tchanx, UDMA_CHAN_RT_CTL_REG,
+				UDMA_CHAN_RT_CTL_EN);
+	}
 
 	k3_udma_glue_dump_tx_rt_chn(tx_chn, "txchn en");
 	return 0;
@@ -682,7 +690,6 @@ static int k3_udma_glue_cfg_rx_chn(struct k3_udma_glue_rx_channel *rx_chn)
 			   TI_SCI_MSG_VALUE_RM_UDMAP_CH_CHAN_TYPE_VALID |
 			   TI_SCI_MSG_VALUE_RM_UDMAP_CH_ATYPE_VALID;
 
-	req.nav_id = tisci_rm->tisci_dev_id;
 	req.index = rx_chn->udma_rchan_id;
 	req.rx_fetch_size = rx_chn->common.hdesc_size >> 2;
 	/*
@@ -702,11 +709,18 @@ static int k3_udma_glue_cfg_rx_chn(struct k3_udma_glue_rx_channel *rx_chn)
 	req.rx_chan_type = TI_SCI_RM_UDMAP_CHAN_TYPE_PKT_PBRR;
 	req.rx_atype = rx_chn->common.atype_asel;
 
+	if (!tisci_rm->tisci) {
+		// TODO: look at the chan settings
+		xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_CHAN_RT_CFG_REG,
+				    UDMA_CHAN_RT_CTL_TDOWN | UDMA_CHAN_RT_CTL_PAUSE);
+		return 0;
+	}
+
+	req.nav_id = tisci_rm->tisci_dev_id;
 	ret = tisci_rm->tisci_udmap_ops->rx_ch_cfg(tisci_rm->tisci, &req);
 	if (ret)
 		dev_err(rx_chn->common.dev, "rchan%d cfg failed %d\n",
-			rx_chn->udma_rchan_id, ret);
-
+				rx_chn->udma_rchan_id, ret);
 	return ret;
 }
 
@@ -755,8 +769,11 @@ static int k3_udma_glue_cfg_rx_flow(struct k3_udma_glue_rx_channel *rx_chn,
 	}
 
 	if (xudma_is_pktdma(rx_chn->common.udmax)) {
-		rx_ringfdq_id = flow->udma_rflow_id +
+		if (tisci_rm->tisci)
+			rx_ringfdq_id = flow->udma_rflow_id +
 				xudma_get_rflow_ring_offset(rx_chn->common.udmax);
+		else
+			rx_ringfdq_id = flow->udma_rflow_id;
 		rx_ring_id = 0;
 	} else {
 		rx_ring_id = flow_cfg->ring_rxq_id;
@@ -803,6 +820,13 @@ static int k3_udma_glue_cfg_rx_flow(struct k3_udma_glue_rx_channel *rx_chn,
 		rx_ringfdq_id = k3_ringacc_get_ring_id(flow->ringrxfdq);
 	}
 
+	if (!tisci_rm->tisci) {
+		xudma_rflowrt_write(flow->udma_rflow, UDMA_RX_FLOWRT_RFA,
+				UDMA_CHAN_RT_CTL_TDOWN | UDMA_CHAN_RT_CTL_PAUSE);
+		rx_chn->flows_ready++;
+		return 0;
+	}
+
 	memset(&req, 0, sizeof(req));
 
 	req.valid_params =
@@ -1307,6 +1331,9 @@ int k3_udma_glue_rx_flow_enable(struct k3_udma_glue_rx_channel *rx_chn,
 	if (!rx_chn->remote)
 		return -EINVAL;
 
+	if (!tisci_rm->tisci)
+		return 0;
+
 	rx_ring_id = k3_ringacc_get_ring_id(flow->ringrx);
 	rx_ringfdq_id = k3_ringacc_get_ring_id(flow->ringrxfdq);
 
@@ -1348,6 +1375,9 @@ int k3_udma_glue_rx_flow_disable(struct k3_udma_glue_rx_channel *rx_chn,
 	if (!rx_chn->remote)
 		return -EINVAL;
 
+	if (!tisci_rm->tisci)
+		return 0;
+
 	memset(&req, 0, sizeof(req));
 	req.valid_params =
 			TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_DEST_QNUM_VALID |
@@ -1383,21 +1413,26 @@ int k3_udma_glue_enable_rx_chn(struct k3_udma_glue_rx_channel *rx_chn)
 	if (rx_chn->flows_ready < rx_chn->flow_num)
 		return -EINVAL;
 
-	ret = xudma_navss_psil_pair(rx_chn->common.udmax,
-				    rx_chn->common.src_thread,
-				    rx_chn->common.dst_thread);
-	if (ret) {
-		dev_err(rx_chn->common.dev, "PSI-L request err %d\n", ret);
-		return ret;
-	}
+	if (rx_chn->common.udmax->match_data->type == DMA_TYPE_PKTDMA_V2) {
+		xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_CHAN_RT_CTL_REG,
+				UDMA_CHAN_RT_CTL_AUTOPAIR |  UDMA_CHAN_RT_CTL_EN);
+	} else {
+		ret = xudma_navss_psil_pair(rx_chn->common.udmax,
+					    rx_chn->common.src_thread,
+					    rx_chn->common.dst_thread);
+		if (ret) {
+			dev_err(rx_chn->common.dev, "PSI-L request err %d\n", ret);
+			return ret;
+		}
 
-	rx_chn->psil_paired = true;
+		rx_chn->psil_paired = true;
 
-	xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_CHAN_RT_CTL_REG,
-			    UDMA_CHAN_RT_CTL_EN);
+		xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_CHAN_RT_CTL_REG,
+				UDMA_CHAN_RT_CTL_EN);
 
-	xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_CHAN_RT_PEER_RT_EN_REG,
-			    UDMA_PEER_RT_EN_ENABLE);
+		xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_CHAN_RT_PEER_RT_EN_REG,
+				UDMA_PEER_RT_EN_ENABLE);
+	}
 
 	k3_udma_glue_dump_rx_rt_chn(rx_chn, "rxrt en");
 	return 0;
diff --git a/drivers/dma/ti/k3-udma-private.c b/drivers/dma/ti/k3-udma-private.c
index 05228bf000333..5fccb8d18c898 100644
--- a/drivers/dma/ti/k3-udma-private.c
+++ b/drivers/dma/ti/k3-udma-private.c
@@ -3,18 +3,28 @@
  *  Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
  *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
  */
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/interrupt.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 
 int xudma_navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread)
 {
-	return navss_psil_pair(ud, src_thread, dst_thread);
+	if (IS_ENABLED(CONFIG_TI_K3_UDMA))
+		return navss_psil_pair(ud, src_thread, dst_thread);
+
+	return 0;
 }
 EXPORT_SYMBOL(xudma_navss_psil_pair);
 
 int xudma_navss_psil_unpair(struct udma_dev *ud, u32 src_thread, u32 dst_thread)
 {
-	return navss_psil_unpair(ud, src_thread, dst_thread);
+	if (IS_ENABLED(CONFIG_TI_K3_UDMA))
+		return navss_psil_unpair(ud, src_thread, dst_thread);
+
+	return 0;
 }
 EXPORT_SYMBOL(xudma_navss_psil_unpair);
 
@@ -159,15 +169,32 @@ void xudma_##res##rt_write(struct udma_##res *p, int reg, u32 val)	\
 EXPORT_SYMBOL(xudma_##res##rt_write)
 XUDMA_RT_IO_FUNCTIONS(tchan);
 XUDMA_RT_IO_FUNCTIONS(rchan);
+XUDMA_RT_IO_FUNCTIONS(rflow);
 
 int xudma_is_pktdma(struct udma_dev *ud)
 {
-	return ud->match_data->type == DMA_TYPE_PKTDMA;
+	return (ud->match_data->type == DMA_TYPE_PKTDMA ||
+			ud->match_data->type == DMA_TYPE_PKTDMA_V2);
 }
 EXPORT_SYMBOL(xudma_is_pktdma);
 
 int xudma_pktdma_tflow_get_irq(struct udma_dev *ud, int udma_tflow_id)
 {
+	if (ud->match_data->type == DMA_TYPE_PKTDMA_V2) {
+		__be32 addr[2] = {0, 0};
+		struct of_phandle_args out_irq;
+		int ret;
+
+		out_irq.np = dev_of_node(ud->dev);
+		out_irq.args_count = 1;
+		out_irq.args[0] = udma_tflow_id;
+		ret = of_irq_parse_raw(addr, &out_irq);
+		if (ret)
+			return ret;
+
+		return irq_create_of_mapping(&out_irq);
+	}
+
 	const struct udma_oes_offsets *oes = &ud->soc_data->oes;
 
 	return msi_get_virq(ud->dev, udma_tflow_id + oes->pktdma_tchan_flow);
@@ -176,6 +203,21 @@ EXPORT_SYMBOL(xudma_pktdma_tflow_get_irq);
 
 int xudma_pktdma_rflow_get_irq(struct udma_dev *ud, int udma_rflow_id)
 {
+	if (ud->match_data->type == DMA_TYPE_PKTDMA_V2) {
+		__be32 addr[2] = {0, 0};
+		struct of_phandle_args out_irq;
+		int ret;
+
+		out_irq.np = dev_of_node(ud->dev);
+		out_irq.args_count = 1;
+		out_irq.args[0] = udma_rflow_id;
+		ret = of_irq_parse_raw(addr, &out_irq);
+		if (ret)
+			return ret;
+
+		return irq_create_of_mapping(&out_irq);
+	}
+
 	const struct udma_oes_offsets *oes = &ud->soc_data->oes;
 
 	return msi_get_virq(ud->dev, udma_rflow_id + oes->pktdma_rchan_flow);
diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
index a112ce4186ca9..b09a7339a6442 100644
--- a/drivers/dma/ti/k3-udma.h
+++ b/drivers/dma/ti/k3-udma.h
@@ -718,6 +718,8 @@ u32 xudma_rchanrt_read(struct udma_rchan *rchan, int reg);
 void xudma_rchanrt_write(struct udma_rchan *rchan, int reg, u32 val);
 bool xudma_rflow_is_gp(struct udma_dev *ud, int id);
 int xudma_get_rflow_ring_offset(struct udma_dev *ud);
+u32 xudma_rflowrt_read(struct udma_rflow *rflow, int reg);
+void xudma_rflowrt_write(struct udma_rflow *rflow, int reg, u32 val);
 
 int xudma_is_pktdma(struct udma_dev *ud);
 
-- 
2.34.1


