Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5C230BE98
	for <lists+dmaengine@lfdr.de>; Tue,  2 Feb 2021 13:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhBBMqc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Feb 2021 07:46:32 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:56128 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231761AbhBBMlz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 Feb 2021 07:41:55 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D87FCC00BA;
        Tue,  2 Feb 2021 12:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612269655; bh=rP7FcyZIb2UiEc7bBGnoSeIkNGnft9AjTq7ZKuTESmg=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=RZzkp0/o8ChPA+gazPHAPnCnh6phfhO/9/LOpmgSUtgUHkKCmI+5qWLUTpJmewBOD
         9mjNzYQvJwvc1PYCQPmHHKTgXeDxkp2yVb3aM8kRsNrMAczugYABULckeMlGKgV8ku
         GAdh5dddLh5+C1DJNS9eGfqZk/zA3OfJfUzOogJBSRmDae5O4CXGhPvPKS7sSlgaWq
         fYOH7slpgfbK2q7gnaGTK5luUT9IeaHzJY0QpKugHyw7Z4r/MA6lrf0L1daUbqsdob
         Bf8D9Sb78rjOsQxAW9A7+3AJQbr2MwR4w4HDi5ps+WtO+1l7VCDVE+ExL/gqdNx1cc
         8THdg/yci9LjQ==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 9E9C6A0249;
        Tue,  2 Feb 2021 12:40:53 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v2 08/15] dmaengine: dw-edma: Reorder variables to keep consistency
Date:   Tue,  2 Feb 2021 13:40:22 +0100
Message-Id: <644f1e5d460a090c3c61ba8f9c776b0aef506a82.1612269537.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1612269536.git.gustavo.pimentel@synopsys.com>
References: <cover.1612269536.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1612269536.git.gustavo.pimentel@synopsys.com>
References: <cover.1612269536.git.gustavo.pimentel@synopsys.com>
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
index 7077d79..9e79eb5 100644
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

