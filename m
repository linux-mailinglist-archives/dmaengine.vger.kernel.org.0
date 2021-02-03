Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9372630DEB9
	for <lists+dmaengine@lfdr.de>; Wed,  3 Feb 2021 16:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbhBCPwO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Feb 2021 10:52:14 -0500
Received: from mga14.intel.com ([192.55.52.115]:56154 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234581AbhBCPv7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 3 Feb 2021 10:51:59 -0500
IronPort-SDR: LXYbgyfYxjThyU5IExZb/r+EjoyXeoTLi6WJe1VAsTF0lFTCcFq1q7a0eHY9RvASxRa2/aKhG2
 f9+Kq24zLvgA==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="180289529"
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="180289529"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 07:51:06 -0800
IronPort-SDR: gr3vgGA40Dbfo+0IP4OhWCYenyInI3rtxhNbxSCaHNk1ZshJISO9zhnwt2BBv+QFa6Sl3Ubzu1
 42glqzY3Yk2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="414099822"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Feb 2021 07:51:04 -0800
From:   Cezary Rojewski <cezary.rojewski@intel.com>
To:     dmaengine@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        andriy.shevchenko@linux.intel.com, vireshk@kernel.org,
        vkoul@kernel.org, Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH] Revert "dmaengine: dw: Enable runtime PM"
Date:   Wed,  3 Feb 2021 16:51:00 +0100
Message-Id: <20210203155100.15034-1-cezary.rojewski@intel.com>
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

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
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

