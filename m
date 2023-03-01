Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2443E6A780B
	for <lists+dmaengine@lfdr.de>; Thu,  2 Mar 2023 00:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjCAXxv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Mar 2023 18:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjCAXxu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Mar 2023 18:53:50 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB40D1D91F;
        Wed,  1 Mar 2023 15:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677714828; x=1709250828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OmchmeFQuGlSdMLx91I/F0FSRiJuQKOQ2C+PJU8/67A=;
  b=hnQG1FIO9L0PiudKA9d4Y5qQwmNDM0aAY8NBl1NeedgcGNK4OoveTARZ
   RLevYncOQOMPrHEch146z9X1b0FCDq0XsmQccY8PXOeRIlyLW6KvXsepl
   b60AKFgtqaBUSPuo6Nnrx3WgN4g/WZ5Gdku4ScYAr8L7+RG7T/imxAkiM
   Y5QfB6UZeFQq7uCWmWJVVCHmF+1AMyLd9m0ZHR4NOqTPmLdUxXnONdxi7
   IXoHKEWBHUwPMwsAmcKfJ4dY1zrQrZ6w4WpdPvJE/9kptDP2OT+Is33u0
   s02rjtGVHxHfNKnKHrF12LPOuUSOof6UChoBdHTEseuE8lyndTMKNNnfp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="397127638"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="397127638"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 15:53:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="1003880324"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="1003880324"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by fmsmga005.fm.intel.com with ESMTP; 01 Mar 2023 15:53:01 -0800
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
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 2/6] iommu/sva: Move PASID helpers to sva code
Date:   Wed,  1 Mar 2023 15:56:42 -0800
Message-Id: <20230301235646.2692846-3-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230301235646.2692846-1-jacob.jun.pan@linux.intel.com>
References: <20230301235646.2692846-1-jacob.jun.pan@linux.intel.com>
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
under SVA code. Decouple mm code from IOASID. Use iommu-help.h instead
of iommu.h to prevent circular inclusion.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
v4: (Jason's comments)
	- delete and open code mm_set_pasid
	- keep mm_init_pasid() as inline for fork performance
---
 drivers/iommu/iommu-sva.c    | 10 +++++++++-
 include/linux/ioasid.h       |  2 +-
 include/linux/iommu-helper.h |  1 +
 include/linux/sched/mm.h     | 18 ++----------------
 4 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 24bf9b2b58aa..376b2a9e2543 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -44,7 +44,7 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 	if (!pasid_valid(pasid))
 		ret = -ENOMEM;
 	else
-		mm_pasid_set(mm, pasid);
+		mm->pasid = ret;
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
index 74be34f3a20a..0aa922f6bfad 100644
--- a/include/linux/iommu-helper.h
+++ b/include/linux/iommu-helper.h
@@ -40,5 +40,6 @@ static inline unsigned long iommu_num_pages(unsigned long addr,
 
 	return DIV_ROUND_UP(size, io_page_size);
 }
+#define INVALID_IOASID	(-1U)
 
 #endif
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 2a243616f222..ae5a3f16b321 100644
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
@@ -456,23 +456,9 @@ static inline void mm_pasid_init(struct mm_struct *mm)
 {
 	mm->pasid = INVALID_IOASID;
 }
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
+void mm_pasid_drop(struct mm_struct *mm);
 #else
 static inline void mm_pasid_init(struct mm_struct *mm) {}
-static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid) {}
 static inline void mm_pasid_drop(struct mm_struct *mm) {}
 #endif
 
-- 
2.25.1

