Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14B41FFDB6
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2020 00:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgFRWHR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 18 Jun 2020 18:07:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:32043 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727827AbgFRWHR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 18 Jun 2020 18:07:17 -0400
IronPort-SDR: tT+uWiIADhdwIPPzvKDYtsBBLz/kEJNJkK7iRU1fH9EWvscm2y+XjF32JPzVTl9of7ZqEfSR05
 sQRJ55Qp5bXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="141065305"
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; 
   d="scan'208";a="141065305"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 15:07:16 -0700
IronPort-SDR: dZTBk9gftSgMz1C1sZGUKFADIxA0VFxbZvdUq35gxzZRmZpQwa0C5dxwc2fjho1OROeMoNFZ6F
 JLQtgrRpB/jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; 
   d="scan'208";a="450792804"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga005.jf.intel.com with ESMTP; 18 Jun 2020 15:07:15 -0700
Subject: [PATCH] dmaengine: idxd: fix misc interrupt handler thread unmasking
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Thu, 18 Jun 2020 15:07:15 -0700
Message-ID: <159251803563.35972.386134975421311008.stgit@djiang5-desk3.ch.intel.com>
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
 drivers/dma/idxd/irq.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 6052765ca3c8..b7db8a0e1773 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -135,7 +135,7 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
 
 	iowrite32(cause, idxd->reg_base + IDXD_INTCAUSE_OFFSET);
 	if (!err)
-		return IRQ_HANDLED;
+		goto out;
 
 	gensts.bits = ioread32(idxd->reg_base + IDXD_GENSTATS_OFFSET);
 	if (gensts.state == IDXD_DEVICE_STATE_HALT) {
@@ -159,6 +159,7 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
 		}
 	}
 
+ out:
 	idxd_unmask_msix_vector(idxd, irq_entry->id);
 	return IRQ_HANDLED;
 }

