Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FBE6D30ED
	for <lists+dmaengine@lfdr.de>; Sat,  1 Apr 2023 15:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjDANQs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 1 Apr 2023 09:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDANQs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 1 Apr 2023 09:16:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EE91C1C6;
        Sat,  1 Apr 2023 06:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680355006; x=1711891006;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N3safgfWsh2c+eTF9vyVgbtj21H3J9PwdTuH4RYy+tg=;
  b=V9YEpEc+fwhTVz9Y9J2w1ecvuN8VdfAkuk3B6izgh+Bjfzwh7ZnUTHL1
   EG8l+KNyPQE/M0dR6VxM9BcoJKtko8N7QP3za/lOhJOcnv3ogrYF7HlVp
   /HG75ZwRBB/cdJGBhzb+ViTcixrq/f0zvPIS+l0KAcmF93RLKwVIqpPZA
   jq1BwUapjmUHHW69HtfyNwRUbLS6WdOciYGPeOY4JM4URY0AylxZc1yfD
   9mZMaTayyilyD72e15Pbgh1Mg8ZhZeLwI7AZOwjy68nXkLj725/CloNVk
   rYezgKti8auQxYJGnlbrLucxW9B4/lxpGk+7Hfn8/hjaPXZSBwQ/WbnbM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="343335742"
X-IronPort-AV: E=Sophos;i="5.98,310,1673942400"; 
   d="scan'208";a="343335742"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 06:16:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="685421926"
X-IronPort-AV: E=Sophos;i="5.98,310,1673942400"; 
   d="scan'208";a="685421926"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.211.241]) ([10.254.211.241])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 06:16:41 -0700
Message-ID: <d20a04fc-e0a8-32ee-0d4a-083338d4179b@linux.intel.com>
Date:   Sat, 1 Apr 2023 21:16:39 +0800
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
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org
References: <20230331231137.1947675-1-jacob.jun.pan@linux.intel.com>
 <20230331231137.1947675-4-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230331231137.1947675-4-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2023/4/1 7:11, Jacob Pan wrote:
> Devices that use Intel ENQCMD to submit work must use global PASIDs in
> that the PASID are stored in a per CPU MSR. When such device need to
> submit work for in-kernel DMA with PASID, it must allocate PASIDs from
> the same global number space to avoid conflict.
> 
> This patch moves global PASID allocation APIs from SVA to IOMMU APIs.
> It is expected that device drivers will use the allocated PASIDs to attach
> to appropriate IOMMU domains for use.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/iommu-sva.c | 10 ++++------
>   drivers/iommu/iommu.c     | 33 +++++++++++++++++++++++++++++++++
>   include/linux/iommu.h     | 10 ++++++++++
>   3 files changed, 47 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index c434b95dc8eb..222544587582 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -9,15 +9,13 @@
>   #include "iommu-sva.h"
>   
>   static DEFINE_MUTEX(iommu_sva_lock);
> -static DEFINE_IDA(iommu_global_pasid_ida);
>   
>   /* Allocate a PASID for the mm within range (inclusive) */
>   static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
>   {
>   	int ret = 0;
>   
> -	if (!pasid_valid(min) || !pasid_valid(max) ||
> -	    min == 0 || max < min)
> +	if (!pasid_valid(min) || !pasid_valid(max) || max < min)
>   		return -EINVAL;
>   
>   	mutex_lock(&iommu_sva_lock);
> @@ -28,8 +26,8 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t ma
>   		goto out;
>   	}
>   
> -	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max, GFP_KERNEL);
> -	if (ret < min)
> +	ret = iommu_alloc_global_pasid(min, max);
> +	if (!pasid_valid(ret))
>   		goto out;
>   	mm->pasid = ret;
>   	ret = 0;
> @@ -211,5 +209,5 @@ void mm_pasid_drop(struct mm_struct *mm)
>   	if (likely(!pasid_valid(mm->pasid)))
>   		return;
>   
> -	ida_free(&iommu_global_pasid_ida, mm->pasid);
> +	iommu_free_global_pasid(mm->pasid);
>   }
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 10db680acaed..5a8ffdc3063d 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -38,6 +38,7 @@
>   
>   static struct kset *iommu_group_kset;
>   static DEFINE_IDA(iommu_group_ida);
> +static DEFINE_IDA(iommu_global_pasid_ida);
>   
>   static unsigned int iommu_def_domain_type __read_mostly;
>   static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_DMA_STRICT);
> @@ -3450,3 +3451,35 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
>   
>   	return domain;
>   }
> +
> +/**
> + * @brief
> + *	Reserve a PASID from the SVA global number space.
> + *
> + * @param min starting range, inclusive
> + * @param max ending range, inclusive
> + * @return The reserved PASID on success or IOMMU_PASID_INVALID on failure.
> + */

Nit: the comments here also need to be changed accordingly.

Best regards,
baolu

> +ioasid_t iommu_alloc_global_pasid(ioasid_t min, ioasid_t max)
> +{
> +	int ret;
> +
> +	if (!pasid_valid(min) || !pasid_valid(max) || max < min)
> +		return IOMMU_PASID_INVALID;
> +
> +	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max, GFP_KERNEL);
> +	if (ret < 0)
> +		return IOMMU_PASID_INVALID;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_alloc_global_pasid);
> +
> +void iommu_free_global_pasid(ioasid_t pasid)
> +{
> +	if (WARN_ON(!pasid_valid(pasid)))
> +		return;
> +
> +	ida_free(&iommu_global_pasid_ida, pasid);
> +}
> +EXPORT_SYMBOL_GPL(iommu_free_global_pasid);
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

