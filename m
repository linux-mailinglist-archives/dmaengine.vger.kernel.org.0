Return-Path: <dmaengine+bounces-3288-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 922989930C2
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 17:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 611622848DD
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 15:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB151D414C;
	Mon,  7 Oct 2024 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EHRpfCYt"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC241DDC9;
	Mon,  7 Oct 2024 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313788; cv=none; b=CvrYXlBe4SSrNOu86nPOhoAi5/Yr3Xy/cu3/OD91TeUSm0VlyJzYAEBF4u7BkzeHp5DD42bnDBzGn2quk/Kyfy2EPgnhaRsIsd3NMTKFFOrG0J3rkamK9b4DwpRJWi34tAav0/i8CmPTiVrBBAdyOnff7P8CTaR8Q4yX7DApWZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313788; c=relaxed/simple;
	bh=GdFJbEH9FuHcHkDgW9w9j0RlEqZ4KkfewDrDe8HQ5S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kwoNZBBN06hm0Ro6m6gYggmZiV7cGVBvQ8Xac5Pa5lMI3qE8hxuex7cwtq0GFmeVK2mq/qsWXNOZIzBsLAd5+gWwBPiGgT6C91gOGD9zZS2wbBmRsL05G4u9sYkH8J6E9ueCm2kj7UKV6uqLX+E6dUbZaryGJjLSztyir7KksC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EHRpfCYt; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728313788; x=1759849788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GdFJbEH9FuHcHkDgW9w9j0RlEqZ4KkfewDrDe8HQ5S0=;
  b=EHRpfCYthSgsmIBj/g/XCZYHa3d5g3L7Kuz3z8gcDMs0mRKorGgCfJ1m
   +G5EA2XF8pGMtwsopvrcMRMVe4R9R+31uYtJIWJ4hAhpOURmp0rUPMH4h
   3hYc0NCiNGROdqBc5fd70Co5jToS/Tz92jptg2S3Vgc4r6CsFIJ1tRSpF
   VBDZqaD/KSZzO76pKAHDUXWGfwkJfPgTSuQqQ1lj1wPbrpWHenMI6kYYE
   Yd1Sg9NLGWGLWlNskyXJ7F8/EYALSzR5pkCHhTc7pA9yL3nGxPOpyhvxc
   ILl9ooL9m/i+GwouWgBt650aJffvYDDq9yAaHgB3O1Og6kweqJqP2F6Qm
   w==;
X-CSE-ConnectionGUID: tUzxjHwkTLKRTROtq+ka/g==
X-CSE-MsgGUID: uWx1fKZFQsqNok3oq8ZEtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27346847"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="27346847"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 08:08:58 -0700
X-CSE-ConnectionGUID: EVLZ8vnYQ3+e6g0dKKK1lA==
X-CSE-MsgGUID: 4tzqZlrqSAGNiQT0kZMEmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="79494665"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 07 Oct 2024 08:08:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C116A27C; Mon, 07 Oct 2024 18:08:53 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v1 1/4] dmaengine: Replace dma_request_slave_channel() by dma_request_chan()
Date: Mon,  7 Oct 2024 18:06:45 +0300
Message-ID: <20241007150852.2183722-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241007150852.2183722-1-andriy.shevchenko@linux.intel.com>
References: <20241007150852.2183722-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace dma_request_slave_channel() by dma_request_chan() as suggested
since the former is deprecated.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/imx-sdma.c    | 5 ++---
 include/linux/dmaengine.h | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 72299a08af44..3a769934c984 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1459,9 +1459,8 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
 	 * dmatest, thus create 'struct imx_dma_data mem_data' for this case.
 	 * Please note in any other slave case, you have to setup chan->private
 	 * with 'struct imx_dma_data' in your own filter function if you want to
-	 * request dma channel by dma_request_channel() rather than
-	 * dma_request_slave_channel(). Othwise, 'MEMCPY in case?' will appear
-	 * to warn you to correct your filter function.
+	 * request DMA channel by dma_request_channel(), otherwise, 'MEMCPY in
+	 * case?' will appear to warn you to correct your filter function.
 	 */
 	if (!data) {
 		dev_dbg(sdmac->sdma->dev, "MEMCPY in case?\n");
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index b137fdb56093..b4e6de892d34 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1632,8 +1632,8 @@ static inline struct dma_chan
 {
 	struct dma_chan *chan;
 
-	chan = dma_request_slave_channel(dev, name);
-	if (chan)
+	chan = dma_request_chan(dev, name);
+	if (!IS_ERR(chan))
 		return chan;
 
 	if (!fn || !fn_param)
-- 
2.43.0.rc1.1336.g36b5255a03ac


