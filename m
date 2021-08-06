Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062D43E2DD4
	for <lists+dmaengine@lfdr.de>; Fri,  6 Aug 2021 17:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240276AbhHFPhC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Aug 2021 11:37:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:23134 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232103AbhHFPhB (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 6 Aug 2021 11:37:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10068"; a="211286430"
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="scan'208";a="211286430"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 08:36:44 -0700
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="scan'208";a="420206664"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 08:36:44 -0700
Subject: [PATCH v2] dmaengine: idxd: remove interrupt flag for completion list
 spinlock
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Fri, 06 Aug 2021 08:36:43 -0700
Message-ID: <162826417450.3454650.3733188117742416238.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The list lock is never acquired in interrupt context. Therefore there is no
need to disable interrupts. Remove interrupt flags for lock operations.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

v2:
- Rebase against latest dmaengine/next

 drivers/dma/idxd/irq.c    |   12 +++++-------
 drivers/dma/idxd/submit.c |    5 ++---
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 11addb394793..d221c2e37460 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -176,7 +176,6 @@ static void irq_process_pending_llist(struct idxd_irq_entry *irq_entry)
 {
 	struct idxd_desc *desc, *t;
 	struct llist_node *head;
-	unsigned long flags;
 
 	head = llist_del_all(&irq_entry->pending_llist);
 	if (!head)
@@ -197,17 +196,16 @@ static void irq_process_pending_llist(struct idxd_irq_entry *irq_entry)
 
 			complete_desc(desc, IDXD_COMPLETE_NORMAL);
 		} else {
-			spin_lock_irqsave(&irq_entry->list_lock, flags);
+			spin_lock(&irq_entry->list_lock);
 			list_add_tail(&desc->list,
 				      &irq_entry->work_list);
-			spin_unlock_irqrestore(&irq_entry->list_lock, flags);
+			spin_unlock(&irq_entry->list_lock);
 		}
 	}
 }
 
 static void irq_process_work_list(struct idxd_irq_entry *irq_entry)
 {
-	unsigned long flags;
 	LIST_HEAD(flist);
 	struct idxd_desc *desc, *n;
 
@@ -215,9 +213,9 @@ static void irq_process_work_list(struct idxd_irq_entry *irq_entry)
 	 * This lock protects list corruption from access of list outside of the irq handler
 	 * thread.
 	 */
-	spin_lock_irqsave(&irq_entry->list_lock, flags);
+	spin_lock(&irq_entry->list_lock);
 	if (list_empty(&irq_entry->work_list)) {
-		spin_unlock_irqrestore(&irq_entry->list_lock, flags);
+		spin_unlock(&irq_entry->list_lock);
 		return;
 	}
 
@@ -228,7 +226,7 @@ static void irq_process_work_list(struct idxd_irq_entry *irq_entry)
 		}
 	}
 
-	spin_unlock_irqrestore(&irq_entry->list_lock, flags);
+	spin_unlock(&irq_entry->list_lock);
 
 	list_for_each_entry(desc, &flist, list) {
 		/*
diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
index 92ae9a157cc9..4b514c63af15 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -106,14 +106,13 @@ static void llist_abort_desc(struct idxd_wq *wq, struct idxd_irq_entry *ie,
 {
 	struct idxd_desc *d, *t, *found = NULL;
 	struct llist_node *head;
-	unsigned long flags;
 
 	desc->completion->status = IDXD_COMP_DESC_ABORT;
 	/*
 	 * Grab the list lock so it will block the irq thread handler. This allows the
 	 * abort code to locate the descriptor need to be aborted.
 	 */
-	spin_lock_irqsave(&ie->list_lock, flags);
+	spin_lock(&ie->list_lock);
 	head = llist_del_all(&ie->pending_llist);
 	if (head) {
 		llist_for_each_entry_safe(d, t, head, llnode) {
@@ -127,7 +126,7 @@ static void llist_abort_desc(struct idxd_wq *wq, struct idxd_irq_entry *ie,
 
 	if (!found)
 		found = list_abort_desc(wq, ie, desc);
-	spin_unlock_irqrestore(&ie->list_lock, flags);
+	spin_unlock(&ie->list_lock);
 
 	if (found)
 		complete_desc(found, IDXD_COMPLETE_ABORT);


