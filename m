Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDF56A7814
	for <lists+dmaengine@lfdr.de>; Thu,  2 Mar 2023 00:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCAXyE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Mar 2023 18:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjCAXxw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Mar 2023 18:53:52 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABE324135;
        Wed,  1 Mar 2023 15:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677714830; x=1709250830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1FIYSLlpkge8re5qTc++8PmSzlQmi2H7J50SjinVZ98=;
  b=DPgvtDm6W3EkVyEyTutkf6Zi2+RtUNF2QvKrnGLin7lkCRvV0OARziPT
   wbx7RSolgXgF4/PjlgNRt6lPKoQkgbcYQEZU9h9QhmW/ZwnK/lxyKJYZX
   Nr9mQMBMO78stC8uN3Nj41b/NVKaiNHYJR89CKA6NLovD454zkg3KpN4O
   o488mq3ujlWMhxzCp2vQQMGD6cerYMq+4jmPCpNg3meT6jxzcqTvI/P9x
   UiuPT0FpgWnP3HGJ2Hi9WcI82JWy+OGGvTOl+CcQSQNHa/rijCnfii7gu
   kSWq/+wXAPp5/9XuQzKgb60YWHuu9Yhpt4J1ZHeoGqdJEGIPA88ASMKHA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="397127678"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="397127678"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 15:53:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="1003880342"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="1003880342"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by fmsmga005.fm.intel.com with ESMTP; 01 Mar 2023 15:53:05 -0800
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
Subject: [PATCH v4 5/6] iommu/ioasid: Rename INVALID_IOASID
Date:   Wed,  1 Mar 2023 15:56:45 -0800
Message-Id: <20230301235646.2692846-6-jacob.jun.pan@linux.intel.com>
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

INVALID_IOASID and IOMMU_PASID_INVALID are duplicated. Rename
INVALID_IOASID and consolidate since we are moving away from IOASID
infrastructure.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 Documentation/x86/sva.rst    | 2 +-
 arch/x86/kernel/traps.c      | 5 ++++-
 drivers/dma/idxd/device.c    | 8 ++++----
 drivers/dma/idxd/idxd.h      | 1 +
 drivers/dma/idxd/init.c      | 2 +-
 drivers/dma/idxd/irq.c       | 2 +-
 drivers/iommu/intel/dmar.c   | 4 ++--
 drivers/iommu/intel/iommu.c  | 2 +-
 drivers/iommu/intel/svm.c    | 2 +-
 include/linux/ioasid.h       | 5 +----
 include/linux/iommu-helper.h | 2 +-
 include/linux/iommu.h        | 7 +++++--
 include/linux/sched/mm.h     | 2 +-
 mm/init-mm.c                 | 4 ++--
 14 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/Documentation/x86/sva.rst b/Documentation/x86/sva.rst
index 2e9b8b0f9a0f..33cb05005982 100644
--- a/Documentation/x86/sva.rst
+++ b/Documentation/x86/sva.rst
@@ -107,7 +107,7 @@ process share the same page tables, thus the same MSR value.
 PASID Life Cycle Management
 ===========================
 
-PASID is initialized as INVALID_IOASID (-1) when a process is created.
+PASID is initialized as IOMMU_PASID_INVALID (-1) when a process is created.
 
 Only processes that access SVA-capable devices need to have a PASID
 allocated. This allocation happens when a process opens/binds an SVA-capable
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index d317dc3d06a3..d6fb03ebf548 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -40,7 +40,10 @@
 #include <linux/io.h>
 #include <linux/hardirq.h>
 #include <linux/atomic.h>
-#include <linux/ioasid.h>
+
+#ifdef CONFIG_IOMMU_SVA
+#include <linux/iommu.h>
+#endif
 
 #include <asm/stacktrace.h>
 #include <asm/processor.h>
diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 29dbb0f52e18..125652a8bb29 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1194,7 +1194,7 @@ static void idxd_device_set_perm_entry(struct idxd_device *idxd,
 {
 	union msix_perm mperm;
 
-	if (ie->pasid == INVALID_IOASID)
+	if (ie->pasid == IOMMU_PASID_INVALID)
 		return;
 
 	mperm.bits = 0;
@@ -1224,7 +1224,7 @@ void idxd_wq_free_irq(struct idxd_wq *wq)
 	idxd_device_clear_perm_entry(idxd, ie);
 	ie->vector = -1;
 	ie->int_handle = INVALID_INT_HANDLE;
-	ie->pasid = INVALID_IOASID;
+	ie->pasid = IOMMU_PASID_INVALID;
 }
 
 int idxd_wq_request_irq(struct idxd_wq *wq)
@@ -1240,7 +1240,7 @@ int idxd_wq_request_irq(struct idxd_wq *wq)
 
 	ie = &wq->ie;
 	ie->vector = pci_irq_vector(pdev, ie->id);
-	ie->pasid = device_pasid_enabled(idxd) ? idxd->pasid : INVALID_IOASID;
+	ie->pasid = device_pasid_enabled(idxd) ? idxd->pasid : IOMMU_PASID_INVALID;
 	idxd_device_set_perm_entry(idxd, ie);
 
 	rc = request_threaded_irq(ie->vector, NULL, idxd_wq_thread, 0, "idxd-portal", ie);
@@ -1265,7 +1265,7 @@ int idxd_wq_request_irq(struct idxd_wq *wq)
 	free_irq(ie->vector, ie);
 err_irq:
 	idxd_device_clear_perm_entry(idxd, ie);
-	ie->pasid = INVALID_IOASID;
+	ie->pasid = IOMMU_PASID_INVALID;
 	return rc;
 }
 
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 7ced8d283d98..417e602a46b6 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -13,6 +13,7 @@
 #include <linux/ioasid.h>
 #include <linux/bitmap.h>
 #include <linux/perf_event.h>
+#include <linux/iommu.h>
 #include <uapi/linux/idxd.h>
 #include "registers.h"
 
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 529ea09c9094..f30eef701970 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -105,7 +105,7 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
 		ie = idxd_get_ie(idxd, msix_idx);
 		ie->id = msix_idx;
 		ie->int_handle = INVALID_INT_HANDLE;
-		ie->pasid = INVALID_IOASID;
+		ie->pasid = IOMMU_PASID_INVALID;
 
 		spin_lock_init(&ie->list_lock);
 		init_llist_head(&ie->pending_llist);
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index aa314ebec587..242f1f0b9f09 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -80,7 +80,7 @@ static void idxd_int_handle_revoke_drain(struct idxd_irq_entry *ie)
 	desc.opcode = DSA_OPCODE_DRAIN;
 	desc.priv = 1;
 
-	if (ie->pasid != INVALID_IOASID)
+	if (ie->pasid != IOMMU_PASID_INVALID)
 		desc.pasid = ie->pasid;
 	desc.int_handle = ie->int_handle;
 	portal = idxd_wq_portal_addr(wq);
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index bf0bfe5ba7a7..c567f94b66c7 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1933,7 +1933,7 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 		return 0;
 	}
 
-	if (pasid == INVALID_IOASID)
+	if (pasid == IOMMU_PASID_INVALID)
 		pr_err("[%s NO_PASID] Request device [%02x:%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
 		       type ? "DMA Read" : "DMA Write",
 		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
@@ -2014,7 +2014,7 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
 		if (!ratelimited)
 			/* Using pasid -1 if pasid is not present */
 			dmar_fault_do_one(iommu, type, fault_reason,
-					  pasid_present ? pasid : INVALID_IOASID,
+					  pasid_present ? pasid : IOMMU_PASID_INVALID,
 					  source_id, guest_addr);
 
 		fault_index++;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a295e80fdfe8..10f657828d3a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -876,7 +876,7 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
 		return;
 	}
 	/* For request-without-pasid, get the pasid from context entry */
