Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD74277829
	for <lists+dmaengine@lfdr.de>; Thu, 24 Sep 2020 20:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgIXSBO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Sep 2020 14:01:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728643AbgIXSBN (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 24 Sep 2020 14:01:13 -0400
Received: from localhost (unknown [192.55.55.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70CC7239E5;
        Thu, 24 Sep 2020 18:01:12 +0000 (UTC)
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dan.j.williams@intel.com, tony.luck@intel.com,
        jing.lin@intel.com, ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        fenghua.yu@intel.com, kevin.tian@intel.com, David.Laight@ACULAB.COM
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/5] dmaengine: idxd: Clean up descriptors with fault error
Date:   Thu, 24 Sep 2020 11:00:40 -0700
Message-Id: <20200924180041.34056-5-dave.jiang@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200924180041.34056-1-dave.jiang@intel.com>
References: <20200924180041.34056-1-dave.jiang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add code to "complete" a descriptor when the descriptor or its completion
address hit a fault error when SVA mode is being used. This error can be
triggered due to bad programming by the user. A lock is introduced in order
to protect the descriptor completion lists since the fault handler will run
from the system work queue after being scheduled in the interrupt handler.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dma/idxd/idxd.h |   5 ++
 drivers/dma/idxd/init.c |   1 +
 drivers/dma/idxd/irq.c  | 143 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 137 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 43a216c42d25..b64b6266ca97 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -34,6 +34,11 @@ struct idxd_irq_entry {
 	int id;
 	struct llist_head pending_llist;
 	struct list_head work_list;
+	/*
+	 * Lock to protect access between irq thread process descriptor
+	 * and irq thread processing error descriptor.
+	 */
+	spinlock_t list_lock;
 };
 
 struct idxd_group {
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 626401a71fdd..1bb7637b02eb 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -97,6 +97,7 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
 	for (i = 0; i < msixcnt; i++) {
 		idxd->irq_entries[i].id = i;
 		idxd->irq_entries[i].idxd = idxd;
+		spin_lock_init(&idxd->irq_entries[i].list_lock);
 	}
 
 	msix = &idxd->msix_entries[0];
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 17a65a13fb64..9e6cc55ad22f 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -11,6 +11,24 @@
 #include "idxd.h"
 #include "registers.h"
 
+enum irq_work_type {
+	IRQ_WORK_NORMAL = 0,
+	IRQ_WORK_PROCESS_FAULT,
+};
+
+struct idxd_fault {
+	struct work_struct work;
+	u64 addr;
+	struct idxd_device *idxd;
+};
+
+static int irq_process_work_list(struct idxd_irq_entry *irq_entry,
+				 enum irq_work_type wtype,
+				 int *processed, u64 data);
+static int irq_process_pending_llist(struct idxd_irq_entry *irq_entry,
+				     enum irq_work_type wtype,
+				     int *processed, u64 data);
+
 static void idxd_device_reinit(struct work_struct *work)
 {
 	struct idxd_device *idxd = container_of(work, struct idxd_device, work);
@@ -44,6 +62,46 @@ static void idxd_device_reinit(struct work_struct *work)
 	idxd_device_wqs_clear_state(idxd);
 }
 
+static void idxd_device_fault_work(struct work_struct *work)
+{
+	struct idxd_fault *fault = container_of(work, struct idxd_fault, work);
+	struct idxd_irq_entry *ie;
+	int i;
+	int processed;
+	int irqcnt = fault->idxd->num_wq_irqs + 1;
+
+	for (i = 1; i < irqcnt; i++) {
+		ie = &fault->idxd->irq_entries[i];
+		irq_process_work_list(ie, IRQ_WORK_PROCESS_FAULT,
+				      &processed, fault->addr);
+		if (processed)
+			break;
+
+		irq_process_pending_llist(ie, IRQ_WORK_PROCESS_FAULT,
+					  &processed, fault->addr);
+		if (processed)
+			break;
+	}
+
+	kfree(fault);
+}
+
+static int idxd_device_schedule_fault_process(struct idxd_device *idxd,
+					      u64 fault_addr)
+{
+	struct idxd_fault *fault;
+
+	fault = kmalloc(sizeof(*fault), GFP_ATOMIC);
+	if (!fault)
+		return -ENOMEM;
+
+	fault->addr = fault_addr;
+	fault->idxd = idxd;
+	INIT_WORK(&fault->work, idxd_device_fault_work);
+	queue_work(idxd->wq, &fault->work);
+	return 0;
+}
+
 irqreturn_t idxd_irq_handler(int vec, void *data)
 {
 	struct idxd_irq_entry *irq_entry = data;
@@ -125,6 +183,16 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
 	if (!err)
 		goto out;
 
+	/*
+	 * This case should rarely happen and typically is due to software
+	 * programming error by the driver.
+	 */
+	if (idxd->sw_err.valid &&
+	    idxd->sw_err.desc_valid &&
+	    idxd->sw_err.fault_addr)
+		idxd_device_schedule_fault_process(idxd,
+						   idxd->sw_err.fault_addr);
+
 	gensts.bits = ioread32(idxd->reg_base + IDXD_GENSTATS_OFFSET);
 	if (gensts.state == IDXD_DEVICE_STATE_HALT) {
 		idxd->state = IDXD_DEV_HALTED;
@@ -152,57 +220,106 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
 	return IRQ_HANDLED;
 }
 
+static bool process_fault(struct idxd_desc *desc, u64 fault_addr)
+{
+	if ((u64)desc->hw == fault_addr ||
+	    (u64)desc->completion == fault_addr) {
+		idxd_dma_complete_txd(desc, IDXD_COMPLETE_DEV_FAIL);
+		return true;
+	}
+
+	return false;
+}
+
+static bool complete_desc(struct idxd_desc *desc)
+{
+	if (desc->completion->status) {
+		idxd_dma_complete_txd(desc, IDXD_COMPLETE_NORMAL);
+		return true;
+	}
+
+	return false;
+}
+
 static int irq_process_pending_llist(struct idxd_irq_entry *irq_entry,
-				     int *processed)
+				     enum irq_work_type wtype,
+				     int *processed, u64 data)
 {
 	struct idxd_desc *desc, *t;
 	struct llist_node *head;
 	int queued = 0;
+	bool completed = false;
+	unsigned long flags;
 
 	*processed = 0;
 	head = llist_del_all(&irq_entry->pending_llist);
 	if (!head)
-		return 0;
+		goto out;
 
 	llist_for_each_entry_safe(desc, t, head, llnode) {
-		if (desc->completion->status) {
-			idxd_dma_complete_txd(desc, IDXD_COMPLETE_NORMAL);
+		if (wtype == IRQ_WORK_NORMAL)
+			completed = complete_desc(desc);
+		else if (wtype == IRQ_WORK_PROCESS_FAULT)
+			completed = process_fault(desc, data);
+
+		if (completed) {
 			idxd_free_desc(desc->wq, desc);
 			(*processed)++;
+			if (wtype == IRQ_WORK_PROCESS_FAULT)
+				break;
 		} else {
-			list_add_tail(&desc->list, &irq_entry->work_list);
+			spin_lock_irqsave(&irq_entry->list_lock, flags);
+			list_add_tail(&desc->list,
+				      &irq_entry->work_list);
+			spin_unlock_irqrestore(&irq_entry->list_lock, flags);
 			queued++;
 		}
 	}
 
+ out:
 	return queued;
 }
 
 static int irq_process_work_list(struct idxd_irq_entry *irq_entry,
-				 int *processed)
+				 enum irq_work_type wtype,
+				 int *processed, u64 data)
 {
 	struct list_head *node, *next;
 	int queued = 0;
+	bool completed = false;
+	unsigned long flags;
 
 	*processed = 0;
+	spin_lock_irqsave(&irq_entry->list_lock, flags);
 	if (list_empty(&irq_entry->work_list))
-		return 0;
+		goto out;
 
 	list_for_each_safe(node, next, &irq_entry->work_list) {
 		struct idxd_desc *desc =
 			container_of(node, struct idxd_desc, list);
 
-		if (desc->completion->status) {
+		spin_unlock_irqrestore(&irq_entry->list_lock, flags);
+		if (wtype == IRQ_WORK_NORMAL)
+			completed = complete_desc(desc);
+		else if (wtype == IRQ_WORK_PROCESS_FAULT)
+			completed = process_fault(desc, data);
+
+		if (completed) {
+			spin_lock_irqsave(&irq_entry->list_lock, flags);
 			list_del(&desc->list);
-			/* process and callback */
-			idxd_dma_complete_txd(desc, IDXD_COMPLETE_NORMAL);
+			spin_unlock_irqrestore(&irq_entry->list_lock, flags);
 			idxd_free_desc(desc->wq, desc);
 			(*processed)++;
+			if (wtype == IRQ_WORK_PROCESS_FAULT)
+				return queued;
 		} else {
 			queued++;
 		}
+		spin_lock_irqsave(&irq_entry->list_lock, flags);
 	}
 
+ out:
+	spin_unlock_irqrestore(&irq_entry->list_lock, flags);
 	return queued;
 }
 
@@ -230,12 +347,14 @@ static int idxd_desc_process(struct idxd_irq_entry *irq_entry)
 	 * 5. Repeat until no more descriptors.
 	 */
 	do {
-		rc = irq_process_work_list(irq_entry, &processed);
+		rc = irq_process_work_list(irq_entry, IRQ_WORK_NORMAL,
+					   &processed, 0);
 		total += processed;
 		if (rc != 0)
 			continue;
 
-		rc = irq_process_pending_llist(irq_entry, &processed);
+		rc = irq_process_pending_llist(irq_entry, IRQ_WORK_NORMAL,
+					       &processed, 0);
 		total += processed;
 	} while (rc != 0);
 
-- 
2.21.3

