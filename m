Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2271E6AC884
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 17:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjCFQp7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 11:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjCFQol (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 11:44:41 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109FABC;
        Mon,  6 Mar 2023 08:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678121044; x=1709657044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o0tzkoJWUdCWbcbRIlF9BFXfJp21Z11MftALfWwp9uM=;
  b=QD/JCTT+SGbbivKqusSkyKpQ2ZVfC2db//w9PeAsvV5abKAtnLbmdjcy
   /qwaMPp5QRidHeQ7atvKhlHmhJIAfj9mmgvUWovh+YglGzdcYzkbdjhBd
   3LWpraIZBfnudi7NxgZyj+TGiVnndoN7tFfCFgGAoB2R89hHIQf9bWsZy
   qQTfWVJCO8ApNiuhaLem3SoM66Yj+yQsPiTYT9LOfc5lPZ8zBj2BXoBFz
   m+/vaGM3Q8Ys89mH6P/gHw+2wkXzvc4D0bgrM2y9bVI3RI3ymOl1+kr88
   ZNnpAHPu91Na/+55SoYy+FIWnOXuwCphE8wwdfzLB8Jj77m+Szaa5s1sK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="398181182"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="398181182"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 08:31:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="669504553"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="669504553"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga007.jf.intel.com with ESMTP; 06 Mar 2023 08:31:59 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Tony Zhu <tony.zhu@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 13/16] dmaengine: idxd: add a device to represent the file opened
Date:   Mon,  6 Mar 2023 08:31:35 -0800
Message-Id: <20230306163138.587484-14-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230306163138.587484-1-fenghua.yu@intel.com>
References: <20230306163138.587484-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/dma/idxd/cdev.c | 122 +++++++++++++++++++++++++++++++---------
 drivers/dma/idxd/idxd.h |   2 +
 2 files changed, 97 insertions(+), 27 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 3ce134afa867..2ff9a680ea5e 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -22,6 +22,13 @@ struct idxd_cdev_context {
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
@@ -37,7 +44,60 @@ struct idxd_user_context {
 	unsigned int pasid;
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
@@ -105,10 +165,11 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
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
@@ -163,10 +224,41 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
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
 
+ failed_dev_add:
+ failed_dev_name:
+	put_device(fdev);
+ failed_ida:
  failed_set_pasid:
 	if (device_user_pasid_enabled(idxd))
 		idxd_xa_pasid_remove(ctx);
@@ -214,35 +306,10 @@ static int idxd_cdev_release(struct inode *node, struct file *filep)
 	struct idxd_wq *wq = ctx->wq;
 	struct idxd_device *idxd = wq->idxd;
 	struct device *dev = &idxd->pdev->dev;
-	int rc;
 
 	dev_dbg(dev, "%s called\n", __func__);
 	filep->private_data = NULL;
-
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
-
-	if (ctx->sva) {
-		idxd_cdev_evl_drain_pasid(wq, ctx->pasid);
-		iommu_sva_unbind_device(ctx->sva);
-		idxd_xa_pasid_remove(ctx);
-	}
-
-	kfree(ctx);
-	mutex_lock(&wq->wq_lock);
-	idxd_wq_put(wq);
-	mutex_unlock(&wq->wq_lock);
+	device_unregister(user_ctx_dev(ctx));
 	return 0;
 }
 
@@ -373,6 +440,7 @@ void idxd_wq_del_cdev(struct idxd_wq *wq)
 	struct idxd_cdev *idxd_cdev;
 
 	idxd_cdev = wq->idxd_cdev;
+	ida_destroy(&file_ida);
 	wq->idxd_cdev = NULL;
 	cdev_device_del(&idxd_cdev->cdev, cdev_dev(idxd_cdev));
 	put_device(cdev_dev(idxd_cdev));
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index f92db20015fb..b5d7ef611bae 100644
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

