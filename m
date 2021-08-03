Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD823DF7CB
	for <lists+dmaengine@lfdr.de>; Wed,  4 Aug 2021 00:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhHCW3n (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Aug 2021 18:29:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:22126 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229611AbhHCW3n (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 3 Aug 2021 18:29:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="200970243"
X-IronPort-AV: E=Sophos;i="5.84,292,1620716400"; 
   d="scan'208";a="200970243"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 15:29:30 -0700
X-IronPort-AV: E=Sophos;i="5.84,292,1620716400"; 
   d="scan'208";a="479861386"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 15:29:30 -0700
Subject: [PATCH] dmaengine: idxd: make I/O interrupt handler one shot
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
Date:   Tue, 03 Aug 2021 15:29:30 -0700
Message-ID: <162802977005.3084234.11836261157026497585.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The interrupt thread handler currently loops forever to process outstanding
completions. This causes either an "irq X: nobody cared" kernel splat or
the NMI watchdog kicks in due to running too long in the function. The irq
thread handler is expected to run again after exiting if there are
interrupts fired while the thread handler is running. So the handler code
can process all the completed I/O in a single pass and exit without losing
the follow on completed I/O.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/irq.c |   59 +++++++-----------------------------------------
 1 file changed, 8 insertions(+), 51 deletions(-)

diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 65dc7bbb0a13..2f895dccb3b4 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -22,11 +22,6 @@ struct idxd_fault {
 	struct idxd_device *idxd;
 };
 
-static int irq_process_work_list(struct idxd_irq_entry *irq_entry,
-				 int *processed, u64 data);
-static int irq_process_pending_llist(struct idxd_irq_entry *irq_entry,
-				     int *processed, u64 data);
-
 static void idxd_device_reinit(struct work_struct *work)
 {
 	struct idxd_device *idxd = container_of(work, struct idxd_device, work);
@@ -177,18 +172,15 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
 	return IRQ_HANDLED;
 }
 
-static int irq_process_pending_llist(struct idxd_irq_entry *irq_entry,
-				     int *processed, u64 data)
+static void irq_process_pending_llist(struct idxd_irq_entry *irq_entry)
 {
 	struct idxd_desc *desc, *t;
 	struct llist_node *head;
-	int queued = 0;
 	unsigned long flags;
 
-	*processed = 0;
 	head = llist_del_all(&irq_entry->pending_llist);
 	if (!head)
-		goto out;
+		return;
 
 	llist_for_each_entry_safe(desc, t, head, llnode) {
 		u8 status = desc->completion->status & DSA_COMP_STATUS_MASK;
@@ -200,35 +192,25 @@ static int irq_process_pending_llist(struct idxd_irq_entry *irq_entry,
 			 */
 			if (unlikely(desc->completion->status == IDXD_COMP_DESC_ABORT)) {
 				complete_desc(desc, IDXD_COMPLETE_ABORT);
-				(*processed)++;
 				continue;
 			}
 
 			complete_desc(desc, IDXD_COMPLETE_NORMAL);
-			(*processed)++;
 		} else {
 			spin_lock_irqsave(&irq_entry->list_lock, flags);
 			list_add_tail(&desc->list,
 				      &irq_entry->work_list);
 			spin_unlock_irqrestore(&irq_entry->list_lock, flags);
-			queued++;
 		}
 	}
-
- out:
-	return queued;
 }
 
-static int irq_process_work_list(struct idxd_irq_entry *irq_entry,
-				 int *processed, u64 data)
+static void irq_process_work_list(struct idxd_irq_entry *irq_entry)
 {
-	int queued = 0;
 	unsigned long flags;
 	LIST_HEAD(flist);
 	struct idxd_desc *desc, *n;
 
-	*processed = 0;
-
 	/*
 	 * This lock protects list corruption from access of list outside of the irq handler
 	 * thread.
@@ -236,16 +218,13 @@ static int irq_process_work_list(struct idxd_irq_entry *irq_entry,
 	spin_lock_irqsave(&irq_entry->list_lock, flags);
 	if (list_empty(&irq_entry->work_list)) {
 		spin_unlock_irqrestore(&irq_entry->list_lock, flags);
-		return 0;
+		return;
 	}
 
 	list_for_each_entry_safe(desc, n, &irq_entry->work_list, list) {
 		if (desc->completion->status) {
 			list_del(&desc->list);
-			(*processed)++;
 			list_add_tail(&desc->list, &flist);
-		} else {
-			queued++;
 		}
 	}
 
@@ -265,13 +244,11 @@ static int irq_process_work_list(struct idxd_irq_entry *irq_entry,
 
 		complete_desc(desc, IDXD_COMPLETE_NORMAL);
 	}
-
-	return queued;
 }
 
-static int idxd_desc_process(struct idxd_irq_entry *irq_entry)
+irqreturn_t idxd_wq_thread(int irq, void *data)
 {
-	int rc, processed, total = 0;
+	struct idxd_irq_entry *irq_entry = data;
 
 	/*
 	 * There are two lists we are processing. The pending_llist is where
@@ -290,29 +267,9 @@ static int idxd_desc_process(struct idxd_irq_entry *irq_entry)
 	 *    and process the completed entries.
 	 * 4. If the entry is still waiting on hardware, list_add_tail() to
 	 *    the work_list.
-	 * 5. Repeat until no more descriptors.
 	 */
-	do {
-		rc = irq_process_work_list(irq_entry, &processed, 0);
-		total += processed;
-		if (rc != 0)
-			continue;
-
-		rc = irq_process_pending_llist(irq_entry, &processed, 0);
-		total += processed;
-	} while (rc != 0);
-
-	return total;
-}
-
-irqreturn_t idxd_wq_thread(int irq, void *data)
-{
-	struct idxd_irq_entry *irq_entry = data;
-	int processed;
-
-	processed = idxd_desc_process(irq_entry);
-	if (processed == 0)
-		return IRQ_NONE;
+	irq_process_work_list(irq_entry);
+	irq_process_pending_llist(irq_entry);
 
 	return IRQ_HANDLED;
 }


