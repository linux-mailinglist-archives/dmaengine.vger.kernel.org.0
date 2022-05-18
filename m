Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CC352C20A
	for <lists+dmaengine@lfdr.de>; Wed, 18 May 2022 20:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241347AbiERSRj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 May 2022 14:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241336AbiERSRi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 May 2022 14:17:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9645E185402;
        Wed, 18 May 2022 11:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652897857; x=1684433857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VA8nFl9fC9gNGwuMhCr88Na7OguiZVel87k14M/WRzo=;
  b=oHoaDoqR76XSX5UC6/D7a9Tezl75RFKKlf242DUf/RXX4oR3IFVcvaSu
   gCM38X71MzoyglqbYssHQhjL6UhHGqSIxK+NDDGXeBpes+CrpnB38ifQ0
   h6RGiE4u1ccNOzbJyd7HD97kpZpy4OQoLuQduZCRqL6yJ+n+hA/5syTTl
   clAWEECGVlkGXipSKiy559NTaccCtPluB5MPuv3JtjfFbOBaeoO4ZlzBx
   wZ/PMtPb8nXijhvOlrXOGOnhfELFwr4luvqiHdtLfvCZ3bpBmfo/IqoFu
   Wo3TOk3V8eki8ywkBL3beSdLuGn0DFtP+br3EtebhR4UCG2Q79riBrGGd
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="270648738"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="270648738"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 11:17:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="639405494"
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
Subject: [PATCH v4 1/6] iommu: Add a per domain PASID for DMA API
Date:   Wed, 18 May 2022 11:21:15 -0700
Message-Id: <20220518182120.1136715-2-jacob.jun.pan@linux.intel.com>
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

DMA requests tagged with PASID can target individual IOMMU domains.
Introduce a domain-wide PASID for DMA API, it will be used on the same
mapping as legacy DMA without PASID. Let it be IOVA or PA in case of
identity domain.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 include/linux/iommu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 9405034e3013..36ad007084cc 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -106,6 +106,8 @@ struct iommu_domain {
 	enum iommu_page_response_code (*iopf_handler)(struct iommu_fault *fault,
 						      void *data);
 	void *fault_data;
+	ioasid_t dma_pasid;		/* Used for DMA requests with PASID */
+	atomic_t dma_pasid_users;
 };
 
 static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
-- 
2.25.1

