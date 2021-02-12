Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD8431A3E1
	for <lists+dmaengine@lfdr.de>; Fri, 12 Feb 2021 18:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbhBLRjt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 12 Feb 2021 12:39:49 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:42880 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231665AbhBLRjM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 12 Feb 2021 12:39:12 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 97FE040C7B;
        Fri, 12 Feb 2021 17:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613151492; bh=72Sja5KwGGKlDLBCdOJNht7/ylko2TEKcoumQMOKlvI=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=SQPXbcH10secXkY1L3DG3Fv/A+S0kQIsRF/FMC0nLWhtK4jVGFeNayGd6TM8Wa9rH
         RBZ67B51drvOiHivCknVmJEQN01E5oT+91FMYws9ABq9EcRkinxbwtYddVDFntcTfx
         c1VXCp4ETpubG0kQiD04Aq06Da5cufzpzeiaZwJLsQy8DV5WfphqFClrHEq0I7+z3k
         zUgsd44sO/0xtqwZ+F4MSP5nUiZOZyUQERYhNdtyeFM0NrDJ/rfYrylubowHXeqvE5
         ukDKKRXwOfcFxLvgo1SN/JZZe20PhJ5m2N+/cKfv3/Q4LQUFYoiukVOQJxTT03TncF
         ndP+MEpZQ3QcA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 689C7A005C;
        Fri, 12 Feb 2021 17:38:11 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v6 15/15] dmaengine: dw-edma: Add pcim_iomap_table return check
Date:   Fri, 12 Feb 2021 18:37:50 +0100
Message-Id: <ecdcc7adf5113b262df678bae235c2f836e61ab9.1613151392.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1613151392.git.gustavo.pimentel@synopsys.com>
References: <cover.1613151392.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1613151392.git.gustavo.pimentel@synopsys.com>
References: <cover.1613151392.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Currently, is missing a null check on a pcim_iomap_table() return value
and this can lead to a null pointer dereference if the desired BAR
wasn't mapped previously.
Fix this by adding a null check and returning -ENOMEM.

Addresses-Coverity: ("Dereference null return")
Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 502de71..70d0d08 100644
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

