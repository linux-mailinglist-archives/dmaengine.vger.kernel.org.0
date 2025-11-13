Return-Path: <dmaengine+bounces-7160-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D9AC5870D
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 16:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 814384FB5AB
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 15:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD86F3563CE;
	Thu, 13 Nov 2025 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hmj4mhTv"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F32355811;
	Thu, 13 Nov 2025 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046980; cv=none; b=CWiLZ+HeNSB/4Aojyy5+7hfCd61olSwn7scutWkmJFNXiwAp8H8US0YOIiG+mIMUfjewyD49lZg7sZjCvAzplH4NrtoqL9BUeQL0NE2jFHFNFPYw3T0W/Wjsp0+a2jyoNnGI/vampqxqdI4TbjAJhGfVupb/Leo8btywzud1KMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046980; c=relaxed/simple;
	bh=akryAXafWhZQlfplABSdwgarfhhYIf26xngrUAauxhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRjzFt+W6bvDSl/LM/d35q4EEWyD6YEVG4k00ET8URG3hLjAIDBC+FkIBh4pMS7vgS33xDdLNoSCXRdaRwZTpLsFLAzRd12TLGlADqCICfOTBcoXLZZ618jbpOmAJj5+nz4pQtXzdGi1fSUB6WBI4YhWBYAbkdW1ao/Jqv8utWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hmj4mhTv; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763046979; x=1794582979;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=akryAXafWhZQlfplABSdwgarfhhYIf26xngrUAauxhA=;
  b=hmj4mhTvYsrfrtLt3pmQKyfAkSOpOW26kmLGH8kPSsPsUWAgax3smO7X
   4AOi/R1bHR8AM+6nHOzd3VWwxUJstZ1Z+zwDkFEW6GBN9T2EGEvazRb3a
   2R1hQvRsBMlry+6l6U5tEeKBo+3V8r7Z0dGAE0DC+hTMouAU/xU/33+3U
   8YySKn5EyyU0Ui3EHPmFA0Q6+wgwNIe1FJWZSm+vkPvItPvu+0U8/s1hE
   v6S4PMHI+9hAtpBmSdIe2F32XQiHt+FBrnAhcvmMvnjp26bq8i+ByZTop
   fQz5ZKdA3zXtuZ7MFLO0G6F+M/xtt0tPmxGMAjcTFxE6nALoQtnbAVyu+
   A==;
X-CSE-ConnectionGUID: ffu8SZUaRbCr1jddN5m8mw==
X-CSE-MsgGUID: LNE/x5jFR1y6tv5YQnOU0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="75740543"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="75740543"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 07:16:17 -0800
X-CSE-ConnectionGUID: ciipLS86TrWoIsMCLMxgLw==
X-CSE-MsgGUID: snFg2F5dRgKe8HTqX1Oxmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="189792123"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 13 Nov 2025 07:16:12 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id DE6D5A0; Thu, 13 Nov 2025 16:16:04 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Vinod Koul <vkoul@kernel.org>,
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
Subject: [PATCH v3 10/13] dmaengine: qcom: bam_dma: use sg_nents_for_dma() helper
Date: Thu, 13 Nov 2025 16:13:06 +0100
Message-ID: <20251113151603.3031717-11-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251113151603.3031717-1-andriy.shevchenko@linux.intel.com>
References: <20251113151603.3031717-1-andriy.shevchenko@linux.intel.com>
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
index 2cf060174795..62b3921f0d11 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -655,22 +655,17 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
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


