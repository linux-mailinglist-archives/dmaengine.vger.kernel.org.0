Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E246DB53F
	for <lists+dmaengine@lfdr.de>; Fri,  7 Apr 2023 22:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjDGUbf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Apr 2023 16:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjDGUbb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Apr 2023 16:31:31 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F56C159;
        Fri,  7 Apr 2023 13:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680899490; x=1712435490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SwpeRxc+FAwpZVQhpK7HOzcDqkraAg+wbK5hUXTJgoQ=;
  b=J2w5uBxvIJMF8MJKeZ3HtIHXj1YCSMfMOeC+ejqqttFZj0A578Jg41lG
   Kxcn9EB2wWRoAIriHVHZUVP6mkrSbSTSU6kJ79CcHd16ZDbqP2GJQon+Y
   12VgyWqezv7nj3HjIpvM1PdFPK9MWAmq+1crZV4KGvleRD5+/HOoq664+
   meqCynQ1N26PNirvJUVgU+KfUsZkMtyEzTQqhe4Sb3Xy/79naKzeIG85n
   eyHrapTB90ItzdGK7tiz6SWfSxqQKRyboj1Pmy1QO5LLYw3pOkE26Fm4H
   jRhVfMhuQwoqr20i8zoL8B8hhuy6jXe+7bEG+kVxbk2josjbUl47a+Ix0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="408196865"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="408196865"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 13:31:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="681125885"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="681125885"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga007.jf.intel.com with ESMTP; 07 Apr 2023 13:31:26 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Tony Luck <tony.luck@intel.com>, Tony Zhu <tony.zhu@intel.com>
Subject: [PATCH v4 08/16] dmaengine: idxd: add idxd_copy_cr() to copy user completion record during page fault handling
Date:   Fri,  7 Apr 2023 13:31:35 -0700
Message-Id: <20230407203143.2189681-9-fenghua.yu@intel.com>
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

Define idxd_copy_cr() to copy completion record to fault address in
user address that is found by work queue (wq) and PASID.

It will be used to write the user's completion record that the hardware
device is not able to write due to user completion record page fault.

An xarray is added to associate the PASID and mm with the
struct idxd_user_context so mm can be found by PASID and wq.

It is called when handling the completion record fault in a kernel thread
context. Switch to the mm using kthread_use_vm() and copy the
completion record to the mm via copy_to_user(). Once the copy is
completed, switch back to the current mm using kthread_unuse_mm().

Suggested-by: Christoph Hellwig <hch@infradead.org>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Tony Luck <tony.luck@intel.com>
Tested-by: Tony Zhu <tony.zhu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
v4:
- Use kthread_use_mm(), copy_to_user(), and kthread_unuse_mm() to switch
  to the mm, copy completion record to the mm, and switch back to the
  current mm. It's simpler than previous access_remote_vm() or emulation
  ways (Jason Gunthorpe, Christoph Hellwig, Tony Luck).

v3:
- Since iommu_sva_find() will be removed in IOMMU and access_remote_vm()
  cannot be exported, the completion record copy function idxd_copy_cr()
  is rewritten by maintaining and finding mm in xarray and copy completion
  record to the mm.
  Please check discussion on iommu_sva_find() will be removed and
  access_remote_vm() cannot be exported:
  1. https://lore.kernel.org/lkml/ZAjSsm4%2FPDRqViwa@nvidia.com/
  2. https://lore.kernel.org/lkml/20230306163138.587484-1-fenghua.yu@intel.com/T/#m1fc97725a0e56ea269c8bdabacee447070d51846

v2:
- Define and export iommu_access_remote_vm() for IDXD driver to write
  completion record to user address space. This change removes
  patch 8 and 9 in v1 (Alistair Popple)
 drivers/dma/idxd/cdev.c  | 107 +++++++++++++++++++++++++++++++++++++--
 drivers/dma/idxd/idxd.h  |   6 +++
 drivers/dma/idxd/init.c  |   2 +
 drivers/dma/idxd/sysfs.c |   1 +
 4 files changed, 111 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index cbe29e1a6a44..8b8a0a0fb054 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -11,7 +11,9 @@
 #include <linux/fs.h>
 #include <linux/poll.h>
 #include <linux/iommu.h>
+#include <linux/highmem.h>
 #include <uapi/linux/idxd.h>
+#include <linux/xarray.h>
 #include "registers.h"
 #include "idxd.h"
 
@@ -34,6 +36,7 @@ struct idxd_user_context {
 	struct idxd_wq *wq;
 	struct task_struct *task;
 	unsigned int pasid;
+	struct mm_struct *mm;
 	unsigned int flags;
 	struct iommu_sva *sva;
 };
@@ -68,6 +71,19 @@ static inline struct idxd_wq *inode_wq(struct inode *inode)
 	return idxd_cdev->wq;
 }
 
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
@@ -108,20 +124,26 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 
 		pasid = iommu_sva_get_pasid(sva);
 		if (pasid == IOMMU_PASID_INVALID) {
-			iommu_sva_unbind_device(sva);
 			rc = -EINVAL;
-			goto failed;
+			goto failed_get_pasid;
 		}
 
 		ctx->sva = sva;
 		ctx->pasid = pasid;
