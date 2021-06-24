Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FAF3B36A9
	for <lists+dmaengine@lfdr.de>; Thu, 24 Jun 2021 21:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbhFXTPy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Jun 2021 15:15:54 -0400
Received: from mga05.intel.com ([192.55.52.43]:35173 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232596AbhFXTPx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 24 Jun 2021 15:15:53 -0400
IronPort-SDR: jxm9FspNdMWOiH0Nn6dGv2HGizRr6iq3AVwT1m0L5vVO9BLfLGSxWq3l0odpeAEi0Nxah8kGD9
 7VnTssOrvY5w==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="293177036"
X-IronPort-AV: E=Sophos;i="5.83,297,1616482800"; 
   d="scan'208";a="293177036"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 12:13:31 -0700
IronPort-SDR: ZqTWDdWys78jUhT7pxrZu5dzGciIl4FwyY32GVIQ2mf55Uz7KCikGXkBz3apleCycGl5mmtcjq
 eBfia0dJtD1g==
X-IronPort-AV: E=Sophos;i="5.83,297,1616482800"; 
   d="scan'208";a="639889281"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 12:13:31 -0700
Subject: [PATCH] dmaengine: idxd: fix submission race window
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Konstantin Ananyev <konstantin.ananyev@intel.com>,
        dmaengine@vger.kernel.org
Date:   Thu, 24 Jun 2021 12:13:30 -0700
Message-ID: <162456201091.1127851.8448033220391062931.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Konstantin observed that when descriptors are submitted, the descriptor is
added to the pending list after the submission. This creates a race window
with the slight possibility that the descriptor can complete before it
gets added to the pending list and this window would cause the completion
handler to miss processing the descriptor.

To address the issue, the addition of the descriptor to the pending list
must be done before it gets submitted to the hardware. However, submitting
to swq with ENQCMDS instruction can cause a failure with the condition of
either wq is full or wq is not "active".

With the descriptor allocation being the gate to the wq capacity, it is not
possible to hit a retry with ENQCMDS submission to the swq. The only
possible failure can happen is when wq is no longer "active" due to hw
error and therefore we are moving towards taking down the portal. Given
this is a rare condition and there's no longer concern over I/O
performance, the driver can walk the completion lists in order to retrieve
and abort the descriptor.

The error path will set the descriptor to aborted status. It will take the
work list lock to prevent further processing of worklist. It will do a
delete_all on the pending llist to retrieve all descriptors on the pending
llist. The delete_all action does not require a lock. It will walk through
the acquired llist to find the aborted descriptor while add all remaining
descriptors to the work list since it holds the lock. If it does not find
the aborted descriptor on the llist, it will walk through the work
list. And if it still does not find the descriptor, then it means the
interrupt handler has removed the desc from the llist but is pending on the work
list lock and will process it once the error path releases the lock.

Fixes: eb15e7154fbf ("dmaengine: idxd: add interrupt handle request and release support")
Reported-by: Konstantin Ananyev <konstantin.ananyev@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/idxd.h   |   14 ++++++++
 drivers/dma/idxd/irq.c    |   36 +++++++++++----------
 drivers/dma/idxd/submit.c |   77 ++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 101 insertions(+), 26 deletions(-)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 1f0991dec679..0f27374eae4b 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -294,6 +294,14 @@ struct idxd_desc {
 	struct idxd_wq *wq;
 };
 
+/*
+ * This is software defined error for the completion status. We overload the error code
+ * that will never appear in completion status and only SWERR register.
+ */
+enum idxd_completion_status {
+	IDXD_COMP_DESC_ABORT = 0xff,
+};
+
 #define confdev_to_idxd(dev) container_of(dev, struct idxd_device, conf_dev)
 #define confdev_to_wq(dev) container_of(dev, struct idxd_wq, conf_dev)
 
@@ -480,4 +488,10 @@ static inline void perfmon_init(void) {}
 static inline void perfmon_exit(void) {}
 #endif
 
+static inline void complete_desc(struct idxd_desc *desc, enum idxd_complete_type reason)
+{
+	idxd_dma_complete_txd(desc, reason);
+	idxd_free_desc(desc->wq, desc);
+}
+
 #endif
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 7a2cf0512501..8fd52937537a 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -245,12 +245,6 @@ static inline bool match_fault(struct idxd_desc *desc, u64 fault_addr)
 	return false;
 }
 
