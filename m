Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AB66B7ECA
	for <lists+dmaengine@lfdr.de>; Mon, 13 Mar 2023 18:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjCMRGa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Mar 2023 13:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjCMRGS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Mar 2023 13:06:18 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1BC78CAE;
        Mon, 13 Mar 2023 10:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678727126; x=1710263126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MnpLq/KXUUwPvadOwJMGjEgqddJKg/VVIpHgp4pkIOQ=;
  b=fLauRILh8v7pQ32opo/DiKBMYkN0mgVkDC0VINHdbo2E+a7F+zCktxGV
   ulbi5wCTlUG0Jh2kVhMNompeQeKk+aimqo2AmvwZSc36O9MshLn1qaYUy
   K6eGDjG2yDbQn/Cga2fAdR5MnHh7yGFgj2xFqquoio/OSA/9j3v2urm+I
   g9nwP2/fiJ9tpSL3peXGrkl+QLilXPwTQpGnLajORovTcKLd49Snpx9LC
   l/bWSEd7CoePdjaClSt4Zl6kjQSOhKGf8nuXLeSugVkcF1CuS9wDdWLNG
   z9JA4H94u/IyNiw/qJol0plF9BC9cn4hIncrBQzuaG2WVb5OXuV5sKmW8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="334679660"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="334679660"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 10:02:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="708950920"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="708950920"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga008.jf.intel.com with ESMTP; 13 Mar 2023 10:02:41 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v3 08/16] dmaengine: idxd: define idxd_copy_cr()
Date:   Mon, 13 Mar 2023 10:02:11 -0700
Message-Id: <20230313170219.1956012-9-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230313170219.1956012-1-fenghua.yu@intel.com>
References: <20230313170219.1956012-1-fenghua.yu@intel.com>
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

Define idxd_copy_cr() to copy completion record to fault address in
user address that is found by wq and PASID.

It will be used to write the user's completion record that the hardware
device is not able to write to due to user page fault.

An xarray is added to associate the PASID and mm with the
struct idxd_user_context so mm can be found by PASID and wq.

Although access_remote_vm() can access remote mm, it's not exported
and should not be exported because driver callers may easily make
mistakes by missing mm reference. Since access_remote_vm() cannot be
called directly, _idxd_copy_cr() implements a simplified version of
access_remote_vm() to copy completion record to a remote mm.
Thus, there is duplicate code between the two functions.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
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
 drivers/dma/idxd/cdev.c  | 127 +++++++++++++++++++++++++++++++++++++--
 drivers/dma/idxd/idxd.h  |   6 ++
 drivers/dma/idxd/init.c  |   2 +
 drivers/dma/idxd/sysfs.c |   1 +
 4 files changed, 131 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index cbe29e1a6a44..17d83ecf54e9 100644
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
@@ -418,3 +448,90 @@ void idxd_cdev_remove(void)
 		ida_destroy(&ictx[i].minor_ida);
 	}
 }
+
+static int _idxd_copy_cr(struct mm_struct *mm, unsigned long addr, void *cr,
+			 int len)
+{
+	void *old_cr = cr;
+
+	if (mmap_read_lock_killable(mm))
+		return 0;
+
+	/*
+	 * Page backing on user address is not available. Need to get the
+	 * pages and write the completion record to the pages.
+	 */
+	while (len) {
+		struct vm_area_struct *vma;
+		struct page *page = NULL;
+		int bytes, ret, offset;
+		void *maddr;
+
+		ret = get_user_pages_remote(mm, addr, 1, FOLL_WRITE,
+					    &page, &vma, NULL);
+		if (ret <= 0)
+			break;
+
+		bytes = len;
+		offset = addr & (PAGE_SIZE - 1);
+		if (bytes > PAGE_SIZE - offset)
+			bytes = PAGE_SIZE - offset;
+
+		maddr = kmap_local_page(page);
+		copy_to_user_page(vma, page, addr,
+				  maddr + offset, cr, bytes);
+		set_page_dirty_lock(page);
+		kunmap_local(maddr);
+		put_page(page);
+
+		len -= bytes;
+		cr += bytes;
+		addr += bytes;
+	}
+
+	mmap_read_unlock(mm);
+
+	return cr - old_cr;
+}
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
+ * Return: number of bytes copied.
+ */
+int idxd_copy_cr(struct idxd_wq *wq, ioasid_t pasid, unsigned long addr,
+		 void *cr, int len)
+{
+	struct device *dev = &wq->idxd->pdev->dev;
+	struct idxd_user_context *ctx;
+	struct mm_struct *mm;
+	int copied = 0;
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
+	if (!mmget_not_zero(mm)) {
+		dev_warn(dev, "Cannot get mm\n");
+		goto out;
+	}
+
+	copied = _idxd_copy_cr(mm, addr, cr, len);
+	mmput(mm);
+
+out:
+	mutex_unlock(&wq->uc_lock);
+
+	return copied;
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

