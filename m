Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934A2214C3B
	for <lists+dmaengine@lfdr.de>; Sun,  5 Jul 2020 13:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgGEL4Z (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 5 Jul 2020 07:56:25 -0400
Received: from mga14.intel.com ([192.55.52.115]:57570 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgGEL4Y (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 5 Jul 2020 07:56:24 -0400
IronPort-SDR: 3PS5WPU84g3JO775UZgcvqomYzGXZ7C+rULJ7Uq8h8c3Vl1Zs3DE2Lju40s2RLd9euHSgQWIbf
 awtaf5iPmxtg==
X-IronPort-AV: E=McAfee;i="6000,8403,9672"; a="146390843"
X-IronPort-AV: E=Sophos;i="5.75,314,1589266800"; 
   d="scan'208";a="146390843"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2020 04:56:23 -0700
IronPort-SDR: OrudrtlZ52+F3ldPEh4BsprSq/UACtcmCa5awxb68LmjRK+MVHoBLFzNF+vrom6Etky6IfS02F
 H89kDCM2mgzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,314,1589266800"; 
   d="scan'208";a="313695947"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 05 Jul 2020 04:56:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DACCA21D; Sun,  5 Jul 2020 14:56:20 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Viresh Kumar <vireshk@kernel.org>, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tsuchiya Yuto <kitakar@gmail.com>
Subject: [PATCH v1] dmaengine: dw: Initialize channel before each transfer
Date:   Sun,  5 Jul 2020 14:56:20 +0300
Message-Id: <20200705115620.51929-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In some cases DMA can be used only with a consumer which does runtime power
management and on the platforms, that have DMA auto power gating logic
(see comments in the drivers/acpi/acpi_lpss.c), may result in DMA losing
its context. Simple mitigation of this issue is to initialize channel
each time the consumer initiates a transfer.

Fixes: cfdf5b6cc598 ("dw_dmac: add support for Lynxpoint DMA controllers")
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206403
Reported-by: Tsuchiya Yuto <kitakar@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dw/core.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 21cb2a58dbd2..a1b56f52db2f 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -118,16 +118,11 @@ static void dwc_initialize(struct dw_dma_chan *dwc)
 {
 	struct dw_dma *dw = to_dw_dma(dwc->chan.device);
 
-	if (test_bit(DW_DMA_IS_INITIALIZED, &dwc->flags))
-		return;
-
 	dw->initialize_chan(dwc);
 
 	/* Enable interrupts */
 	channel_set_bit(dw, MASK.XFER, dwc->mask);
 	channel_set_bit(dw, MASK.ERROR, dwc->mask);
-
-	set_bit(DW_DMA_IS_INITIALIZED, &dwc->flags);
 }
 
 /*----------------------------------------------------------------------*/
@@ -954,8 +949,6 @@ static void dwc_issue_pending(struct dma_chan *chan)
 
 void do_dw_dma_off(struct dw_dma *dw)
 {
-	unsigned int i;
-
 	dma_writel(dw, CFG, 0);
 
 	channel_clear_bit(dw, MASK.XFER, dw->all_chan_mask);
@@ -966,9 +959,6 @@ void do_dw_dma_off(struct dw_dma *dw)
 
 	while (dma_readl(dw, CFG) & DW_CFG_DMA_EN)
 		cpu_relax();
-
-	for (i = 0; i < dw->dma.chancnt; i++)
-		clear_bit(DW_DMA_IS_INITIALIZED, &dw->chan[i].flags);
 }
 
 void do_dw_dma_on(struct dw_dma *dw)
@@ -1032,8 +1022,6 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 	/* Clear custom channel configuration */
 	memset(&dwc->dws, 0, sizeof(struct dw_dma_slave));
 
-	clear_bit(DW_DMA_IS_INITIALIZED, &dwc->flags);
-
 	/* Disable interrupts */
 	channel_clear_bit(dw, MASK.XFER, dwc->mask);
 	channel_clear_bit(dw, MASK.BLOCK, dwc->mask);
-- 
2.27.0

