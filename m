Return-Path: <dmaengine+bounces-8180-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98350D0BBA9
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 18:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DD393017F13
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 17:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023F4366DD7;
	Fri,  9 Jan 2026 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NgzkXxbU"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C522933BBC6;
	Fri,  9 Jan 2026 17:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767980245; cv=none; b=bTzJqVT2jl3s74N/f+rz1fSER/o3miefHNjqhJVEKPmt2YtWB3P7sCjH/tBcgOSzcRzbzTpoNS4KD1XsQlDq5ksmoVv9DFxQEku+JYsHG/Hs/I7b6VP+daNBwRLifxody1E2wkLYleU8AL3e9UAa4/kZ1Q3o8HJBnyt1l8evNY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767980245; c=relaxed/simple;
	bh=Ezv/cI+S7Rpio/bPOgUj7+jGK2vl4C3PC4kBtAVLg9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHf3nnlDEFFxfBFXLYWGWohwMbv7rjJuTeyYfCZ/YGxU/M3YYW/A2kqBM0K88zSicQPXvvxtzbNuuEvNDb0KBJV3WNIGD+CfQwI7dmkbx04RlUECBx6cpaX6fXod8mTAXy3Sn/Xr1eg9JBUvaaCVztOLB+76M+QXHeqbKu20jRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NgzkXxbU; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767980243; x=1799516243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ezv/cI+S7Rpio/bPOgUj7+jGK2vl4C3PC4kBtAVLg9U=;
  b=NgzkXxbUwNVYlz3BLa8/nMsjqDVqOOzFOQS4fn9KPz/gxfHAuo4yidlP
   L2xGZ1AyfcKftaQQ5YVGmBLeg9wfviXgVSKRQrMYNTllR6kxF7CaLF+vT
   y0Tt8YXknBFYgaVFqWoNW6lZVIKekS5zLQmneG0PkUvNhIDZ8DuIrI4GY
   lFbc1hfl2OnsiYd9cK4/J7UwNdbr4B9XkwEeR4wArPn6nyZnPVLCZBpA5
   38qlS4fEBfXCjlL9a5TJeV7zL/VmKBxB1W9QpV8Ij7KfozPvhXEOlft5B
   FgUhKUVOPVFeKPx2ccF+Plr7B8TSKW8nEE8pUttvYwLix9HqT3Fy6xSLl
   A==;
X-CSE-ConnectionGUID: wJqR3ZBOSWe/bxang7+kZg==
X-CSE-MsgGUID: +s3E0HPcR0+Wey/3j54H3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="69296536"
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="69296536"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 09:37:21 -0800
X-CSE-ConnectionGUID: 0kyikiZ0RTGClZJ+U3eKQQ==
X-CSE-MsgGUID: mUAQbDW6SxKhNDG/eW34Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="204318498"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 09 Jan 2026 09:37:20 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 3635F98; Fri, 09 Jan 2026 18:37:19 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v3 1/3] dmaengine: Refactor devm_dma_request_chan() for readability
Date: Fri,  9 Jan 2026 18:35:41 +0100
Message-ID: <20260109173718.3605829-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260109173718.3605829-1-andriy.shevchenko@linux.intel.com>
References: <20260109173718.3605829-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Yes, while it's a bit longer in terms of LoCs, it's more readable
when we use the usual patter to check for errors, and not for
a success). This eliminates unneeded assignment and moves the
needed one closer to its user which is better programming pattern
because it allows avoiding potential errors in case the variable
is getting reused. Also note that the same pattern have been used
already in dmaenginem_async_device_register().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dmaengine.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index ca13cd39330b..8fe552c74eb8 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -943,12 +943,14 @@ static void dmaenginem_release_channel(void *chan)
 
 struct dma_chan *devm_dma_request_chan(struct device *dev, const char *name)
 {
-	struct dma_chan *chan = dma_request_chan(dev, name);
-	int ret = 0;
+	struct dma_chan *chan;
+	int ret;
 
-	if (!IS_ERR(chan))
-		ret = devm_add_action_or_reset(dev, dmaenginem_release_channel, chan);
+	chan = dma_request_chan(dev, name);
+	if (IS_ERR(chan))
+		return chan;
 
+	ret = devm_add_action_or_reset(dev, dmaenginem_release_channel, chan);
 	if (ret)
 		return ERR_PTR(ret);
 
-- 
2.50.1


