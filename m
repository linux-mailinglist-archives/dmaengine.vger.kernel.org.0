Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E51A30E327
	for <lists+dmaengine@lfdr.de>; Wed,  3 Feb 2021 20:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbhBCTVD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Feb 2021 14:21:03 -0500
Received: from mga03.intel.com ([134.134.136.65]:40198 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231622AbhBCTVD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 3 Feb 2021 14:21:03 -0500
IronPort-SDR: 0Jda1J2EVk3qQcF7cwmYOXhcLAn5MbXpAdYPjme6MLptyMgh+Qt5GuJyWw3KbfKYd8gXDqSPcc
 YYFnhHabc/6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="181176650"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="181176650"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 11:20:12 -0800
IronPort-SDR: HdqJQI8Or5c7cL7CDQnRtDb/LNQsbLA1zj2KlFya/h8u9XnKoLmqKJ4amZFX3iecnT6VAp+QuN
 udCjEZ96qP8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="406756505"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmsmga004.fm.intel.com with ESMTP; 03 Feb 2021 11:20:10 -0800
From:   Cezary Rojewski <cezary.rojewski@intel.com>
To:     dmaengine@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        andriy.shevchenko@linux.intel.com, vireshk@kernel.org,
        vkoul@kernel.org, Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v2] Revert "dmaengine: dw: Enable runtime PM"
Date:   Wed,  3 Feb 2021 20:19:24 +0100
Message-Id: <20210203191924.15706-1-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This reverts commit 842067940a3e3fc008a60fee388e000219b32632.
For some solutions e.g. sound/soc/intel/catpt, DW DMA is part of a
compound device (in that very example, domains: ADSP, SSP0, SSP1, DMA0
and DMA1 are part of a single entity) rather than being a standalone
one. Driver for said device may enlist DMA to transfer data during
suspend or resume sequences.

Manipulating RPM explicitly in dw's DMA request and release channel
functions causes suspend() to also invoke resume() for the exact same
device. Similar situation occurs for resume() sequence. Effectively
renders device dysfunctional after first suspend() attempt. Revert the
change to address the problem.

Fixes: 842067940a3e ("dmaengine: dw: Enable runtime PM")
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---

Changes v2:
- enriched tag area with fixes tag

 drivers/dma/dw/core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 19a23767533a..7ab83fe601ed 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -982,11 +982,8 @@ static int dwc_alloc_chan_resources(struct dma_chan *chan)
 
 	dev_vdbg(chan2dev(chan), "%s\n", __func__);
 
-	pm_runtime_get_sync(dw->dma.dev);
-
 	/* ASSERT:  channel is idle */
 	if (dma_readl(dw, CH_EN) & dwc->mask) {
-		pm_runtime_put_sync_suspend(dw->dma.dev);
 		dev_dbg(chan2dev(chan), "DMA channel not idle?\n");
 		return -EIO;
 	}
@@ -1003,7 +1000,6 @@ static int dwc_alloc_chan_resources(struct dma_chan *chan)
 	 * We need controller-specific data to set up slave transfers.
 	 */
 	if (chan->private && !dw_dma_filter(chan, chan->private)) {
-		pm_runtime_put_sync_suspend(dw->dma.dev);
 		dev_warn(chan2dev(chan), "Wrong controller-specific data\n");
 		return -EINVAL;
 	}
@@ -1047,8 +1043,6 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 	if (!dw->in_use)
 		do_dw_dma_off(dw);
 
-	pm_runtime_put_sync_suspend(dw->dma.dev);
-
 	dev_vdbg(chan2dev(chan), "%s: done\n", __func__);
 }
 
-- 
2.17.1

