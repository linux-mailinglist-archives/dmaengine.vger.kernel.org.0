Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE6E6B82EB
	for <lists+dmaengine@lfdr.de>; Mon, 13 Mar 2023 21:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjCMUiO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Mar 2023 16:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjCMUiL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Mar 2023 16:38:11 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FEE9EDA;
        Mon, 13 Mar 2023 13:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678739888; x=1710275888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/F8u+EcSTX2fvnnUpM/s6xCyCASCCDpZz4NdP4C05pc=;
  b=WnD6DL9NuQd0quWqqjUhrgcMehDN0NQ6I+ErjQbF995xS2wXmNveTYsh
   ozJVk8flSyWhGlwym34uRQRjkn0tSHHNW4HHhd3C2XGIE/sjXM5s2Qnnn
   szKvFDEmod9A/PjbGz0fxACZW+6DtL+OQPdAmEmN6Q+eZs5VUYCx9wvvp
   NgbMhXpp+98GUYO1xUOFskSQzzg370M6PnHoc8pe13YvRS6373cjfAli1
   FZit1gKj+OtyWM/8sHfoEW21F/SRNIlgNjcFA6LoVSYoVHQSq+18fd7B6
   XRCgEGDUoJmnIiqWe6o6frwAtEg2/bCqV45NJ9EgUY7lWSwoDjWMF2abD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="334732097"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="334732097"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 13:38:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="802584790"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="802584790"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by orsmga004.jf.intel.com with ESMTP; 13 Mar 2023 13:38:05 -0700
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
Subject: [PATCH v6 6/7] iommu/ioasid: Rename INVALID_IOASID
Date:   Mon, 13 Mar 2023 13:41:57 -0700
Message-Id: <20230313204158.1495067-7-jacob.jun.pan@linux.intel.com>
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

INVALID_IOASID and IOMMU_PASID_INVALID are duplicated. Rename
INVALID_IOASID and consolidate since we are moving away from IOASID
infrastructure.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

---
v5:
	- Use pasid_valid() helper
---
 Documentation/x86/sva.rst   | 2 +-
 arch/x86/kernel/traps.c     | 5 ++++-
 drivers/dma/idxd/device.c   | 8 ++++----
 drivers/dma/idxd/idxd.h     | 1 +
 drivers/dma/idxd/init.c     | 2 +-
 drivers/dma/idxd/irq.c      | 2 +-
 drivers/iommu/intel/dmar.c  | 4 ++--
 drivers/iommu/intel/iommu.c | 2 +-
 drivers/iommu/intel/svm.c   | 2 +-
 include/linux/ioasid.h      | 1 +
 include/linux/iommu.h       | 6 +++---
 mm/init-mm.c                | 4 ++--
 12 files changed, 22 insertions(+), 17 deletions(-)

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
index 5f321f3b4242..6fca8fa8d3a8 100644
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
index 640d3048368e..e6ee267da0ff 100644
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
index 0f348439ef0e..10bb20ff50fd 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1958,7 +1958,7 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 		return 0;
 	}
 
-	if (pasid == INVALID_IOASID)
+	if (pasid == IOMMU_PASID_INVALID)
 		pr_err("[%s NO_PASID] Request device [%02x:%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
 		       type ? "DMA Read" : "DMA Write",
 		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
@@ -2039,7 +2039,7 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
 		if (!ratelimited)
 			/* Using pasid -1 if pasid is not present */
 			dmar_fault_do_one(iommu, type, fault_reason,
-					  pasid_present ? pasid : INVALID_IOASID,
+					  pasid_present ? pasid : IOMMU_PASID_INVALID,
 					  source_id, guest_addr);
 
 		fault_index++;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 21c14e00c852..0768dcae90fd 100644
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
index 7367f56c3bad..3848a1b0800c 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -273,7 +273,7 @@ static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
 	if (WARN_ON(!mutex_is_locked(&pasid_mutex)))
 		return -EINVAL;
 
-	if (pasid == INVALID_IOASID || pasid >= PASID_MAX)
+	if (pasid == IOMMU_PASID_INVALID || pasid >= PASID_MAX)
 		return -EINVAL;
 
 	svm = pasid_private_find(pasid);
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index bdee937da907..6cf5d1c904c5 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -7,6 +7,7 @@
 #include <linux/iommu.h>
 
 typedef unsigned int ioasid_t;
+#define INVALID_IOASID ((ioasid_t)-1)
 typedef ioasid_t (*ioasid_alloc_fn_t)(ioasid_t min, ioasid_t max, void *data);
 typedef void (*ioasid_free_fn_t)(ioasid_t ioasid, void *data);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d3f81dc6e4dd..54f535ff9868 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -192,7 +192,6 @@ enum iommu_dev_features {
 
 #define IOMMU_PASID_INVALID	(-1U)
 typedef unsigned int ioasid_t;
-#define INVALID_IOASID ((ioasid_t)-1)
 
 #ifdef CONFIG_IOMMU_API
 
@@ -1175,12 +1174,13 @@ static inline bool tegra_dev_iommu_get_stream_id(struct device *dev, u32 *stream
 
 static inline bool pasid_valid(ioasid_t ioasid)
 {
-	return ioasid != INVALID_IOASID;
+	return ioasid != IOMMU_PASID_INVALID;
 }
+
 #ifdef CONFIG_IOMMU_SVA
 static inline void mm_pasid_init(struct mm_struct *mm)
 {
-	mm->pasid = INVALID_IOASID;
+	mm->pasid = IOMMU_PASID_INVALID;
 }
 void mm_pasid_drop(struct mm_struct *mm);
 struct iommu_sva *iommu_sva_bind_device(struct device *dev,
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

