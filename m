Return-Path: <dmaengine+bounces-7097-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BFDC44912
	for <lists+dmaengine@lfdr.de>; Sun, 09 Nov 2025 23:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 166E3346209
	for <lists+dmaengine@lfdr.de>; Sun,  9 Nov 2025 22:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F1226560D;
	Sun,  9 Nov 2025 22:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jwF0pecF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789F01FC8;
	Sun,  9 Nov 2025 22:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762727389; cv=none; b=rI0Zok1Qom8plOZ/2k1qPxox7VFplrI5t5pWNmy+wSFSNM6IbSG5Y7Az+4VC8lLtA+/NxmmmPqJ7JBhVtU3LJHcwUJroip74NdCBdHxCKUfo9bqmzASMC8X1pkTLNIJ2H3agObsuo5jUlzgrwO6DyjRWFICcTdv6+naKGUg/5kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762727389; c=relaxed/simple;
	bh=77CKwVdtWsJNWpKftuBU7e7nzwOjoeEWoDpjWJbNI/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQuGf4yOOrW9C9iIh3iGQNgUlfCtkKdQHjGmq3yHm4wvSm0Rbi5gPcb9LP/EXbWQxCDCtvjsvnOEINLYKZrbnG52kE0EmPM3mXKFzZ5s13klkcs2xTPyCEDrzgymj/c2AWJKumWTFggipWzYG2BEkMiqIUg6JjtAfgZVHTOO4vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jwF0pecF; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762727388; x=1794263388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=77CKwVdtWsJNWpKftuBU7e7nzwOjoeEWoDpjWJbNI/A=;
  b=jwF0pecF/x3gLbwXoB+k1RecffYYjO9E3GRiGLZo+PsewpIocJ6VTp3e
   N345OipO8ycylWvQZ4S/NcBnLmdG1OkVtEW/WBcPDes+Xa017+R/X5jdV
   QbbL/yvBVtAQoULV6TYCJlRlLxu2gLCg0OMHYHelfADZ9eEtpuoW3QMjj
   Bcs9GCl8z+u416wdpxSgtlmUGWalVjrmQHN5ixFtwHtuADckfisBqNyH2
   UYVHvj0hcDhxsTryGRqtIhgSCwHBRgaZy4W7G88iU4s0Y3tQdmy2HkOVV
   yhm445lp3m/B6L7LnHBm351qia3yCVryyGWQZh49sV84u9QVS7qctY4kW
   Q==;
X-CSE-ConnectionGUID: Xa1xhtnJTLSpIVR4QG/41g==
X-CSE-MsgGUID: h4uIsd1dS0CbY7VDRAg76A==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="75078159"
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="75078159"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 14:29:48 -0800
X-CSE-ConnectionGUID: gewZSnbNRpORYD4h5O1XLA==
X-CSE-MsgGUID: MlN4RGmBTRSZzWCpjh8Fqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="192786027"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 09 Nov 2025 14:29:47 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 4327596; Sun, 09 Nov 2025 23:29:45 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v1 1/4] dmaengine: Use dma_request_channel() instead of __dma_request_channel()
Date: Sun,  9 Nov 2025 23:28:34 +0100
Message-ID: <20251109222944.3222436-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251109222944.3222436-1-andriy.shevchenko@linux.intel.com>
References: <20251109222944.3222436-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reduce use of internal __dma_request_channel() function.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dmaengine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index ca13cd39330b..cd1c0744bfc0 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -886,7 +886,7 @@ struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask)
 	if (!mask)
 		return ERR_PTR(-ENODEV);
 
-	chan = __dma_request_channel(mask, NULL, NULL, NULL);
+	chan = dma_request_channel(mask, NULL, NULL);
 	if (!chan) {
 		mutex_lock(&dma_list_mutex);
 		if (list_empty(&dma_device_list))
-- 
2.50.1


