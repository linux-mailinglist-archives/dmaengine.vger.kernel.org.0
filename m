Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABE36D3107
	for <lists+dmaengine@lfdr.de>; Sat,  1 Apr 2023 15:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjDAN2L (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 1 Apr 2023 09:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDAN2L (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 1 Apr 2023 09:28:11 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEC1191CB;
        Sat,  1 Apr 2023 06:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680355689; x=1711891689;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sSjm2R/ZERWrLvuTMJ4+1cTW3tasqNODXsINXDA4T4w=;
  b=g0Fo7DlRTniNHg3FTEurLfmm/UIxskHVCqetswAG/PSNZv2wKPqYOC1E
   ShXuujwuijqU2oFjYCK2wVUknmhfdK0J51aXerMN2FyZpmWZB6HVKowPL
   E4vUQ+Z0SC/FzNZXtZGeL00SszVybK4AFo1m9CnB241fhrGw+5WZujcT6
   MXwRiC+JDTs0soZhCopvG4tsuXEPjybNZoas0SEF8PhB4THHai1Lqjp4Y
   F8n8CakVjW+cV3Z0ghx24y1gUYGGATrtvyAezK+V2VS8eaV2sfInGDM2T
   yzEoJhT/hSJP9ZG4W8fnjrmFSiVlnzAfBlKquzWCqPok7OJQUOcviPtOL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="321307543"
X-IronPort-AV: E=Sophos;i="5.98,310,1673942400"; 
   d="scan'208";a="321307543"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 06:28:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="774661731"
X-IronPort-AV: E=Sophos;i="5.98,310,1673942400"; 
   d="scan'208";a="774661731"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.211.241]) ([10.254.211.241])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 06:28:04 -0700
Message-ID: <81fddd3e-bf6c-966a-b44b-b8a7c9c00591@linux.intel.com>
Date:   Sat, 1 Apr 2023 21:28:02 +0800
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
Subject: Re: [PATCH v3 3/7] iommu/sva: Support allocation of global PASIDs
 outside SVA
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org
References: <20230331231137.1947675-1-jacob.jun.pan@linux.intel.com>
 <20230331231137.1947675-4-jacob.jun.pan@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230331231137.1947675-4-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2023/4/1 7:11, Jacob Pan wrote:
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 54f535ff9868..f70478a11a5f 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1187,6 +1187,9 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev,
>   					struct mm_struct *mm);
>   void iommu_sva_unbind_device(struct iommu_sva *handle);
>   u32 iommu_sva_get_pasid(struct iommu_sva *handle);
> +ioasid_t iommu_alloc_global_pasid(ioasid_t min, ioasid_t max);
> +void iommu_free_global_pasid(ioasid_t pasid);
> +
>   #else
>   static inline struct iommu_sva *
>   iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
> @@ -1202,6 +1205,13 @@ static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
>   {
>   	return IOMMU_PASID_INVALID;
>   }
> +
> +static inline ioasid_t iommu_alloc_global_pasid(ioasid_t min, ioasid_t max)
> +{
> +	return IOMMU_PASID_INVALID;
> +}
> +
> +static inline void iommu_free_global_pasid(ioasid_t pasid) {}
>   static inline void mm_pasid_init(struct mm_struct *mm) {}
>   static inline void mm_pasid_drop(struct mm_struct *mm) {}
>   #endif /* CONFIG_IOMMU_SVA */

I don't think the function prototypes of
iommu_[alloc|free]_global_pasid() should be impacted by
CONFIG_IOMMU_SVA. Or I may overlooked something?

Best regards,
baolu
