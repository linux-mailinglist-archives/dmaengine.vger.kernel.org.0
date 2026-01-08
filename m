Return-Path: <dmaengine+bounces-8114-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C91F4D02CE4
	for <lists+dmaengine@lfdr.de>; Thu, 08 Jan 2026 14:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A649A356079F
	for <lists+dmaengine@lfdr.de>; Thu,  8 Jan 2026 12:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F583570B3;
	Thu,  8 Jan 2026 10:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TG+tR8Ov"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376844A5B04;
	Thu,  8 Jan 2026 10:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767869802; cv=none; b=VvJrKsaOrPhQVXbWws+69nEDjd56DOJU24NDLRmnLr4LggO4jwBg9+ND5pSBrsBuXCJ/hJ59SKeAHHpvd3tCQuBbkgemH/FresMHY4eUyt7qGR+UKRU7/5UhUab3bqwMzIVzebPkTi8N/6R0gG68CKaFFfTDZP3bdD4Z+Zij/9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767869802; c=relaxed/simple;
	bh=QsLTBFLRSsqzKbhE6ZxuHj1l34g02g1XFbZdK2cy1fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHjcpFh8sMEj5UTO+2itRnUkR+Fb4CM7SAqpZzcdmoyk5t0/KUPgoCY4+G+/Wq9FA1ZUZr8cTxHrr+QzPxK48WMIVVMAa4pVtV9IDiKXaovqctUBcdrC7KJnZk9jpp//wR3iTuSUYabX/YkN7g83MxCJh69ciSDysbFQgUfm9W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TG+tR8Ov; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767869796; x=1799405796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QsLTBFLRSsqzKbhE6ZxuHj1l34g02g1XFbZdK2cy1fs=;
  b=TG+tR8OveQx5FY7gyZOkRUyTTd0La/q32n0nZDJ9usXLghxqG0uUcVFk
   OKj6g+Mke5HJqHcK7+S2DwhpKGRzEfjaPfg5Um9HUgdpKy2r2M+SDELdF
   tjpKqjtmY2OIveHpDwJCXtBZptx6OgJc1IpH2gc//fQAtff3lEvXKJ7Yr
   HBUIZevwNuQ0lxK9f+HCO7R2YeSJ+wc8YlXdCKof4NLUqEts/oLi+MV1F
   TcWHMgYiaNR+PneFDa4fW43yADpdH5PjNAObf4Xu7L99aH3hNXgo8NDrU
   SxmIHyatzHh3gVUbjvTuI6Mfsh2Io3Lnyl6MmcYyJCnRMEmhspwYPhPWO
   A==;
X-CSE-ConnectionGUID: KBgAy7jaQmGf8F6lNX5LXQ==
X-CSE-MsgGUID: gdrltfU9TPeoRJislMx2gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="80354531"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="80354531"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 02:56:27 -0800
X-CSE-ConnectionGUID: iy3iIMreQ6a/mDhF/dca9g==
X-CSE-MsgGUID: wlX6BSnmRU22UNKliXDG6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="203615535"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 08 Jan 2026 02:56:21 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 4FFB19E; Thu, 08 Jan 2026 11:56:20 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Vinod Koul <vkoul@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Thomas Andreatta <thomasandreatta2000@gmail.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org
Cc: Olivier Dautricourt <olivierdautricourt@gmail.com>,
	Stefan Roese <sr@denx.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 04/13] dmaengine: bcm2835-dma: use sg_nents_for_dma() helper
Date: Thu,  8 Jan 2026 11:50:15 +0100
Message-ID: <20260108105619.3513561-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260108105619.3513561-1-andriy.shevchenko@linux.intel.com>
References: <20260108105619.3513561-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of open coded variant let's use recently introduced helper.

Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/bcm2835-dma.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 321748e2983e..3f638c3e81cd 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -260,23 +260,6 @@ static void bcm2835_dma_create_cb_set_length(
 	control_block->info |= finalextrainfo;
 }
 
-static inline size_t bcm2835_dma_count_frames_for_sg(
-	struct bcm2835_chan *c,
-	struct scatterlist *sgl,
-	unsigned int sg_len)
-{
-	size_t frames = 0;
-	struct scatterlist *sgent;
-	unsigned int i;
-	size_t plength = bcm2835_dma_max_frame_length(c);
-
-	for_each_sg(sgl, sgent, sg_len, i)
-		frames += bcm2835_dma_frames_for_length(
-			sg_dma_len(sgent), plength);
-
-	return frames;
-}
-
 /**
  * bcm2835_dma_create_cb_chain - create a control block and fills data in
  *
@@ -672,7 +655,7 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_slave_sg(
 	}
 
 	/* count frames in sg list */
-	frames = bcm2835_dma_count_frames_for_sg(c, sgl, sg_len);
+	frames = sg_nents_for_dma(sgl, sg_len, bcm2835_dma_max_frame_length(c));
 
 	/* allocate the CB chain */
 	d = bcm2835_dma_create_cb_chain(chan, direction, false,
-- 
2.50.1


