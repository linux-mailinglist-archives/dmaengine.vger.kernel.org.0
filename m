Return-Path: <dmaengine+bounces-1158-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7970586B963
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 21:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DDC91C26C6E
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 20:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9563D72932;
	Wed, 28 Feb 2024 20:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QZ09pxQo"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DA470024;
	Wed, 28 Feb 2024 20:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709153388; cv=none; b=A4I/YGhh7YB2UJXVAYotwg7A2QWygpwDT/3YxWzznFJxoGlJTzk1rk7VQTn6jSEBn1PQ7i3IujN8kgJMAmOrVbK+2DOpFUkZXvHxY61AN0jsIfIncCuBK2hCagQ03+GwjOxHYvfJwS5jRekYlh6wNSNnlPp9KSOjNWljKTJjaK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709153388; c=relaxed/simple;
	bh=8BAIf0j7CaHKQ/zZDl1HE0ybcnT2/U9McrHMACFS6nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bc6m38LBgqBZkBhVaFOtO+WM5p2QxZ8o3FtlkQCeA2ForQLLRsS5mqXmZ150IPNqqpksrdFB/R+ifzRjCAEA//Yy1dPEbUlmF6xqymY1Xm30Tw+mcCVVNjBgaLK2K9Xn2yI8cYM2vPR4HbHSKdrMxPw65FDIbK2NzIda08I08Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QZ09pxQo; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709153387; x=1740689387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8BAIf0j7CaHKQ/zZDl1HE0ybcnT2/U9McrHMACFS6nk=;
  b=QZ09pxQorS2cktz5/PqzrEEJ1ZhQzKXIsb/o28M2LCQ+Y/WAQrWPi0VI
   Rnv6d9HOpXGy6XYOgXfU6x6TWSfN5oVmL2F8YxXIUAyYmk8CjoMPkjzsW
   Fwn1wxZlojqJnEXm59296i/tLew/BkQND+BmXAjUhUQ84Y98vJiDMKV7t
   KEqO3hTKBM7agMu1DmK4Y9H+bai+gkmYnYO8A6rAZ11lZXv8mTFqS9Y7L
   qWIeOqx9ig/8Igy/UlXUQ2WnbV+GN033+kopYAGurPJQzxiccqpA/OwJz
   +IHR+BErf/HlrfaSP/wON9gSqHMrs9buO8WTXEFpX6SwySuDkVhDZfHdo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3428753"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="3428753"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 12:49:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="937034663"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="937034663"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2024 12:49:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6F964715; Wed, 28 Feb 2024 22:49:34 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vinod Koul <vkoul@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH v4 8/8] dmaengine: ste_dma40: Use new helpers from overflow.h
Date: Wed, 28 Feb 2024 22:41:38 +0200
Message-ID: <20240228204919.3680786-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com>
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have two new helpers struct_size_with_data() and struct_data_pointer()
that we can utilize in d40_hw_detect_init(). Do it so.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/ste_dma40.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 2c489299148e..bead3b8836c7 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -15,6 +15,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/log2.h>
+#include <linux/overflow.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/err.h>
@@ -3141,6 +3142,7 @@ static int __init d40_hw_detect_init(struct platform_device *pdev,
 	int num_log_chans;
 	int num_phy_chans;
 	int num_memcpy_chans;
+	size_t sz;
 	int i;
 	u32 pid;
 	u32 cid;
@@ -3207,11 +3209,9 @@ static int __init d40_hw_detect_init(struct platform_device *pdev,
 		 "hardware rev: %d with %d physical and %d logical channels\n",
 		 rev, num_phy_chans, num_log_chans);
 
-	base = devm_kzalloc(dev,
-		ALIGN(sizeof(struct d40_base), 4) +
-		(num_phy_chans + num_log_chans + num_memcpy_chans) *
-		sizeof(struct d40_chan), GFP_KERNEL);
-
+	sz = array_size(num_phy_chans + num_log_chans + num_memcpy_chans,
+			sizeof(struct d40_chan));
+	base = devm_kzalloc(dev, struct_size_with_data(base, 4, sz), GFP_KERNEL);
 	if (!base)
 		return -ENOMEM;
 
@@ -3223,7 +3223,7 @@ static int __init d40_hw_detect_init(struct platform_device *pdev,
 	base->virtbase = virtbase;
 	base->plat_data = plat_data;
 	base->dev = dev;
-	base->phy_chans = ((void *)base) + ALIGN(sizeof(struct d40_base), 4);
+	base->phy_chans = struct_data_pointer(base, 4);
 	base->log_chans = &base->phy_chans[num_phy_chans];
 
 	if (base->plat_data->num_of_phy_chans == 14) {
-- 
2.43.0.rc1.1.gbec44491f096