-static inline void complete_desc(struct idxd_desc *desc, enum idxd_complete_type reason)
-{
-	idxd_dma_complete_txd(desc, reason);
-	idxd_free_desc(desc->wq, desc);
-}
-
 static int irq_process_pending_llist(struct idxd_irq_entry *irq_entry,
 				     enum irq_work_type wtype,
 				     int *processed, u64 data)
@@ -258,8 +252,7 @@ static int irq_process_pending_llist(struct idxd_irq_entry *irq_entry,
 	struct idxd_desc *desc, *t;
 	struct llist_node *head;
 	int queued = 0;
-	unsigned long flags;
-	enum idxd_complete_type reason;
+	enum idxd_complete_type reason = IDXD_COMPLETE_NORMAL;
 
 	*processed = 0;
 	head = llist_del_all(&irq_entry->pending_llist);
@@ -272,16 +265,20 @@ static int irq_process_pending_llist(struct idxd_irq_entry *irq_entry,
 		reason = IDXD_COMPLETE_DEV_FAIL;
 
 	llist_for_each_entry_safe(desc, t, head, llnode) {
-		if (desc->completion->status) {
-			if ((desc->completion->status & DSA_COMP_STATUS_MASK) != DSA_COMP_SUCCESS)
+		u8 status = desc->completion->status & DSA_COMP_STATUS_MASK;
+
+		if (status) {
+			if (status == IDXD_COMP_DESC_ABORT)
+				reason = IDXD_COMPLETE_ABORT;
+			else if (status != DSA_COMP_SUCCESS)
 				match_fault(desc, data);
 			complete_desc(desc, reason);
 			(*processed)++;
 		} else {
-			spin_lock_irqsave(&irq_entry->list_lock, flags);
+			spin_lock_bh(&irq_entry->list_lock);
 			list_add_tail(&desc->list,
 				      &irq_entry->work_list);
-			spin_unlock_irqrestore(&irq_entry->list_lock, flags);
+			spin_unlock_bh(&irq_entry->list_lock);
 			queued++;
 		}
 	}
@@ -295,10 +292,9 @@ static int irq_process_work_list(struct idxd_irq_entry *irq_entry,
 				 int *processed, u64 data)
 {
 	int queued = 0;
-	unsigned long flags;
 	LIST_HEAD(flist);
 	struct idxd_desc *desc, *n;
-	enum idxd_complete_type reason;
+	enum idxd_complete_type reason = IDXD_COMPLETE_NORMAL;
 
 	*processed = 0;
 	if (wtype == IRQ_WORK_NORMAL)
@@ -310,9 +306,9 @@ static int irq_process_work_list(struct idxd_irq_entry *irq_entry,
 	 * This lock protects list corruption from access of list outside of the irq handler
 	 * thread.
 	 */
-	spin_lock_irqsave(&irq_entry->list_lock, flags);
+	spin_lock_bh(&irq_entry->list_lock);
 	if (list_empty(&irq_entry->work_list)) {
-		spin_unlock_irqrestore(&irq_entry->list_lock, flags);
+		spin_unlock_bh(&irq_entry->list_lock);
 		return 0;
 	}
 
@@ -326,10 +322,14 @@ static int irq_process_work_list(struct idxd_irq_entry *irq_entry,
 		}
 	}
 
-	spin_unlock_irqrestore(&irq_entry->list_lock, flags);
+	spin_unlock_bh(&irq_entry->list_lock);
 
 	list_for_each_entry(desc, &flist, list) {
-		if ((desc->completion->status & DSA_COMP_STATUS_MASK) != DSA_COMP_SUCCESS)
+		u8 status = desc->completion->status & DSA_COMP_STATUS_MASK;
+
+		if (desc->completion->status == IDXD_COMP_DESC_ABORT)
+			reason = IDXD_COMPLETE_ABORT;
+		else if (status != DSA_COMP_SUCCESS)
 			match_fault(desc, data);
 		complete_desc(desc, reason);
 	}
diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
index 736def129fa8..d99a3aeb038c 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -88,9 +88,66 @@ void idxd_free_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 	sbitmap_queue_clear(&wq->sbq, desc->id, cpu);
 }
 
+static void list_abort_desc(struct idxd_wq *wq, struct idxd_irq_entry *ie,
+			    struct idxd_desc *desc)
+{
+	struct idxd_desc *d, *n;
+
+	lockdep_assert_held(&ie->list_lock);
+	list_for_each_entry_safe(d, n, &ie->work_list, list) {
+		if (d == desc) {
+			list_del(&d->list);
+			complete_desc(desc, IDXD_COMPLETE_ABORT);
+			return;
+		}
+	}
+
+	/*
+	 * At this point, the desc needs to be aborted is held by the completion
+	 * handler where it has taken it off the pending list but has not added to the
+	 * work list. It will be cleaned up by the interrupt handler when it sees the
+	 * IDXD_COMP_DESC_ABORT for completion status.
+	 */
+}
+
+static void llist_abort_desc(struct idxd_wq *wq, struct idxd_irq_entry *ie,
+			     struct idxd_desc *desc)
+{
+	struct idxd_desc *d, *t;
+	struct llist_node *head;
+	bool found = false;
+
+	desc->completion->status = IDXD_COMP_DESC_ABORT;
+	/*
+	 * Grab the list lock so it will block the irq thread handler. This allows the
+	 * abort code to locate the descriptor need to be aborted.
+	 */
+	spin_lock_bh(&ie->list_lock);
+	head = llist_del_all(&ie->pending_llist);
+	if (!head) {
+		list_abort_desc(wq, ie, desc);
+		spin_unlock_bh(&ie->list_lock);
+		return;
+	}
+
+	llist_for_each_entry_safe(d, t, head, llnode) {
+		if (d == desc) {
+			complete_desc(desc, IDXD_COMPLETE_ABORT);
+			found = true;
+			continue;
+		}
+		list_add_tail(&desc->list, &ie->work_list);
+	}
+
+	if (!found)
+		list_abort_desc(wq, ie, desc);
+	spin_unlock_bh(&ie->list_lock);
+}
+
 int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 {
 	struct idxd_device *idxd = wq->idxd;
+	struct idxd_irq_entry *ie = NULL;
 	void __iomem *portal;
 	int rc;
 
@@ -108,6 +165,16 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 	 * even on UP because the recipient is a device.
 	 */
 	wmb();
+
+	/*
+	 * Pending the descriptor to the lockless list for the irq_entry
+	 * that we designated the descriptor to.
+	 */
+	if (desc->hw->flags & IDXD_OP_FLAG_RCI) {
+		ie = &idxd->irq_entries[desc->vector];
+		llist_add(&desc->llnode, &ie->pending_llist);
+	}
+
 	if (wq_dedicated(wq)) {
 		iosubmit_cmds512(portal, desc->hw, 1);
 	} else {
@@ -120,18 +187,12 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 		rc = enqcmds(portal, desc->hw);
 		if (rc < 0) {
 			percpu_ref_put(&wq->wq_active);
+			if (ie)
+				llist_abort_desc(wq, ie, desc);
 			return rc;
 		}
 	}
 
 	percpu_ref_put(&wq->wq_active);
-
-	/*
-	 * Pending the descriptor to the lockless list for the irq_entry
-	 * that we designated the descriptor to.
-	 */
-	if (desc->hw->flags & IDXD_OP_FLAG_RCI)
-		llist_add(&desc->llnode, &idxd->irq_entries[desc->vector].pending_llist);
-
 	return 0;
 }


