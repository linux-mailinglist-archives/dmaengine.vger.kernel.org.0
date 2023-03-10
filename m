Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D4F6B514D
	for <lists+dmaengine@lfdr.de>; Fri, 10 Mar 2023 21:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjCJUBW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Mar 2023 15:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjCJUBP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Mar 2023 15:01:15 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BACE125DBE;
        Fri, 10 Mar 2023 12:01:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0F0BAD7;
        Fri, 10 Mar 2023 12:01:48 -0800 (PST)
Received: from [10.57.90.67] (unknown [10.57.90.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3764D3F71A;
        Fri, 10 Mar 2023 12:00:59 -0800 (PST)
Message-ID: <30923327-6c08-f0c1-1b52-c1d818f3a3a2@arm.com>
Date:   Fri, 10 Mar 2023 20:00:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 2/7] iommu/sva: Move PASID helpers to sva code
Content-Language: en-GB
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
References: <20230309222159.487826-1-jacob.jun.pan@linux.intel.com>
 <20230309222159.487826-4-jacob.jun.pan@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230309222159.487826-4-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2023-03-09 22:21, Jacob Pan wrote:
> Preparing to remove IOASID infrastructure, PASID management will be
> under SVA code. Decouple mm code from IOASID. Use iommu-help.h instead
> of iommu.h to prevent circular inclusion.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
> v5:
> 	- move definition of helpers to iommu code to be consistent with
> 	  declarations. (Kevin)
> 	- fix patch partitioning bug (Baolu)
> v4:
> 	- delete and open code mm_set_pasid
> 	- keep mm_init_pasid() as inline for fork performance
> ---
>   drivers/iommu/iommu-sva.c    | 10 +++++++++-
>   include/linux/ioasid.h       |  2 +-
>   include/linux/iommu-helper.h | 12 ++++++++++++

Eww, can we not? iommu-helper is very much just parts of a specific type 
of bitmap-based IOVA allocator used by some crusty old arch-specific 
IOMMU code and SWIOTLB. It is unrelated to the iommu.h IOMMU API, and 
dragging that stuff into modern SVA-related matters seems bizarrely 
inappropriate. Could we just move the mm_pasid stuff into ioasid.h here, 
then maybe rename it to iommu-sva.h at the end if eradicating the old 
name really matters?

Thanks,
Robin.

>   include/linux/sched/mm.h     | 27 +--------------------------
>   4 files changed, 23 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 24bf9b2b58aa..fcfdc80a3939 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -44,7 +44,7 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
>   	if (!pasid_valid(pasid))
>   		ret = -ENOMEM;
>   	else
> -		mm_pasid_set(mm, pasid);
> +		mm->pasid = pasid;
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
> index 74be34f3a20a..be1451a05a15 100644
> --- a/include/linux/iommu-helper.h
> +++ b/include/linux/iommu-helper.h
> @@ -6,6 +6,7 @@
>   #include <linux/log2.h>
>   #include <linux/math.h>
>   #include <linux/types.h>
> +#include <linux/mm_types.h>
>   
>   static inline unsigned long iommu_device_max_index(unsigned long size,
>   						   unsigned long offset,
> @@ -41,4 +42,15 @@ static inline unsigned long iommu_num_pages(unsigned long addr,
>   	return DIV_ROUND_UP(size, io_page_size);
>   }
>   
> +#define INVALID_IOASID	(-1U)
> +#ifdef CONFIG_IOMMU_SVA
> +static inline void mm_pasid_init(struct mm_struct *mm)
> +{
> +	mm->pasid = INVALID_IOASID;
> +}
> +void mm_pasid_drop(struct mm_struct *mm);
> +#else
> +static inline void mm_pasid_init(struct mm_struct *mm) {}
> +static inline void mm_pasid_drop(struct mm_struct *mm) {}
> +#endif
>   #endif
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 2a243616f222..f341a7a855e8 100644
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
> @@ -451,29 +451,4 @@ static inline void membarrier_update_current_mm(struct mm_struct *next_mm)
>   }
>   #endif
>   
> -#ifdef CONFIG_IOMMU_SVA
> -static inline void mm_pasid_init(struct mm_struct *mm)
> -{
> -	mm->pasid = INVALID_IOASID;
> -}
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
> -#else
> -static inline void mm_pasid_init(struct mm_struct *mm) {}
> -static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid) {}
> -static inline void mm_pasid_drop(struct mm_struct *mm) {}
> -#endif
> -
>   #endif /* _LINUX_SCHED_MM_H */
