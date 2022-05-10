Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8635522606
	for <lists+dmaengine@lfdr.de>; Tue, 10 May 2022 23:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbiEJVDY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 May 2022 17:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbiEJVDW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 May 2022 17:03:22 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E6A23724D;
        Tue, 10 May 2022 14:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652216601; x=1683752601;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BWGbvczE9hHSwD7LKlNCfOE3pQLWXV9yP/c7WBdOTFs=;
  b=CIZiIGiTI4/6nT76bSsZD9us8vF/LyF4wGia7EWTMsojBpFFhP2eXbNJ
   lW7yC9d53Vtj9AJPh6ZOHC5n/5x5EP11SCcKyKuuvocQO1DOfp9t09U2W
   1QpTU0zxVvb+mISmXKYRNRmQ4SBQhFrFfaADUZ2iE8EwSw0WTdcrpcazV
   5yDTYUjhqFCDhWV37j8Z9IY1TwL07rFfbfnHg/1wgz08PB5JlPxWLooZP
   l+wcuGSfNQA1AJzN30QJMRsM9vT5Y/caxL02m9ReRIsknigrAGcYhH1lG
   4lrxS3Ex4/ulACnMHUIYDzcQf+M1VZbAbjbvt5Jz1dITdJhoZ5hX5vLth
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="332538550"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="332538550"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 14:03:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="553017098"
Received: from otc-wp-03.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.79])
  by orsmga002.jf.intel.com with ESMTP; 10 May 2022 14:03:20 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, vkoul@kernel.org,
        robin.murphy@arm.com, will@kernel.org
Cc:     Yi Liu <yi.l.liu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3 1/4] iommu/vt-d: Implement domain ops for attach_dev_pasid
Date:   Tue, 10 May 2022 14:07:01 -0700
Message-Id: <20220510210704.3539577-2-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510210704.3539577-1-jacob.jun.pan@linux.intel.com>
References: <20220510210704.3539577-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/iommu/intel/iommu.c | 81 ++++++++++++++++++++++++++++++++++++-
 include/linux/intel-iommu.h |  1 +
 2 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a51b96fa9b3a..5408418f4f4b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1562,6 +1562,10 @@ static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
 
 	sid = info->bus << 8 | info->devfn;
 	qdep = info->ats_qdep;
+	if (info->pasid) {
+		qi_flush_dev_iotlb_pasid(info->iommu, sid, info->pfsid,
+					 info->pasid, qdep, addr, mask);
+	}
 	qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
 			   qdep, addr, mask);
 }
@@ -1591,6 +1595,7 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 	unsigned int mask = ilog2(aligned_pages);
 	uint64_t addr = (uint64_t)pfn << VTD_PAGE_SHIFT;
 	u16 did = domain->iommu_did[iommu->seq_id];
+	struct iommu_domain *iommu_domain = &domain->domain;
 
 	BUG_ON(pages == 0);
 
@@ -1599,6 +1604,9 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 
 	if (domain_use_first_level(domain)) {
 		qi_flush_piotlb(iommu, did, PASID_RID2PASID, addr, pages, ih);
+		/* flush additional kernel DMA PASIDs attached */
+		if (iommu_domain->pasid)
+			qi_flush_piotlb(iommu, did, iommu_domain->pasid, addr, pages, ih);
 	} else {
 		unsigned long bitmask = aligned_pages - 1;
 
@@ -4265,10 +4273,13 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 	domain = info->domain;
 
 	if (info->dev && !dev_is_real_dma_subdevice(info->dev)) {
-		if (dev_is_pci(info->dev) && sm_supported(iommu))
+		if (dev_is_pci(info->dev) && sm_supported(iommu)) {
 			intel_pasid_tear_down_entry(iommu, info->dev,
 					PASID_RID2PASID, false);
-
+			if (info->pasid)
+				intel_pasid_tear_down_entry(iommu, info->dev,
+							    info->pasid, false);
+		}
 		iommu_disable_dev_iotlb(info);
 		domain_context_clear(info);
 		intel_pasid_free_table(info->dev);
@@ -4912,6 +4923,70 @@ static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
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
+	spin_lock_irqsave(&device_domain_lock, flags);
+	/*
+	 * If the same device already has a PASID attached, just return.
+	 * DMA layer will return the PASID value to the caller.
+	 */
+	if (pasid != PASID_RID2PASID && info->pasid) {
+		if (info->pasid == pasid)
+			ret = 0;
+		else {
+			dev_warn(dev, "Cannot attach PASID %u, %u already attached\n",
+				 pasid, info->pasid);
+			ret = -EBUSY;
+		}
+		goto out_unlock_domain;
+	}
+
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
+out_unlock_domain:
+	spin_unlock_irqrestore(&device_domain_lock, flags);
+	if (!ret)
+		info->pasid = pasid;
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
+	WARN_ON(info->pasid != pasid);
+	spin_lock_irqsave(&iommu->lock, flags);
+	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
+	info->pasid = 0;
+	spin_unlock_irqrestore(&iommu->lock, flags);
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
@@ -4940,6 +5015,8 @@ const struct iommu_ops intel_iommu_ops = {
 		.iova_to_phys		= intel_iommu_iova_to_phys,
 		.free			= intel_iommu_domain_free,
 		.enforce_cache_coherency = intel_iommu_enforce_cache_coherency,
+		.attach_dev_pasid	= intel_iommu_attach_dev_pasid,
+		.detach_dev_pasid	= intel_iommu_detach_dev_pasid,
 	}
 };
 
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 5af24befc9f1..55845a8c4f4d 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -627,6 +627,7 @@ struct device_domain_info {
 	struct intel_iommu *iommu; /* IOMMU used by this device */
 	struct dmar_domain *domain; /* pointer to domain */
 	struct pasid_table *pasid_table; /* pasid table */
+	ioasid_t pasid; /* DMA request with PASID */
 };
 
 static inline void __iommu_flush_cache(
-- 
2.25.1

