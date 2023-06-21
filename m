Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C26D739129
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jun 2023 22:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjFUUz1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 21 Jun 2023 16:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjFUUzN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 21 Jun 2023 16:55:13 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E791D10F8;
        Wed, 21 Jun 2023 13:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687380911; x=1718916911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n9e+x5KIG9y3L9yhpC/i1d2YZuCh2BS2PfXSQcvbH+g=;
  b=IB35grlql/BJg1yiBLYr/eUKRFonizhVe5HvETFBrFgrJcVz7HR5fdti
   hMiYOQWcTGmR1vOKvOxd/xGfgchPYdAddYnAhM8wKcwJ3m17FGYhI8BLq
   tywNuQ5bDtoCc3xC35HSYzP0EfQmN7imu7PXFuMh3WMn+9OfeL+gfApsr
   0/bR/ZL0xD1ofzaSCYXDiVhP/jb+K3NkfsFT2msC5T4lAOc//VULmHFAd
   cbuVuQNpDgrn57cY7WWWXPyJ3g5g857Yhmg22x+Jsni3ubkqiPS6fsfg2
   2O9rkczdF55GjK1VTJFs5IcAZreXz98svacjg+hJy2sHY90E4p+jsQIdW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="359168958"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="359168958"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 13:55:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="827597929"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="827597929"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.97.184])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jun 2023 13:55:09 -0700
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
Subject: [PATCH v9 6/7] iommu/vt-d: Add set_dev_pasid callback for dma domain
Date:   Wed, 21 Jun 2023 13:59:46 -0700
Message-Id: <20230621205947.1327094-7-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230621205947.1327094-1-jacob.jun.pan@linux.intel.com>
References: <20230621205947.1327094-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Lu Baolu <baolu.lu@linux.intel.com>

This allows the upper layers to set a domain to a PASID of a device
if the PASID feature is supported by the IOMMU hardware. The typical
use cases are, for example, kernel DMA with PASID and hardware
assisted mediated device drivers.

