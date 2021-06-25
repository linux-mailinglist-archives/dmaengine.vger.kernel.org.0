Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B113B49DA
	for <lists+dmaengine@lfdr.de>; Fri, 25 Jun 2021 22:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhFYUxO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 25 Jun 2021 16:53:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:20483 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhFYUxN (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 25 Jun 2021 16:53:13 -0400
IronPort-SDR: LCiurClQamMTLW+mWezGQ4HBaJwOTX1UrORiAf8NuS6LYZhq/brx8iKVtAH/9APj4JQTedJhAo
 i9u8yMt1Ii7w==
X-IronPort-AV: E=McAfee;i="6200,9189,10026"; a="194885113"
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; 
   d="scan'208";a="194885113"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 13:50:35 -0700
IronPort-SDR: Rqoc6N/rqwxf3ZBAGecgaJiBhhyvDFGcT8quArokvYEyIKpdxA3e3BVI4Y0O6AvsqxaF3iKuGw
 epW7qIxcfGvg==
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; 
   d="scan'208";a="407083142"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 13:50:34 -0700
Subject: [PATCH v2] dmaengine: idxd: fix submission race window
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Konstantin Ananyev <konstantin.ananyev@intel.com>,
        dmaengine@vger.kernel.org
Date:   Fri, 25 Jun 2021 13:50:33 -0700
Message-ID: <162465411551.1619377.10886487403115313579.stgit@djiang5-desk3.ch.intel.com>
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
interrupt handler has removed the desc from the llist but is pending on
the work list lock and will process it once the error path releases the
lock.

Fixes: eb15e7154fbf ("dmaengine: idxd: add interrupt handle request and release support")
Reported-by: Konstantin Ananyev <konstantin.ananyev@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

v2:
- do abort callback outside of lock (Konstantin)
- fix abort reason flag (Konstantin)
- remove changes to spinlock

 drivers/dma/idxd/idxd.h   |   14 ++++++++
 drivers/dma/idxd/irq.c    |   27 +++++++++++-----
 drivers/dma/idxd/submit.c |   75 ++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 99 insertions(+), 17 deletions(-)

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
index 7a2cf0512501..2924819ca8f3 100644
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
@@ -272,8 +266,16 @@ static int irq_process_pending_llist(struct idxd_irq_entry *irq_entry,
 		reason = IDXD_COMPLETE_DEV_FAIL;
 
 	llist_for_each_entry_safe(desc, t, head, llnode) {
-		if (desc->completion->status) {
-			if ((desc->completion->status & DSA_COMP_STATUS_MASK) != DSA_COMP_SUCCESS)
+		u8 status = desc->completion->status & DSA_COMP_STATUS_MASK;
+
+		if (status) {
+			if (unlikely(status == IDXD_COMP_DESC_ABORT)) {
+				complete_desc(desc, IDXD_COMPLETE_ABORT);
+				(*processed)++;
+				continue;
+			}
+
+			if (unlikely(status != DSA_COMP_SUCCESS))
 				match_fault(desc, data);
 			complete_desc(desc, reason);
 			(*processed)++;
@@ -329,7 +331,14 @@ static int irq_process_work_list(struct idxd_irq_entry *irq_entry,
 	spin_unlock_irqrestore(&irq_entry->list_lock, flags);
 
 	list_for_each_entry(desc, &flist, list) {
-		if ((desc->completion->status & DSA_COMP_STATUS_MASK) != DSA_COMP_SUCCESS)
+		u8 status = desc->completion->status & DSA_COMP_STATUS_MASK;
+
+		if (unlikely(status == IDXD_COMP_DESC_ABORT)) {
+			complete_desc(desc, IDXD_COMPLETE_ABORT);
+			continue;
+		}
+
+		if (unlikely(status != DSA_COMP_SUCCESS))
 			match_fault(desc, data);
 		complete_desc(desc, reason);
 	}
diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
index 736def129fa8..b08400c44229 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -88,9 +88,64 @@ void idxd_free_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 	sbitmap_queue_clear(&wq->sbq, desc->id, cpu);
 }
 
+static struct idxd_desc *list_abort_desc(struct idxd_wq *wq, struct idxd_irq_entry *ie,
+					 struct idxd_desc *desc)
+{
+	struct idxd_desc *d, *n;
+
+	lockdep_assert_held(&ie->list_lock);
+	list_for_each_entry_safe(d, n, &ie->work_list, list) {
+		if (d == desc) {
+			list_del(&d->list);
+			return d;
+		}
+	}
+
+	/*
+	 * At this point, the desc needs to be aborted is held by the completion
+	 * handler where it has taken it off the pending list but has not added to the
+	 * work list. It will be cleaned up by the interrupt handler when it sees the
+	 * IDXD_COMP_DESC_ABORT for completion status.
+	 */
+	return NULL;
+}
+
+static void llist_abort_desc(struct idxd_wq *wq, struct idxd_irq_entry *ie,
+			     struct idxd_desc *desc)
+{
+	struct idxd_desc *d, *t, *found;
+	struct llist_node *head;
+	unsigned long flags;
+
+	desc->completion->status = IDXD_COMP_DESC_ABORT;
+	/*
+	 * Grab the list lock so it will block the irq thread handler. This allows the
+	 * abort code to locate the descriptor need to be aborted.
+	 */
+	spin_lock_irqsave(&ie->list_lock, flags);
+	head = llist_del_all(&ie->pending_llist);
+	if (head) {
+		llist_for_each_entry_safe(d, t, head, llnode) {
+			if (d == desc) {
+				found = desc;
+				continue;
+			}
+			list_add_tail(&desc->list, &ie->work_list);
+		}
+	}
+
+	if (!found)
+		found = list_abort_desc(wq, ie, desc);
+	spin_unlock_irqrestore(&ie->list_lock, flags);
+
+	if (found)
+		complete_desc(found, IDXD_COMPLETE_ABORT);
+}
+
 int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 {
 	struct idxd_device *idxd = wq->idxd;
+	struct idxd_irq_entry *ie = NULL;
 	void __iomem *portal;
 	int rc;
 
@@ -108,6 +163,16 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
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
@@ -120,18 +185,12 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
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