+		ctx->mm = current->mm;
+
+		mutex_lock(&wq->uc_lock);
+		rc = xa_insert(&wq->upasid_xa, pasid, ctx, GFP_KERNEL);
+		mutex_unlock(&wq->uc_lock);
+		if (rc < 0)
+			dev_warn(dev, "PASID entry already exist in xarray.\n");
 
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
@@ -130,7 +152,13 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	mutex_unlock(&wq->wq_lock);
 	return 0;
 
- failed:
+failed_set_pasid:
+	if (device_user_pasid_enabled(idxd))
+		idxd_xa_pasid_remove(ctx);
+failed_get_pasid:
+	if (device_user_pasid_enabled(idxd))
+		iommu_sva_unbind_device(sva);
+failed:
 	mutex_unlock(&wq->wq_lock);
 	kfree(ctx);
 	return rc;
@@ -161,8 +189,10 @@ static int idxd_cdev_release(struct inode *node, struct file *filep)
 		}
 	}
 
-	if (ctx->sva)
+	if (ctx->sva) {
 		iommu_sva_unbind_device(ctx->sva);
+		idxd_xa_pasid_remove(ctx);
+	}
 	kfree(ctx);
 	mutex_lock(&wq->wq_lock);
 	idxd_wq_put(wq);
@@ -418,3 +448,70 @@ void idxd_cdev_remove(void)
 		ida_destroy(&ictx[i].minor_ida);
 	}
 }
+
+/**
+ * idxd_copy_cr - copy completion record to user address space found by wq and
+ *		  PASID
+ * @wq:		work queue
+ * @pasid:	PASID
+ * @addr:	user fault address to write
+ * @cr:		completion record
+ * @len:	number of bytes to copy
+ *
+ * This is called by a work that handles completion record fault.
+ *
+ * Return: number of bytes copied.
+ */
+int idxd_copy_cr(struct idxd_wq *wq, ioasid_t pasid, unsigned long addr,
+		 void *cr, int len)
+{
+	struct device *dev = &wq->idxd->pdev->dev;
+	int left = len, status_size = 1;
+	struct idxd_user_context *ctx;
+	struct mm_struct *mm;
+
+	mutex_lock(&wq->uc_lock);
+
+	ctx = xa_load(&wq->upasid_xa, pasid);
+	if (!ctx) {
+		dev_warn(dev, "No user context\n");
+		goto out;
+	}
+
+	mm = ctx->mm;
+	/*
+	 * The completion record fault handling work is running in kernel
+	 * thread context. It temporarily switches to the mm to copy cr
+	 * to addr in the mm.
+	 */
+	kthread_use_mm(mm);
+	left = copy_to_user((void __user *)addr + status_size, cr + status_size,
+			    len - status_size);
+	/*
+	 * Copy status only after the rest of completion record is copied
+	 * successfully so that the user gets the complete completion record
+	 * when a non-zero status is polled.
+	 */
+	if (!left) {
+		u8 status;
+
+		/*
+		 * Ensure that the completion record's status field is written
+		 * after the rest of the completion record has been written.
+		 * This ensures that the user receives the correct completion
+		 * record information once polling for a non-zero status.
+		 */
+		wmb();
+		status = *(u8 *)cr;
+		if (put_user(status, (u8 __user *)addr))
+			left += status_size;
+	} else {
+		left += status_size;
+	}
+	kthread_unuse_mm(mm);
+
+out:
+	mutex_unlock(&wq->uc_lock);
+
+	return len - left;
+}
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index c5d99c179902..b3f9a12adce2 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -215,6 +215,10 @@ struct idxd_wq {
 	char name[WQ_NAME_SIZE + 1];
 	u64 max_xfer_bytes;
 	u32 max_batch_size;
+
+	/* Lock to protect upasid_xa access. */
+	struct mutex uc_lock;
+	struct xarray upasid_xa;
 };
 
 struct idxd_engine {
@@ -702,6 +706,8 @@ void idxd_cdev_remove(void);
 int idxd_cdev_get_major(struct idxd_device *idxd);
 int idxd_wq_add_cdev(struct idxd_wq *wq);
 void idxd_wq_del_cdev(struct idxd_wq *wq);
+int idxd_copy_cr(struct idxd_wq *wq, ioasid_t pasid, unsigned long addr,
+		 void *buf, int len);
 
 /* perfmon */
 #if IS_ENABLED(CONFIG_INTEL_IDXD_PERFMON)
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index a7c98fac7a85..912753a99747 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -200,6 +200,8 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 			}
 			bitmap_copy(wq->opcap_bmap, idxd->opcap_bmap, IDXD_MAX_OPCAP_BITS);
 		}
+		mutex_init(&wq->uc_lock);
+		xa_init(&wq->upasid_xa);
 		idxd->wqs[i] = wq;
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

