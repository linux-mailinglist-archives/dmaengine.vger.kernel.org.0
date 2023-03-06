Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F136AC886
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 17:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjCFQqC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 11:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjCFQoo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 11:44:44 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0A0392A4;
        Mon,  6 Mar 2023 08:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678121047; x=1709657047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PlfSoZzN1gXey+LT5NcjYosAUIPiULYfrB8G6xkyz8E=;
  b=Xcs6B7NErTFicDLjJ4bI4/xPAOVn++O3xGRPbmHVoKtusfxigxIEWN8P
   J1PSIPTcIG6wXOjdNyFWXc5BBSpDeg+JJ6F3pU/VXdLAz75k0w814CMQB
   hV2ebFCg/wkbeZA2K+hMoHkZtVJ9QeX6DcaFplliY2ltrKxstegTUqGx6
   qN5aD5YJmsOH4/wgKwmEUrvkcL2SMhg5EBcnEGrQ0cY8WEuM/m6e/gW9U
   0xt+ViQSRrpq4ZtA2Ul7oqMIMExqchUgF/nlLt7Pp1AlEffUtH0WpyJYf
   speiz8ua8DGCYejFXWUXyRPi8myaBHhZSKHxzcHryQ2hFU9m9rVZGw4Xr
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="398181180"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="398181180"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 08:31:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="669504548"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="669504548"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga007.jf.intel.com with ESMTP; 06 Mar 2023 08:31:58 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Tony Zhu <tony.zhu@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 12/16] dmaengine: idxd: add per file user counters for completion record faults
Date:   Mon,  6 Mar 2023 08:31:34 -0800
Message-Id: <20230306163138.587484-13-fenghua.yu@intel.com>
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

Add counters per opened file for the char device in order to keep track how
many completion record faults occurred and how many of those faults failed
the writeback by the driver after attempt to fault in the page. An xarray
is added to associate the PASID with the struct idxd_user_context so the
counters can be managed.

Tested-by: Tony Zhu <tony.zhu@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/cdev.c  | 50 +++++++++++++++++++++++++++++++++++++---
 drivers/dma/idxd/idxd.h  | 11 +++++++++
 drivers/dma/idxd/init.c  |  2 ++
 drivers/dma/idxd/irq.c   |  4 ++++
 drivers/dma/idxd/sysfs.c |  1 +
 5 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 51a5b8ab160e..3ce134afa867 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/poll.h>
 #include <linux/iommu.h>
+#include <linux/xarray.h>
 #include <uapi/linux/idxd.h>
 #include "registers.h"
 #include "idxd.h"
@@ -36,6 +37,7 @@ struct idxd_user_context {
 	unsigned int pasid;
 	unsigned int flags;
 	struct iommu_sva *sva;
+	u64 counters[COUNTER_MAX];
 };
 
 static void idxd_cdev_dev_release(struct device *dev)
@@ -68,6 +70,36 @@ static inline struct idxd_wq *inode_wq(struct inode *inode)
 	return idxd_cdev->wq;
 }
 
+void idxd_user_counter_increment(struct idxd_wq *wq, u32 pasid, int index)
+{
+	struct idxd_user_context *ctx;
+
+	if (index >= COUNTER_MAX)
+		return;
+
+	mutex_lock(&wq->uc_lock);
+	ctx = xa_load(&wq->upasid_xa, pasid);
+	if (!ctx) {
+		mutex_unlock(&wq->uc_lock);
+		return;
+	}
+	ctx->counters[index]++;
+	mutex_unlock(&wq->uc_lock);
+}
+
+static void idxd_xa_pasid_remove(struct idxd_user_context *ctx)
+{
+	struct idxd_wq *wq = ctx->wq;
+	void *ptr;
+
+	mutex_lock(&wq->uc_lock);
+	ptr = xa_cmpxchg(&wq->upasid_xa, ctx->pasid, ctx, NULL, GFP_KERNEL);
+	if (ptr != (void *)ctx)
+		dev_warn(&wq->idxd->pdev->dev, "xarray cmpxchg failed for pasid %u\n",
+			 ctx->pasid);
+	mutex_unlock(&wq->uc_lock);
+}
+
 static int idxd_cdev_open(struct inode *inode, struct file *filp)
 {
 	struct idxd_user_context *ctx;
@@ -108,20 +140,25 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 
 		pasid = iommu_sva_get_pasid(sva);
 		if (pasid == IOMMU_PASID_INVALID) {
-			iommu_sva_unbind_device(sva);
 			rc = -EINVAL;
-			goto failed;
+			goto failed_get_pasid;
 		}
 
 		ctx->sva = sva;
 		ctx->pasid = pasid;
 
+		mutex_lock(&wq->uc_lock);
+		rc = xa_insert(&wq->upasid_xa, pasid, ctx, GFP_KERNEL);
+		mutex_unlock(&wq->uc_lock);
+		if (rc < 0)
+			dev_warn(dev, "PASID entry already exist in xarray.\n");
+
 		if (wq_dedicated(wq)) {
 			rc = idxd_wq_set_pasid(wq, pasid);
 			if (rc < 0) {
 				iommu_sva_unbind_device(sva);
 				dev_err(dev, "wq set pasid failed: %d\n", rc);
-				goto failed;
+				goto failed_set_pasid;
 			}
 		}
 	}
