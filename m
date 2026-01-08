Return-Path: <dmaengine+bounces-8118-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C33FDD023D8
	for <lists+dmaengine@lfdr.de>; Thu, 08 Jan 2026 11:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AAB2E3007646
	for <lists+dmaengine@lfdr.de>; Thu,  8 Jan 2026 10:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB923E9F6C;
	Thu,  8 Jan 2026 10:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M9mWuv6O"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05342E36F8;
	Thu,  8 Jan 2026 10:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767869814; cv=none; b=CQBOh1hUFjEoy3CKp4sOufKev7vbWwo/0Pd1rKo9PBz+aVmr4d3Mz5BS40uUm+KcFPJxU7UYMX77gQAI8sPRTkOTxhyX4EwBL1IbdkT1wEFIMWN2YbuIoCGcwFrbdLS1jyTJJ6DYFs2qcJF8p7Bi3ZnRnmaF9GAGGTs305YZF+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767869814; c=relaxed/simple;
	bh=rdhxhHeXthv3D6UydRaYxlwt/uP4N7mUvFy9MHLi4Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LaaPS7EvN1bDDbvbsjiUZAvfVcK4W8fwQ8sqOLbPeRLMWwl+PUS1T0Nv8RcGJpkKQgIXZc9nDRNCdtCJLumLferZV1plS5W7BY9tskgrsaImThbeyX2TmPJo0fwXCc5elXVOcNkYuSOeXRO/oVVywkbZqQxNmvze+rX2yB3zusU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M9mWuv6O; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767869807; x=1799405807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rdhxhHeXthv3D6UydRaYxlwt/uP4N7mUvFy9MHLi4Co=;
  b=M9mWuv6Ov0YyGRjoCsjoIfTCVflofyOr5JkWHMMyeCYodynFc4ZsLI3R
   V129NZYHaJPz9QRHsoujEzjfuM2g48Bov1BeBuyASRvUV5JJUMvXNcn1t
   TwqoFoKtS8xOfaS18qa+AdDGstwCXiEsxiz7I6fsF9f/pFJMpNY9FxRY4
   T+0n/+1lw0XUa2NsVKsFLCS3i5DlUisbqqaOiV9AAmUzlWiPopRcz3V6n
   eTjUPa9DSdT6PSclq6Mlu8DimGdfyI56ToNBjqIANWHb0OcHe15nNZFoS
   qCFbVaC90wtsDwPrbk8a8djr2JiVw1Y7LH+7TVXzqmzOzF3Fgv1PPZ9eR
   A==;
X-CSE-ConnectionGUID: VBkXCNHFQKKy+QY10jSLow==
X-CSE-MsgGUID: ZV8HaeURQrWLynX1jhaeog==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="80354561"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="80354561"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 02:56:28 -0800
X-CSE-ConnectionGUID: QhV2ONw8RvuC/tQXu0jlDA==
X-CSE-MsgGUID: 4vsa0VpNTJGGMmrjFSW5TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="203615537"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 08 Jan 2026 02:56:21 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 4B3ED9D; Thu, 08 Jan 2026 11:56:20 +0100 (CET)
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
Subject: [PATCH v5 03/13] dmaengine: axi-dmac: use sg_nents_for_dma() helper
Date: Thu,  8 Jan 2026 11:50:14 +0100
Message-ID: <20260108105619.3513561-4-andriy.shevchenko@linux.intel.com>
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
 drivers/dma/dma-axi-dmac.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 045e9b9a90df..f5caf75dc0e7 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -677,10 +677,7 @@ static struct dma_async_tx_descriptor *axi_dmac_prep_slave_sg(
 	if (direction != chan->direction)
 		return NULL;
 
-	num_sgs = 0;
-	for_each_sg(sgl, sg, sg_len, i)
-		num_sgs += DIV_ROUND_UP(sg_dma_len(sg), chan->max_length);
-
+	num_sgs = sg_nents_for_dma(sgl, sg_len, chan->max_length);
 	desc = axi_dmac_alloc_desc(chan, num_sgs);
 	if (!desc)
 		return NULL;
-- 
2.50.1


