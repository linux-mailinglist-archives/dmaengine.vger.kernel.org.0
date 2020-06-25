Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B568C20A58A
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2020 21:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390330AbgFYTQ4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Jun 2020 15:16:56 -0400
Received: from mga11.intel.com ([192.55.52.93]:12658 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390025AbgFYTQ4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 25 Jun 2020 15:16:56 -0400
IronPort-SDR: DxYZZ+47GaJnA1g8gAp4AYDEhURH9IUAQtRnBO8PmG5ftyp4YIfcN1eXNbnbAgxBglbz7HTP7L
 G0H1NNx3Ya/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="143278961"
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="143278961"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 12:16:55 -0700
IronPort-SDR: cF80MMyYTZfifvbUtpcdLY+sO7TrldJCiB06RSFyrcm4ZNYK/0n+wI+2Lab+6b4In3pnTM5rmx
 6QFjea+7FF/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="453115226"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga005.jf.intel.com with ESMTP; 25 Jun 2020 12:16:54 -0700
Subject: [PATCH v2] dmaengine: idxd: fix misc interrupt handler thread
 unmasking
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Thu, 25 Jun 2020 12:16:54 -0700
Message-ID: <159311256528.855.11527922406329728512.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fix unmasking of misc interrupt handler when completing normal. It exits
early and skips the unmasking with the current implementation. Fix to
unmask interrupt when exiting normally.

Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

Rebased against dmaengine fixes branch

 drivers/dma/idxd/irq.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 6510791b9921..8a35f58da689 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -141,7 +141,7 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
 
 	iowrite32(cause, idxd->reg_base + IDXD_INTCAUSE_OFFSET);
 	if (!err)
-		return IRQ_HANDLED;
+		goto out;
 
 	gensts.bits = ioread32(idxd->reg_base + IDXD_GENSTATS_OFFSET);
 	if (gensts.state == IDXD_DEVICE_STATE_HALT) {
@@ -162,6 +162,7 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
 		spin_unlock_bh(&idxd->dev_lock);
 	}
 
+ out:
 	idxd_unmask_msix_vector(idxd, irq_entry->id);
 	return IRQ_HANDLED;
 }

