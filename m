Return-Path: <dmaengine+bounces-8121-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC45D0240E
	for <lists+dmaengine@lfdr.de>; Thu, 08 Jan 2026 12:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE0ED3018C8B
	for <lists+dmaengine@lfdr.de>; Thu,  8 Jan 2026 10:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED4C41B377;
	Thu,  8 Jan 2026 10:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gsp76dzu"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2174A5B0D;
	Thu,  8 Jan 2026 10:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767869818; cv=none; b=qAIZ2vNMEQdyHQXKHGhsalLhmUtFJ3rnC0GXPwEUOOVImEDr+/I9qGIjO0pDCXPSjCSfIBX7NYmShsFOSQgO6KWxSKsIthNWs1k0JqaYjAHKo9V9RBQ2jbFlc2exLHlYTFFVOj7ftmXm99yFjVODJOs5z0LeOHfEfpDYAT/0278=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767869818; c=relaxed/simple;
	bh=AVsEaLmI7GtsoKPxvWrWR94lD6aGbAJMgKiJV4Biyag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tt7+MXuDVCTnFg8WyymiZyBX5dj3Xg/XKpNa5gAVvVyr7kvmkmslpWDP1Dyt07KdZolTnpcQi0V5uahhThswvEWjPi0qkR8XwMv51Rd8aznJDVnnyFGqHiq46qQHUAWlOG/tkOfjqd+tQGlpPM280meW8FzMzbsebVW255ql5xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gsp76dzu; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767869809; x=1799405809;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AVsEaLmI7GtsoKPxvWrWR94lD6aGbAJMgKiJV4Biyag=;
  b=gsp76dzulR7eptnXqNZUUTACnYTIWHi+J+SXou1SWkk9Y8HF0dVtp+Fy
   QEsEYdqCGay5CBmgdryxx4QPIPQyjk5m0w0rarhmyMcsKhnqqMWp5byiY
   GUKTDzyaNHROOTgvau4JLdE2jvTARvbXijezUGwa60DVLxIvIVEedphE/
   P88Ldu3dqE8d8agrs36EavSJUE70U+WQujspnz5wySE2W+lFj8PKDfSeJ
   58f/3Z/fbV/9AsaNP/oOcG+pi5Vqkp8bV80oIn8oL376gLIxIjkwdH05n
   pTJJeVL0ClI28nEnsCpC7SR4uKZaS6LWt5OtbHIXPRDFoCilRk43Fry6x
   g==;
X-CSE-ConnectionGUID: p5pPXnppQEqsQscg8ecj+w==
X-CSE-MsgGUID: ue5+gqwHT462+3e61yXIrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="79886184"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="79886184"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 02:56:33 -0800
X-CSE-ConnectionGUID: 601UvqCKTx6wLpXwlbDKHQ==
X-CSE-MsgGUID: 9ZAmcWIfTjWGSX4K+MEYhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="203091233"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 08 Jan 2026 02:56:27 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 54E70A1; Thu, 08 Jan 2026 11:56:20 +0100 (CET)
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
Subject: [PATCH v5 05/13] dmaengine: dw-axi-dmac: use sg_nents_for_dma() helper
Date: Thu,  8 Jan 2026 11:50:16 +0100
Message-ID: <20260108105619.3513561-6-andriy.shevchenko@linux.intel.com>
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
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index b23536645ff7..493c2a32b0fe 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -850,7 +850,7 @@ dw_axi_dma_chan_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 	unsigned int loop = 0;
 	struct scatterlist *sg;
 	size_t axi_block_len;
-	u32 len, num_sgs = 0;
+	u32 len, num_sgs;
 	unsigned int i;
 	dma_addr_t mem;
 	int status;
@@ -867,9 +867,7 @@ dw_axi_dma_chan_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 	if (axi_block_len == 0)
 		return NULL;
 
-	for_each_sg(sgl, sg, sg_len, i)
-		num_sgs += DIV_ROUND_UP(sg_dma_len(sg), axi_block_len);
-
+	num_sgs = sg_nents_for_dma(sgl, sg_len, axi_block_len);
 	desc = axi_desc_alloc(num_sgs);
 	if (unlikely(!desc))
 		goto err_desc_get;
-- 
2.50.1


