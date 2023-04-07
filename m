Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962CE6DB25A
	for <lists+dmaengine@lfdr.de>; Fri,  7 Apr 2023 20:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjDGSB7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Apr 2023 14:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjDGSB5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Apr 2023 14:01:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E443BBB7;
        Fri,  7 Apr 2023 11:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680890515; x=1712426515;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XIu8pG3dfBoG5twXS+C7UZckidk9Mw8wBu2etiAguq8=;
  b=jPmEhIbgpOa64Y1vC2Ble3PfsJLFyJtymsqDFiMitHUZzOyz5hQS7pBF
   tR7ZvxZCfRGNFgysVXC6HraFxyJCuD68QDBOIn76hVU0WViOo4NWgj4JQ
   actSCy5joe4zXs8PXqmqOesiDbshgQ858Dri31TTdWTGngkWIxnanNbVb
   K/sD7n39kaFLs9tW4ld2YjfK+EPxsqDAO4sF8OigS5BYpxlyO2suet00a
   0wVNKOOyYxz42rOzOjFGuS2fHmZRITdyUtueFykw/jR06do52iHtXRjW1
   8bhZ+wZFtWcqI6xx+d7Ps/E8VG+Xm9/yJpZwM5YFYN/j9nRYb4e5shSRz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="343046499"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="343046499"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 11:01:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="776910085"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="776910085"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Apr 2023 11:01:51 -0700
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
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 5/7] iommu/vt-d: Make device pasid attachment explicit
Date:   Fri,  7 Apr 2023 11:05:52 -0700
Message-Id: <20230407180554.2784285-6-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230407180554.2784285-1-jacob.jun.pan@linux.intel.com>
References: <20230407180554.2784285-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Currently, when a device is attached to its DMA domain, RID_PASID is
implicitly attached if VT-d is in scalable mode. To prepare for generic
PASID-device domain attachment, this patch parameterizes PASID such that
all PASIDs are attached explicitly.

It will allow code reuse for DMA API with PASID usage and makes no
assumptions of the ordering in which PASIDs and device are attached.
The same change applies to IOTLB invalidation and removing PASIDs.

Extracted common code based on Baolu's patch:

Link:https://lore.kernel.org/linux-iommu/20220614034411.1634238-1-baolu.lu@linux.intel.com/
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 153 ++++++++++++++++++++++++++++--------
 drivers/iommu/intel/iommu.h |   8 ++
 2 files changed, 128 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cbb2670f88ca..52b9d0d3a02c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -278,6 +278,8 @@ static LIST_HEAD(dmar_satc_units);
 	list_for_each_entry(rmrr, &dmar_rmrr_units, list)
 
 static void device_block_translation(struct device *dev);
+static void intel_iommu_detach_device_pasid(struct iommu_domain *domain,
+					    struct device *dev, ioasid_t pasid);
 static void intel_iommu_domain_free(struct iommu_domain *domain);
 
 int dmar_disabled = !IS_ENABLED(CONFIG_INTEL_IOMMU_DEFAULT_ON);
@@ -1365,6 +1367,7 @@ domain_lookup_dev_info(struct dmar_domain *domain,
 
 static void domain_update_iotlb(struct dmar_domain *domain)
 {
+	struct device_pasid_info *dev_pasid;
 	struct device_domain_info *info;
 	bool has_iotlb_device = false;
 	unsigned long flags;
@@ -1376,6 +1379,14 @@ static void domain_update_iotlb(struct dmar_domain *domain)
 			break;
 		}
 	}
+
+	list_for_each_entry(dev_pasid, &domain->dev_pasids, link_domain) {
+		info = dev_iommu_priv_get(dev_pasid->dev);
+		if (info->ats_enabled) {
+			has_iotlb_device = true;
+			break;
+		}
+	}
 	domain->has_iotlb_device = has_iotlb_device;
 	spin_unlock_irqrestore(&domain->lock, flags);
 }
@@ -1486,6 +1497,7 @@ static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
 static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 				  u64 addr, unsigned mask)
 {
+	struct device_pasid_info *dev_pasid;
 	struct device_domain_info *info;
 	unsigned long flags;
 
@@ -1495,6 +1507,39 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 	spin_lock_irqsave(&domain->lock, flags);
 	list_for_each_entry(info, &domain->devices, link)
 		__iommu_flush_dev_iotlb(info, addr, mask);
+
+	list_for_each_entry(dev_pasid, &domain->dev_pasids, link_domain) {
+		/* device TLB is not aware of the use of RID PASID is for DMA w/o PASID */
+		if (dev_pasid->pasid == PASID_RID2PASID)
+			continue;
+
+		info = dev_iommu_priv_get(dev_pasid->dev);
+		qi_flush_dev_iotlb_pasid(info->iommu,
+					 PCI_DEVID(info->bus, info->devfn),
+					 info->pfsid, dev_pasid->pasid,
+					 info->ats_qdep, addr,
+					 mask);
+	}
+	spin_unlock_irqrestore(&domain->lock, flags);
+}
+
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
+	struct device_pasid_info *dev_pasid;
+	unsigned long flags;
+
+	spin_lock_irqsave(&domain->lock, flags);
+	list_for_each_entry(dev_pasid, &domain->dev_pasids, link_domain)
+		qi_flush_piotlb(iommu, did, dev_pasid->pasid, addr, npages, ih);
+
 	spin_unlock_irqrestore(&domain->lock, flags);
 }
 
