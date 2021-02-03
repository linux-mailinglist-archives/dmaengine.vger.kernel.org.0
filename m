Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D2A30E1C0
	for <lists+dmaengine@lfdr.de>; Wed,  3 Feb 2021 19:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbhBCR66 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Feb 2021 12:58:58 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:40818 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232479AbhBCR6b (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Feb 2021 12:58:31 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 739BAC010E;
        Wed,  3 Feb 2021 17:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612375050; bh=RPtJq9pnB6c2RL81eMcBv6mkc0ffZocP1N1iwYCqspQ=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=ltqKhfPtIAlvAZMklZE/yTPmeeoq5TR+HfJkqtVKFf0P6+EzM9RQaeS+i8HV3DaBt
         LZKerbANIRg+pEzjmUiFgFET49X2lsimIsQLKP9sEvNbnI0cYt1+dNXt9w8iu6cPb8
         5KDhRaqUeAt+r2PoBpNG2cS/CgCPKOSLg9LJPiTZiVjfRUoCflPiqX0v6Tk2zWod2X
         avM0MSl2ltAKn5DjCcit9EzOmmYDymBlo0BuZjeZB0qbIFH3GmKRHC/w+avJJjNLz0
         yFB/lQcKE0UkO9vFWF/Jz9nkRgLGQ3joF5yITY/O8FUDqwxUfDry7VPhIFQ0OQoq/X
         lx4yCKJvZd3RA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3888DA005E;
        Wed,  3 Feb 2021 17:57:29 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v3 15/15] dmaengine: dw-edma: Add pcim_iomap_table return checker
Date:   Wed,  3 Feb 2021 18:57:07 +0100
Message-Id: <9fcd7137c661d1a5e6b8e6441de7e903e2cfc069.1612374941.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1612374941.git.gustavo.pimentel@synopsys.com>
References: <cover.1612374941.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1612374941.git.gustavo.pimentel@synopsys.com>
References: <cover.1612374941.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Detected by CoverityScan CID 16555 ("Dereference null return")

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 686b4ff..7445033 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -238,6 +238,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	dw->rd_ch_cnt = vsec_data.rd_ch_cnt;
 
 	dw->rg_region.vaddr = pcim_iomap_table(pdev)[vsec_data.rg.bar];
+	if (!dw->rg_region.vaddr)
+		return -ENOMEM;
+
 	dw->rg_region.vaddr += vsec_data.rg.off;
 	dw->rg_region.paddr = pdev->resource[vsec_data.rg.bar].start;
 	dw->rg_region.paddr += vsec_data.rg.off;
@@ -250,12 +253,18 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		struct dw_edma_block *dt_block = &vsec_data.dt_wr[i];
 
 		ll_region->vaddr = pcim_iomap_table(pdev)[ll_block->bar];
+		if (!ll_region->vaddr)
+			return -ENOMEM;
+
 		ll_region->vaddr += ll_block->off;
 		ll_region->paddr = pdev->resource[ll_block->bar].start;
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
 		dt_region->vaddr = pcim_iomap_table(pdev)[dt_block->bar];
+		if (!dt_region->vaddr)
+			return -ENOMEM;
+
 		dt_region->vaddr += dt_block->off;
 		dt_region->paddr = pdev->resource[dt_block->bar].start;
 		dt_region->paddr += dt_block->off;
@@ -269,12 +278,18 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		struct dw_edma_block *dt_block = &vsec_data.dt_rd[i];
 
 		ll_region->vaddr = pcim_iomap_table(pdev)[ll_block->bar];
+		if (!ll_region->vaddr)
+			return -ENOMEM;
+
 		ll_region->vaddr += ll_block->off;
 		ll_region->paddr = pdev->resource[ll_block->bar].start;
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
 		dt_region->vaddr = pcim_iomap_table(pdev)[dt_block->bar];
+		if (!dt_region->vaddr)
+			return -ENOMEM;
+
 		dt_region->vaddr += dt_block->off;
 		dt_region->paddr = pdev->resource[dt_block->bar].start;
 		dt_region->paddr += dt_block->off;
-- 
2.7.4

