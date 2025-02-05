Return-Path: <dmaengine+bounces-4309-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A8DA293B7
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 16:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A8083AAF21
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 15:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2561170A13;
	Wed,  5 Feb 2025 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l4y9LgeN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3966C1E89C;
	Wed,  5 Feb 2025 15:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768028; cv=none; b=KDoIfEmCmyj28HOa1LTPdMFv2v3tCfTPtMqc8Qg09542rRK1NkizpShVghD38npBehR4za0cJ9AgXFtTNsWiCR1FSEmJ+ZgdvtfgxnhNMngUQYoair+CGaiKFWNCxH3PnRyT8NWWhEi4dL7+o4SZ+5h8eENbV9dOMLEwW+iPTmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768028; c=relaxed/simple;
	bh=6dFCiRvGPFYLimEwIAGFtwpExZsUf7bI25MVWx+7PGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cbvx1diK5+YkppbeGBahzrZBPsg2J+QpMPc26U2y7D4BX5CxDRoVTtiEGSvlLGGC7s0i813I4ZGZyYkfoc2LZ6kfRZCngbfyvoP32APfBmDJy9NXgmBlV9POoZlCinnDC3SGbGXzesKbwKV/gqu7qDif5WNha3jUz9yXDXy6DQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l4y9LgeN; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738768027; x=1770304027;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6dFCiRvGPFYLimEwIAGFtwpExZsUf7bI25MVWx+7PGA=;
  b=l4y9LgeN3AG+WHXfGFCyHeRhRijDZqn7PSzPdLWIaIiWRaCyBJhR/Twc
   lTPB/QpRsfAe56nQ2XTBEGDz9cnbA9eTGjHb6JoKJTGtnqmREgnQXu/wN
   lwJ+plb8LcjmPx0MnMbjjVmir0zx8MOgw2EiTNJSzdCPmD+/Xag5LElhC
   XXDT8GBnpHXwBB+vqEiPvBBF+CT6nWWTxr86HwF4SLD6Hlc+KxebF8Pew
   FpsF3rZ8kYbywFSIP8i50Mx7xKcgP0vA6c/EZHQcq37ljXx5LeDwulE3I
   fZKNPlv5BLIfFQyxQGgwbhxxd6P3xSQ/Z/ZpMU63MADVNQBsD1hmnIPqJ
   w==;
X-CSE-ConnectionGUID: SOnClJm3Tu67Y4jzOgUIVA==
X-CSE-MsgGUID: gt21gG9hTWOHIn1C4e7l+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="56876875"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="56876875"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 07:07:06 -0800
X-CSE-ConnectionGUID: Cnm0773VTG2ARi1R1+uEwg==
X-CSE-MsgGUID: qzv2QuPERje5gyAL7K9xiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="115897485"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 05 Feb 2025 07:07:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 31FA710D; Wed, 05 Feb 2025 17:07:03 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vinod Koul <vkoul@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Viresh Kumar <vireshk@kernel.org>
Subject: [PATCH v2 1/1] dmaengine: dw: Switch to LATE_SIMPLE_DEV_PM_OPS()
Date: Wed,  5 Feb 2025 17:06:48 +0200
Message-ID: <20250205150701.893083-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SET_LATE_SYSTEM_SLEEP_PM_OPS is deprecated, replace it with
LATE_SYSTEM_SLEEP_PM_OPS() and use pm_sleep_ptr() for setting
the driver's pm routines. We can now remove the ifdeffery
in the suspend and resume functions.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: rebased on top of v6.14-rc1

 drivers/dma/dw/pci.c      | 8 ++------
 drivers/dma/dw/platform.c | 8 ++------
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/dw/pci.c b/drivers/dma/dw/pci.c
index e8a0eb81726a..a3aae3d1c093 100644
--- a/drivers/dma/dw/pci.c
+++ b/drivers/dma/dw/pci.c
@@ -76,8 +76,6 @@ static void dw_pci_remove(struct pci_dev *pdev)
 		dev_warn(&pdev->dev, "can't remove device properly: %d\n", ret);
 }
 
-#ifdef CONFIG_PM_SLEEP
-
 static int dw_pci_suspend_late(struct device *dev)
 {
 	struct dw_dma_chip_pdata *data = dev_get_drvdata(dev);
@@ -94,10 +92,8 @@ static int dw_pci_resume_early(struct device *dev)
 	return do_dw_dma_enable(chip);
 };
 
-#endif /* CONFIG_PM_SLEEP */
-
 static const struct dev_pm_ops dw_pci_dev_pm_ops = {
-	SET_LATE_SYSTEM_SLEEP_PM_OPS(dw_pci_suspend_late, dw_pci_resume_early)
+	LATE_SYSTEM_SLEEP_PM_OPS(dw_pci_suspend_late, dw_pci_resume_early)
 };
 
 static const struct pci_device_id dw_pci_id_table[] = {
@@ -136,7 +132,7 @@ static struct pci_driver dw_pci_driver = {
 	.probe		= dw_pci_probe,
 	.remove		= dw_pci_remove,
 	.driver	= {
-		.pm	= &dw_pci_dev_pm_ops,
+		.pm	= pm_sleep_ptr(&dw_pci_dev_pm_ops),
 	},
 };
 
diff --git a/drivers/dma/dw/platform.c b/drivers/dma/dw/platform.c
index 2606cf9cd429..cee56cd31a61 100644
--- a/drivers/dma/dw/platform.c
+++ b/drivers/dma/dw/platform.c
@@ -157,8 +157,6 @@ static const struct acpi_device_id dw_dma_acpi_id_table[] = {
 MODULE_DEVICE_TABLE(acpi, dw_dma_acpi_id_table);
 #endif
 
-#ifdef CONFIG_PM_SLEEP
-
 static int dw_suspend_late(struct device *dev)
 {
 	struct dw_dma_chip_pdata *data = dev_get_drvdata(dev);
@@ -183,10 +181,8 @@ static int dw_resume_early(struct device *dev)
 	return do_dw_dma_enable(chip);
 }
 
-#endif /* CONFIG_PM_SLEEP */
-
 static const struct dev_pm_ops dw_dev_pm_ops = {
-	SET_LATE_SYSTEM_SLEEP_PM_OPS(dw_suspend_late, dw_resume_early)
+	LATE_SYSTEM_SLEEP_PM_OPS(dw_suspend_late, dw_resume_early)
 };
 
 static struct platform_driver dw_driver = {
@@ -195,7 +191,7 @@ static struct platform_driver dw_driver = {
 	.shutdown       = dw_shutdown,
 	.driver = {
 		.name	= DRV_NAME,
-		.pm	= &dw_dev_pm_ops,
+		.pm	= pm_sleep_ptr(&dw_dev_pm_ops),
 		.of_match_table = of_match_ptr(dw_dma_of_id_table),
 		.acpi_match_table = ACPI_PTR(dw_dma_acpi_id_table),
 	},
-- 
2.43.0.rc1.1336.g36b5255a03ac


