Return-Path: <dmaengine+bounces-8124-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E25A2D024F4
	for <lists+dmaengine@lfdr.de>; Thu, 08 Jan 2026 12:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBCB8301E5AB
	for <lists+dmaengine@lfdr.de>; Thu,  8 Jan 2026 10:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A730E42846E;
	Thu,  8 Jan 2026 10:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lvck8GBd"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14764A5B1C;
	Thu,  8 Jan 2026 10:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767869824; cv=none; b=GtGlyGs+hF6t45NzdE0H4/XQJNyvf0GqQczwav4b+f0LyGkiInntUTO/EOU+hXWR2nW0D2i5bc8iXiqpHR+tUhphnBao12OiRdXdkNGRTImAwdhw0J54EAqNykyFQHZYrqnRi+5/WFUhdXxsbJ4+AbR2ns5ebbNS2y0Mf6HKz6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767869824; c=relaxed/simple;
	bh=aIZKpp2i1U4bYPp+lJpBExBX9TU2DJpWjDWAz41Iejk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRBv1j4D1PBymlQazKhuBMSdf5omYT4naK9lUANODYDscwxaI6R35J2NSxexfpYC5EaONa/yDcWJQlJCT93c1UhTaG8MGZL5Y888phf5F5rtQD0Q48qUd8zbj09zqvN86eXY+9+cQE/1Vo3lA1+2RG6VliS0GOKrz36TAi2TIK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lvck8GBd; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767869818; x=1799405818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aIZKpp2i1U4bYPp+lJpBExBX9TU2DJpWjDWAz41Iejk=;
  b=Lvck8GBd5gIZhMQX0Ol8Y10wSDFcKne2+dr/8A7DJ9s0s7oOatdWZLzU
   vJD8GNR2lUV9KHT9X6T4neg3P1ChDMXRNp+Q1Kg3ilG1YkUEIqBwTx7+v
   7YeTBzr6mRk4lZrcMl+2vqLDNWLTQxXHvx4eN5r7Q0lgxJGJ8+w1Hc7uO
   EhZeuo0jSGTuLVmKSjmvNUpmMCmdMpXNupqg5mTyYprOVbxonMo2OWtFQ
   V+cWVyFVr1KIi3NyPn0HsSgY6B2DXXm/2y/7oLwhKGuxkexcwa0ZLYhEM
   pKQO9+nZudKebaMY1Ao9vd6wPY93UC2ClhJ0qmsvcueZSoUHs/SPAhYBa
   Q==;
X-CSE-ConnectionGUID: s6Dw8uTlTjWKaamB3H0zhQ==
X-CSE-MsgGUID: WT3JtB89Q6K800NBDRbv9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="80354604"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="80354604"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 02:56:33 -0800
X-CSE-ConnectionGUID: Gb3DjqCbSMKUzD25zpkYEg==
X-CSE-MsgGUID: fJjhLUL8TIea3RGk5XNoVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="203615547"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 08 Jan 2026 02:56:27 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6314CA5; Thu, 08 Jan 2026 11:56:20 +0100 (CET)
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
Subject: [PATCH v5 08/13] dmaengine: pxa-dma: use sg_nents_for_dma() helper
Date: Thu,  8 Jan 2026 11:50:19 +0100
Message-ID: <20260108105619.3513561-9-andriy.shevchenko@linux.intel.com>
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
 drivers/dma/pxa_dma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index 249296389771..b639c8b51e87 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -970,7 +970,7 @@ pxad_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 	struct scatterlist *sg;
 	dma_addr_t dma;
 	u32 dcmd, dsadr = 0, dtadr = 0;
-	unsigned int nb_desc = 0, i, j = 0;
+	unsigned int nb_desc, i, j = 0;
 
 	if ((sgl == NULL) || (sg_len == 0))
 		return NULL;
@@ -979,8 +979,7 @@ pxad_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 	dev_dbg(&chan->vc.chan.dev->device,
 		"%s(): dir=%d flags=%lx\n", __func__, dir, flags);
 
-	for_each_sg(sgl, sg, sg_len, i)
-		nb_desc += DIV_ROUND_UP(sg_dma_len(sg), PDMA_MAX_DESC_BYTES);
+	nb_desc = sg_nents_for_dma(sgl, sg_len, PDMA_MAX_DESC_BYTES);
 	sw_desc = pxad_alloc_desc(chan, nb_desc + 1);
 	if (!sw_desc)
 		return NULL;
-- 
2.50.1


