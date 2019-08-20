Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 275B095FB8
	for <lists+dmaengine@lfdr.de>; Tue, 20 Aug 2019 15:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbfHTNPw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Aug 2019 09:15:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:13976 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729576AbfHTNPw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Aug 2019 09:15:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 06:15:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="202674810"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 20 Aug 2019 06:15:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 411CF2BA; Tue, 20 Aug 2019 16:15:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 05/10] dmaengine: dw: platform: Enable iDMA 32-bit on Intel Elkhart Lake
Date:   Tue, 20 Aug 2019 16:15:41 +0300
Message-Id: <20190820131546.75744-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190820131546.75744-1-andriy.shevchenko@linux.intel.com>
References: <20190820131546.75744-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Intel® PSE (Programmable Services Engine) provides few DMA controllers
to the host on Intel Elkhart Lake. Enable them in the ACPI glue driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dw/platform.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw/platform.c b/drivers/dma/dw/platform.c
index 234abbd6359a..63465fd0e286 100644
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
+	/* Elkhart Lake iDMA 32-bit (PSE DMA) */
+	{ "80864BB4", (kernel_ulong_t)&idma32_chip_pdata },
+	{ "80864BB5", (kernel_ulong_t)&idma32_chip_pdata },
+	{ "80864BB6", (kernel_ulong_t)&idma32_chip_pdata },
+
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, dw_dma_acpi_id_table);
-- 
2.23.0.rc1

