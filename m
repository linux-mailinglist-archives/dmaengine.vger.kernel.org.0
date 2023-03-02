Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8945F6A7887
	for <lists+dmaengine@lfdr.de>; Thu,  2 Mar 2023 01:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjCBA4V (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Mar 2023 19:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBA4U (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Mar 2023 19:56:20 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC6756795;
        Wed,  1 Mar 2023 16:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677718579; x=1709254579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D0qyjUJXtQ22gjOJkGfAodz2FNGnPAkWpKsE9lPkA68=;
  b=AQVN+4DGHAo9OTn5Ten3wzSBwdcRt77FgA7e7uqs87TFQkgkoZoCe5dS
   b3+jE07AEVFK64mVpedOb1pwb6sMjH6IYO21xiP6wqIMmw10AqfDR7qfj
   BCaGyUvrbzF4Gl6vElDxV9DlG6DgKLGqPgCWgKRjS5NefsNNH0HsJA/4Y
   Fv42F0h/TX9YPDRORZmiOCgOQgyc4O9qSYlZkvJIp21idpvqDMZizvOhq
   InjNidBsxgB4lHo3+XMwZA1kbYzsQXB+PCta4sxIPdbjyXCGqty6PVkAs
   pHqJhPegl6rpwDMzmw6V6F5dlh9Ntuep/5uX3cU59FYCBYGOENfW6n4WY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="397141489"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="397141489"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 16:56:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="624708997"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="624708997"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by orsmga003.jf.intel.com with ESMTP; 01 Mar 2023 16:56:12 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org
Cc:     "Robin Murphy" <robin.murphy@arm.com>,
        "Will Deacon" <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 3/4] iommu/sva: Support reservation of global PASIDs
Date:   Wed,  1 Mar 2023 16:59:58 -0800
Message-Id: <20230302005959.2695267-4-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
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

Global PASID allocation is under IOMMU SVA code since it is the primary
use case.  However, some architecture such as VT-d, global PASIDs are
necessary for its internal use of DMA API with PASID.

This patch introduces SVA APIs to reserve and release global PASIDs.

Link: https://lore.kernel.org/all/20230301235646.2692846-4-jacob.jun.pan@linux.intel.com/
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/iommu-sva.c | 25 +++++++++++++++++++++++++
 include/linux/iommu.h     | 14 ++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 8c92a145e15d..cfdeafde88a9 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -149,6 +149,31 @@ u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 }
 EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
 
+ioasid_t iommu_sva_reserve_pasid(ioasid_t min, ioasid_t max)
+{
+	int ret;
+
+	if (min == IOMMU_PASID_INVALID || max == IOMMU_PASID_INVALID ||
+	    min == 0 || max < min)
+		return IOMMU_PASID_INVALID;
+
+	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max, GFP_KERNEL);
+	if (ret < 0)
+		return IOMMU_PASID_INVALID;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_reserve_pasid);
+
+void iommu_sva_unreserve_pasid(ioasid_t pasid)
+{
+	if (!pasid_valid(pasid))
+		return;
+
+	ida_free(&iommu_global_pasid_ida, pasid);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_unreserve_pasid);
+
 /*
  * I/O page fault handler for SVA
  */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 39a97bd8f04a..8ba07eb03d32 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1192,6 +1192,9 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev,
 					struct mm_struct *mm);
 void iommu_sva_unbind_device(struct iommu_sva *handle);
 u32 iommu_sva_get_pasid(struct iommu_sva *handle);
+ioasid_t iommu_sva_reserve_pasid(ioasid_t min, ioasid_t max);
+void iommu_sva_unreserve_pasid(ioasid_t pasid);
+
 #else
 static inline struct iommu_sva *
 iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
@@ -1207,6 +1210,17 @@ static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 {
 	return IOMMU_PASID_INVALID;
 }
+
+static inline ioasid_t iommu_sva_reserve_pasid(ioasid_t min, ioasid_t max);
+{
+	return IOMMU_PASID_INVALID;
+}
+
+static inline void iommu_sva_unreserve_pasid(ioasid_t pasid)
+{
+
+}
+
 #endif /* CONFIG_IOMMU_SVA */
 
 #endif /* __LINUX_IOMMU_H */
-- 
2.25.1

