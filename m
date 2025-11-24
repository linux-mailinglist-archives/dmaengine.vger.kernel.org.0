Return-Path: <dmaengine+bounces-7317-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D38C806C8
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 13:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E263A8E03
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 12:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933DA3016F3;
	Mon, 24 Nov 2025 12:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GzfNSGJ2"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CF23009DE;
	Mon, 24 Nov 2025 12:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763986345; cv=none; b=D8eZ5V6ryAOqwxqeKhjVSDGNNjh/W5GsRqsPAFza0yfE+IjwrlOPIGhVFs5EWPtGKuRMd8UxhSKR/UtPao6nHk42DIlb26JiG5ofWD0YDfptBEYOVD1k26LBzG3k83AYDXfkOVDxrYOnTSzLZRDd6LrPzdgmfwgzRwy450GFYLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763986345; c=relaxed/simple;
	bh=akryAXafWhZQlfplABSdwgarfhhYIf26xngrUAauxhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9PUHlm132C7+J6pRwMRnkMB/CKqn1cVOeT9qP8p2Ou9VGzSRzB69ijktVzgblUi3TJmyhROkvZ3sQ19mnN1nNRMZTqRbrJKrdZbp8J9Onv+YyozRlNwBUuVUvJycSluERv6aLh2xDiGRCGq3f4FkVjdCl5auLcbXgis1m2aqAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GzfNSGJ2; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763986342; x=1795522342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=akryAXafWhZQlfplABSdwgarfhhYIf26xngrUAauxhA=;
  b=GzfNSGJ2E1pQxiu4EP2P8LI+5Oz0o34CO2vRKu3w0MCGr11VmxTR/hkS
   a4u1Sj0DKtAL5A9cKZQeJiacR847MRvAIAHHLRs3NJyvmrJw2xgDDNHnw
   CtbtMvupJ4W6FQfi96nkbiM+DaL5fLwQL5N6auPtbP4+bAijoQW1jEuOL
   vOaVAMbTzzP5IhgOhmGxMqx/QZfeVcfAfYyAEa+f1sZgOl7KFSoD8AXPj
   HjWhmqFiSPPb/qGphMpb9CJWESxVGCYgNuWNV75YfhEoZ4GYGwX68ta/Y
   JDXjg+UYXteV4zMlhxYkGzs0VJ41UMJDzIHxbPdJPosfH0Q3Cog7qJG1f
   Q==;
X-CSE-ConnectionGUID: TinSauuCTAyfyRgDOysJHg==
X-CSE-MsgGUID: 3/8d3062St+tRrBVtjGGwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="69847617"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="69847617"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 04:12:16 -0800
X-CSE-ConnectionGUID: DwbDk/0CSIK5hVBMlgSbzQ==
X-CSE-MsgGUID: 60dj4sW0Rx6N2jQllImwvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="222970346"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 24 Nov 2025 04:12:10 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 73EFAAA; Mon, 24 Nov 2025 13:12:03 +0100 (CET)
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
Subject: [PATCH v4 10/13] dmaengine: qcom: bam_dma: use sg_nents_for_dma() helper
Date: Mon, 24 Nov 2025 13:09:28 +0100
Message-ID: <20251124121202.424072-11-andriy.shevchenko@linux.intel.com>
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


