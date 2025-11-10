Return-Path: <dmaengine+bounces-7121-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9CFC46027
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 11:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A8D3B52DC
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 10:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C6C30F92A;
	Mon, 10 Nov 2025 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PRuOqkeJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5566130CD8E;
	Mon, 10 Nov 2025 10:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771103; cv=none; b=OgtKSCdAUfa8CO6zf2nnMYuHWKB1nY/56IUcy9cGJcd6FyQL7SZZG/9ye+7Hq7SFT6NQKyUb2LfDloYCY77i/LPZ4HGzvGiyTSX1RNtQITL+2naMj7mBSrUp9noPjjbatttKdzh7lrkcDD2L85Dz4oC181ZVT8oMkzCxW3bZ36o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771103; c=relaxed/simple;
	bh=OwNTWbPKJ24ffgAUyc6H9GN1ggjkmnfUcXfxAtMuqrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSpCI5pl6bJrp/5eTwdgGpH4YPS4IISDO+fXCxTptmtOlf/F5MySCUKXfryByibLtaZ92XMYiKyPKKnqb8NqtxSGNAwlbY8EcI0eE0WKwwJJes2oP1YECwHXqvLnJggGzPcZz9B0104JYFOjSUVjDCYl5qswq6YfU1TnNMX7x+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PRuOqkeJ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762771101; x=1794307101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OwNTWbPKJ24ffgAUyc6H9GN1ggjkmnfUcXfxAtMuqrQ=;
  b=PRuOqkeJCnzu7qoC947kuqUW9owXbACxD4Lj/+CnQiWJu+kYncRt4sX3
   ZXI9zGXjdj67go9rDE39LPyXsuhFtkKUg/LlvCXzWHYHQe3z/x0aTmFtd
   tRvqWNvVLK1N4aTXWlYGo/pLx2M/IE+MFrmgMuUQWv3UsidrtIt274Siz
   O6JZWFLHFNu9rgoudrovoheKvDRph+no8ojTw6wiRBknZYkm+WGanP9Yh
   Fq3gJF9wuKqBPOmyM5nHulfrvS8mQJ3RQDO4Z4jU28ai31OXBPesun6KF
   sBSZXludLt7QiUnq7p7y1r69Ryp5eSi0qsVmNmseVZntwd16br/pCLf30
   A==;
X-CSE-ConnectionGUID: IJDHwz1MSS29obbuagUhXg==
X-CSE-MsgGUID: 3K35ZdWhTTKtA7WyHQJ8og==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="52376884"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="52376884"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 02:38:19 -0800
X-CSE-ConnectionGUID: 6E3zoBtVSpW1NjrvUZ8dwA==
X-CSE-MsgGUID: zGNu059tSv69g9qQPFKq0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="188891267"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 10 Nov 2025 02:38:14 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id A5264A2; Mon, 10 Nov 2025 11:38:07 +0100 (CET)
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
Subject: [PATCH v2 13/13] dmaengine: xilinx: xdma: use sg_nents_for_dma() helper
Date: Mon, 10 Nov 2025 11:23:40 +0100
Message-ID: <20251110103805.3562136-14-andriy.shevchenko@linux.intel.com>
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
 drivers/dma/xilinx/xdma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 5ecf8223c112..118199a04902 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -605,13 +605,11 @@ xdma_prep_device_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	struct xdma_chan *xdma_chan = to_xdma_chan(chan);
 	struct dma_async_tx_descriptor *tx_desc;
 	struct xdma_desc *sw_desc;
-	u32 desc_num = 0, i;
 	u64 addr, dev_addr, *src, *dst;
+	u32 desc_num, i;
 	struct scatterlist *sg;
 
-	for_each_sg(sgl, sg, sg_len, i)
-		desc_num += DIV_ROUND_UP(sg_dma_len(sg), XDMA_DESC_BLEN_MAX);
-
+	desc_num = sg_nents_for_dma(sgl, sg_len, XDMA_DESC_BLEN_MAX);
 	sw_desc = xdma_alloc_desc(xdma_chan, desc_num, false);
 	if (!sw_desc)
 		return NULL;
-- 
2.50.1


