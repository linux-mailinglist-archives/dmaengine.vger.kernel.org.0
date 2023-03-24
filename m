Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184EB6C7DA6
	for <lists+dmaengine@lfdr.de>; Fri, 24 Mar 2023 13:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjCXMCr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Mar 2023 08:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjCXMCm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 24 Mar 2023 08:02:42 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6C7241DA;
        Fri, 24 Mar 2023 05:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679659355; x=1711195355;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J8yNL0xsswqSZQ3dx1kUSPhIC1pxHFcfvF18SpMWQe8=;
  b=iEwNKOgjgV1jHggFkxUNPb36K7099jnco1mNGGWu5Dev1nys4vh3/aGz
   MhoowBbaUW72dKTqhh9D1NqGe5svBoA9MSEh/Ss6N+xLAOsiqTTqmwZ2H
   D3hKajKQ2ztElwm+THeM5m56GVv2ulRIRLM4JEbx7+5xpuUJ5nVG4urah
   6meXjltwSHPxnhb8km19C19x8EAGZBpyP/0Om8C6n/ZzcvKYJZU1ueQ6E
   qFkAsLyWZdRhoI8EEUlXMJ/4ut5yUorAy909ExoUVCVQx4UUkdNv6SbKj
   iB/UEubMwxxXHwxNpCBOJqKXbmo84WbOzaJiO3eWq/0wklIqIQwl2uNKA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="323634165"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="323634165"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 05:02:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="682674824"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="682674824"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga002.jf.intel.com with ESMTP; 24 Mar 2023 05:02:32 -0700
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
Subject: [PATCH v3 4/6] iommu/vt-d: Move pfsid and ats_qdep calculation to device probe path
Date:   Fri, 24 Mar 2023 20:02:32 +0800
Message-Id: <20230324120234.313643-5-baolu.lu@linux.intel.com>
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

They should be part of the per-device iommu private data initialization.

Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a6f07c74da2d..6d77b4072fdd 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1406,20 +1406,6 @@ static void iommu_enable_pci_caps(struct device_domain_info *info)
 		return;
 
 	pdev = to_pci_dev(info->dev);
-	/* For IOMMU that supports device IOTLB throttling (DIT), we assign
-	 * PFSID to the invalidation desc of a VF such that IOMMU HW can gauge
-	 * queue depth at PF level. If DIT is not set, PFSID will be treated as
-	 * reserved, which should be set to 0.
-	 */
-	if (!ecap_dit(info->iommu->ecap))
-		info->pfsid = 0;
-	else {
-		struct pci_dev *pf_pdev;
-
-		/* pdev will be returned if device is not a vf */
-		pf_pdev = pci_physfn(pdev);
-		info->pfsid = pci_dev_id(pf_pdev);
-	}
 
 	/* The PCIe spec, in its wisdom, declares that the behaviour of
 	   the device if you enable PASID support after ATS support is
@@ -1438,7 +1424,6 @@ static void iommu_enable_pci_caps(struct device_domain_info *info)
 	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
 		info->ats_enabled = 1;
 		domain_update_iotlb(info->domain);
-		info->ats_qdep = pci_ats_queue_depth(pdev);
 	}
 }
 
@@ -4521,6 +4506,17 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 		    dmar_ats_supported(pdev, iommu)) {
 			info->ats_supported = 1;
 			info->dtlb_extra_inval = dev_needs_extra_dtlb_flush(pdev);
+
+			/*
+			 * For IOMMU that supports device IOTLB throttling
+			 * (DIT), we assign PFSID to the invalidation desc
+			 * of a VF such that IOMMU HW can gauge queue depth
+			 * at PF level. If DIT is not set, PFSID will be
+			 * treated as reserved, which should be set to 0.
+			 */
+			if (ecap_dit(iommu->ecap))
+				info->pfsid = pci_dev_id(pci_physfn(pdev));
+			info->ats_qdep = pci_ats_queue_depth(pdev);
 		}
 		if (sm_supported(iommu)) {
 			if (pasid_supported(iommu)) {
-- 
2.34.1

