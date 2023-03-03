Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CBD6A8F26
	for <lists+dmaengine@lfdr.de>; Fri,  3 Mar 2023 03:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjCCCZs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Mar 2023 21:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjCCCZo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Mar 2023 21:25:44 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD985457E1;
        Thu,  2 Mar 2023 18:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677810342; x=1709346342;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W+SrNllZInPCiK6vR9t2oCCKH1HMniP23Avh0Rh2exg=;
  b=XSJo7awCm0nB72Pib3wCEniuIvzq41IDAlg+ZnvGeW2QqscbusAcf3mB
   mrpK+RQJch+WpPgIWikC4NGfNbj8ev88sMsocVAgZSK8nEqEpKLI/7Y/2
   sA9qZOn8OX7EZfRRvbo4FxO8wqvKq+KXRlDSD0gFmFhCIhLNdmEBjG1ki
   aUo69sMu20MPAlukl/p/TAVWTn6f/xVxli3e2YJ1F1ikrPKMpTbdKBwzt
   ToobhsvvS+mwq7y2SNjtIf2wBR2I1X5NBid4z+KRDHt14gqtW/3H7jxXq
   mKJRNX4+v07xRKfk8f7+1pexlJuoKB6YF9kNyN5/G5v+a2D9gH6IujP43
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="315334734"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="315334734"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 18:25:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="652633078"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="652633078"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 02 Mar 2023 18:25:35 -0800
Message-ID: <794c7dad-2e62-3afa-ea10-92179b0d1659@linux.intel.com>
Date:   Fri, 3 Mar 2023 10:24:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com, LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 3/6] iommu/sva: Stop using ioasid_set for SVA
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20230301235646.2692846-1-jacob.jun.pan@linux.intel.com>
 <20230301235646.2692846-4-jacob.jun.pan@linux.intel.com>
 <3b7fb4d3-1fe9-a3be-46ad-c271be9f96c7@linux.intel.com>
 <20230302091707.58d59964@jacob-builder>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230302091707.58d59964@jacob-builder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 3/3/23 1:17 AM, Jacob Pan wrote:
