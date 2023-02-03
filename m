Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02966892C8
	for <lists+dmaengine@lfdr.de>; Fri,  3 Feb 2023 09:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjBCIxc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Feb 2023 03:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbjBCIxc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Feb 2023 03:53:32 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E89C42DF5;
        Fri,  3 Feb 2023 00:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675414409; x=1706950409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kB18aiVy7J86X3vvgBkRFgvMDABP1q/NhATKJ+pNSBQ=;
  b=kTQDURaHSMQOhzYQ6a3628YLgatkxralcGHovVzoQHoa0h50PHc8eF+l
   PzBY6RxlLPCAf1wDcbwgCWg3jSHmk3XZfS8UA4wZ3ArwDfB3RO5ExMLb6
   +qkonVo2VmiymwtZibgYxwxgWCs4y3z7XoLiczVco3OPYgQ3cwE6mH40b
   8cZO1wf4GVMjYxJvllCR7WrcIgPu3MzeIAjkmajMU9g4mT3Aayfuh9IqA
   YOGIg3FpyOl96LPdQaeRE9BhIechh5EDLjx3wjE0dGxCzZtK3BAtHwEs1
   qNcf66NX+JTOdmc+5xa+UwN3g7P8LJ85uwRvUFixLkS6hWGRNYXFskYce
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="327337328"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="327337328"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 00:53:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="994447955"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="994447955"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga005.fm.intel.com with ESMTP; 03 Feb 2023 00:53:15 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev, dmaengine@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/2] iommu/vt-d: Move iopf code from SVA to IOPF enabling path
Date:   Fri,  3 Feb 2023 16:44:56 +0800
Message-Id: <20230203084456.469641-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230203084456.469641-1-baolu.lu@linux.intel.com>
References: <20230203084456.469641-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Generally enabling IOMMU_DEV_FEAT_SVA requires IOMMU_DEV_FEAT_IOPF, but
some devices manage I/O Page Faults themselves instead of relying on the
IOMMU. Move IOPF related code from SVA to IOPF enabling path to make the
driver work for devices that manage IOPF themselves.

For the device drivers that relies on the IOMMU for IOPF through PCI/PRI,
IOMMU_DEV_FEAT_IOPF must be enabled before and disabled after
IOMMU_DEV_FEAT_SVA.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a1a66798e1f0..149cb20d8dd5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4632,7 +4632,6 @@ static int intel_iommu_enable_sva(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu;
-	int ret;
 
 	if (!info || dmar_disabled)
 		return -EINVAL;
@@ -4644,17 +4643,13 @@ static int intel_iommu_enable_sva(struct device *dev)
 	if (!(iommu->flags & VTD_FLAG_SVM_CAPABLE))
 		return -ENODEV;
 
-	if (!info->pasid_enabled || !info->pri_enabled || !info->ats_enabled)
+	if (!info->pasid_enabled)
 		return -EINVAL;
 
-	ret = iopf_queue_add_device(iommu->iopf_queue, dev);
-	if (!ret)
-		ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
-
-	return ret;
+	return 0;
 }
 
-static int intel_iommu_disable_sva(struct device *dev)
+static int intel_iommu_disable_iopf(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
@@ -4670,11 +4665,20 @@ static int intel_iommu_disable_sva(struct device *dev)
 static int intel_iommu_enable_iopf(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	int ret;
 
-	if (info && info->pri_supported)
-		return 0;
+	if (!info || !info->ats_enabled || !info->pri_enabled)
+		return -ENODEV;
 
-	return -ENODEV;
+	ret = iopf_queue_add_device(info->iommu->iopf_queue, dev);
+	if (ret)
+		return ret;
+
+	ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
+	if (ret)
+		iopf_queue_remove_device(info->iommu->iopf_queue, dev);
+
+	return ret;
 }
 
 static int
@@ -4697,10 +4701,10 @@ intel_iommu_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
 {
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
-		return 0;
+		return intel_iommu_disable_iopf(dev);
 
 	case IOMMU_DEV_FEAT_SVA:
-		return intel_iommu_disable_sva(dev);
+		return 0;
 
 	default:
 		return -ENODEV;
-- 
2.34.1