@@ -1514,7 +1559,7 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 		ih = 1 << 6;
 
 	if (domain->use_first_level) {
-		qi_flush_piotlb(iommu, did, PASID_RID2PASID, addr, pages, ih);
+		domain_flush_pasid_iotlb(iommu, domain, addr, pages, ih);
 	} else {
 		unsigned long bitmask = aligned_pages - 1;
 
@@ -1584,7 +1629,7 @@ static void intel_flush_iotlb_all(struct iommu_domain *domain)
 		u16 did = domain_id_iommu(dmar_domain, iommu);
 
 		if (dmar_domain->use_first_level)
-			qi_flush_piotlb(iommu, did, PASID_RID2PASID, 0, -1, 0);
+			domain_flush_pasid_iotlb(iommu, dmar_domain, 0, -1, 0);
 		else
 			iommu->flush.flush_iotlb(iommu, did, 0, 0,
 						 DMA_TLB_DSI_FLUSH);
@@ -1756,6 +1801,7 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 		domain->use_first_level = true;
 	domain->has_iotlb_device = false;
 	INIT_LIST_HEAD(&domain->devices);
+	INIT_LIST_HEAD(&domain->dev_pasids);
 	spin_lock_init(&domain->lock);
 	xa_init(&domain->iommu_array);
 
@@ -2429,10 +2475,11 @@ static int __init si_domain_init(int hw)
 	return 0;
 }
 
-static int dmar_domain_attach_device(struct dmar_domain *domain,
-				     struct device *dev)
+static int dmar_domain_attach_device_pasid(struct dmar_domain *domain,
+				     struct device *dev, ioasid_t pasid)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct device_pasid_info *dev_pasid;
 	struct intel_iommu *iommu;
 	unsigned long flags;
 	u8 bus, devfn;
@@ -2442,43 +2489,57 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 	if (!iommu)
 		return -ENODEV;
 
+	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
+	if (!dev_pasid)
+		return -ENOMEM;
+
 	ret = domain_attach_iommu(domain, iommu);
 	if (ret)
-		return ret;
+		goto exit_free;
+
 	info->domain = domain;
+	dev_pasid->pasid = pasid;
+	dev_pasid->dev = dev;
 	spin_lock_irqsave(&domain->lock, flags);
-	list_add(&info->link, &domain->devices);
+	if (!info->dev_attached)
+		list_add(&info->link, &domain->devices);
+
+	list_add(&dev_pasid->link_domain, &domain->dev_pasids);
 	spin_unlock_irqrestore(&domain->lock, flags);
 
 	/* PASID table is mandatory for a PCI device in scalable mode. */
 	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
 		/* Setup the PASID entry for requests without PASID: */
 		if (hw_pass_through && domain_type_is_si(domain))
-			ret = intel_pasid_setup_pass_through(iommu, domain,
-					dev, PASID_RID2PASID);
+			ret = intel_pasid_setup_pass_through(iommu, domain, dev, pasid);
 		else if (domain->use_first_level)
-			ret = domain_setup_first_level(iommu, domain, dev,
-					PASID_RID2PASID);
+			ret = domain_setup_first_level(iommu, domain, dev, pasid);
 		else
-			ret = intel_pasid_setup_second_level(iommu, domain,
-					dev, PASID_RID2PASID);
+			ret = intel_pasid_setup_second_level(iommu, domain, dev, pasid);
 		if (ret) {
-			dev_err(dev, "Setup RID2PASID failed\n");
+			dev_err(dev, "Setup PASID %d failed\n", pasid);
 			device_block_translation(dev);
-			return ret;
+			goto exit_free;
 		}
 	}
+	/* device context already activated,  we are done */
+	if (info->dev_attached)
+		goto exit;
 
 	ret = domain_context_mapping(domain, dev);
 	if (ret) {
 		dev_err(dev, "Domain context map failed\n");
 		device_block_translation(dev);
-		return ret;
+		goto exit_free;
 	}
 
 	iommu_enable_pci_caps(info);
-
+	info->dev_attached = 1;
+exit:
 	return 0;
