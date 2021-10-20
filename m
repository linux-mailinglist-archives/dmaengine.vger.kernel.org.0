Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FBD4350BC
	for <lists+dmaengine@lfdr.de>; Wed, 20 Oct 2021 18:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhJTQ4F (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Oct 2021 12:56:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:40119 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230493AbhJTQ4E (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 20 Oct 2021 12:56:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="228779566"
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="228779566"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 09:53:48 -0700
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="567628942"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 09:53:47 -0700
Subject: [PATCH 2/7] dmaengine: idxd: int handle management refactoring
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Kevin Tian <kevin.tian@intel.com>, dmaengine@vger.kernel.org
Date:   Wed, 20 Oct 2021 09:53:47 -0700
Message-ID: <163474882718.2608004.12634000793945886851.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <163474864017.2608004.10983485368237365990.stgit@djiang5-desk3.ch.intel.com>
References: <163474864017.2608004.10983485368237365990.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Attach int_handle to irq_entry. This removes the separate management of int
handles and reduces the confusion of interating through int handles that is
off by 1 count.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |    8 ++++
 drivers/dma/idxd/idxd.h   |   10 ++++-
 drivers/dma/idxd/init.c   |   86 ++++++++++++++++++++++++---------------------
 drivers/dma/idxd/submit.c |    6 ++-
 drivers/dma/idxd/sysfs.c  |    1 -
 5 files changed, 64 insertions(+), 47 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index fab412349f7f..f381319615fd 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1206,6 +1206,13 @@ int __drv_enable_wq(struct idxd_wq *wq)
 		goto err;
 	}
 
+	/*
+	 * Device has 1 misc interrupt and N interrupts for descriptor completion. To
+	 * assign WQ to interrupt, we will take the N+1 interrupt since vector 0 is
+	 * for the misc interrupt.
+	 */
+	wq->ie = &idxd->irq_entries[wq->id + 1];
+
 	rc = idxd_wq_enable(wq);
 	if (rc < 0) {
 		dev_dbg(dev, "wq %d enabling failed: %d\n", wq->id, rc);
@@ -1256,6 +1263,7 @@ void __drv_disable_wq(struct idxd_wq *wq)
 	idxd_wq_drain(wq);
 	idxd_wq_reset(wq);
 
+	wq->ie = NULL;
 	wq->client_count = 0;
 }
 
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 3d600f8ee90b..355159d4ee68 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -10,6 +10,7 @@
 #include <linux/cdev.h>
 #include <linux/idr.h>
 #include <linux/pci.h>
+#include <linux/ioasid.h>
 #include <linux/perf_event.h>
 #include <uapi/linux/idxd.h>
 #include "registers.h"
@@ -64,6 +65,7 @@ extern struct idxd_device_driver idxd_drv;
 extern struct idxd_device_driver idxd_dmaengine_drv;
 extern struct idxd_device_driver idxd_user_drv;
 
+#define INVALID_INT_HANDLE	-1
 struct idxd_irq_entry {
 	struct idxd_device *idxd;
 	int id;
@@ -75,6 +77,9 @@ struct idxd_irq_entry {
 	 * and irq thread processing error descriptor.
 	 */
 	spinlock_t list_lock;
+	int int_handle;
+	struct idxd_wq *wq;
+	ioasid_t pasid;
 };
 
 struct idxd_group {
@@ -171,6 +176,7 @@ struct idxd_wq {
 	struct wait_queue_head err_queue;
 	struct idxd_device *idxd;
 	int id;
+	struct idxd_irq_entry *ie;
 	enum idxd_wq_type type;
 	struct idxd_group *group;
 	int client_count;
@@ -266,6 +272,8 @@ struct idxd_device {
 	unsigned int pasid;
 
 	int num_groups;
+	int irq_cnt;
+	bool request_int_handles;
 
 	u32 msix_perm_offset;
 	u32 wqcfg_offset;
@@ -292,8 +300,6 @@ struct idxd_device {
 	struct workqueue_struct *wq;
 	struct work_struct work;
 
-	int *int_handles;
-
 	struct idxd_pmu *idxd_pmu;
 };
 
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index ef549cef8480..bae32a30081d 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -81,6 +81,7 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
 		dev_err(dev, "Not MSI-X interrupt capable.\n");
 		return -ENOSPC;
 	}
+	idxd->irq_cnt = msixcnt;
 
 	rc = pci_alloc_irq_vectors(pdev, msixcnt, msixcnt, PCI_IRQ_MSIX);
 	if (rc != msixcnt) {
@@ -103,7 +104,18 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
 	for (i = 0; i < msixcnt; i++) {
 		idxd->irq_entries[i].id = i;
 		idxd->irq_entries[i].idxd = idxd;
+		/*
+		 * Association of WQ should be assigned starting with irq_entry 1.
+		 * irq_entry 0 is for misc interrupts and has no wq association
+		 */
+		if (i > 0)
+			idxd->irq_entries[i].wq = idxd->wqs[i - 1];
 		idxd->irq_entries[i].vector = pci_irq_vector(pdev, i);
+		idxd->irq_entries[i].int_handle = INVALID_INT_HANDLE;
+		if (device_pasid_enabled(idxd) && i > 0)
+			idxd->irq_entries[i].pasid = idxd->pasid;
+		else
+			idxd->irq_entries[i].pasid = INVALID_IOASID;
 		spin_lock_init(&idxd->irq_entries[i].list_lock);
 	}
 
@@ -135,22 +147,14 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
 		}
 
 		dev_dbg(dev, "Allocated idxd-msix %d for vector %d\n", i, irq_entry->vector);
-		if (idxd->hw.cmd_cap & BIT(IDXD_CMD_REQUEST_INT_HANDLE)) {
-			/*
-			 * The MSIX vector enumeration starts at 1 with vector 0 being the
-			 * misc interrupt that handles non I/O completion events. The
-			 * interrupt handles are for IMS enumeration on guest. The misc
-			 * interrupt vector does not require a handle and therefore we start
-			 * the int_handles at index 0. Since 'i' starts at 1, the first
-			 * int_handles index will be 0.
-			 */
-			rc = idxd_device_request_int_handle(idxd, i, &idxd->int_handles[i - 1],
+		if (idxd->request_int_handles) {
+			rc = idxd_device_request_int_handle(idxd, i, &irq_entry->int_handle,
 							    IDXD_IRQ_MSIX);
 			if (rc < 0) {
 				free_irq(irq_entry->vector, irq_entry);
 				goto err_wq_irqs;
 			}
-			dev_dbg(dev, "int handle requested: %u\n", idxd->int_handles[i - 1]);
+			dev_dbg(dev, "int handle requested: %u\n", irq_entry->int_handle);
 		}
 	}
 
@@ -161,9 +165,15 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
 	while (--i >= 0) {
 		irq_entry = &idxd->irq_entries[i];
 		free_irq(irq_entry->vector, irq_entry);
-		if (i != 0)
-			idxd_device_release_int_handle(idxd,
-						       idxd->int_handles[i], IDXD_IRQ_MSIX);
+		if (irq_entry->int_handle != INVALID_INT_HANDLE) {
+			idxd_device_release_int_handle(idxd, irq_entry->int_handle,
+						       IDXD_IRQ_MSIX);
+			irq_entry->int_handle = INVALID_INT_HANDLE;
+			irq_entry->pasid = INVALID_IOASID;
+		}
+		irq_entry->vector = -1;
+		irq_entry->wq = NULL;
+		irq_entry->idxd = NULL;
 	}
  err_misc_irq:
 	/* Disable error interrupt generation */
@@ -179,21 +189,19 @@ static void idxd_cleanup_interrupts(struct idxd_device *idxd)
 {
 	struct pci_dev *pdev = idxd->pdev;
 	struct idxd_irq_entry *irq_entry;
-	int i, msixcnt;
-
-	msixcnt = pci_msix_vec_count(pdev);
-	if (msixcnt <= 0)
-		return;
-
-	irq_entry = &idxd->irq_entries[0];
-	free_irq(irq_entry->vector, irq_entry);
-
-	for (i = 1; i < msixcnt; i++) {
+	int i;
 
+	for (i = 0; i < idxd->irq_cnt; i++) {
 		irq_entry = &idxd->irq_entries[i];
-		if (idxd->hw.cmd_cap & BIT(IDXD_CMD_RELEASE_INT_HANDLE))
-			idxd_device_release_int_handle(idxd, idxd->int_handles[i],
+		if (irq_entry->int_handle != INVALID_INT_HANDLE) {
+			idxd_device_release_int_handle(idxd, irq_entry->int_handle,
 						       IDXD_IRQ_MSIX);
+			irq_entry->int_handle = INVALID_INT_HANDLE;
+			irq_entry->pasid = INVALID_IOASID;
+		}
+		irq_entry->vector = -1;
+		irq_entry->wq = NULL;
+		irq_entry->idxd = NULL;
 		free_irq(irq_entry->vector, irq_entry);
 	}
 
@@ -379,13 +387,6 @@ static int idxd_setup_internals(struct idxd_device *idxd)
 
 	init_waitqueue_head(&idxd->cmd_waitq);
 
-	if (idxd->hw.cmd_cap & BIT(IDXD_CMD_REQUEST_INT_HANDLE)) {
-		idxd->int_handles = kcalloc_node(idxd->max_wqs, sizeof(int), GFP_KERNEL,
-						 dev_to_node(dev));
-		if (!idxd->int_handles)
-			return -ENOMEM;
-	}
-
 	rc = idxd_setup_wqs(idxd);
 	if (rc < 0)
 		goto err_wqs;
@@ -416,7 +417,6 @@ static int idxd_setup_internals(struct idxd_device *idxd)
 	for (i = 0; i < idxd->max_wqs; i++)
 		put_device(wq_confdev(idxd->wqs[i]));
  err_wqs:
-	kfree(idxd->int_handles);
 	return rc;
 }
 
@@ -451,6 +451,10 @@ static void idxd_read_caps(struct idxd_device *idxd)
 		dev_dbg(dev, "cmd_cap: %#x\n", idxd->hw.cmd_cap);
 	}
 
+	/* reading command capabilities */
+	if (idxd->hw.cmd_cap & BIT(IDXD_CMD_REQUEST_INT_HANDLE))
+		idxd->request_int_handles = true;
+
 	idxd->max_xfer_bytes = 1ULL << idxd->hw.gen_cap.max_xfer_shift;
 	dev_dbg(dev, "max xfer size: %llu bytes\n", idxd->max_xfer_bytes);
 	idxd->max_batch_size = 1U << idxd->hw.gen_cap.max_batch_shift;
@@ -748,15 +752,15 @@ static void idxd_release_int_handles(struct idxd_device *idxd)
 	struct device *dev = &idxd->pdev->dev;
 	int i, rc;
 
-	for (i = 0; i < idxd->num_wq_irqs; i++) {
-		if (idxd->hw.cmd_cap & BIT(IDXD_CMD_RELEASE_INT_HANDLE)) {
-			rc = idxd_device_release_int_handle(idxd, idxd->int_handles[i],
-							    IDXD_IRQ_MSIX);
+	for (i = 1; i < idxd->irq_cnt; i++) {
+		struct idxd_irq_entry *ie = &idxd->irq_entries[i];
+
+		if (ie->int_handle != INVALID_INT_HANDLE) {
+			rc = idxd_device_release_int_handle(idxd, ie->int_handle, IDXD_IRQ_MSIX);
 			if (rc < 0)
-				dev_warn(dev, "irq handle %d release failed\n",
-					 idxd->int_handles[i]);
+				dev_warn(dev, "irq handle %d release failed\n", ie->int_handle);
 			else
-				dev_dbg(dev, "int handle requested: %u\n", idxd->int_handles[i]);
+				dev_dbg(dev, "int handle released: %u\n", ie->int_handle);
 		}
 	}
 }
diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
index ea11809dbb32..d4688f369bc2 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -25,10 +25,10 @@ static struct idxd_desc *__get_desc(struct idxd_wq *wq, int idx, int cpu)
 	 * On host, MSIX vecotr 0 is used for misc interrupt. Therefore when we match
 	 * vector 1:1 to the WQ id, we need to add 1
 	 */
-	if (!idxd->int_handles)
+	if (wq->ie->int_handle == INVALID_INT_HANDLE)
 		desc->hw->int_handle = wq->id + 1;
 	else
-		desc->hw->int_handle = idxd->int_handles[wq->id];
+		desc->hw->int_handle = wq->ie->int_handle;
 
 	return desc;
 }
@@ -159,7 +159,7 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 	 * that we designated the descriptor to.
 	 */
 	if (desc->hw->flags & IDXD_OP_FLAG_RCI) {
-		ie = &idxd->irq_entries[wq->id + 1];
+		ie = wq->ie;
 		llist_add(&desc->llnode, &ie->pending_llist);
 	}
 
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index a9025be940db..90857e776273 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1269,7 +1269,6 @@ static void idxd_conf_device_release(struct device *dev)
 	kfree(idxd->wqs);
 	kfree(idxd->engines);
 	kfree(idxd->irq_entries);
-	kfree(idxd->int_handles);
 	ida_free(&idxd_ida, idxd->id);
 	kfree(idxd);
 }


