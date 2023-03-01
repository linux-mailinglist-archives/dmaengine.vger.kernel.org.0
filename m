Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4456A780E
	for <lists+dmaengine@lfdr.de>; Thu,  2 Mar 2023 00:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjCAXxw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Mar 2023 18:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjCAXxv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Mar 2023 18:53:51 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB421EBDC;
        Wed,  1 Mar 2023 15:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677714830; x=1709250830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hrZzp23shenWc1CmMYjfPNpWaBvm/38EYThzSGpMAe0=;
  b=jksDsE+tx6hCGnrSSzES9yjO5/aGRMoqe6udLcc7YCjxFylJLQctI/+I
   dL/ZTNYTfci95vQ61zSf4UuF9N0uZp0kyv2ZGjEU9ZAZRIVCdzjOyhpcH
   eF7iBPNr1ACxBwlzThecykmBbycrVRVr3/VwaqUAhrta7MXWBv3VNRP9S
   Gdm5Zcx8rHZn8VGVu5kyKrCG6pNHuOXuKQAa+0K14ONt6wvP5ySWafTH6
   +uo2SgAZqZMfTrj2GiIjFWyybJuSEabQz7+NiEcaQ02NQ7EVWEp/bUBov
   ADRfkui3cgSwDxg/1mqPJHakxRSBBbTgaL/GrFyXBJa6+zFKncjotLsCD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="397127651"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="397127651"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 15:53:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="1003880330"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="1003880330"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by fmsmga005.fm.intel.com with ESMTP; 01 Mar 2023 15:53:02 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     "Robin Murphy" <robin.murphy@arm.com>,
        "Will Deacon" <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 3/6] iommu/sva: Stop using ioasid_set for SVA
Date:   Wed,  1 Mar 2023 15:56:43 -0800
Message-Id: <20230301235646.2692846-4-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230301235646.2692846-1-jacob.jun.pan@linux.intel.com>
References: <20230301235646.2692846-1-jacob.jun.pan@linux.intel.com>
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

From: Jason Gunthorpe <jgg@nvidia.com>

Instead SVA drivers can use a simple global IDA to allocate PASIDs for
each mm_struct.

Future work would be to allow drivers using the SVA APIs to reserve global
PASIDs from this IDA for their internal use, eg with the DMA API PASID
support.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
v4:
	- Keep GFP_ATOMIC flag for PASID allocation, will changed to
	GFP_KERNEL in a separate patch.
---
 drivers/iommu/iommu-sva.c | 62 ++++++++++-----------------------------
 drivers/iommu/iommu-sva.h |  3 --
 2 files changed, 15 insertions(+), 50 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 376b2a9e2543..297852ae5e7c 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -9,26 +9,13 @@
 #include "iommu-sva.h"
 
 static DEFINE_MUTEX(iommu_sva_lock);
-static DECLARE_IOASID_SET(iommu_sva_pasid);
+static DEFINE_IDA(iommu_global_pasid_ida);
 
-/**
- * iommu_sva_alloc_pasid - Allocate a PASID for the mm
- * @mm: the mm
- * @min: minimum PASID value (inclusive)
- * @max: maximum PASID value (inclusive)
- *
- * Try to allocate a PASID for this mm, or take a reference to the existing one
- * provided it fits within the [@min, @max] range. On success the PASID is
- * available in mm->pasid and will be available for the lifetime of the mm.
- *
- * Returns 0 on success and < 0 on error.
- */
-int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
+static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 {
-	int ret = 0;
-	ioasid_t pasid;
+	int ret;
 
-	if (min == INVALID_IOASID || max == INVALID_IOASID ||
+	if (min == IOMMU_PASID_INVALID || max == IOMMU_PASID_INVALID ||
 	    min == 0 || max < min)
 		return -EINVAL;
 
@@ -37,39 +24,20 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 	if (pasid_valid(mm->pasid)) {
 		if (mm->pasid < min || mm->pasid >= max)
 			ret = -EOVERFLOW;
+		else
+			ret = 0;
 		goto out;
 	}
 
-	pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
-	if (!pasid_valid(pasid))
-		ret = -ENOMEM;
-	else
-		mm->pasid = ret;
+	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max, GFP_ATOMIC);
+	if (ret < min)
+		goto out;
+	mm->pasid = ret;
+	ret = 0;
 out:
 	mutex_unlock(&iommu_sva_lock);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
-
-/* ioasid_find getter() requires a void * argument */
-static bool __mmget_not_zero(void *mm)
-{
-	return mmget_not_zero(mm);
-}
-
-/**
- * iommu_sva_find() - Find mm associated to the given PASID
- * @pasid: Process Address Space ID assigned to the mm
- *
- * On success a reference to the mm is taken, and must be released with mmput().
- *
- * Returns the mm corresponding to this PASID, or an error if not found.
- */
-struct mm_struct *iommu_sva_find(ioasid_t pasid)
-{
-	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
-}
-EXPORT_SYMBOL_GPL(iommu_sva_find);
 
 /**
  * iommu_sva_bind_device() - Bind a process address space to a device
@@ -241,8 +209,8 @@ iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
 
 void mm_pasid_drop(struct mm_struct *mm)
 {
-	if (pasid_valid(mm->pasid)) {
-		ioasid_free(mm->pasid);
-		mm->pasid = INVALID_IOASID;
-	}
+	if (likely(!pasid_valid(mm->pasid)))
+		return;
+
+	ida_free(&iommu_global_pasid_ida, mm->pasid);
 }
diff --git a/drivers/iommu/iommu-sva.h b/drivers/iommu/iommu-sva.h
index 7215a761b962..c22d0174ad61 100644
--- a/drivers/iommu/iommu-sva.h
+++ b/drivers/iommu/iommu-sva.h
@@ -8,9 +8,6 @@
 #include <linux/ioasid.h>
 #include <linux/mm_types.h>
 
-int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max);
-struct mm_struct *iommu_sva_find(ioasid_t pasid);
-
 /* I/O Page fault */
 struct device;
 struct iommu_fault;
-- 
2.25.1

