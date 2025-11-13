Return-Path: <dmaengine+bounces-7167-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E973C586DD
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 16:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CF643BFFBD
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 15:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86E73590B0;
	Thu, 13 Nov 2025 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QcStGCO7"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CDB357725;
	Thu, 13 Nov 2025 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046984; cv=none; b=dyPg0xu5/9CvmUqoS7TCi5kVNNPXix77OXzT9G44eroawLYkY5JFXFG+xSDFywNdnljzpdyw7fUlUYnps+agCR0C1P7QnI3t5LAYoW70sWcEc06k2lfGI/iMkjeafY02G1LCxhx9NlI0/5A4BSnaovUeo5e2x3eSQysRccwc2f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046984; c=relaxed/simple;
	bh=cDKmRefM+evq3je2XEyX6jEIHeqcRBXhtx3BtPimOeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFTrAPr7BVy32ZTUvtflcBasbilCSG3eFbvpdLpqUPNyJIPhqxhZ0tBTDahZxK2mzqaov2hGLN6UWx1tXSbo+f6NpticECEprSEqiyfJxXH36rSX47ClRyH+DjEKy0zQnTw0NttGRbcNEk6ZVH5kLJFDbdJKAz2y0MEurUMfK2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QcStGCO7; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763046982; x=1794582982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cDKmRefM+evq3je2XEyX6jEIHeqcRBXhtx3BtPimOeg=;
  b=QcStGCO7iLh073A8dSj2gWFKRuEjABtP3YnN3i2hRP3lhFiQX3FwLmr5
   KKYjJt+2ZJ3XQsii0ehGOvqQgEEzScec639Ai/50L43+jzJ2IeY4EHTie
   MiRQtjj552y6MGzDh/BD90gSGhP9BOWZvvsQZqApu+VAanzn/l6eozVG/
   xTUvefzqn0E3gJD5gdkqWQWYZ7SuU/f0mPnsQkPwUUkDtO4oTF6h8Ykh9
   hXdYGWDbm7o8Eg6Fwn/IuLTf+79oe1a4RH6vnHR/pybPL9myGxfdZB0HF
   wu4NZFvnAAu+anImqCBwy86Uw2Wy5tRwHjkjwHXqhmG1hkfWdfAVvwCxK
   w==;
X-CSE-ConnectionGUID: uPws8MPsRo6+fNSucEU8eg==
X-CSE-MsgGUID: RSjxFqJzQLuc7jkfkagPQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="75809694"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="75809694"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 07:16:17 -0800
X-CSE-ConnectionGUID: dN/3GVTBSias59zhoV0RsQ==
X-CSE-MsgGUID: qIWJEscpSZeQJvpy44sGxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="194684670"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 13 Nov 2025 07:16:11 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id CF7FA9D; Thu, 13 Nov 2025 16:16:04 +0100 (CET)
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
Subject: [PATCH v3 07/13] dmaengine: lgm: use sg_nents_for_dma() helper
Date: Thu, 13 Nov 2025 16:13:03 +0100
Message-ID: <20251113151603.3031717-8-andriy.shevchenko@linux.intel.com>
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
 drivers/dma/lgm/lgm-dma.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/lgm/lgm-dma.c b/drivers/dma/lgm/lgm-dma.c
index 8173c3f1075a..7d4d3dde6d88 100644
--- a/drivers/dma/lgm/lgm-dma.c
+++ b/drivers/dma/lgm/lgm-dma.c
@@ -1164,8 +1164,8 @@ ldma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	struct dw2_desc *hw_ds;
 	struct dw2_desc_sw *ds;
 	struct scatterlist *sg;
-	int num = sglen, i;
 	dma_addr_t addr;
+	int num, i;
 
 	if (!sgl)
 		return NULL;
@@ -1173,12 +1173,7 @@ ldma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	if (d->ver > DMA_VER22)
 		return ldma_chan_desc_cfg(chan, sgl->dma_address, sglen);
 
-	for_each_sg(sgl, sg, sglen, i) {
-		avail = sg_dma_len(sg);
-		if (avail > DMA_MAX_SIZE)
-			num += DIV_ROUND_UP(avail, DMA_MAX_SIZE) - 1;
-	}
-
+	num = sg_nents_for_dma(sgl, sg_len, DMA_MAX_SIZE);
 	ds = dma_alloc_desc_resource(num, c);
 	if (!ds)
 		return NULL;
-- 
2.50.1


