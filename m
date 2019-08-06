Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECB4D82EFB
	for <lists+dmaengine@lfdr.de>; Tue,  6 Aug 2019 11:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732254AbfHFJp2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Aug 2019 05:45:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:62195 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732197AbfHFJp2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 6 Aug 2019 05:45:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 02:40:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="325589304"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 06 Aug 2019 02:40:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C775D40E; Tue,  6 Aug 2019 12:40:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 07/12] dmaengine: dw: platform: Enable iDMA 32-bit on Intel Elkhart Lake
Date:   Tue,  6 Aug 2019 12:40:49 +0300
Message-Id: <20190806094054.64871-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806094054.64871-1-andriy.shevchenko@linux.intel.com>
References: <20190806094054.64871-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Intel Elkhart Lake OSE (Offload Service Engine) provides few DMA controllers
to the host. Enable them in the ACPI glue driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dw/platform.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw/platform.c b/drivers/dma/dw/platform.c
index 234abbd6359a..7e0ec6ef3a1f 100644
--- a/drivers/dma/dw/platform.c
+++ b/drivers/dma/dw/platform.c
@@ -173,7 +173,6 @@ static int dw_probe(struct platform_device *pdev)
 	struct dw_dma_chip *chip;
 	struct device *dev = &pdev->dev;
 	struct resource *mem;
-	const struct dw_dma_platform_data *pdata;
 	int err;
 
 	match = device_get_match_data(dev);
@@ -201,13 +200,14 @@ static int dw_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	pdata = dev_get_platdata(dev);
-	if (!pdata)
-		pdata = dw_dma_parse_dt(pdev);
+	if (!data->pdata)
+		data->pdata = dev_get_platdata(dev);
+	if (!data->pdata)
+		data->pdata = dw_dma_parse_dt(pdev);
 
 	chip->dev = dev;
 	chip->id = pdev->id;
-	chip->pdata = pdata;
+	chip->pdata = data->pdata;
 
 	data->chip = chip;
 
@@ -298,6 +298,12 @@ static const struct acpi_device_id dw_dma_acpi_id_table[] = {
 	{ "INTL9C60", (kernel_ulong_t)&dw_dma_chip_pdata },
 	{ "80862286", (kernel_ulong_t)&dw_dma_chip_pdata },
 	{ "808622C0", (kernel_ulong_t)&dw_dma_chip_pdata },
+
+	/* Elkhart Lake iDMA 32-bit (OSE DMA) */
+	{ "80864BB4", (kernel_ulong_t)&idma32_chip_pdata },
+	{ "80864BB5", (kernel_ulong_t)&idma32_chip_pdata },
+	{ "80864BB6", (kernel_ulong_t)&idma32_chip_pdata },
+
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, dw_dma_acpi_id_table);
-- 
2.20.1

