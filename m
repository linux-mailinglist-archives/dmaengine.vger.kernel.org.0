Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B07C7208EB
	for <lists+dmaengine@lfdr.de>; Fri,  2 Jun 2023 20:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237028AbjFBSRq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Jun 2023 14:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236869AbjFBSRo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Jun 2023 14:17:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4955123;
        Fri,  2 Jun 2023 11:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685729862; x=1717265862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4p3zIDhXUsEFoA0tsNg8+G8DCi8YsUnHZ4JrFrt/SXY=;
  b=ewvxt5VBrpIzcm4zCFYiMBj75RhX/OO/w11Tm/R0ZpzkzuiyuGoKkqVc
   YEQJIGkIYPI6TapJ5/3rVPvD7C/OPami4TIR+L1tVaBUyOtl/kmiSkMt6
   L8I9D8yTJq5fStUSa1nh3gtfPfkLTXrsanF+mLau4nrBJ+f1sFp08BnZ/
   IwrglVoJV51Ibuh5qdEY9Pr8DgjoWgmI2+M5opuzew1Qy4RAy1wPzUNx6
   F94AwSuScxRs/m8QDQom3KvZ2ClH6iSJpvch9b5loE2cAuCejjLzGvARj
   ZMg6+V2c/ZJRds/JRJcnbOotlnxgT8084H+O8GdUODOSzKrRK/IYVyKUx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="442310232"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="442310232"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 11:17:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="832060965"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="832060965"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.97.184])
  by orsmga004.jf.intel.com with ESMTP; 02 Jun 2023 11:17:38 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        dmaengine@vger.kernel.org, vkoul@kernel.org
Cc:     "Will Deacon" <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>, rex.zhang@intel.com,
        xiaochen.shen@intel.com, narayan.ranganathan@intel.com,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v8 3/7] iommu/vt-d: Add domain_flush_pasid_iotlb()
Date:   Fri,  2 Jun 2023 11:22:08 -0700
Message-Id: <20230602182212.150825-4-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230602182212.150825-1-jacob.jun.pan@linux.intel.com>
References: <20230602182212.150825-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Lu Baolu <baolu.lu@linux.intel.com>

The VT-d spec requires to use PASID-based-IOTLB invalidation descriptor
to invalidate IOTLB and the paging-structure caches for a first-stage
page table. Add a generic helper to do this.

RID2PASID is used if the domain has been attached to a physical device,
otherwise real PASIDs that the domain has been attached to will be used.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4eba9973f537..3214990b69b7 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1475,6 +1475,24 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 	spin_unlock_irqrestore(&domain->lock, flags);
 }
 
+/*
+ * The VT-d spec requires to use PASID-based-IOTLB Invalidation to
+ * invalidate IOTLB and the paging-structure-caches for a first-stage
+ * page table.
+ */
+static void domain_flush_pasid_iotlb(struct intel_iommu *iommu,
+				     struct dmar_domain *domain, u64 addr,
+				     unsigned long npages, bool ih)
+{
+	u16 did = domain_id_iommu(domain, iommu);
+	unsigned long flags;
+
+	spin_lock_irqsave(&domain->lock, flags);
+	if (!list_empty(&domain->devices))
+		qi_flush_piotlb(iommu, did, IOMMU_NO_PASID, addr, npages, ih);
+	spin_unlock_irqrestore(&domain->lock, flags);
+}
+
 static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 				  struct dmar_domain *domain,
 				  unsigned long pfn, unsigned int pages,
@@ -1492,7 +1510,7 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 		ih = 1 << 6;
 
 	if (domain->use_first_level) {
-		qi_flush_piotlb(iommu, did, IOMMU_NO_PASID, addr, pages, ih);
+		domain_flush_pasid_iotlb(iommu, domain, addr, pages, ih);
 	} else {
 		unsigned long bitmask = aligned_pages - 1;
 
@@ -1562,7 +1580,7 @@ static void intel_flush_iotlb_all(struct iommu_domain *domain)
 		u16 did = domain_id_iommu(dmar_domain, iommu);
 
 		if (dmar_domain->use_first_level)
-			qi_flush_piotlb(iommu, did, IOMMU_NO_PASID, 0, -1, 0);
+			domain_flush_pasid_iotlb(iommu, dmar_domain, 0, -1, 0);
 		else
 			iommu->flush.flush_iotlb(iommu, did, 0, 0,
 						 DMA_TLB_DSI_FLUSH);
-- 
2.25.1

