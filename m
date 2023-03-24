Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2626C7DA7
	for <lists+dmaengine@lfdr.de>; Fri, 24 Mar 2023 13:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjCXMC4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Mar 2023 08:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjCXMCr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 24 Mar 2023 08:02:47 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E5C244B6;
        Fri, 24 Mar 2023 05:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679659358; x=1711195358;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nDsWWHt3XXkQGYiQaHFSNmSDapZTcbGSD8doZIV3ewQ=;
  b=U8cC2O/xvTnOy8Be1KmMz5zPdVy3edAdm5TraWFz42koY+b4X5NaoFyu
   Q+oglOYYjPAO/2RgSL6dsiU4ysLshElpyuMysMEGa26dOjRVVBtgcID93
   6iXtZS/Q/3L/dF3OdsLrdm86nRpgTF+/OIXt5tDxBHwFNDmyU+LA3drVf
   YNAYD1cHvsedMA4aONdRnT1YSsT6gDGuwlmYWS6ltKx19LArX870HaxgA
   F1l+ZM7/Xsmaaxw9sY0xb25dod3yxZa6i0zlkSP0N82+/ZbdoDCA/eZIk
   UnSNFv0C4Ts6rxZ258nyPYt7iBFkHLICX6lyOzop9fqFMah/3oR3/b0EP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="323634179"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="323634179"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 05:02:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="682674883"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="682674883"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga002.jf.intel.com with ESMTP; 24 Mar 2023 05:02:35 -0700
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
Subject: [PATCH v3 5/6] iommu/vt-d: Move PRI handling to IOPF feature path
Date:   Fri, 24 Mar 2023 20:02:33 +0800
Message-Id: <20230324120234.313643-6-baolu.lu@linux.intel.com>
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

PRI is only used for IOPF. With this move, the PCI/PRI feature could be
controlled by the device driver through iommu_dev_enable/disable_feature()
interfaces.

Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 53 ++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6d77b4072fdd..cd3a3c4b5e64 100644
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
@@ -4667,23 +4657,48 @@ static int intel_iommu_enable_sva(struct device *dev)
 
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
@@ -4694,6 +4709,20 @@ static int intel_iommu_disable_iopf(struct device *dev)
 	struct intel_iommu *iommu = info->iommu;
 	int ret;
 
+	if (!info->pri_enabled)
+		return -EINVAL;
+
+	/*
+	 * PCIe spec states that by clearing PRI enable bit, the Page
+	 * Request Interface will not issue new page requests, but has
+	 * outstanding page requests that have been transmitted or are
+	 * queued for transmission. This is supposed to be called after
+	 * the device driver has stopped DMA, all PASIDs have been
+	 * unbound and the outstanding PRQs have been drained.
+	 */
+	pci_disable_pri(to_pci_dev(dev));
+	info->pri_enabled = 0;
+
 	ret = iommu_unregister_device_fault_handler(dev);
 	if (ret)
 		return ret;
-- 
2.34.1

