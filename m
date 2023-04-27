Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A606F0B45
	for <lists+dmaengine@lfdr.de>; Thu, 27 Apr 2023 19:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244163AbjD0Rpx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Apr 2023 13:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244271AbjD0Rpo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 Apr 2023 13:45:44 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0CD3581;
        Thu, 27 Apr 2023 10:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682617540; x=1714153540;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/8RWr0U3j2KVbiC09idxwXgdGc0DHtm2IMJ6x0/p/c0=;
  b=RyThv+hqWTvnFm1xLzOXfVfzt1g/tF2pYztEScCt4IAiXkSlLH7+1Ztp
   ccRuOnWzFPRKzFde4i/SzVgZAFDChzYu1frGRRWcwNCRjeExfV8xogB6V
   95DvowXkpXFjZOqsWIVaqitBJIFwDIpNxj5ML2/v3jn9oKKAXkcC0kPhk
   Ue5S5lmLtQG87S/rx3uS/nam6aX1zBPOgQjoNx8fmXMgvFVwP+s11Nxzy
   skOVMHWESevVeYEaKHe9BbFksZpY6/DLvqsYATQvC01Svg4RzdGwkAls7
   AdvLsCYdsabUMdxOfcV2L9z6A4FNhv8QKGdpSsYhuuGjZoMFpoOvI6cCG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="350398724"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="350398724"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 10:45:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="1024219712"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="1024219712"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by fmsmga005.fm.intel.com with ESMTP; 27 Apr 2023 10:45:21 -0700
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
Subject: [PATCH v5 4/7] iommu/vt-d: Factoring out PASID set up helper function
Date:   Thu, 27 Apr 2023 10:49:34 -0700
Message-Id: <20230427174937.471668-5-jacob.jun.pan@linux.intel.com>
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

From: Lu Baolu <baolu.lu@linux.intel.com>

To prepare non-RID_PASID attachment, factoring out common code to be
reused. PASID entry set up is common for all DMA API PASIDs.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 42 ++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9ec45e0497cc..cb586849a1ee 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2429,6 +2429,26 @@ static int __init si_domain_init(int hw)
 	return 0;
 }
 
+static int dmar_domain_attach_device_pasid(struct dmar_domain *domain,
+					   struct intel_iommu *iommu,
+					   struct device *dev, ioasid_t pasid)
+{
+	int ret;
+
+	/* PASID table is mandatory for a PCI device in scalable mode. */
+	if (!sm_supported(iommu) && dev_is_real_dma_subdevice(dev))
+		return -EOPNOTSUPP;
+
+	if (hw_pass_through && domain_type_is_si(domain))
+		ret = intel_pasid_setup_pass_through(iommu, domain, dev, pasid);
+	else if (domain->use_first_level)
+		ret = domain_setup_first_level(iommu, domain, dev, pasid);
+	else
+		ret = intel_pasid_setup_second_level(iommu, domain, dev, pasid);
+
+	return 0;
+}
+
 static int dmar_domain_attach_device(struct dmar_domain *domain,
 				     struct device *dev)
 {
@@ -2450,23 +2470,11 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 	list_add(&info->link, &domain->devices);
 	spin_unlock_irqrestore(&domain->lock, flags);
 
-	/* PASID table is mandatory for a PCI device in scalable mode. */
-	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
-		/* Setup the PASID entry for requests without PASID: */
-		if (hw_pass_through && domain_type_is_si(domain))
-			ret = intel_pasid_setup_pass_through(iommu, domain,
-					dev, IOMMU_DEF_RID_PASID);
-		else if (domain->use_first_level)
-			ret = domain_setup_first_level(iommu, domain, dev,
-					IOMMU_DEF_RID_PASID);
-		else
-			ret = intel_pasid_setup_second_level(iommu, domain,
-					dev, IOMMU_DEF_RID_PASID);
-		if (ret) {
-			dev_err(dev, "Setup RID2PASID failed\n");
-			device_block_translation(dev);
-			return ret;
-		}
+	ret = dmar_domain_attach_device_pasid(domain, iommu, dev,
+					      IOMMU_DEF_RID_PASID);
+	if (ret) {
+		dev_err(dev, "Setup RID2PASID failed\n");
+		device_block_translation(dev);
 	}
 
 	ret = domain_context_mapping(domain, dev);
-- 
2.25.1

