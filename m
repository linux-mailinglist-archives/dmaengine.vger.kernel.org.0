Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E0A6B304B
	for <lists+dmaengine@lfdr.de>; Thu,  9 Mar 2023 23:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjCIWSO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Mar 2023 17:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjCIWSM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Mar 2023 17:18:12 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6523F1DBB5;
        Thu,  9 Mar 2023 14:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678400290; x=1709936290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RLB9QOgu5WoBCT5LDKUKMG2e08HiAC7PAVH7EE4gqZc=;
  b=Wmsfkka04S206lkVTC4JTKNbNLmIhVRoykVjJwIBepMqUksZqr+/c2CV
   D2Eo1LWxy5oAp4NDYSgd1LYVZYT0urwDLQe6b5UUdxzPHijaqI+oxJSb/
   38BDssHcQrDypaknW3+hihHWCC43Vmt1UIteBPrHN6zBR2eH4TIwdF6ys
   DLFwKbZva8g9s8AOfWP0uApO9BPIHhQg77efT8O7C/D+POwwC7wp/8r6P
   QqBLQHlL8mK8ScqsEkQWsP/BfZ7YwPf8KiPvQLnxLI7IdbwORus88//YF
   QvO/RZSqVuheWWqSMXn+FQ8obp/J3nB//ooEmyipemEZc/Qsl4X8/3WVJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="364235216"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="364235216"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 14:18:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="707788836"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="707788836"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by orsmga008.jf.intel.com with ESMTP; 09 Mar 2023 14:18:08 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     "Robin Murphy" <robin.murphy@arm.com>,
        "Will Deacon" <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v5 2/7] iommu/sva: Move PASID helpers to sva code
Date:   Thu,  9 Mar 2023 14:21:54 -0800
Message-Id: <20230309222159.487826-4-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230309222159.487826-1-jacob.jun.pan@linux.intel.com>
References: <20230309222159.487826-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Preparing to remove IOASID infrastructure, PASID management will be
under SVA code. Decouple mm code from IOASID. Use iommu-help.h instead
of iommu.h to prevent circular inclusion.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
v5:
	- move definition of helpers to iommu code to be consistent with
	  declarations. (Kevin)
	- fix patch partitioning bug (Baolu)
v4:
	- delete and open code mm_set_pasid
	- keep mm_init_pasid() as inline for fork performance
---
 drivers/iommu/iommu-sva.c    | 10 +++++++++-
 include/linux/ioasid.h       |  2 +-
 include/linux/iommu-helper.h | 12 ++++++++++++
 include/linux/sched/mm.h     | 27 +--------------------------
 4 files changed, 23 insertions(+), 28 deletions(-)

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
index af1c9d62e642..2c502e77ee78 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -4,8 +4,8 @@
 
 #include <linux/types.h>
 #include <linux/errno.h>
+#include <linux/iommu-helper.h>
 
-#define INVALID_IOASID ((ioasid_t)-1)
 typedef unsigned int ioasid_t;
 typedef ioasid_t (*ioasid_alloc_fn_t)(ioasid_t min, ioasid_t max, void *data);
 typedef void (*ioasid_free_fn_t)(ioasid_t ioasid, void *data);
diff --git a/include/linux/iommu-helper.h b/include/linux/iommu-helper.h
index 74be34f3a20a..be1451a05a15 100644
--- a/include/linux/iommu-helper.h
+++ b/include/linux/iommu-helper.h
@@ -6,6 +6,7 @@
 #include <linux/log2.h>
 #include <linux/math.h>
 #include <linux/types.h>
+#include <linux/mm_types.h>
 
 static inline unsigned long iommu_device_max_index(unsigned long size,
 						   unsigned long offset,
@@ -41,4 +42,15 @@ static inline unsigned long iommu_num_pages(unsigned long addr,
 	return DIV_ROUND_UP(size, io_page_size);
 }
 
+#define INVALID_IOASID	(-1U)
+#ifdef CONFIG_IOMMU_SVA
+static inline void mm_pasid_init(struct mm_struct *mm)
+{
+	mm->pasid = INVALID_IOASID;
+}
+void mm_pasid_drop(struct mm_struct *mm);
+#else
+static inline void mm_pasid_init(struct mm_struct *mm) {}
+static inline void mm_pasid_drop(struct mm_struct *mm) {}
+#endif
 #endif
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 2a243616f222..f341a7a855e8 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -8,7 +8,7 @@
 #include <linux/mm_types.h>
 #include <linux/gfp.h>
 #include <linux/sync_core.h>
-#include <linux/ioasid.h>
+#include <linux/iommu-helper.h>
 
 /*
  * Routines for handling mm_structs
@@ -451,29 +451,4 @@ static inline void membarrier_update_current_mm(struct mm_struct *next_mm)
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
-- 
2.25.1

