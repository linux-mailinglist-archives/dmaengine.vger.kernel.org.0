Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F7952C20F
	for <lists+dmaengine@lfdr.de>; Wed, 18 May 2022 20:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241356AbiERSRl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 May 2022 14:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241346AbiERSRj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 May 2022 14:17:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE2617EC3F;
        Wed, 18 May 2022 11:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652897858; x=1684433858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4E0rUsQ0j9aptl5lb7L0UIOwroU6cL8nhCs1ddmoug0=;
  b=cj1lzljHpeP7O11FRCsm+hYZIR0uYDFByzUT34/fqqlFCwClbyS3oPlU
   pGCnO7OiDI5TDswH76Y+mHQg4x9iBO+qjLxjrAVMMw3Suk07n8mG5EYMK
   pF87d4J0KDIbTv62Pl2rqEShLc+rR9pyDXIkt+GyCSfk9Jn9R0hUOaQY3
   cOXkE5WMhLaVXn47tzjhhS3gfy+PNz/PHHC0GA3OerqDJwd2ymv4/vg9h
   3zBPXLxyDhiGdb/8Bk0agtECZnBg5BcUh5ITKW44bjOK1yyQsyArrdkrt
   aMRqNWgt9MqDTixvtk9bKjW3UUSIsFlKu1NViE6Rh3S45ONkxA+iuJQAt
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="270648740"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="270648740"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 11:17:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="639405497"
Received: from otc-wp-03.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.79])
  by fmsmga004.fm.intel.com with ESMTP; 18 May 2022 11:17:32 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Christoph Hellwig" <hch@infradead.org>, vkoul@kernel.org,
        robin.murphy@arm.com, will@kernel.org
Cc:     Yi Liu <yi.l.liu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 3/6] iommu/vt-d: Implement domain ops for attach_dev_pasid
Date:   Wed, 18 May 2022 11:21:17 -0700
Message-Id: <20220518182120.1136715-4-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On VT-d platforms with scalable mode enabled, devices issue DMA requests
with PASID need to attach PASIDs to given IOMMU domains. The attach
operation involves the following:
- Programming the PASID into the device's PASID table
- Tracking device domain and the PASID relationship
- Managing IOTLB and device TLB invalidations

This patch add attach_dev_pasid functions to the default domain ops which
is used by DMA and identity domain types. It could be extended to support
other domain types whenever necessary.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 72 +++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 1c2c92b657c7..75615c105fdf 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1556,12 +1556,18 @@ static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
 				    u64 addr, unsigned int mask)
 {
 	u16 sid, qdep;
+	ioasid_t pasid;
 
 	if (!info || !info->ats_enabled)
 		return;
 
 	sid = info->bus << 8 | info->devfn;
 	qdep = info->ats_qdep;
+	pasid = iommu_get_pasid_from_domain(info->dev, &info->domain->domain);
+	if (pasid != INVALID_IOASID) {
+		qi_flush_dev_iotlb_pasid(info->iommu, sid, info->pfsid,
+					 pasid, qdep, addr, mask);
+	}
 	qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
 			   qdep, addr, mask);
 }
@@ -1591,6 +1597,7 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 	unsigned int mask = ilog2(aligned_pages);
 	uint64_t addr = (uint64_t)pfn << VTD_PAGE_SHIFT;
 	u16 did = domain->iommu_did[iommu->seq_id];
+	struct iommu_domain *iommu_domain = &domain->domain;
 
 	BUG_ON(pages == 0);
 
@@ -1599,6 +1606,9 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 
 	if (domain_use_first_level(domain)) {
 		qi_flush_piotlb(iommu, did, PASID_RID2PASID, addr, pages, ih);
+		/* flush additional kernel DMA PASIDs attached */
+		if (iommu_domain->dma_pasid)
+			qi_flush_piotlb(iommu, did, iommu_domain->dma_pasid, addr, pages, ih);
 	} else {
 		unsigned long bitmask = aligned_pages - 1;
 
@@ -4255,6 +4265,7 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 	struct dmar_domain *domain;
 	struct intel_iommu *iommu;
 	unsigned long flags;
+	ioasid_t pasid;
 
 	assert_spin_locked(&device_domain_lock);
 
@@ -4265,10 +4276,15 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 	domain = info->domain;
 
 	if (info->dev && !dev_is_real_dma_subdevice(info->dev)) {
-		if (dev_is_pci(info->dev) && sm_supported(iommu))
+		if (dev_is_pci(info->dev) && sm_supported(iommu)) {
 			intel_pasid_tear_down_entry(iommu, info->dev,
 					PASID_RID2PASID, false);
-
+			pasid = iommu_get_pasid_from_domain(info->dev,
+							    &info->domain->domain);
+			if (pasid != INVALID_IOASID)
+				intel_pasid_tear_down_entry(iommu, info->dev,
+							    pasid, false);
+		}
 		iommu_disable_dev_iotlb(info);
 		domain_context_clear(info);
 		intel_pasid_free_table(info->dev);
@@ -4904,6 +4920,56 @@ static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 	}
 }
 
+static int intel_iommu_attach_dev_pasid(struct iommu_domain *domain,
+					struct device *dev,
+					ioasid_t pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct intel_iommu *iommu = info->iommu;
+	unsigned long flags;
+	int ret = 0;
+
+	if (!sm_supported(iommu) || !info)
+		return -ENODEV;
+
+	if (WARN_ON(pasid == PASID_RID2PASID))
+		return -EINVAL;
+
+	spin_lock_irqsave(&device_domain_lock, flags);
+	spin_lock(&iommu->lock);
+	if (hw_pass_through && domain_type_is_si(dmar_domain))
+		ret = intel_pasid_setup_pass_through(iommu, dmar_domain,
+						     dev, pasid);
+	else if (domain_use_first_level(dmar_domain))
+		ret = domain_setup_first_level(iommu, dmar_domain,
+					       dev, pasid);
+	else
+		ret = intel_pasid_setup_second_level(iommu, dmar_domain,
+						     dev, pasid);
+
+	spin_unlock(&iommu->lock);
+	spin_unlock_irqrestore(&device_domain_lock, flags);
+
+	return ret;
+}
+
+static void intel_iommu_detach_dev_pasid(struct iommu_domain *domain,
+					struct device *dev,
+					ioasid_t pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+	unsigned long flags;
+
+	if (pasid != iommu_get_pasid_from_domain(info->dev, &info->domain->domain))
+		return;
+
+	spin_lock_irqsave(&iommu->lock, flags);
+	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
+	spin_unlock_irqrestore(&iommu->lock, flags);
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
@@ -4932,6 +4998,8 @@ const struct iommu_ops intel_iommu_ops = {
 		.iova_to_phys		= intel_iommu_iova_to_phys,
 		.free			= intel_iommu_domain_free,
 		.enforce_cache_coherency = intel_iommu_enforce_cache_coherency,
+		.attach_dev_pasid	= intel_iommu_attach_dev_pasid,
+		.detach_dev_pasid	= intel_iommu_detach_dev_pasid,
 	}
 };
 
-- 
2.25.1

