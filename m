Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40FF282EE3
	for <lists+dmaengine@lfdr.de>; Tue,  6 Aug 2019 11:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732546AbfHFJlB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Aug 2019 05:41:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:57969 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732492AbfHFJlB (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 6 Aug 2019 05:41:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 02:41:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="176584849"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 06 Aug 2019 02:40:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BBB7F39A; Tue,  6 Aug 2019 12:40:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 06/12] dmaengine: dw: platform: Use struct dw_dma_chip_pdata
Date:   Tue,  6 Aug 2019 12:40:48 +0300
Message-Id: <20190806094054.64871-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806094054.64871-1-andriy.shevchenko@linux.intel.com>
References: <20190806094054.64871-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Now, when we have a generic structure for the chip and platform data,
use it in the platform glue driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dw/platform.c | 42 +++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/dw/platform.c b/drivers/dma/dw/platform.c
index 382dfd9e9600..234abbd6359a 100644
--- a/drivers/dma/dw/platform.c
+++ b/drivers/dma/dw/platform.c
@@ -168,12 +168,22 @@ dw_dma_parse_dt(struct platform_device *pdev)
 
 static int dw_probe(struct platform_device *pdev)
 {
+	const struct dw_dma_chip_pdata *match;
+	struct dw_dma_chip_pdata *data;
 	struct dw_dma_chip *chip;
 	struct device *dev = &pdev->dev;
 	struct resource *mem;
 	const struct dw_dma_platform_data *pdata;
 	int err;
 
+	match = device_get_match_data(dev);
+	if (!match)
+		return -ENODEV;
+
+	data = devm_kmemdup(&pdev->dev, match, sizeof(*match), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
 	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
@@ -199,6 +209,8 @@ static int dw_probe(struct platform_device *pdev)
 	chip->id = pdev->id;
 	chip->pdata = pdata;
 
+	data->chip = chip;
+
 	chip->clk = devm_clk_get(chip->dev, "hclk");
 	if (IS_ERR(chip->clk))
 		return PTR_ERR(chip->clk);
@@ -208,11 +220,11 @@ static int dw_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(&pdev->dev);
 
-	err = dw_dma_probe(chip);
+	err = data->probe(chip);
 	if (err)
 		goto err_dw_dma_probe;
 
-	platform_set_drvdata(pdev, chip);
+	platform_set_drvdata(pdev, data);
 
 	if (pdev->dev.of_node) {
 		err = of_dma_controller_register(pdev->dev.of_node,
@@ -235,12 +247,17 @@ static int dw_probe(struct platform_device *pdev)
 
 static int dw_remove(struct platform_device *pdev)
 {
-	struct dw_dma_chip *chip = platform_get_drvdata(pdev);
+	struct dw_dma_chip_pdata *data = platform_get_drvdata(pdev);
+	struct dw_dma_chip *chip = data->chip;
+	int ret;
 
 	if (pdev->dev.of_node)
 		of_dma_controller_free(pdev->dev.of_node);
 
-	dw_dma_remove(chip);
+	ret = data->remove(chip);
+	if (ret)
+		dev_warn(chip->dev, "can't remove device properly: %d\n", ret);
+
 	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(chip->clk);
 
@@ -249,7 +266,8 @@ static int dw_remove(struct platform_device *pdev)
 
 static void dw_shutdown(struct platform_device *pdev)
 {
-	struct dw_dma_chip *chip = platform_get_drvdata(pdev);
+	struct dw_dma_chip_pdata *data = platform_get_drvdata(pdev);
+	struct dw_dma_chip *chip = data->chip;
 
 	/*
 	 * We have to call do_dw_dma_disable() to stop any ongoing transfer. On
@@ -269,7 +287,7 @@ static void dw_shutdown(struct platform_device *pdev)
 
 #ifdef CONFIG_OF
 static const struct of_device_id dw_dma_of_id_table[] = {
-	{ .compatible = "snps,dma-spear1340" },
+	{ .compatible = "snps,dma-spear1340", .data = &dw_dma_chip_pdata },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dw_dma_of_id_table);
@@ -277,9 +295,9 @@ MODULE_DEVICE_TABLE(of, dw_dma_of_id_table);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id dw_dma_acpi_id_table[] = {
-	{ "INTL9C60", 0 },
-	{ "80862286", 0 },
-	{ "808622C0", 0 },
+	{ "INTL9C60", (kernel_ulong_t)&dw_dma_chip_pdata },
+	{ "80862286", (kernel_ulong_t)&dw_dma_chip_pdata },
+	{ "808622C0", (kernel_ulong_t)&dw_dma_chip_pdata },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, dw_dma_acpi_id_table);
@@ -289,7 +307,8 @@ MODULE_DEVICE_TABLE(acpi, dw_dma_acpi_id_table);
 
 static int dw_suspend_late(struct device *dev)
 {
-	struct dw_dma_chip *chip = dev_get_drvdata(dev);
+	struct dw_dma_chip_pdata *data = dev_get_drvdata(dev);
+	struct dw_dma_chip *chip = data->chip;
 
 	do_dw_dma_disable(chip);
 	clk_disable_unprepare(chip->clk);
@@ -299,7 +318,8 @@ static int dw_suspend_late(struct device *dev)
 
 static int dw_resume_early(struct device *dev)
 {
-	struct dw_dma_chip *chip = dev_get_drvdata(dev);
+	struct dw_dma_chip_pdata *data = dev_get_drvdata(dev);
+	struct dw_dma_chip *chip = data->chip;
 	int ret;
 
 	ret = clk_prepare_enable(chip->clk);
-- 
2.20.1

