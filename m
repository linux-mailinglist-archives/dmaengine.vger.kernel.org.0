Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176836B19B3
	for <lists+dmaengine@lfdr.de>; Thu,  9 Mar 2023 03:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjCIC6E (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Mar 2023 21:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjCIC57 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 Mar 2023 21:57:59 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE117C2;
        Wed,  8 Mar 2023 18:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678330673; x=1709866673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=etYi5IgjOwIgLSDHDiUJVx1EpEQNh0CUBtN03FXsKLI=;
  b=T1jtIMoj/pvcqeSe6RpJP3cWUpGcC3CSakeV73Nlvd4OyQQAptfk2wtl
   ZgKrhALURGcqyhee9pnjjq9z3OiymoBwLxbb6t9eHFgFEn0hDgKail+3t
   RYPVsD9PnAUL6MJ5jSF7sDxG7RCl2fN5Fa2MyBm+auTZBdXEWp6IsD1pY
   9ryiAoeN1au9wR/xh1EuftSQP2McLqTWDBw8V7KixEaSZq3BiVa7kdZvy
   hR40+0RNbwhmL9NJN7B5DgOLq2nbRGFjGof4O198+BDSlVYd6tTzpktPJ
   r7YXoBsq+9SGhEjAxCKYpn+9+soP3pWTrIlriiHqtdgeP4azGoXJ94b8o
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="316732664"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="316732664"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 18:57:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="746144632"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="746144632"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga004.fm.intel.com with ESMTP; 08 Mar 2023 18:57:51 -0800
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
Subject: [PATCH v2 3/5] iommu/vt-d: Move iopf code from SVA to IOPF enabling path
Date:   Thu,  9 Mar 2023 10:56:37 +0800
Message-Id: <20230309025639.26109-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230309025639.26109-1-baolu.lu@linux.intel.com>
References: <20230309025639.26109-1-baolu.lu@linux.intel.com>
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
IOMMU. Move IOPF related code from SVA to IOPF enabling path.

For the device drivers that relies on the IOMMU for IOPF through PCI/PRI,
IOMMU_DEV_FEAT_IOPF must be enabled before and disabled after
IOMMU_DEV_FEAT_SVA.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d2fcab9d8f61..9ada12bf38dd 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4638,7 +4638,6 @@ static int intel_iommu_enable_sva(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu;
-	int ret;
 
 	if (!info || dmar_disabled)
 		return -EINVAL;
@@ -4664,6 +4663,21 @@ static int intel_iommu_enable_sva(struct device *dev)
 	if (!info->pri_enabled || !info->ats_enabled)
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
@@ -4675,7 +4689,7 @@ static int intel_iommu_enable_sva(struct device *dev)
 	return ret;
 }
 
-static int intel_iommu_disable_sva(struct device *dev)
+static int intel_iommu_disable_iopf(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
@@ -4692,16 +4706,6 @@ static int intel_iommu_disable_sva(struct device *dev)
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
@@ -4722,10 +4726,10 @@ intel_iommu_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
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

