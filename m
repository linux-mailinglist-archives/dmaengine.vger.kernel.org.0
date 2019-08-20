Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 163A095FBC
	for <lists+dmaengine@lfdr.de>; Tue, 20 Aug 2019 15:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbfHTNPx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Aug 2019 09:15:53 -0400
Received: from mga09.intel.com ([134.134.136.24]:13987 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729672AbfHTNPx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Aug 2019 09:15:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 06:15:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="179742847"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 20 Aug 2019 06:15:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7AA863C6; Tue, 20 Aug 2019 16:15:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 10/10] dmaengine: dw: platform: Split OF helpers to separate module
Date:   Tue, 20 Aug 2019 16:15:46 +0300
Message-Id: <20190820131546.75744-11-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190820131546.75744-1-andriy.shevchenko@linux.intel.com>
References: <20190820131546.75744-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

For better maintenance split OF helpers to the separate module.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dw/Makefile   |   1 +
 drivers/dma/dw/internal.h |  15 +++++
 drivers/dma/dw/of.c       | 131 ++++++++++++++++++++++++++++++++++++++
 drivers/dma/dw/platform.c | 115 +--------------------------------
 4 files changed, 149 insertions(+), 113 deletions(-)
 create mode 100644 drivers/dma/dw/of.c

diff --git a/drivers/dma/dw/Makefile b/drivers/dma/dw/Makefile
index 5e69815f3cf1..b6f06699e91a 100644
--- a/drivers/dma/dw/Makefile
+++ b/drivers/dma/dw/Makefile
@@ -5,6 +5,7 @@ dw_dmac_core-objs	:= core.o dw.o idma32.o
 obj-$(CONFIG_DW_DMAC)		+= dw_dmac.o
 dw_dmac-y			:= platform.o
 dw_dmac-$(CONFIG_ACPI)		+= acpi.o
+dw_dmac-$(CONFIG_OF)		+= of.o
 
 obj-$(CONFIG_DW_DMAC_PCI)	+= dw_dmac_pci.o
 dw_dmac_pci-objs	:= pci.o
diff --git a/drivers/dma/dw/internal.h b/drivers/dma/dw/internal.h
index acada530aa96..2e1c52eefdeb 100644
--- a/drivers/dma/dw/internal.h
+++ b/drivers/dma/dw/internal.h
@@ -31,6 +31,21 @@ static inline void dw_dma_acpi_controller_register(struct dw_dma *dw) {}
 static inline void dw_dma_acpi_controller_free(struct dw_dma *dw) {}
 #endif /* !CONFIG_ACPI */
 
