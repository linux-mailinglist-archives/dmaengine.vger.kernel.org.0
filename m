Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CC76B82E7
	for <lists+dmaengine@lfdr.de>; Mon, 13 Mar 2023 21:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjCMUiL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Mar 2023 16:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjCMUiJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Mar 2023 16:38:09 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39404C15;
        Mon, 13 Mar 2023 13:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678739887; x=1710275887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1P8fTuJy1aEitfqN8h9LKhDqmvPsenvZ0+tji/3Yisg=;
  b=leIT066p+LcIIps/t+20pbD73+dnB+BQ7632y/rHU+tacVwA+FNZGa9u
   kUtB6BVOxEQbOKz2YznuesdRvOHv4xOBDAw2ithazPEidOFKyerZF1She
   mJ+wgeqmLIvL/UmLFVlY7eRxzR8Nnqj6gatHJQLT1sFI/96qP7EifPWUl
   JacZyYhh8AsA+4vpeU+Fqb+65MKGm/mlwtaxCe74YmrNQhPVpxu/SGYeM
   7R76IWE2ibQ+2dM/oj9r55pb9B90ipxH3YDs55ABlXQLlRyT3K28IL4Y+
   x8jmVkV+HtI+GnwVJHyh1dDTJHAEeECUYi900BG93v6q+/sMkDth7eiQ5
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="334732045"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="334732045"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 13:38:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="802584774"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="802584774"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by orsmga004.jf.intel.com with ESMTP; 13 Mar 2023 13:38:04 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     "Will Deacon" <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v6 2/7] iommu/sva: Move PASID helpers to sva code
Date:   Mon, 13 Mar 2023 13:41:53 -0700
Message-Id: <20230313204158.1495067-3-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230313204158.1495067-1-jacob.jun.pan@linux.intel.com>
References: <20230313204158.1495067-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Preparing to remove IOASID infrastructure, PASID management will be
under SVA code. Decouple mm code from IOASID.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
v6:
	- put helpers under iommu.h instead of iommu-helper.h
v5:
	- move definition of helpers to iommu code to be consistent with
	  declarations. (Kevin)
	- fix patch partitioning bug (Baolu)
v4:
	- delete and open code mm_set_pasid
	- keep mm_init_pasid() as inline for fork performance
---
 drivers/iommu/iommu-sva.c | 10 +++++++++-
 include/linux/ioasid.h    |  6 +-----
 include/linux/iommu.h     | 14 +++++++++++++-
 include/linux/sched/mm.h  | 26 --------------------------
 kernel/fork.c             |  3 +++
 5 files changed, 26 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 24bf9b2b58aa..fcfdc80a3939 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -44,7 +44,7 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 	if (!pasid_valid(pasid))
 		ret = -ENOMEM;
 	else
-		mm_pasid_set(mm, pasid);
+		mm->pasid = pasid;
 out:
 	mutex_unlock(&iommu_sva_lock);
 	return ret;
@@ -238,3 +238,11 @@ iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
 
 	return status;
 }
+
+void mm_pasid_drop(struct mm_struct *mm)
+{
+	if (pasid_valid(mm->pasid)) {
+		ioasid_free(mm->pasid);
+		mm->pasid = INVALID_IOASID;
+	}
+}
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index af1c9d62e642..bdee937da907 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -4,8 +4,8 @@
 
 #include <linux/types.h>
 #include <linux/errno.h>
+#include <linux/iommu.h>
 
-#define INVALID_IOASID ((ioasid_t)-1)
 typedef unsigned int ioasid_t;
 typedef ioasid_t (*ioasid_alloc_fn_t)(ioasid_t min, ioasid_t max, void *data);
 typedef void (*ioasid_free_fn_t)(ioasid_t ioasid, void *data);
@@ -40,10 +40,6 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
 int ioasid_set_data(ioasid_t ioasid, void *data);
-static inline bool pasid_valid(ioasid_t ioasid)
-{
-	return ioasid != INVALID_IOASID;
-}
 
 #else /* !CONFIG_IOASID */
 static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 6595454d4f48..d3f81dc6e4dd 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -13,7 +13,6 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/of.h>
-#include <linux/ioasid.h>
 #include <uapi/linux/iommu.h>
 
 #define IOMMU_READ	(1 << 0)
@@ -192,6 +191,8 @@ enum iommu_dev_features {
 };
 
 #define IOMMU_PASID_INVALID	(-1U)
+typedef unsigned int ioasid_t;
+#define INVALID_IOASID ((ioasid_t)-1)
 
 #ifdef CONFIG_IOMMU_API
 
@@ -1172,7 +1173,16 @@ static inline bool tegra_dev_iommu_get_stream_id(struct device *dev, u32 *stream
 	return false;
 }
 
+static inline bool pasid_valid(ioasid_t ioasid)
+{
+	return ioasid != INVALID_IOASID;
+}
 #ifdef CONFIG_IOMMU_SVA
+static inline void mm_pasid_init(struct mm_struct *mm)
+{
+	mm->pasid = INVALID_IOASID;
+}
+void mm_pasid_drop(struct mm_struct *mm);
 struct iommu_sva *iommu_sva_bind_device(struct device *dev,
 					struct mm_struct *mm);
 void iommu_sva_unbind_device(struct iommu_sva *handle);
@@ -1192,6 +1202,8 @@ static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 {
 	return IOMMU_PASID_INVALID;
 }
+static inline void mm_pasid_init(struct mm_struct *mm) {}
+static inline void mm_pasid_drop(struct mm_struct *mm) {}
 #endif /* CONFIG_IOMMU_SVA */
 
 #endif /* __LINUX_IOMMU_H */
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 2a243616f222..da9712a3ba73 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -8,7 +8,6 @@
 #include <linux/mm_types.h>
 #include <linux/gfp.h>
 #include <linux/sync_core.h>
-#include <linux/ioasid.h>
 
 /*
  * Routines for handling mm_structs
@@ -451,29 +450,4 @@ static inline void membarrier_update_current_mm(struct mm_struct *next_mm)
 }
 #endif
 
-#ifdef CONFIG_IOMMU_SVA
-static inline void mm_pasid_init(struct mm_struct *mm)
-{
-	mm->pasid = INVALID_IOASID;
-}
-
-/* Associate a PASID with an mm_struct: */
-static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid)
-{
-	mm->pasid = pasid;
-}
-
-static inline void mm_pasid_drop(struct mm_struct *mm)
-{
-	if (pasid_valid(mm->pasid)) {
-		ioasid_free(mm->pasid);
-		mm->pasid = INVALID_IOASID;
-	}
-}
-#else
-static inline void mm_pasid_init(struct mm_struct *mm) {}
-static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid) {}
-static inline void mm_pasid_drop(struct mm_struct *mm) {}
-#endif
-
 #endif /* _LINUX_SCHED_MM_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index f68954d05e89..d75646bf1387 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -97,6 +97,9 @@
 #include <linux/io_uring.h>
 #include <linux/bpf.h>
 #include <linux/stackprotector.h>
+#ifdef CONFIG_IOMMU_SVA
+#include <linux/iommu.h>
+#endif
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
-- 
2.25.1

