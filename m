Return-Path: <dmaengine+bounces-7166-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A53AC586FE
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 16:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4293D4A5710
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 15:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6794E358D30;
	Thu, 13 Nov 2025 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RSuGoT/6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8033D357A3B;
	Thu, 13 Nov 2025 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046984; cv=none; b=aCDVKQA7WyfWk9fYqqUMnEMTgSrtmUGt3CqxxjyWPqPqMHEpQ/V2dedd0YvnzpV7N/W6q60ajF7ZDBE0WfFIojfQM3A8Dx4+fh6eREOJcoUqNCPbXqYFkvXbjPI83edcIRoyUqOQAnUwwdmc4dplwJ84tB1CtNZrXJ/rIWduPXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046984; c=relaxed/simple;
	bh=WtcwbhDFfrQdZOzgChF1SRUOy+m0/hJ81tJ/Ve8zpzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EuMQjH7sUvL6YOh82BN2cjEZI7EkOeuEnINhDjwMx4gwZt9jkevwDvLiGVjF/tVZeJO+D6kw5q5obsYGd3ZBCfkzDcB2/2dsoYcsH3R39+zmvRr/LSptNYZoM4s6EqA6xeGxGKdIHG5uQdTOyA39Xx2/49gpYlhBMu4TG3An8+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RSuGoT/6; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763046982; x=1794582982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WtcwbhDFfrQdZOzgChF1SRUOy+m0/hJ81tJ/Ve8zpzc=;
  b=RSuGoT/69MSyVMrerEFy1y3ocyItIzi3BDf7TuYMC5Jwfa0FQcpcazAm
   hAXY7N2Lz1t9O2A2cT+nWH0QKlB3+U+/6exAFdfJHK5t+CXhuwWacJewI
   kgLhfM9EMYOTU7oqcZFiRNhHUY6cax3XVEWEHjnYEBHQ3k+5LYbKzvM/U
   CG/iV+VAOaUdRFt3SzN/mCASWMWROSedCQs/yV73V5B69XZqOijsXRFZf
   BK5rV2hohPW61eNv9JO+RxOVHLM3/uK2AcL5hoZN7EBcki0QYPhjTTjqA
   xClXJbfpnRTzbnUKZWNF9hLUcCw5ElTA9vTiYg5CuwzVN6aS+e1Cg1sIi
   Q==;
X-CSE-ConnectionGUID: KEPWKJnSRaKj2d4EynkYRQ==
X-CSE-MsgGUID: Denhb1GoRYCYWtiP+DBDZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="75809719"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="75809719"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 07:16:18 -0800
X-CSE-ConnectionGUID: HLpBtDzUSvGWaDkTYlJYkw==
X-CSE-MsgGUID: 13s146MAS46konZFIvPn3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="194684673"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 13 Nov 2025 07:16:12 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id E2822A1; Thu, 13 Nov 2025 16:16:04 +0100 (CET)
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
Subject: [PATCH v3 11/13] dmaengine: sa11x0: use sg_nents_for_dma() helper
Date: Thu, 13 Nov 2025 16:13:07 +0100
Message-ID: <20251113151603.3031717-12-andriy.shevchenko@linux.intel.com>
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
 drivers/dma/sa11x0-dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sa11x0-dma.c b/drivers/dma/sa11x0-dma.c
index dc1a9a05252e..3dd33d3f7987 100644
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
 
+	j = sg_nents_for_dma(sgl, sg_len, DMA_MAX_SIZE & ~DMA_ALIGN);
 	txd = kzalloc(struct_size(txd, sg, j), GFP_ATOMIC);
 	if (!txd) {
 		dev_dbg(chan->device->dev, "vchan %p: kzalloc failed\n", &c->vc);
-- 
2.50.1


