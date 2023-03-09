Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004496B19B4
	for <lists+dmaengine@lfdr.de>; Thu,  9 Mar 2023 03:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjCIC6G (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Mar 2023 21:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjCIC6B (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 Mar 2023 21:58:01 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0407DBDE;
        Wed,  8 Mar 2023 18:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678330677; x=1709866677;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ue30EGl5GVT7NuvhkyMNOql0d+yRmWolurmgmiReO2I=;
  b=g4CZfSAQb1LE6z95oBCs0Js4HWV1KZOsB+JApu2+eowu3QYFDLokPpww
   5m06CdAn0HeDPd+CZr4zszTdItrsH9hDn+aoJWXA0kD8RMWt6GkgCKIeP
   Ok1HyeoejD7Ni0ddtr9wl1gaJ/xlNJUGHqCdbXezCRz3oQhne8bZTQC9h
   o9I0oGZ3uI6mxwScDNEtxysZDDbbN5grKUy8Nbxrdg03ecpjDm/Q2r0zw
   gYaHQqyP69mSzzvPqYOP+mmi43wYInjPMF66cEOVIQ76s5j/yBTNdx05j
   cudPwIo5wo4kFvrqfShOGRa6/bcyJ855uGA1rybTBdDRGsxEf2mqHWaR4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="316732675"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="316732675"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 18:57:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="746144644"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="746144644"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga004.fm.intel.com with ESMTP; 08 Mar 2023 18:57:53 -0800
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
Subject: [PATCH v2 4/5] iommu/vt-d: Move pfsid and ats_qdep calculation to device probe path
Date:   Thu,  9 Mar 2023 10:56:38 +0800
Message-Id: <20230309025639.26109-5-baolu.lu@linux.intel.com>
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

They should be part of the per-device iommu private data initialization.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9ada12bf38dd..fb64ab8358a9 100644
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

