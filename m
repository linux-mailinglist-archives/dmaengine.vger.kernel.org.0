Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F7A31F010
	for <lists+dmaengine@lfdr.de>; Thu, 18 Feb 2021 20:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbhBRTjz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 18 Feb 2021 14:39:55 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:37718 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233370AbhBRTFl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 18 Feb 2021 14:05:41 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 89EE2C0090;
        Thu, 18 Feb 2021 19:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613675063; bh=rHv7oLj97WJLWT1Fh5vLvE2sBkULFzGK9jvVjMIuKtI=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=LacEK/1Mykj0IVtRRSKTX31cqusg78B34D/vN/IvuvkljqMxtkLUR8FpDatAqnQsE
         IoEf6kLZSyNicbbolYU9+XuZk15dmKe7xijQ0XwF0wTpJ3e1JKaeF+8Du/jNCH9fSe
         nyxfqrBkTXVwLFfkfvc7YN/vKewy7CSBQ86WDZnSeIEp7F+Im0pN9FhsFc/0rRDPOn
         n036yLh3PifJAPgFhmNsX4m47vWiwMxkvBEyRXwV9vLIuflwsHXv/LfRFUgqbdLC+S
         4KnQ+nIBcSkTPzpuw1FU4BinwKF8tGbK8zWcikl8V4EOB8+XaS9uzQkG2i3QcXHtnF
         yxRBSgBxIw0TQ==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 18631A005D;
        Thu, 18 Feb 2021 19:04:20 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v7 05/15] dmaengine: dw-edma: Add PCIe VSEC data retrieval support
Date:   Thu, 18 Feb 2021 20:03:59 +0100
Message-Id: <0b880b8893ff457ffc1b5071a1c7f47e61ceea1c.1613674948.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1613674948.git.gustavo.pimentel@synopsys.com>
References: <cover.1613674948.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1613674948.git.gustavo.pimentel@synopsys.com>
References: <cover.1613674948.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The latest eDMA IP development implements a Vendor-Specific Extended
Capability that contains the eDMA BAR, offset, map format, and the
number of read/write channels available.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/dma/dw-edma/dw-edma-core.c |  20 ++++---
 drivers/dma/dw-edma/dw-edma-pcie.c | 116 ++++++++++++++++++++++++++++---------
 2 files changed, 101 insertions(+), 35 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 08d71da..18a2878 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -863,15 +863,19 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 
 	raw_spin_lock_init(&dw->lock);
 
-	/* Find out how many write channels are supported by hardware */
-	dw->wr_ch_cnt = dw_edma_v0_core_ch_count(dw, EDMA_DIR_WRITE);
-	if (!dw->wr_ch_cnt)
-		return -EINVAL;
+	if (!dw->wr_ch_cnt) {
+		/* Find out how many write channels are supported by hardware */
+		dw->wr_ch_cnt = dw_edma_v0_core_ch_count(dw, EDMA_DIR_WRITE);
+		if (!dw->wr_ch_cnt)
+			return -EINVAL;
+	}
 
-	/* Find out how many read channels are supported by hardware */
-	dw->rd_ch_cnt = dw_edma_v0_core_ch_count(dw, EDMA_DIR_READ);
-	if (!dw->rd_ch_cnt)
-		return -EINVAL;
+	if (!dw->rd_ch_cnt) {
+		/* Find out how many read channels are supported by hardware */
+		dw->rd_ch_cnt = dw_edma_v0_core_ch_count(dw, EDMA_DIR_READ);
+		if (!dw->rd_ch_cnt)
+			return -EINVAL;
+	}
 
 	dev_vdbg(dev, "Channels:\twrite=%d, read=%d\n",
 		 dw->wr_ch_cnt, dw->rd_ch_cnt);
diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index c130549..eb6f8b3 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -13,9 +13,16 @@
 #include <linux/dma/edma.h>
 #include <linux/pci-epf.h>
 #include <linux/msi.h>
+#include <linux/bitfield.h>
 
 #include "dw-edma-core.h"
 
