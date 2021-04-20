Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE815365FF1
	for <lists+dmaengine@lfdr.de>; Tue, 20 Apr 2021 21:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbhDTTBY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Apr 2021 15:01:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:12161 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233498AbhDTTBX (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Apr 2021 15:01:23 -0400
IronPort-SDR: dd8LqYho14Mba34Cl7zJ1GjcoWHN3W3m+ceT2sS2oI1rklC3Hi1ey6WoKVSQMto7eHVtWP+e+a
 8uhYrpByBe3Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="182701622"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="182701622"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 12:00:36 -0700
IronPort-SDR: mul3YQHkpRQRhVWWoanA/HREB8oxZVeXgST84DWtG3vEaAvM4vR8ak+l4HYKJ1a8DixhgXLrto
 PRIm+U+40J8Q==
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="427108456"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 12:00:36 -0700
Subject: [PATCH] dmaengine: idxd: remove MSIX masking for interrupt handlers
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Date:   Tue, 20 Apr 2021 12:00:34 -0700
Message-ID: <161894523436.3210025.1834640110556139277.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Remove interrupt masking and just let the hard irq handler keep
firing for new events. This is less of a performance impact vs
the MMIO readback inside the pci_msi_{mask,unmas}_irq(). Especially
with a loaded system those flushes can be stuck behind large amounts
of MMIO writes to flush. When guest kernel is running on top of VFIO
mdev, mask/unmask causes a vmexit each time and is not desirable.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dma/idxd/idxd.h |    1 -
 drivers/dma/idxd/init.c |    4 ++--
 drivers/dma/idxd/irq.c  |   12 ------------
 3 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index d7185c6bfade..7237f3e15a5e 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -376,7 +376,6 @@ void idxd_wqs_quiesce(struct idxd_device *idxd);
 /* device interrupt control */
 void idxd_msix_perm_setup(struct idxd_device *idxd);
 void idxd_msix_perm_clear(struct idxd_device *idxd);
-irqreturn_t idxd_irq_handler(int vec, void *data);
 irqreturn_t idxd_misc_thread(int vec, void *data);
 irqreturn_t idxd_wq_thread(int irq, void *data);
 void idxd_mask_error_interrupts(struct idxd_device *idxd);
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index e6bfd55e421b..36b33eef5aa2 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -102,7 +102,7 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
 	}
 
 	irq_entry = &idxd->irq_entries[0];
-	rc = request_threaded_irq(irq_entry->vector, idxd_irq_handler, idxd_misc_thread,
+	rc = request_threaded_irq(irq_entry->vector, NULL, idxd_misc_thread,
 				  0, "idxd-misc", irq_entry);
 	if (rc < 0) {
 		dev_err(dev, "Failed to allocate misc interrupt.\n");
@@ -119,7 +119,7 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
 
 		init_llist_head(&idxd->irq_entries[i].pending_llist);
 		INIT_LIST_HEAD(&idxd->irq_entries[i].work_list);
-		rc = request_threaded_irq(irq_entry->vector, idxd_irq_handler,
+		rc = request_threaded_irq(irq_entry->vector, NULL,
 					  idxd_wq_thread, 0, "idxd-portal", irq_entry);
 		if (rc < 0) {
 			dev_err(dev, "Failed to allocate irq %d.\n", irq_entry->vector);
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 43eea5c9cbd4..afee571e0194 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -102,15 +102,6 @@ static int idxd_device_schedule_fault_process(struct idxd_device *idxd,
 	return 0;
 }
 
-irqreturn_t idxd_irq_handler(int vec, void *data)
-{
-	struct idxd_irq_entry *irq_entry = data;
-	struct idxd_device *idxd = irq_entry->idxd;
-
-	idxd_mask_msix_vector(idxd, irq_entry->id);
-	return IRQ_WAKE_THREAD;
-}
-
 static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
 {
 	struct device *dev = &idxd->pdev->dev;
@@ -237,7 +228,6 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
 			iowrite32(cause, idxd->reg_base + IDXD_INTCAUSE_OFFSET);
 	}
 
-	idxd_unmask_msix_vector(idxd, irq_entry->id);
 	return IRQ_HANDLED;
 }
 
@@ -394,8 +384,6 @@ irqreturn_t idxd_wq_thread(int irq, void *data)
 	int processed;
 
 	processed = idxd_desc_process(irq_entry);
-	idxd_unmask_msix_vector(irq_entry->idxd, irq_entry->id);
-
 	if (processed == 0)
 		return IRQ_NONE;
 


