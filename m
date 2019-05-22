Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8AE26693
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2019 17:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbfEVPEL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 May 2019 11:04:11 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:37438 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729777AbfEVPEL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 May 2019 11:04:11 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BDDC2C0B9C;
        Wed, 22 May 2019 15:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1558537457; bh=zED53Me0Y/ylTRCXlVsrkkOk+kt9nsUsXJjlReYCT8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=e4Xf893GR3A8zhPOfx12T1rkRp8WGVjUl4MDNSedbsLmGyHYNv5u2VCDr1BRwMgQ3
         QFKg0fhPJFHnM3gFvpYEDydxfTPVEOoD54pzWhGwqfh+cQx+n/YlEnI+lYJlgkmOaA
         4U3WepovutL+dRLxUlC0ap5msraZ1NCrOI4vplIreNqK9Y6sNZgJw8wFXE1mK1rDzw
         3a76aMHXGki8caAkZUOox/YztmvtIeqmRNgOAt343qxTJtRAgFWcl2IdGHidIWj/+J
         UPfSGJhzB+85aweNgBtmITJ3FnA0YDQA+ln9EbKT77Ga6M1Iy5loV5E05Aoar27B+3
         HkaE9SDJJxTPg==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 77F8CA0096;
        Wed, 22 May 2019 15:04:10 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 011353F068;
        Wed, 22 May 2019 17:04:09 +0200 (CEST)
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH 5/6] dmaengine: Add Synopsys eDMA IP PCIe glue-logic
Date:   Wed, 22 May 2019 17:04:04 +0200
Message-Id: <fe38bb39add5d09d7d14369eee50eb3261ec08c3.1558536992.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1558536991.git.gustavo.pimentel@synopsys.com>
References: <cover.1558536991.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1558536991.git.gustavo.pimentel@synopsys.com>
References: <cover.1558536991.git.gustavo.pimentel@synopsys.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Synopsys eDMA IP is normally distributed along with Synopsys PCIe
EndPoint IP (depends of the use and licensing agreement).

This IP requires some basic configurations, such as:
 - eDMA registers BAR
 - eDMA registers offset
 - eDMA registers size
 - eDMA linked list memory BAR
 - eDMA linked list memory offset
 - eDMA linked list memory size
 - eDMA data memory BAR
 - eDMA data memory offset
 - eDMA data memory size
 - eDMA version
 - eDMA mode
 - IRQs available for eDMA

As a working example, PCIe glue-logic will attach to a Synopsys PCIe
EndPoint IP prototype kit (Vendor ID = 0x16c3, Device ID = 0xedda),
which has built-in an eDMA IP with this default configuration:
 - eDMA registers BAR = 0
 - eDMA registers offset = 0x00001000 (4 Kbytes)
 - eDMA registers size = 0x00002000 (8 Kbytes)
 - eDMA linked list memory BAR = 2
 - eDMA linked list memory offset = 0x00000000 (0 Kbytes)
 - eDMA linked list memory size = 0x00800000 (8 Mbytes)
 - eDMA data memory BAR = 2
 - eDMA data memory offset = 0x00800000 (8 Mbytes)
 - eDMA data memory size = 0x03800000 (56 Mbytes)
 - eDMA version = 0
 - eDMA mode = EDMA_MODE_UNROLL
 - IRQs = 1

This driver can be compile as built-in or external module in kernel.

To enable this driver just select DW_EDMA_PCIE option in kernel
configuration, however it requires and selects automatically DW_EDMA
option too.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/dma/dw-edma/Kconfig        |   9 ++
 drivers/dma/dw-edma/Makefile       |   1 +
 drivers/dma/dw-edma/dw-edma-pcie.c | 229 +++++++++++++++++++++++++++++++++++++
 3 files changed, 239 insertions(+)
 create mode 100644 drivers/dma/dw-edma/dw-edma-pcie.c

diff --git a/drivers/dma/dw-edma/Kconfig b/drivers/dma/dw-edma/Kconfig
index 3016bed..c0838ce 100644
--- a/drivers/dma/dw-edma/Kconfig
+++ b/drivers/dma/dw-edma/Kconfig
@@ -7,3 +7,12 @@ config DW_EDMA
 	help
 	  Support the Synopsys DesignWare eDMA controller, normally
 	  implemented on endpoints SoCs.
