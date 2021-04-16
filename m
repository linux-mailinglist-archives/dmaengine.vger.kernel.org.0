Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4CD5361666
	for <lists+dmaengine@lfdr.de>; Fri, 16 Apr 2021 01:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237208AbhDOXiV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Apr 2021 19:38:21 -0400
Received: from mga14.intel.com ([192.55.52.115]:28086 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236032AbhDOXiV (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 15 Apr 2021 19:38:21 -0400
IronPort-SDR: SixM3XK2SvksBd8dbjAK4ag7O5g/LKKUm0WUa8kf7m9xvHd4wCAjwceW9xmx5IdzQ4dX1IjH6S
 kRAtt9Jjwq6Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="194523326"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="194523326"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:37:57 -0700
IronPort-SDR: fuRHTzvhtvI+lE+KIiwRGfG7lYPA5OTLLBvCXRY2V2tP2WgyVWt/li4zmRP+QDJYKePrIYOjxw
 D9tUGyh499sQ==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="451287177"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:37:57 -0700
Subject: [PATCH v10 09/11] dmaengine: idxd: fix cdev setup and free device
 lifetime issues
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Date:   Thu, 15 Apr 2021 16:37:57 -0700
Message-ID: <161852987721.2203940.1478218825576630810.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <161852959148.2203940.7484827367948091199.stgit@djiang5-desk3.ch.intel.com>
References: <161852959148.2203940.7484827367948091199.stgit@djiang5-desk3.ch.intel.com>
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
 drivers/dma/idxd/cdev.c  |  129 +++++++++++++++++-----------------------------
 drivers/dma/idxd/idxd.h  |    7 +-
 drivers/dma/idxd/init.c  |    2 -
 drivers/dma/idxd/irq.c   |    4 +
 drivers/dma/idxd/sysfs.c |   10 +++-
 5 files changed, 63 insertions(+), 89 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 0db9b82ed8cf..1d8a3876b745 100644
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
@@ -246,98 +242,67 @@ int idxd_cdev_get_major(struct idxd_device *idxd)
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
+	idxd_cdev = wq->idxd_cdev;
+	wq->idxd_cdev = NULL;
+	cdev_device_del(&idxd_cdev->cdev, &idxd_cdev->dev);
+	put_device(&idxd_cdev->dev);
 }
 
 int idxd_cdev_register(void)
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 3c4ce7997c88..89daf746d121 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -80,10 +80,10 @@ enum idxd_wq_type {
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
@@ -109,7 +109,8 @@ struct idxd_dma_chan {
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
index c20ea6bf09bf..07cf7977a045 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -176,7 +176,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		}
 
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
index f793688039c9..9586b55abce5 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1169,8 +1169,16 @@ static ssize_t wq_cdev_minor_show(struct device *dev,
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
+	if (minor == -1)
+		return -ENXIO;
+	return sysfs_emit(buf, "%d\n", minor);
 }
 
 static struct device_attribute dev_attr_wq_cdev_minor =


