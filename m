Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B2039AD6C
	for <lists+dmaengine@lfdr.de>; Fri,  4 Jun 2021 00:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhFCWEz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Jun 2021 18:04:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:62668 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230370AbhFCWEz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 3 Jun 2021 18:04:55 -0400
IronPort-SDR: vNyfD5PpbDyIpQzxt3y3A52UUiVFsGsWfkr/fVMNRojwfI4lKmRAsJHNd/tBEOc6AufPBpnIO1
 AjThNS84k0iA==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="201145702"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="201145702"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 15:03:07 -0700
IronPort-SDR: HfQeYVAi9HHR6Tri49NAwCww7d+ooJaht2g8MjMFARuAUgwhCsH7w8zEdIbmt45/bQj5C/byP+
 q/D2vQNWptwg==
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="483647587"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 15:03:05 -0700
Subject: [PATCH] dmaengine: idxd: remove fault processing code
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Thu, 03 Jun 2021 15:03:03 -0700
Message-ID: <162275778388.1857326.6348833334923107311.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Kernel memory are pinned and will not cause faults. Since the driver
does not support interrupts for user descriptors, no fault errors are
expected to come through the misc interrupt. Remove dead code.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/irq.c |   98 ++----------------------------------------------
 1 file changed, 5 insertions(+), 93 deletions(-)

diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index d1a635ecc7f3..6328f76188b8 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -23,10 +23,8 @@ struct idxd_fault {
 };
 
 static int irq_process_work_list(struct idxd_irq_entry *irq_entry,
-				 enum irq_work_type wtype,
 				 int *processed, u64 data);
 static int irq_process_pending_llist(struct idxd_irq_entry *irq_entry,
-				     enum irq_work_type wtype,
 				     int *processed, u64 data);
 
 static void idxd_device_reinit(struct work_struct *work)
@@ -62,46 +60,6 @@ static void idxd_device_reinit(struct work_struct *work)
 	idxd_device_wqs_clear_state(idxd);
 }
 
