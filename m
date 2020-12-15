Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2655E2DB2A2
	for <lists+dmaengine@lfdr.de>; Tue, 15 Dec 2020 18:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731309AbgLORb6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Dec 2020 12:31:58 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:46068 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731297AbgLORbt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Dec 2020 12:31:49 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DE665C04DA;
        Tue, 15 Dec 2020 17:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1608053449; bh=ZCFeUiaOqr6nmVdSrA/yeLCZ+L/gs597171/4LwdJCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=ZaoDvg8wbB8lCJwqvd7TcwYJEpkV+2//cfQTiz+RHVEC+jMYRlc+izTY8ju7EOoA0
         Ucu4KqBspALgJaI821QKEyJNXNFci8CobzLMbon9298Yco7m+SocDx7HrN8/stwnF9
         xDA7cekeWAmWICbA87U5jAqTYKd4TbS65SXnZNgMSdCWKefnN4twArukNMdYzgfH+2
         +E5h93VzSXxiIg26AarKgzS5hgY3P1xNPQeBTQ8SnIeLnVAub7p+2akL1jOK0BdcvI
         jrfCyWa+S7jeNAGeMQ2M8AUgCDjDOnzE8O2rcqq5X1lgDjEihfB+RnCXPniIlRpozk
         p0KIKYv9dCBcg==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 73759A024A;
        Tue, 15 Dec 2020 17:30:47 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/15] dmaengine: dw-edma: Add pcim_iomap_table return checker
Date:   Tue, 15 Dec 2020 18:30:24 +0100
Message-Id: <6df68db09ac19b2be8559e848497714ee763d5bd.1608053262.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1608053262.git.gustavo.pimentel@synopsys.com>
References: <cover.1608053262.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1608053262.git.gustavo.pimentel@synopsys.com>
References: <cover.1608053262.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Detected by CoverityScan CID 16555 ("Dereference null return")

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 1fa43e3..b759796 100644
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

