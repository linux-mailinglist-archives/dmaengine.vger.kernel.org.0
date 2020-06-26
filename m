Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFBA20B7D5
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2020 20:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725280AbgFZSLY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Jun 2020 14:11:24 -0400
Received: from mga09.intel.com ([134.134.136.24]:21778 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgFZSLX (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 26 Jun 2020 14:11:23 -0400
IronPort-SDR: O0380PCi3nVn8MzUQmSJXCe902lDW1a4gforep/s2xAp59XLwSpvQ9hYPHXuqSEuyu+fOiOwem
 dgolh79wO0LA==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="146935795"
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="146935795"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 11:11:19 -0700
IronPort-SDR: T9RYCq2rgeuGqfP7A/p4hdbFRJs0sUTPpROmLT+KE+RAaP3if77Entbx9xdEjZrSHgi8Mn6rb9
 R+ZerfUqqUFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="312393035"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jun 2020 11:11:18 -0700
Subject: [PATCH v2] dmaengine: idxd: add work queue drain support
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Date:   Fri, 26 Jun 2020 11:11:18 -0700
Message-ID: <159319502515.69593.13451647706946040301.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add wq drain support. When a wq is being released, it needs to wait for
all in-flight operation to complete.  A device control function
idxd_wq_drain() has been added to facilitate this. A wq drain call
is added to the char dev on release to make sure all user operations are
complete. A wq drain is also added before the wq is being disabled.

A drain command can take an unpredictable period of time. Interrupt support
for device commands is added to allow waiting on the command to
finish. If a previous command is in progress, the new submitter can block
until the current command is finished before proceeding. The interrupt
based submission will submit the command and then wait until a command
completion interrupt happens to complete. All commands are moved to the
interrupt based command submission except for the device reset during
probe, which will be polled.

Fixes: 42d279f9137a ("dmaengine: idxd: add char driver to expose submission portal to userland")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---

- Removed excessive debug output (Vinod)
- Rebased to dmaengine next tree

 drivers/dma/idxd/cdev.c   |    3 +
 drivers/dma/idxd/device.c |  155 ++++++++++++++++++++-------------------------
 drivers/dma/idxd/idxd.h   |   11 ++-
 drivers/dma/idxd/init.c   |   14 ++--
 drivers/dma/idxd/irq.c    |   41 ++++++------
 drivers/dma/idxd/sysfs.c  |   20 +-----
 6 files changed, 112 insertions(+), 132 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index ff49847e37a8..f9fc58966207 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -104,6 +104,9 @@ static int idxd_cdev_release(struct inode *node, struct file *filep)
 	dev_dbg(dev, "%s called\n", __func__);
 	filep->private_data = NULL;
 
+	/* Wait for in-flight operations to complete. */
+	idxd_wq_drain(wq);
+
 	kfree(ctx);
 	idxd_wq_put(wq);
 	return 0;
diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 8f05b29e7891..1d8d64508a28 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -11,8 +11,8 @@
 #include "idxd.h"
 #include "registers.h"
 
-static int idxd_cmd_wait(struct idxd_device *idxd, u32 *status, int timeout);
-static int idxd_cmd_send(struct idxd_device *idxd, int cmd_code, u32 operand);
+static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
+			  u32 *status);
 
 /* Interrupt control bits */
 int idxd_mask_msix_vector(struct idxd_device *idxd, int vec_id)
@@ -233,21 +233,13 @@ int idxd_wq_enable(struct idxd_wq *wq)
 	struct idxd_device *idxd = wq->idxd;
 	struct device *dev = &idxd->pdev->dev;
 	u32 status;
-	int rc;
-
-	lockdep_assert_held(&idxd->dev_lock);
 
 	if (wq->state == IDXD_WQ_ENABLED) {
 		dev_dbg(dev, "WQ %d already enabled\n", wq->id);
 		return -ENXIO;
 	}
 
-	rc = idxd_cmd_send(idxd, IDXD_CMD_ENABLE_WQ, wq->id);
-	if (rc < 0)
-		return rc;
-	rc = idxd_cmd_wait(idxd, &status, IDXD_REG_TIMEOUT);
-	if (rc < 0)
-		return rc;
+	idxd_cmd_exec(idxd, IDXD_CMD_ENABLE_WQ, wq->id, &status);
 
 	if (status != IDXD_CMDSTS_SUCCESS &&
 	    status != IDXD_CMDSTS_ERR_WQ_ENABLED) {
@@ -265,9 +257,7 @@ int idxd_wq_disable(struct idxd_wq *wq)
 	struct idxd_device *idxd = wq->idxd;
 	struct device *dev = &idxd->pdev->dev;
 	u32 status, operand;
-	int rc;
 
-	lockdep_assert_held(&idxd->dev_lock);
 	dev_dbg(dev, "Disabling WQ %d\n", wq->id);
 
 	if (wq->state != IDXD_WQ_ENABLED) {
@@ -276,12 +266,7 @@ int idxd_wq_disable(struct idxd_wq *wq)
 	}
 
 	operand = BIT(wq->id % 16) | ((wq->id / 16) << 16);
-	rc = idxd_cmd_send(idxd, IDXD_CMD_DISABLE_WQ, operand);
-	if (rc < 0)
-		return rc;
-	rc = idxd_cmd_wait(idxd, &status, IDXD_REG_TIMEOUT);
-	if (rc < 0)
-		return rc;
+	idxd_cmd_exec(idxd, IDXD_CMD_DISABLE_WQ, operand, &status);
 
 	if (status != IDXD_CMDSTS_SUCCESS) {
 		dev_dbg(dev, "WQ disable failed: %#x\n", status);
@@ -293,6 +278,22 @@ int idxd_wq_disable(struct idxd_wq *wq)
 	return 0;
 }
 
+void idxd_wq_drain(struct idxd_wq *wq)
+{
+	struct idxd_device *idxd = wq->idxd;
+	struct device *dev = &idxd->pdev->dev;
+	u32 operand;
+
+	if (wq->state != IDXD_WQ_ENABLED) {
+		dev_dbg(dev, "WQ %d in wrong state: %d\n", wq->id, wq->state);
+		return;
+	}
+
+	dev_dbg(dev, "Draining WQ %d\n", wq->id);
+	operand = BIT(wq->id % 16) | ((wq->id / 16) << 16);
+	idxd_cmd_exec(idxd, IDXD_CMD_DRAIN_WQ, operand, NULL);
+}
+
 int idxd_wq_map_portal(struct idxd_wq *wq)
 {
 	struct idxd_device *idxd = wq->idxd;
@@ -330,66 +331,79 @@ static inline bool idxd_is_enabled(struct idxd_device *idxd)
 	return false;
 }
 
-static int idxd_cmd_wait(struct idxd_device *idxd, u32 *status, int timeout)
+/*
+ * This is function is only used for reset during probe and will
+ * poll for completion. Once the device is setup with interrupts,
+ * all commands will be done via interrupt completion.
+ */
+void idxd_device_init_reset(struct idxd_device *idxd)
 {
-	u32 sts, to = timeout;
-
-	lockdep_assert_held(&idxd->dev_lock);
-	sts = ioread32(idxd->reg_base + IDXD_CMDSTS_OFFSET);
-	while (sts & IDXD_CMDSTS_ACTIVE && --to) {
-		cpu_relax();
-		sts = ioread32(idxd->reg_base + IDXD_CMDSTS_OFFSET);
-	}
+	struct device *dev = &idxd->pdev->dev;
+	union idxd_command_reg cmd;
+	unsigned long flags;
 
-	if (to == 0 && sts & IDXD_CMDSTS_ACTIVE) {
-		dev_warn(&idxd->pdev->dev, "%s timed out!\n", __func__);
-		*status = 0;
-		return -EBUSY;
-	}
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.cmd = IDXD_CMD_RESET_DEVICE;
+	dev_dbg(dev, "%s: sending reset for init.\n", __func__);
+	spin_lock_irqsave(&idxd->dev_lock, flags);
+	iowrite32(cmd.bits, idxd->reg_base + IDXD_CMD_OFFSET);
 
-	*status = sts;
-	return 0;
+	while (ioread32(idxd->reg_base + IDXD_CMDSTS_OFFSET) &
+	       IDXD_CMDSTS_ACTIVE)
+		cpu_relax();
+	spin_unlock_irqrestore(&idxd->dev_lock, flags);
 }
 
-static int idxd_cmd_send(struct idxd_device *idxd, int cmd_code, u32 operand)
+static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
+			  u32 *status)
 {
 	union idxd_command_reg cmd;
-	int rc;
-	u32 status;
-
-	lockdep_assert_held(&idxd->dev_lock);
-	rc = idxd_cmd_wait(idxd, &status, IDXD_REG_TIMEOUT);
-	if (rc < 0)
-		return rc;
+	DECLARE_COMPLETION_ONSTACK(done);
+	unsigned long flags;
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.cmd = cmd_code;
 	cmd.operand = operand;
+	cmd.int_req = 1;
+
+	spin_lock_irqsave(&idxd->dev_lock, flags);
+	wait_event_lock_irq(idxd->cmd_waitq,
+			    !test_bit(IDXD_FLAG_CMD_RUNNING, &idxd->flags),
+			    idxd->dev_lock);
+
 	dev_dbg(&idxd->pdev->dev, "%s: sending cmd: %#x op: %#x\n",
 		__func__, cmd_code, operand);
+
+	__set_bit(IDXD_FLAG_CMD_RUNNING, &idxd->flags);
+	idxd->cmd_done = &done;
 	iowrite32(cmd.bits, idxd->reg_base + IDXD_CMD_OFFSET);
 
-	return 0;
+	/*
+	 * After command submitted, release lock and go to sleep until
+	 * the command completes via interrupt.
+	 */
+	spin_unlock_irqrestore(&idxd->dev_lock, flags);
+	wait_for_completion(&done);
+	spin_lock_irqsave(&idxd->dev_lock, flags);
+	if (status)
+		*status = ioread32(idxd->reg_base + IDXD_CMDSTS_OFFSET);
+	__clear_bit(IDXD_FLAG_CMD_RUNNING, &idxd->flags);
+	/* Wake up other pending commands */
+	wake_up(&idxd->cmd_waitq);
+	spin_unlock_irqrestore(&idxd->dev_lock, flags);
 }
 
 int idxd_device_enable(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
-	int rc;
 	u32 status;
 
-	lockdep_assert_held(&idxd->dev_lock);
 	if (idxd_is_enabled(idxd)) {
 		dev_dbg(dev, "Device already enabled\n");
 		return -ENXIO;
 	}
 
-	rc = idxd_cmd_send(idxd, IDXD_CMD_ENABLE_DEVICE, 0);
-	if (rc < 0)
-		return rc;
-	rc = idxd_cmd_wait(idxd, &status, IDXD_REG_TIMEOUT);
-	if (rc < 0)
-		return rc;
+	idxd_cmd_exec(idxd, IDXD_CMD_ENABLE_DEVICE, 0, &status);
 
 	/* If the command is successful or if the device was enabled */
 	if (status != IDXD_CMDSTS_SUCCESS &&
@@ -405,58 +419,29 @@ int idxd_device_enable(struct idxd_device *idxd)
 int idxd_device_disable(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
-	int rc;
 	u32 status;
 
-	lockdep_assert_held(&idxd->dev_lock);
 	if (!idxd_is_enabled(idxd)) {
 		dev_dbg(dev, "Device is not enabled\n");
 		return 0;
 	}
 
-	rc = idxd_cmd_send(idxd, IDXD_CMD_DISABLE_DEVICE, 0);
-	if (rc < 0)
-		return rc;
-	rc = idxd_cmd_wait(idxd, &status, IDXD_REG_TIMEOUT);
-	if (rc < 0)
-		return rc;
+	idxd_cmd_exec(idxd, IDXD_CMD_DISABLE_DEVICE, 0, &status);
 
 	/* If the command is successful or if the device was disabled */
 	if (status != IDXD_CMDSTS_SUCCESS &&
 	    !(status & IDXD_CMDSTS_ERR_DIS_DEV_EN)) {
 		dev_dbg(dev, "%s: err_code: %#x\n", __func__, status);
-		rc = -ENXIO;
-		return rc;
+		return -ENXIO;
 	}
 
 	idxd->state = IDXD_DEV_CONF_READY;
 	return 0;
 }
 
-int __idxd_device_reset(struct idxd_device *idxd)
-{
-	u32 status;
-	int rc;
-
-	rc = idxd_cmd_send(idxd, IDXD_CMD_RESET_DEVICE, 0);
-	if (rc < 0)
-		return rc;
-	rc = idxd_cmd_wait(idxd, &status, IDXD_REG_TIMEOUT);
-	if (rc < 0)
-		return rc;
-
-	return 0;
-}
-
-int idxd_device_reset(struct idxd_device *idxd)
+void idxd_device_reset(struct idxd_device *idxd)
 {
-	unsigned long flags;
-	int rc;
-
-	spin_lock_irqsave(&idxd->dev_lock, flags);
-	rc = __idxd_device_reset(idxd);
-	spin_unlock_irqrestore(&idxd->dev_lock, flags);
-	return rc;
+	idxd_cmd_exec(idxd, IDXD_CMD_RESET_DEVICE, 0, NULL);
 }
 
 /* Device configuration bits */
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index b03a754918ef..83214e902dd2 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -142,6 +142,7 @@ enum idxd_device_state {
 
 enum idxd_device_flag {
 	IDXD_FLAG_CONFIGURABLE = 0,
+	IDXD_FLAG_CMD_RUNNING,
 };
 
 struct idxd_device {
@@ -158,6 +159,7 @@ struct idxd_device {
 	void __iomem *reg_base;
 
 	spinlock_t dev_lock;	/* spinlock for device */
+	struct completion *cmd_done;
 	struct idxd_group *groups;
 	struct idxd_wq *wqs;
 	struct idxd_engine *engines;
@@ -180,12 +182,14 @@ struct idxd_device {
 	int nr_tokens;		/* non-reserved tokens */
 
 	union sw_err_reg sw_err;
-
+	wait_queue_head_t cmd_waitq;
 	struct msix_entry *msix_entries;
 	int num_wq_irqs;
 	struct idxd_irq_entry *irq_entries;
 
 	struct dma_device dma_dev;
+	struct workqueue_struct *wq;
+	struct work_struct work;
 };
 
 /* IDXD software descriptor */
@@ -273,10 +277,10 @@ int idxd_mask_msix_vector(struct idxd_device *idxd, int vec_id);
 int idxd_unmask_msix_vector(struct idxd_device *idxd, int vec_id);
 
 /* device control */
+void idxd_device_init_reset(struct idxd_device *idxd);
 int idxd_device_enable(struct idxd_device *idxd);
 int idxd_device_disable(struct idxd_device *idxd);
-int idxd_device_reset(struct idxd_device *idxd);
-int __idxd_device_reset(struct idxd_device *idxd);
+void idxd_device_reset(struct idxd_device *idxd);
 void idxd_device_cleanup(struct idxd_device *idxd);
 int idxd_device_config(struct idxd_device *idxd);
 void idxd_device_wqs_clear_state(struct idxd_device *idxd);
@@ -286,6 +290,7 @@ int idxd_wq_alloc_resources(struct idxd_wq *wq);
 void idxd_wq_free_resources(struct idxd_wq *wq);
 int idxd_wq_enable(struct idxd_wq *wq);
 int idxd_wq_disable(struct idxd_wq *wq);
+void idxd_wq_drain(struct idxd_wq *wq);
 int idxd_wq_map_portal(struct idxd_wq *wq);
 void idxd_wq_unmap_portal(struct idxd_wq *wq);
 
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index b69839a8ac2c..c7c61974f20f 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -146,6 +146,7 @@ static int idxd_setup_internals(struct idxd_device *idxd)
 	struct device *dev = &idxd->pdev->dev;
 	int i;
 
+	init_waitqueue_head(&idxd->cmd_waitq);
 	idxd->groups = devm_kcalloc(dev, idxd->max_groups,
 				    sizeof(struct idxd_group), GFP_KERNEL);
 	if (!idxd->groups)
@@ -182,6 +183,10 @@ static int idxd_setup_internals(struct idxd_device *idxd)
 		idxd->engines[i].id = i;
 	}
 
+	idxd->wq = create_workqueue(dev_name(dev));
+	if (!idxd->wq)
+		return -ENOMEM;
+
 	return 0;
 }
 
@@ -277,9 +282,7 @@ static int idxd_probe(struct idxd_device *idxd)
 	int rc;
 
 	dev_dbg(dev, "%s entered and resetting device\n", __func__);
-	rc = idxd_device_reset(idxd);
-	if (rc < 0)
-		return rc;
+	idxd_device_init_reset(idxd);
 	dev_dbg(dev, "IDXD reset complete\n");
 
 	idxd_read_caps(idxd);
@@ -414,11 +417,8 @@ static void idxd_shutdown(struct pci_dev *pdev)
 	int rc, i;
 	struct idxd_irq_entry *irq_entry;
 	int msixcnt = pci_msix_vec_count(pdev);
-	unsigned long flags;
 
-	spin_lock_irqsave(&idxd->dev_lock, flags);
 	rc = idxd_device_disable(idxd);
-	spin_unlock_irqrestore(&idxd->dev_lock, flags);
 	if (rc)
 		dev_err(&pdev->dev, "Disabling device failed\n");
 
@@ -434,6 +434,8 @@ static void idxd_shutdown(struct pci_dev *pdev)
 		idxd_flush_pending_llist(irq_entry);
 		idxd_flush_work_list(irq_entry);
 	}
+
+	destroy_workqueue(idxd->wq);
 }
 
 static void idxd_remove(struct pci_dev *pdev)
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 6510791b9921..6052765ca3c8 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -23,16 +23,13 @@ void idxd_device_wqs_clear_state(struct idxd_device *idxd)
 	}
 }
 
