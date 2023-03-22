Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9333B6C573C
	for <lists+dmaengine@lfdr.de>; Wed, 22 Mar 2023 21:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjCVUPl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Mar 2023 16:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbjCVUOz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Mar 2023 16:14:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962D785B3B;
        Wed, 22 Mar 2023 13:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679515552; x=1711051552;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ma+CNKIi+BORvLSTM0qZN8P9HSZ9s2sfacruAV1YmcA=;
  b=lsqU8bE7+tdfwdqVadYt967jrVFlFJowbFWdbElmTkG13o/tAyqMSnpQ
   IFnxFTs9bFlW1hpn8ml19oezaXH15xOhopD48v0aVYiN5DsGQdlEmff80
   2IhMuXfS58sk7u1BhHgv/aqcoX3K/vmHz/mtZGV39MvEgK6RhkDHijDUI
   zgCQkXRLN835uwGgIFhIjoOp7cgwVIGCEFYkmAEqYSjdBRcNyBmcOcLEN
   JFydPRzXJj3HeOvKBaGymngjf2gfeWZ41ahpXpQ/CFG6PLliGk6H9uIAY
   UsgZHf7PN6D/YmMW1eC8lmbyAxWAaF6rkB9kgy6CuTW+jPW0OycrXUeiv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="339356847"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="339356847"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 13:04:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="682039338"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="682039338"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by orsmga002.jf.intel.com with ESMTP; 22 Mar 2023 13:04:05 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     "Will Deacon" <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v8 4/7] iommu/sva: Stop using ioasid_set for SVA
Date:   Wed, 22 Mar 2023 13:08:00 -0700
Message-Id: <20230322200803.869130-5-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230322200803.869130-1-jacob.jun.pan@linux.intel.com>
References: <20230322200803.869130-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
v5:
	- Put removing iommu_sva_find() to a separate patch (Kevin)
	- Make pasid allocation range to be inclusive (Tina)
	- Simplified return code handling (Baolu)
v4:
	- Keep GFP_ATOMIC flag for PASID allocation, will changed to
	GFP_KERNEL in a separate patch.
---
 drivers/iommu/iommu-sva.c | 41 +++++++++++++--------------------------
 drivers/iommu/iommu-sva.h |  2 --
 2 files changed, 14 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 4f357ef14f04..48e8a15ddc9b 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -9,47 +9,34 @@
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
+/* Allocate a PASID for the mm within range (inclusive) */
+static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 {
 	int ret = 0;
-	ioasid_t pasid;
 
-	if (min == INVALID_IOASID || max == INVALID_IOASID ||
+	if (!pasid_valid(min) || !pasid_valid(max) ||
 	    min == 0 || max < min)
 		return -EINVAL;
 
 	mutex_lock(&iommu_sva_lock);
 	/* Is a PASID already associated with this mm? */
 	if (pasid_valid(mm->pasid)) {
-		if (mm->pasid < min || mm->pasid >= max)
+		if (mm->pasid < min || mm->pasid > max)
 			ret = -EOVERFLOW;
 		goto out;
 	}
 
-	pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
-	if (!pasid_valid(pasid))
-		ret = -ENOMEM;
-	else
-		mm->pasid = pasid;
+	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max, GFP_ATOMIC);
+	if (ret < 0)
+		goto out;
+	mm->pasid = ret;
+	ret = 0;
 out:
 	mutex_unlock(&iommu_sva_lock);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
 
 /**
  * iommu_sva_bind_device() - Bind a process address space to a device
@@ -221,8 +208,8 @@ iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
 
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
index 102eae1817a2..c22d0174ad61 100644
--- a/drivers/iommu/iommu-sva.h
+++ b/drivers/iommu/iommu-sva.h
@@ -8,8 +8,6 @@
 #include <linux/ioasid.h>
 #include <linux/mm_types.h>
 
-int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max);
-
 /* I/O Page fault */
 struct device;
 struct iommu_fault;
-- 
2.25.1

