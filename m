Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E934350C0
	for <lists+dmaengine@lfdr.de>; Wed, 20 Oct 2021 18:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhJTQ4b (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Oct 2021 12:56:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:31701 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhJTQ4b (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 20 Oct 2021 12:56:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="227600290"
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="227600290"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 09:54:16 -0700
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="532752616"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 09:54:15 -0700
Subject: [PATCH 7/7] dmaengine: idxd: handle interrupt handle revoked event
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Kevin Tian <kevin.tian@intel.com>, dmaengine@vger.kernel.org
Date:   Wed, 20 Oct 2021 09:54:15 -0700
Message-ID: <163474885533.2608004.13540888939571807207.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <163474864017.2608004.10983485368237365990.stgit@djiang5-desk3.ch.intel.com>
References: <163474864017.2608004.10983485368237365990.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

"Interrupt handle revoked" is an event that happens when the driver is
running on a guest kernel and the VM is migrated to a new machine.
The device will trigger an interrupt that signals to the guest driver
that the interrupt handles need to be replaced.

The misc irq thread function calls a helper function to handle the
event. The function uses the WQ percpu_ref to quiesce the kernel
submissions. It then replaces the interrupt handles by requesting
interrupt handle command for each I/O MSIX vector. Once the handle is
updated, the driver will unblock the submission path to allow new
submissions.

The submitter will attempt to acquire a percpu_ref before submission. When
the request fails, it will wait on the wq_resurrect 'completion'.

The driver does anticipate the possibility of descriptors being submitted
before the WQ percpu_ref is killed. If a descriptor has already been
submitted, it will return with incorrect interrupt handle status. The
descriptor will be re-submitted with the new interrupt handle on the
completion path. For descriptors with incorrect interrupt handles,
completion interrupt won't be triggered.

At the completion of the interrupt handle refresh, the handling function
will call idxd_int_handle_refresh_drain() to issue drain descriptors to
each of the wq with associated interrupt handle. The drain descriptor will have
interrupt request set but without completion record. This will ensure all
descriptors with incorrect interrupt completion handle get drained and
a completion interrupt is triggered for the guest driver to process them.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Co-Developed-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c    |    6 ++
 drivers/dma/idxd/idxd.h      |    1 
 drivers/dma/idxd/init.c      |    1 
 drivers/dma/idxd/irq.c       |  137 ++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/idxd/registers.h |    1 
 drivers/dma/idxd/submit.c    |   10 ++-
 6 files changed, 152 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 943e9967627b..1dc5245107df 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -404,17 +404,21 @@ int idxd_wq_init_percpu_ref(struct idxd_wq *wq)
 	int rc;
 
 	memset(&wq->wq_active, 0, sizeof(wq->wq_active));
-	rc = percpu_ref_init(&wq->wq_active, idxd_wq_ref_release, 0, GFP_KERNEL);
+	rc = percpu_ref_init(&wq->wq_active, idxd_wq_ref_release,
+			     PERCPU_REF_ALLOW_REINIT, GFP_KERNEL);
 	if (rc < 0)
 		return rc;
 	reinit_completion(&wq->wq_dead);
+	reinit_completion(&wq->wq_resurrect);
 	return 0;
 }
 
 void __idxd_wq_quiesce(struct idxd_wq *wq)
 {
 	lockdep_assert_held(&wq->wq_lock);
+	reinit_completion(&wq->wq_resurrect);
 	percpu_ref_kill(&wq->wq_active);
+	complete_all(&wq->wq_resurrect);
 	wait_for_completion(&wq->wq_dead);
 }
 
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 82c4915f58a2..51e79201636c 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -171,6 +171,7 @@ struct idxd_wq {
 	u32 portal_offset;
 	struct percpu_ref wq_active;
 	struct completion wq_dead;
+	struct completion wq_resurrect;
 	struct idxd_dev idxd_dev;
 	struct idxd_cdev *idxd_cdev;
 	struct wait_queue_head err_queue;
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index bae32a30081d..4a34121472ab 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -245,6 +245,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		mutex_init(&wq->wq_lock);
 		init_waitqueue_head(&wq->err_queue);
 		init_completion(&wq->wq_dead);
+		init_completion(&wq->wq_resurrect);
 		wq->max_xfer_bytes = idxd->max_xfer_bytes;
 		wq->max_batch_size = idxd->max_batch_size;
 		wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 26fa871934e6..76718e6a9c5c 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -6,6 +6,7 @@
 #include <linux/pci.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/dmaengine.h>
+#include <linux/delay.h>
 #include <uapi/linux/idxd.h>
 #include "../dmaengine.h"
 #include "idxd.h"
@@ -27,6 +28,11 @@ struct idxd_resubmit {
 	struct idxd_desc *desc;
 };
 
+struct idxd_int_handle_revoke {
+	struct work_struct work;
+	struct idxd_device *idxd;
+};
+
 static void idxd_device_reinit(struct work_struct *work)
 {
 	struct idxd_device *idxd = container_of(work, struct idxd_device, work);
@@ -101,6 +107,120 @@ static void idxd_int_handle_revoke_drain(struct idxd_irq_entry *ie)
 	}
 }
 
+static void idxd_abort_invalid_int_handle_descs(struct idxd_irq_entry *ie)
+{
+	LIST_HEAD(flist);
+	struct idxd_desc *d, *t;
+	struct llist_node *head;
+
+	spin_lock(&ie->list_lock);
+	head = llist_del_all(&ie->pending_llist);
+	if (head) {
+		llist_for_each_entry_safe(d, t, head, llnode)
+			list_add_tail(&d->list, &ie->work_list);
+	}
+
+	list_for_each_entry_safe(d, t, &ie->work_list, list) {
+		if (d->completion->status == DSA_COMP_INT_HANDLE_INVAL)
+			list_move_tail(&d->list, &flist);
+	}
+	spin_unlock(&ie->list_lock);
+
+	list_for_each_entry_safe(d, t, &flist, list) {
+		list_del(&d->list);
+		idxd_dma_complete_txd(d, IDXD_COMPLETE_ABORT, true);
+	}
+}
+
+static void idxd_int_handle_revoke(struct work_struct *work)
+{
+	struct idxd_int_handle_revoke *revoke =
+		container_of(work, struct idxd_int_handle_revoke, work);
+	struct idxd_device *idxd = revoke->idxd;
+	struct pci_dev *pdev = idxd->pdev;
+	struct device *dev = &pdev->dev;
+	int i, new_handle, rc;
+
+	if (!idxd->request_int_handles) {
+		kfree(revoke);
+		dev_warn(dev, "Unexpected int handle refresh interrupt.\n");
+		return;
+	}
+
+	/*
+	 * The loop attempts to acquire new interrupt handle for all interrupt
+	 * vectors that supports a handle. If a new interrupt handle is acquired and the
+	 * wq is kernel type, the driver will kill the percpu_ref to pause all
+	 * ongoing descriptor submissions. The interrupt handle is then changed.
+	 * After change, the percpu_ref is revived and all the pending submissions
+	 * are woken to try again. A drain is sent to for the interrupt handle
+	 * at the end to make sure all invalid int handle descriptors are processed.
+	 */
+	for (i = 1; i < idxd->irq_cnt; i++) {
+		struct idxd_irq_entry *ie = &idxd->irq_entries[i];
+		struct idxd_wq *wq = ie->wq;
+
+		rc = idxd_device_request_int_handle(idxd, i, &new_handle, IDXD_IRQ_MSIX);
+		if (rc < 0) {
+			dev_warn(dev, "get int handle %d failed: %d\n", i, rc);
+			/*
+			 * Failed to acquire new interrupt handle. Kill the WQ
+			 * and release all the pending submitters. The submitters will
+			 * get error return code and handle appropriately.
+			 */
+			ie->int_handle = INVALID_INT_HANDLE;
+			idxd_wq_quiesce(wq);
+			idxd_abort_invalid_int_handle_descs(ie);
+			continue;
+		}
+
+		/* No change in interrupt handle, nothing needs to be done */
+		if (ie->int_handle == new_handle)
+			continue;
+
+		if (wq->state != IDXD_WQ_ENABLED || wq->type != IDXD_WQT_KERNEL) {
+			/*
+			 * All the MSIX interrupts are allocated at once during probe.
+			 * Therefore we need to update all interrupts even if the WQ
+			 * isn't supporting interrupt operations.
+			 */
+			ie->int_handle = new_handle;
+			continue;
+		}
+
+		mutex_lock(&wq->wq_lock);
+		reinit_completion(&wq->wq_resurrect);
+
+		/* Kill percpu_ref to pause additional descriptor submissions */
+		percpu_ref_kill(&wq->wq_active);
+
+		/* Wait for all submitters quiesce before we change interrupt handle */
+		wait_for_completion(&wq->wq_dead);
+
+		ie->int_handle = new_handle;
+
+		/* Revive percpu ref and wake up all the waiting submitters */
+		percpu_ref_reinit(&wq->wq_active);
+		complete_all(&wq->wq_resurrect);
+		mutex_unlock(&wq->wq_lock);
+
+		/*
+		 * The delay here is to wait for all possible MOVDIR64B that
+		 * are issued before percpu_ref_kill() has happened to have
+		 * reached the PCIe domain before the drain is issued. The driver
+		 * needs to ensure that the drain descriptor issued does not pass
+		 * all the other issued descriptors that contain the invalid
+		 * interrupt handle in order to ensure that the drain descriptor
+		 * interrupt will allow the cleanup of all the descriptors with
+		 * invalid interrupt handle.
+		 */
+		if (wq_dedicated(wq))
+			udelay(100);
+		idxd_int_handle_revoke_drain(ie);
+	}
+	kfree(revoke);
+}
+
 static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
 {
 	struct device *dev = &idxd->pdev->dev;
@@ -147,6 +267,23 @@ static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
 		err = true;
 	}
 
+	if (cause & IDXD_INTC_INT_HANDLE_REVOKED) {
+		struct idxd_int_handle_revoke *revoke;
+
+		val |= IDXD_INTC_INT_HANDLE_REVOKED;
+
+		revoke = kzalloc(sizeof(*revoke), GFP_ATOMIC);
+		if (revoke) {
+			revoke->idxd = idxd;
+			INIT_WORK(&revoke->work, idxd_int_handle_revoke);
+			queue_work(idxd->wq, &revoke->work);
+
+		} else {
+			dev_err(dev, "Failed to allocate work for int handle revoke\n");
+			idxd_wqs_quiesce(idxd);
+		}
+	}
+
 	if (cause & IDXD_INTC_CMD) {
 		val |= IDXD_INTC_CMD;
 		complete(idxd->cmd_done);
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index 262c8220adbd..8e396698c22b 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -158,6 +158,7 @@ enum idxd_device_reset_type {
 #define IDXD_INTC_OCCUPY			0x04
 #define IDXD_INTC_PERFMON_OVFL		0x08
 #define IDXD_INTC_HALT_STATE		0x10
+#define IDXD_INTC_INT_HANDLE_REVOKED	0x80000000
 
 #define IDXD_CMD_OFFSET			0xa0
 union idxd_command_reg {
diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
index df02c5c814e7..776fa81db61d 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -127,14 +127,18 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 {
 	struct idxd_device *idxd = wq->idxd;
 	struct idxd_irq_entry *ie = NULL;
+	u32 desc_flags = desc->hw->flags;
 	void __iomem *portal;
 	int rc;
 
 	if (idxd->state != IDXD_DEV_ENABLED)
 		return -EIO;
 
-	if (!percpu_ref_tryget_live(&wq->wq_active))
-		return -ENXIO;
+	if (!percpu_ref_tryget_live(&wq->wq_active)) {
+		wait_for_completion(&wq->wq_resurrect);
+		if (!percpu_ref_tryget_live(&wq->wq_active))
+			return -ENXIO;
+	}
 
 	portal = idxd_wq_portal_addr(wq);
 
@@ -149,7 +153,7 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 	 * Pending the descriptor to the lockless list for the irq_entry
 	 * that we designated the descriptor to.
 	 */
-	if (desc->hw->flags & IDXD_OP_FLAG_RCI) {
+	if (desc_flags & IDXD_OP_FLAG_RCI) {
 		ie = wq->ie;
 		if (ie->int_handle == INVALID_INT_HANDLE)
 			desc->hw->int_handle = ie->id;


