Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F266A8790
	for <lists+dmaengine@lfdr.de>; Thu,  2 Mar 2023 18:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjCBROD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Mar 2023 12:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCBROC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Mar 2023 12:14:02 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE5525E02;
        Thu,  2 Mar 2023 09:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677777241; x=1709313241;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7KR7GFzhVzDZCKMNzsEZi/lu67Vgbj19JPrpCXd1srE=;
  b=DBPbQ1JzAn2qyIHdYJxn5hINjXT8+3hIl/jTODb0LwgMakmSiWoeNs5R
   wF+maKgpLC54nHekAZTVnm0nHrbqqqW728rPAX4BksZJ2+VzZQuNCNiA8
   7HwtGelKz23zgPpiYIrf1X27O1KtPadkOm/SFB6XrM2Nqcf/G84FQ5ROB
   MlZ5G9962Bf7PSAYKt9Ehr4RFvbSYl7AcGACwEdQi/PGPYPNx3go8bMjA
   Bm6RaWXZYPK3YCtDg9Pkd1q3kC+KinYNuf8gU7IOvsh62/vx+aDGhwZ3T
   Vc7WVxVj+zGeDZYcjFFnoy494sXsKGIBcblW6szJ0ualGEyGLPt2mYNRB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="314445720"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="314445720"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 09:13:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="625019051"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="625019051"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 09:13:18 -0800
Date:   Thu, 2 Mar 2023 09:17:07 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
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
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 3/6] iommu/sva: Stop using ioasid_set for SVA
Message-ID: <20230302091707.58d59964@jacob-builder>
In-Reply-To: <3b7fb4d3-1fe9-a3be-46ad-c271be9f96c7@linux.intel.com>
References: <20230301235646.2692846-1-jacob.jun.pan@linux.intel.com>
        <20230301235646.2692846-4-jacob.jun.pan@linux.intel.com>
        <3b7fb4d3-1fe9-a3be-46ad-c271be9f96c7@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Baolu,

On Thu, 2 Mar 2023 21:01:42 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 2023/3/2 7:56, Jacob Pan wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > Instead SVA drivers can use a simple global IDA to allocate PASIDs for
> > each mm_struct.
> > 
> > Future work would be to allow drivers using the SVA APIs to reserve
> > global PASIDs from this IDA for their internal use, eg with the DMA API
> > PASID support.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> > v4:
> > 	- Keep GFP_ATOMIC flag for PASID allocation, will changed to
> > 	GFP_KERNEL in a separate patch.
> > ---
> >   drivers/iommu/iommu-sva.c | 62 ++++++++++-----------------------------
> >   drivers/iommu/iommu-sva.h |  3 --
> >   2 files changed, 15 insertions(+), 50 deletions(-)
> > 
> > diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> > index 376b2a9e2543..297852ae5e7c 100644
> > --- a/drivers/iommu/iommu-sva.c
> > +++ b/drivers/iommu/iommu-sva.c
> > @@ -9,26 +9,13 @@
> >   #include "iommu-sva.h"
> >   
> >   static DEFINE_MUTEX(iommu_sva_lock);
> > -static DECLARE_IOASID_SET(iommu_sva_pasid);
> > +static DEFINE_IDA(iommu_global_pasid_ida);
> >   
> > -/**
> > - * iommu_sva_alloc_pasid - Allocate a PASID for the mm
> > - * @mm: the mm
> > - * @min: minimum PASID value (inclusive)
> > - * @max: maximum PASID value (inclusive)
> > - *
> > - * Try to allocate a PASID for this mm, or take a reference to the
> > existing one
> > - * provided it fits within the [@min, @max] range. On success the
> > PASID is
> > - * available in mm->pasid and will be available for the lifetime of
> > the mm.
> > - *
> > - * Returns 0 on success and < 0 on error.
> > - */
> > -int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t
> > max) +static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t
> > min, ioasid_t max) {
> > -	int ret = 0;
> > -	ioasid_t pasid;
> > +	int ret;
> >   
> > -	if (min == INVALID_IOASID || max == INVALID_IOASID ||
> > +	if (min == IOMMU_PASID_INVALID || max == IOMMU_PASID_INVALID ||
> >   	    min == 0 || max < min)  
> 
> It's irrelevant to this patch. Just out of curiosity, why do we need to
> exclude PASID 0 here? I just had a quick look at PCI spec section 6.20.
> The spec does not state that PASID 0 is invalid.
> 
my understanding is that ARM reserves PASID0, unlike VT-d where RID_PASID
is programmable.

> >   		return -EINVAL;
> >   
> > @@ -37,39 +24,20 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm,
> > ioasid_t min, ioasid_t max) if (pasid_valid(mm->pasid)) {
> >   		if (mm->pasid < min || mm->pasid >= max)
> >   			ret = -EOVERFLOW;
> > +		else
> > +			ret = 0;  
> 
> Nit:
> 
> If you didn't change "int ret = 0" to "int ret", we don't need above two
> lines. Did I miss anything?
> 
you are right

> >   		goto out;
> >   	}
> >   
> > -	pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
> > -	if (!pasid_valid(pasid))
> > -		ret = -ENOMEM;
> > -	else
> > -		mm->pasid = ret;
> > +	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max,
> > GFP_ATOMIC);
> > +	if (ret < min)  
> 
> Nit:
> 	    ret < 0?
will do

