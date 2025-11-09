Return-Path: <dmaengine+bounces-7099-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A8DC4491E
	for <lists+dmaengine@lfdr.de>; Sun, 09 Nov 2025 23:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16F5F4E5434
	for <lists+dmaengine@lfdr.de>; Sun,  9 Nov 2025 22:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85C126ED36;
	Sun,  9 Nov 2025 22:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZFmypnIu"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9592623D28B;
	Sun,  9 Nov 2025 22:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762727389; cv=none; b=EWsLk5RjbaZ6Qp2LJccuKP664zXKUfkdJ4qlPWay4BNwULN91vggJl3k46oDLnmPoPRrAGH3qBPof+ir/ICG89vLQ3IKTjuxpqk4KJqAqIjJkG+XtYnVq8NiNnB27Jffezx0Dfd5dzh1kESOuZ6lulyDTHHATCwcXWp+jdntocE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762727389; c=relaxed/simple;
	bh=IXLDjEiHrZHZgamlzXvJvh+xW4fyoOOqH+x8TWFjbfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSEQndr+14uexFJoqsHMm3h0wrD7JKfXQPZ4dip5HFdGPQ+kST76h826rD3qUx+3mVtwjPAnaLkBBUawWx77lQLIYVTJyN5/K3ovHfjy9uX5iUK1XTc5LF5tgzqh1cLR2jogqp6ZLSnb82R3kOCIRQHE/cJy28+ovlU6pdpipMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZFmypnIu; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762727388; x=1794263388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IXLDjEiHrZHZgamlzXvJvh+xW4fyoOOqH+x8TWFjbfI=;
  b=ZFmypnIuhfrgAzUQQONXHApq4vqdHD0aXJdvE1ENpf7JaVqGVAoFgtwz
   DehI3VSk5kExZ07BcH7GfO6Ymcvn65Cvi4e5IFHHVwjpAY2odjPlXFWQF
   j5RilS/vquO0gy5ayZjYV/ao9ywTLMc2j9giW/H7BQqgg1HSHHFXkJssY
   IZ2fh1OBbqInjYoXHh+tIDs9NWwxUBsh7cFoFsFHI64P+TydLy+EzGhp0
   BqffMJ9vx8+0huYG8kUh6MP2kVwC2iBrKDp//fnHEBAnOSDtZ26ifqEQj
   NMYEAM/a3mLQ/qzc90luizVuSHu6D/nVzuhbfwjMeMlWZp5PU1MNqrvWH
   g==;
X-CSE-ConnectionGUID: 5ZizDvxJSGuWZpbwKz8t8Q==
X-CSE-MsgGUID: 0YGxduXvTT64nwZd9+yG0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="68427317"
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="68427317"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 14:29:47 -0800
X-CSE-ConnectionGUID: nV0xQrU5QY+h3kAf8tC4BA==
X-CSE-MsgGUID: K0/PXmXfSjmVxczAIzrfVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="188165800"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 09 Nov 2025 14:29:46 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 4788D97; Sun, 09 Nov 2025 23:29:45 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v1 2/4] dmaengine: Refactor devm_dma_request_chan() for readability
Date: Sun,  9 Nov 2025 23:28:35 +0100
Message-ID: <20251109222944.3222436-3-andriy.shevchenko@linux.intel.com>
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
index cd1c0744bfc0..620c5bcff3bf 100644
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
+	        return chan;
 
+	ret = devm_add_action_or_reset(dev, dmaenginem_release_channel, chan);
 	if (ret)
 		return ERR_PTR(ret);
 
-- 
2.50.1


