Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4936A3F6AF9
	for <lists+dmaengine@lfdr.de>; Tue, 24 Aug 2021 23:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbhHXVZO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Aug 2021 17:25:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:38239 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231474AbhHXVZO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Aug 2021 17:25:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="281120721"
X-IronPort-AV: E=Sophos;i="5.84,348,1620716400"; 
   d="scan'208";a="281120721"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 14:24:29 -0700
X-IronPort-AV: E=Sophos;i="5.84,348,1620716400"; 
   d="scan'208";a="597724601"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 14:24:28 -0700
Subject: [PATCH] dmaengine: idxd: remove interrupt disable for dev_lock
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
Date:   Tue, 24 Aug 2021 14:24:27 -0700
Message-ID: <162984026772.1939166.11504067782824765879.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The spinlock is not being used in hard interrupt context. There is no need
to disable irq when acquiring the lock. The interrupt thread handler also
is not in bottom half context, therefore we can also remove disabling of
the bh. Convert all dev_lock acquisition to plain spin_lock() calls.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/cdev.c   |    5 ++---
 drivers/dma/idxd/device.c |   31 ++++++++++++-------------------
 drivers/dma/idxd/irq.c    |    8 ++++----
 drivers/dma/idxd/sysfs.c  |   10 ++++------
 4 files changed, 22 insertions(+), 32 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 4d2ecdb130e7..b9b2b4a4124e 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -218,14 +218,13 @@ static __poll_t idxd_cdev_poll(struct file *filp,
 	struct idxd_user_context *ctx = filp->private_data;
 	struct idxd_wq *wq = ctx->wq;
 	struct idxd_device *idxd = wq->idxd;
-	unsigned long flags;
 	__poll_t out = 0;
 
 	poll_wait(filp, &wq->err_queue, wait);
-	spin_lock_irqsave(&idxd->dev_lock, flags);
+	spin_lock(&idxd->dev_lock);
 	if (idxd->sw_err.valid)
 		out = EPOLLIN | EPOLLRDNORM;
-	spin_unlock_irqrestore(&idxd->dev_lock, flags);
+	spin_unlock(&idxd->dev_lock);
 
 	return out;
 }
diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 241df74fc047..3e6c4f6f5f8b 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -341,19 +341,18 @@ int idxd_wq_set_pasid(struct idxd_wq *wq, int pasid)
 	int rc;
 	union wqcfg wqcfg;
 	unsigned int offset;
-	unsigned long flags;
 
 	rc = idxd_wq_disable(wq, false);
 	if (rc < 0)
 		return rc;
 
 	offset = WQCFG_OFFSET(idxd, wq->id, WQCFG_PASID_IDX);
-	spin_lock_irqsave(&idxd->dev_lock, flags);
+	spin_lock(&idxd->dev_lock);
 	wqcfg.bits[WQCFG_PASID_IDX] = ioread32(idxd->reg_base + offset);
 	wqcfg.pasid_en = 1;
 	wqcfg.pasid = pasid;
 	iowrite32(wqcfg.bits[WQCFG_PASID_IDX], idxd->reg_base + offset);
-	spin_unlock_irqrestore(&idxd->dev_lock, flags);
+	spin_unlock(&idxd->dev_lock);
 
 	rc = idxd_wq_enable(wq);
 	if (rc < 0)
@@ -368,19 +367,18 @@ int idxd_wq_disable_pasid(struct idxd_wq *wq)
 	int rc;
 	union wqcfg wqcfg;
 	unsigned int offset;
-	unsigned long flags;
 
 	rc = idxd_wq_disable(wq, false);
 	if (rc < 0)
 		return rc;
 
 	offset = WQCFG_OFFSET(idxd, wq->id, WQCFG_PASID_IDX);
-	spin_lock_irqsave(&idxd->dev_lock, flags);
+	spin_lock(&idxd->dev_lock);
 	wqcfg.bits[WQCFG_PASID_IDX] = ioread32(idxd->reg_base + offset);
 	wqcfg.pasid_en = 0;
 	wqcfg.pasid = 0;
 	iowrite32(wqcfg.bits[WQCFG_PASID_IDX], idxd->reg_base + offset);
-	spin_unlock_irqrestore(&idxd->dev_lock, flags);
+	spin_unlock(&idxd->dev_lock);
 
 	rc = idxd_wq_enable(wq);
 	if (rc < 0)
@@ -560,7 +558,6 @@ int idxd_device_disable(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
 	u32 status;
-	unsigned long flags;
 
 	if (!idxd_is_enabled(idxd)) {
 		dev_dbg(dev, "Device is not enabled\n");
@@ -576,22 +573,20 @@ int idxd_device_disable(struct idxd_device *idxd)
 		return -ENXIO;
 	}
 
-	spin_lock_irqsave(&idxd->dev_lock, flags);
+	spin_lock(&idxd->dev_lock);
 	idxd_device_clear_state(idxd);
 	idxd->state = IDXD_DEV_DISABLED;
-	spin_unlock_irqrestore(&idxd->dev_lock, flags);
+	spin_unlock(&idxd->dev_lock);
 	return 0;
 }
 
 void idxd_device_reset(struct idxd_device *idxd)
 {
-	unsigned long flags;
-
 	idxd_cmd_exec(idxd, IDXD_CMD_RESET_DEVICE, 0, NULL);
-	spin_lock_irqsave(&idxd->dev_lock, flags);
+	spin_lock(&idxd->dev_lock);
 	idxd_device_clear_state(idxd);
 	idxd->state = IDXD_DEV_DISABLED;
-	spin_unlock_irqrestore(&idxd->dev_lock, flags);
+	spin_unlock(&idxd->dev_lock);
 }
 
 void idxd_device_drain_pasid(struct idxd_device *idxd, int pasid)
