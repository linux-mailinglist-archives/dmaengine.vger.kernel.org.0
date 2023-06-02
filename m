Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BDC7208EC
	for <lists+dmaengine@lfdr.de>; Fri,  2 Jun 2023 20:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbjFBSRq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Jun 2023 14:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236650AbjFBSRp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Jun 2023 14:17:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B248C196;
        Fri,  2 Jun 2023 11:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685729863; x=1717265863;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mm0RBRlxNTWUVWGSjZmJqXmc9M/wdroaapVIA3ESeqk=;
  b=D4kq+b1VRziy0PKQ04jgIDM2PuZ+qDqnw3jKCl6yKcwLXynHw8rkyUTj
   bKzWoPAu7z6NIP1SUnp/b3y45ggwAKwEOrrTbYcEm1MfVUkDb2TkFOFzq
   M72mlTClM83srvsSQ7musGEdySgU/h65zUXpnPDK53IoTolfT5St7V/5e
   /Mfs9cymgWk6I8UiBUyQ1cMbZP8wfTG5e9xM2YJbKij/z/5lnYl66J0ks
   yV72wlzmUoifFfR67b70sD4dMYupPSkeNqj/LnlAYQEEAKOPiH7WIwatM
   mDpMbej2zVSjxIZ3wTvCyFS2DKe9IsED++CHTaeA5apYuJFIL1SD69mDo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="442310244"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="442310244"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 11:17:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="832060968"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="832060968"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.97.184])
  by orsmga004.jf.intel.com with ESMTP; 02 Jun 2023 11:17:38 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        dmaengine@vger.kernel.org, vkoul@kernel.org
Cc:     "Will Deacon" <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>, rex.zhang@intel.com,
        xiaochen.shen@intel.com, narayan.ranganathan@intel.com,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v8 4/7] iommu/vt-d: Remove pasid_mutex
Date:   Fri,  2 Jun 2023 11:22:09 -0700
Message-Id: <20230602182212.150825-5-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230602182212.150825-1-jacob.jun.pan@linux.intel.com>
References: <20230602182212.150825-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Lu Baolu <baolu.lu@linux.intel.com>

The pasid_mutex was used to protect the paths of set/remove_dev_pasid().
It's duplicate with iommu_sva_lock. Remove it to avoid duplicate code.

Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 45 +++++----------------------------------
 1 file changed, 5 insertions(+), 40 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index e95b339e9cdc..2a82864e9d57 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -259,8 +259,6 @@ static const struct mmu_notifier_ops intel_mmuops = {
 	.invalidate_range = intel_invalidate_range,
 };
 
-static DEFINE_MUTEX(pasid_mutex);
-
 static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
 			     struct intel_svm **rsvm,
 			     struct intel_svm_dev **rsdev)
@@ -268,10 +266,6 @@ static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
 	struct intel_svm_dev *sdev = NULL;
 	struct intel_svm *svm;
 
-	/* The caller should hold the pasid_mutex lock */
-	if (WARN_ON(!mutex_is_locked(&pasid_mutex)))
-		return -EINVAL;
-
 	if (pasid == IOMMU_PASID_INVALID || pasid >= PASID_MAX)
 		return -EINVAL;
 
@@ -371,22 +365,19 @@ static int intel_svm_bind_mm(struct intel_iommu *iommu, struct device *dev,
 	return ret;
 }
 
-/* Caller must hold pasid_mutex */
-static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
+void intel_svm_remove_dev_pasid(struct device *dev, u32 pasid)
 {
 	struct intel_svm_dev *sdev;
 	struct intel_iommu *iommu;
 	struct intel_svm *svm;
 	struct mm_struct *mm;
-	int ret = -EINVAL;
 
 	iommu = device_to_iommu(dev, NULL, NULL);
 	if (!iommu)
-		goto out;
+		return;
 
-	ret = pasid_to_svm_sdev(dev, pasid, &svm, &sdev);
-	if (ret)
-		goto out;
+	if (pasid_to_svm_sdev(dev, pasid, &svm, &sdev))
+		return;
 	mm = svm->mm;
 
 	if (sdev) {
@@ -418,8 +409,6 @@ static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
 			kfree(svm);
 		}
 	}
-out:
-	return ret;
 }
 
 /* Page request queue descriptor */
@@ -520,19 +509,7 @@ static void intel_svm_drain_prq(struct device *dev, u32 pasid)
 		goto prq_retry;
 	}
 
-	/*
-	 * A work in IO page fault workqueue may try to lock pasid_mutex now.
-	 * Holding pasid_mutex while waiting in iopf_queue_flush_dev() for
-	 * all works in the workqueue to finish may cause deadlock.
-	 *
-	 * It's unnecessary to hold pasid_mutex in iopf_queue_flush_dev().
-	 * Unlock it to allow the works to be handled while waiting for
-	 * them to finish.
-	 */
-	lockdep_assert_held(&pasid_mutex);
-	mutex_unlock(&pasid_mutex);
 	iopf_queue_flush_dev(dev);
-	mutex_lock(&pasid_mutex);
 
 	/*
 	 * Perform steps described in VT-d spec CH7.10 to drain page
@@ -827,26 +804,14 @@ int intel_svm_page_response(struct device *dev,
 	return ret;
 }
 
-void intel_svm_remove_dev_pasid(struct device *dev, ioasid_t pasid)
-{
-	mutex_lock(&pasid_mutex);
-	intel_svm_unbind_mm(dev, pasid);
-	mutex_unlock(&pasid_mutex);
-}
-
 static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 				   struct device *dev, ioasid_t pasid)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
 	struct mm_struct *mm = domain->mm;
-	int ret;
 
-	mutex_lock(&pasid_mutex);
-	ret = intel_svm_bind_mm(iommu, dev, mm);
-	mutex_unlock(&pasid_mutex);
-
-	return ret;
+	return intel_svm_bind_mm(iommu, dev, mm);
 }
 
 static void intel_svm_domain_free(struct iommu_domain *domain)
-- 
2.25.1

