Return-Path: <dmaengine+bounces-7312-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD16C8063E
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 13:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 32FE8343685
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 12:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C49301009;
	Mon, 24 Nov 2025 12:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nDgU5l2S"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C202FF660;
	Mon, 24 Nov 2025 12:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763986341; cv=none; b=fFnXv9CvlYPb3riTemun+A/uy3YZJ/rM2eE3c1kZfMcOCzPoIPYdb/RVGCdrhr4qMhSAvX8wjqxok1Efvatu+ADysLUhHpVowRNVjLG48hewQxuedRltb+PyxjrrK/yQv0/FohA6vfRiMNteo+cVYqWqxL/I5BWF0XBL6XGug4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763986341; c=relaxed/simple;
	bh=AVsEaLmI7GtsoKPxvWrWR94lD6aGbAJMgKiJV4Biyag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yn50AJZNNVl1HOM8AKi6pqx/uMG6pz0B+7hhDjkOBcRh5ndDGbijWC5yI0eEnzzAl413bqLcTpXJGOwjnX04kjyBqLb4TxWXnxUu5NrkT3Eih8ZqFiZn5lrRSHMSuzTCcpGR4RcDEJIdvccKAyt8rX9HHSbi7ShOQGxTO9RmuBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nDgU5l2S; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763986338; x=1795522338;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AVsEaLmI7GtsoKPxvWrWR94lD6aGbAJMgKiJV4Biyag=;
  b=nDgU5l2SPHX2F15B4BeVwXbf05GYKbZWr4pLLftejBtWiAgcLDUaWoi1
   WRnnaHffdckquhkaBAZwO7vbUUoZqO4U0bdEIudyyKPHblMRpoevpG4Rq
   xy4+Bd2rMYSBshPHi91kmU/YJ3Q9M9nUJGu0ZjLquxVZheYbAGFVFiMca
   G9QA9oFokch6MrzlcUlgiwUHmcU0aJmTOdas52xG8NGHukvVW8TBTTPE1
   D1ri41ipDrp2erWw8AgKbvxLPrT41J56kMX9l69q4139F4p+1ienP9f/O
   /yuYN3Ftkko8locMJVxwu1fKUWjPQEhkuboWydiCeqjhXdJr6d2/WdSyb
   w==;
X-CSE-ConnectionGUID: 66gGZhDJQe6R6tWQi15obw==
X-CSE-MsgGUID: kh4UF9GKTu6fcqw0mlh9kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="69847569"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="69847569"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 04:12:15 -0800
X-CSE-ConnectionGUID: spmCwM9MRQqA5SvF0Vzuuw==
X-CSE-MsgGUID: TZzaWKrJQOSEKD51KOqVAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="222970343"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 24 Nov 2025 04:12:10 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 5B4BCA5; Mon, 24 Nov 2025 13:12:03 +0100 (CET)
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
Subject: [PATCH v4 05/13] dmaengine: dw-axi-dmac: use sg_nents_for_dma() helper
Date: Mon, 24 Nov 2025 13:09:23 +0100
Message-ID: <20251124121202.424072-6-andriy.shevchenko@linux.intel.com>
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


