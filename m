Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E746DC257
	for <lists+dmaengine@lfdr.de>; Mon, 10 Apr 2023 03:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjDJBeV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 Apr 2023 21:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDJBeU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 9 Apr 2023 21:34:20 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781FF26B1;
        Sun,  9 Apr 2023 18:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681090459; x=1712626459;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VPEA52FKxbDPXZFsBUBRgLqlLFiawR6T60laqFjEQvw=;
  b=I4D/FO6JdItg8J/yfT1dYdZPWAatpbli6dxRQflfR20/WMnXcLRf9Yg4
   cNZoOoWhcKHCTlqsh8iJBDCrJJiNxtdZglnExiB1KgIgF0jZpDhzLiG0D
   c5RvKFAKXo4Ysq1D+e1bKl1YbGW7KiJwBEEYzhJajLErOh9ydBv7VcZ7g
   jfze3WX6hRge00BCCoUYiLZXmzAb8lRn6t6VtYgFNTdxaJ9uXVqfLVXiy
   6U5NXWuxXWH4JGjXcXyZUm65NGJXAxJZ9R8jGYLLOoaVvR6YsalYRPYJx
   FyIP+H5kbFN3+bmYxOm4HCDWHUkZFl02LRtldTeUQlovyOdSG9fT84CLF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10675"; a="342026849"
X-IronPort-AV: E=Sophos;i="5.98,332,1673942400"; 
   d="scan'208";a="342026849"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2023 18:34:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10675"; a="831775182"
X-IronPort-AV: E=Sophos;i="5.98,332,1673942400"; 
   d="scan'208";a="831775182"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2023 18:34:14 -0700
Message-ID: <ce7de769-ecc2-4f89-d031-7f1279384eb2@linux.intel.com>
Date:   Mon, 10 Apr 2023 09:34:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc:     baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH v4 3/7] iommu: Support allocation of global PASIDs outside
 SVA
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org
References: <20230407180554.2784285-1-jacob.jun.pan@linux.intel.com>
 <20230407180554.2784285-4-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230407180554.2784285-4-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 4/8/23 2:05 AM, Jacob Pan wrote:
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
> v4: move dummy functions outside ifdef CONFIG_IOMMU_SVA (Baolu)
> ---
>   drivers/iommu/iommu-sva.c | 10 ++++------
>   drivers/iommu/iommu.c     | 33 +++++++++++++++++++++++++++++++++
>   include/linux/iommu.h     | 11 +++++++++++
>   3 files changed, 48 insertions(+), 6 deletions(-)
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
> index 10db680acaed..2a132ff7e3de 100644
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
> + *	Allocate a PASID from the global number space.
> + *
> + * @param min starting range, inclusive
> + * @param max ending range, inclusive
> + * @return The reserved PASID on success or IOMMU_PASID_INVALID on failure.
> + */
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
> index 54f535ff9868..c9720ddc81d2 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -723,6 +723,8 @@ void iommu_detach_device_pasid(struct iommu_domain *domain,
>   struct iommu_domain *
>   iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid,
>   			       unsigned int type);
> +ioasid_t iommu_alloc_global_pasid(ioasid_t min, ioasid_t max);
> +void iommu_free_global_pasid(ioasid_t pasid);
>   #else /* CONFIG_IOMMU_API */
>   
>   struct iommu_ops {};
> @@ -1089,6 +1091,13 @@ iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid,
>   {
>   	return NULL;
>   }
> +
> +static inline ioasid_t iommu_alloc_global_pasid(ioasid_t min, ioasid_t max)
> +{
> +	return IOMMU_PASID_INVALID;
> +}
> +
> +static inline void iommu_free_global_pasid(ioasid_t pasid) {}
>   #endif /* CONFIG_IOMMU_API */
>   
>   /**
> @@ -1187,6 +1196,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev,
>   					struct mm_struct *mm);
>   void iommu_sva_unbind_device(struct iommu_sva *handle);
>   u32 iommu_sva_get_pasid(struct iommu_sva *handle);
> +

Nit: irrelevant blank line

>   #else
>   static inline struct iommu_sva *
>   iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
> @@ -1202,6 +1212,7 @@ static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
>   {
>   	return IOMMU_PASID_INVALID;
>   }
> +

Ditto

>   static inline void mm_pasid_init(struct mm_struct *mm) {}
>   static inline void mm_pasid_drop(struct mm_struct *mm) {}
>   #endif /* CONFIG_IOMMU_SVA */

Other look good to me.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
