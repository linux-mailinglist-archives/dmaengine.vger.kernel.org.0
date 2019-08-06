Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0B7682EE0
	for <lists+dmaengine@lfdr.de>; Tue,  6 Aug 2019 11:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732520AbfHFJlA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Aug 2019 05:41:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:24449 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732529AbfHFJlA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 6 Aug 2019 05:41:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 02:40:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="181928732"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Aug 2019 02:40:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F0115559; Tue,  6 Aug 2019 12:40:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 11/12] dmaengine: dw: platform: Split ACPI helpers to separate module
Date:   Tue,  6 Aug 2019 12:40:53 +0300
Message-Id: <20190806094054.64871-11-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806094054.64871-1-andriy.shevchenko@linux.intel.com>
References: <20190806094054.64871-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

For better maintenance split ACPI helpers to the separate module.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dw/Makefile   |  3 ++-
 drivers/dma/dw/acpi.c     | 53 +++++++++++++++++++++++++++++++++++++++
 drivers/dma/dw/internal.h |  8 ++++++
 drivers/dma/dw/platform.c | 52 --------------------------------------
 4 files changed, 63 insertions(+), 53 deletions(-)
 create mode 100644 drivers/dma/dw/acpi.c

diff --git a/drivers/dma/dw/Makefile b/drivers/dma/dw/Makefile
index 63ed895c09aa..5e69815f3cf1 100644
--- a/drivers/dma/dw/Makefile
+++ b/drivers/dma/dw/Makefile
@@ -3,7 +3,8 @@ obj-$(CONFIG_DW_DMAC_CORE)	+= dw_dmac_core.o
 dw_dmac_core-objs	:= core.o dw.o idma32.o
 
 obj-$(CONFIG_DW_DMAC)		+= dw_dmac.o
-dw_dmac-objs		:= platform.o
+dw_dmac-y			:= platform.o
+dw_dmac-$(CONFIG_ACPI)		+= acpi.o
 
 obj-$(CONFIG_DW_DMAC_PCI)	+= dw_dmac_pci.o
 dw_dmac_pci-objs	:= pci.o
diff --git a/drivers/dma/dw/acpi.c b/drivers/dma/dw/acpi.c
new file mode 100644
index 000000000000..f6e8d55b4f6e
--- /dev/null
+++ b/drivers/dma/dw/acpi.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2013,2019 Intel Corporation
+
+#include <linux/acpi.h>
+#include <linux/acpi_dma.h>
+
+#include "internal.h"
+
+static bool dw_dma_acpi_filter(struct dma_chan *chan, void *param)
+{
+	struct acpi_dma_spec *dma_spec = param;
+	struct dw_dma_slave slave = {
+		.dma_dev = dma_spec->dev,
+		.src_id = dma_spec->slave_id,
+		.dst_id = dma_spec->slave_id,
+		.m_master = 0,
+		.p_master = 1,
+	};
+
+	return dw_dma_filter(chan, &slave);
+}
+
+void dw_dma_acpi_controller_register(struct dw_dma *dw)
+{
+	struct device *dev = dw->dma.dev;
+	struct acpi_dma_filter_info *info;
+	int ret;
+
+	if (!has_acpi_companion(dev))
+		return;
+
+	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return;
+
+	dma_cap_zero(info->dma_cap);
+	dma_cap_set(DMA_SLAVE, info->dma_cap);
+	info->filter_fn = dw_dma_acpi_filter;
+
+	ret = acpi_dma_controller_register(dev, acpi_dma_simple_xlate, info);
+	if (ret)
+		dev_err(dev, "could not register acpi_dma_controller\n");
+}
+
+void dw_dma_acpi_controller_free(struct dw_dma *dw)
+{
+	struct device *dev = dw->dma.dev;
+
+	if (!has_acpi_companion(dev))
+		return;
+
+	acpi_dma_controller_free(dev);
+}
diff --git a/drivers/dma/dw/internal.h b/drivers/dma/dw/internal.h
index df5c84e2a4fd..acada530aa96 100644
--- a/drivers/dma/dw/internal.h
+++ b/drivers/dma/dw/internal.h
@@ -23,6 +23,14 @@ int do_dw_dma_enable(struct dw_dma_chip *chip);
 
 extern bool dw_dma_filter(struct dma_chan *chan, void *param);
 
+#ifdef CONFIG_ACPI
+void dw_dma_acpi_controller_register(struct dw_dma *dw);
+void dw_dma_acpi_controller_free(struct dw_dma *dw);
+#else /* !CONFIG_ACPI */
+static inline void dw_dma_acpi_controller_register(struct dw_dma *dw) {}
+static inline void dw_dma_acpi_controller_free(struct dw_dma *dw) {}
+#endif /* !CONFIG_ACPI */
+
 struct dw_dma_chip_pdata {
 	const struct dw_dma_platform_data *pdata;
 	int (*probe)(struct dw_dma_chip *chip);
diff --git a/drivers/dma/dw/platform.c b/drivers/dma/dw/platform.c
index 11f2f6ed4c8a..dcf9b6dc96a9 100644
--- a/drivers/dma/dw/platform.c
+++ b/drivers/dma/dw/platform.c
@@ -19,7 +19,6 @@
 #include <linux/of.h>
 #include <linux/of_dma.h>
 #include <linux/acpi.h>
-#include <linux/acpi_dma.h>
 
 #include "internal.h"
 
@@ -55,57 +54,6 @@ static struct dma_chan *dw_dma_of_xlate(struct of_phandle_args *dma_spec,
 	return dma_request_channel(cap, dw_dma_filter, &slave);
 }
 
-#ifdef CONFIG_ACPI
-static bool dw_dma_acpi_filter(struct dma_chan *chan, void *param)
-{
-	struct acpi_dma_spec *dma_spec = param;
-	struct dw_dma_slave slave = {
-		.dma_dev = dma_spec->dev,
-		.src_id = dma_spec->slave_id,
-		.dst_id = dma_spec->slave_id,
-		.m_master = 0,
-		.p_master = 1,
-	};
-
-	return dw_dma_filter(chan, &slave);
-}
-
-static void dw_dma_acpi_controller_register(struct dw_dma *dw)
-{
-	struct device *dev = dw->dma.dev;
-	struct acpi_dma_filter_info *info;
-	int ret;
-
-	if (!has_acpi_companion(dev))
-		return;
-
-	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
-	if (!info)
-		return;
-
-	dma_cap_zero(info->dma_cap);
-	dma_cap_set(DMA_SLAVE, info->dma_cap);
-	info->filter_fn = dw_dma_acpi_filter;
-
-	ret = acpi_dma_controller_register(dev, acpi_dma_simple_xlate, info);
-	if (ret)
-		dev_err(dev, "could not register acpi_dma_controller\n");
-}
-
-static void dw_dma_acpi_controller_free(struct dw_dma *dw)
-{
-	struct device *dev = dw->dma.dev;
-
-	if (!has_acpi_companion(dev))
-		return;
-
-	acpi_dma_controller_free(dev);
-}
-#else /* !CONFIG_ACPI */
-static inline void dw_dma_acpi_controller_register(struct dw_dma *dw) {}
-static inline void dw_dma_acpi_controller_free(struct dw_dma *dw) {}
-#endif /* !CONFIG_ACPI */
-
 #ifdef CONFIG_OF
 static struct dw_dma_platform_data *
 dw_dma_parse_dt(struct platform_device *pdev)
-- 
2.20.1

