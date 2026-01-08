Return-Path: <dmaengine+bounces-8117-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 935BCD023D2
	for <lists+dmaengine@lfdr.de>; Thu, 08 Jan 2026 11:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF98B30087A2
	for <lists+dmaengine@lfdr.de>; Thu,  8 Jan 2026 10:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0E94A5AE4;
	Thu,  8 Jan 2026 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SNNBIyqd"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9812935970C;
	Thu,  8 Jan 2026 10:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767869808; cv=none; b=BAxxiTTL/JmYpLRCjDlmkLS0g2zt7r64CtEyTTWdDtFHkUdgZLfcWUOa8+Rmr239QNTvWBpEzSwTp/H2PHLReX3p+wrtuVll3Y7ZncuoZxClJTlR84WEBouNpUp2BNuxQbd5EMs1LnAY1ESfJxsbY/imn5N4qsT9/Oro5zAYerw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767869808; c=relaxed/simple;
	bh=bSFr2N381lHNrtuhF3irBWmneWRqxVrWJKWgEFfnSeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3gy9GPy+MDSxz+8g4PdZdoDB617kB/66lCXTEXzIcIP/X4iBlCeBXqVZNzTNeZ6ZtZ4GrZjnFuteqbEiON7YEc8D6ceFViGBnUeGTLR+H2I0H8zoNqhvWh5rH5RkSl1Dfj7tlGWf3MpFk9jLXFshWx17AUKQUqzIE5QSVEQngM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SNNBIyqd; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767869799; x=1799405799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bSFr2N381lHNrtuhF3irBWmneWRqxVrWJKWgEFfnSeo=;
  b=SNNBIyqdeH6eR4TF/5fyAjhBk1PLtlVXDVW231+9HA2Z8YHHJwWQX5+G
   i0bSRLHijDPP7W8GuwZoH+A2zm5zTfcFy+gkENjTNClE883YPjrjNiXlE
   W9G0DOugfaphqsOoqv9s+udcp2yS9WveLjNFZTpioHlcI/WIBiUb7Q1nf
   AUUAM+283LA/Hi/6MhfSc45idmD5APSL4qwEMGmoKh65iutSYVnWIX19a
   8hGFXukrYprfe90ym7VpChG2F51d4J1T+AJnDFcMHsjzWtWJP0bOuhb6O
   BE0yFLwLFt8oBAEv6kqq+bdyDJGKQizHcuL3WqtxBRO4mbm7+2qVG14DD
   g==;
X-CSE-ConnectionGUID: hNkHQKqwS42++rXlGpMZEQ==
X-CSE-MsgGUID: GObycHXcTPWykhmB6ND0mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="79886151"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="79886151"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 02:56:33 -0800
X-CSE-ConnectionGUID: siYkkejISBWUJZwYaBuoTg==
X-CSE-MsgGUID: 9QnnkmWhSxS3N43gRqAtAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="203091235"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 08 Jan 2026 02:56:27 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6CA77A7; Thu, 08 Jan 2026 11:56:20 +0100 (CET)
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
Subject: [PATCH v5 10/13] dmaengine: qcom: bam_dma: use sg_nents_for_dma() helper
Date: Thu,  8 Jan 2026 11:50:21 +0100
Message-ID: <20260108105619.3513561-11-andriy.shevchenko@linux.intel.com>
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
 drivers/dma/qcom/bam_dma.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index bcd8de9a9a12..e184cebbface 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -653,22 +653,17 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
 	struct scatterlist *sg;
 	u32 i;
 	struct bam_desc_hw *desc;
-	unsigned int num_alloc = 0;
-
+	unsigned int num_alloc;
 
 	if (!is_slave_direction(direction)) {
 		dev_err(bdev->dev, "invalid dma direction\n");
 		return NULL;
 	}
 
-	/* calculate number of required entries */
-	for_each_sg(sgl, sg, sg_len, i)
-		num_alloc += DIV_ROUND_UP(sg_dma_len(sg), BAM_FIFO_SIZE);
-
 	/* allocate enough room to accommodate the number of entries */
+	num_alloc = sg_nents_for_dma(sgl, sg_len, BAM_FIFO_SIZE);
 	async_desc = kzalloc(struct_size(async_desc, desc, num_alloc),
 			     GFP_NOWAIT);
-
 	if (!async_desc)
 		return NULL;
 
-- 
2.50.1