+#define DW_PCIE_VSEC_DMA_ID			0x6
+#define DW_PCIE_VSEC_DMA_BAR			GENMASK(10, 8)
+#define DW_PCIE_VSEC_DMA_MAP			GENMASK(2, 0)
+#define DW_PCIE_VSEC_DMA_RD_CH			GENMASK(25, 16)
+#define DW_PCIE_VSEC_DMA_WR_CH			GENMASK(9, 0)
+
 struct dw_edma_pcie_data {
 	/* eDMA registers location */
 	enum pci_barno			rg_bar;
@@ -32,6 +39,8 @@ struct dw_edma_pcie_data {
 	/* Other */
 	enum dw_edma_map_format		mf;
 	u8				irqs;
+	u16				rd_ch_cnt;
+	u16				wr_ch_cnt;
 };
 
 static const struct dw_edma_pcie_data snps_edda_data = {
@@ -50,6 +59,8 @@ static const struct dw_edma_pcie_data snps_edda_data = {
 	/* Other */
 	.mf				= EDMA_MF_EDMA_UNROLL,
 	.irqs				= 1,
+	.rd_ch_cnt			= 0,
+	.wr_ch_cnt			= 0,
 };
 
 static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
@@ -61,10 +72,51 @@ static const struct dw_edma_core_ops dw_edma_pcie_core_ops = {
 	.irq_vector = dw_edma_pcie_irq_vector,
 };
 
+static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
+					   struct dw_edma_pcie_data *pdata)
+{
+	u32 val, map;
+	u16 vsec;
+	u64 off;
+
+	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSYS,
+					DW_PCIE_VSEC_DMA_ID);
+	if (!vsec)
+		return;
+
+	pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
+	if (PCI_VNDR_HEADER_REV(val) != 0x00 ||
+	    PCI_VNDR_HEADER_LEN(val) != 0x18)
+		return;
+
+	pci_dbg(pdev, "Detected PCIe Vendor-Specific Extended Capability DMA\n");
+	pci_read_config_dword(pdev, vsec + 0x8, &val);
+	map = FIELD_GET(DW_PCIE_VSEC_DMA_MAP, val);
+	if (map != EDMA_MF_EDMA_LEGACY &&
+	    map != EDMA_MF_EDMA_UNROLL &&
+	    map != EDMA_MF_HDMA_COMPAT)
+		return;
+
+	pdata->mf = map;
+	pdata->rg_bar = FIELD_GET(DW_PCIE_VSEC_DMA_BAR, val);
+
+	pci_read_config_dword(pdev, vsec + 0xc, &val);
+	pdata->rd_ch_cnt = FIELD_GET(DW_PCIE_VSEC_DMA_RD_CH, val);
+	pdata->wr_ch_cnt = FIELD_GET(DW_PCIE_VSEC_DMA_WR_CH, val);
+
+	pci_read_config_dword(pdev, vsec + 0x14, &val);
+	off = val;
+	pci_read_config_dword(pdev, vsec + 0x10, &val);
+	off <<= 32;
+	off |= val;
+	pdata->rg_off = off;
+}
+
 static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			      const struct pci_device_id *pid)
 {
-	const struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
+	struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
+	struct dw_edma_pcie_data vsec_data;
 	struct device *dev = &pdev->dev;
 	struct dw_edma_chip *chip;
 	struct dw_edma *dw;
@@ -77,10 +129,18 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		return err;
 	}
 
+	memcpy(&vsec_data, pdata, sizeof(struct dw_edma_pcie_data));
+
+	/*
+	 * Tries to find if exists a PCIe Vendor-Specific Extended Capability
+	 * for the DMA, if one exists, then reconfigures it.
+	 */
+	dw_edma_pcie_get_vsec_dma_data(pdev, &vsec_data);
+
 	/* Mapping PCI BAR regions */
