Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82F630E201
	for <lists+dmaengine@lfdr.de>; Wed,  3 Feb 2021 19:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbhBCSHZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Feb 2021 13:07:25 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:40786 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232399AbhBCR60 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Feb 2021 12:58:26 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1F308C010A;
        Wed,  3 Feb 2021 17:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612375043; bh=rP7FcyZIb2UiEc7bBGnoSeIkNGnft9AjTq7ZKuTESmg=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=i/hvJ8+cU5scehoahrF4EPyLGapTBVW2fM6TXM42w7lxnxIcg48h6tgfsb8zw7Bq5
         sFjfn7JdE8zF5Sfz/jU3mWlPYA2FaCfljD/T/Ct+gDtoRCQV3cUFMcuyvkkXlKawj2
         WLGB1R5MtCU0AhzL16rvpPc0kCG7si7a3R4XjZCPQiJxWKY7OtGxYTf8xS77a/Z0iw
         aj6vul+P3JCN9aq4QVUqayG1FZrZg05g6Oao2fo+lY2eMl/IJrYKozvRsNDYj2wXqI
         BuOHc7pYe/dFz2ApWqr5IKpn+PrgtYf5z/InadCXldft2dvbQsn09PC0VCOW5bLVej
         wQ95/1y1yDqXg==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id E43BEA005E;
        Wed,  3 Feb 2021 17:57:21 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v3 08/15] dmaengine: dw-edma: Reorder variables to keep consistency
Date:   Wed,  3 Feb 2021 18:57:00 +0100
Message-Id: <64c6c10b259de2691047be56c9bc0e267a3a76e2.1612374941.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1612374941.git.gustavo.pimentel@synopsys.com>
References: <cover.1612374941.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1612374941.git.gustavo.pimentel@synopsys.com>
References: <cover.1612374941.git.gustavo.pimentel@synopsys.com>
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