> Hi Baolu,
> 
> On Thu, 2 Mar 2023 21:01:42 +0800, Baolu Lu <baolu.lu@linux.intel.com>
> wrote:
> 
>> On 2023/3/2 7:56, Jacob Pan wrote:
>>> From: Jason Gunthorpe <jgg@nvidia.com>
>>>
>>> Instead SVA drivers can use a simple global IDA to allocate PASIDs for
>>> each mm_struct.
>>>
>>> Future work would be to allow drivers using the SVA APIs to reserve
>>> global PASIDs from this IDA for their internal use, eg with the DMA API
>>> PASID support.
>>>
>>> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>> ---
>>> v4:
>>> 	- Keep GFP_ATOMIC flag for PASID allocation, will changed to
>>> 	GFP_KERNEL in a separate patch.
>>> ---
>>>    drivers/iommu/iommu-sva.c | 62 ++++++++++-----------------------------
>>>    drivers/iommu/iommu-sva.h |  3 --
>>>    2 files changed, 15 insertions(+), 50 deletions(-)
>>>
>>> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
>>> index 376b2a9e2543..297852ae5e7c 100644
>>> --- a/drivers/iommu/iommu-sva.c
>>> +++ b/drivers/iommu/iommu-sva.c
>>> @@ -9,26 +9,13 @@
>>>    #include "iommu-sva.h"
>>>    
>>>    static DEFINE_MUTEX(iommu_sva_lock);
>>> -static DECLARE_IOASID_SET(iommu_sva_pasid);
>>> +static DEFINE_IDA(iommu_global_pasid_ida);
>>>    
>>> -/**
>>> - * iommu_sva_alloc_pasid - Allocate a PASID for the mm
>>> - * @mm: the mm
>>> - * @min: minimum PASID value (inclusive)
>>> - * @max: maximum PASID value (inclusive)
>>> - *
>>> - * Try to allocate a PASID for this mm, or take a reference to the
>>> existing one
>>> - * provided it fits within the [@min, @max] range. On success the
>>> PASID is
>>> - * available in mm->pasid and will be available for the lifetime of
>>> the mm.
>>> - *
>>> - * Returns 0 on success and < 0 on error.
>>> - */
>>> -int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t
>>> max) +static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t
>>> min, ioasid_t max) {
>>> -	int ret = 0;
>>> -	ioasid_t pasid;
>>> +	int ret;
>>>    
>>> -	if (min == INVALID_IOASID || max == INVALID_IOASID ||
>>> +	if (min == IOMMU_PASID_INVALID || max == IOMMU_PASID_INVALID ||
>>>    	    min == 0 || max < min)
>>
>> It's irrelevant to this patch. Just out of curiosity, why do we need to
>> exclude PASID 0 here? I just had a quick look at PCI spec section 6.20.
>> The spec does not state that PASID 0 is invalid.
>>
> my understanding is that ARM reserves PASID0, unlike VT-d where RID_PASID
> is programmable.

I suppose the common thing is reserving some kind of special PASIDs.

> 
>>>    		return -EINVAL;
>>>    
>>> @@ -37,39 +24,20 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm,
>>> ioasid_t min, ioasid_t max) if (pasid_valid(mm->pasid)) {
>>>    		if (mm->pasid < min || mm->pasid >= max)
>>>    			ret = -EOVERFLOW;
>>> +		else
>>> +			ret = 0;
>>
>> Nit:
>>
>> If you didn't change "int ret = 0" to "int ret", we don't need above two
>> lines. Did I miss anything?
>>
> you are right
> 
>>>    		goto out;
>>>    	}
>>>    
>>> -	pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
>>> -	if (!pasid_valid(pasid))
>>> -		ret = -ENOMEM;
>>> -	else
>>> -		mm->pasid = ret;
>>> +	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max,
>>> GFP_ATOMIC);
>>> +	if (ret < min)
>>
>> Nit:
>> 	    ret < 0?
> will do
> 
>> ida_alloc_range() returns negative error number on failure.
>>
>>> +		goto out;
>>> +	mm->pasid = ret;
>>> +	ret = 0;
>>>    out:
>>>    	mutex_unlock(&iommu_sva_lock);
>>>    	return ret;
>>>    }
>>> -EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
>>> -
>>> -/* ioasid_find getter() requires a void * argument */
>>> -static bool __mmget_not_zero(void *mm)
>>> -{
>>> -	return mmget_not_zero(mm);
>>> -}
>>> -
>>> -/**
>>> - * iommu_sva_find() - Find mm associated to the given PASID
>>> - * @pasid: Process Address Space ID assigned to the mm
>>> - *
>>> - * On success a reference to the mm is taken, and must be released
>>> with mmput().
>>> - *
>>> - * Returns the mm corresponding to this PASID, or an error if not
>>> found.
>>> - */
>>> -struct mm_struct *iommu_sva_find(ioasid_t pasid)
>>> -{
>>> -	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
>>> -}
>>> -EXPORT_SYMBOL_GPL(iommu_sva_find);
>>
>> Removing iommu_sva_find() has nothing to do with the intention of this
>> patch. Perhaps make it in a separated patch?
> will do
> 
>>>    
>>>    /**
>>>     * iommu_sva_bind_device() - Bind a process address space to a device
>>> @@ -241,8 +209,8 @@ iommu_sva_handle_iopf(struct iommu_fault *fault,
>>> void *data)
>>>    void mm_pasid_drop(struct mm_struct *mm)
>>>    {
>>> -	if (pasid_valid(mm->pasid)) {
>>> -		ioasid_free(mm->pasid);
>>> -		mm->pasid = INVALID_IOASID;
>>> -	}
>>> +	if (likely(!pasid_valid(mm->pasid)))
>>
>> Why is this a likely?
> most mm does not have a PASID, thus initialized with invalid ioasid during
> fork. This function is called for every mm.

Make sense.

> 
>>> +		return;
>>> +
>>> +	ida_free(&iommu_global_pasid_ida, mm->pasid);
>>>    }
>>> diff --git a/drivers/iommu/iommu-sva.h b/drivers/iommu/iommu-sva.h
>>> index 7215a761b962..c22d0174ad61 100644
>>> --- a/drivers/iommu/iommu-sva.h
>>> +++ b/drivers/iommu/iommu-sva.h
>>> @@ -8,9 +8,6 @@
>>>    #include <linux/ioasid.h>
>>>    #include <linux/mm_types.h>
>>>    
>>> -int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t
>>> max); -struct mm_struct *iommu_sva_find(ioasid_t pasid);
>>> -
>>>    /* I/O Page fault */
>>>    struct device;
>>>    struct iommu_fault;
>>
>> Best regards,
>> baolu
> 
> 
> Thanks,
> 
> Jacob

Best regards,
baolu