-	err = pcim_iomap_regions(pdev, BIT(pdata->rg_bar) |
-				       BIT(pdata->ll_bar) |
-				       BIT(pdata->dt_bar),
+	err = pcim_iomap_regions(pdev, BIT(vsec_data.rg_bar) |
+				       BIT(vsec_data.ll_bar) |
+				       BIT(vsec_data.dt_bar),
 				 pci_name(pdev));
 	if (err) {
 		pci_err(pdev, "eDMA BAR I/O remapping failed\n");
@@ -123,7 +183,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		return -ENOMEM;
 
 	/* IRQs allocation */
-	nr_irqs = pci_alloc_irq_vectors(pdev, 1, pdata->irqs,
+	nr_irqs = pci_alloc_irq_vectors(pdev, 1, vsec_data.irqs,
 					PCI_IRQ_MSI | PCI_IRQ_MSIX);
 	if (nr_irqs < 1) {
 		pci_err(pdev, "fail to alloc IRQ vector (number of IRQs=%u)\n",
@@ -137,27 +197,29 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->id = pdev->devfn;
 	chip->irq = pdev->irq;
 
-	dw->rg_region.vaddr = pcim_iomap_table(pdev)[pdata->rg_bar];
-	dw->rg_region.vaddr += pdata->rg_off;
-	dw->rg_region.paddr = pdev->resource[pdata->rg_bar].start;
-	dw->rg_region.paddr += pdata->rg_off;
-	dw->rg_region.sz = pdata->rg_sz;
-
-	dw->ll_region.vaddr = pcim_iomap_table(pdev)[pdata->ll_bar];
-	dw->ll_region.vaddr += pdata->ll_off;
-	dw->ll_region.paddr = pdev->resource[pdata->ll_bar].start;
-	dw->ll_region.paddr += pdata->ll_off;
-	dw->ll_region.sz = pdata->ll_sz;
-
-	dw->dt_region.vaddr = pcim_iomap_table(pdev)[pdata->dt_bar];
-	dw->dt_region.vaddr += pdata->dt_off;
-	dw->dt_region.paddr = pdev->resource[pdata->dt_bar].start;
-	dw->dt_region.paddr += pdata->dt_off;
-	dw->dt_region.sz = pdata->dt_sz;
-
-	dw->mf = pdata->mf;
+	dw->rg_region.vaddr = pcim_iomap_table(pdev)[vsec_data.rg_bar];
+	dw->rg_region.vaddr += vsec_data.rg_off;
+	dw->rg_region.paddr = pdev->resource[vsec_data.rg_bar].start;
+	dw->rg_region.paddr += vsec_data.rg_off;
+	dw->rg_region.sz = vsec_data.rg_sz;
+
+	dw->ll_region.vaddr = pcim_iomap_table(pdev)[vsec_data.ll_bar];
+	dw->ll_region.vaddr += vsec_data.ll_off;
+	dw->ll_region.paddr = pdev->resource[vsec_data.ll_bar].start;
+	dw->ll_region.paddr += vsec_data.ll_off;
+	dw->ll_region.sz = vsec_data.ll_sz;
+
+	dw->dt_region.vaddr = pcim_iomap_table(pdev)[vsec_data.dt_bar];
+	dw->dt_region.vaddr += vsec_data.dt_off;
+	dw->dt_region.paddr = pdev->resource[vsec_data.dt_bar].start;
+	dw->dt_region.paddr += vsec_data.dt_off;
+	dw->dt_region.sz = vsec_data.dt_sz;
+
+	dw->mf = vsec_data.mf;
 	dw->nr_irqs = nr_irqs;
 	dw->ops = &dw_edma_pcie_core_ops;
+	dw->rd_ch_cnt = vsec_data.rd_ch_cnt;
+	dw->wr_ch_cnt = vsec_data.wr_ch_cnt;
 
 	/* Debug info */
 	if (dw->mf == EDMA_MF_EDMA_LEGACY)
@@ -170,15 +232,15 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		pci_dbg(pdev, "Version:\tUnknown (0x%x)\n", dw->mf);
 
 	pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
-		pdata->rg_bar, pdata->rg_off, pdata->rg_sz,
+		vsec_data.rg_bar, vsec_data.rg_off, vsec_data.rg_sz,
 		dw->rg_region.vaddr, &dw->rg_region.paddr);
 
 	pci_dbg(pdev, "L. List:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
-		pdata->ll_bar, pdata->ll_off, pdata->ll_sz,
+		vsec_data.ll_bar, vsec_data.ll_off, vsec_data.ll_sz,
 		dw->ll_region.vaddr, &dw->ll_region.paddr);
 
 	pci_dbg(pdev, "Data:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
-		pdata->dt_bar, pdata->dt_off, pdata->dt_sz,
+		vsec_data.dt_bar, vsec_data.dt_off, vsec_data.dt_sz,
 		dw->dt_region.vaddr, &dw->dt_region.paddr);
 
 	pci_dbg(pdev, "Nr. IRQs:\t%u\n", dw->nr_irqs);
-- 
2.7.4

