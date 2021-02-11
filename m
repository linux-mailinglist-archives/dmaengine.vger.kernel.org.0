Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF30318700
	for <lists+dmaengine@lfdr.de>; Thu, 11 Feb 2021 10:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhBKJVm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 11 Feb 2021 04:21:42 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:56814 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230110AbhBKJON (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 11 Feb 2021 04:14:13 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5CA82C00C1;
        Thu, 11 Feb 2021 09:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613034783; bh=rP7FcyZIb2UiEc7bBGnoSeIkNGnft9AjTq7ZKuTESmg=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=EWBNZ5bl0UpZzXtqr5G0ycKrXG/UEhfWAAygmjT6CAY47zNjbFr9Zd4JEfbtJYg0G
         nkgf2QMJUCWWGywt9JmAcJ27+5xm5mt9zhBLe/23caWmzp4Ch30qnH1urYjiNDGVLj
         ltFILRe+BwnZBXvfxp3VKBgElZZyA7kFvIDxlZZvNOCjf+HiU1EWBz8nZYc1VhI2SI
         3kb7xxGsl6FsrJ915trrBNKG1HDGbzviUPp6utkcIeL51MHqyJFusCnSYye/KzF83O
         UOztRN6BGSR9JIvpxBxgLn2kKEX8s10aAk3JpjpJvpolcE3mpLuAoeojvIme7hbDMZ
         D4NC/0lv1u+Hg==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 23876A0061;
        Thu, 11 Feb 2021 09:13:02 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v5 08/15] dmaengine: dw-edma: Reorder variables to keep consistency
Date:   Thu, 11 Feb 2021 10:12:41 +0100
Message-Id: <61fe6e8555bfd8eb53fd104ebafb6ac2de3def59.1613034728.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
References: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
References: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
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

