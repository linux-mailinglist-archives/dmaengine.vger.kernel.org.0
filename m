Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA3F6F0B3F
	for <lists+dmaengine@lfdr.de>; Thu, 27 Apr 2023 19:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244457AbjD0Rpm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Apr 2023 13:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244308AbjD0Rpj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 Apr 2023 13:45:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2AA3C31;
        Thu, 27 Apr 2023 10:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682617522; x=1714153522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VFQ7RRboV5zEjLwRKmGEviJ0SvUB1JU0qs7+McM0Wfo=;
  b=AHYQGo8gssDK19NXPDEuyuO1tu2Kk2666QTDTWXHUJZT/YEUTk8wol79
   1q9E9AK0sUzvx4wL+cEgQgruDpNh0ZBYpSCPSrLsiroDAv1TwsROg0LqL
   TDC7d2RU5+1gl5MRjJCTLOwM44SmIX9QQzp8dqmyCEeJxPNwM8RnEw23N
   0BRHrKzqgMNSf0r3zFvRwpdzUC1ZmsGOe4voRkCjq9hiIEfDvksta7w0L
   uulEe2b3DBNZ7afZ2qcKoGhuxOzzYAj6JBrsbRT6SoiCk3mYB+E61EDx1
   sv52wLiYhyJryqJgEkw6/75klgRiLzTymofqtSgS+K8Ew5WaIuqC66qYW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="350398697"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="350398697"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 10:45:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="1024219691"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="1024219691"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by fmsmga005.fm.intel.com with ESMTP; 27 Apr 2023 10:45:20 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org
Cc:     "Will Deacon" <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        narayan.ranganathan@intel.com,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v5 1/7] iommu: Generalize default PCIe requester ID PASID
Date:   Thu, 27 Apr 2023 10:49:31 -0700
Message-Id: <20230427174937.471668-2-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230427174937.471668-1-jacob.jun.pan@linux.intel.com>
References: <20230427174937.471668-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PCIe Process address space ID (PASID) is used to tag DMA traffic, it
provides finer grained isolation than requester ID (RID).

For each RID, 0 is as a special PASID for the legacy DMA (without
PASID), thus RID_PASID. This is universal across all architectures,
therefore warranted to be declared in the common header.
Noting that VT-d could support none-zero RID_PASID, but currently not
used.

By having a common RID_PASID, we can avoid conflicts between different
use cases in the generic code. e.g. SVA and DMA API with PASIDs.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 24 ++++++++++++------------
 drivers/iommu/intel/pasid.c |  2 +-
 drivers/iommu/intel/pasid.h |  1 -
 include/linux/iommu.h       |  1 +
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9f737ef55463..9ec45e0497cc 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -877,7 +877,7 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
 	}
 	/* For request-without-pasid, get the pasid from context entry */
 	if (intel_iommu_sm && pasid == IOMMU_PASID_INVALID)
-		pasid = PASID_RID2PASID;
+		pasid = IOMMU_DEF_RID_PASID;
 
 	dir_index = pasid >> PASID_PDE_SHIFT;
 	pde = &dir[dir_index];
@@ -1480,7 +1480,7 @@ static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
 	qdep = info->ats_qdep;
 	qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
 			   qdep, addr, mask);
-	quirk_extra_dev_tlb_flush(info, addr, mask, PASID_RID2PASID, qdep);
+	quirk_extra_dev_tlb_flush(info, addr, mask, IOMMU_DEF_RID_PASID, qdep);
 }
 
 static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
