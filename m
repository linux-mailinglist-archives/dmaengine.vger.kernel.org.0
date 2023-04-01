Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5851D6D311C
	for <lists+dmaengine@lfdr.de>; Sat,  1 Apr 2023 15:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjDANnW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 1 Apr 2023 09:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDANnV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 1 Apr 2023 09:43:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5412191E8;
        Sat,  1 Apr 2023 06:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680356600; x=1711892600;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MFKyQgWRfmOJKme2+efm2K6/Azaun05Iy1yrj8qyo5E=;
  b=bgUfNM/scLvL0pE4KgW4wq4MOIlziaPfz0oKD66yrOLBxwPQ9qSgfX1Y
   EdZCMam7Rd6bF1WiWUbxU+vzvrun8HyoVQ3aiyoo6niQwxb3aDWfNjr1O
   Dq7riiG/ehJhLjtNHsetsrsSqC8N6Ujgd66U41Fab7hiTxl9pf14VR1sY
   BM97orfUCDumFEpFeoUEkAsJQw0NWBi7/7J4HFKO0eHYkImmJzF/ckuSc
   nAFQJCHjuFq3kALF5Goe4lX7wGAAOEFtagFN+AH3bPPag+kNvxHSDHJam
   LyRjPwvVOSoXz3CMEF3CATXI6gVhbAKsYJqWpOXU6rlwutFYI3ddEfG/T
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="341673178"
X-IronPort-AV: E=Sophos;i="5.98,310,1673942400"; 
   d="scan'208";a="341673178"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 06:43:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="749978248"
X-IronPort-AV: E=Sophos;i="5.98,310,1673942400"; 
   d="scan'208";a="749978248"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.211.241]) ([10.254.211.241])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 06:43:15 -0700
Message-ID: <13bf4050-7563-798a-1776-dd6c948bc1f8@linux.intel.com>
Date:   Sat, 1 Apr 2023 21:43:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Cc:     baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH v3 4/7] iommu/vt-d: Reserve RID_PASID from global PASID
 space
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org
References: <20230331231137.1947675-1-jacob.jun.pan@linux.intel.com>
 <20230331231137.1947675-5-jacob.jun.pan@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230331231137.1947675-5-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2023/4/1 7:11, Jacob Pan wrote:
> On VT-d platforms, RID_PASID is used for DMA request without PASID. We
> should not treat RID_PASID special instead let it be allocated from the
> global PASID number space. Non-zero value can be used in RID_PASID on
> Intel VT-d.
> 
> For ARM, AMD and others that _always_ use 0 as RID_PASID, there is no
> impact in that SVA PASID allocation base is 1.
> 
> With this change, devices do both DMA with PASID and SVA will not worry
> about conflicts when it comes to allocating PASIDs for in-kernel DMA.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 9f737ef55463..cbb2670f88ca 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3956,6 +3956,10 @@ int __init intel_iommu_init(void)
>   
>   	intel_iommu_enabled = 1;
>   
> +	/* Reserved RID_PASID from the global namespace for legacy DMA */
> +	WARN_ON(iommu_alloc_global_pasid(PASID_RID2PASID, PASID_RID2PASID) !=
> +		PASID_RID2PASID);

This looks odd. With the previous patch unchanged,
iommu_alloc_global_pasid() will always return IOMMU_PASID_INVALID if
CONFIG_IOMMU_SVA is not set.

> +
>   	return 0;
>   
>   out_free_dmar:

Best regards,
baolu
