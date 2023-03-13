Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E576B82E1
	for <lists+dmaengine@lfdr.de>; Mon, 13 Mar 2023 21:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjCMUiJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Mar 2023 16:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjCMUiI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Mar 2023 16:38:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5013ABDCF;
        Mon, 13 Mar 2023 13:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678739886; x=1710275886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o6N2Au2DvL8M7c0qc1w0ZGowkeZSbBghUKfA8/mNPTE=;
  b=BuzvK5OwIuEIMW9Cp1UBgOIsPLIRuYuz1ou8rj9ccKLegoebXak3nSZ8
   V9ZgQzxTlFjwpuOktqw1dXCXkS6HArdUqDcc4OZvEiTrME5/DvsqCnVqL
   v43QaortIzNK5WJ6QtuBjQ5orm+ANVRMKa8I0Yg8do5mKecqm+yPwxb5n
   YoNBuWX9UWSZ0nFKbmkfLRZktcEJhgQ+YZ0dJAEvoXo37rjRAq4WcjZEG
   57llkhX1fJJjZ3IgA68NemhXXdyGXa+78KQo4FWO4UxX/0qop1yCbpWbl
   cM60Jy7I6dBidMW3Wjp2FjhvRjjq5FzBEg3Ecb5lLNE4qi7d99EXBkXi2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="334732030"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="334732030"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 13:38:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="802584769"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="802584769"
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
Subject: [PATCH v6 1/7] iommu/vt-d: Remove virtual command interface
Date:   Mon, 13 Mar 2023 13:41:52 -0700
Message-Id: <20230313204158.1495067-2-jacob.jun.pan@linux.intel.com>
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
 drivers/iommu/intel/iommu.h     |  2 -
 4 files changed, 91 deletions(-)

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
index 6acfe879589c..0f348439ef0e 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -993,8 +993,6 @@ static int map_iommu(struct intel_iommu *iommu, struct dmar_drhd_unit *drhd)
 		warn_invalid_dmar(phys_addr, " returns all ones");
 		goto unmap;
 	}
-	if (ecap_vcs(iommu->ecap))
-		iommu->vccap = dmar_readq(iommu->reg + DMAR_VCCAP_REG);
 
 	/* the registers might be more than one page */
 	map_size = max_t(int, ecap_max_iotlb_offset(iommu->ecap),
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7c2f4bd33582..21c14e00c852 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1722,9 +1722,6 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 		if (ecap_prs(iommu->ecap))
 			intel_svm_finish_prq(iommu);
 	}
-	if (vccap_pasid(iommu->vccap))
-		ioasid_unregister_allocator(&iommu->pasid_allocator);
-
 #endif
 }
 
@@ -2797,85 +2794,6 @@ static int copy_translation_tables(struct intel_iommu *iommu)
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
@@ -2964,9 +2882,6 @@ static int __init init_dmars(void)
 	 */
 	for_each_active_iommu(iommu, drhd) {
 		iommu_flush_write_buffer(iommu);
-#ifdef CONFIG_INTEL_IOMMU_SVM
-		register_pasid_allocator(iommu);
-#endif
 		iommu_set_root_entry(iommu);
 	}
 
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index d6df3b865812..a2010fb120e2 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -198,7 +198,6 @@
 #define ecap_flts(e)		(((e) >> 47) & 0x1)
 #define ecap_slts(e)		(((e) >> 46) & 0x1)
 #define ecap_slads(e)		(((e) >> 45) & 0x1)
-#define ecap_vcs(e)		(((e) >> 44) & 0x1)
 #define ecap_smts(e)		(((e) >> 43) & 0x1)
 #define ecap_dit(e)		(((e) >> 41) & 0x1)
 #define ecap_pds(e)		(((e) >> 42) & 0x1)
@@ -676,7 +675,6 @@ struct intel_iommu {
 	unsigned char prq_name[16];    /* Name for PRQ interrupt */
 	unsigned long prq_seq_number;
 	struct completion prq_complete;
-	struct ioasid_allocator_ops pasid_allocator; /* Custom allocator for PASIDs */
 #endif
 	struct iopf_queue *iopf_queue;
 	unsigned char iopfq_name[16];
-- 
2.25.1

