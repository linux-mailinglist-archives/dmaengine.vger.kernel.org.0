Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9036E6F0B47
	for <lists+dmaengine@lfdr.de>; Thu, 27 Apr 2023 19:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244558AbjD0Rpx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Apr 2023 13:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244414AbjD0Rpp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 Apr 2023 13:45:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F781423C;
        Thu, 27 Apr 2023 10:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682617540; x=1714153540;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CRyJbqzwsJkqF3JsU2EACDXdJKzUmZ2BfREYf2oyZ7Y=;
  b=PNWYqLpSDpF2/IowfmHCznjaPfwjpSYjYHpocMe5U1GNZqPObKV6s0cH
   XgfGeLWTFUvYJgvm+HmSQIVXTL2duV0yX5qQTXb7xvpuZunPlKPIlVksP
   wLIgOhEEnnjiMwPgxygVLhLK9JjrQvFGkxbE9LwECJtOTF4Kg0DuOu+sU
   /2yqKnPHnTze+WFi6V5FpQdCkSAVfpT2PLnqy9ZzNPQWa5Lp41HW4wA5v
   /EHPzXor845dXUNlyLyW5wfap1Mr+/3Ml1xC48TqUd3m/peNsHKe7vuiM
   zMpf/JaiqoMyXnHkzb0lK6DOWsXb+n5ZLBh2VatUDzjtpEDDACxNa1OK+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="350398736"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="350398736"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 10:45:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="1024219718"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="1024219718"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by fmsmga005.fm.intel.com with ESMTP; 27 Apr 2023 10:45:22 -0700
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
Subject: [PATCH v5 5/7] iommu/vt-d: Prepare PASID attachment beyond RID_PASID
Date:   Thu, 27 Apr 2023 10:49:35 -0700
Message-Id: <20230427174937.471668-6-jacob.jun.pan@linux.intel.com>
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

Currently, device and default domain attaching process includes RID_PASID
setup whenever PASID is supported.
To prepare for non-RID_PASID usage such as ENQCMDS, we can factor out helper
functions such that they can be reused in any order between PASID and
device attachment. i.e. non-RID_PASID attachment via device_set_pasid()
can happen prior to device_attach().
It was agreed that upper level APIs should not make assumptions about
ordering.
Link: https://lore.kernel.org/lkml/ZAY4zd4OlgSz+puZ@nvidia.com/

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 106 ++++++++++++++++++++++++++++++++----
 drivers/iommu/intel/iommu.h |   8 +++
 2 files changed, 102 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cb586849a1ee..388453a7415e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
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
+		if (dev_pasid->pasid == IOMMU_DEF_RID_PASID)
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
-		qi_flush_piotlb(iommu, did, IOMMU_DEF_RID_PASID, addr, pages, ih);
+		domain_flush_pasid_iotlb(iommu, domain, addr, pages, ih);
 	} else {
 		unsigned long bitmask = aligned_pages - 1;
 
@@ -1584,7 +1627,7 @@ static void intel_flush_iotlb_all(struct iommu_domain *domain)
 		u16 did = domain_id_iommu(dmar_domain, iommu);
 
 		if (dmar_domain->use_first_level)
-			qi_flush_piotlb(iommu, did, IOMMU_DEF_RID_PASID, 0, -1, 0);
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
 
@@ -2433,12 +2477,17 @@ static int dmar_domain_attach_device_pasid(struct dmar_domain *domain,
 					   struct intel_iommu *iommu,
 					   struct device *dev, ioasid_t pasid)
 {
+	struct device_pasid_info *dev_pasid;
+	unsigned long flags;
 	int ret;
 
-	/* PASID table is mandatory for a PCI device in scalable mode. */
 	if (!sm_supported(iommu) && dev_is_real_dma_subdevice(dev))
 		return -EOPNOTSUPP;
 
+	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
+	if (!dev_pasid)
+		return -ENOMEM;
+
 	if (hw_pass_through && domain_type_is_si(domain))
 		ret = intel_pasid_setup_pass_through(iommu, domain, dev, pasid);
 	else if (domain->use_first_level)
@@ -2446,6 +2495,17 @@ static int dmar_domain_attach_device_pasid(struct dmar_domain *domain,
 	else
 		ret = intel_pasid_setup_second_level(iommu, domain, dev, pasid);
 
+	if (ret) {
+		kfree(dev_pasid);
+		return ret;
+	}
+
+	dev_pasid->pasid = pasid;
+	dev_pasid->dev = dev;
+	spin_lock_irqsave(&domain->lock, flags);
+	list_add(&dev_pasid->link_domain, &domain->dev_pasids);
+	spin_unlock_irqrestore(&domain->lock, flags);
+
 	return 0;
 }
 
@@ -2467,16 +2527,13 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 		return ret;
 	info->domain = domain;
 	spin_lock_irqsave(&domain->lock, flags);
+	if (info->dev_attached) {
+		spin_unlock_irqrestore(&domain->lock, flags);
+		return 0;
+	}
 	list_add(&info->link, &domain->devices);
 	spin_unlock_irqrestore(&domain->lock, flags);
 
-	ret = dmar_domain_attach_device_pasid(domain, iommu, dev,
-					      IOMMU_DEF_RID_PASID);
-	if (ret) {
-		dev_err(dev, "Setup RID2PASID failed\n");
-		device_block_translation(dev);
-	}
-
 	ret = domain_context_mapping(domain, dev);
 	if (ret) {
 		dev_err(dev, "Domain context map failed\n");
@@ -2485,8 +2542,9 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 	}
 
 	iommu_enable_pci_caps(info);
+	info->dev_attached = 1;
 
-	return 0;
+	return ret;
 }
 
 static bool device_has_rmrr(struct device *dev)
@@ -4044,6 +4102,7 @@ static void device_block_translation(struct device *dev)
 
 	spin_lock_irqsave(&info->domain->lock, flags);
 	list_del(&info->link);
+	info->dev_attached = 0;
 	spin_unlock_irqrestore(&info->domain->lock, flags);
 
 	domain_detach_iommu(info->domain, iommu);
@@ -4175,8 +4234,15 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 				     struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct intel_iommu *iommu;
+	u8 bus, devfn;
 	int ret;
 
+	iommu = device_to_iommu(dev, &bus, &devfn);
+	if (!iommu)
+		return -ENODEV;
+
 	if (domain->type == IOMMU_DOMAIN_UNMANAGED &&
 	    device_is_rmrr_locked(dev)) {
 		dev_warn(dev, "Device is ineligible for IOMMU domain attach due to platform RMRR requirement.  Contact your platform vendor.\n");
@@ -4190,7 +4256,23 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 	if (ret)
 		return ret;
 
-	return dmar_domain_attach_device(to_dmar_domain(domain), dev);
+	ret = dmar_domain_attach_device(to_dmar_domain(domain), dev);
+	if (ret) {
+		dev_err(dev, "Attach device failed\n");
+		return ret;
+	}
+
+	/* PASID table is mandatory for a PCI device in scalable mode. */
+	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
+		/* Setup the PASID entry for requests without PASID: */
+		ret = dmar_domain_attach_device_pasid(dmar_domain, iommu, dev,
+						      IOMMU_DEF_RID_PASID);
+		if (ret) {
+			dev_err(dev, "Setup RID2PASID failed\n");
+			device_block_translation(dev);
+		}
+	}
+	return ret;
 }
 
 static int intel_iommu_map(struct iommu_domain *domain,
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

