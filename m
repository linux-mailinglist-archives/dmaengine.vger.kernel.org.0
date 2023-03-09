Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3E76B19B1
	for <lists+dmaengine@lfdr.de>; Thu,  9 Mar 2023 03:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjCIC5x (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Mar 2023 21:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjCIC5w (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 Mar 2023 21:57:52 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F6393E28;
        Wed,  8 Mar 2023 18:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678330671; x=1709866671;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QiXay9B0/cIAt+xudzeSslyrWr7mHV5btFCAUOhzZSY=;
  b=PPxFmRDvHxBKoeUka0ZcsPRp+1bMbvOVNvUTRF6sCG8RvEAhHeQUsCx8
   5gj2oscSkqY1mp6WQ5fGDHjN/UITF4VOIoQbtKW8gZCHDFz3mHblYoc1I
   WRxz4zjxF94NDjh3eYoxtwmLKR3eU74F6L+HQI78WKe4CJ9AbWGxtw0fA
   TNPIZe87cQyLpPU2rhpCnDQwmxj3G6i4zk1Bdo1ASdVrbnqlW85WFZG55
   H3od8BtlvQoTt3AE6uJncYgSYBHn1oOgeZcBgk/yLVMtPTzTo57azl93G
   RHPbCAn2qAM1VovoZ+qqushtjm/FcRrXBCz4vcxrnk1DR4ntpNNiS//uU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="316732654"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="316732654"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 18:57:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="746144621"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="746144621"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga004.fm.intel.com with ESMTP; 08 Mar 2023 18:57:48 -0800
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
Subject: [PATCH v2 2/5] iommu/vt-d: Allow SVA with device-specific IOPF
Date:   Thu,  9 Mar 2023 10:56:36 +0800
Message-Id: <20230309025639.26109-3-baolu.lu@linux.intel.com>
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

Currently enabling SVA requires IOPF support from the IOMMU and device
PCI PRI. However, some devices can handle IOPF by itself without ever
sending PCI page requests nor advertising PRI capability.

Allow SVA support with IOPF handled either by IOMMU (PCI PRI) or device
driver (device-specific IOPF). As long as IOPF could be handled, SVA
should continue to work.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7c2f4bd33582..d2fcab9d8f61 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4650,7 +4650,18 @@ static int intel_iommu_enable_sva(struct device *dev)
 	if (!(iommu->flags & VTD_FLAG_SVM_CAPABLE))
 		return -ENODEV;
 
-	if (!info->pasid_enabled || !info->pri_enabled || !info->ats_enabled)
+	if (!info->pasid_enabled)
+		return -EINVAL;
+
+	/*
+	 * Devices having device-specific I/O fault handling should not
+	 * support PCI/PRI.
+	 */
+	if (!info->pri_supported)
+		return 0;
+
+	/* Devices supporting ATS/PRI should have it enabled. */
+	if (!info->pri_enabled || !info->ats_enabled)
 		return -EINVAL;
 
 	ret = iopf_queue_add_device(iommu->iopf_queue, dev);
-- 
2.34.1

