Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4629F6CB22F
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 01:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjC0XRq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Mar 2023 19:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjC0XRm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Mar 2023 19:17:42 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22502695;
        Mon, 27 Mar 2023 16:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679959060; x=1711495060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1SdkUUUBHZJQCRi6h0Z7n2ql7EVR5htvRrWsQgDktQs=;
  b=MW1eMcz4wB1OuWTXqBhJ4FRf32rjF9elGR3c8A+4UxCjFidgNp6+uw6t
   CRLb/B++MAbSWOMgIvfb3dLZkacCHWsFpNhAoPZHG4/BwZOxBaHdTdbLp
   3gBy4rjad+Q+ZQ5X4aPVWMNCPYNsJzQ6ajkPkwDmUWrR63lbZAW7k6o9A
   MiulocGvJe2OYsxA4UIv93kPO00MBpVetUvz7HBac8rws9iD1/GEEnXlt
   8k9gs6iF3YTvrqKodFCzueKafVOUWhxvNiTZS8lNUE+Y9R0TW5ah0VwQ1
   vcUdZ95FRG3NSUH1gPurWJJ9KrRzaYZxNwZ2HW04ciSKZsB2Yfk8FiWvY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="320817327"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="320817327"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 16:17:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="686144732"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="686144732"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by fmsmga007.fm.intel.com with ESMTP; 27 Mar 2023 16:17:39 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org
Cc:     "Robin Murphy" <robin.murphy@arm.com>,
        "Will Deacon" <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 5/8] iommu/vt-d: Make device pasid attachment explicit
Date:   Mon, 27 Mar 2023 16:21:35 -0700
Message-Id: <20230327232138.1490712-6-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
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
 drivers/iommu/intel/iommu.c | 161 +++++++++++++++++++++++++++---------
 drivers/iommu/intel/iommu.h |   8 ++
 2 files changed, 131 insertions(+), 38 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 61c06f7ad8f7..0a195136bac7 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -277,7 +277,7 @@ static LIST_HEAD(dmar_satc_units);
 #define for_each_rmrr_units(rmrr) \
 	list_for_each_entry(rmrr, &dmar_rmrr_units, list)
 
-static void device_block_translation(struct device *dev);
+static void device_block_translation(struct device *dev, struct device_pasid_info *dev_pasid);
 static void intel_iommu_domain_free(struct iommu_domain *domain);
 
 int dmar_disabled = !IS_ENABLED(CONFIG_INTEL_IOMMU_DEFAULT_ON);
