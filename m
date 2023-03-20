Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572546C20BE
	for <lists+dmaengine@lfdr.de>; Mon, 20 Mar 2023 20:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjCTTEB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Mar 2023 15:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCTTDh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Mar 2023 15:03:37 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE275301A3;
        Mon, 20 Mar 2023 11:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679338556; x=1710874556;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VVMjsQ1HxJ3krLgi1Lg7Cpv+oN6wKxL1Z/KsE9PULTQ=;
  b=Jjif29aMGmuOo2hjn14hW71kpnuVrRyU7b73ShiKYewjWj/AD1KuKaVk
   xVG2nM9h3HBA6wHP/f4Lso/ZCXO0Gtdp/i1zUQWDIXVcmkoVkZIffPv4S
   4lTwPwhqgs4UkzanZ4iTvLIrk7gw3oKEhYMqpBZetAMgCabDasTY1gdiL
   +i79IwgDDx3WKC7D2+5bG90GfI78tU9cOzwFaNwpe4QyDSN3KTBJjvw2C
   dmNAnynSZhErLFoAzMpsKQH0EoeAFv9G+3gRxeji3OBlavk5hF4HJAf7z
   +vda7kguVyz3c8mmMzxx0M3WRfgXPQ9XMANLH363R9SLJL3vGGryADbJI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="366473748"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="366473748"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 11:55:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="927076465"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="927076465"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by fmsmga006.fm.intel.com with ESMTP; 20 Mar 2023 11:55:16 -0700
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
Subject: [PATCH v7 3/7] iommu/sva: Remove PASID to mm lookup function
Date:   Mon, 20 Mar 2023 11:59:06 -0700
Message-Id: <20230320185910.2643260-4-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230320185910.2643260-1-jacob.jun.pan@linux.intel.com>
References: <20230320185910.2643260-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There is no user of iommu_sva_find() function, remove it so that PASID
allocator can be a simple IDA. Device drivers are expected to store
and keep track of their own PASID metadata.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/iommu-sva.c | 20 --------------------
 drivers/iommu/iommu-sva.h |  1 -
 2 files changed, 21 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index fcfdc80a3939..4f357ef14f04 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -51,26 +51,6 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 }
 EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
 
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
-
 /**
  * iommu_sva_bind_device() - Bind a process address space to a device
  * @dev: the device
diff --git a/drivers/iommu/iommu-sva.h b/drivers/iommu/iommu-sva.h
index 7215a761b962..102eae1817a2 100644
--- a/drivers/iommu/iommu-sva.h
+++ b/drivers/iommu/iommu-sva.h
@@ -9,7 +9,6 @@
 #include <linux/mm_types.h>
 
 int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max);
-struct mm_struct *iommu_sva_find(ioasid_t pasid);
 
 /* I/O Page fault */
 struct device;
-- 
2.25.1