-static int idxd_restart(struct idxd_device *idxd)
+static void idxd_device_reinit(struct work_struct *work)
 {
-	int i, rc;
-
-	lockdep_assert_held(&idxd->dev_lock);
-
-	rc = __idxd_device_reset(idxd);
-	if (rc < 0)
-		goto out;
+	struct idxd_device *idxd = container_of(work, struct idxd_device, work);
+	struct device *dev = &idxd->pdev->dev;
+	int rc, i;
 
+	idxd_device_reset(idxd);
 	rc = idxd_device_config(idxd);
 	if (rc < 0)
 		goto out;
@@ -47,19 +44,16 @@ static int idxd_restart(struct idxd_device *idxd)
 		if (wq->state == IDXD_WQ_ENABLED) {
 			rc = idxd_wq_enable(wq);
 			if (rc < 0) {
-				dev_warn(&idxd->pdev->dev,
-					 "Unable to re-enable wq %s\n",
+				dev_warn(dev, "Unable to re-enable wq %s\n",
 					 dev_name(&wq->conf_dev));
 			}
 		}
 	}
 
-	return 0;
+	return;
 
  out:
 	idxd_device_wqs_clear_state(idxd);
-	idxd->state = IDXD_DEV_HALTED;
-	return rc;
 }
 
 irqreturn_t idxd_irq_handler(int vec, void *data)
