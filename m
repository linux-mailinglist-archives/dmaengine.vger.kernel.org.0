Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752AD6A7809
	for <lists+dmaengine@lfdr.de>; Thu,  2 Mar 2023 00:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjCAXxu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Mar 2023 18:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjCAXxu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Mar 2023 18:53:50 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753AC1555E;
        Wed,  1 Mar 2023 15:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677714828; x=1709250828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PQv1EIqxcbMVYjSqKFA6vmasY+4GsJ4YxNDnMlXpMJQ=;
  b=V8B02qFiHW3OTRPQLep5PGKkZMH/NgYfevJvP5gZaJnrpkMx9oxoxw/m
   zoTsqEs5xH7ZQVyA0/o93haFR6E3RpEFKN8hh0hAqL7T66/n81dR8BevN
   96ESQXR/Qj4sDaG9VLToDo228xzJ/6vlyCSzLXO4nQ492ZxScJn++QjJt
   eKzmsqdo4iFbG9aFefaZOMUBDjlvGlfwrsid9aGvo2XuXE9yYUGwPSKYZ
   KPBBXZrtJl99H9A2Kd8F27OdGNX7Lan5L0wZWz6rtgQ+WjJGKHsZjOSEC
   GwK2kGv8aAezH3WbL7EyfdZZY/LpnRCicnvQjJVMLmvmTI86/5wLBeSKW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="397127625"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="397127625"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 15:53:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="1003880318"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="1003880318"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by fmsmga005.fm.intel.com with ESMTP; 01 Mar 2023 15:53:00 -0800
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
Subject: [PATCH v4 1/6] iommu/vt-d: Remove virtual command interface
Date:   Wed,  1 Mar 2023 15:56:41 -0800
Message-Id: <20230301235646.2692846-2-jacob.jun.pan@linux.intel.com>
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

Virtual command interface was introduced to allow using host PASIDs
inside VMs. It is unused and abandoned due to architectural change.

With this patch, we can safely remove this feature and the related helpers.

Link: https://lore.kernel.org/r/20230210230206.3160144-2-jacob.jun.pan@linux.intel.com
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/cap_audit.c |  2 -
 drivers/iommu/intel/dmar.c      |  2 -
 drivers/iommu/intel/iommu.c     | 85 ---------------------------------
 drivers/iommu/intel/iommu.h     |  8 ----
 4 files changed, 97 deletions(-)

diff --git a/drivers/iommu/intel/cap_audit.c b/drivers/iommu/intel/cap_audit.c
index 806986696841..9862dc20b35e 100644
--- a/drivers/iommu/intel/cap_audit.c
+++ b/drivers/iommu/intel/cap_audit.c
@@ -54,7 +54,6 @@ static inline void check_dmar_capabilities(struct intel_iommu *a,
 	CHECK_FEATURE_MISMATCH(a, b, ecap, slts, ECAP_SLTS_MASK);
 	CHECK_FEATURE_MISMATCH(a, b, ecap, nwfs, ECAP_NWFS_MASK);
 	CHECK_FEATURE_MISMATCH(a, b, ecap, slads, ECAP_SLADS_MASK);
-	CHECK_FEATURE_MISMATCH(a, b, ecap, vcs, ECAP_VCS_MASK);
 	CHECK_FEATURE_MISMATCH(a, b, ecap, smts, ECAP_SMTS_MASK);
 	CHECK_FEATURE_MISMATCH(a, b, ecap, pds, ECAP_PDS_MASK);
 	CHECK_FEATURE_MISMATCH(a, b, ecap, dit, ECAP_DIT_MASK);
@@ -101,7 +100,6 @@ static int cap_audit_hotplug(struct intel_iommu *iommu, enum cap_audit_type type
 	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, slts, ECAP_SLTS_MASK);
 	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, nwfs, ECAP_NWFS_MASK);
 	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, slads, ECAP_SLADS_MASK);
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, vcs, ECAP_VCS_MASK);
 	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, smts, ECAP_SMTS_MASK);
 	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, pds, ECAP_PDS_MASK);
 	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, dit, ECAP_DIT_MASK);
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index b00a0ceb2d13..bf0bfe5ba7a7 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -989,8 +989,6 @@ static int map_iommu(struct intel_iommu *iommu, u64 phys_addr)
 		warn_invalid_dmar(phys_addr, " returns all ones");
 		goto unmap;
 	}
-	if (ecap_vcs(iommu->ecap))
-		iommu->vccap = dmar_readq(iommu->reg + DMAR_VCCAP_REG);
 
 	/* the registers might be more than one page */
 	map_size = max_t(int, ecap_max_iotlb_offset(iommu->ecap),
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 59df7e42fd53..a295e80fdfe8 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1721,9 +1721,6 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 		if (ecap_prs(iommu->ecap))
 			intel_svm_finish_prq(iommu);
 	}
-	if (vccap_pasid(iommu->vccap))
-		ioasid_unregister_allocator(&iommu->pasid_allocator);
-
 #endif
 }
 
@@ -2793,85 +2790,6 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 	return ret;
 }
 
