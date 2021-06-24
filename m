Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED7C3B37FE
	for <lists+dmaengine@lfdr.de>; Thu, 24 Jun 2021 22:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhFXUly (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Jun 2021 16:41:54 -0400
Received: from mga05.intel.com ([192.55.52.43]:41983 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229525AbhFXUly (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 24 Jun 2021 16:41:54 -0400
IronPort-SDR: iSwNj5ckUnZ/KpSLIAoF86WzgmXZUCAHEXOltKKNTfGVouXeCC3Y+FdhWnZrOHEpovJAtdH3n0
 /QiSmsbcn6lA==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="293191019"
X-IronPort-AV: E=Sophos;i="5.83,297,1616482800"; 
   d="scan'208";a="293191019"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 13:39:35 -0700
IronPort-SDR: Nn9INGsTBFyeT+xqfla2xe4+p0bN5ohQgRVkGe0xZm0n6nheNNxzm7o7/yF3XOgXewllK6G486
 yWsOW5mMA2Ag==
X-IronPort-AV: E=Sophos;i="5.83,297,1616482800"; 
   d="scan'208";a="406763102"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 13:39:33 -0700
Subject: [PATCH] dmaengine: idxd: assign MSIX vectors to each WQ rather than
 roundrobin
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Konstantin Ananyev <konstantin.ananyev@intel.com>,
        Konstantin Ananyev <konstantin.ananyev@intel.com>,
        dmaengine@vger.kernel.org
Date:   Thu, 24 Jun 2021 13:39:33 -0700
Message-ID: <162456717326.1130457.15258077196523268356.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

IOPS increased when changing MSIX vector to per WQ from roundrobin.
Allows descriptor to be completed by the submitter improves caching
locality.

Suggested-by: Konstantin Ananyev <konstantin.ananyev@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@intel.com>
---
 drivers/dma/idxd/idxd.h   |    2 --
 drivers/dma/idxd/submit.c |   36 ++++++++----------------------------
 2 files changed, 8 insertions(+), 30 deletions(-)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 5516ea31ff07..cdefd304d396 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -178,7 +178,6 @@ struct idxd_wq {
 	enum idxd_wq_state state;
 	unsigned long flags;
 	union wqcfg *wqcfg;
-	u32 vec_ptr;		/* interrupt steering */
 	struct dsa_hw_desc **hw_descs;
 	int num_descs;
 	union {
@@ -314,7 +313,6 @@ struct idxd_desc {
 	struct list_head list;
 	int id;
 	int cpu;
-	unsigned int vector;
 	struct idxd_wq *wq;
 };
 
diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
index 19afb62abaff..406f15a84f11 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -22,22 +22,13 @@ static struct idxd_desc *__get_desc(struct idxd_wq *wq, int idx, int cpu)
 		desc->hw->pasid = idxd->pasid;
 
 	/*
-	 * Descriptor completion vectors are 1...N for MSIX. We will round
-	 * robin through the N vectors.
+	 * On host, MSIX vecotr 0 is used for misc interrupt. Therefore when we match
+	 * vector 1:1 to the WQ id, we need to add 1
 	 */
-	wq->vec_ptr = (wq->vec_ptr % idxd->num_wq_irqs) + 1;
-	if (!idxd->int_handles) {
-		desc->hw->int_handle = wq->vec_ptr;
-	} else {
-		desc->vector = wq->vec_ptr;
-		/*
-		 * int_handles are only for descriptor completion. However for device
-		 * MSIX enumeration, vec 0 is used for misc interrupts. Therefore even
-		 * though we are rotating through 1...N for descriptor interrupts, we
-		 * need to acqurie the int_handles from 0..N-1.
-		 */
-		desc->hw->int_handle = idxd->int_handles[desc->vector - 1];
-	}
+	if (!idxd->int_handles)
+		desc->hw->int_handle = wq->id + 1;
+	else
+		desc->hw->int_handle = idxd->int_handles[wq->id];
 
 	return desc;
 }
@@ -128,19 +119,8 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
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
+		llist_add(&desc->llnode, &idxd->irq_entries[wq->id + 1].pending_llist);
 
 	return 0;
 }


