Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A91E6B883C
	for <lists+dmaengine@lfdr.de>; Tue, 14 Mar 2023 03:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjCNCRw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Mar 2023 22:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjCNCRw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Mar 2023 22:17:52 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DCF8B327;
        Mon, 13 Mar 2023 19:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678760270; x=1710296270;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Lh56lV68VvySS648vM+XrUZMIJ/KFe+c7SBnKmBWTn8=;
  b=nZyEQyrQmAZvu80bRsDWbY9TiQJiP8RQsB2f94ICd3ifvLC5VTq3F+zv
   CPcrkYqitbXkb9eGm6i9y/KCZIFyE0FgHTLYG8h1gCn0nYM8dLUWbOgyy
   iMqDvoIUn2C7+NDnQKsiAZm/1W9P1rnHYKEYumZydf+R9IYCigYc+vKgB
   1ofnStbcqmkGBllr8H+BRE5CTju610ubqooIh51eUr41tQdVB7oGUgQXP
   yXkuQBpX4Ymwf7RnU+Jd/GwZ24Rjp7nGRj7M6G+vd7V3Yg04PP5+uOiKB
   m2SB6ZHA56qv7TMk/aVQWhVGzrYWzFSlhBJnm/6rOIiVZwsrAxEDCL+OM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="339675410"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="339675410"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 19:17:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="924729527"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="924729527"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga006.fm.intel.com with ESMTP; 13 Mar 2023 19:17:44 -0700
Message-ID: <0548021d-d9b3-3a2e-8c1f-e266dedb8f1c@linux.intel.com>
Date:   Tue, 14 Mar 2023 10:16:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v6 4/7] iommu/sva: Stop using ioasid_set for SVA
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230313204158.1495067-1-jacob.jun.pan@linux.intel.com>
 <20230313204158.1495067-5-jacob.jun.pan@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230313204158.1495067-5-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 3/14/23 4:41 AM, Jacob Pan wrote:
> From: Jason Gunthorpe<jgg@nvidia.com>
> 
> Instead SVA drivers can use a simple global IDA to allocate PASIDs for
> each mm_struct.
> 
> Future work would be to allow drivers using the SVA APIs to reserve global
> PASIDs from this IDA for their internal use, eg with the DMA API PASID
> support.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
> ---
> v5:
> 	- Put removing iommu_sva_find() to a separate patch (Kevin)
> 	- Make pasid allocation range to be inclusive (Tina)
> 	- Simplified return code handling (Baolu)
> v4:
> 	- Keep GFP_ATOMIC flag for PASID allocation, will changed to
> 	GFP_KERNEL in a separate patch.
> ---
>   drivers/iommu/iommu-sva.c | 43 ++++++++++++++-------------------------
>   drivers/iommu/iommu-sva.h |  2 --
>   2 files changed, 15 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 4f357ef14f04..d4640731727a 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -9,47 +9,34 @@
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
> +/* Allocate a PASID for the mm within range (inclusive) */
> +static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
>   {
>   	int ret = 0;
> -	ioasid_t pasid;
>   
> -	if (min == INVALID_IOASID || max == INVALID_IOASID ||
> -	    min == 0 || max < min)
> +	if (!pasid_valid(min) || !pasid_valid(max) ||
> +	     min == 0 || max < min)

I still think the last line change is unnecessary. Otherwise, you
probably will get below CHECK warning:

CHECK: Alignment should match open parenthesis
#259: FILE: drivers/iommu/iommu-sva.c:20:
+	if (!pasid_valid(min) || !pasid_valid(max) ||
+	     min == 0 || max < min)

Besides that,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
