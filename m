Return-Path: <dmaengine+bounces-8127-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CDDD02A59
	for <lists+dmaengine@lfdr.de>; Thu, 08 Jan 2026 13:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F55F33D422C
	for <lists+dmaengine@lfdr.de>; Thu,  8 Jan 2026 12:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D391F45106A;
	Thu,  8 Jan 2026 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fV4N72wL"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864534A5AF8;
	Thu,  8 Jan 2026 10:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767869840; cv=none; b=R0NQrb7nofdoUrZQ3YBtu7+vypLZnx04GiYqPkFCu7/GZiv7VWRBEr6DVSEi803KTy6G/ujQ48NTKc8WcZd2kGzF8zz6vrEdc++0mrBpaGo7oMd1GVAtGm8riTduxeM8IxtuigD8IepAul+CRjRHdnrN9RYyWUgVEMAnVbA3akk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767869840; c=relaxed/simple;
	bh=rUyODX56g/0PVw4q9uoPm3QtJgx5W1kE7M9udwy7iHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jti0bKcWLu1hBeBXE5z1SLHUOhtyKCLcjVUyMiUg/Xy+1wYghla3KXbQsm0QqXM3/AuNd0xZ4icRpQivbm252GLNPUCAgUgKfBmOGvXm+r3+zTcLvyc4sXnuOQ/WY/1t8fo79+zqHYjGwN02lEqTbeOQv3OKiO46xrO/CivUlxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fV4N72wL; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767869831; x=1799405831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rUyODX56g/0PVw4q9uoPm3QtJgx5W1kE7M9udwy7iHM=;
  b=fV4N72wLCpa4D9of6ZDKykXz9vADaZuVJpiL+csyWzLEHpWa3JAD/x3C
   3AZ2bHZgHaPVHJPjBnex07ic2FUx6HpaxHmKtDb/4FUZQUhRC1NEY35Qs
   3Am+fsyZJ2KjN+/s5R0DThY9MRIXQh3K3VVA4yjmzI93wTrvfxOfKXcOV
   YhWrPB/aV3BYw2W3cEtOFYC0zI4KfdzqdmAVtu7sb2v+PjeRBX4HMJhkW
   v+n28Z8s7A/RAqOAmocW8+oWaFoZCllRsxhuwgZY1yq91QAFPW2YlaJ2r
   UGLhxJ87+Fii3A5JR/T/FuQbuzJbC0QWSq2opjKnBLqXbhDZsDiINNG6Q
   Q==;
X-CSE-ConnectionGUID: kk/uC6YfS2avWiN0UKxCuQ==
X-CSE-MsgGUID: DnP1UzHjTfS5DvH3jPpBrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="80354637"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="80354637"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 02:56:34 -0800
X-CSE-ConnectionGUID: DgHj2duHTWOGuskfnGCuGg==
X-CSE-MsgGUID: AmxWRW/wSYO52jnqsY6CWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="203615550"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 08 Jan 2026 02:56:27 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 7AE09AA; Thu, 08 Jan 2026 11:56:20 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Vinod Koul <vkoul@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
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
Subject: [PATCH v5 13/13] dmaengine: xilinx: xdma: use sg_nents_for_dma() helper
Date: Thu,  8 Jan 2026 11:50:24 +0100
Message-ID: <20260108105619.3513561-14-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260108105619.3513561-1-andriy.shevchenko@linux.intel.com>
References: <20260108105619.3513561-1-andriy.shevchenko@linux.intel.com>
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


