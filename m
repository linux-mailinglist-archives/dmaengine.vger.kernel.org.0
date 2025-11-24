Return-Path: <dmaengine+bounces-7313-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 536C0C8064D
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 13:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 695853439D5
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 12:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DAA301466;
	Mon, 24 Nov 2025 12:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VCrZL4kk"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25A42FF663;
	Mon, 24 Nov 2025 12:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763986342; cv=none; b=q4EuDv8+VMHOtI77mUm5B2TBRNyS4Dv7zBGCxurbyOpzcgx38LM0SMi2R0KpDLGmNmglh3I8yzngvUGHBdqNZW7Ruv3jEru9B2M4EboA6EG+OvpGm5pgQDsT1TgUbceWW3FtW/YulKMnIBAlXGh7BcjaRrYb5S/oz0rvVpdKsS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763986342; c=relaxed/simple;
	bh=yN+ecYcYKcZKT4gWNmRCDsdhTOBiye6jHzywdjrd5sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9JAdMGd5Sv89Haqb/Eq+oxUGt/GN1jA5aFygS2MlhsHSx2VQn/6+fqzzsb4+/qVzHogzbIwGJqV/sCOtnPS9v9GTC7tH/XNifgAjAq0oK/uCzSItLY0pv8G9+U7YsVy5cKnSTjr+eT6B8/TXr7rvKWdzDxPtfbBEVvvq6obS3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VCrZL4kk; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763986339; x=1795522339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yN+ecYcYKcZKT4gWNmRCDsdhTOBiye6jHzywdjrd5sk=;
  b=VCrZL4kkP/55orkgEchC+T9PDYTOIoiptM37kOSs41Fswlqy9I6WC3If
   d3lqgnyQ5WQ5jtwJLCqz4kTgIcGcEDtEGtnkdoORrquIwWGW/+/RE1OHs
   0SNI/1Uzb+1L86fWmR5iObKWyJn/NuHPmNIlnL93q2SZPpTa6WwjcOxPl
   1xQle2T8kjMj9Va9PhcWEv2iM38fzAJzqD7JMQKpt7YdSufJ1KcJhdGUY
   gpJ21IgGStljGtPZi/CIjBDnaBOtG8gHd7JMjauoYzOaEtjhU7LwKc6YE
   sT7MgEYnrLC8iNPi4cl916lseckgNVUwgGKKmm/n2LJRq2ThxSRUwbtxl
   Q==;
X-CSE-ConnectionGUID: lEracMilTJC7itXDr1WuGQ==
X-CSE-MsgGUID: K3PJ6//LSu+K/qeK0ifuOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="91467960"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="91467960"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 04:12:15 -0800
X-CSE-ConnectionGUID: J8Apy+NdRdG8m6rJd8K6Ig==
X-CSE-MsgGUID: jcpL5DqWTwKaU8kaKNBkiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="192559570"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 24 Nov 2025 04:12:10 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6077AA6; Mon, 24 Nov 2025 13:12:03 +0100 (CET)
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
Subject: [PATCH v4 06/13] dmaengine: k3dma: use sg_nents_for_dma() helper
Date: Mon, 24 Nov 2025 13:09:24 +0100
Message-ID: <20251124121202.424072-7-andriy.shevchenko@linux.intel.com>
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
 drivers/dma/k3dma.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index acc2983e28e0..88f9a2952edc 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -536,19 +536,14 @@ static struct dma_async_tx_descriptor *k3_dma_prep_slave_sg(
 	size_t len, avail, total = 0;
 	struct scatterlist *sg;
 	dma_addr_t addr, src = 0, dst = 0;
-	int num = sglen, i;
+	int num, i;
 
 	if (sgl == NULL)
 		return NULL;
 
 	c->cyclic = 0;
 
-	for_each_sg(sgl, sg, sglen, i) {
-		avail = sg_dma_len(sg);
-		if (avail > DMA_MAX_SIZE)
-			num += DIV_ROUND_UP(avail, DMA_MAX_SIZE) - 1;
-	}
-
+	num = sg_nents_for_dma(sgl, sglen, DMA_MAX_SIZE);
 	ds = k3_dma_alloc_desc_resource(num, chan);
 	if (!ds)
 		return NULL;
-- 
2.50.1


