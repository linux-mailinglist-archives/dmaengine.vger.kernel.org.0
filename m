Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3468F4E9C9E
	for <lists+dmaengine@lfdr.de>; Mon, 28 Mar 2022 18:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiC1QqV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Mar 2022 12:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242867AbiC1QqD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Mar 2022 12:46:03 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE03821E31;
        Mon, 28 Mar 2022 09:44:16 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id EF50E1E4940;
        Thu, 24 Mar 2022 04:48:41 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru EF50E1E4940
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648086521;
        bh=jEu2wUvM7pH5rgVAy75gfZMJJnSsEu5NWHk3/A0TPYc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=aUCL31APiFO1HvyR7TBZJSlejnEyqsZ+oAx/sgRuFkH6uVF0OzoraFRG5oQGlkYkD
         ooM2mxv/Icyi+gfS8aXxUHhyfYtaF7ME+UA9mIByWENfQDbz/2IvD+ADWqhe9g0Iwh
         XXInaE8E8qXtZYWP/pTxJVIsUVGa4hxaJkj+Pg4U=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 04:48:41 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH 05/25] dmaengine: dw-edma: Convert ll/dt phys-address to PCIe bus/DMA address
Date:   Thu, 24 Mar 2022 04:48:16 +0300
Message-ID: <20220324014836.19149-6-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In accordance with the dw_edma_region.paddr field semantics it is supposed
to be initialized with a memory base address visible by the DW eDMA
controller. If the DMA engine is embedded into the DW PCIe Host/EP
controller, then the address should belong to the Local CPU/Application
memory. If eDMA is remotely accessible across the PCIe bus via the PCIe
memory IOs, then the address needs to be a part of the PCIe bus memory
space. The later case hasn't been well covered in the corresponding
glue-driver. Since in general the PCIe memory space doesn't have to match
the CPU memory space and the pci_dev.resource[] arrays contain the
resources defined in the CPU memory space, a proper conversion needs to be
performed, otherwise either the driver won't properly work or much worse
the memory corruption will happen. The conversion can be done by means of
the pci_bus_address() method. Let's use it to retrieve the LL, DT and CSRs
PCIe memory ranges.

Note in addition to that we need to extend the dw_edma_region.paddr field
size. The field normally contains a memory range base address to be set in
the DW eDMA Linked-List pointer register or as a base address of the
Linked-List data buffer. In accordance with [1] the LL range is supposed
to be created in the Local CPU/Application memory, but depending on the DW
eDMA utilization the memory can be created as a part of the PCIe bus
address space (as in the case of the DW PCIe EP prototype kit). Thus in
the former case the dw_edma_region.paddr field should have the dma_addr_t
type, while in the later one - pci_bus_addr_t. Seeing the corresponding
CSRs are always 64-bits wide let's convert the dw_edma_region.paddr field
type to be u64 and let the client code logic to make sure it has a valid
address visible by the DW eDMA controller. For instance the DW eDMA PCIe
glue-driver initializes the field with the addresses from the PCIe bus
memory space.

[1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
    v.5.40a, March 2019, p.1103

Fixes: 41aaff2a2ac0 ("dmaengine: Add Synopsys eDMA IP PCIe glue-logic")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 8 ++++----
 include/linux/dma/edma.h           | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index d6b5e2463884..04c95cba1244 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -231,7 +231,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr += ll_block->off;
-		ll_region->paddr = pdev->resource[ll_block->bar].start;
+		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -240,7 +240,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		dt_region->vaddr += dt_block->off;
-		dt_region->paddr = pdev->resource[dt_block->bar].start;
+		dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
 		dt_region->paddr += dt_block->off;
 		dt_region->sz = dt_block->sz;
 	}
@@ -256,7 +256,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr += ll_block->off;
-		ll_region->paddr = pdev->resource[ll_block->bar].start;
+		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -265,7 +265,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		dt_region->vaddr += dt_block->off;
-		dt_region->paddr = pdev->resource[dt_block->bar].start;
+		dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
 		dt_region->paddr += dt_block->off;
 		dt_region->sz = dt_block->sz;
 	}
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 8897f8a79b52..5abac9640a4e 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -18,7 +18,7 @@
 struct dw_edma;
 
 struct dw_edma_region {
-	phys_addr_t	paddr;
+	u64		paddr;
 	void __iomem	*vaddr;
 	size_t		sz;
 };
-- 
2.35.1

