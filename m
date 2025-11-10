Return-Path: <dmaengine+bounces-7113-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE63C45FF0
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 11:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 580393B6228
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 10:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C455A30C361;
	Mon, 10 Nov 2025 10:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J3desNKI"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBFF30BBB0;
	Mon, 10 Nov 2025 10:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771100; cv=none; b=l8gNflbRcUJZKIX6AyDk8knN2nQpXeSky+qSqOYoc3hFwLE+nwUGNTVOQCpgth3K8FKyoe8t+BgkaaBe1pPe+M4fr+V+yrwzC2BypCwQ+Pqmc14ZBs41PmChyd5UAcKm+vOGBqtk4H4bq6wzezklJpLCkCdGBOH8puDKruWcayA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771100; c=relaxed/simple;
	bh=90DBnN1DGQYnGUgwfmS95iw+ByD4MmosW5yY9D3pBv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hu+0P5DYYtZdlx8M//PaV+cdUnfvj9MYmdQpJV1VVily0vGoHkNUgNwhb25AcJHaJO973FPGCI5dOTb6X/vQasjmcEOAixRF3lAGNl7SneZAG4/HbL6O9Ga5epIpWtpq5LgNZo7kkSY5f8gCSwAxxsmwxSaBboDUTeGd2OcXubA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J3desNKI; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762771099; x=1794307099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=90DBnN1DGQYnGUgwfmS95iw+ByD4MmosW5yY9D3pBv0=;
  b=J3desNKI9TNJ5VtcMB5/LTfQBAvlTpUJb2ppzQpepdfZlaWnUrcNRRRm
   JJ6PL9pYmi9zwixaoiFA9yGnZ5vZohYJVQURbTlTo4ymnWExeUT1A8F15
   cJLdrQoip+5BfFzseNWDMZX22HVGxfPcPcyAePaONl3shINCmltZvwBvq
   nABiF50feJtUxOQUSZZreeyAtCJQL44sBOCyZ5zezb9DOFEvfpKVRkA0a
   cG/S0ygDlqD/VBFy5V9k2dKWU7aVQOp94HRUsSeVFNIrZBEf30kKCjL9X
   /uN7JEgm9Ti13GkZT2ncJ3UtuN3vE60IrmtdQQIBaoKOpjXHbmPdYoN+a
   A==;
X-CSE-ConnectionGUID: 4yYmdELzRS6bvY/MLoIAfw==
X-CSE-MsgGUID: GS64F8pJTgunHl3mKUUMHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="52376882"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="52376882"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 02:38:19 -0800
X-CSE-ConnectionGUID: QkmrFVSsSRGnEf/YxIPPiA==
X-CSE-MsgGUID: np91THmSSw2v20kIwbQ+dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="188891261"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 10 Nov 2025 02:38:13 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 8CC869D; Mon, 10 Nov 2025 11:38:07 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Subject: [PATCH v2 08/13] dmaengine: pxa-dma: use sg_nents_for_dma() helper
Date: Mon, 10 Nov 2025 11:23:35 +0100
Message-ID: <20251110103805.3562136-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251110103805.3562136-1-andriy.shevchenko@linux.intel.com>
References: <20251110103805.3562136-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of open coded variant let's use recently introduced helper.

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


