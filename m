Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACCE795FB7
	for <lists+dmaengine@lfdr.de>; Tue, 20 Aug 2019 15:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbfHTNPu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Aug 2019 09:15:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:6720 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729576AbfHTNPu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Aug 2019 09:15:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 06:15:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="207362282"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 20 Aug 2019 06:15:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2A09A268; Tue, 20 Aug 2019 16:15:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 03/10] dmaengine: dw: Export struct dw_dma_chip_pdata for wider use
Date:   Tue, 20 Aug 2019 16:15:39 +0300
Message-Id: <20190820131546.75744-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190820131546.75744-1-andriy.shevchenko@linux.intel.com>
References: <20190820131546.75744-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

We are expecting some devices can be enumerated either as PCI or ACPI.
Nevertheless, they will share same information, thus, provide a generic
struct dw_dma_chip_pdata for all glue drivers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dw/internal.h | 28 ++++++++++++++++++
 drivers/dma/dw/pci.c      | 60 +++++++++++----------------------------
 2 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/dma/dw/internal.h b/drivers/dma/dw/internal.h
index 1dd7a4e6dd23..df5c84e2a4fd 100644
--- a/drivers/dma/dw/internal.h
+++ b/drivers/dma/dw/internal.h
@@ -23,4 +23,32 @@ int do_dw_dma_enable(struct dw_dma_chip *chip);
 
 extern bool dw_dma_filter(struct dma_chan *chan, void *param);
 
+struct dw_dma_chip_pdata {
+	const struct dw_dma_platform_data *pdata;
+	int (*probe)(struct dw_dma_chip *chip);
+	int (*remove)(struct dw_dma_chip *chip);
+	struct dw_dma_chip *chip;
+};
+
+static __maybe_unused const struct dw_dma_chip_pdata dw_dma_chip_pdata = {
+	.probe = dw_dma_probe,
+	.remove = dw_dma_remove,
+};
+
+static const struct dw_dma_platform_data idma32_pdata = {
+	.nr_channels = 8,
+	.chan_allocation_order = CHAN_ALLOCATION_ASCENDING,
+	.chan_priority = CHAN_PRIORITY_ASCENDING,
+	.block_size = 131071,
+	.nr_masters = 1,
+	.data_width = {4},
+	.multi_block = {1, 1, 1, 1, 1, 1, 1, 1},
+};
+
+static __maybe_unused const struct dw_dma_chip_pdata idma32_chip_pdata = {
+	.pdata = &idma32_pdata,
+	.probe = idma32_dma_probe,
+	.remove = idma32_dma_remove,
+};
+
 #endif /* _DMA_DW_INTERNAL_H */
diff --git a/drivers/dma/dw/pci.c b/drivers/dma/dw/pci.c
index ad6db1cc287e..cf6e8ec4c0ff 100644
--- a/drivers/dma/dw/pci.c
+++ b/drivers/dma/dw/pci.c
@@ -12,38 +12,10 @@
 
 #include "internal.h"
 