@@ -78,7 +72,7 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
 	struct device *dev = &idxd->pdev->dev;
 	union gensts_reg gensts;
 	u32 cause, val = 0;
-	int i, rc;
+	int i;
 	bool err = false;
 
 	cause = ioread32(idxd->reg_base + IDXD_INTCAUSE_OFFSET);
@@ -117,8 +111,8 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
 	}
 
 	if (cause & IDXD_INTC_CMD) {
-		/* Driver does use command interrupts */
 		val |= IDXD_INTC_CMD;
+		complete(idxd->cmd_done);
 	}
 
 	if (cause & IDXD_INTC_OCCUPY) {
@@ -145,21 +139,24 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
 
 	gensts.bits = ioread32(idxd->reg_base + IDXD_GENSTATS_OFFSET);
 	if (gensts.state == IDXD_DEVICE_STATE_HALT) {
-		spin_lock_bh(&idxd->dev_lock);
+		idxd->state = IDXD_DEV_HALTED;
 		if (gensts.reset_type == IDXD_DEVICE_RESET_SOFTWARE) {
-			rc = idxd_restart(idxd);
-			if (rc < 0)
-				dev_err(&idxd->pdev->dev,
-					"idxd restart failed, device halt.");
+			/*
+			 * If we need a software reset, we will throw the work
+			 * on a system workqueue in order to allow interrupts
+			 * for the device command completions.
+			 */
+			INIT_WORK(&idxd->work, idxd_device_reinit);
+			queue_work(idxd->wq, &idxd->work);
 		} else {
+			spin_lock_bh(&idxd->dev_lock);
 			idxd_device_wqs_clear_state(idxd);
-			idxd->state = IDXD_DEV_HALTED;
 			dev_err(&idxd->pdev->dev,
 				"idxd halted, need %s.\n",
 				gensts.reset_type == IDXD_DEVICE_RESET_FLR ?
 				"FLR" : "system reset");
+			spin_unlock_bh(&idxd->dev_lock);
 		}
-		spin_unlock_bh(&idxd->dev_lock);
 	}
 
 	idxd_unmask_msix_vector(idxd, irq_entry->id);
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 052dae5d6ddd..6f0711a822a1 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -118,12 +118,11 @@ static int idxd_config_bus_probe(struct device *dev)
 		if (!try_module_get(THIS_MODULE))
 			return -ENXIO;
 
-		spin_lock_irqsave(&idxd->dev_lock, flags);
-
 		/* Perform IDXD configuration and enabling */
+		spin_lock_irqsave(&idxd->dev_lock, flags);
 		rc = idxd_device_config(idxd);
+		spin_unlock_irqrestore(&idxd->dev_lock, flags);
 		if (rc < 0) {
-			spin_unlock_irqrestore(&idxd->dev_lock, flags);
 			module_put(THIS_MODULE);
 			dev_warn(dev, "Device config failed: %d\n", rc);
 			return rc;
@@ -132,18 +131,15 @@ static int idxd_config_bus_probe(struct device *dev)
 		/* start device */
 		rc = idxd_device_enable(idxd);
 		if (rc < 0) {
-			spin_unlock_irqrestore(&idxd->dev_lock, flags);
 			module_put(THIS_MODULE);
 			dev_warn(dev, "Device enable failed: %d\n", rc);
 			return rc;
 		}
 
-		spin_unlock_irqrestore(&idxd->dev_lock, flags);
 		dev_info(dev, "Device %s enabled\n", dev_name(dev));
 
 		rc = idxd_register_dma_device(idxd);
 		if (rc < 0) {
-			spin_unlock_irqrestore(&idxd->dev_lock, flags);
 			module_put(THIS_MODULE);
 			dev_dbg(dev, "Failed to register dmaengine device\n");
 			return rc;
@@ -188,8 +184,8 @@ static int idxd_config_bus_probe(struct device *dev)
 
 		spin_lock_irqsave(&idxd->dev_lock, flags);
 		rc = idxd_device_config(idxd);
+		spin_unlock_irqrestore(&idxd->dev_lock, flags);
 		if (rc < 0) {
-			spin_unlock_irqrestore(&idxd->dev_lock, flags);
 			mutex_unlock(&wq->wq_lock);
 			dev_warn(dev, "Writing WQ %d config failed: %d\n",
 				 wq->id, rc);
@@ -198,13 +194,11 @@ static int idxd_config_bus_probe(struct device *dev)
 
 		rc = idxd_wq_enable(wq);
 		if (rc < 0) {
-			spin_unlock_irqrestore(&idxd->dev_lock, flags);
 			mutex_unlock(&wq->wq_lock);
 			dev_warn(dev, "WQ %d enabling failed: %d\n",
 				 wq->id, rc);
 			return rc;
 		}
-		spin_unlock_irqrestore(&idxd->dev_lock, flags);
 
 		rc = idxd_wq_map_portal(wq);
 		if (rc < 0) {
@@ -212,7 +206,6 @@ static int idxd_config_bus_probe(struct device *dev)
 			rc = idxd_wq_disable(wq);
 			if (rc < 0)
 				dev_warn(dev, "IDXD wq disable failed\n");
-			spin_unlock_irqrestore(&idxd->dev_lock, flags);
 			mutex_unlock(&wq->wq_lock);
 			return rc;
 		}
@@ -248,7 +241,6 @@ static void disable_wq(struct idxd_wq *wq)
 {
 	struct idxd_device *idxd = wq->idxd;
 	struct device *dev = &idxd->pdev->dev;
-	unsigned long flags;
 	int rc;
 
 	mutex_lock(&wq->wq_lock);
@@ -269,9 +261,8 @@ static void disable_wq(struct idxd_wq *wq)
 
 	idxd_wq_unmap_portal(wq);
 
-	spin_lock_irqsave(&idxd->dev_lock, flags);
+	idxd_wq_drain(wq);
 	rc = idxd_wq_disable(wq);
-	spin_unlock_irqrestore(&idxd->dev_lock, flags);
 
 	idxd_wq_free_resources(wq);
 	wq->client_count = 0;
@@ -287,7 +278,6 @@ static void disable_wq(struct idxd_wq *wq)
 static int idxd_config_bus_remove(struct device *dev)
 {
 	int rc;
-	unsigned long flags;
 
 	dev_dbg(dev, "%s called for %s\n", __func__, dev_name(dev));
 
@@ -313,9 +303,7 @@ static int idxd_config_bus_remove(struct device *dev)
 		}
 
 		idxd_unregister_dma_device(idxd);
-		spin_lock_irqsave(&idxd->dev_lock, flags);
 		rc = idxd_device_disable(idxd);
-		spin_unlock_irqrestore(&idxd->dev_lock, flags);
 		module_put(THIS_MODULE);
 		if (rc < 0)
 			dev_warn(dev, "Device disable failed\n");

