Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D45B6DB54C
	for <lists+dmaengine@lfdr.de>; Fri,  7 Apr 2023 22:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjDGUcH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Apr 2023 16:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjDGUbf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Apr 2023 16:31:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D110CA0C;
        Fri,  7 Apr 2023 13:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680899493; x=1712435493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WerQDtmuf8yZcX7AnDOXhwPDaGTSDW/AqrkuB0lbMbA=;
  b=Gg0oiEUh057AWSYz1wx4WodP6mnbCKLU88+M0aMzTigdq+/TmMytxZrk
   MXX9uWt1OkAooDttDUMC8+mnZQQNyE85m2WrMWKJY445GrqiRP9Wmqk2Z
   lazyUPCSS0+WJeNW7O1OUanT5s917pEKLzm8X/ZjOv3ltsINmDOinWfLS
   Lv/ncpVNvjpuruBTksQvAxy7aH/QYlz0Gcaownvr1E1L6pPlkbsnMsJ/H
   1rX6H14FWPat1wMh8gxZ1Rx21TrykMMQv2I1BJpTouZGY3yncTCfL9o1k
   olPvKqLaMQc35eGIsli/0Y3xYcJw8NK1Xe4pUbthRcrLmr79d6twENNtM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="408196878"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="408196878"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 13:31:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="681125900"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="681125900"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga007.jf.intel.com with ESMTP; 07 Apr 2023 13:31:27 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Tony Zhu <tony.zhu@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 13/16] dmaengine: idxd: add a device to represent the file opened
Date:   Fri,  7 Apr 2023 13:31:40 -0700
Message-Id: <20230407203143.2189681-14-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230407203143.2189681-1-fenghua.yu@intel.com>
References: <20230407203143.2189681-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Dave Jiang <dave.jiang@intel.com>

Embed a struct device for the user file context in order to export sysfs
attributes related with the opened file. Tie the lifetime of the file
context to the device. The sysfs entry will be added under the char device.

Tested-by: Tony Zhu <tony.zhu@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/cdev.c | 119 ++++++++++++++++++++++++++++++++--------
 drivers/dma/idxd/idxd.h |   2 +
 2 files changed, 97 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 5c8e964e671b..e07411053e21 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -23,6 +23,13 @@ struct idxd_cdev_context {
 	struct ida minor_ida;
 };
 
+/*
+ * Since user file names are global in DSA devices, define their ida's as
+ * global to avoid conflict file names.
+ */
+static DEFINE_IDA(file_ida);
+static DEFINE_MUTEX(ida_lock);
+
 /*
  * ictx is an array based off of accelerator types. enum idxd_type
  * is used as index
@@ -39,7 +46,60 @@ struct idxd_user_context {
 	struct mm_struct *mm;
 	unsigned int flags;
 	struct iommu_sva *sva;
+	struct idxd_dev idxd_dev;
 	u64 counters[COUNTER_MAX];
+	int id;
+};
+
+static void idxd_cdev_evl_drain_pasid(struct idxd_wq *wq, u32 pasid);
+static void idxd_xa_pasid_remove(struct idxd_user_context *ctx);
+
+static inline struct idxd_user_context *dev_to_uctx(struct device *dev)
+{
+	struct idxd_dev *idxd_dev = confdev_to_idxd_dev(dev);
+
+	return container_of(idxd_dev, struct idxd_user_context, idxd_dev);
+}
+
+static void idxd_file_dev_release(struct device *dev)
+{
+	struct idxd_user_context *ctx = dev_to_uctx(dev);
+	struct idxd_wq *wq = ctx->wq;
+	struct idxd_device *idxd = wq->idxd;
+	int rc;
+
+	mutex_lock(&ida_lock);
+	ida_free(&file_ida, ctx->id);
+	mutex_unlock(&ida_lock);
+
+	/* Wait for in-flight operations to complete. */
+	if (wq_shared(wq)) {
+		idxd_device_drain_pasid(idxd, ctx->pasid);
+	} else {
+		if (device_user_pasid_enabled(idxd)) {
+			/* The wq disable in the disable pasid function will drain the wq */
+			rc = idxd_wq_disable_pasid(wq);
+			if (rc < 0)
+				dev_err(dev, "wq disable pasid failed.\n");
+		} else {
+			idxd_wq_drain(wq);
+		}
+	}
+
+	if (ctx->sva) {
+		idxd_cdev_evl_drain_pasid(wq, ctx->pasid);
+		iommu_sva_unbind_device(ctx->sva);
+		idxd_xa_pasid_remove(ctx);
+	}
+	kfree(ctx);
+	mutex_lock(&wq->wq_lock);
+	idxd_wq_put(wq);
+	mutex_unlock(&wq->wq_lock);
+}
+
+static struct device_type idxd_cdev_file_type = {
+	.name = "idxd_file",
+	.release = idxd_file_dev_release,
 };
 
 static void idxd_cdev_dev_release(struct device *dev)
