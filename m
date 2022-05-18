Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5828652C224
	for <lists+dmaengine@lfdr.de>; Wed, 18 May 2022 20:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241337AbiERSRi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 May 2022 14:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241316AbiERSRh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 May 2022 14:17:37 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E552617EC38;
        Wed, 18 May 2022 11:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652897856; x=1684433856;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4MoEi9eIAsQEEnYGbn1gdDfBYv7oO8G4INN9f64CdNo=;
  b=amBX8b8TQ9JF5jwFJItSzPmoZ2Mv+DnqXkSb+3iW0dj5NZdyIcKntb8S
   LHoYjBtJaZ0NTvC1SUXabdnr/83nz3VItqfY8C1l2jeD4VWTJ89y5JK+R
   GzknF1eb1ND9bXbu2DfUHbjvEhU0rCBdXc+OQAEJYsFjO7B/NsgMwm2Zl
   e9cuI3f+XUwy2wTGSWDjS4m/3pPFkntpXU6FI8pKJgHdCBXgnJ4FRYmtP
   OVZpk8YKQuV7x2wSbbCLXRzzV6Uom6imSfnDilpMuxvPmJA4Vae1iHQBP
   AjvQaI7NmgDZ6p+ok8ll44myBIcqbbVk0Q9NAEpiWlJp+dpUpv/dtB8XB
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="270648746"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="270648746"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 11:17:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="639405510"
Received: from otc-wp-03.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.79])
  by fmsmga004.fm.intel.com with ESMTP; 18 May 2022 11:17:33 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Christoph Hellwig" <hch@infradead.org>, vkoul@kernel.org,
        robin.murphy@arm.com, will@kernel.org
Cc:     Yi Liu <yi.l.liu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 6/6] iommu/vt-d: Delete unused SVM flag
Date:   Wed, 18 May 2022 11:21:20 -0700
Message-Id: <20220518182120.1136715-7-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index 44331db060e4..5b220d464218 100644
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

