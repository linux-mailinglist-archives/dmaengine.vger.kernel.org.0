Return-Path: <dmaengine+bounces-7314-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 546DCC80644
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 13:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0862A4E3994
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 12:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F0A30149C;
	Mon, 24 Nov 2025 12:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TCkiUMio"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539E62FFF80;
	Mon, 24 Nov 2025 12:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763986343; cv=none; b=lZVj2DOJp8R83ZhOKuLn03rPg4ZyEKuax8NKyiqeWp5mmQxfTrKCAP8ZNDn8RcGULaclgYgVSzfEBQ/hCpjH/IAft8hRJ2KCHJqhln0nDGirEiAW/YQpxvH7dSBpuyg/hXgl2lzWyhhQJRMwhE8jGYTsFa13waqyuu3JYFtDI3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763986343; c=relaxed/simple;
	bh=Z4cy+2HbiLCLWtcSsLcUwBV59DreBfM5HrektthG6GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNNj9SmJ6NgHJTbseFSd2rEbepaqU/3xQK9CzGLb0Pjjfyd4ruC8cJgKrIT86HQvrpnEnVNVoIY66T1wddkr7N0lbN/C1GxITyVxWVDeacAMjTwxYQa1MtDzx8vtSQHe1yKBvSrONW4ZHEp1Z/HlLwTNB1DmiCHqhf0/Ol31o4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TCkiUMio; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763986339; x=1795522339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z4cy+2HbiLCLWtcSsLcUwBV59DreBfM5HrektthG6GQ=;
  b=TCkiUMiowQuCOQ3zBlrCxPwT4dEAA8TFmVLTpdDxMuNM8qg9CPotyMUf
   Y47G5B4T+L6kepVAwtesr87Wn1+DCMojVjn6jeWKFFBYcpC3d2dv8TgOI
   Jr5L1717wLVAlJ0IpdTrLa795UAm+Izy+LHxxRnbpl9RpWEV+qx6SWNo/
   FJ53Z2r4fhoqbQ1AIzHcTf6km1oXvBz3JUFG1shmpfC79K4/RkBulEMbH
   9+D+jkMJSTKjkGQAZYoGVjSutRyKHl5hp/XVtGztPbBqqFI69t0vgenR4
   TAKuRWngNlhNVop766q+gXWwscXVU6JghgPBDWuesBBw+9X97hBJWW/W/
   Q==;
X-CSE-ConnectionGUID: F+2DNrXjR+a7DTykIgwWfw==
X-CSE-MsgGUID: hHzEaE7lRAqiK33kNvPiNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="69847587"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="69847587"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 04:12:15 -0800
X-CSE-ConnectionGUID: u8eTMZfQRgaZ40Qo2k195g==
X-CSE-MsgGUID: 39ttMucESuq1ncwuVM0izw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="222970344"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 24 Nov 2025 04:12:10 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6560CA7; Mon, 24 Nov 2025 13:12:03 +0100 (CET)
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
Subject: [PATCH v4 07/13] dmaengine: lgm: use sg_nents_for_dma() helper
Date: Mon, 24 Nov 2025 13:09:25 +0100
Message-ID: <20251124121202.424072-8-andriy.shevchenko@linux.intel.com>
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
 drivers/dma/lgm/lgm-dma.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/lgm/lgm-dma.c b/drivers/dma/lgm/lgm-dma.c
index 8173c3f1075a..a7b9cf30f6ad 100644
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
+	num = sg_nents_for_dma(sgl, sglen, DMA_MAX_SIZE);
 	ds = dma_alloc_desc_resource(num, c);
 	if (!ds)
 		return NULL;
-- 
2.50.1


