Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F2134530F
	for <lists+dmaengine@lfdr.de>; Tue, 23 Mar 2021 00:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhCVXcM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Mar 2021 19:32:12 -0400
Received: from mga04.intel.com ([192.55.52.120]:57555 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230434AbhCVXcF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Mar 2021 19:32:05 -0400
IronPort-SDR: 0reRni0DfZPl2VqqMB2eNe5T7GV5MegKYj5vyYv5kZLwR9+s86y434tcJqJMYE5q+5ayRS0sLR
 WQv0m3zQbCfA==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="188049770"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="188049770"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 16:32:01 -0700
IronPort-SDR: zCTgcsMDif6g2X67Yi7dm50mc/OG/gzn+ynhmVeu4HB87dmqyjl7infeMI+mSbLJSkdklQpsuB
 I17WzQ8ZKJRQ==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="513483709"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 16:32:01 -0700
Subject: [PATCH v7 8/8] dmaengine: idxd: fix cdev setup and free device
 lifetime issues
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, jgg@nvidia.com, dan.j.williams@intel.com
Date:   Mon, 22 Mar 2021 16:32:01 -0700
Message-ID: <161645592123.2002542.5490784749723732920.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <161645534083.2002542.11583610276394664799.stgit@djiang5-desk3.ch.intel.com>
References: <161645534083.2002542.11583610276394664799.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The char device setup and cleanup has device lifetime issues regarding when
parts are initialized and cleaned up. The initialization of struct device is
done incorrectly. device_initialize() needs to be called on the 'struct
device' and then additional changes can be added. The ->release() function
needs to be setup via device_type before dev_set_name() to allow proper
cleanup. The change re-parents the cdev under the wq->conf_dev to get
natural reference inheritance. No known dependency on the old device path exists.

Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Fixes: 42d279f9137a ("dmaengine: idxd: add char driver to expose submission portal to userland")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dma/idxd/cdev.c  |  131 +++++++++++++++++-----------------------------
 drivers/dma/idxd/idxd.h  |    7 +-
 drivers/dma/idxd/init.c  |    2 -
 drivers/dma/idxd/irq.c   |    4 +
 drivers/dma/idxd/sysfs.c |    8 ++-
 5 files changed, 63 insertions(+), 89 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 0db9b82ed8cf..b4ff97f93f13 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -39,15 +39,15 @@ struct idxd_user_context {
 	struct iommu_sva *sva;
 };
 
-enum idxd_cdev_cleanup {
-	CDEV_NORMAL = 0,
-	CDEV_FAILED,
-};
-
 static void idxd_cdev_dev_release(struct device *dev)
 {
-	dev_dbg(dev, "releasing cdev device\n");
-	kfree(dev);
+	struct idxd_cdev *idxd_cdev = container_of(dev, struct idxd_cdev, dev);
+	struct idxd_cdev_context *cdev_ctx;
+	struct idxd_wq *wq = idxd_cdev->wq;
+
+	cdev_ctx = &ictx[wq->idxd->type];
+	ida_simple_remove(&cdev_ctx->minor_ida, idxd_cdev->minor);
+	kfree(idxd_cdev);
 }
 
 static struct device_type idxd_cdev_device_type = {
@@ -62,14 +62,11 @@ static inline struct idxd_cdev *inode_idxd_cdev(struct inode *inode)
 	return container_of(cdev, struct idxd_cdev, cdev);
 }
 
-static inline struct idxd_wq *idxd_cdev_wq(struct idxd_cdev *idxd_cdev)
-{
-	return container_of(idxd_cdev, struct idxd_wq, idxd_cdev);
-}
-
 static inline struct idxd_wq *inode_wq(struct inode *inode)
 {
-	return idxd_cdev_wq(inode_idxd_cdev(inode));
+	struct idxd_cdev *idxd_cdev = inode_idxd_cdev(inode);
+
+	return idxd_cdev->wq;
 }
 
 static int idxd_cdev_open(struct inode *inode, struct file *filp)
@@ -220,11 +217,10 @@ static __poll_t idxd_cdev_poll(struct file *filp,
 	struct idxd_user_context *ctx = filp->private_data;
 	struct idxd_wq *wq = ctx->wq;
 	struct idxd_device *idxd = wq->idxd;
-	struct idxd_cdev *idxd_cdev = &wq->idxd_cdev;
 	unsigned long flags;
 	__poll_t out = 0;
 
-	poll_wait(filp, &idxd_cdev->err_queue, wait);
+	poll_wait(filp, &wq->err_queue, wait);
 	spin_lock_irqsave(&idxd->dev_lock, flags);
 	if (idxd->sw_err.valid)
 		out = EPOLLIN | EPOLLRDNORM;
@@ -246,98 +242,69 @@ int idxd_cdev_get_major(struct idxd_device *idxd)
 	return MAJOR(ictx[idxd->type].devt);
 }
 
-static int idxd_wq_cdev_dev_setup(struct idxd_wq *wq)
+int idxd_wq_add_cdev(struct idxd_wq *wq)
 {
 	struct idxd_device *idxd = wq->idxd;
-	struct idxd_cdev *idxd_cdev = &wq->idxd_cdev;
-	struct idxd_cdev_context *cdev_ctx;
+	struct idxd_cdev *idxd_cdev;
+	struct cdev *cdev;
 	struct device *dev;
-	int minor, rc;
+	struct idxd_cdev_context *cdev_ctx;
+	int rc, minor;
 
-	idxd_cdev->dev = kzalloc(sizeof(*idxd_cdev->dev), GFP_KERNEL);
-	if (!idxd_cdev->dev)
+	idxd_cdev = kzalloc(sizeof(*idxd_cdev), GFP_KERNEL);
+	if (!idxd_cdev)
 		return -ENOMEM;
 
-	dev = idxd_cdev->dev;
-	dev->parent = &idxd->pdev->dev;
-	dev_set_name(dev, "%s/wq%u.%u", idxd_get_dev_name(idxd),
-		     idxd->id, wq->id);
-	dev->bus = idxd_get_bus_type(idxd);
-
+	idxd_cdev->wq = wq;
+	cdev = &idxd_cdev->cdev;
+	dev = &idxd_cdev->dev;
 	cdev_ctx = &ictx[wq->idxd->type];
 	minor = ida_simple_get(&cdev_ctx->minor_ida, 0, MINORMASK, GFP_KERNEL);
 	if (minor < 0) {
-		rc = minor;
-		kfree(dev);
-		goto ida_err;
-	}
-
-	dev->devt = MKDEV(MAJOR(cdev_ctx->devt), minor);
-	dev->type = &idxd_cdev_device_type;
-	rc = device_register(dev);
-	if (rc < 0) {
-		dev_err(&idxd->pdev->dev, "device register failed\n");
-		goto dev_reg_err;
+		kfree(idxd_cdev);
+		return minor;
 	}
 	idxd_cdev->minor = minor;
 
-	return 0;
-
- dev_reg_err:
-	ida_simple_remove(&cdev_ctx->minor_ida, MINOR(dev->devt));
-	put_device(dev);
- ida_err:
-	idxd_cdev->dev = NULL;
-	return rc;
-}
-
-static void idxd_wq_cdev_cleanup(struct idxd_wq *wq,
-				 enum idxd_cdev_cleanup cdev_state)
-{
-	struct idxd_cdev *idxd_cdev = &wq->idxd_cdev;
-	struct idxd_cdev_context *cdev_ctx;
-
-	cdev_ctx = &ictx[wq->idxd->type];
-	if (cdev_state == CDEV_NORMAL)
-		cdev_del(&idxd_cdev->cdev);
-	device_unregister(idxd_cdev->dev);
-	/*
-	 * The device_type->release() will be called on the device and free
-	 * the allocated struct device. We can just forget it.
-	 */
-	ida_simple_remove(&cdev_ctx->minor_ida, idxd_cdev->minor);
-	idxd_cdev->dev = NULL;
-	idxd_cdev->minor = -1;
-}
-
-int idxd_wq_add_cdev(struct idxd_wq *wq)
-{
-	struct idxd_cdev *idxd_cdev = &wq->idxd_cdev;
-	struct cdev *cdev = &idxd_cdev->cdev;
-	struct device *dev;
-	int rc;
+	device_initialize(dev);
+	dev->parent = &wq->conf_dev;
+	dev->bus = idxd_get_bus_type(idxd);
+	dev->type = &idxd_cdev_device_type;
+	dev->devt = MKDEV(MAJOR(cdev_ctx->devt), minor);
 
-	rc = idxd_wq_cdev_dev_setup(wq);
+	rc = dev_set_name(dev, "%s/wq%u.%u", idxd_get_dev_name(idxd),
+			  idxd->id, wq->id);
 	if (rc < 0)
-		return rc;
+		goto err;
 
-	dev = idxd_cdev->dev;
+	wq->idxd_cdev = idxd_cdev;
 	cdev_init(cdev, &idxd_cdev_fops);
-	cdev_set_parent(cdev, &dev->kobj);
-	rc = cdev_add(cdev, dev->devt, 1);
+	rc = cdev_device_add(cdev, dev);
 	if (rc) {
 		dev_dbg(&wq->idxd->pdev->dev, "cdev_add failed: %d\n", rc);
-		idxd_wq_cdev_cleanup(wq, CDEV_FAILED);
-		return rc;
+		goto err;
 	}
 
-	init_waitqueue_head(&idxd_cdev->err_queue);
 	return 0;
+
+ err:
+	put_device(dev);
+	wq->idxd_cdev = NULL;
+	return rc;
 }
 
 void idxd_wq_del_cdev(struct idxd_wq *wq)
 {
-	idxd_wq_cdev_cleanup(wq, CDEV_NORMAL);
+	struct idxd_cdev *idxd_cdev;
+	struct idxd_cdev_context *cdev_ctx;
+
+	cdev_ctx = &ictx[wq->idxd->type];
+	mutex_lock(&wq->wq_lock);
+	idxd_cdev = wq->idxd_cdev;
+	wq->idxd_cdev = NULL;
+	mutex_unlock(&wq->wq_lock);
+	cdev_device_del(&idxd_cdev->cdev, &idxd_cdev->dev);
+	put_device(&idxd_cdev->dev);
 }
 
 int idxd_cdev_register(void)
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 35bb616f04d5..acb70c3b7e36 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -79,10 +79,10 @@ enum idxd_wq_type {
 };
 
 struct idxd_cdev {
+	struct idxd_wq *wq;
 	struct cdev cdev;
-	struct device *dev;
+	struct device dev;
 	int minor;
-	struct wait_queue_head err_queue;
 };
 
 #define IDXD_ALLOCATED_BATCH_SIZE	128U
@@ -108,7 +108,8 @@ struct idxd_dma_chan {
 struct idxd_wq {
 	void __iomem *portal;
 	struct device conf_dev;
-	struct idxd_cdev idxd_cdev;
+	struct idxd_cdev *idxd_cdev;
+	struct wait_queue_head err_queue;
 	struct idxd_device *idxd;
 	int id;
 	enum idxd_wq_type type;
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 72b859c33937..7847daa51d4c 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -273,7 +273,7 @@ static int idxd_setup_internals(struct idxd_device *idxd)
 		wq->id = i;
 		wq->idxd = idxd;
 		mutex_init(&wq->wq_lock);
-		wq->idxd_cdev.minor = -1;
+		init_waitqueue_head(&wq->err_queue);
 		wq->max_xfer_bytes = idxd->max_xfer_bytes;
 		wq->max_batch_size = idxd->max_batch_size;
 		wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 7b0181532f77..fc0781e3f36d 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -133,7 +133,7 @@ static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
 			struct idxd_wq *wq = idxd->wqs[id];
 
 			if (wq->type == IDXD_WQT_USER)
-				wake_up_interruptible(&wq->idxd_cdev.err_queue);
+				wake_up_interruptible(&wq->err_queue);
 		} else {
 			int i;
 
@@ -141,7 +141,7 @@ static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
 				struct idxd_wq *wq = idxd->wqs[i];
 
 				if (wq->type == IDXD_WQT_USER)
-					wake_up_interruptible(&wq->idxd_cdev.err_queue);
+					wake_up_interruptible(&wq->err_queue);
 			}
 		}
 
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 03079ff54889..8a08988ea9d1 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1174,8 +1174,14 @@ static ssize_t wq_cdev_minor_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
 	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+	int minor = -1;
 
-	return sprintf(buf, "%d\n", wq->idxd_cdev.minor);
+	mutex_lock(&wq->wq_lock);
+	if (wq->idxd_cdev)
+		minor = wq->idxd_cdev->minor;
+	mutex_unlock(&wq->wq_lock);
+
+	return sprintf(buf, "%d\n", minor);
 }
 
 static struct device_attribute dev_attr_wq_cdev_minor =


