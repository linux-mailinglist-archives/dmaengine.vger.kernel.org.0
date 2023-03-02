Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB41E6A7885
	for <lists+dmaengine@lfdr.de>; Thu,  2 Mar 2023 01:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjCBA4U (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Mar 2023 19:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjCBA4T (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Mar 2023 19:56:19 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E853F5678D;
        Wed,  1 Mar 2023 16:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677718578; x=1709254578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iAEeG4ALX1eVVTpD7m5C0QNfU+j9krX/lMoruCC5oxY=;
  b=Q9GxJoeeOMGps0DiQCbTkOhZyHOcwRcfiiit/Eztqgxda9FqYWd3Z0sh
   Mw4hxSt9vafYYAgmZOqllFHdOB87VNZRMxNWBDt6cy5r2b3DRzBlJkHf5
   NSK1ruEz8WOqMKsdZz1BE9cxoA/HeEfLfm8SaATncpXvd6zajIPj8iUpX
   rHsAx5ZBZk+Cg1qbUxBAPT0oZL2NAbqsdVvqVf4nDxcQVYpHhC3EJuJK6
   0jWIJKiuSNKwuHt4lv6zkIdCMKMAXPQ1rshVVNY6ZzzEK9hbYyB0nyO6F
   +oz9EL6flttG5Z8X2y49xr10pvUte8VnuaAU2EvfAUVBg5/vy4+nb0kiF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="397141475"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="397141475"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 16:56:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="624708990"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="624708990"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by orsmga003.jf.intel.com with ESMTP; 01 Mar 2023 16:56:11 -0800
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
Subject: [PATCH 1/4] iommu/vt-d: Implement set device pasid op for default domain
Date:   Wed,  1 Mar 2023 16:59:56 -0800
Message-Id: <20230302005959.2695267-2-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On VT-d platforms, legacy DMA requests without PASID use device’s
default domain, where RID_PASID is always attached. Device drivers
can then use the DMA API for all in-kernel DMA on the RID.

Ideally, devices capable of using ENQCMDS can also transparently use the
default domain, consequently DMA API. However, VT-d architecture
dictates that the PASID used by ENQCMDS must be different from the
RID_PASID value.

To provide support for transparent use of DMA API with non-RID_PASID
value, this patch implements the set_dev_pasid() function for the
default domain. The idea is that device drivers wishing to use ENQCMDS
to submit work on buffers mapped by DMA API will call
iommu_attach_device_pasid() beforehand.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 10f657828d3a..a0cb3bc851ac 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4665,6 +4665,10 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 		case IOMMU_DOMAIN_SVA:
 			intel_svm_remove_dev_pasid(dev, pasid);
 			break;
+		case IOMMU_DOMAIN_DMA:
+		case IOMMU_DOMAIN_DMA_FQ:
+		case IOMMU_DOMAIN_IDENTITY:
+			break;
 		default:
 			/* should never reach here */
 			WARN_ON(1);
@@ -4675,6 +4679,33 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
 }
 
+static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
+				   struct device *dev, ioasid_t pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct intel_iommu *iommu = info->iommu;
+	int ret = 0;
+
+	if (!sm_supported(iommu) || !info)
+		return -ENODEV;
+
+	if (WARN_ON(pasid == PASID_RID2PASID))
+		return -EINVAL;
+
+	if (hw_pass_through && domain_type_is_si(dmar_domain))
+		ret = intel_pasid_setup_pass_through(iommu, dmar_domain,
+						     dev, pasid);
+	else if (dmar_domain->use_first_level)
+		ret = domain_setup_first_level(iommu, dmar_domain,
+					       dev, pasid);
+	else
+		ret = intel_pasid_setup_second_level(iommu, dmar_domain,
+						     dev, pasid);
+
+	return ret;
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
@@ -4702,6 +4733,7 @@ const struct iommu_ops intel_iommu_ops = {
 		.iova_to_phys		= intel_iommu_iova_to_phys,
 		.free			= intel_iommu_domain_free,
 		.enforce_cache_coherency = intel_iommu_enforce_cache_coherency,
+		.set_dev_pasid		= intel_iommu_set_dev_pasid,
 	}
 };
 
-- 
2.25.1

