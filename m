Return-Path: <dmaengine+bounces-7310-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF9AC8062F
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 13:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 69CA73435AF
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 12:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B763002CF;
	Mon, 24 Nov 2025 12:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ezzUEZRF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5052FFDE4;
	Mon, 24 Nov 2025 12:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763986339; cv=none; b=Lq+1/Si2BIa16iuU0hJlNDfl8ieXgw8vsUfs6KUh+fueK798E9NpxbtKqwaAHn+9FSt0Lm1hyDIdvMenC8V4CT0Lm0fZV8y75viWC/zF9YqFZFgAlI+6r1ApyKxgQYXVLImKiuG7PcqC+/MbIvsva+Tc2eXn6gmGAJ77Eg6rcnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763986339; c=relaxed/simple;
	bh=trxP5p0DPdBeRi5vhwLDZx5PvWwqNzPStkGF5be32MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7f22JnmmgppaAfszxScAHNmx3V8xNdqzJnk+HbhjVoaQwtWbSuyBvla7xjpyQy78h3zw4r3K553HaDe+4TU73FsEsei64Nxvg2AZTekiMrTKx+7nKIA/gQrvAVeiI6MTqSz6OCdYNaBlIJ6I7htJ6bG2ryuEErGnJ3mhrqOD/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ezzUEZRF; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763986336; x=1795522336;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=trxP5p0DPdBeRi5vhwLDZx5PvWwqNzPStkGF5be32MQ=;
  b=ezzUEZRFRHaaq9BHbLBBgpzraAvF9dt2GM0gCgmn4Ixsr7lvocWqstKM
   OV2d2g+f7imzExV9Jqzcu04YDvvjQHvWrYfEggfU9VFSc8QiaRFf1q3Zq
   nMVGavM8HKS19C34e0vZRR1gDgiODuQAn+ivL7NDWGzlgtnU6yCWxY/Ex
   w1ILXrq+5XxYpZh+PE37XYtCeTyq6YG3bI+3jGAGXjO0E5eIvjbN489Yz
   isEQktppA3kF61q1GCmhnehtJ3q0J+DNmrRomZdpQQ7+fqlVmI9v1EvmB
   UxpYJNbBWZ9VJlRQ3sQR+i4y042+9BAdaRkL/F0EC4lkWXVTNA2DI/Ohh
   A==;
X-CSE-ConnectionGUID: yXohF6B2TTexW3cksiZIgw==
X-CSE-MsgGUID: +3uMCVgoSWGXV5z/alzzCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="91467930"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="91467930"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 04:12:09 -0800
X-CSE-ConnectionGUID: 3opyCmUeRgyXZLeN0a8A3A==
X-CSE-MsgGUID: ZpvOF1xUTt2GcGUO71jbBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="192559539"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 24 Nov 2025 04:12:04 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 4E189A2; Mon, 24 Nov 2025 13:12:03 +0100 (CET)
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
Subject: [PATCH v4 02/13] dmaengine: altera-msgdma: use sg_nents_for_dma() helper
Date: Mon, 24 Nov 2025 13:09:20 +0100
Message-ID: <20251124121202.424072-3-andriy.shevchenko@linux.intel.com>
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
 drivers/dma/altera-msgdma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
index a203fdd84950..48d2a0e638bb 100644
--- a/drivers/dma/altera-msgdma.c
+++ b/drivers/dma/altera-msgdma.c
@@ -396,13 +396,12 @@ msgdma_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 	void *desc = NULL;
 	size_t len, avail;
 	dma_addr_t dma_dst, dma_src;
-	u32 desc_cnt = 0, i;
 	struct scatterlist *sg;
+	u32 desc_cnt;
 	u32 stride;
 	unsigned long irqflags;
 
-	for_each_sg(sgl, sg, sg_len, i)
-		desc_cnt += DIV_ROUND_UP(sg_dma_len(sg), MSGDMA_MAX_TRANS_LEN);
+	desc_cnt = sg_nents_for_dma(sgl, sg_len, MSGDMA_MAX_TRANS_LEN);
 
 	spin_lock_irqsave(&mdev->lock, irqflags);
 	if (desc_cnt > mdev->desc_free_cnt) {
-- 
2.50.1