> ida_alloc_range() returns negative error number on failure.
> 
> > +		goto out;
> > +	mm->pasid = ret;
> > +	ret = 0;
> >   out:
> >   	mutex_unlock(&iommu_sva_lock);
> >   	return ret;
> >   }
> > -EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
> > -
> > -/* ioasid_find getter() requires a void * argument */
> > -static bool __mmget_not_zero(void *mm)
> > -{
> > -	return mmget_not_zero(mm);
> > -}
> > -
> > -/**
> > - * iommu_sva_find() - Find mm associated to the given PASID
> > - * @pasid: Process Address Space ID assigned to the mm
> > - *
> > - * On success a reference to the mm is taken, and must be released
> > with mmput().
> > - *
> > - * Returns the mm corresponding to this PASID, or an error if not
> > found.
> > - */
> > -struct mm_struct *iommu_sva_find(ioasid_t pasid)
> > -{
> > -	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
> > -}
> > -EXPORT_SYMBOL_GPL(iommu_sva_find);  
> 
> Removing iommu_sva_find() has nothing to do with the intention of this
> patch. Perhaps make it in a separated patch?
will do

> >   
> >   /**
> >    * iommu_sva_bind_device() - Bind a process address space to a device
> > @@ -241,8 +209,8 @@ iommu_sva_handle_iopf(struct iommu_fault *fault,
> > void *data) 
> >   void mm_pasid_drop(struct mm_struct *mm)
> >   {
> > -	if (pasid_valid(mm->pasid)) {
> > -		ioasid_free(mm->pasid);
> > -		mm->pasid = INVALID_IOASID;
> > -	}
> > +	if (likely(!pasid_valid(mm->pasid)))  
> 
> Why is this a likely?
most mm does not have a PASID, thus initialized with invalid ioasid during
fork. This function is called for every mm.

> > +		return;
> > +
> > +	ida_free(&iommu_global_pasid_ida, mm->pasid);
> >   }
> > diff --git a/drivers/iommu/iommu-sva.h b/drivers/iommu/iommu-sva.h
> > index 7215a761b962..c22d0174ad61 100644
> > --- a/drivers/iommu/iommu-sva.h
> > +++ b/drivers/iommu/iommu-sva.h
> > @@ -8,9 +8,6 @@
> >   #include <linux/ioasid.h>
> >   #include <linux/mm_types.h>
> >   
> > -int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t
> > max); -struct mm_struct *iommu_sva_find(ioasid_t pasid);
> > -
> >   /* I/O Page fault */
> >   struct device;
> >   struct iommu_fault;  
> 
> Best regards,
> baolu


Thanks,

Jacob