-	if (intel_iommu_sm && pasid == INVALID_IOASID)
+	if (intel_iommu_sm && pasid == IOMMU_PASID_INVALID)
 		pasid = PASID_RID2PASID;
 
 	dir_index = pasid >> PASID_PDE_SHIFT;
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index c76b66263467..be98af2fce06 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -274,7 +274,7 @@ static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
 	if (WARN_ON(!mutex_is_locked(&pasid_mutex)))
 		return -EINVAL;
 
-	if (pasid == INVALID_IOASID || pasid >= PASID_MAX)
+	if (pasid == IOMMU_PASID_INVALID || pasid >= PASID_MAX)
 		return -EINVAL;
 
 	svm = pasid_private_find(pasid);
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 2c502e77ee78..665a3773a409 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -7,6 +7,7 @@
 #include <linux/iommu-helper.h>
 
 typedef unsigned int ioasid_t;
+#define INVALID_IOASID ((ioasid_t)-1)
 typedef ioasid_t (*ioasid_alloc_fn_t)(ioasid_t min, ioasid_t max, void *data);
 typedef void (*ioasid_free_fn_t)(ioasid_t ioasid, void *data);
 
@@ -40,10 +41,6 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
 int ioasid_set_data(ioasid_t ioasid, void *data);
-static inline bool pasid_valid(ioasid_t ioasid)
-{
-	return ioasid != INVALID_IOASID;
-}
 
 #else /* !CONFIG_IOASID */
 static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
diff --git a/include/linux/iommu-helper.h b/include/linux/iommu-helper.h
index 0aa922f6bfad..0147430d8a6c 100644
--- a/include/linux/iommu-helper.h
+++ b/include/linux/iommu-helper.h
@@ -40,6 +40,6 @@ static inline unsigned long iommu_num_pages(unsigned long addr,
 
 	return DIV_ROUND_UP(size, io_page_size);
 }
-#define INVALID_IOASID	(-1U)
+#define IOMMU_PASID_INVALID	(-1U)
 
 #endif
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 46e1347bfa22..a694f6256d2d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -192,8 +192,11 @@ enum iommu_dev_features {
 	IOMMU_DEV_FEAT_IOPF,
 };
 
-#define IOMMU_PASID_INVALID	(-1U)
-
+typedef unsigned int ioasid_t;
+static inline bool pasid_valid(ioasid_t ioasid)
+{
+	return ioasid != IOMMU_PASID_INVALID;
+}
 #ifdef CONFIG_IOMMU_API
 
 /**
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index ae5a3f16b321..0e0aa285a12f 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -454,7 +454,7 @@ static inline void membarrier_update_current_mm(struct mm_struct *next_mm)
 #ifdef CONFIG_IOMMU_SVA
 static inline void mm_pasid_init(struct mm_struct *mm)
 {
-	mm->pasid = INVALID_IOASID;
+	mm->pasid = IOMMU_PASID_INVALID;
 }
 void mm_pasid_drop(struct mm_struct *mm);
 #else
diff --git a/mm/init-mm.c b/mm/init-mm.c
index c9327abb771c..a084039f55d8 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -10,7 +10,7 @@
 
 #include <linux/atomic.h>
 #include <linux/user_namespace.h>
-#include <linux/ioasid.h>
+#include <linux/iommu.h>
 #include <asm/mmu.h>
 
 #ifndef INIT_MM_CONTEXT
@@ -40,7 +40,7 @@ struct mm_struct init_mm = {
 	.user_ns	= &init_user_ns,
 	.cpu_bitmap	= CPU_BITS_NONE,
 #ifdef CONFIG_IOMMU_SVA
-	.pasid		= INVALID_IOASID,
+	.pasid		= IOMMU_PASID_INVALID,
 #endif
 	INIT_MM_CONTEXT(init_mm)
 };
-- 
2.25.1