+struct platform_device;
+
+#ifdef CONFIG_OF
+struct dw_dma_platform_data *dw_dma_parse_dt(struct platform_device *pdev);
+void dw_dma_of_controller_register(struct dw_dma *dw);
+void dw_dma_of_controller_free(struct dw_dma *dw);
+#else
+static inline struct dw_dma_platform_data *dw_dma_parse_dt(struct platform_device *pdev)
+{
+	return NULL;
+}
+static inline void dw_dma_of_controller_register(struct dw_dma *dw) {}
+static inline void dw_dma_of_controller_free(struct dw_dma *dw) {}
+#endif
+
 struct dw_dma_chip_pdata {
 	const struct dw_dma_platform_data *pdata;
 	int (*probe)(struct dw_dma_chip *chip);
diff --git a/drivers/dma/dw/of.c b/drivers/dma/dw/of.c
new file mode 100644
index 000000000000..9e27831dee32
--- /dev/null
+++ b/drivers/dma/dw/of.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Platform driver for the Synopsys DesignWare DMA Controller
+ *
+ * Copyright (C) 2007-2008 Atmel Corporation
+ * Copyright (C) 2010-2011 ST Microelectronics
+ * Copyright (C) 2013 Intel Corporation
+ */
+
+#include <linux/of.h>
+#include <linux/of_dma.h>
+#include <linux/platform_device.h>
+
+#include "internal.h"
+
+static struct dma_chan *dw_dma_of_xlate(struct of_phandle_args *dma_spec,
+					struct of_dma *ofdma)
+{
+	struct dw_dma *dw = ofdma->of_dma_data;
+	struct dw_dma_slave slave = {
+		.dma_dev = dw->dma.dev,
+	};
+	dma_cap_mask_t cap;
+
+	if (dma_spec->args_count != 3)
+		return NULL;
+
+	slave.src_id = dma_spec->args[0];
+	slave.dst_id = dma_spec->args[0];
+	slave.m_master = dma_spec->args[1];
+	slave.p_master = dma_spec->args[2];
+
+	if (WARN_ON(slave.src_id >= DW_DMA_MAX_NR_REQUESTS ||
+		    slave.dst_id >= DW_DMA_MAX_NR_REQUESTS ||
+		    slave.m_master >= dw->pdata->nr_masters ||
+		    slave.p_master >= dw->pdata->nr_masters))
+		return NULL;
+
+	dma_cap_zero(cap);
+	dma_cap_set(DMA_SLAVE, cap);
+
+	/* TODO: there should be a simpler way to do this */
+	return dma_request_channel(cap, dw_dma_filter, &slave);
+}
+
+struct dw_dma_platform_data *dw_dma_parse_dt(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct dw_dma_platform_data *pdata;
+	u32 tmp, arr[DW_DMA_MAX_NR_MASTERS], mb[DW_DMA_MAX_NR_CHANNELS];
+	u32 nr_masters;
+	u32 nr_channels;
+
+	if (!np) {
+		dev_err(&pdev->dev, "Missing DT data\n");
+		return NULL;
+	}
+
+	if (of_property_read_u32(np, "dma-masters", &nr_masters))
+		return NULL;
+	if (nr_masters < 1 || nr_masters > DW_DMA_MAX_NR_MASTERS)
+		return NULL;
+
+	if (of_property_read_u32(np, "dma-channels", &nr_channels))
+		return NULL;
+	if (nr_channels > DW_DMA_MAX_NR_CHANNELS)
+		return NULL;
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return NULL;
+
+	pdata->nr_masters = nr_masters;
+	pdata->nr_channels = nr_channels;
+
+	if (!of_property_read_u32(np, "chan_allocation_order", &tmp))
+		pdata->chan_allocation_order = (unsigned char)tmp;
+
+	if (!of_property_read_u32(np, "chan_priority", &tmp))
+		pdata->chan_priority = tmp;
+
+	if (!of_property_read_u32(np, "block_size", &tmp))
+		pdata->block_size = tmp;
+
+	if (!of_property_read_u32_array(np, "data-width", arr, nr_masters)) {
+		for (tmp = 0; tmp < nr_masters; tmp++)
+			pdata->data_width[tmp] = arr[tmp];
+	} else if (!of_property_read_u32_array(np, "data_width", arr, nr_masters)) {
+		for (tmp = 0; tmp < nr_masters; tmp++)
+			pdata->data_width[tmp] = BIT(arr[tmp] & 0x07);
+	}
+
+	if (!of_property_read_u32_array(np, "multi-block", mb, nr_channels)) {
+		for (tmp = 0; tmp < nr_channels; tmp++)
+			pdata->multi_block[tmp] = mb[tmp];
+	} else {
+		for (tmp = 0; tmp < nr_channels; tmp++)
+			pdata->multi_block[tmp] = 1;
+	}
+
+	if (!of_property_read_u32(np, "snps,dma-protection-control", &tmp)) {
+		if (tmp > CHAN_PROTCTL_MASK)
+			return NULL;
+		pdata->protctl = tmp;
+	}
+
+	return pdata;
+}
+
+void dw_dma_of_controller_register(struct dw_dma *dw)
+{
+	struct device *dev = dw->dma.dev;
+	int ret;
+
+	if (!dev->of_node)
+		return;
+
+	ret = of_dma_controller_register(dev->of_node, dw_dma_of_xlate, dw);
+	if (ret)
+		dev_err(dev, "could not register of_dma_controller\n");
+}
+
+void dw_dma_of_controller_free(struct dw_dma *dw)
+{
+	struct device *dev = dw->dma.dev;
+
+	if (!dev->of_node)
+		return;
+
+	of_dma_controller_free(dev->of_node);
+}
diff --git a/drivers/dma/dw/platform.c b/drivers/dma/dw/platform.c
index d50e038acb1e..c90c798e5ec3 100644
--- a/drivers/dma/dw/platform.c
+++ b/drivers/dma/dw/platform.c
@@ -17,116 +17,12 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/of.h>
-#include <linux/of_dma.h>
 #include <linux/acpi.h>
 
 #include "internal.h"
 
 #define DRV_NAME	"dw_dmac"
 
-static struct dma_chan *dw_dma_of_xlate(struct of_phandle_args *dma_spec,
-					struct of_dma *ofdma)
-{
-	struct dw_dma *dw = ofdma->of_dma_data;
-	struct dw_dma_slave slave = {
-		.dma_dev = dw->dma.dev,
-	};
-	dma_cap_mask_t cap;
-
-	if (dma_spec->args_count != 3)
-		return NULL;
-
-	slave.src_id = dma_spec->args[0];
-	slave.dst_id = dma_spec->args[0];
-	slave.m_master = dma_spec->args[1];
-	slave.p_master = dma_spec->args[2];
-
-	if (WARN_ON(slave.src_id >= DW_DMA_MAX_NR_REQUESTS ||
-		    slave.dst_id >= DW_DMA_MAX_NR_REQUESTS ||
-		    slave.m_master >= dw->pdata->nr_masters ||
-		    slave.p_master >= dw->pdata->nr_masters))
-		return NULL;
-
-	dma_cap_zero(cap);
-	dma_cap_set(DMA_SLAVE, cap);
-
-	/* TODO: there should be a simpler way to do this */
-	return dma_request_channel(cap, dw_dma_filter, &slave);
-}
-
-#ifdef CONFIG_OF
-static struct dw_dma_platform_data *
-dw_dma_parse_dt(struct platform_device *pdev)
-{
-	struct device_node *np = pdev->dev.of_node;
-	struct dw_dma_platform_data *pdata;
-	u32 tmp, arr[DW_DMA_MAX_NR_MASTERS], mb[DW_DMA_MAX_NR_CHANNELS];
-	u32 nr_masters;
-	u32 nr_channels;
-
-	if (!np) {
-		dev_err(&pdev->dev, "Missing DT data\n");
-		return NULL;
-	}
-
-	if (of_property_read_u32(np, "dma-masters", &nr_masters))
-		return NULL;
-	if (nr_masters < 1 || nr_masters > DW_DMA_MAX_NR_MASTERS)
-		return NULL;
-
-	if (of_property_read_u32(np, "dma-channels", &nr_channels))
-		return NULL;
-	if (nr_channels > DW_DMA_MAX_NR_CHANNELS)
-		return NULL;
-
-	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata)
-		return NULL;
-
-	pdata->nr_masters = nr_masters;
-	pdata->nr_channels = nr_channels;
-
-	if (!of_property_read_u32(np, "chan_allocation_order", &tmp))
-		pdata->chan_allocation_order = (unsigned char)tmp;
-
-	if (!of_property_read_u32(np, "chan_priority", &tmp))
-		pdata->chan_priority = tmp;
-
-	if (!of_property_read_u32(np, "block_size", &tmp))
-		pdata->block_size = tmp;
-
-	if (!of_property_read_u32_array(np, "data-width", arr, nr_masters)) {
-		for (tmp = 0; tmp < nr_masters; tmp++)
-			pdata->data_width[tmp] = arr[tmp];
-	} else if (!of_property_read_u32_array(np, "data_width", arr, nr_masters)) {
-		for (tmp = 0; tmp < nr_masters; tmp++)
-			pdata->data_width[tmp] = BIT(arr[tmp] & 0x07);
-	}
-
-	if (!of_property_read_u32_array(np, "multi-block", mb, nr_channels)) {
-		for (tmp = 0; tmp < nr_channels; tmp++)
-			pdata->multi_block[tmp] = mb[tmp];
-	} else {
-		for (tmp = 0; tmp < nr_channels; tmp++)
-			pdata->multi_block[tmp] = 1;
-	}
-
-	if (!of_property_read_u32(np, "snps,dma-protection-control", &tmp)) {
-		if (tmp > CHAN_PROTCTL_MASK)
-			return NULL;
-		pdata->protctl = tmp;
-	}
-
-	return pdata;
-}
-#else
-static inline struct dw_dma_platform_data *
-dw_dma_parse_dt(struct platform_device *pdev)
-{
-	return NULL;
-}
-#endif
-
 static int dw_probe(struct platform_device *pdev)
 {
 	const struct dw_dma_chip_pdata *match;
@@ -185,13 +81,7 @@ static int dw_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, data);
 
-	if (pdev->dev.of_node) {
-		err = of_dma_controller_register(pdev->dev.of_node,
-						 dw_dma_of_xlate, chip->dw);
-		if (err)
-			dev_err(&pdev->dev,
-				"could not register of_dma_controller\n");
-	}
+	dw_dma_of_controller_register(chip->dw);
 
 	dw_dma_acpi_controller_register(chip->dw);
 
@@ -211,8 +101,7 @@ static int dw_remove(struct platform_device *pdev)
 
 	dw_dma_acpi_controller_free(chip->dw);
 
-	if (pdev->dev.of_node)
-		of_dma_controller_free(pdev->dev.of_node);
+	dw_dma_of_controller_free(chip->dw);
 
 	ret = data->remove(chip);
 	if (ret)
-- 
2.23.0.rc1