-#ifdef CONFIG_INTEL_IOMMU_SVM
-static ioasid_t intel_vcmd_ioasid_alloc(ioasid_t min, ioasid_t max, void *data)
-{
-	struct intel_iommu *iommu = data;
-	ioasid_t ioasid;
-
-	if (!iommu)
-		return INVALID_IOASID;
-	/*
-	 * VT-d virtual command interface always uses the full 20 bit
-	 * PASID range. Host can partition guest PASID range based on
-	 * policies but it is out of guest's control.
-	 */
-	if (min < PASID_MIN || max > intel_pasid_max_id)
-		return INVALID_IOASID;
-
-	if (vcmd_alloc_pasid(iommu, &ioasid))
-		return INVALID_IOASID;
-
-	return ioasid;
-}
-
-static void intel_vcmd_ioasid_free(ioasid_t ioasid, void *data)
-{
-	struct intel_iommu *iommu = data;
-
-	if (!iommu)
-		return;
-	/*
-	 * Sanity check the ioasid owner is done at upper layer, e.g. VFIO
-	 * We can only free the PASID when all the devices are unbound.
-	 */
-	if (ioasid_find(NULL, ioasid, NULL)) {
-		pr_alert("Cannot free active IOASID %d\n", ioasid);
-		return;
-	}
-	vcmd_free_pasid(iommu, ioasid);
-}
-
-static void register_pasid_allocator(struct intel_iommu *iommu)
-{
-	/*
-	 * If we are running in the host, no need for custom allocator
-	 * in that PASIDs are allocated from the host system-wide.
-	 */
-	if (!cap_caching_mode(iommu->cap))
-		return;
-
-	if (!sm_supported(iommu)) {
-		pr_warn("VT-d Scalable Mode not enabled, no PASID allocation\n");
-		return;
-	}
-
-	/*
-	 * Register a custom PASID allocator if we are running in a guest,
-	 * guest PASID must be obtained via virtual command interface.
-	 * There can be multiple vIOMMUs in each guest but only one allocator
-	 * is active. All vIOMMU allocators will eventually be calling the same
-	 * host allocator.
-	 */
-	if (!vccap_pasid(iommu->vccap))
-		return;
-
-	pr_info("Register custom PASID allocator\n");
-	iommu->pasid_allocator.alloc = intel_vcmd_ioasid_alloc;
-	iommu->pasid_allocator.free = intel_vcmd_ioasid_free;
-	iommu->pasid_allocator.pdata = (void *)iommu;
-	if (ioasid_register_allocator(&iommu->pasid_allocator)) {
-		pr_warn("Custom PASID allocator failed, scalable mode disabled\n");
-		/*
-		 * Disable scalable mode on this IOMMU if there
-		 * is no custom allocator. Mixing SM capable vIOMMU
-		 * and non-SM vIOMMU are not supported.
-		 */
-		intel_iommu_sm = 0;
-	}
-}
-#endif
-
 static int __init init_dmars(void)
 {
 	struct dmar_drhd_unit *drhd;
@@ -2960,9 +2878,6 @@ static int __init init_dmars(void)
 	 */
 	for_each_active_iommu(iommu, drhd) {
 		iommu_flush_write_buffer(iommu);
-#ifdef CONFIG_INTEL_IOMMU_SVM
-		register_pasid_allocator(iommu);
-#endif
 		iommu_set_root_entry(iommu);
 	}
 
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 06e61e474856..6bdfbead82c4 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -184,7 +184,6 @@
 #define ecap_flts(e)		(((e) >> 47) & 0x1)
 #define ecap_slts(e)		(((e) >> 46) & 0x1)
 #define ecap_slads(e)		(((e) >> 45) & 0x1)
-#define ecap_vcs(e)		(((e) >> 44) & 0x1)
 #define ecap_smts(e)		(((e) >> 43) & 0x1)
 #define ecap_dit(e)		(((e) >> 41) & 0x1)
 #define ecap_pds(e)		(((e) >> 42) & 0x1)
@@ -210,9 +209,6 @@
 #define ecap_max_handle_mask(e) (((e) >> 20) & 0xf)
 #define ecap_sc_support(e)	(((e) >> 7) & 0x1) /* Snooping Control */
 
-/* Virtual command interface capability */
-#define vccap_pasid(v)		(((v) & DMA_VCS_PAS)) /* PASID allocation */
-
 /* IOTLB_REG */
 #define DMA_TLB_FLUSH_GRANU_OFFSET  60
 #define DMA_TLB_GLOBAL_FLUSH (((u64)1) << 60)
@@ -307,8 +303,6 @@
 #define DMA_PRS_PPR	((u32)1)
 #define DMA_PRS_PRO	((u32)2)
 
-#define DMA_VCS_PAS	((u64)1)
-
 #define IOMMU_WAIT_OP(iommu, offset, op, cond, sts)			\
 do {									\
 	cycles_t start_time = get_cycles();				\
@@ -560,7 +554,6 @@ struct intel_iommu {
 	u64		reg_size; /* size of hw register set */
 	u64		cap;
 	u64		ecap;
-	u64		vccap;
 	u32		gcmd; /* Holds TE, EAFL. Don't need SRTP, SFL, WBF */
 	raw_spinlock_t	register_lock; /* protect register handling */
 	int		seq_id;	/* sequence id of the iommu */
@@ -583,7 +576,6 @@ struct intel_iommu {
 	unsigned char prq_name[16];    /* Name for PRQ interrupt */
 	unsigned long prq_seq_number;
 	struct completion prq_complete;
-	struct ioasid_allocator_ops pasid_allocator; /* Custom allocator for PASIDs */
 #endif
 	struct iopf_queue *iopf_queue;
 	unsigned char iopfq_name[16];
-- 
2.25.1

