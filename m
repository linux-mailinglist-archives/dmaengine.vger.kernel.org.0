Return-Path: <dmaengine+bounces-1453-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDEC8815AF
	for <lists+dmaengine@lfdr.de>; Wed, 20 Mar 2024 17:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 270C528556E
	for <lists+dmaengine@lfdr.de>; Wed, 20 Mar 2024 16:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B135AA47;
	Wed, 20 Mar 2024 16:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a7e6M0S/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF63E7EB;
	Wed, 20 Mar 2024 16:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710952337; cv=none; b=U6e9YZl4DGxLIoKY29+hZUlyL2ySpToz7UJb49U6hjTpQ3m/Qc7M9/Ko6cIasBtWicFZHpgWMyyLtJNhPPVV26bdWJUVabyTczCrKK36d1S2wIYQbwZrApXHkHEg3pHkxVFMgbbh5f0HItDjdfYi/ZoqqyVYCEpsSz3zRQirRz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710952337; c=relaxed/simple;
	bh=BUylS3kME2q0eaZg/TAVRkngmIlm+goa7PviZhmabOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d06d/ZflQXMuhkgpDjgZslP60TMGnHZPYKWRSfCXZjEU1G2l+bt9SBWhjG1ViIgF9dWc6H2cR//LrEQM3pK7wwyWegL1Os129+stafpg1hB81/h+sHDUsm//Q72lMt2zxAhEiILeLO0jQSsWSS+EqPzCHmysyJXUcS1lC8NekKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a7e6M0S/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710952336; x=1742488336;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BUylS3kME2q0eaZg/TAVRkngmIlm+goa7PviZhmabOg=;
  b=a7e6M0S/NnRO1q8VX63PZY/HgJ1InDRVCU9ftPLo1Uvd9K6mNegAGGZg
   a1bvckuHYcM8vFtLcxCmBkExyfF/HTamiDbCL741VynYtWHA3BG6Yz4om
   YPuxo+1gFqxhtlHovXmOCeugIsEQwdS8Ol+0OrxR45FHgky8s3O36tq+R
   lFbEjG23s+wFYd5du1yHf0Ssk0+7fubBmXo0EGNPDCJy9WEw2SnNSVhqD
   95r6PmKlYxM+8YtYzyvTIkdcRo0X19RSUuGd3pWJxrQBBm6E5KyAI5aE1
   udJNcXTLoYv9VQPF5+YFuyWs6Bw8+bA0xmXCR9L7Hv3yZdvb7curCUrRX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="31324324"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="31324324"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 09:32:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="937063848"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="937063848"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 20 Mar 2024 09:32:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4CDA930D; Wed, 20 Mar 2024 18:32:12 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v1 1/1] idma64: Don't try to serve interrupts when device is powered off
Date: Wed, 20 Mar 2024 18:32:10 +0200
Message-ID: <20240320163210.1153679-1-andriy.shevchenko@linux.intel.com>
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
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/idma64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index 78a938969d7d..1b60e73d9322 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -173,6 +173,10 @@ static irqreturn_t idma64_irq(int irq, void *dev)
 
 	dev_vdbg(idma64->dma.dev, "%s: status=%#x\n", __func__, status);
 
+	/* Since IRQ may be shared, check if DMA controller is powered on */
+	if (status == GENMASK(31, 0))
+		return IRQ_NONE;
+
 	/* Check if we have any interrupt from the DMA controller */
 	if (!status)
 		return IRQ_NONE;
-- 
2.43.0.rc1.1.gbec44491f096


