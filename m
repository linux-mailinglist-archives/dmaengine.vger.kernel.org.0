Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597CD6C7D9F
	for <lists+dmaengine@lfdr.de>; Fri, 24 Mar 2023 13:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjCXMC2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Mar 2023 08:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjCXMC1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 24 Mar 2023 08:02:27 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924CE23DBA;
        Fri, 24 Mar 2023 05:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679659346; x=1711195346;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6qHH3kdmqICVZ9+zA4TiLrfUZ5cUI9ZxES/yWptHuC0=;
  b=DiFQlU9Vf64fnPa11KS8FDtZZJ2EKVuFQtZveMXYA8NmEoEwWx/LzNvJ
   MxdFy9hPhPRKC00u2JnxWeg0YrIjxN1a+XlqKBTi4df2CB2FrJZqjRRw8
   +zWENGCQjlywANjBoq/koDEyqAnjLEfTpDV7YlyiupdjG4+qQLmDrTxxe
   bfY8XBZCpRwxqPFTaTYsQQXKUESvaonlIaa2eONd0YTV2u3j6fcPaeO6g
   XpeudK60LdyzcqZwsbmpOYsa4nhEpZwRYDVLdtSLWBbjFW5VAbI0vz9ba
   2RJigUFL3RhCCy0t412CR88KfsIsXwv6FWZ16jyRuj8i59sa1YMR8hWVK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="323634139"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="323634139"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 05:02:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="682674713"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="682674713"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga002.jf.intel.com with ESMTP; 24 Mar 2023 05:02:23 -0700
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
Subject: [PATCH v3 1/6] dmaengine: idxd: Add enable/disable device IOPF feature
Date:   Fri, 24 Mar 2023 20:02:29 +0800
Message-Id: <20230324120234.313643-2-baolu.lu@linux.intel.com>
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

The iommu subsystem requires IOMMU_DEV_FEAT_IOPF must be enabled before
and disabled after IOMMU_DEV_FEAT_SVA, if device's I/O page faults rely
on the IOMMU. Add explicit IOMMU_DEV_FEAT_IOPF enabling/disabling in this
driver.

At present, missing IOPF enabling/disabling doesn't cause any real issue,
because the IOMMU driver places the IOPF enabling/disabling in the path
of SVA feature handling. But this may change.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
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

