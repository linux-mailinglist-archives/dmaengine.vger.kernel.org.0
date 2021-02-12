Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C61C31A3D1
	for <lists+dmaengine@lfdr.de>; Fri, 12 Feb 2021 18:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhBLRjX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 12 Feb 2021 12:39:23 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:42844 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231611AbhBLRjF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 12 Feb 2021 12:39:05 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EEF8E40C73;
        Fri, 12 Feb 2021 17:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613151485; bh=NA4JeeG3cX+2fYKsMboULujwYLJgtmE/qoisVnvluZI=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=XXvklP52pnFcs/TyXgrz+8YDrXqR7M2HAMJYIXpmcmA6QF9uHj5DTze2KPnqV9nNJ
         xJ1NrttxOVPetTnNA1K4IS/c9RxeT73bl1D6ddX3uP7eFNbcIvWFMitYDH9pos+vtn
         rrltWfOKDCjXxWh8xbHdFvhvrrzZIWM/vmlOqQ1GtPUqI2SWztGwzVKZU/c7rzOLxR
         AvOWNS6WEREYaaZR8pfqkrBoBwAq7EzXTkiLakt04mVz91ML0qDgnf7xyPQWL5OpGn
         NcXjSblx6wkd9JfJ/BPkugD+dSPKMrrvmrJad9ljxYpM8lKzjK036qDJvw+roaDNON
         u0h/77GYn4i3A==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id BBA7CA005C;
        Fri, 12 Feb 2021 17:38:03 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v6 08/15] dmaengine: dw-edma: Reorder variables to keep consistency
Date:   Fri, 12 Feb 2021 18:37:43 +0100
Message-Id: <d9d6b08b01fb776f5e4a73ef781da9193b1b55d2.1613151392.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1613151392.git.gustavo.pimentel@synopsys.com>
References: <cover.1613151392.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1613151392.git.gustavo.pimentel@synopsys.com>
References: <cover.1613151392.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In the driver code structure, I tried to keep the code style consistency
by writing the write channels instructions first, and then follow by the
read channels instructions, mimicking the hardware implementation.

However, this code style failed in some cases. This patch fixes that and
no functional changes are expected.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 1ddea34..41384ff 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -20,8 +20,8 @@
 #define DW_PCIE_VSEC_DMA_ID			0x6
 #define DW_PCIE_VSEC_DMA_BAR			GENMASK(10, 8)
 #define DW_PCIE_VSEC_DMA_MAP			GENMASK(2, 0)
-#define DW_PCIE_VSEC_DMA_RD_CH			GENMASK(25, 16)
 #define DW_PCIE_VSEC_DMA_WR_CH			GENMASK(9, 0)
+#define DW_PCIE_VSEC_DMA_RD_CH			GENMASK(25, 16)
 
 struct dw_edma_pcie_data {
 	/* eDMA registers location */
@@ -39,8 +39,8 @@ struct dw_edma_pcie_data {
 	/* Other */
 	enum dw_edma_map_format		mf;
 	u8				irqs;
-	u16				rd_ch_cnt;
 	u16				wr_ch_cnt;
+	u16				rd_ch_cnt;
 };
 
 static const struct dw_edma_pcie_data snps_edda_data = {
@@ -59,8 +59,8 @@ static const struct dw_edma_pcie_data snps_edda_data = {
 	/* Other */
 	.mf				= EDMA_MF_EDMA_UNROLL,
 	.irqs				= 1,
-	.rd_ch_cnt			= 0,
 	.wr_ch_cnt			= 0,
+	.rd_ch_cnt			= 0,
 };
 
 static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
@@ -99,8 +99,8 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
 	pdata->rg_bar = FIELD_GET(DW_PCIE_VSEC_DMA_BAR, val);
 
 	pci_read_config_dword(pdev, vsec + 0xc, &val);
-	pdata->rd_ch_cnt = FIELD_GET(DW_PCIE_VSEC_DMA_RD_CH, val);
 	pdata->wr_ch_cnt = FIELD_GET(DW_PCIE_VSEC_DMA_WR_CH, val);
+	pdata->rd_ch_cnt = FIELD_GET(DW_PCIE_VSEC_DMA_RD_CH, val);
 
 	pci_read_config_dword(pdev, vsec + 0x14, &val);
 	off = val;
@@ -216,8 +216,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	dw->mf = vsec_data.mf;
 	dw->nr_irqs = nr_irqs;
 	dw->ops = &dw_edma_pcie_core_ops;
-	dw->rd_ch_cnt = vsec_data.rd_ch_cnt;
 	dw->wr_ch_cnt = vsec_data.wr_ch_cnt;
+	dw->rd_ch_cnt = vsec_data.rd_ch_cnt;
 
 	/* Debug info */
 	if (dw->mf == EDMA_MF_EDMA_LEGACY)
-- 
2.7.4

