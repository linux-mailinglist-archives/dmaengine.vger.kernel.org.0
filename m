Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B5D6CB235
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 01:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjC0XRo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Mar 2023 19:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0XRl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Mar 2023 19:17:41 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15162681;
        Mon, 27 Mar 2023 16:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679959060; x=1711495060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qgUzvbGBHIHc0aGK2Q/F/EqhcZ8UqxtTsN6J1Ti6Lks=;
  b=X+Apg11EhmatgR6ORNmBFGw9AHnYpgK/dS5AhQ/tRtxHpuer2QpGUj2c
   +tleWJT9yPbYeeMCs1Re5pLd1xmonHxzklExmhr8V0iO96VOlVrI5kMdl
   XcCd7OPHGWT/jZ/SKVVnQt9KNJUA+KX7FjFFp+1hnJolS2aP49Eqx2YRo
   tvYPmawpO9M3cHZp7FlNaWGs/NcC500dnCU4tcXRIiNYpqhVG+8nFdsTf
   2Cx+0JfnKmOVKIAsC3kogL54Y/jtQv0etvrEe0W9XC7f6ZSMR5OcnsBKL
   VQeGl3JyuIeKMKtaDxDaBh1g2CykrH10El3+LJ0jN5wLvktz4K4EFPVN9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="320817319"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="320817319"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 16:17:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="686144729"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="686144729"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by fmsmga007.fm.intel.com with ESMTP; 27 Mar 2023 16:17:38 -0700
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
Subject: [PATCH v2 4/8] iommu/vt-d: Reserve RID_PASID from global SVA PASID space
Date:   Mon, 27 Mar 2023 16:21:34 -0700
Message-Id: <20230327232138.1490712-5-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
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

On VT-d platforms, RID_PASID is used for DMA request without PASID. We
should not treat RID_PASID special instead let it be allocated from the
global SVA PASID number space.

Consequently, for devices also do DMA with PASID, drivers will not worry
about conflicts when it comes to allocating PASIDs for in-kernel DMA.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9f737ef55463..61c06f7ad8f7 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3956,6 +3956,10 @@ int __init intel_iommu_init(void)
 
 	intel_iommu_enabled = 1;
 
+#ifdef CONFIG_INTEL_IOMMU_SVM
+	/* Reserved RID_PASID from the global namespace for legacy DMA */
+	iommu_sva_reserve_pasid(PASID_RID2PASID, PASID_RID2PASID);
+#endif
 	return 0;
 
 out_free_dmar:
-- 
2.25.1

