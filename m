Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE242A61A0
	for <lists+dmaengine@lfdr.de>; Wed,  4 Nov 2020 11:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgKDKcE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Nov 2020 05:32:04 -0500
Received: from mga07.intel.com ([134.134.136.100]:11201 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729059AbgKDKbf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 4 Nov 2020 05:31:35 -0500
IronPort-SDR: yIsi5+exOCWfZ6SFjMYfLNPTkc2VWST6weaCrM7Ohf/7WzAN8x8MILHw/9CjMWr1w/+TJCzw7H
 eSsASj0l9Gaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="233359914"
X-IronPort-AV: E=Sophos;i="5.77,450,1596524400"; 
   d="scan'208";a="233359914"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 02:31:34 -0800
IronPort-SDR: wb4+OKs2WtrqZ3D7csCfXCRdYuzq1khmBZLr8jgs5TzkmmEzTRur3JfTeUGT+9gFYKD9IYDAoo
 bqDK6sYTyKew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,450,1596524400"; 
   d="scan'208";a="306373716"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 04 Nov 2020 02:31:33 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 669A4646; Wed,  4 Nov 2020 12:31:32 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] dmaengine: idma64: Switch to use __maybe_unused instead of ifdeffery
Date:   Wed,  4 Nov 2020 12:31:31 +0200
Message-Id: <20201104103131.89907-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

ifdeffery is prone to errors and makes code harder to read.
Switch to use __maybe_unused instead of ifdeffery.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/idma64.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index f5a84c846394..f4c07ad3be15 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -667,9 +667,7 @@ static int idma64_platform_remove(struct platform_device *pdev)
 	return idma64_remove(chip);
 }
 
-#ifdef CONFIG_PM_SLEEP
-
-static int idma64_pm_suspend(struct device *dev)
+static int __maybe_unused idma64_pm_suspend(struct device *dev)
 {
 	struct idma64_chip *chip = dev_get_drvdata(dev);
 
@@ -677,7 +675,7 @@ static int idma64_pm_suspend(struct device *dev)
 	return 0;
 }
 
-static int idma64_pm_resume(struct device *dev)
+static int __maybe_unused idma64_pm_resume(struct device *dev)
 {
 	struct idma64_chip *chip = dev_get_drvdata(dev);
 
@@ -685,8 +683,6 @@ static int idma64_pm_resume(struct device *dev)
 	return 0;
 }
 
-#endif /* CONFIG_PM_SLEEP */
-
 static const struct dev_pm_ops idma64_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(idma64_pm_suspend, idma64_pm_resume)
 };
-- 
2.28.0