@@ -1365,6 +1365,7 @@ domain_lookup_dev_info(struct dmar_domain *domain,
 
 static void domain_update_iotlb(struct dmar_domain *domain)
 {
+	struct device_pasid_info *dev_pasid;
 	struct device_domain_info *info;
 	bool has_iotlb_device = false;
 	unsigned long flags;
@@ -1376,6 +1377,14 @@ static void domain_update_iotlb(struct dmar_domain *domain)
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
@@ -1486,6 +1495,7 @@ static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
 static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 				  u64 addr, unsigned mask)
 {
+	struct device_pasid_info *dev_pasid;
 	struct device_domain_info *info;
 	unsigned long flags;
 
@@ -1495,6 +1505,39 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
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
 
@@ -1514,7 +1557,7 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 		ih = 1 << 6;
 
 	if (domain->use_first_level) {
-		qi_flush_piotlb(iommu, did, PASID_RID2PASID, addr, pages, ih);
+		domain_flush_pasid_iotlb(iommu, domain, addr, pages, ih);
 	} else {
 		unsigned long bitmask = aligned_pages - 1;
 
@@ -1584,7 +1627,7 @@ static void intel_flush_iotlb_all(struct iommu_domain *domain)
 		u16 did = domain_id_iommu(dmar_domain, iommu);
 
 		if (dmar_domain->use_first_level)
-			qi_flush_piotlb(iommu, did, PASID_RID2PASID, 0, -1, 0);
+			domain_flush_pasid_iotlb(iommu, dmar_domain, 0, -1, 0);
 		else
 			iommu->flush.flush_iotlb(iommu, did, 0, 0,
 						 DMA_TLB_DSI_FLUSH);
@@ -1756,6 +1799,7 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 		domain->use_first_level = true;
 	domain->has_iotlb_device = false;
 	INIT_LIST_HEAD(&domain->devices);
+	INIT_LIST_HEAD(&domain->dev_pasids);
 	spin_lock_init(&domain->lock);
 	xa_init(&domain->iommu_array);
 
@@ -2429,10 +2473,11 @@ static int __init si_domain_init(int hw)
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
@@ -2442,43 +2487,56 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
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
-			device_block_translation(dev);
-			return ret;
+			dev_err(dev, "Setup PASID %d failed\n", pasid);
+			device_block_translation(dev, dev_pasid);
+			goto exit_free;
 		}
 	}
+	/* device context already activated,  we are done */
+	if (info->dev_attached)
+		goto exit;
 
 	ret = domain_context_mapping(domain, dev);
 	if (ret) {
 		dev_err(dev, "Domain context map failed\n");
-		device_block_translation(dev);
-		return ret;
+		device_block_translation(dev, dev_pasid);
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
@@ -4020,17 +4078,21 @@ static void dmar_remove_one_dev_info(struct device *dev)
  * all DMA requests without PASID from the device are blocked. If the page
  * table has been set, clean up the data structures.
  */
-static void device_block_translation(struct device *dev)
+static void device_block_translation(struct device *dev, struct device_pasid_info *dev_pasid)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
+	ioasid_t pasid = PASID_RID2PASID;
 	unsigned long flags;
 
+	if (dev_pasid)
+		pasid = dev_pasid->pasid;
+
 	iommu_disable_pci_caps(info);
 	if (!dev_is_real_dma_subdevice(dev)) {
 		if (sm_supported(iommu))
 			intel_pasid_tear_down_entry(iommu, dev,
-						    PASID_RID2PASID, false);
+						    pasid, false);
 		else
 			domain_context_clear(info);
 	}
@@ -4040,6 +4102,8 @@ static void device_block_translation(struct device *dev)
 
 	spin_lock_irqsave(&info->domain->lock, flags);
 	list_del(&info->link);
+	if (dev_pasid)
+		list_del(&dev_pasid->link_domain);
 	spin_unlock_irqrestore(&info->domain->lock, flags);
 
 	domain_detach_iommu(info->domain, iommu);
@@ -4070,7 +4134,7 @@ static int md_domain_init(struct dmar_domain *domain, int guest_width)
 static int blocking_domain_attach_dev(struct iommu_domain *domain,
 				      struct device *dev)
 {
-	device_block_translation(dev);
+	device_block_translation(dev, NULL);
 	return 0;
 }
 
@@ -4180,13 +4244,13 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 	}
 
 	if (info->domain)
-		device_block_translation(dev);
+		device_block_translation(dev, NULL);
 
 	ret = prepare_domain_attach_device(domain, dev);
 	if (ret)
 		return ret;
 
-	return dmar_domain_attach_device(to_dmar_domain(domain), dev);
+	return dmar_domain_attach_device_pasid(to_dmar_domain(domain), dev, PASID_RID2PASID);
 }
 
 static int intel_iommu_map(struct iommu_domain *domain,
@@ -4675,26 +4739,47 @@ static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
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
 
-	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
+	domain_detach_iommu(dmar_domain, iommu);
+	kfree(dev_pasid);
+}
+
+static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
+{
+	struct iommu_domain *domain;
+
+	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
+	/*
+	 * SVA Domain type specific cleanup: Not ideal but not until we have
+	 * IOPF capable domain specific ops, we need this special case.
+	 */
+	if (domain->type == IOMMU_DOMAIN_SVA)
+		return intel_svm_remove_dev_pasid(dev, pasid);
+	intel_iommu_detach_device_pasid(domain, dev, pasid);
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