@@ -1167,7 +1162,6 @@ int __drv_enable_wq(struct idxd_wq *wq)
 {
 	struct idxd_device *idxd = wq->idxd;
 	struct device *dev = &idxd->pdev->dev;
-	unsigned long flags;
 	int rc = -ENXIO;
 
 	lockdep_assert_held(&wq->wq_lock);
@@ -1219,10 +1213,10 @@ int __drv_enable_wq(struct idxd_wq *wq)
 	}
 
 	rc = 0;
-	spin_lock_irqsave(&idxd->dev_lock, flags);
+	spin_lock(&idxd->dev_lock);
 	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
 		rc = idxd_device_config(idxd);
-	spin_unlock_irqrestore(&idxd->dev_lock, flags);
+	spin_unlock(&idxd->dev_lock);
 	if (rc < 0) {
 		dev_dbg(dev, "Writing wq %d config failed: %d\n", wq->id, rc);
 		goto err;
@@ -1291,7 +1285,6 @@ void drv_disable_wq(struct idxd_wq *wq)
 int idxd_device_drv_probe(struct idxd_dev *idxd_dev)
 {
 	struct idxd_device *idxd = idxd_dev_to_idxd(idxd_dev);
-	unsigned long flags;
 	int rc = 0;
 
 	/*
@@ -1305,10 +1298,10 @@ int idxd_device_drv_probe(struct idxd_dev *idxd_dev)
 	}
 
 	/* Device configuration */
-	spin_lock_irqsave(&idxd->dev_lock, flags);
+	spin_lock(&idxd->dev_lock);
 	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
 		rc = idxd_device_config(idxd);
-	spin_unlock_irqrestore(&idxd->dev_lock, flags);
+	spin_unlock(&idxd->dev_lock);
 	if (rc < 0)
 		return -ENXIO;
 
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index d221c2e37460..ca88fa7a328e 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -64,7 +64,7 @@ static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
 	bool err = false;
 
 	if (cause & IDXD_INTC_ERR) {
-		spin_lock_bh(&idxd->dev_lock);
+		spin_lock(&idxd->dev_lock);
 		for (i = 0; i < 4; i++)
 			idxd->sw_err.bits[i] = ioread64(idxd->reg_base +
 					IDXD_SWERR_OFFSET + i * sizeof(u64));
@@ -89,7 +89,7 @@ static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
 			}
 		}
 
-		spin_unlock_bh(&idxd->dev_lock);
+		spin_unlock(&idxd->dev_lock);
 		val |= IDXD_INTC_ERR;
 
 		for (i = 0; i < 4; i++)
@@ -133,7 +133,7 @@ static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
 			INIT_WORK(&idxd->work, idxd_device_reinit);
 			queue_work(idxd->wq, &idxd->work);
 		} else {
-			spin_lock_bh(&idxd->dev_lock);
+			spin_lock(&idxd->dev_lock);
 			idxd_wqs_quiesce(idxd);
 			idxd_wqs_unmap_portal(idxd);
 			idxd_device_clear_state(idxd);
@@ -141,7 +141,7 @@ static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
 				"idxd halted, need %s.\n",
 				gensts.reset_type == IDXD_DEVICE_RESET_FLR ?
 				"FLR" : "system reset");
-			spin_unlock_bh(&idxd->dev_lock);
+			spin_unlock(&idxd->dev_lock);
 			return -ENXIO;
 		}
 	}
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index a88886d0f27b..a9025be940db 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1099,16 +1099,15 @@ static ssize_t clients_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
 	struct idxd_device *idxd = confdev_to_idxd(dev);
-	unsigned long flags;
 	int count = 0, i;
 
-	spin_lock_irqsave(&idxd->dev_lock, flags);
+	spin_lock(&idxd->dev_lock);
 	for (i = 0; i < idxd->max_wqs; i++) {
 		struct idxd_wq *wq = idxd->wqs[i];
 
 		count += wq->client_count;
 	}
-	spin_unlock_irqrestore(&idxd->dev_lock, flags);
+	spin_unlock(&idxd->dev_lock);
 
 	return sysfs_emit(buf, "%d\n", count);
 }
@@ -1146,12 +1145,11 @@ static ssize_t errors_show(struct device *dev,
 {
 	struct idxd_device *idxd = confdev_to_idxd(dev);
 	int i, out = 0;
-	unsigned long flags;
 
-	spin_lock_irqsave(&idxd->dev_lock, flags);
+	spin_lock(&idxd->dev_lock);
 	for (i = 0; i < 4; i++)
 		out += sysfs_emit_at(buf, out, "%#018llx ", idxd->sw_err.bits[i]);
-	spin_unlock_irqrestore(&idxd->dev_lock, flags);
+	spin_unlock(&idxd->dev_lock);
 	out--;
 	out += sysfs_emit_at(buf, out, "\n");
 	return out;