+
+config DW_EDMA_PCIE
+	tristate "Synopsys DesignWare eDMA PCIe driver"
+	depends on PCI && PCI_MSI
+	select DW_EDMA
+	help
+	  Provides a glue-logic between the Synopsys DesignWare
+	  eDMA controller and an endpoint PCIe device. This also serves
+	  as a reference design to whom desires to use this IP.
diff --git a/drivers/dma/dw-edma/Makefile b/drivers/dma/dw-edma/Makefile
index 0c53033..8d45c0d 100644
--- a/drivers/dma/dw-edma/Makefile
+++ b/drivers/dma/dw-edma/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_DW_EDMA)		+= dw-edma.o
 dw-edma-$(CONFIG_DEBUG_FS)	:= dw-edma-v0-debugfs.o
 dw-edma-objs			:= dw-edma-core.o \
 					dw-edma-v0-core.o $(dw-edma-y)
+obj-$(CONFIG_DW_EDMA_PCIE)	+= dw-edma-pcie.o
diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
new file mode 100644
index 0000000..4c96e1c
--- /dev/null
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018-2019 Synopsys, Inc. and/or its affiliates.
+ * Synopsys DesignWare eDMA PCIe driver
+ *
+ * Author: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/device.h>
+#include <linux/dma/edma.h>
+#include <linux/pci-epf.h>
+#include <linux/msi.h>
+
+#include "dw-edma-core.h"
+
+struct dw_edma_pcie_data {
+	/* eDMA registers location */
+	enum pci_barno			rg_bar;
+	off_t				rg_off;
+	size_t				rg_sz;
+	/* eDMA memory linked list location */
+	enum pci_barno			ll_bar;
+	off_t				ll_off;
+	size_t				ll_sz;
+	/* eDMA memory data location */
+	enum pci_barno			dt_bar;
+	off_t				dt_off;
+	size_t				dt_sz;
+	/* Other */
+	u32				version;
+	enum dw_edma_mode		mode;
+	u8				irqs;
+};
+
+static const struct dw_edma_pcie_data snps_edda_data = {
+	/* eDMA registers location */
+	.rg_bar				= BAR_0,
+	.rg_off				= 0x00001000,	/*  4 Kbytes */
+	.rg_sz				= 0x00002000,	/*  8 Kbytes */
+	/* eDMA memory linked list location */
+	.ll_bar				= BAR_2,
+	.ll_off				= 0x00000000,	/*  0 Kbytes */
+	.ll_sz				= 0x00800000,	/*  8 Mbytes */
+	/* eDMA memory data location */
+	.dt_bar				= BAR_2,
+	.dt_off				= 0x00800000,	/*  8 Mbytes */
+	.dt_sz				= 0x03800000,	/* 56 Mbytes */
+	/* Other */
+	.version			= 0,
+	.mode				= EDMA_MODE_UNROLL,
+	.irqs				= 1,
+};
+
+static int dw_edma_pcie_probe(struct pci_dev *pdev,
+			      const struct pci_device_id *pid)
+{
+	const struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
+	struct device *dev = &pdev->dev;
+	struct dw_edma_chip *chip;
+	int err, nr_irqs;
+	struct dw_edma *dw;
+
+	/* Enable PCI device */
+	err = pcim_enable_device(pdev);
+	if (err) {
+		pci_err(pdev, "enabling device failed\n");
+		return err;
+	}
+
+	/* Mapping PCI BAR regions */
+	err = pcim_iomap_regions(pdev, BIT(pdata->rg_bar) |
+				       BIT(pdata->ll_bar) |
+				       BIT(pdata->dt_bar),
+				 pci_name(pdev));
+	if (err) {
+		pci_err(pdev, "eDMA BAR I/O remapping failed\n");
+		return err;
+	}
+
+	pci_set_master(pdev);
+
+	/* DMA configuration */
+	err = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
+	if (!err) {
+		err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
+		if (err) {
+			pci_err(pdev, "consistent DMA mask 64 set failed\n");
+			return err;
+		}
+	} else {
+		pci_err(pdev, "DMA mask 64 set failed\n");
+
+		err = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+		if (err) {
+			pci_err(pdev, "DMA mask 32 set failed\n");
+			return err;
+		}
+
+		err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
+		if (err) {
+			pci_err(pdev, "consistent DMA mask 32 set failed\n");
+			return err;
+		}
+	}
+
+	/* Data structure allocation */
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
+	if (!dw)
+		return -ENOMEM;
+
+	/* IRQs allocation */
+	nr_irqs = pci_alloc_irq_vectors(pdev, 1, pdata->irqs,
+					PCI_IRQ_MSI | PCI_IRQ_MSIX);
+	if (nr_irqs < 1) {
+		pci_err(pdev, "fail to alloc IRQ vector (number of IRQs=%u)\n",
+			nr_irqs);
+		return -EPERM;
+	}
+
+	/* Data structure initialization */
+	chip->dw = dw;
+	chip->dev = dev;
+	chip->id = pdev->devfn;
+	chip->irq = pdev->irq;
+
+	dw->rg_region.vaddr = (dma_addr_t)pcim_iomap_table(pdev)[pdata->rg_bar];
+	dw->rg_region.vaddr += pdata->rg_off;
+	dw->rg_region.paddr = pdev->resource[pdata->rg_bar].start;
+	dw->rg_region.paddr += pdata->rg_off;
+	dw->rg_region.sz = pdata->rg_sz;
+
+	dw->ll_region.vaddr = (dma_addr_t)pcim_iomap_table(pdev)[pdata->ll_bar];
+	dw->ll_region.vaddr += pdata->ll_off;
+	dw->ll_region.paddr = pdev->resource[pdata->ll_bar].start;
+	dw->ll_region.paddr += pdata->ll_off;
+	dw->ll_region.sz = pdata->ll_sz;
+
+	dw->dt_region.vaddr = (dma_addr_t)pcim_iomap_table(pdev)[pdata->dt_bar];
+	dw->dt_region.vaddr += pdata->dt_off;
+	dw->dt_region.paddr = pdev->resource[pdata->dt_bar].start;
+	dw->dt_region.paddr += pdata->dt_off;
+	dw->dt_region.sz = pdata->dt_sz;
+
+	dw->version = pdata->version;
+	dw->mode = pdata->mode;
+	dw->nr_irqs = nr_irqs;
+
+	/* Debug info */
+	pci_dbg(pdev, "Version:\t%u\n", dw->version);
+
+	pci_dbg(pdev, "Mode:\t%s\n",
+		dw->mode == EDMA_MODE_LEGACY ? "Legacy" : "Unroll");
+
+	pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%pa, p=%pa)\n",
+		pdata->rg_bar, pdata->rg_off, pdata->rg_sz,
+		&dw->rg_region.vaddr, &dw->rg_region.paddr);
+
+	pci_dbg(pdev, "L. List:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%pa, p=%pa)\n",
+		pdata->ll_bar, pdata->ll_off, pdata->ll_sz,
+		&dw->ll_region.vaddr, &dw->ll_region.paddr);
+
+	pci_dbg(pdev, "Data:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%pa, p=%pa)\n",
+		pdata->dt_bar, pdata->dt_off, pdata->dt_sz,
+		&dw->dt_region.vaddr, &dw->dt_region.paddr);
+
+	pci_dbg(pdev, "Nr. IRQs:\t%u\n", dw->nr_irqs);
+
+	/* Validating if PCI interrupts were enabled */
+	if (!pci_dev_msi_enabled(pdev)) {
+		pci_err(pdev, "enable interrupt failed\n");
+		return -EPERM;
+	}
+
+	dw->irq = devm_kcalloc(dev, nr_irqs, sizeof(*dw->irq), GFP_KERNEL);
+	if (!dw->irq)
+		return -ENOMEM;
+
+	/* Starting eDMA driver */
+	err = dw_edma_probe(chip);
+	if (err) {
+		pci_err(pdev, "eDMA probe failed\n");
+		return err;
+	}
+
+	/* Saving data structure reference */
+	pci_set_drvdata(pdev, chip);
+
+	return 0;
+}
+
+static void dw_edma_pcie_remove(struct pci_dev *pdev)
+{
+	struct dw_edma_chip *chip = pci_get_drvdata(pdev);
+	int err;
+
+	/* Stopping eDMA driver */
+	err = dw_edma_remove(chip);
+	if (err)
+		pci_warn(pdev, "can't remove device properly: %d\n", err);
+
+	/* Freeing IRQs */
+	pci_free_irq_vectors(pdev);
+}
+
+static const struct pci_device_id dw_edma_pcie_id_table[] = {
+	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
+
+static struct pci_driver dw_edma_pcie_driver = {
+	.name		= "dw-edma-pcie",
+	.id_table	= dw_edma_pcie_id_table,
+	.probe		= dw_edma_pcie_probe,
+	.remove		= dw_edma_pcie_remove,
+};
+
+module_pci_driver(dw_edma_pcie_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Synopsys DesignWare eDMA PCIe driver");
+MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
-- 
2.7.4

