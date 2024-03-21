Return-Path: <dmaengine+bounces-1468-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8578858C5
	for <lists+dmaengine@lfdr.de>; Thu, 21 Mar 2024 13:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB6ABB21314
	for <lists+dmaengine@lfdr.de>; Thu, 21 Mar 2024 12:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533E075803;
	Thu, 21 Mar 2024 12:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NyK2YckH"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD05859151;
	Thu, 21 Mar 2024 12:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711022700; cv=none; b=leyaxb/y4u0uEYcU4MWaLx9yHreLSdGUGQ8ZZHIWX1h3n/+QZqnvtIoQ0coFaeC8PWqhS1ZzmDp6DV9/yXPVa2a4eVYldEKwOKqaEmuXqG7EL7dPT52k/MBtupz4hr6DGzhA6CyJidC5le/uIWRr1mzi7Ux59DJQFLdwyTiKyxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711022700; c=relaxed/simple;
	bh=6ceQ0oYvakmkviN7nMvyjJL2oNFl6h52gxZmWMK6PLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qA5uMkCxOGwDDbaHVYNZe0Q47QC1Mp/RMydZVSjR5qUHoye0b6EnxN5SJopHTdKVy5+zgc4WRhs0ITI8xp8lBfW9LJb6vUwgw68eefQKPYTcc1p989pkXllKwlrNYdLauV35vnGLhPocv7wgPw6V5hSNKpaDxn1lmYVABemES6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NyK2YckH; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711022699; x=1742558699;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6ceQ0oYvakmkviN7nMvyjJL2oNFl6h52gxZmWMK6PLc=;
  b=NyK2YckHCQKZsFcxORzHZDBJ/6x5ggxQeRgnhTQ89bso0vvghyk6jJll
   jFveE/GTZeJt48eGXtGsOZVDUNexPNp4hQFHZWCQUiFFG1bY9FqJOYQGb
   8YHkoJxSwKuIJ4Ytv8qs6JySQicuvcPl/K1e2Vn9Y+CKO/J/OT6QDfR9C
   5nxsWOwPVXiulTc2DVCH4u1SfiSxagTbdkAPBQZ48vwJY/XJRMwxx+W8l
   Ya9tkq15eZ0VaEG42ycEdT5Sczr1L0UM3D6axtOyG3W5jjF3TtSQp1VVz
   GYRfgL99JYJrT5I7ZWaxpIB8iW5hbEXAAUO87FxLbh9NxxG5GymEC3IMv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="17453479"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="17453479"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 05:04:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="937065208"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="937065208"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 21 Mar 2024 05:04:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 094FD12B; Thu, 21 Mar 2024 14:04:54 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 1/1] idma64: Don't try to serve interrupts when device is powered off
Date: Thu, 21 Mar 2024 14:04:21 +0200
Message-ID: <20240321120453.1360138-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When iDMA 64-bit device is powered off, the IRQ status register
is all 1:s. This is never happen in real case and signalling that
the device is simply powered off. Don't try to serve interrupts
that are not ours.

Fixes: 667dfed98615 ("dmaengine: add a driver for Intel integrated DMA 64-bit")
Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
Closes: https://lore.kernel.org/r/700bbb84-90e1-4505-8ff0-3f17ea8bc631@gmail.com
Tested-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: added tag (Heiner), moved check to be before the debug message
 drivers/dma/idma64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index 78a938969d7d..1398814d8fbb 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -171,6 +171,10 @@ static irqreturn_t idma64_irq(int irq, void *dev)
 	u32 status_err;
 	unsigned short i;
 
+	/* Since IRQ may be shared, check if DMA controller is powered on */
+	if (status == GENMASK(31, 0))
+		return IRQ_NONE;
+
 	dev_vdbg(idma64->dma.dev, "%s: status=%#x\n", __func__, status);
 
 	/* Check if we have any interrupt from the DMA controller */
-- 
2.43.0.rc1.1.gbec44491f096


