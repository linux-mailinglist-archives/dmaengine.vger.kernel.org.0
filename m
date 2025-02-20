Return-Path: <dmaengine+bounces-4543-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B78A3D53C
	for <lists+dmaengine@lfdr.de>; Thu, 20 Feb 2025 10:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2C47189F5AD
	for <lists+dmaengine@lfdr.de>; Thu, 20 Feb 2025 09:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97201F0E59;
	Thu, 20 Feb 2025 09:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TZvLsyra"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F6A1F0E38;
	Thu, 20 Feb 2025 09:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044667; cv=none; b=HdFxuTYp7qbx3W2APZ8TmJGa80AKLlshtFCTxVEIRdw+s81yrMKwNKOIcJxs5eZ5jzOwdAXzjFjm57uNnAlfGYUocLwBaUeobORlqkPaIiswfhfFJvhUeDK/sMa0ExtAQBXKgG5tD5Z8SNEeazI3wAV0UtFQKtruGom/Ze6+/bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044667; c=relaxed/simple;
	bh=c2wuFwNlBSJDce9EXlu8wsXo2D0l1HDxk8QZtLt+F54=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d4YaLBugL2LQEXBh9k85D6mOJPOQJUDscgih7PCDJlopd4TTUVIESRQ5rWjLwXF83ePj4WvKnSwygmBCxvjOZ0YGFX43nh75d7vPHcX0CpXbrQvVB/iLzHUzv0E+PP2ZO+QXt1mnfZle6wewhg86fBPlaSZ7sCD16UfUbHAhs4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TZvLsyra; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740044666; x=1771580666;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c2wuFwNlBSJDce9EXlu8wsXo2D0l1HDxk8QZtLt+F54=;
  b=TZvLsyra0gbbFyD7aV1t7dZPuAhQ314Mm7RFWnLApNoKeIYnqqSpMrdC
   AfjUAdLzlKAr5IG/oZIVEyaL+NSAU2o0w32LoCvxDs5k6WOZ/yNX0jKND
   YAldv39OkFooMGs66ddztnwz5Y+eZTKX1oIMXIyDnyjhUO57gi2FnRbvh
   5H2bd69CsrZc5qh/1eJ9aFQUs6oOfkFcbAZ601jgZvhnsh8UY2C6muzda
   mhnenzBwOLP4UvJn0ymy/902/zsL8v/xPpqYqS19jyj4tjMUXWqtbgkUh
   4HXU19ZCDWthDgX2aj3YcLs6f0XD09a9j4YOpTRu71k9nMNfk/QzDsBDW
   Q==;
X-CSE-ConnectionGUID: GghYShNPQG6JhpPr3iX4PQ==
X-CSE-MsgGUID: Vq1j+g2WRVG1WbcPB0vC8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40935687"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="40935687"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 01:44:26 -0800
X-CSE-ConnectionGUID: SSFjhIjKQ66YA1tyIM6LmQ==
X-CSE-MsgGUID: n/0fFVSiRvOQZse0eRfozw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="152183805"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by orviesa001.jf.intel.com with ESMTP; 20 Feb 2025 01:44:24 -0800
From: niravkumar.l.rabara@intel.com
To: Vinod Koul <vkoul@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
	nirav.rabara@altera.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jisheng Zhang <jszhang@kernel.org>
Subject: [PATCH v4] dma: dw-axi-dmac: remove unnecessary axi_dma_enable() calling
Date: Thu, 20 Feb 2025 17:40:47 +0800
Message-Id: <20250220094047.3799548-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

DMA is always enabled before calling axi_chan_block_xfer_start(),
so it does not need to be enabled again here.

Re-enabling DMA causes random failures in the dmatest test when running
multiple iterations.
e.g.
[   29.600722] dmatest: dma0chan2-copy0: summary 100 tests, 1 failures 160.26 iops 1299 KB/s (0)

Fixes: 1fe20f1b8454 ("dmaengine: Introduce DW AXI DMAC driver")
Tested-by :Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---

Changes in v4:
  * Add fixes tag
  * Rebase to v6.14-rc1 

link to v3:
 - https://lore.kernel.org/all/20230521101216.4084-4-jszhang@kernel.org/

 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index b23536645ff7..43d30c7b8f03 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -435,8 +435,6 @@ static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
 		return;
 	}
 
-	axi_dma_enable(chan->chip);
-
 	config.dst_multblk_type = DWAXIDMAC_MBLK_TYPE_LL;
 	config.src_multblk_type = DWAXIDMAC_MBLK_TYPE_LL;
 	config.tt_fc = DWAXIDMAC_TT_FC_MEM_TO_MEM_DMAC;
-- 
2.25.1