@@ -1514,7 +1514,7 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 		ih = 1 << 6;
 
 	if (domain->use_first_level) {
-		qi_flush_piotlb(iommu, did, PASID_RID2PASID, addr, pages, ih);
+		qi_flush_piotlb(iommu, did, IOMMU_DEF_RID_PASID, addr, pages, ih);
 	} else {
 		unsigned long bitmask = aligned_pages - 1;
 
@@ -1584,7 +1584,7 @@ static void intel_flush_iotlb_all(struct iommu_domain *domain)
 		u16 did = domain_id_iommu(dmar_domain, iommu);
 
 		if (dmar_domain->use_first_level)
-			qi_flush_piotlb(iommu, did, PASID_RID2PASID, 0, -1, 0);
+			qi_flush_piotlb(iommu, did, IOMMU_DEF_RID_PASID, 0, -1, 0);
 		else
 			iommu->flush.flush_iotlb(iommu, did, 0, 0,
 						 DMA_TLB_DSI_FLUSH);
@@ -1976,7 +1976,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 				context_pdts(pds);
 
 		/* Setup the RID_PASID field: */
-		context_set_sm_rid2pasid(context, PASID_RID2PASID);
+		context_set_sm_rid2pasid(context, IOMMU_DEF_RID_PASID);
 
 		/*
 		 * Setup the Device-TLB enable bit and Page request
@@ -2455,13 +2455,13 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 		/* Setup the PASID entry for requests without PASID: */
 		if (hw_pass_through && domain_type_is_si(domain))
 			ret = intel_pasid_setup_pass_through(iommu, domain,
-					dev, PASID_RID2PASID);
+					dev, IOMMU_DEF_RID_PASID);
 		else if (domain->use_first_level)
 			ret = domain_setup_first_level(iommu, domain, dev,
-					PASID_RID2PASID);
+					IOMMU_DEF_RID_PASID);
 		else
 			ret = intel_pasid_setup_second_level(iommu, domain,
-					dev, PASID_RID2PASID);
+					dev, IOMMU_DEF_RID_PASID);
 		if (ret) {
 			dev_err(dev, "Setup RID2PASID failed\n");
 			device_block_translation(dev);
@@ -3997,7 +3997,7 @@ static void dmar_remove_one_dev_info(struct device *dev)
 	if (!dev_is_real_dma_subdevice(info->dev)) {
 		if (dev_is_pci(info->dev) && sm_supported(iommu))
 			intel_pasid_tear_down_entry(iommu, info->dev,
-					PASID_RID2PASID, false);
+					IOMMU_DEF_RID_PASID, false);
 
 		iommu_disable_pci_caps(info);
 		domain_context_clear(info);
@@ -4026,7 +4026,7 @@ static void device_block_translation(struct device *dev)
 	if (!dev_is_real_dma_subdevice(dev)) {
 		if (sm_supported(iommu))
 			intel_pasid_tear_down_entry(iommu, dev,
-						    PASID_RID2PASID, false);
+						    IOMMU_DEF_RID_PASID, false);
 		else
 			domain_context_clear(info);
 	}
@@ -4360,7 +4360,7 @@ static void domain_set_force_snooping(struct dmar_domain *domain)
 
 	list_for_each_entry(info, &domain->devices, link)
 		intel_pasid_setup_page_snoop_control(info->iommu, info->dev,
-						     PASID_RID2PASID);
+						     IOMMU_DEF_RID_PASID);
 }
 
 static bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain)
@@ -4948,7 +4948,7 @@ void quirk_extra_dev_tlb_flush(struct device_domain_info *info,
 		return;
 
 	sid = PCI_DEVID(info->bus, info->devfn);
-	if (pasid == PASID_RID2PASID) {
+	if (pasid == IOMMU_DEF_RID_PASID) {
 		qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
 				   qdep, address, mask);
 	} else {
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index c5d479770e12..e8c60af8591b 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -438,7 +438,7 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 	 * SVA usage, device could do DMA with multiple PASIDs. It is more
 	 * efficient to flush devTLB specific to the PASID.
 	 */
-	if (pasid == PASID_RID2PASID)
+	if (pasid == IOMMU_DEF_RID_PASID)
 		qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64 - VTD_PAGE_SHIFT);
 	else
 		qi_flush_dev_iotlb_pasid(iommu, sid, pfsid, pasid, qdep, 0, 64 - VTD_PAGE_SHIFT);
diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index d6b7d21244b1..027d30afaba6 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -10,7 +10,6 @@
 #ifndef __INTEL_PASID_H
 #define __INTEL_PASID_H
 
-#define PASID_RID2PASID			0x0
 #define PASID_MIN			0x1
 #define PASID_MAX			0x100000
 #define PASID_PTE_MASK			0x3F
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 54f535ff9868..15aa4a1f7b1a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -190,6 +190,7 @@ enum iommu_dev_features {
 	IOMMU_DEV_FEAT_IOPF,
 };
 
+#define IOMMU_DEF_RID_PASID	(0U) /* Reserved for DMA w/o PASID */
 #define IOMMU_PASID_INVALID	(-1U)
 typedef unsigned int ioasid_t;
 
-- 
2.25.1

