Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1530630E567
	for <lists+dmaengine@lfdr.de>; Wed,  3 Feb 2021 23:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbhBCV7d (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Feb 2021 16:59:33 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:60294 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232676AbhBCV71 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Feb 2021 16:59:27 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 88665404A2;
        Wed,  3 Feb 2021 21:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612389507; bh=RPtJq9pnB6c2RL81eMcBv6mkc0ffZocP1N1iwYCqspQ=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=kX3rv6W8jpQMgcUnj1fJtWr7khaXJiGnxuK/XNzQky87qosdjILdZuuZzX2XWHG49
         z9PUg2lReIHRlQTsJECetpah4VOdnKmzou+QHvpVDANsX2K5o+1cXn+aNJpF6cTMYj
         3F0sAvlm3+DFitGo1bP/oFAfj73yFKgJPW0yd+JBLqhgF3j4+Xz8R5dgdDEs0vqR29
         FU2gVJG1UbhlKiUFgcDrQACvUSF7z4D/ohk3ll+HdlyNeOqiHGooaa/9zKJc/nvKOc
         IBPrUO7Pd6+KVI3K9c1Ys2h30kTXv4ji0TjXAK7jwWRijewCdUxm3EpMthno/FEzVj
         ZyheGfgmaZbew==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 60E24A024B;
        Wed,  3 Feb 2021 21:58:26 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v4 15/15] dmaengine: dw-edma: Add pcim_iomap_table return checker
Date:   Wed,  3 Feb 2021 22:58:06 +0100
Message-Id: <ceb5eb396e417f9e45d39fd5ef565ba77aae6a63.1612389406.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1612389406.git.gustavo.pimentel@synopsys.com>
References: <cover.1612389406.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1612389406.git.gustavo.pimentel@synopsys.com>
References: <cover.1612389406.git.gustavo.pimentel@synopsys.com>
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

