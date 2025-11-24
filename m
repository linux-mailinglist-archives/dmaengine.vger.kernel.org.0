Return-Path: <dmaengine+bounces-7318-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F90BC80656
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 13:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 399234E39CB
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 12:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0521301704;
	Mon, 24 Nov 2025 12:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ObM8xmXR"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C1E3009D9;
	Mon, 24 Nov 2025 12:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763986345; cv=none; b=VKD5dxbhe3oyRK8riJRPvJxrfYX9+4FsNl/KUfGvSq8cdpofLh3K115bsq4zAckUbnOFjQD0srXxiwI64YBFD++hIf1aUBSZWuYqn3c7W4IJTAaDdVj0aHBfMZRSbRXICLKdjMd/jEVdaC4OmkPQZVFl1XwVsXRDiiAkARoZYp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763986345; c=relaxed/simple;
	bh=G7V9+SrifDGfqxju25Hp/oyxgo/fWf9zfXipYvZQzAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNsDcKSaOiZcasJ+wgISDQTsoFx5mTeN7+nGp+MehYVoGc/9/swx39vpG6yAjZOYYvLWTfZecEb8WCFEjjwAnu4rnWmWzHuRUXwhdAEBCbTqPSFNUil1Pc+glFVxsKph2gWVW5b0+7fAF8ADraSvdJXAZg5+cbZZZhz30mqBVkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ObM8xmXR; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763986342; x=1795522342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G7V9+SrifDGfqxju25Hp/oyxgo/fWf9zfXipYvZQzAU=;
  b=ObM8xmXRYJZXoGByNHV+VHnw99j7kWwJBlFxNsR1ZKOFG414AzyhNhHj
   wRQHi3AFx11eUp5kVtytDbbXNSuFf/mJL+V40h6e11Xg04MumW3ahLciw
   T6B3Xjdn3tbV0q0jIsr+AN5YpjAg/8a8FUexJLT/A9yL+xUbIyTFnmIx7
   IPwwm2252mosP/2/qkBdFUBccylAJ+qsVOz3Ix/fkmXXkaBHhRgs/Jd8g
   S6/N5qsJY1lYXkw230luIYtUQrJXcVshsUo0YCOgafuamByRy9Sritau8
   7uJmS7Y4IR94/Oad6zREoAMd0YX8ffwiXOrCXsvNXju22APk0XKe+uLTf
   Q==;
X-CSE-ConnectionGUID: UUYBMMjzQ/20RZxOB0sIfg==
X-CSE-MsgGUID: Rp1o0W/SRNaj/ntoZhndPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="91467987"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="91467987"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 04:12:15 -0800
X-CSE-ConnectionGUID: lJ4Ysb5USrGqJ9huUsuiUg==
X-CSE-MsgGUID: 0wSONVK7THiwWxrHksVtVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="192559575"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 24 Nov 2025 04:12:10 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 78832AB; Mon, 24 Nov 2025 13:12:03 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
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
Subject: [PATCH v4 11/13] dmaengine: sa11x0: use sg_nents_for_dma() helper
Date: Mon, 24 Nov 2025 13:09:29 +0100
Message-ID: <20251124121202.424072-12-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251124121202.424072-1-andriy.shevchenko@linux.intel.com>
References: <20251124121202.424072-1-andriy.shevchenko@linux.intel.com>
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
 drivers/dma/sa11x0-dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sa11x0-dma.c b/drivers/dma/sa11x0-dma.c
index dc1a9a05252e..86f1d7461f56 100644
--- a/drivers/dma/sa11x0-dma.c
+++ b/drivers/dma/sa11x0-dma.c
@@ -526,7 +526,7 @@ static struct dma_async_tx_descriptor *sa11x0_dma_prep_slave_sg(
 	struct sa11x0_dma_chan *c = to_sa11x0_dma_chan(chan);
 	struct sa11x0_dma_desc *txd;
 	struct scatterlist *sgent;
-	unsigned i, j = sglen;
+	unsigned int i, j;
 	size_t size = 0;
 
 	/* SA11x0 channels can only operate in their native direction */
@@ -542,10 +542,7 @@ static struct dma_async_tx_descriptor *sa11x0_dma_prep_slave_sg(
 
 	for_each_sg(sg, sgent, sglen, i) {
 		dma_addr_t addr = sg_dma_address(sgent);
-		unsigned int len = sg_dma_len(sgent);
 
-		if (len > DMA_MAX_SIZE)
-			j += DIV_ROUND_UP(len, DMA_MAX_SIZE & ~DMA_ALIGN) - 1;
 		if (addr & DMA_ALIGN) {
 			dev_dbg(chan->device->dev, "vchan %p: bad buffer alignment: %pad\n",
 				&c->vc, &addr);
@@ -553,6 +550,7 @@ static struct dma_async_tx_descriptor *sa11x0_dma_prep_slave_sg(
 		}
 	}
 
+	j = sg_nents_for_dma(sg, sglen, DMA_MAX_SIZE & ~DMA_ALIGN);
 	txd = kzalloc(struct_size(txd, sg, j), GFP_ATOMIC);
 	if (!txd) {
 		dev_dbg(chan->device->dev, "vchan %p: kzalloc failed\n", &c->vc);
-- 
2.50.1


