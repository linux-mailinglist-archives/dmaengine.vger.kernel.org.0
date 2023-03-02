Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5816A875F
	for <lists+dmaengine@lfdr.de>; Thu,  2 Mar 2023 17:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjCBQu7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Mar 2023 11:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjCBQu5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Mar 2023 11:50:57 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820BE55B0;
        Thu,  2 Mar 2023 08:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677775852; x=1709311852;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FsCt2B/wytVfS3W47gWNlYsYxuAgQJlg7+x5qUPIYjM=;
  b=ebeNb8ZSCEhzlUtrxXSVMs4sU/BP3fihL+pJqqEsa9nKuJgZI8F1okdK
   uLdsSm/Y80FbMfS3m9jEnxkZ2gR9AGQ7BMBlHJs/NIfjgMey8jSXfRH2v
   Kr4JNotXRlBz0ctA6vRPddHW6M5fA/xIwY5+2HAjHDWfzIWLU8k077nkD
   4KUO+TPccqnbskvRLo7mpuRHEIbBun+cBaYhePsjZjTQdSlRZ+FmRgUg/
   yD/4bongMBEYgZeDsEg6/Or8knqiL4evVO2YGYKEcFKOeuSczBAA2amLc
   hg4e0QgJrIe03JgzoCHxk61ED5u7qlBc1pS0MWKGsLGblsyL+KNkvqIhH
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="323071200"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="323071200"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 08:50:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="625013835"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="625013835"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 08:50:51 -0800
Date:   Thu, 2 Mar 2023 08:54:41 -0800
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
Subject: Re: [PATCH v4 2/6] iommu/sva: Move PASID helpers to sva code
Message-ID: <20230302085441.15a4c523@jacob-builder>
In-Reply-To: <5b441119-59ff-997f-ee59-a062ac2ddcca@linux.intel.com>
References: <20230301235646.2692846-1-jacob.jun.pan@linux.intel.com>
        <20230301235646.2692846-3-jacob.jun.pan@linux.intel.com>
        <5b441119-59ff-997f-ee59-a062ac2ddcca@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Baolu,

On Thu, 2 Mar 2023 20:21:33 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 2023/3/2 7:56, Jacob Pan wrote:
> > Preparing to remove IOASID infrastructure, PASID management will be
> > under SVA code. Decouple mm code from IOASID. Use iommu-help.h instead
> > of iommu.h to prevent circular inclusion.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> > v4: (Jason's comments)
> > 	- delete and open code mm_set_pasid
> > 	- keep mm_init_pasid() as inline for fork performance
> > ---
> >   drivers/iommu/iommu-sva.c    | 10 +++++++++-
> >   include/linux/ioasid.h       |  2 +-
> >   include/linux/iommu-helper.h |  1 +
> >   include/linux/sched/mm.h     | 18 ++----------------
> >   4 files changed, 13 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> > index 24bf9b2b58aa..376b2a9e2543 100644
> > --- a/drivers/iommu/iommu-sva.c
> > +++ b/drivers/iommu/iommu-sva.c
> > @@ -44,7 +44,7 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm,
> > ioasid_t min, ioasid_t max) if (!pasid_valid(pasid))
> >   		ret = -ENOMEM;
> >   	else
> > -		mm_pasid_set(mm, pasid);
> > +		mm->pasid = ret;  
> 
> This seems obviously incorrect.
> 
> 		mm->pasid = pasid;
> 
you are right, it got messed up while partitioning. the final was correct.
> 
> >   out:
> >   	mutex_unlock(&iommu_sva_lock);
> >   	return ret;
> > @@ -238,3 +238,11 @@ iommu_sva_handle_iopf(struct iommu_fault *fault,
> > void *data) 
> >   	return status;
> >   }
> > +
> > +void mm_pasid_drop(struct mm_struct *mm)
> > +{
> > +	if (pasid_valid(mm->pasid)) {
> > +		ioasid_free(mm->pasid);
> > +		mm->pasid = INVALID_IOASID;
> > +	}
> > +}
> > diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> > index af1c9d62e642..2c502e77ee78 100644
> > --- a/include/linux/ioasid.h
> > +++ b/include/linux/ioasid.h
> > @@ -4,8 +4,8 @@
> >   
> >   #include <linux/types.h>
> >   #include <linux/errno.h>
> > +#include <linux/iommu-helper.h>
> >   
> > -#define INVALID_IOASID ((ioasid_t)-1)
> >   typedef unsigned int ioasid_t;
> >   typedef ioasid_t (*ioasid_alloc_fn_t)(ioasid_t min, ioasid_t max,
> > void *data); typedef void (*ioasid_free_fn_t)(ioasid_t ioasid, void
> > *data); diff --git a/include/linux/iommu-helper.h
> > b/include/linux/iommu-helper.h index 74be34f3a20a..0aa922f6bfad 100644
> > --- a/include/linux/iommu-helper.h
> > +++ b/include/linux/iommu-helper.h
> > @@ -40,5 +40,6 @@ static inline unsigned long iommu_num_pages(unsigned
> > long addr, 
> >   	return DIV_ROUND_UP(size, io_page_size);
> >   }
> > +#define INVALID_IOASID	(-1U)
> >   
> >   #endif
> > diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> > index 2a243616f222..ae5a3f16b321 100644
> > --- a/include/linux/sched/mm.h
> > +++ b/include/linux/sched/mm.h
> > @@ -8,7 +8,7 @@
> >   #include <linux/mm_types.h>
> >   #include <linux/gfp.h>
> >   #include <linux/sync_core.h>
> > -#include <linux/ioasid.h>
> > +#include <linux/iommu-helper.h>
> >   
> >   /*
> >    * Routines for handling mm_structs
> > @@ -456,23 +456,9 @@ static inline void mm_pasid_init(struct mm_struct
> > *mm) {
> >   	mm->pasid = INVALID_IOASID;
> >   }
> > -
> > -/* Associate a PASID with an mm_struct: */
> > -static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid)
> > -{
> > -	mm->pasid = pasid;
> > -}
> > -
> > -static inline void mm_pasid_drop(struct mm_struct *mm)
> > -{
> > -	if (pasid_valid(mm->pasid)) {
> > -		ioasid_free(mm->pasid);
> > -		mm->pasid = INVALID_IOASID;
> > -	}
> > -}
> > +void mm_pasid_drop(struct mm_struct *mm);
> >   #else
> >   static inline void mm_pasid_init(struct mm_struct *mm) {}
> > -static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid) {}
> >   static inline void mm_pasid_drop(struct mm_struct *mm) {}  
> 
> Above mm_pasid_drop() should also be removed.
will do,


Thanks,

Jacob
