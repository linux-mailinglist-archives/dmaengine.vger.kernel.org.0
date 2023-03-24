Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE076C7DA3
	for <lists+dmaengine@lfdr.de>; Fri, 24 Mar 2023 13:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjCXMCk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Mar 2023 08:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjCXMCd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 24 Mar 2023 08:02:33 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44357241DE;
        Fri, 24 Mar 2023 05:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679659352; x=1711195352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HlO9DJUB1VeUc0i1Z73Y/pek9tXf+C6otlR5IrcBXs8=;
  b=mKWkI3tkbYguRG4hfd0Vxh5zmLMtQfSXqG6g7fubW7ZC4xaIlP3hB2jN
   oMzCC4gWH6G8xqSOONZqo3Ud4OvWKULPApYZl2V4D3iTosTHedbbRa9wO
   RuDuOHUNDia6if7vXC94K3TZMVP1w7WwUf7plKR6rkpY7WcsCOkW6iI+1
   QGocNBywheSpZGlIu9Z1r0zSe6ouvqBS9HJcrMRbyeN8bxZeakWdUT6fc
   Vgi1hTfJAs1RhLfVJO4TbxfUKMfO8sZc5/tmwgEcFwBPBmCzFweQH/KDC
   ZVtzGC+MXUw4kPXdR9I0IboIkJLz0IeOTDuGPZw9uzhGHXkJYySZJLdr5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="323634155"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="323634155"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 05:02:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="682674777"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="682674777"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga002.jf.intel.com with ESMTP; 24 Mar 2023 05:02:29 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev, dmaengine@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 3/6] iommu/vt-d: Move iopf code from SVA to IOPF enabling path
Date:   Fri, 24 Mar 2023 20:02:31 +0800
Message-Id: <20230324120234.313643-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324120234.313643-1-baolu.lu@linux.intel.com>
References: <20230324120234.313643-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Generally enabling IOMMU_DEV_FEAT_SVA requires IOMMU_DEV_FEAT_IOPF, but
some devices manage I/O Page Faults themselves instead of relying on the
IOMMU. Move IOPF related code from SVA to IOPF enabling path.

For the device drivers that relies on the IOMMU for IOPF through PCI/PRI,
IOMMU_DEV_FEAT_IOPF must be enabled before and disabled after
IOMMU_DEV_FEAT_SVA.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index caf664448ee9..a6f07c74da2d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4638,7 +4638,6 @@ static int intel_iommu_enable_sva(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu;
-	int ret;
 
 	if (!info || dmar_disabled)
 		return -EINVAL;
@@ -4667,6 +4666,21 @@ static int intel_iommu_enable_sva(struct device *dev)
 	if (!info->pri_enabled)
 		return -EINVAL;
 
+	return 0;
+}
+
+static int intel_iommu_enable_iopf(struct device *dev)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu;
+	int ret;
+
+	if (!info || !info->ats_enabled || !info->pri_enabled)
+		return -ENODEV;
+	iommu = info->iommu;
+	if (!iommu)
+		return -EINVAL;
+
 	ret = iopf_queue_add_device(iommu->iopf_queue, dev);
 	if (ret)
 		return ret;
@@ -4678,7 +4692,7 @@ static int intel_iommu_enable_sva(struct device *dev)
 	return ret;
 }
 
-static int intel_iommu_disable_sva(struct device *dev)
+static int intel_iommu_disable_iopf(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
@@ -4695,16 +4709,6 @@ static int intel_iommu_disable_sva(struct device *dev)
 	return ret;
 }
 
-static int intel_iommu_enable_iopf(struct device *dev)
-{
-	struct device_domain_info *info = dev_iommu_priv_get(dev);
-
-	if (info && info->pri_supported)
-		return 0;
-
-	return -ENODEV;
-}
-
 static int
 intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
 {
@@ -4725,10 +4729,10 @@ intel_iommu_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
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

