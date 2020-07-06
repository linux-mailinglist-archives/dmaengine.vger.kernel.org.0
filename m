Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C69C215E3F
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2020 20:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbgGFSWB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Jul 2020 14:22:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:2390 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729647AbgGFSWA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 6 Jul 2020 14:22:00 -0400
IronPort-SDR: H9Ins1009DlVb9qOUagcPF4h2ogsaPoTuogkwuee9Vsn/53bXgSvsnu4sseC1dfGclI6VPGCB/
 Y3sTeuW1LwLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="232334042"
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="232334042"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 11:21:56 -0700
IronPort-SDR: vEq1dLRVboRKtmkQk7QG5u8f3HQsKMF8qQlQHOK4pwND+lrLj29S7B+c6a0eX+1Tr7A5Qnn+Wx
 qJjcbDeva2UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="314037038"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga008.jf.intel.com with ESMTP; 06 Jul 2020 11:21:55 -0700
Subject: [PATCH v3 5/6] dmaengine: idxd: clean up descriptors with fault
 error
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, dan.j.williams@intel.com, ashok.raj@intel.com,
        fenghua.yu@intel.com, tony.luck@intel.com, jing.lin@intel.com
Date:   Mon, 06 Jul 2020 11:21:55 -0700
Message-ID: <159405971555.19216.16912463239825977485.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <159405827797.19216.15283540319201919054.stgit@djiang5-desk3.ch.intel.com>
References: <159405827797.19216.15283540319201919054.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
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
 drivers/dma/idxd/idxd.h |    5 ++
 drivers/dma/idxd/init.c |    1 
 drivers/dma/idxd/irq.c  |  143 +++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 137 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index ab31e939dad6..518768885d7b 100644
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
index 1f23df0f97c1..a7e1dbfcd173 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -96,6 +96,7 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
 	for (i = 0; i < msixcnt; i++) {
 		idxd->irq_entries[i].id = i;
 		idxd->irq_entries[i].idxd = idxd;
+		spin_lock_init(&idxd->irq_entries[i].list_lock);
 	}
 
 	msix = &idxd->msix_entries[0];
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index b5142556cc4e..c97e08480323 100644
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
 void idxd_device_wqs_clear_state(struct idxd_device *idxd)
 {
 	int i;
@@ -56,6 +74,46 @@ static void idxd_device_reinit(struct work_struct *work)
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
@@ -137,6 +195,16 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
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
@@ -164,57 +232,106 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
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
 
@@ -242,12 +359,14 @@ static int idxd_desc_process(struct idxd_irq_entry *irq_entry)
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
 