-struct dw_dma_pci_data {
-	const struct dw_dma_platform_data *pdata;
-	int (*probe)(struct dw_dma_chip *chip);
-	int (*remove)(struct dw_dma_chip *chip);
-	struct dw_dma_chip *chip;
-};
-
-static const struct dw_dma_pci_data dw_pci_data = {
-	.probe = dw_dma_probe,
-	.remove = dw_dma_remove,
-};
-
-static const struct dw_dma_platform_data idma32_pdata = {
-	.nr_channels = 8,
-	.chan_allocation_order = CHAN_ALLOCATION_ASCENDING,
-	.chan_priority = CHAN_PRIORITY_ASCENDING,
-	.block_size = 131071,
-	.nr_masters = 1,
-	.data_width = {4},
-	.multi_block = {1, 1, 1, 1, 1, 1, 1, 1},
-};
-
-static const struct dw_dma_pci_data idma32_pci_data = {
-	.pdata = &idma32_pdata,
-	.probe = idma32_dma_probe,
-	.remove = idma32_dma_remove,
-};
-
 static int dw_pci_probe(struct pci_dev *pdev, const struct pci_device_id *pid)
 {
-	const struct dw_dma_pci_data *drv_data = (void *)pid->driver_data;
-	struct dw_dma_pci_data *data;
+	const struct dw_dma_chip_pdata *drv_data = (void *)pid->driver_data;
+	struct dw_dma_chip_pdata *data;
 	struct dw_dma_chip *chip;
 	int ret;
 
@@ -95,7 +67,7 @@ static int dw_pci_probe(struct pci_dev *pdev, const struct pci_device_id *pid)
 
 static void dw_pci_remove(struct pci_dev *pdev)
 {
-	struct dw_dma_pci_data *data = pci_get_drvdata(pdev);
+	struct dw_dma_chip_pdata *data = pci_get_drvdata(pdev);
 	struct dw_dma_chip *chip = data->chip;
 	int ret;
 
@@ -108,7 +80,7 @@ static void dw_pci_remove(struct pci_dev *pdev)
 
 static int dw_pci_suspend_late(struct device *dev)
 {
-	struct dw_dma_pci_data *data = dev_get_drvdata(dev);
+	struct dw_dma_chip_pdata *data = dev_get_drvdata(dev);
 	struct dw_dma_chip *chip = data->chip;
 
 	return do_dw_dma_disable(chip);
@@ -116,7 +88,7 @@ static int dw_pci_suspend_late(struct device *dev)
 
 static int dw_pci_resume_early(struct device *dev)
 {
-	struct dw_dma_pci_data *data = dev_get_drvdata(dev);
+	struct dw_dma_chip_pdata *data = dev_get_drvdata(dev);
 	struct dw_dma_chip *chip = data->chip;
 
 	return do_dw_dma_enable(chip);
@@ -130,29 +102,29 @@ static const struct dev_pm_ops dw_pci_dev_pm_ops = {
 
 static const struct pci_device_id dw_pci_id_table[] = {
 	/* Medfield (GPDMA) */
-	{ PCI_VDEVICE(INTEL, 0x0827), (kernel_ulong_t)&dw_pci_data },
+	{ PCI_VDEVICE(INTEL, 0x0827), (kernel_ulong_t)&dw_dma_chip_pdata },
 
 	/* BayTrail */
-	{ PCI_VDEVICE(INTEL, 0x0f06), (kernel_ulong_t)&dw_pci_data },
-	{ PCI_VDEVICE(INTEL, 0x0f40), (kernel_ulong_t)&dw_pci_data },
+	{ PCI_VDEVICE(INTEL, 0x0f06), (kernel_ulong_t)&dw_dma_chip_pdata },
+	{ PCI_VDEVICE(INTEL, 0x0f40), (kernel_ulong_t)&dw_dma_chip_pdata },
 
 	/* Merrifield */
-	{ PCI_VDEVICE(INTEL, 0x11a2), (kernel_ulong_t)&idma32_pci_data },
+	{ PCI_VDEVICE(INTEL, 0x11a2), (kernel_ulong_t)&idma32_chip_pdata },
 
 	/* Braswell */
-	{ PCI_VDEVICE(INTEL, 0x2286), (kernel_ulong_t)&dw_pci_data },
-	{ PCI_VDEVICE(INTEL, 0x22c0), (kernel_ulong_t)&dw_pci_data },
+	{ PCI_VDEVICE(INTEL, 0x2286), (kernel_ulong_t)&dw_dma_chip_pdata },
+	{ PCI_VDEVICE(INTEL, 0x22c0), (kernel_ulong_t)&dw_dma_chip_pdata },
 
 	/* Elkhart Lake iDMA 32-bit (PSE DMA) */
-	{ PCI_VDEVICE(INTEL, 0x4bb4), (kernel_ulong_t)&idma32_pci_data },
-	{ PCI_VDEVICE(INTEL, 0x4bb5), (kernel_ulong_t)&idma32_pci_data },
-	{ PCI_VDEVICE(INTEL, 0x4bb6), (kernel_ulong_t)&idma32_pci_data },
+	{ PCI_VDEVICE(INTEL, 0x4bb4), (kernel_ulong_t)&idma32_chip_pdata },
+	{ PCI_VDEVICE(INTEL, 0x4bb5), (kernel_ulong_t)&idma32_chip_pdata },
+	{ PCI_VDEVICE(INTEL, 0x4bb6), (kernel_ulong_t)&idma32_chip_pdata },
 
 	/* Haswell */
-	{ PCI_VDEVICE(INTEL, 0x9c60), (kernel_ulong_t)&dw_pci_data },
+	{ PCI_VDEVICE(INTEL, 0x9c60), (kernel_ulong_t)&dw_dma_chip_pdata },
 
 	/* Broadwell */
-	{ PCI_VDEVICE(INTEL, 0x9ce0), (kernel_ulong_t)&dw_pci_data },
+	{ PCI_VDEVICE(INTEL, 0x9ce0), (kernel_ulong_t)&dw_dma_chip_pdata },
 
 	{ }
 };
-- 
2.23.0.rc1

