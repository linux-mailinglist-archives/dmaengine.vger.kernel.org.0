Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9127368A63
	for <lists+dmaengine@lfdr.de>; Fri, 23 Apr 2021 03:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbhDWBbO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 22 Apr 2021 21:31:14 -0400
Received: from mx07-00376f01.pphosted.com ([185.132.180.163]:24280 "EHLO
        mx07-00376f01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239964AbhDWBbN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 22 Apr 2021 21:31:13 -0400
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
        by mx07-00376f01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 13N0xc8A008391;
        Fri, 23 Apr 2021 02:19:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=dk201812; bh=awzIVRW0kyxiBcPd5wocecT8nM+8mcnAfpBf9ybxBdg=;
 b=bxaItgavqMXaxTyTOTB35Iv7B3OEyDPvESTXNTxpFbSNceEsqQ8kKADHR/bTIa4N9AY1
 AN0fZZfIFkMgBPyaQ8j2SWNRUok++0y3Ab8q2O9lWmDaFqbbRgfMIVx2jfZQ9di2M9CQ
 a/mhOWeo4F7fjGBn3GF+AXR3KrLjeFz/TfJhSWRgREJlxKIufr8ZIBi3IwQ0B4WqPTx1
 5rfl5GmX2lTnyyW2Lu+61JkUq03e962v3pnjo3BhP9Ba5FC6vuJ0YZWTpo0Q0FMKsmeW
 mvLBGTj5SxU4PPp4uHACJ8+X7+d2N0ht+XONdfw+fX9UH4kgLKe8692ulFoGDtry2ES+ rg== 
Received: from hhmail05.hh.imgtec.org ([217.156.249.195])
        by mx07-00376f01.pphosted.com with ESMTP id 382p9395yh-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 23 Apr 2021 02:19:27 +0100
Received: from adrianlarumbe-HP-Elite-7500-Series-MT.hh.imgtec.org
 (10.100.70.86) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Apr 2021 02:19:25 +0100
From:   Adrian Larumbe <adrian.martinezlarumbe@imgtec.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC:     <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <adrian.martinezlarumbe@imgtec.com>
Subject: [PATCH 2/4] dmaengine: xilinx_dma: Add channel configuration setting callback
Date:   Fri, 23 Apr 2021 02:19:11 +0100
Message-ID: <20210423011913.13122-3-adrian.martinezlarumbe@imgtec.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423011913.13122-1-adrian.martinezlarumbe@imgtec.com>
References: <20210423011913.13122-1-adrian.martinezlarumbe@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.70.86]
X-ClientProxiedBy: HHMAIL05.hh.imgtec.org (10.100.10.120) To
 HHMAIL05.hh.imgtec.org (10.100.10.120)
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-GUID: a834GjnaYGV2bEHFbYpeLkGpU18nVCid
X-Proofpoint-ORIG-GUID: a834GjnaYGV2bEHFbYpeLkGpU18nVCid
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This callback allows the DMA Engine API user to set a per-channel
configuration structure before calling dmaengine_prep_slave_sg.
This is a prerequisite for being able to do CDMA SG transfers, because
one of the transfer ends is meant to be a preconfigured contiguous
block of memory.

A later implementation of CDMA SG transfers will access this configuration
structure, and is therefore dependent on this change.

Signed-off-by: Adrian Larumbe <adrian.martinezlarumbe@imgtec.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 3f859de593dc..49c7093e2487 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -392,6 +392,7 @@ struct xilinx_dma_tx_descriptor {
  * @irq: Channel IRQ
  * @id: Channel ID
  * @direction: Transfer direction
+ * @cfg: DMA slave channel configuration
  * @num_frms: Number of frames
  * @has_sg: Support scatter transfers
  * @cyclic: Check for cyclic transfers.
@@ -429,6 +430,7 @@ struct xilinx_dma_chan {
 	int irq;
 	int id;
 	enum dma_transfer_direction direction;
+	struct dma_slave_config cfg;
 	int num_frms;
 	bool has_sg;
 	bool cyclic;
@@ -2565,6 +2567,21 @@ static void xilinx_dma_chan_remove(struct xilinx_dma_chan *chan)
 	list_del(&chan->common.device_node);
 }
 
+/**
+ * xilinx_dma_slave_config - Set the channel config
+ * @dchan: DMA channel
+ * @cfg: DMA slave channel configuration
+ */
+static int xilinx_dma_slave_config(struct dma_chan *dchan,
+				   struct dma_slave_config *cfg)
+{
+	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
+
+	chan->cfg = *cfg;
+
+	return 0;
+}
+
 static int axidma_clk_init(struct platform_device *pdev, struct clk **axi_clk,
 			    struct clk **tx_clk, struct clk **rx_clk,
 			    struct clk **sg_clk, struct clk **tmp_clk)
@@ -3095,6 +3112,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	xdev->common.device_terminate_all = xilinx_dma_terminate_all;
 	xdev->common.device_tx_status = xilinx_dma_tx_status;
 	xdev->common.device_issue_pending = xilinx_dma_issue_pending;
+	xdev->common.device_config = xilinx_dma_slave_config;
 	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
 		dma_cap_set(DMA_CYCLIC, xdev->common.cap_mask);
 		xdev->common.device_prep_slave_sg = xilinx_dma_prep_slave_sg;
-- 
2.17.1

