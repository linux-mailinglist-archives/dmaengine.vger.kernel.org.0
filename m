Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47E06B19AF
	for <lists+dmaengine@lfdr.de>; Thu,  9 Mar 2023 03:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjCIC5u (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Mar 2023 21:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCIC5t (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 Mar 2023 21:57:49 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577BB91B4F;
        Wed,  8 Mar 2023 18:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678330668; x=1709866668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mr8/K6JBGpVgjtzlsLYvSNCRVB4WvcXxxyRVG14osPg=;
  b=SL98nc+dD5afs9cyGYSjig4cb5y9xRDawWza4Km/W1QlbUGntMdxXAZQ
   bPDExRvfbehP9GB2QNf6HDdZBOUWboW0HsKopo6E931AHGVZrjK0dB+ru
   aeHkExW6LZVBT1LGneXivUEfXV5Zc3gy6VFa9gc8Y4YE4MBQ33zOB3jYW
   fudLToUjkfnp1VAitFwBvizxVVPsKK1POwJH92EMp4UDCsk3MakU9szL+
   rgPPjIQBRBhnXrXMniLN8g/gKp1hpVQJpBZQot+obYVxMdB5Uzfrmc36e
   vqR+UX6RanKrzVAbxQQmS85p6Fiv7Z+sjt2EMuK2dVabcq2dmbL6yUsEA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="316732642"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="316732642"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 18:57:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="746144610"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="746144610"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga004.fm.intel.com with ESMTP; 08 Mar 2023 18:57:45 -0800
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
Subject: [PATCH v2 1/5] dmaengine: idxd: Add enable/disable device IOPF feature
Date:   Thu,  9 Mar 2023 10:56:35 +0800
Message-Id: <20230309025639.26109-2-baolu.lu@linux.intel.com>
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

The iommu subsystem requires IOMMU_DEV_FEAT_IOPF must be enabled before
and disabled after IOMMU_DEV_FEAT_SVA, if device's I/O page faults rely
on the IOMMU. Add explicit IOMMU_DEV_FEAT_IOPF enabling/disabling in this
driver.

At present, missing IOPF enabling/disabling doesn't cause any real issue,
because the IOMMU driver places the IOPF enabling/disabling in the path
of SVA feature handling. But this may change.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/dma/idxd/init.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 640d3048368e..09ef62aa0635 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -516,6 +516,27 @@ static void idxd_disable_system_pasid(struct idxd_device *idxd)
 	idxd->sva = NULL;
 }
 
+static int idxd_enable_sva(struct pci_dev *pdev)
+{
+	int ret;
+
+	ret = iommu_dev_enable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
+	if (ret)
+		return ret;
+
+	ret = iommu_dev_enable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
+	if (ret)
+		iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
+
+	return ret;
+}
+
+static void idxd_disable_sva(struct pci_dev *pdev)
+{
+	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
+	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
+}
+
 static int idxd_probe(struct idxd_device *idxd)
 {
 	struct pci_dev *pdev = idxd->pdev;
@@ -530,7 +551,7 @@ static int idxd_probe(struct idxd_device *idxd)
 	dev_dbg(dev, "IDXD reset complete\n");
 
 	if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM) && sva) {
-		if (iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA)) {
+		if (idxd_enable_sva(pdev)) {
 			dev_warn(dev, "Unable to turn on user SVA feature.\n");
 		} else {
 			set_bit(IDXD_FLAG_USER_PASID_ENABLED, &idxd->flags);
@@ -578,21 +599,19 @@ static int idxd_probe(struct idxd_device *idxd)
 	if (device_pasid_enabled(idxd))
 		idxd_disable_system_pasid(idxd);
 	if (device_user_pasid_enabled(idxd))
-		iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA);
+		idxd_disable_sva(pdev);
 	return rc;
 }
 
 static void idxd_cleanup(struct idxd_device *idxd)
 {
-	struct device *dev = &idxd->pdev->dev;
-
 	perfmon_pmu_remove(idxd);
 	idxd_cleanup_interrupts(idxd);
 	idxd_cleanup_internals(idxd);
 	if (device_pasid_enabled(idxd))
 		idxd_disable_system_pasid(idxd);
 	if (device_user_pasid_enabled(idxd))
-		iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA);
+		idxd_disable_sva(idxd->pdev);
 }
 
 static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
@@ -710,7 +729,7 @@ static void idxd_remove(struct pci_dev *pdev)
 	pci_free_irq_vectors(pdev);
 	pci_iounmap(pdev, idxd->reg_base);
 	if (device_user_pasid_enabled(idxd))
-		iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
+		idxd_disable_sva(pdev);
 	pci_disable_device(pdev);
 	destroy_workqueue(idxd->wq);
 	perfmon_pmu_remove(idxd);
-- 
2.34.1

