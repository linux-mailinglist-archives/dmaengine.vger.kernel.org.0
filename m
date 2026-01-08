Return-Path: <dmaengine+bounces-8125-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76738D02876
	for <lists+dmaengine@lfdr.de>; Thu, 08 Jan 2026 13:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6395231428F9
	for <lists+dmaengine@lfdr.de>; Thu,  8 Jan 2026 11:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5EF428FC4;
	Thu,  8 Jan 2026 10:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FrXmuxDf"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15803AE6F9;
	Thu,  8 Jan 2026 10:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767869824; cv=none; b=hnPDo+b4WgU2deFH7GtimWOB1MDuUVNiJt4l0SfCeMzoW1SnGVEInMgtTZ9XkvEBu1KphaO824GvmP0uHuQB3OZtZcUCpYUKeacSO2JjOJWWS3jehgVMASF/g2yKqjfrmPhzZVNlYv6d4IbaxQNB2prGxKMwEZ41Lfm17QteX7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767869824; c=relaxed/simple;
	bh=in8YVWOx7X3+N9u8C3YWLE2bz3o7s3AEf77KzqE5x8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMBcMmbkBoZSCQiGamUtkYH1qatN9nZNxLqKriu7Ow89tW6L9v2kdAtfS9QtBKnCcxnzpLaetxXUkl6qO8kgRWGFe1kS3c1E2ZG1T8Vo8vUClBUErvD8+k4X6z/jQrJFfxbMVt9J6VUNwi7T2MQFPDZevA8BAjdTG+NIGcupSCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FrXmuxDf; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767869819; x=1799405819;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=in8YVWOx7X3+N9u8C3YWLE2bz3o7s3AEf77KzqE5x8M=;
  b=FrXmuxDfvKRE/8LP7jVsjc3zJq1EHpA91lt3JboalEoCMr2ClbaGBRFw
   oxYwy1VR/wIC9LMpRccyl0p3SoFsy0SNRi6l/Jb/jBT6j4CHUznOCiS3W
   eBPH+fdqJ5ZcXHwPznbMCGKEKcgRKWniB5CX2utn4hcsbZYv8F6y87hI7
   LJzkAPa2jlgHgnow1B/CM5khi1tiCjC+HEGXk4Dvp3ii1snUILLXSCA43
   w7/04p04USCyMCOthhjjq/KEwEMXh7tZKHeEVczxwJ+dK2VsKf/YkeYfl
   OSlaOURwDksuSKRD+ycAiCeMsADI+eLzaBKXgl0E9/VffQ71w+i3Hy5rE
   Q==;
X-CSE-ConnectionGUID: vZZqva5HQd2+2IrVhlnO5g==
X-CSE-MsgGUID: p2PbW1vtRYiYp5s6/LSgvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="80354615"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="80354615"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 02:56:33 -0800
X-CSE-ConnectionGUID: fAZd+NvLR9yHxXM1xEdoug==
X-CSE-MsgGUID: KPnd7k64TXKfbXL285H4kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="203615548"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 08 Jan 2026 02:56:27 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 7632BA9; Thu, 08 Jan 2026 11:56:20 +0100 (CET)
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
Subject: [PATCH v5 12/13] dmaengine: sh: use sg_nents_for_dma() helper
Date: Thu,  8 Jan 2026 11:50:23 +0100
Message-ID: <20260108105619.3513561-13-andriy.shevchenko@linux.intel.com>
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
 drivers/dma/sh/shdma-base.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
index 1e4b4d6069c0..3ff2a8be8faa 100644
--- a/drivers/dma/sh/shdma-base.c
+++ b/drivers/dma/sh/shdma-base.c
@@ -577,12 +577,11 @@ static struct dma_async_tx_descriptor *shdma_prep_sg(struct shdma_chan *schan,
 	struct scatterlist *sg;
 	struct shdma_desc *first = NULL, *new = NULL /* compiler... */;
 	LIST_HEAD(tx_list);
-	int chunks = 0;
+	int chunks;
 	unsigned long irq_flags;
 	int i;
 
-	for_each_sg(sgl, sg, sg_len, i)
-		chunks += DIV_ROUND_UP(sg_dma_len(sg), schan->max_xfer_len);
+	chunks = sg_nents_for_dma(sgl, sg_len, schan->max_xfer_len);
 
 	/* Have to lock the whole loop to protect against concurrent release */
 	spin_lock_irqsave(&schan->chan_lock, irq_flags);
-- 
2.50.1


