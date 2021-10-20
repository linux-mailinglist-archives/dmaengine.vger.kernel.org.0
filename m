Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0426B4350C8
	for <lists+dmaengine@lfdr.de>; Wed, 20 Oct 2021 18:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhJTQ6b (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Oct 2021 12:58:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:54397 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230073AbhJTQ6b (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 20 Oct 2021 12:58:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="252323929"
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="252323929"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 09:53:42 -0700
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="527147856"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 09:53:41 -0700
Subject: [PATCH 1/7] dmaengine: idxd: rework descriptor free path on failure
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Kevin Tian <kevin.tian@intel.com>, dmaengine@vger.kernel.org
Date:   Wed, 20 Oct 2021 09:53:41 -0700
Message-ID: <163474882126.2608004.7014964789204798071.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <163474864017.2608004.10983485368237365990.stgit@djiang5-desk3.ch.intel.com>
References: <163474864017.2608004.10983485368237365990.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Refactor the completion function to allow skipping of descriptor freeing on
the submission failiure path. This completely removes descriptor freeing
from the submit failure path and leave the responsibility to the caller.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/dma.c    |   10 ++++++++--
 drivers/dma/idxd/idxd.h   |    8 +-------
 drivers/dma/idxd/init.c   |    9 +++------
 drivers/dma/idxd/irq.c    |    8 ++++----
 drivers/dma/idxd/submit.c |   12 +++---------
 5 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index c39e9483206a..1ea663215909 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -21,7 +21,8 @@ static inline struct idxd_wq *to_idxd_wq(struct dma_chan *c)
 }
 
 void idxd_dma_complete_txd(struct idxd_desc *desc,
-			   enum idxd_complete_type comp_type)
+			   enum idxd_complete_type comp_type,
+			   bool free_desc)
 {
 	struct dma_async_tx_descriptor *tx;
 	struct dmaengine_result res;
@@ -44,6 +45,9 @@ void idxd_dma_complete_txd(struct idxd_desc *desc,
 		tx->callback = NULL;
 		tx->callback_result = NULL;
 	}
+
+	if (free_desc)
+		idxd_free_desc(desc->wq, desc);
 }
 
 static void op_flag_setup(unsigned long flags, u32 *desc_flags)
@@ -153,8 +157,10 @@ static dma_cookie_t idxd_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 	cookie = dma_cookie_assign(tx);
 
 	rc = idxd_submit_desc(wq, desc);
-	if (rc < 0)
+	if (rc < 0) {
+		idxd_free_desc(wq, desc);
 		return rc;
+	}
 
 	return cookie;
 }
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 0cf8d3145870..3d600f8ee90b 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -579,7 +579,7 @@ int idxd_register_dma_channel(struct idxd_wq *wq);
 void idxd_unregister_dma_channel(struct idxd_wq *wq);
 void idxd_parse_completion_status(u8 status, enum dmaengine_tx_result *res);
 void idxd_dma_complete_txd(struct idxd_desc *desc,
-			   enum idxd_complete_type comp_type);
+			   enum idxd_complete_type comp_type, bool free_desc);
 
 /* cdev */
 int idxd_cdev_register(void);
@@ -603,10 +603,4 @@ static inline void perfmon_init(void) {}
 static inline void perfmon_exit(void) {}
 #endif
 
-static inline void complete_desc(struct idxd_desc *desc, enum idxd_complete_type reason)
-{
-	idxd_dma_complete_txd(desc, reason);
-	idxd_free_desc(desc->wq, desc);
-}
-
 #endif
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index eb09bc591c31..ef549cef8480 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -717,10 +717,8 @@ static void idxd_flush_pending_llist(struct idxd_irq_entry *ie)
 	if (!head)
 		return;
 
-	llist_for_each_entry_safe(desc, itr, head, llnode) {
-		idxd_dma_complete_txd(desc, IDXD_COMPLETE_ABORT);
-		idxd_free_desc(desc->wq, desc);
-	}
+	llist_for_each_entry_safe(desc, itr, head, llnode)
+		idxd_dma_complete_txd(desc, IDXD_COMPLETE_ABORT, true);
 }
 
 static void idxd_flush_work_list(struct idxd_irq_entry *ie)
@@ -729,8 +727,7 @@ static void idxd_flush_work_list(struct idxd_irq_entry *ie)
 
 	list_for_each_entry_safe(desc, iter, &ie->work_list, list) {
 		list_del(&desc->list);
-		idxd_dma_complete_txd(desc, IDXD_COMPLETE_ABORT);
-		idxd_free_desc(desc->wq, desc);
+		idxd_dma_complete_txd(desc, IDXD_COMPLETE_ABORT, true);
 	}
 }
 
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 3261ea247e83..573a2f6d0f7f 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -195,11 +195,11 @@ static void irq_process_pending_llist(struct idxd_irq_entry *irq_entry)
 			 * and 0xff, which DSA_COMP_STATUS_MASK can mask out.
 			 */
 			if (unlikely(desc->completion->status == IDXD_COMP_DESC_ABORT)) {
-				complete_desc(desc, IDXD_COMPLETE_ABORT);
+				idxd_dma_complete_txd(desc, IDXD_COMPLETE_ABORT, true);
 				continue;
 			}
 
-			complete_desc(desc, IDXD_COMPLETE_NORMAL);
+			idxd_dma_complete_txd(desc, IDXD_COMPLETE_NORMAL, true);
 		} else {
 			spin_lock(&irq_entry->list_lock);
 			list_add_tail(&desc->list,
@@ -239,11 +239,11 @@ static void irq_process_work_list(struct idxd_irq_entry *irq_entry)
 		 * and 0xff, which DSA_COMP_STATUS_MASK can mask out.
 		 */
 		if (unlikely(desc->completion->status == IDXD_COMP_DESC_ABORT)) {
-			complete_desc(desc, IDXD_COMPLETE_ABORT);
+			idxd_dma_complete_txd(desc, IDXD_COMPLETE_ABORT, true);
 			continue;
 		}
 
-		complete_desc(desc, IDXD_COMPLETE_NORMAL);
+		idxd_dma_complete_txd(desc, IDXD_COMPLETE_NORMAL, true);
 	}
 }
 
diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
index de76fb4abac2..ea11809dbb32 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -129,7 +129,7 @@ static void llist_abort_desc(struct idxd_wq *wq, struct idxd_irq_entry *ie,
 	spin_unlock(&ie->list_lock);
 
 	if (found)
-		complete_desc(found, IDXD_COMPLETE_ABORT);
+		idxd_dma_complete_txd(found, IDXD_COMPLETE_ABORT, false);
 }
 
 int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
@@ -139,15 +139,11 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 	void __iomem *portal;
 	int rc;
 
-	if (idxd->state != IDXD_DEV_ENABLED) {
-		idxd_free_desc(wq, desc);
+	if (idxd->state != IDXD_DEV_ENABLED)
 		return -EIO;
-	}
 
-	if (!percpu_ref_tryget_live(&wq->wq_active)) {
-		idxd_free_desc(wq, desc);
+	if (!percpu_ref_tryget_live(&wq->wq_active))
 		return -ENXIO;
-	}
 
 	portal = idxd_wq_portal_addr(wq);
 
@@ -182,8 +178,6 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 			/* abort operation frees the descriptor */
 			if (ie)
 				llist_abort_desc(wq, ie, desc);
-			else
-				idxd_free_desc(wq, desc);
 			return rc;
 		}
 	}