@@ -107,10 +167,11 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	struct idxd_user_context *ctx;
 	struct idxd_device *idxd;
 	struct idxd_wq *wq;
-	struct device *dev;
+	struct device *dev, *fdev;
 	int rc = 0;
 	struct iommu_sva *sva;
 	unsigned int pasid;
+	struct idxd_cdev *idxd_cdev;
 
 	wq = inode_wq(inode);
 	idxd = wq->idxd;
@@ -166,10 +227,41 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 		}
 	}
 
+	idxd_cdev = wq->idxd_cdev;
+	mutex_lock(&ida_lock);
+	ctx->id = ida_alloc(&file_ida, GFP_KERNEL);
+	mutex_unlock(&ida_lock);
+	if (ctx->id < 0) {
+		dev_warn(dev, "ida alloc failure\n");
+		goto failed_ida;
+	}
+	ctx->idxd_dev.type  = IDXD_DEV_CDEV_FILE;
+	fdev = user_ctx_dev(ctx);
+	device_initialize(fdev);
+	fdev->parent = cdev_dev(idxd_cdev);
+	fdev->bus = &dsa_bus_type;
+	fdev->type = &idxd_cdev_file_type;
+
+	rc = dev_set_name(fdev, "file%d", ctx->id);
+	if (rc < 0) {
+		dev_warn(dev, "set name failure\n");
+		goto failed_dev_name;
+	}
+
+	rc = device_add(fdev);
+	if (rc < 0) {
+		dev_warn(dev, "file device add failure\n");
+		goto failed_dev_add;
+	}
+
 	idxd_wq_get(wq);
 	mutex_unlock(&wq->wq_lock);
 	return 0;
 
+failed_dev_add:
+failed_dev_name:
+	put_device(fdev);
+failed_ida:
 failed_set_pasid:
 	if (device_user_pasid_enabled(idxd))
 		idxd_xa_pasid_remove(ctx);
@@ -217,34 +309,12 @@ static int idxd_cdev_release(struct inode *node, struct file *filep)
 	struct idxd_wq *wq = ctx->wq;
 	struct idxd_device *idxd = wq->idxd;
 	struct device *dev = &idxd->pdev->dev;
-	int rc;
 
 	dev_dbg(dev, "%s called\n", __func__);
 	filep->private_data = NULL;
 
-	/* Wait for in-flight operations to complete. */
-	if (wq_shared(wq)) {
-		idxd_device_drain_pasid(idxd, ctx->pasid);
-	} else {
-		if (device_user_pasid_enabled(idxd)) {
-			/* The wq disable in the disable pasid function will drain the wq */
-			rc = idxd_wq_disable_pasid(wq);
-			if (rc < 0)
-				dev_err(dev, "wq disable pasid failed.\n");
-		} else {
-			idxd_wq_drain(wq);
-		}
-	}
+	device_unregister(user_ctx_dev(ctx));
 
-	if (ctx->sva) {
-		idxd_cdev_evl_drain_pasid(wq, ctx->pasid);
-		iommu_sva_unbind_device(ctx->sva);
-		idxd_xa_pasid_remove(ctx);
-	}
-	kfree(ctx);
-	mutex_lock(&wq->wq_lock);
-	idxd_wq_put(wq);
-	mutex_unlock(&wq->wq_lock);
 	return 0;
 }
 
@@ -375,6 +445,7 @@ void idxd_wq_del_cdev(struct idxd_wq *wq)
 	struct idxd_cdev *idxd_cdev;
 
 	idxd_cdev = wq->idxd_cdev;
+	ida_destroy(&file_ida);
 	wq->idxd_cdev = NULL;
 	cdev_device_del(&idxd_cdev->cdev, cdev_dev(idxd_cdev));
 	put_device(cdev_dev(idxd_cdev));
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 9fb26d017285..bd544eb2ddcb 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -32,6 +32,7 @@ enum idxd_dev_type {
 	IDXD_DEV_GROUP,
 	IDXD_DEV_ENGINE,
 	IDXD_DEV_CDEV,
+	IDXD_DEV_CDEV_FILE,
 	IDXD_DEV_MAX_TYPE,
 };
 
@@ -405,6 +406,7 @@ enum idxd_completion_status {
 #define engine_confdev(engine) &engine->idxd_dev.conf_dev
 #define group_confdev(group) &group->idxd_dev.conf_dev
 #define cdev_dev(cdev) &cdev->idxd_dev.conf_dev
+#define user_ctx_dev(ctx) (&(ctx)->idxd_dev.conf_dev)
 
 #define confdev_to_idxd_dev(dev) container_of(dev, struct idxd_dev, conf_dev)
 #define idxd_dev_to_idxd(idxd_dev) container_of(idxd_dev, struct idxd_device, idxd_dev)
-- 
2.37.1

