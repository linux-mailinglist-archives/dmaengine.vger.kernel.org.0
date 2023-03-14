Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DDA6B9895
	for <lists+dmaengine@lfdr.de>; Tue, 14 Mar 2023 16:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjCNPLa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Mar 2023 11:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjCNPL3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Mar 2023 11:11:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159718682;
        Tue, 14 Mar 2023 08:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678806688; x=1710342688;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=79VXzKUbCpKzyI43FtKU7IvK1LvZdN9gS4iyBbKt50U=;
  b=JsiPXM+5El2xjKIrl+qewbCM+7qLAu7/1eB9KB7LnwUCgbSEF7roCs9e
   Ic0n/YlYqqoW2GVNlg35Yj27BF/6GUHcfkKn0O4fVGA6JeLLbsyHSSl5G
   VfgdWjZXZ1Ao7TLWMJ1idl9WCNfJMjeF2IABmTUuNBvy+JKg61c6AOPkB
   YLW/KS/O2NLrvgDPn3y3PNBBa+BehoKzWZDX1+m39lqWwGuUA9nZKcD8g
   2ysjhk0oFOXPVF0fDFurmCdiif5AAmCSngKhQpO45iS1xYCYptQtUV6zz
   7o6b6LN7+rLJDNmn0a37BEQyV5osoBYoZAy+e78Hjpoq3zMrEZsov54/q
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="317841669"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="317841669"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 08:11:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="681458589"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="681458589"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 08:11:26 -0700
Date:   Tue, 14 Mar 2023 08:15:22 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
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
        linux-doc@vger.kernel.org, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v6 4/7] iommu/sva: Stop using ioasid_set for SVA
Message-ID: <20230314081522.11d2f921@jacob-builder>
In-Reply-To: <0548021d-d9b3-3a2e-8c1f-e266dedb8f1c@linux.intel.com>
References: <20230313204158.1495067-1-jacob.jun.pan@linux.intel.com>
        <20230313204158.1495067-5-jacob.jun.pan@linux.intel.com>
        <0548021d-d9b3-3a2e-8c1f-e266dedb8f1c@linux.intel.com>
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

On Tue, 14 Mar 2023 10:16:41 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 3/14/23 4:41 AM, Jacob Pan wrote:
> > From: Jason Gunthorpe<jgg@nvidia.com>
> > 
> > Instead SVA drivers can use a simple global IDA to allocate PASIDs for
> > each mm_struct.
> > 
> > Future work would be to allow drivers using the SVA APIs to reserve
> > global PASIDs from this IDA for their internal use, eg with the DMA API
> > PASID support.
> > 
> > Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> > Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
> > ---
> > v5:
> > 	- Put removing iommu_sva_find() to a separate patch (Kevin)
> > 	- Make pasid allocation range to be inclusive (Tina)
> > 	- Simplified return code handling (Baolu)
> > v4:
> > 	- Keep GFP_ATOMIC flag for PASID allocation, will changed to
> > 	GFP_KERNEL in a separate patch.
> > ---
> >   drivers/iommu/iommu-sva.c | 43 ++++++++++++++-------------------------
> >   drivers/iommu/iommu-sva.h |  2 --
> >   2 files changed, 15 insertions(+), 30 deletions(-)
> > 
> > diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> > index 4f357ef14f04..d4640731727a 100644
> > --- a/drivers/iommu/iommu-sva.c
> > +++ b/drivers/iommu/iommu-sva.c
> > @@ -9,47 +9,34 @@
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
> > max) +/* Allocate a PASID for the mm within range (inclusive) */
> > +static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min,
> > ioasid_t max) {
> >   	int ret = 0;
> > -	ioasid_t pasid;
> >   
> > -	if (min == INVALID_IOASID || max == INVALID_IOASID ||
> > -	    min == 0 || max < min)
> > +	if (!pasid_valid(min) || !pasid_valid(max) ||
> > +	     min == 0 || max < min)  
> 
> I still think the last line change is unnecessary. Otherwise, you
> probably will get below CHECK warning:
> 
Got it :) I misunderstood, I thought you meant should not change to
pasid_valid()
will fix
> CHECK: Alignment should match open parenthesis
> #259: FILE: drivers/iommu/iommu-sva.c:20:
> +	if (!pasid_valid(min) || !pasid_valid(max) ||
> +	     min == 0 || max < min)
> 
> Besides that,
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Best regards,
> baolu
> 


Thanks,

Jacob
