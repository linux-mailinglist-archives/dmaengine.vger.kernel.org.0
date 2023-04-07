Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21456DB255
	for <lists+dmaengine@lfdr.de>; Fri,  7 Apr 2023 20:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjDGSB4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Apr 2023 14:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbjDGSBz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Apr 2023 14:01:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FCCB451;
        Fri,  7 Apr 2023 11:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680890513; x=1712426513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V3GEorKv47qptI/FPYdE9VJz/E7KChATznXusYLtsLA=;
  b=fQzylXXZ9FbdJD02rnPxy7jacVJR3HuqEp+1DAMj/e6k/2k1BzyBLMEh
   6BeICKmDumFaou8ay6PaO2S7mGML4zNgOzO6mWqbXcJNXdQNwdDA+3ot6
   02I23vIWyvUETg1LkKfZTnnhg2ICO+vM+PZk+WEpabU/lm8Jvtvqiub8s
   rwjLScU1G7ilppUkdFNp8k5UJnAloETtZ2FcrRfycCjCP3rpaHlqoIwyL
   uGqjG45a5Fj/8MKH2W4R1VQfmuDUQi83PZHZYy1uS3sBfGIKhEYmI8stk
   mfIaLPwuKPwIVEyseZCdsP7M9qNeNIeIOVTytz8gdA7cTuz46fJyRhkt+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="343046480"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="343046480"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 11:01:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="776910053"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="776910053"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Apr 2023 11:01:50 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org
Cc:     "Will Deacon" <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 3/7] iommu: Support allocation of global PASIDs outside SVA
Date:   Fri,  7 Apr 2023 11:05:50 -0700
Message-Id: <20230407180554.2784285-4-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230407180554.2784285-1-jacob.jun.pan@linux.intel.com>
References: <20230407180554.2784285-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Devices that use Intel ENQCMD to submit work must use global PASIDs in
that the PASID are stored in a per CPU MSR. When such device need to
submit work for in-kernel DMA with PASID, it must allocate PASIDs from
the same global number space to avoid conflict.

This patch moves global PASID allocation APIs from SVA to IOMMU APIs.
It is expected that device drivers will use the allocated PASIDs to attach
to appropriate IOMMU domains for use.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
v4: move dummy functions outside ifdef CONFIG_IOMMU_SVA (Baolu)
---
 drivers/iommu/iommu-sva.c | 10 ++++------
 drivers/iommu/iommu.c     | 33 +++++++++++++++++++++++++++++++++
 include/linux/iommu.h     | 11 +++++++++++
 3 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index c434b95dc8eb..222544587582 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -9,15 +9,13 @@
 #include "iommu-sva.h"
 
 static DEFINE_MUTEX(iommu_sva_lock);
-static DEFINE_IDA(iommu_global_pasid_ida);
 
 /* Allocate a PASID for the mm within range (inclusive) */
 static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 {
 	int ret = 0;
 
-	if (!pasid_valid(min) || !pasid_valid(max) ||
-	    min == 0 || max < min)
+	if (!pasid_valid(min) || !pasid_valid(max) || max < min)
 		return -EINVAL;
 
 	mutex_lock(&iommu_sva_lock);
@@ -28,8 +26,8 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t ma
 		goto out;
 	}
 
-	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max, GFP_KERNEL);
-	if (ret < min)
+	ret = iommu_alloc_global_pasid(min, max);
+	if (!pasid_valid(ret))
 		goto out;
 	mm->pasid = ret;
 	ret = 0;
@@ -211,5 +209,5 @@ void mm_pasid_drop(struct mm_struct *mm)
 	if (likely(!pasid_valid(mm->pasid)))
 		return;
 
-	ida_free(&iommu_global_pasid_ida, mm->pasid);
+	iommu_free_global_pasid(mm->pasid);
 }
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 10db680acaed..2a132ff7e3de 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -38,6 +38,7 @@
 
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
+static DEFINE_IDA(iommu_global_pasid_ida);
 
 static unsigned int iommu_def_domain_type __read_mostly;
 static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_DMA_STRICT);
@@ -3450,3 +3451,35 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 
 	return domain;
 }
+
+/**
+ * @brief
+ *	Allocate a PASID from the global number space.
+ *
+ * @param min starting range, inclusive
+ * @param max ending range, inclusive
+ * @return The reserved PASID on success or IOMMU_PASID_INVALID on failure.
+ */
+ioasid_t iommu_alloc_global_pasid(ioasid_t min, ioasid_t max)
+{
+	int ret;
+
+	if (!pasid_valid(min) || !pasid_valid(max) || max < min)
+		return IOMMU_PASID_INVALID;
+
+	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max, GFP_KERNEL);
+	if (ret < 0)
+		return IOMMU_PASID_INVALID;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_alloc_global_pasid);
+
+void iommu_free_global_pasid(ioasid_t pasid)
+{
+	if (WARN_ON(!pasid_valid(pasid)))
+		return;
+
+	ida_free(&iommu_global_pasid_ida, pasid);
+}
+EXPORT_SYMBOL_GPL(iommu_free_global_pasid);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 54f535ff9868..c9720ddc81d2 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -723,6 +723,8 @@ void iommu_detach_device_pasid(struct iommu_domain *domain,
 struct iommu_domain *
 iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid,
 			       unsigned int type);
+ioasid_t iommu_alloc_global_pasid(ioasid_t min, ioasid_t max);
+void iommu_free_global_pasid(ioasid_t pasid);
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -1089,6 +1091,13 @@ iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid,
 {
 	return NULL;
 }
+
+static inline ioasid_t iommu_alloc_global_pasid(ioasid_t min, ioasid_t max)
+{
+	return IOMMU_PASID_INVALID;
+}
+
+static inline void iommu_free_global_pasid(ioasid_t pasid) {}
 #endif /* CONFIG_IOMMU_API */
 
 /**
@@ -1187,6 +1196,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev,
 					struct mm_struct *mm);
 void iommu_sva_unbind_device(struct iommu_sva *handle);
 u32 iommu_sva_get_pasid(struct iommu_sva *handle);
+
 #else
 static inline struct iommu_sva *
 iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
@@ -1202,6 +1212,7 @@ static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 {
 	return IOMMU_PASID_INVALID;
 }
+
 static inline void mm_pasid_init(struct mm_struct *mm) {}
 static inline void mm_pasid_drop(struct mm_struct *mm) {}
 #endif /* CONFIG_IOMMU_SVA */
-- 
2.25.1

