Return-Path: <dmaengine+bounces-7104-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A35A1C45750
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 09:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74B96188FB12
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 08:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440652FD1D5;
	Mon, 10 Nov 2025 08:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TbqrNStJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753ED254AFF;
	Mon, 10 Nov 2025 08:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764834; cv=none; b=LZwTgpGTpp1EOuIqAUST0chSfR+dfOQKZj3K9G+aPBfR7vxFbuKBjhmhhw8YE98f/Hruhu/hzDnjy7NbJgTGuL5d0LK6oBZ2trnnm6w5oI0YineQZAN7UF+XjN1Hu2J1pBtqGJduifmgpSXSE5F+zqzuQTqa2rpBQ0QebV7imtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764834; c=relaxed/simple;
	bh=H2Ut4C47TjTTWAEiAZB6fT+V+Bi06YVKL5a7Ju+hC+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QvXzOsuK+nE95BQGT0JRqtV7O6whC78V2NNPg7TlMYJ5KtdYA7YsuEWj9QGf6og2ztB6vIiPumdvSSPar+VOQPQkO6uPfpZp5UeX4INSY7oXww0JXCrSU5+oDKI+HlPNl5M8zKVE0KWNBS0CJp7TJKpp3aRvAsdC1EYWno8fmMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TbqrNStJ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762764832; x=1794300832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H2Ut4C47TjTTWAEiAZB6fT+V+Bi06YVKL5a7Ju+hC+U=;
  b=TbqrNStJKBAG17ubxWqsCUFYljUjKDba5yJSh+lcSwHObgS33aCYIfVf
   k9qj9/Xoi1ESugE9HRYKEH+v/scQRT8MDyww81rbfTG60Kj+k6ksxqRYB
   eZLgxoAAkNmsOUfxhT5Ee60/vPUfegPD5SFw6bFE3rbo402QvkKjXVtmF
   JS/7Zy50Rl/92fdOLB4CjFHduBcetgfo6ZEa1Xqc5T1If9zyCBPCnjUjo
   noYwtVAi0v+BssOMqyORYg0XqWvL6kEmTDnZXywvb1UrPBNgr16IMhCLb
   miKl7U20xxygjpIwaQFrDBGXTH6H8jmE6FVrjrBa2pAsz2rHyThnpaFWB
   A==;
X-CSE-ConnectionGUID: /lrjNrGAQTqFwOH7sxoenQ==
X-CSE-MsgGUID: s3n+L3x9TXSrMyBOd2gJzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="67417845"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="67417845"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 00:53:52 -0800
X-CSE-ConnectionGUID: J5AWogJfSsCj2ztNDCWb9A==
X-CSE-MsgGUID: WjtjAC/mSKekqckoNB02QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="188458045"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 10 Nov 2025 00:53:50 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 2DCC698; Mon, 10 Nov 2025 09:53:50 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v2 3/3] dmaengine: Sort headers alphabetically
Date: Mon, 10 Nov 2025 09:47:45 +0100
Message-ID: <20251110085349.3414507-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251110085349.3414507-1-andriy.shevchenko@linux.intel.com>
References: <20251110085349.3414507-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For better maintenance sort headers alphabetically.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dmaengine.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index e89280587d5d..5bc38424398b 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -31,29 +31,29 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/platform_device.h>
-#include <linux/dma-mapping.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/mm.h>
-#include <linux/device.h>
-#include <linux/dmaengine.h>
-#include <linux/hardirq.h>
-#include <linux/spinlock.h>
-#include <linux/of.h>
-#include <linux/property.h>
-#include <linux/percpu.h>
-#include <linux/rcupdate.h>
-#include <linux/mutex.h>
-#include <linux/jiffies.h>
-#include <linux/rculist.h>
-#include <linux/idr.h>
-#include <linux/slab.h>
 #include <linux/acpi.h>
 #include <linux/acpi_dma.h>
-#include <linux/of_dma.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/hardirq.h>
+#include <linux/idr.h>
+#include <linux/init.h>
+#include <linux/jiffies.h>
 #include <linux/mempool.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/numa.h>
+#include <linux/of.h>
+#include <linux/of_dma.h>
+#include <linux/percpu.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/rculist.h>
+#include <linux/rcupdate.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
 
 #include "dmaengine.h"
 
-- 
2.50.1


