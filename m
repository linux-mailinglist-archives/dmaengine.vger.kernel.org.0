Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84A8A95FBD
	for <lists+dmaengine@lfdr.de>; Tue, 20 Aug 2019 15:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbfHTNPx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Aug 2019 09:15:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:13766 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729672AbfHTNPx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Aug 2019 09:15:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 06:15:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="378560800"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 20 Aug 2019 06:15:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 638FD373; Tue, 20 Aug 2019 16:15:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 08/10] dmaengine: dw: platform: Move handle check to dw_dma_acpi_controller_register()
Date:   Tue, 20 Aug 2019 16:15:44 +0300
Message-Id: <20190820131546.75744-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190820131546.75744-1-andriy.shevchenko@linux.intel.com>
References: <20190820131546.75744-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Move ACPI handle check to the dw_dma_acpi_controller_register().

While here, convert it to has_acpi_companion() which is recommended way.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dw/platform.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw/platform.c b/drivers/dma/dw/platform.c
index 44fec1eabccd..b8514d7895d1 100644
--- a/drivers/dma/dw/platform.c
+++ b/drivers/dma/dw/platform.c
@@ -76,6 +76,9 @@ static void dw_dma_acpi_controller_register(struct dw_dma *dw)
 	struct acpi_dma_filter_info *info;
 	int ret;
 
+	if (!has_acpi_companion(dev))
+		return;
+
 	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return;
@@ -93,6 +96,9 @@ static void dw_dma_acpi_controller_free(struct dw_dma *dw)
 {
 	struct device *dev = dw->dma.dev;
 
+	if (!has_acpi_companion(dev))
+		return;
+
 	acpi_dma_controller_free(dev);
 }
 #else /* !CONFIG_ACPI */
@@ -239,8 +245,7 @@ static int dw_probe(struct platform_device *pdev)
 				"could not register of_dma_controller\n");
 	}
 
-	if (ACPI_HANDLE(&pdev->dev))
-		dw_dma_acpi_controller_register(chip->dw);
+	dw_dma_acpi_controller_register(chip->dw);
 
 	return 0;
 
@@ -256,8 +261,7 @@ static int dw_remove(struct platform_device *pdev)
 	struct dw_dma_chip *chip = data->chip;
 	int ret;
 
-	if (ACPI_HANDLE(&pdev->dev))
-		dw_dma_acpi_controller_free(chip->dw);
+	dw_dma_acpi_controller_free(chip->dw);
 
 	if (pdev->dev.of_node)
 		of_dma_controller_free(pdev->dev.of_node);
-- 
2.23.0.rc1

