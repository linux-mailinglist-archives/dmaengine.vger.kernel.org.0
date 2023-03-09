Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C82C6B19B6
	for <lists+dmaengine@lfdr.de>; Thu,  9 Mar 2023 03:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjCIC6K (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Mar 2023 21:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjCIC6E (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 Mar 2023 21:58:04 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7B2244B3;
        Wed,  8 Mar 2023 18:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678330679; x=1709866679;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hyRAeVg/VZEIlAorH/vE8IpPiieMJP0llhhFp7ElHnk=;
  b=HUYjJpUuAfVFpx0LrgbR1Y23EX3ApUBeCDzIAGfCk6CgqgYQU40Ml6vh
   iEX9zsTWCy5mQLi7hMu4sBcVpwtl24YAc8Sv66pBxx/UzRq6TvVDfd+ta
   lVm8bNhVWQiHSJI4xctLt/lt9ZC86h1b/nnJMc0MNoArmTMu7H4BXA1aT
   aapUg5a0QQWRitTAFIeg2GU8JX7wcZREV1JMwRxA3FddcBLiVDyi6ID+V
   bPobRnfcwodojfCxZVYN1Ww3Kd1qKMjqradbajb5tFdfo2Bj4z4FiPe5e
   DVBht3TZ2HOwsNnYwzcBn1XxK49JmllTKuaIScpHgrkZKEQnMLDehkO38
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="316732691"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="316732691"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 18:57:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="746144657"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="746144657"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga004.fm.intel.com with ESMTP; 08 Mar 2023 18:57:56 -0800
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
Subject: [PATCH v2 5/5] iommu/vt-d: Move PRI handling to IOPF feature path
Date:   Thu,  9 Mar 2023 10:56:39 +0800
Message-Id: <20230309025639.26109-6-baolu.lu@linux.intel.com>
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

PRI is only used for IOPF. With this move, the PCI/PRI feature could be
controlled by the device driver through iommu_dev_enable/disable_feature()
interfaces.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 59 ++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index fb64ab8358a9..4ed32bde4287 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1415,11 +1415,6 @@ static void iommu_enable_pci_caps(struct device_domain_info *info)
 	if (info->pasid_supported && !pci_enable_pasid(pdev, info->pasid_supported & ~1))
 		info->pasid_enabled = 1;
 
-	if (info->pri_supported &&
-	    (info->pasid_enabled ? pci_prg_resp_pasid_required(pdev) : 1)  &&
-	    !pci_reset_pri(pdev) && !pci_enable_pri(pdev, PRQ_DEPTH))
-		info->pri_enabled = 1;
-
 	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
 	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
 		info->ats_enabled = 1;
@@ -1442,11 +1437,6 @@ static void iommu_disable_pci_caps(struct device_domain_info *info)
 		domain_update_iotlb(info->domain);
 	}
 
-	if (info->pri_enabled) {
-		pci_disable_pri(pdev);
-		info->pri_enabled = 0;
-	}
-
 	if (info->pasid_enabled) {
 		pci_disable_pasid(pdev);
 		info->pasid_enabled = 0;
@@ -4664,23 +4654,48 @@ static int intel_iommu_enable_sva(struct device *dev)
 
 static int intel_iommu_enable_iopf(struct device *dev)
 {
+	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu;
 	int ret;
 
-	if (!info || !info->ats_enabled || !info->pri_enabled)
+	if (!pdev || !info || !info->ats_enabled || !info->pri_supported)
 		return -ENODEV;
+
+	if (info->pri_enabled)
+		return -EBUSY;
+
 	iommu = info->iommu;
 	if (!iommu)
 		return -EINVAL;
 
+	/* PASID is required in PRG Response Message. */
+	if (info->pasid_enabled && !pci_prg_resp_pasid_required(pdev))
+		return -EINVAL;
+
+	ret = pci_reset_pri(pdev);
+	if (ret)
+		return ret;
+
 	ret = iopf_queue_add_device(iommu->iopf_queue, dev);
 	if (ret)
 		return ret;
 
 	ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
 	if (ret)
-		iopf_queue_remove_device(iommu->iopf_queue, dev);
+		goto iopf_remove_device;
+
+	ret = pci_enable_pri(pdev, PRQ_DEPTH);
+	if (ret)
+		goto iopf_unregister_handler;
+	info->pri_enabled = 1;
+
+	return 0;
+
+iopf_unregister_handler:
+	iommu_unregister_device_fault_handler(dev);
+iopf_remove_device:
+	iopf_queue_remove_device(iommu->iopf_queue, dev);
 
 	return ret;
 }
@@ -4689,17 +4704,21 @@ static int intel_iommu_disable_iopf(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
-	int ret;
 
-	ret = iommu_unregister_device_fault_handler(dev);
-	if (ret)
-		return ret;
+	if (!info->pri_enabled)
+		return -EINVAL;
 
-	ret = iopf_queue_remove_device(iommu->iopf_queue, dev);
-	if (ret)
-		iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
+	pci_disable_pri(to_pci_dev(dev));
+	info->pri_enabled = 0;
 
-	return ret;
+	/*
+	 * With pri_enabled checked, unregistering fault handler and
+	 * removing device from iopf queue should never fail.
+	 */
+	iommu_unregister_device_fault_handler(dev);
+	iopf_queue_remove_device(iommu->iopf_queue, dev);
+
+	return 0;
 }
 
 static int
-- 
2.34.1