@@ -130,6 +167,12 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	mutex_unlock(&wq->wq_lock);
 	return 0;
 
+ failed_set_pasid:
+	if (device_user_pasid_enabled(idxd))
+		idxd_xa_pasid_remove(ctx);
+ failed_get_pasid:
+	if (device_user_pasid_enabled(idxd))
+		iommu_sva_unbind_device(sva);
  failed:
 	mutex_unlock(&wq->wq_lock);
 	kfree(ctx);
@@ -193,6 +236,7 @@ static int idxd_cdev_release(struct inode *node, struct file *filep)
 	if (ctx->sva) {
 		idxd_cdev_evl_drain_pasid(wq, ctx->pasid);
 		iommu_sva_unbind_device(ctx->sva);
+		idxd_xa_pasid_remove(ctx);
 	}
 
 	kfree(ctx);
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 8f3b0fbd04ae..f92db20015fb 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -127,6 +127,12 @@ struct idxd_pmu {
 
 #define IDXD_MAX_PRIORITY	0xf
 
+enum {
+	COUNTER_FAULTS = 0,
+	COUNTER_FAULT_FAILS,
+	COUNTER_MAX
+};
+
 enum idxd_wq_state {
 	IDXD_WQ_DISABLED = 0,
 	IDXD_WQ_ENABLED,
@@ -215,6 +221,10 @@ struct idxd_wq {
 	char name[WQ_NAME_SIZE + 1];
 	u64 max_xfer_bytes;
 	u32 max_batch_size;
+
+	/* Lock to protect upasid_xa access. */
+	struct mutex uc_lock;
+	struct xarray upasid_xa;
 };
 
 struct idxd_engine {
@@ -707,6 +717,7 @@ void idxd_cdev_remove(void);
 int idxd_cdev_get_major(struct idxd_device *idxd);
 int idxd_wq_add_cdev(struct idxd_wq *wq);
 void idxd_wq_del_cdev(struct idxd_wq *wq);
+void idxd_user_counter_increment(struct idxd_wq *wq, u32 pasid, int index);
 
 /* perfmon */
 #if IS_ENABLED(CONFIG_INTEL_IDXD_PERFMON)
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 73fb9c74ed20..9b3e7f0770d1 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -206,6 +206,8 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 			}
 			bitmap_copy(wq->opcap_bmap, idxd->opcap_bmap, IDXD_MAX_OPCAP_BITS);
 		}
+		mutex_init(&wq->uc_lock);
+		xa_init(&wq->upasid_xa);
 		idxd->wqs[i] = wq;
 	}
 
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 894a73e56cb6..69e0b8e1b3cf 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -241,6 +241,7 @@ static void idxd_evl_fault_work(struct work_struct *work)
 			evl->batch_fail[entry_head->batch_id] = false;
 
 		copy_size = cr_size;
+		idxd_user_counter_increment(wq, entry_head->pasid, COUNTER_FAULTS);
 		break;
 	case DSA_COMP_BATCH_EVL_ERR:
 		bf = &evl->batch_fail[entry_head->batch_id];
@@ -252,6 +253,7 @@ static void idxd_evl_fault_work(struct work_struct *work)
 			*result = 1;
 			*bf = false;
 		}
+		idxd_user_counter_increment(wq, entry_head->pasid, COUNTER_FAULTS);
 		break;
 	case DSA_COMP_DRAIN_EVL:
 		copy_size = cr_size;
@@ -275,6 +277,7 @@ static void idxd_evl_fault_work(struct work_struct *work)
 	switch (fault->status) {
 	case DSA_COMP_CRA_XLAT:
 		if (copied != copy_size) {
+			idxd_user_counter_increment(wq, entry_head->pasid, COUNTER_FAULT_FAILS);
 			dev_err(dev, "Failed to write to completion record: (%d:%d)\n",
 				copy_size, copied);
 			if (entry_head->batch)
@@ -283,6 +286,7 @@ static void idxd_evl_fault_work(struct work_struct *work)
 		break;
 	case DSA_COMP_BATCH_EVL_ERR:
 		if (copied != copy_size) {
+			idxd_user_counter_increment(wq, entry_head->pasid, COUNTER_FAULT_FAILS);
 			dev_err(dev, "Failed to write to batch completion record: (%d:%d)\n",
 				copy_size, copied);
 		}
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 8b9dfa0d2b99..465d2e7627e4 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1292,6 +1292,7 @@ static void idxd_conf_wq_release(struct device *dev)
 
 	bitmap_free(wq->opcap_bmap);
 	kfree(wq->wqcfg);
+	xa_destroy(&wq->upasid_xa);
 	kfree(wq);
 }
 
-- 
2.37.1