+exit_free:
+	kfree(dev_pasid);
+	return ret;
 }
 
 static bool device_has_rmrr(struct device *dev)
@@ -4029,8 +4090,7 @@ static void device_block_translation(struct device *dev)
 	iommu_disable_pci_caps(info);
 	if (!dev_is_real_dma_subdevice(dev)) {
 		if (sm_supported(iommu))
-			intel_pasid_tear_down_entry(iommu, dev,
-						    PASID_RID2PASID, false);
+			intel_iommu_detach_device_pasid(&info->domain->domain, dev, PASID_RID2PASID);
 		else
 			domain_context_clear(info);
 	}
@@ -4040,6 +4100,7 @@ static void device_block_translation(struct device *dev)
 
 	spin_lock_irqsave(&info->domain->lock, flags);
 	list_del(&info->link);
+	info->dev_attached = 0;
 	spin_unlock_irqrestore(&info->domain->lock, flags);
 
 	domain_detach_iommu(info->domain, iommu);
@@ -4186,7 +4247,7 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 	if (ret)
 		return ret;
 
-	return dmar_domain_attach_device(to_dmar_domain(domain), dev);
+	return dmar_domain_attach_device_pasid(to_dmar_domain(domain), dev, PASID_RID2PASID);
 }
 
 static int intel_iommu_map(struct iommu_domain *domain,
@@ -4675,26 +4736,52 @@ static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 		__mapping_notify_one(info->iommu, dmar_domain, pfn, pages);
 }
 
-static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
+static void intel_iommu_detach_device_pasid(struct iommu_domain *domain,
+					    struct device *dev, ioasid_t pasid)
 {
-	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
-	struct iommu_domain *domain;
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct device_pasid_info *i, *dev_pasid = NULL;
+	struct intel_iommu *iommu = info->iommu;
+	unsigned long flags;
 
-	/* Domain type specific cleanup: */
-	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
-	if (domain) {
-		switch (domain->type) {
-		case IOMMU_DOMAIN_SVA:
-			intel_svm_remove_dev_pasid(dev, pasid);
-			break;
-		default:
-			/* should never reach here */
-			WARN_ON(1);
+	spin_lock_irqsave(&dmar_domain->lock, flags);
+	list_for_each_entry(i, &dmar_domain->dev_pasids, link_domain) {
+		if (i->dev == dev && i->pasid == pasid) {
+			list_del(&i->link_domain);
+			dev_pasid = i;
 			break;
 		}
 	}
+	spin_unlock_irqrestore(&dmar_domain->lock, flags);
+	if (WARN_ON(!dev_pasid))
+		return;
+
+	/* PASID entry already cleared during SVA unbind */
+	if (domain->type != IOMMU_DOMAIN_SVA)
+		intel_pasid_tear_down_entry(iommu, dev, pasid, false);
+
+	kfree(dev_pasid);
+}
+
+static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct dmar_domain *dmar_domain;
+	struct iommu_domain *domain;
+
+	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
+	dmar_domain = to_dmar_domain(domain);
+
+	/*
+	 * SVA Domain type specific cleanup: Not ideal but not until we have
+	 * IOPF capable domain specific ops, we need this special case.
+	 */
+	if (domain->type == IOMMU_DOMAIN_SVA)
+		return intel_svm_remove_dev_pasid(dev, pasid);
 
-	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
+	intel_iommu_detach_device_pasid(domain, dev, pasid);
+	domain_detach_iommu(dmar_domain, info->iommu);
 }
 
 const struct iommu_ops intel_iommu_ops = {
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 65b15be72878..b6c26f25d1ba 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -595,6 +595,7 @@ struct dmar_domain {
 
 	spinlock_t lock;		/* Protect device tracking lists */
 	struct list_head devices;	/* all devices' list */
+	struct list_head dev_pasids;	/* all attached pasids */
 
 	struct dma_pte	*pgd;		/* virtual address */
 	int		gaw;		/* max guest address width */
@@ -708,6 +709,7 @@ struct device_domain_info {
 	u8 ats_supported:1;
 	u8 ats_enabled:1;
 	u8 dtlb_extra_inval:1;	/* Quirk for devices need extra flush */
+	u8 dev_attached:1;	/* Device context activated */
 	u8 ats_qdep;
 	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
 	struct intel_iommu *iommu; /* IOMMU used by this device */
@@ -715,6 +717,12 @@ struct device_domain_info {
 	struct pasid_table *pasid_table; /* pasid table */
 };
 
+struct device_pasid_info {
+	struct list_head link_domain;	/* link to domain siblings */
+	struct device *dev;		/* physical device derived from */
+	ioasid_t pasid;			/* PASID on physical device */
+};
+
 static inline void __iommu_flush_cache(
 	struct intel_iommu *iommu, void *addr, int size)
 {
-- 
2.25.1