-static void idxd_device_fault_work(struct work_struct *work)
-{
-	struct idxd_fault *fault = container_of(work, struct idxd_fault, work);
-	struct idxd_irq_entry *ie;
-	int i;
-	int processed;
-	int irqcnt = fault->idxd->num_wq_irqs + 1;
-
-	for (i = 1; i < irqcnt; i++) {
-		ie = &fault->idxd->irq_entries[i];
-		irq_process_work_list(ie, IRQ_WORK_PROCESS_FAULT,
-				      &processed, fault->addr);
-		if (processed)
-			break;
-
-		irq_process_pending_llist(ie, IRQ_WORK_PROCESS_FAULT,
-					  &processed, fault->addr);
-		if (processed)
-			break;
-	}
-
-	kfree(fault);
-}
-
-static int idxd_device_schedule_fault_process(struct idxd_device *idxd,
-					      u64 fault_addr)
-{
-	struct idxd_fault *fault;
-
-	fault = kmalloc(sizeof(*fault), GFP_ATOMIC);
-	if (!fault)
-		return -ENOMEM;
-
-	fault->addr = fault_addr;
-	fault->idxd = idxd;
-	INIT_WORK(&fault->work, idxd_device_fault_work);
-	queue_work(idxd->wq, &fault->work);
-	return 0;
-}
-
 static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
 {
 	struct device *dev = &idxd->pdev->dev;
@@ -168,15 +126,6 @@ static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
 	if (!err)
 		return 0;
 
-	/*
-	 * This case should rarely happen and typically is due to software
-	 * programming error by the driver.
-	 */
-	if (idxd->sw_err.valid &&
-	    idxd->sw_err.desc_valid &&
-	    idxd->sw_err.fault_addr)
-		idxd_device_schedule_fault_process(idxd, idxd->sw_err.fault_addr);
-
 	gensts.bits = ioread32(idxd->reg_base + IDXD_GENSTATS_OFFSET);
 	if (gensts.state == IDXD_DEVICE_STATE_HALT) {
 		idxd->state = IDXD_DEV_HALTED;
@@ -228,23 +177,6 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
 	return IRQ_HANDLED;
 }
 
-static inline bool match_fault(struct idxd_desc *desc, u64 fault_addr)
-{
-	/*
-	 * Completion address can be bad as well. Check fault address match for descriptor
-	 * and completion address.
-	 */
-	if ((u64)desc->hw == fault_addr || (u64)desc->completion == fault_addr) {
-		struct idxd_device *idxd = desc->wq->idxd;
-		struct device *dev = &idxd->pdev->dev;
-
-		dev_warn(dev, "desc with fault address: %#llx\n", fault_addr);
-		return true;
-	}
-
-	return false;
-}
-
 static inline void complete_desc(struct idxd_desc *desc, enum idxd_complete_type reason)
 {
 	idxd_dma_complete_txd(desc, reason);
@@ -252,30 +184,21 @@ static inline void complete_desc(struct idxd_desc *desc, enum idxd_complete_type
 }
 
 static int irq_process_pending_llist(struct idxd_irq_entry *irq_entry,
-				     enum irq_work_type wtype,
 				     int *processed, u64 data)
 {
 	struct idxd_desc *desc, *t;
 	struct llist_node *head;
 	int queued = 0;
 	unsigned long flags;
-	enum idxd_complete_type reason;
 
 	*processed = 0;
 	head = llist_del_all(&irq_entry->pending_llist);
 	if (!head)
 		goto out;
 
-	if (wtype == IRQ_WORK_NORMAL)
-		reason = IDXD_COMPLETE_NORMAL;
-	else
-		reason = IDXD_COMPLETE_DEV_FAIL;
-
 	llist_for_each_entry_safe(desc, t, head, llnode) {
 		if (desc->completion->status) {
-			if ((desc->completion->status & DSA_COMP_STATUS_MASK) != DSA_COMP_SUCCESS)
-				match_fault(desc, data);
-			complete_desc(desc, reason);
+			complete_desc(desc, IDXD_COMPLETE_NORMAL);
 			(*processed)++;
 		} else {
 			spin_lock_irqsave(&irq_entry->list_lock, flags);
@@ -291,20 +214,14 @@ static int irq_process_pending_llist(struct idxd_irq_entry *irq_entry,
 }
 
 static int irq_process_work_list(struct idxd_irq_entry *irq_entry,
-				 enum irq_work_type wtype,
 				 int *processed, u64 data)
 {
 	int queued = 0;
 	unsigned long flags;
 	LIST_HEAD(flist);
 	struct idxd_desc *desc, *n;
-	enum idxd_complete_type reason;
 
 	*processed = 0;
-	if (wtype == IRQ_WORK_NORMAL)
-		reason = IDXD_COMPLETE_NORMAL;
-	else
-		reason = IDXD_COMPLETE_DEV_FAIL;
 
 	/*
 	 * This lock protects list corruption from access of list outside of the irq handler
@@ -328,11 +245,8 @@ static int irq_process_work_list(struct idxd_irq_entry *irq_entry,
 
 	spin_unlock_irqrestore(&irq_entry->list_lock, flags);
 
-	list_for_each_entry(desc, &flist, list) {
-		if ((desc->completion->status & DSA_COMP_STATUS_MASK) != DSA_COMP_SUCCESS)
-			match_fault(desc, data);
-		complete_desc(desc, reason);
-	}
+	list_for_each_entry(desc, &flist, list)
+		complete_desc(desc, IDXD_COMPLETE_NORMAL);
 
 	return queued;
 }
@@ -361,14 +275,12 @@ static int idxd_desc_process(struct idxd_irq_entry *irq_entry)
 	 * 5. Repeat until no more descriptors.
 	 */
 	do {
-		rc = irq_process_work_list(irq_entry, IRQ_WORK_NORMAL,
-					   &processed, 0);
+		rc = irq_process_work_list(irq_entry, &processed, 0);
 		total += processed;
 		if (rc != 0)
 			continue;
 
-		rc = irq_process_pending_llist(irq_entry, IRQ_WORK_NORMAL,
-					       &processed, 0);
+		rc = irq_process_pending_llist(irq_entry, &processed, 0);
 		total += processed;
 	} while (rc != 0);
 


