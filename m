Return-Path: <dmaengine+bounces-8115-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 92114D02A80
	for <lists+dmaengine@lfdr.de>; Thu, 08 Jan 2026 13:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AF2E329A330
	for <lists+dmaengine@lfdr.de>; Thu,  8 Jan 2026 12:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919BC329E5F;
	Thu,  8 Jan 2026 10:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4zdEfry"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FED4A5AF0;
	Thu,  8 Jan 2026 10:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767869805; cv=none; b=n1LIFYoh6/YzowlDQwBtQV8QoKcNZgaBlmoFhd03iJ9T9n7HXd9WZBHvUVHXoxdppczKEc035dnQEv/Xo+/bUyKx4jhlfCNkjn6d/lGmo+oS+soQWNct470b53aW59BytI+UQH3u8SQFlaIAJUa9RC4RQgWYohKbo6RvC39GGBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767869805; c=relaxed/simple;
	bh=iHVq+79pb8Yq4SdLxvoeSS6py1B5FyegYsoIgEHQMaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=crWT+cepuFC9MFvuyTjVDeUMO/P6p+Bs3rLtymChlgQuIlPtcPuWYqNZ7hK/mYbR37SjBQZW8YGUn2FUAfvNU7SuAiRdmXiSEp8k6gS/aSlxopcnQstFz5rkshm/F573CxmAY6BptsQ1gPt8cdssi0LqxGTXa5dyQQFBVDtYNkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H4zdEfry; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767869799; x=1799405799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iHVq+79pb8Yq4SdLxvoeSS6py1B5FyegYsoIgEHQMaA=;
  b=H4zdEfrycsJBBoNlB93VIX8UqNKZjgQnUYnb/GQTX41FLSCiM8MiPydI
   YrwwjfgEj3IrClBe5xtKgxlot5699MO/M2WC+N6b70llpQi1BRqGHJYqp
   tDSmlGTMKuh+JKwZS1QGr/FIoc3kU+NbpnUqhtWsn73Li2tInLbm081Kp
   z7l5XypF5FsINAcrIQRELC2rVFu4S6mgEv/b9+t2x+TF4m1fjpL5SNVw7
   6+XnIOBy6FiVi8S2yZ0XuAdrUddXZsQojX0oV3+7zoCQPTFdu/7UqmD4P
   qkd5jKih4YltvDkdu6HHowkKBve5RNqvhvxnTpOFTgok5MeLcwteELF9L
   w==;
X-CSE-ConnectionGUID: hoXDcAF7TH63uAXQk9JFlw==
X-CSE-MsgGUID: 7+DHSaFDS829wnC+SKNc9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="79886167"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="79886167"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 02:56:33 -0800
X-CSE-ConnectionGUID: qwS2kr8bSuOOdOFkEdNwNg==
X-CSE-MsgGUID: hHkm5BXrQlOpnfQ0U7iDZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="203091232"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 08 Jan 2026 02:56:27 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 5977FA2; Thu, 08 Jan 2026 11:56:20 +0100 (CET)
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
Subject: [PATCH v5 06/13] dmaengine: k3dma: use sg_nents_for_dma() helper
Date: Thu,  8 Jan 2026 11:50:17 +0100
Message-ID: <20260108105619.3513561-7-andriy.shevchenko@linux.intel.com>
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
 drivers/dma/k3dma.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index 0f9cd7815f88..63677c0b6f18 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -536,19 +536,14 @@ static struct dma_async_tx_descriptor *k3_dma_prep_slave_sg(
 	size_t len, avail, total = 0;
 	struct scatterlist *sg;
 	dma_addr_t addr, src = 0, dst = 0;
-	int num = sglen, i;
+	int num, i;
 
 	if (sgl == NULL)
 		return NULL;
 
 	c->cyclic = 0;
 
-	for_each_sg(sgl, sg, sglen, i) {
-		avail = sg_dma_len(sg);
-		if (avail > DMA_MAX_SIZE)
-			num += DIV_ROUND_UP(avail, DMA_MAX_SIZE) - 1;
-	}
-
+	num = sg_nents_for_dma(sgl, sglen, DMA_MAX_SIZE);
 	ds = k3_dma_alloc_desc_resource(num, chan);
 	if (!ds)
 		return NULL;
-- 
2.50.1


