Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF7B522612
	for <lists+dmaengine@lfdr.de>; Tue, 10 May 2022 23:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbiEJVD0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 May 2022 17:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbiEJVDY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 May 2022 17:03:24 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124FB23724D;
        Tue, 10 May 2022 14:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652216604; x=1683752604;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MOu4j9oTaoLByHMcGaRvSM1IqcXLeJucVfuaFmAdiQ0=;
  b=Y3d0qofRyM0eNUyf1DYG7QB27PRtxPoAdpuDEhEd7UXOTM8DTjr1k0Qk
   +9aH+c0rZTzhSWj2WU4IR679R1hdZ31sDwFYYcABG3lq76DlZl5xXb311
   MvxxdllVvL8eEh217OGD8H4SbNk/7e6MRAYLd7HY29I/nA+KDgQR3RLqo
   wMcGcmdSoTcq8BrNJkPQZ7KO9cQ3Z6iS79VJ9N09f9ATT3Fpt0h8uswOf
   YiEH8XilDcZBqglAastTlhk0IjtqN6U4W9Jn4MxUzxRfOwl3IJdK0gnx4
   E7wGGRtXYn4KJMJDwLToa2UGR5ws8x5tEt0qwHwfP7NHtNVCFfAa+1b32
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="332538562"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="332538562"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 14:03:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="553017155"
Received: from otc-wp-03.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.79])
  by orsmga002.jf.intel.com with ESMTP; 10 May 2022 14:03:23 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, vkoul@kernel.org,
        robin.murphy@arm.com, will@kernel.org
Cc:     Yi Liu <yi.l.liu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3 4/4] iommu/vt-d: Delete unused SVM flag
Date:   Tue, 10 May 2022 14:07:04 -0700
Message-Id: <20220510210704.3539577-5-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510210704.3539577-1-jacob.jun.pan@linux.intel.com>
References: <20220510210704.3539577-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Supervisor PASID for SVA/SVM is no longer supported, delete the unused
flag.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/svm.c |  2 +-
 include/linux/intel-svm.h | 13 -------------
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 38c33cde177e..98ec77415770 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -750,7 +750,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			 * to unbind the mm while any page faults are outstanding.
 			 */
 			svm = pasid_private_find(req->pasid);
-			if (IS_ERR_OR_NULL(svm) || (svm->flags & SVM_FLAG_SUPERVISOR_MODE))
+			if (IS_ERR_OR_NULL(svm))
 				goto bad_req;
 		}
 
diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
index b3b125b332aa..6835a665c195 100644
--- a/include/linux/intel-svm.h
+++ b/include/linux/intel-svm.h
@@ -13,17 +13,4 @@
 #define PRQ_RING_MASK	((0x1000 << PRQ_ORDER) - 0x20)
 #define PRQ_DEPTH	((0x1000 << PRQ_ORDER) >> 5)
 
-/*
- * The SVM_FLAG_SUPERVISOR_MODE flag requests a PASID which can be used only
- * for access to kernel addresses. No IOTLB flushes are automatically done
- * for kernel mappings; it is valid only for access to the kernel's static
- * 1:1 mapping of physical memory — not to vmalloc or even module mappings.
- * A future API addition may permit the use of such ranges, by means of an
- * explicit IOTLB flush call (akin to the DMA API's unmap method).
- *
- * It is unlikely that we will ever hook into flush_tlb_kernel_range() to
- * do such IOTLB flushes automatically.
- */
-#define SVM_FLAG_SUPERVISOR_MODE	BIT(0)
-
 #endif /* __INTEL_SVM_H__ */
-- 
2.25.1

