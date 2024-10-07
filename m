Return-Path: <dmaengine+bounces-3287-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA469930C0
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 17:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FABC1C23039
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 15:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6BC1D86D5;
	Mon,  7 Oct 2024 15:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g8apA/uM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDB61D9346;
	Mon,  7 Oct 2024 15:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313765; cv=none; b=OtbOAukycw4HrkevwK485NQ5OGfoQBZa+tck57QF8VBXCdsMAClga7DcZwUFgIYzbccUaOA+K2lb29z6sEIrY83vVAd5HCpiqjG0qnoC04qmz7Ya0nRQEuR+3+a/EUJywfCVZaVZesTVYBSkb3BrVelFZZtbsFEzNxW01Tw/u7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313765; c=relaxed/simple;
	bh=BKbork5gBqIloe0Od1Y/sxmZlNndoLFGO0UTT9ogkmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PYVnT87TFpTmmqheocNxBsfIh/dBi30vly+SrUQjC4fuHBzcBCH3EfOwc4Bzi2HtSv9x36XD7O+hRA9nT2SHRWn0fpNjNUQtCbsNfO6LkqoDEU5bhysldTsPY9qfYHv0Dcv1jQd/6k00KORfGuTQn7FWPfrfkzRqYp3Uq+NcQUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g8apA/uM; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728313764; x=1759849764;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BKbork5gBqIloe0Od1Y/sxmZlNndoLFGO0UTT9ogkmY=;
  b=g8apA/uMkzQsPloPfPeC9UYHxnX4TqxyoFouPAtPHV112cka6pCi2+4+
   qpdQgnQ7KquDd8lygW/h16qr7LS+GzhjiMmcFKRQ92Htto2rOtph38m0f
   rBvWy6OOfpXOJ1vjxlyZ+Ta484Q7xxhrS3UBvQvQG1efOhbenPT/oa6zw
   luWU0RT7LlWdI36hHLPlUXHLv7ZBZw8vZCbFSBqFptEhMhxmZLD3RgTQS
   p5nJdURIjCtAxw9v/dO2l0+p/eDIX6nXS+xQpOOtuB0Dh3rXChA1hNdHs
   Nxx9ujFDStzRN9Ae1fFi+kubhCKO4Su2NHbCoEHiI3ZSVG1Q/1I/0NB61
   w==;
X-CSE-ConnectionGUID: tg4+znCkQGeI6OzOiHXz5g==
X-CSE-MsgGUID: 7DPfw7emTUeTQa1ydxAqfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27279181"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="27279181"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 08:09:23 -0700
X-CSE-ConnectionGUID: b2QRy3IWSiuZ6sE6fzhTTg==
X-CSE-MsgGUID: ax4fOGwGSuKVHByXMlJoEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="112968484"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 07 Oct 2024 08:09:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8DD9C301; Mon, 07 Oct 2024 18:09:13 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Viresh Kumar <vireshk@kernel.org>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v1 1/1] dmaengine: dw: Switch to LATE_SIMPLE_DEV_PM_OPS()
Date: Mon,  7 Oct 2024 18:09:12 +0300
Message-ID: <20241007150912.2183805-1-andriy.shevchenko@linux.intel.com>
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
index 47c58ad468cb..bf86c34285f3 100644
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


