Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B5B6B4F67
	for <lists+dmaengine@lfdr.de>; Fri, 10 Mar 2023 18:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCJRtO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Mar 2023 12:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjCJRtN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Mar 2023 12:49:13 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACA21111C8;
        Fri, 10 Mar 2023 09:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678470530; x=1710006530;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ro8Ex/RmEa6MWq801sYiiL4x9mZmeLlidrsZDD6fPbI=;
  b=FvB+jK/ujXBzwtP5CdRumQi9DgEeDeG92YcnA6q4Pggi40f80El5Z8Ei
   xcQcp2rlPVr+wcGr5wzbViALTtk3TTcorld0DsB4B/DZHxb0xqUZjyT5K
   230bhHdBOqeBXcid9k//B5zGI3KJUkyUTtaVuFBbtSZlxu2MXM5dKkrIT
   wMJoiV4SslRNoFC11aPSVou1h7N0JaCOyrJ3+ZNA9EEob9NdJXe5K+wfp
   2YdiMSkho5YGDjFVci7jo8ZiKD3GN9u+R39A4RBqEzYgErL53mINiwTes
   Uk/dLVKN+gbLhoFpUvCyhDnWBc9U3m9TQBOCKb4GUGEZB85KvJTrvly8N
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="317178136"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="317178136"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 09:48:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="1007203494"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="1007203494"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 09:48:27 -0800
Date:   Fri, 10 Mar 2023 09:52:20 -0800
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
        Tony Luck <tony.luck@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v5 4/7] iommu/sva: Stop using ioasid_set for SVA
Message-ID: <20230310095220.5dc3d8ac@jacob-builder>
In-Reply-To: <69753e4a-32f3-8760-ba1d-8286badd159e@linux.intel.com>
References: <20230309222159.487826-1-jacob.jun.pan@linux.intel.com>
        <20230309222159.487826-6-jacob.jun.pan@linux.intel.com>
        <69753e4a-32f3-8760-ba1d-8286badd159e@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Baolu,

On Fri, 10 Mar 2023 13:07:51 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 3/10/23 6:21 AM, Jacob Pan wrote:
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
> > v5:
> > 	- Put removing iommu_sva_find() to a separate patch (Kevin)
> > 	- Make pasid allocation range to be inclusive (Tina)
> > 	- Simplified return code handling (Baolu)
> > v4:
> > 	- Keep GFP_ATOMIC flag for PASID allocation, will changed to
> > 	GFP_KERNEL in a separate patch.
> > ---
> >   drivers/iommu/iommu-sva.c | 42 +++++++++++++--------------------------
> >   drivers/iommu/iommu-sva.h |  2 --
> >   2 files changed, 14 insertions(+), 30 deletions(-)
> > 
> > diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> > index 4f357ef14f04..b75711bdbe97 100644
> > --- a/drivers/iommu/iommu-sva.c
> > +++ b/drivers/iommu/iommu-sva.c
> > @@ -9,47 +9,33 @@
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
> >   	int ret = 0;
> > -	ioasid_t pasid;
> >   
> > -	if (min == INVALID_IOASID || max == INVALID_IOASID ||
> > -	    min == 0 || max < min)
> > +	if (!pasid_valid(min) || !pasid_valid(max) ||
> > +	     min == 0 || max < min)  
> 
> No need to change above line.
> 
> >   		return -EINVAL;
> >   
> >   	mutex_lock(&iommu_sva_lock);
> >   	/* Is a PASID already associated with this mm? */
> >   	if (pasid_valid(mm->pasid)) {
> > -		if (mm->pasid < min || mm->pasid >= max)
> > +		if (mm->pasid < min || mm->pasid > max)  
> 
> I forgot why do we need to change above line. But it's better to put
> some comments there so that people don't need to dive into
> ioasid_alloc() to know the inclusion or exclusion of @min or @max.
> 
just to be consistent for both limits. sure, we can add the comment.

> >   			ret = -EOVERFLOW;
> >   		goto out;
> >   	}
> >   
> > -	pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
> > -	if (!pasid_valid(pasid))
> > -		ret = -ENOMEM;
> > -	else
> > -		mm->pasid = pasid;
> > +	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max,
> > GFP_ATOMIC);
> > +	if (ret < 0)
> > +		goto out;
> > +	mm->pasid = ret;
> > +	ret = 0;
> >   out:
> >   	mutex_unlock(&iommu_sva_lock);
> >   	return ret;
> >   }
> > -EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
> >   
> >   /**
> >    * iommu_sva_bind_device() - Bind a process address space to a device
> > @@ -221,8 +207,8 @@ iommu_sva_handle_iopf(struct iommu_fault *fault,
> > void *data) 
> >   void mm_pasid_drop(struct mm_struct *mm)
> >   {
> > -	if (pasid_valid(mm->pasid)) {
> > -		ioasid_free(mm->pasid);
> > -		mm->pasid = INVALID_IOASID;
> > -	}
> > +	if (likely(!pasid_valid(mm->pasid)))
> > +		return;
> > +
> > +	ida_free(&iommu_global_pasid_ida, mm->pasid);  
> 
> Any reason why do you drop "mm->pasid = INVALID_IOASID;" here?
> 
mm_drop is called when mm gets released because "mm_count" becomes zero. so
there is no more mm_users. No one will see mm->pasid after this.

On the other hand, iommu_sva_bind_device() needs to hold mm_users refcount
so it won;t happen after mm_drop.

> >   }
> > diff --git a/drivers/iommu/iommu-sva.h b/drivers/iommu/iommu-sva.h
> > index 102eae1817a2..c22d0174ad61 100644
> > --- a/drivers/iommu/iommu-sva.h
> > +++ b/drivers/iommu/iommu-sva.h
> > @@ -8,8 +8,6 @@
> >   #include <linux/ioasid.h>
> >   #include <linux/mm_types.h>
> >   
> > -int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t
> > max); -
> >   /* I/O Page fault */
> >   struct device;
> >   struct iommu_fault;  
> 
> Best regards,
> baolu


Thanks,

Jacob
