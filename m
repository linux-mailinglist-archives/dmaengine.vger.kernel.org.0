Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0632F6A8313
	for <lists+dmaengine@lfdr.de>; Thu,  2 Mar 2023 14:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjCBNC1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Mar 2023 08:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjCBNC0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Mar 2023 08:02:26 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF9B3250E;
        Thu,  2 Mar 2023 05:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677762144; x=1709298144;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WkXF8/EcCNkfU640/eEExv8Plxnmv/7/V2TBsmDVado=;
  b=Uh0a4K7mEeXMvg/PeCOo5Tyu4B8hIL+yRYenNwai32v2ci1grdRGxGKq
   kn4XD3xQrri19advEuqe/INRaX1GXfoHTst1TkOhXzINCMhG63121Nf9v
   5JOBCFxemJrAVdToOc04gqsWyuF8oc/XO7gJpvimiEStX2bsAeA1PBxgm
   Z+p0J1H9ps0GHV8KmDR+JVhnJVvWAU1Tw9YfyUIKf28wLVN8YJcQIarIf
   DMUFuK99hHQy8Halo5fVWNLOnx3XX2gTr9VC16I1AswWg2I6SaIuk63fw
   HbN4G2yCQG2D8JZG2mkVRIpRXAAviUKwTWxu/OibqBfOCykK+OaFzZwwj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="318510061"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="318510061"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 05:01:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="624932798"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="624932798"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.214.218]) ([10.254.214.218])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 05:01:44 -0800
Message-ID: <3b7fb4d3-1fe9-a3be-46ad-c271be9f96c7@linux.intel.com>
Date:   Thu, 2 Mar 2023 21:01:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 3/6] iommu/sva: Stop using ioasid_set for SVA
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230301235646.2692846-1-jacob.jun.pan@linux.intel.com>
 <20230301235646.2692846-4-jacob.jun.pan@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230301235646.2692846-4-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2023/3/2 7:56, Jacob Pan wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> Instead SVA drivers can use a simple global IDA to allocate PASIDs for
> each mm_struct.
> 
> Future work would be to allow drivers using the SVA APIs to reserve global
> PASIDs from this IDA for their internal use, eg with the DMA API PASID
> support.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
> v4:
> 	- Keep GFP_ATOMIC flag for PASID allocation, will changed to
> 	GFP_KERNEL in a separate patch.
> ---
>   drivers/iommu/iommu-sva.c | 62 ++++++++++-----------------------------
>   drivers/iommu/iommu-sva.h |  3 --
>   2 files changed, 15 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 376b2a9e2543..297852ae5e7c 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -9,26 +9,13 @@
>   #include "iommu-sva.h"
>   
>   static DEFINE_MUTEX(iommu_sva_lock);
> -static DECLARE_IOASID_SET(iommu_sva_pasid);
> +static DEFINE_IDA(iommu_global_pasid_ida);
>   
> -/**
> - * iommu_sva_alloc_pasid - Allocate a PASID for the mm
> - * @mm: the mm
> - * @min: minimum PASID value (inclusive)
> - * @max: maximum PASID value (inclusive)
> - *
> - * Try to allocate a PASID for this mm, or take a reference to the existing one
> - * provided it fits within the [@min, @max] range. On success the PASID is
> - * available in mm->pasid and will be available for the lifetime of the mm.
> - *
> - * Returns 0 on success and < 0 on error.
> - */
> -int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
> +static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
>   {
> -	int ret = 0;
> -	ioasid_t pasid;
> +	int ret;
>   
> -	if (min == INVALID_IOASID || max == INVALID_IOASID ||
> +	if (min == IOMMU_PASID_INVALID || max == IOMMU_PASID_INVALID ||
>   	    min == 0 || max < min)

It's irrelevant to this patch. Just out of curiosity, why do we need to
exclude PASID 0 here? I just had a quick look at PCI spec section 6.20.
The spec does not state that PASID 0 is invalid.

>   		return -EINVAL;
>   
> @@ -37,39 +24,20 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
>   	if (pasid_valid(mm->pasid)) {
>   		if (mm->pasid < min || mm->pasid >= max)
>   			ret = -EOVERFLOW;
> +		else
> +			ret = 0;

Nit:

If you didn't change "int ret = 0" to "int ret", we don't need above two
lines. Did I miss anything?

>   		goto out;
>   	}
>   
> -	pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
> -	if (!pasid_valid(pasid))
> -		ret = -ENOMEM;
> -	else
> -		mm->pasid = ret;
> +	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max, GFP_ATOMIC);
> +	if (ret < min)

Nit:
	    ret < 0?

ida_alloc_range() returns negative error number on failure.

> +		goto out;
> +	mm->pasid = ret;
> +	ret = 0;
>   out:
>   	mutex_unlock(&iommu_sva_lock);
>   	return ret;
>   }
> -EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
> -
> -/* ioasid_find getter() requires a void * argument */
> -static bool __mmget_not_zero(void *mm)
> -{
> -	return mmget_not_zero(mm);
> -}
> -
> -/**
> - * iommu_sva_find() - Find mm associated to the given PASID
> - * @pasid: Process Address Space ID assigned to the mm
> - *
> - * On success a reference to the mm is taken, and must be released with mmput().
> - *
> - * Returns the mm corresponding to this PASID, or an error if not found.
> - */
> -struct mm_struct *iommu_sva_find(ioasid_t pasid)
> -{
> -	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
> -}
> -EXPORT_SYMBOL_GPL(iommu_sva_find);

Removing iommu_sva_find() has nothing to do with the intention of this
patch. Perhaps make it in a separated patch?

>   
>   /**
>    * iommu_sva_bind_device() - Bind a process address space to a device
> @@ -241,8 +209,8 @@ iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
>   
>   void mm_pasid_drop(struct mm_struct *mm)
>   {
> -	if (pasid_valid(mm->pasid)) {
> -		ioasid_free(mm->pasid);
> -		mm->pasid = INVALID_IOASID;
> -	}
> +	if (likely(!pasid_valid(mm->pasid)))

Why is this a likely?

> +		return;
> +
> +	ida_free(&iommu_global_pasid_ida, mm->pasid);
>   }
> diff --git a/drivers/iommu/iommu-sva.h b/drivers/iommu/iommu-sva.h
> index 7215a761b962..c22d0174ad61 100644
> --- a/drivers/iommu/iommu-sva.h
> +++ b/drivers/iommu/iommu-sva.h
> @@ -8,9 +8,6 @@
>   #include <linux/ioasid.h>
>   #include <linux/mm_types.h>
>   
> -int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max);
> -struct mm_struct *iommu_sva_find(ioasid_t pasid);
> -
>   /* I/O Page fault */
>   struct device;
>   struct iommu_fault;

Best regards,
baolu
