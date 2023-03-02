Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893CB6A8214
	for <lists+dmaengine@lfdr.de>; Thu,  2 Mar 2023 13:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjCBMVu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Mar 2023 07:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCBMVt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Mar 2023 07:21:49 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15743BDB2;
        Thu,  2 Mar 2023 04:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677759705; x=1709295705;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Of/AsuqTwoVolH92KoxBEtDCauJhEREASxt+u67TwW4=;
  b=dB4cOwx5cIvsVsp8mIVusPsF52U3dykltZBcsNi9FibK5yiM8W33DjU+
   lwnsO0cf/H3YQq7s1U1qg59bA87hy7VKsdC53yhV9i2Y4D35U/k4DYK90
   LuJaFMEwuIh/r2U4iC4cpEfZahEkvb4yS5WFzo676IVoAcoje6AVxVq1A
   bQCWDW+Aw9snFE8au0Wfx1j13J4zWHJDEkuliYyGMlym7963O8eeXvTD4
   SYVP7//d50dcLPn0BfU2Pbkxm6L58yxMElRHzaUUUMBvZ4bY0hsG3AZ+u
   BuL4Hyr4+kD5fshDeSKmJ9eLJKij0Gj8Ldrs4ScEkP4Uh/t3ZmmE05j4b
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="397270902"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="397270902"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 04:21:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="817988909"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="817988909"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.214.218]) ([10.254.214.218])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 04:21:35 -0800
Message-ID: <5b441119-59ff-997f-ee59-a062ac2ddcca@linux.intel.com>
Date:   Thu, 2 Mar 2023 20:21:33 +0800
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
Subject: Re: [PATCH v4 2/6] iommu/sva: Move PASID helpers to sva code
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
 <20230301235646.2692846-3-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230301235646.2692846-3-jacob.jun.pan@linux.intel.com>
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

On 2023/3/2 7:56, Jacob Pan wrote:
> Preparing to remove IOASID infrastructure, PASID management will be
> under SVA code. Decouple mm code from IOASID. Use iommu-help.h instead
> of iommu.h to prevent circular inclusion.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
> v4: (Jason's comments)
> 	- delete and open code mm_set_pasid
> 	- keep mm_init_pasid() as inline for fork performance
> ---
>   drivers/iommu/iommu-sva.c    | 10 +++++++++-
>   include/linux/ioasid.h       |  2 +-
>   include/linux/iommu-helper.h |  1 +
>   include/linux/sched/mm.h     | 18 ++----------------
>   4 files changed, 13 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 24bf9b2b58aa..376b2a9e2543 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -44,7 +44,7 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
>   	if (!pasid_valid(pasid))
>   		ret = -ENOMEM;
>   	else
> -		mm_pasid_set(mm, pasid);
> +		mm->pasid = ret;

This seems obviously incorrect.

		mm->pasid = pasid;

?

>   out:
>   	mutex_unlock(&iommu_sva_lock);
>   	return ret;
> @@ -238,3 +238,11 @@ iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
>   
>   	return status;
>   }
> +
> +void mm_pasid_drop(struct mm_struct *mm)
> +{
> +	if (pasid_valid(mm->pasid)) {
> +		ioasid_free(mm->pasid);
> +		mm->pasid = INVALID_IOASID;
> +	}
> +}
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index af1c9d62e642..2c502e77ee78 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -4,8 +4,8 @@
>   
>   #include <linux/types.h>
>   #include <linux/errno.h>
> +#include <linux/iommu-helper.h>
>   
> -#define INVALID_IOASID ((ioasid_t)-1)
>   typedef unsigned int ioasid_t;
>   typedef ioasid_t (*ioasid_alloc_fn_t)(ioasid_t min, ioasid_t max, void *data);
>   typedef void (*ioasid_free_fn_t)(ioasid_t ioasid, void *data);
> diff --git a/include/linux/iommu-helper.h b/include/linux/iommu-helper.h
> index 74be34f3a20a..0aa922f6bfad 100644
> --- a/include/linux/iommu-helper.h
> +++ b/include/linux/iommu-helper.h
> @@ -40,5 +40,6 @@ static inline unsigned long iommu_num_pages(unsigned long addr,
>   
>   	return DIV_ROUND_UP(size, io_page_size);
>   }
> +#define INVALID_IOASID	(-1U)
>   
>   #endif
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 2a243616f222..ae5a3f16b321 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -8,7 +8,7 @@
>   #include <linux/mm_types.h>
>   #include <linux/gfp.h>
>   #include <linux/sync_core.h>
> -#include <linux/ioasid.h>
> +#include <linux/iommu-helper.h>
>   
>   /*
>    * Routines for handling mm_structs
> @@ -456,23 +456,9 @@ static inline void mm_pasid_init(struct mm_struct *mm)
>   {
>   	mm->pasid = INVALID_IOASID;
>   }
> -
> -/* Associate a PASID with an mm_struct: */
> -static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid)
> -{
> -	mm->pasid = pasid;
> -}
> -
> -static inline void mm_pasid_drop(struct mm_struct *mm)
> -{
> -	if (pasid_valid(mm->pasid)) {
> -		ioasid_free(mm->pasid);
> -		mm->pasid = INVALID_IOASID;
> -	}
> -}
> +void mm_pasid_drop(struct mm_struct *mm);
>   #else
>   static inline void mm_pasid_init(struct mm_struct *mm) {}
> -static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid) {}
>   static inline void mm_pasid_drop(struct mm_struct *mm) {}

Above mm_pasid_drop() should also be removed.

>   #endif
>   

Best regards,
baolu
