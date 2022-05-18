Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294A952C21D
	for <lists+dmaengine@lfdr.de>; Wed, 18 May 2022 20:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240092AbiERSRk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 May 2022 14:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241342AbiERSRj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 May 2022 14:17:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F194518540F;
        Wed, 18 May 2022 11:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652897857; x=1684433857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hrkDrSmygZqDJVCbXXXzX8LyYOgqsByefLY3F+S5ueg=;
  b=Dj7bRQt53AbPg24s8WeU0Q+f3PGFxX+YOcMwtV7bn0lOT+Su8vQG6uxE
   c2s8BFOaEZ4Tv9vDe/EarbY23fk0+BJoNLxx5Yp/loL7UJFYozkER+50L
   GrJXwc8sE6hhYAoRs/Ewa4ZptU13I8vySM7YwRp7JhYJf36h3/bavgiiD
   QtFF7X61uKRNOHMET/JfA5CMCFn9udtm5ZcYEuhzuAQX1Q74MMYzVh03K
   Ybys/jRWP/gFBe0ZE4CkwQSgxfUpYwnT86VF8cU1qX9ap8WC7qLEBTCnc
   9ftvgwUCikMaf8geby/EW0qi2+LbcXxjjIr0XZPHTdHw68kw1gWvZzKLg
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="270648741"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="270648741"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 11:17:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="639405499"
Received: from otc-wp-03.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.79])
  by fmsmga004.fm.intel.com with ESMTP; 18 May 2022 11:17:31 -0700
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
Subject: [PATCH v4 2/6] iommu: Add a helper to do PASID lookup from domain
Date:   Wed, 18 May 2022 11:21:16 -0700
Message-Id: <20220518182120.1136715-3-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
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

IOMMU group maintains a PASID array which stores the associated IOMMU
domains. This patch introduces a helper function to do domain to PASID
look up. It will be used by TLB flush and device-PASID attach verification.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/iommu.c | 22 ++++++++++++++++++++++
 include/linux/iommu.h |  6 +++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 00d0262a1fe9..22f44833db64 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3199,3 +3199,25 @@ struct iommu_domain *iommu_get_domain_for_iopf(struct device *dev,
 
 	return domain;
 }
+
+ioasid_t iommu_get_pasid_from_domain(struct device *dev, struct iommu_domain *domain)
+{
+	struct iommu_domain *tdomain;
+	struct iommu_group *group;
+	unsigned long index;
+	ioasid_t pasid = INVALID_IOASID;
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return pasid;
+
+	xa_for_each(&group->pasid_array, index, tdomain) {
+		if (domain == tdomain) {
+			pasid = index;
+			break;
+		}
+	}
+	iommu_group_put(group);
+
+	return pasid;
+}
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 36ad007084cc..c0440a4be699 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -694,7 +694,7 @@ void iommu_detach_device_pasid(struct iommu_domain *domain,
 			       struct device *dev, ioasid_t pasid);
 struct iommu_domain *
 iommu_get_domain_for_iopf(struct device *dev, ioasid_t pasid);
-
+ioasid_t iommu_get_pasid_from_domain(struct device *dev, struct iommu_domain *domain);
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -1070,6 +1070,10 @@ iommu_get_domain_for_iopf(struct device *dev, ioasid_t pasid)
 {
 	return NULL;
 }
+static ioasid_t iommu_get_pasid_from_domain(struct device *dev, struct iommu_domain *domain)
+{
+	return INVALID_IOASID;
+}
 #endif /* CONFIG_IOMMU_API */
 
 #ifdef CONFIG_IOMMU_SVA
-- 
2.25.1