The attaching device and pasid information is tracked in a per-domain
list and is used for IOTLB and devTLB invalidation.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 103 ++++++++++++++++++++++++++++++++++--
 drivers/iommu/intel/iommu.h |   7 +++
 2 files changed, 105 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 8ea656446616..a1f4730743ee 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1367,6 +1367,7 @@ domain_lookup_dev_info(struct dmar_domain *domain,
 
 static void domain_update_iotlb(struct dmar_domain *domain)
 {
+	struct dev_pasid_info *dev_pasid;
 	struct device_domain_info *info;
 	bool has_iotlb_device = false;
 	unsigned long flags;
@@ -1378,6 +1379,14 @@ static void domain_update_iotlb(struct dmar_domain *domain)
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
@@ -1463,6 +1472,7 @@ static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
 static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 				  u64 addr, unsigned mask)
 {
+	struct dev_pasid_info *dev_pasid;
 	struct device_domain_info *info;
 	unsigned long flags;
 
@@ -1472,6 +1482,19 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 	spin_lock_irqsave(&domain->lock, flags);
 	list_for_each_entry(info, &domain->devices, link)
 		__iommu_flush_dev_iotlb(info, addr, mask);
+
+	list_for_each_entry(dev_pasid, &domain->dev_pasids, link_domain) {
+		info = dev_iommu_priv_get(dev_pasid->dev);
+
+		if (!info->ats_enabled)
+			continue;
+
+		qi_flush_dev_iotlb_pasid(info->iommu,
+					 PCI_DEVID(info->bus, info->devfn),
+					 info->pfsid, dev_pasid->pasid,
+					 info->ats_qdep, addr,
+					 mask);
+	}
 	spin_unlock_irqrestore(&domain->lock, flags);
 }
 
@@ -1485,9 +1508,13 @@ static void domain_flush_pasid_iotlb(struct intel_iommu *iommu,
 				     unsigned long npages, bool ih)
 {
 	u16 did = domain_id_iommu(domain, iommu);
+	struct dev_pasid_info *dev_pasid;
 	unsigned long flags;
 
 	spin_lock_irqsave(&domain->lock, flags);
+	list_for_each_entry(dev_pasid, &domain->dev_pasids, link_domain)
+		qi_flush_piotlb(iommu, did, dev_pasid->pasid, addr, npages, ih);
+
 	if (!list_empty(&domain->devices))
 		qi_flush_piotlb(iommu, did, IOMMU_NO_PASID, addr, npages, ih);
 	spin_unlock_irqrestore(&domain->lock, flags);
@@ -1752,6 +1779,7 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 		domain->use_first_level = true;
 	domain->has_iotlb_device = false;
 	INIT_LIST_HEAD(&domain->devices);
+	INIT_LIST_HEAD(&domain->dev_pasids);
 	spin_lock_init(&domain->lock);
 	xa_init(&domain->iommu_array);
 
@@ -4738,7 +4766,10 @@ static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 {
 	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
+	struct dev_pasid_info *curr, *dev_pasid = NULL;
+	struct dmar_domain *dmar_domain;
 	struct iommu_domain *domain;
+	unsigned long flags;
 
 	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
 	if (!domain)
@@ -4754,17 +4785,78 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 		goto out_tear_down;
 	}
 
-	/*
-	 * Should never reach here until we add support for attaching
-	 * non-SVA domain to a pasid.
-	 */
-	WARN_ON(1);
+	dmar_domain = to_dmar_domain(domain);
+	spin_lock_irqsave(&dmar_domain->lock, flags);
+	list_for_each_entry(curr, &dmar_domain->dev_pasids, link_domain) {
+		if (curr->dev == dev && curr->pasid == pasid) {
+			list_del(&curr->link_domain);
+			dev_pasid = curr;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&dmar_domain->lock, flags);
 
+	domain_detach_iommu(dmar_domain, iommu);
+	kfree(dev_pasid);
 out_tear_down:
 	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
 	intel_drain_pasid_prq(dev, pasid);
 }
 
+static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
+				     struct device *dev, ioasid_t pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct intel_iommu *iommu = info->iommu;
+	struct dev_pasid_info *dev_pasid;
+	unsigned long flags;
+	int ret;
+
+	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
+		return -EOPNOTSUPP;
+
+	if (context_copied(iommu, info->bus, info->devfn))
+		return -EBUSY;
+
+	ret = prepare_domain_attach_device(domain, dev);
+	if (ret)
+		return ret;
+
+	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
+	if (!dev_pasid)
+		return -ENOMEM;
+
+	ret = domain_attach_iommu(dmar_domain, iommu);
+	if (ret)
+		goto out_free;
+
+	if (domain_type_is_si(dmar_domain))
+		ret = intel_pasid_setup_pass_through(iommu, dmar_domain,
+						     dev, pasid);
+	else if (dmar_domain->use_first_level)
+		ret = domain_setup_first_level(iommu, dmar_domain,
+					       dev, pasid);
+	else
+		ret = intel_pasid_setup_second_level(iommu, dmar_domain,
+						     dev, pasid);
+	if (ret)
+		goto out_detach_iommu;
+
+	dev_pasid->dev = dev;
+	dev_pasid->pasid = pasid;
+	spin_lock_irqsave(&dmar_domain->lock, flags);
+	list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
+	spin_unlock_irqrestore(&dmar_domain->lock, flags);
+
+	return 0;
+out_detach_iommu:
+	domain_detach_iommu(dmar_domain, iommu);
+out_free:
+	kfree(dev_pasid);
+	return ret;
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
@@ -4784,6 +4876,7 @@ const struct iommu_ops intel_iommu_ops = {
 #endif
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev		= intel_iommu_attach_device,
+		.set_dev_pasid		= intel_iommu_set_dev_pasid,
 		.map_pages		= intel_iommu_map_pages,
 		.unmap_pages		= intel_iommu_unmap_pages,
 		.iotlb_sync_map		= intel_iommu_iotlb_sync_map,
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 6d94a29f5d52..68bb7cdf5543 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -595,6 +595,7 @@ struct dmar_domain {
 
 	spinlock_t lock;		/* Protect device tracking lists */
 	struct list_head devices;	/* all devices' list */
+	struct list_head dev_pasids;	/* all attached pasids */
 
 	struct dma_pte	*pgd;		/* virtual address */
 	int		gaw;		/* max guest address width */
@@ -717,6 +718,12 @@ struct device_domain_info {
 	struct pasid_table *pasid_table; /* pasid table */
 };
 
+struct dev_pasid_info {
+	struct list_head link_domain;	/* link to domain siblings */
+	struct device *dev;		/* the physical device */
+	ioasid_t pasid;			/* PASID of the physical device */
+};
+
 static inline void __iommu_flush_cache(
 	struct intel_iommu *iommu, void *addr, int size)
 {
-- 
2.25.1

