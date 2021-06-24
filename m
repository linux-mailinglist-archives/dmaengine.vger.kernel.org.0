Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F163B369F
	for <lists+dmaengine@lfdr.de>; Thu, 24 Jun 2021 21:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhFXTLw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Jun 2021 15:11:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:5164 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232029AbhFXTLu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 24 Jun 2021 15:11:50 -0400
IronPort-SDR: ZSTidMumyXKmDsK2Nzp4ZOj1bx1MTvbt6JTXHfzxiufUuEby2YU9BHV20A3o3ZLyo4SqSnShdW
 wOhXBRaPkUGQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="207360905"
X-IronPort-AV: E=Sophos;i="5.83,297,1616482800"; 
   d="scan'208";a="207360905"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 12:09:30 -0700
IronPort-SDR: r9IvW4Iu3eIk+qCUoBT4SNI6yVNb1g48Q8dbXl37L0csCCyaG91qva10G8b3f2dmMuIavIxyfs
 sLM9y+c5ypQw==
X-IronPort-AV: E=Sophos;i="5.83,297,1616482800"; 
   d="scan'208";a="407137937"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 12:09:29 -0700
Subject: [PATCH] dmaengine: idxd: fix array index when int_handles are being
 used
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Thu, 24 Jun 2021 12:09:29 -0700
Message-ID: <162456176939.1121476.3366256009925001897.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The index to the irq vector should be local and has no relation to
the assigned interrupt handle. Assign the MSIX interrupt index that is
programmed for the descriptor. The interrupt handle only matters when it
comes to hardware descriptor programming.

Fixes: eb15e7154fbf ("dmaengine: idxd: add interrupt handle request and release support")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/submit.c |   15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
index b0f1ddf75d31..736def129fa8 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -130,19 +130,8 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 	 * Pending the descriptor to the lockless list for the irq_entry
 	 * that we designated the descriptor to.
 	 */
-	if (desc->hw->flags & IDXD_OP_FLAG_RCI) {
-		int vec;
-
-		/*
-		 * If the driver is on host kernel, it would be the value
-		 * assigned to interrupt handle, which is index for MSIX
-		 * vector. If it's guest then can't use the int_handle since
-		 * that is the index to IMS for the entire device. The guest
-		 * device local index will be used.
-		 */
-		vec = !idxd->int_handles ? desc->hw->int_handle : desc->vector;
-		llist_add(&desc->llnode, &idxd->irq_entries[vec].pending_llist);
-	}
+	if (desc->hw->flags & IDXD_OP_FLAG_RCI)
+		llist_add(&desc->llnode, &idxd->irq_entries[desc->vector].pending_llist);
 
 	return 0;
 }


