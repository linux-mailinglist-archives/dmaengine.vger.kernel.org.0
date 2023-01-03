Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5700965C40A
	for <lists+dmaengine@lfdr.de>; Tue,  3 Jan 2023 17:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237907AbjACQfb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Jan 2023 11:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbjACQfU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Jan 2023 11:35:20 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDF2EE18
        for <dmaengine@vger.kernel.org>; Tue,  3 Jan 2023 08:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672763719; x=1704299719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GtmBCgPQ7gXrp24526md6jcY75sBMBIo63hdxSQy1wY=;
  b=bIchkGT3s1Hw70OOaMxT4BSvSdaUCYeQNgMsHPaAYNjfSCRBsfCJBYBF
   ez36jELNBMjo+1poIYMhIwPnEGK2+RnqjrJ5gwxBaFnf6llQmScxZn2wb
   pvirt/bhAKIJsz4V0j7D9LWuvXgEHdU6hoyeYeYFbf+rRY8CQDbSSkId4
   NMhuJZkwTbYxK/iPsMPdq6HZ1D27bKOPhJsw/rGGQaeiBKb3FVR0XJMfp
   OuLp8pDVifEjjUOCGCAsDKQKlCo/aKF3WZeX1+/+nTG9ho4Mt0bNmo+CT
   VONA3fipa0BVFfw5HnSVcoiLQBzJvulP+i4UHf1b1ehlJ8aYy9DCxao+r
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="302072339"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="302072339"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 08:35:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="604858564"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="604858564"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga003.jf.intel.com with ESMTP; 03 Jan 2023 08:35:16 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     "Fenghua Yu" <fenghua.yu@intel.com>, dmaengine@vger.kernel.org,
        Tony Zhu <tony.zhu@intel.com>
Subject: [PATCH 13/17] dmaengine: idxd: add per file user counters for completion record faults
Date:   Tue,  3 Jan 2023 08:35:01 -0800
Message-Id: <20230103163505.1569356-14-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230103163505.1569356-1-fenghua.yu@intel.com>
References: <20230103163505.1569356-1-fenghua.yu@intel.com>
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
 drivers/dma/idxd/irq.c   |  7 +++++-
 drivers/dma/idxd/sysfs.c |  1 +
 5 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index eed0bc15951a..baec95911182 100644
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
index 00edf68e3528..3e0f113368fa 100644
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
@@ -705,6 +715,7 @@ void idxd_cdev_remove(void);
 int idxd_cdev_get_major(struct idxd_device *idxd);
 int idxd_wq_add_cdev(struct idxd_wq *wq);
 void idxd_wq_del_cdev(struct idxd_wq *wq);
+void idxd_user_counter_increment(struct idxd_wq *wq, u32 pasid, int index);
 
 /* perfmon */
 #if IS_ENABLED(CONFIG_INTEL_IDXD_PERFMON)
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index ddb9b13f3c3c..564c025b9b7e 100644
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
index 18245f82d367..241ece8eb9fc 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -250,6 +250,7 @@ static void idxd_evl_fault_work(struct work_struct *work)
 			evl->batch_fail[entry_head->batch_id] = false;
 
 		copy_size = cr_size;
+		idxd_user_counter_increment(wq, entry_head->pasid, COUNTER_FAULTS);
 		break;
 	case DSA_COMP_BATCH_EVL_ERR:
 		bf = &evl->batch_fail[entry_head->batch_id];
@@ -261,6 +262,7 @@ static void idxd_evl_fault_work(struct work_struct *work)
 			*result = 1;
 			*bf = false;
 		}
+		idxd_user_counter_increment(wq, entry_head->pasid, COUNTER_FAULTS);
 		break;
 	case DSA_COMP_DRAIN_EVL:
 		copy_size = cr_size;
@@ -278,6 +280,7 @@ static void idxd_evl_fault_work(struct work_struct *work)
 	switch (fault->status) {
 	case DSA_COMP_CRA_XLAT:
 		if (copied != copy_size) {
+			idxd_user_counter_increment(wq, entry_head->pasid, COUNTER_FAULT_FAILS);
 			dev_err(dev, "Failed to write to completion record: (%d:%d)\n",
 				copy_size, copied);
 			if (entry_head->batch)
@@ -285,9 +288,11 @@ static void idxd_evl_fault_work(struct work_struct *work)
 		}
 		break;
 	case DSA_COMP_BATCH_EVL_ERR:
-		if (copied != copy_size)
+		if (copied != copy_size) {
+			idxd_user_counter_increment(wq, entry_head->pasid, COUNTER_FAULT_FAILS);
 			dev_err(dev, "Failed to write to batch completion record: (%d:%d)\n",
 				copy_size, copied);
+		}
 		break;
 	case DSA_COMP_DRAIN_EVL:
 		if (copied != copy_size)
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index ea696e3c5680..137126781362 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1292,6 +1292,7 @@ static void idxd_conf_wq_release(struct device *dev)
 
 	bitmap_free(wq->opcap_bmap);
 	kfree(wq->wqcfg);
+	xa_destroy(&wq->upasid_xa);
 	kfree(wq);
 }
 
-- 
2.32.0

