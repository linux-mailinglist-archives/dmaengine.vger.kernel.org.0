Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767DC533287
	for <lists+dmaengine@lfdr.de>; Tue, 24 May 2022 22:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiEXUlf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 May 2022 16:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241590AbiEXUle (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 May 2022 16:41:34 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB6F48305;
        Tue, 24 May 2022 13:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653424893; x=1684960893;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yIv8vgMmqMTj4IZXd8vqbLx0EuYjS2FZ1lkgJF4zRYM=;
  b=NC1M3e2lwy0Ok9y9tSkyG22C6TRNER5cCUkUMK6ROof4fj6NslCFuUxS
   c5pwk2E+UxzHlMtkyAb7udHg2LFYRcrK0wpeGQAhGBnicF52uvioP6PBq
   cOMeiboXwt6EjlJdMVVrXlFw8/d42H3RcQfIySK1msTCavETU8OH0octZ
   rgDuCqzddqQnVW255sS4X6JubMYaGU9HIpgmUze4RDEFQdSWoB4mtU+6N
   5GwCF95vm+Iw4zoCGE2QjcwOkBY5pdGxqefCObE++kWykquhHWC0sEd1N
   ELm++9xWw3TZBHIWsUrKKSlrKSULIkjtIjH6+rCc1nR9zW35Sv+XjvFgt
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="273757095"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="273757095"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 13:41:33 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="745385856"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 13:41:32 -0700
Date:   Tue, 24 May 2022 13:45:26 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Christoph Hellwig <hch@infradead.org>, vkoul@kernel.org,
        robin.murphy@arm.com, will@kernel.org, Yi Liu <yi.l.liu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 3/6] iommu/vt-d: Implement domain ops for
 attach_dev_pasid
Message-ID: <20220524134526.409519ac@jacob-builder>
In-Reply-To: <20220524180241.GY1343366@nvidia.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
        <20220518182120.1136715-4-jacob.jun.pan@linux.intel.com>
        <20220524135135.GV1343366@nvidia.com>
        <20220524091235.6dddfab4@jacob-builder>
        <20220524180241.GY1343366@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Jason,

On Tue, 24 May 2022 15:02:41 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, May 24, 2022 at 09:12:35AM -0700, Jacob Pan wrote:
> > Hi Jason,
> > 
> > On Tue, 24 May 2022 10:51:35 -0300, Jason Gunthorpe <jgg@nvidia.com>
> > wrote: 
> > > On Wed, May 18, 2022 at 11:21:17AM -0700, Jacob Pan wrote:  
> > > > On VT-d platforms with scalable mode enabled, devices issue DMA
> > > > requests with PASID need to attach PASIDs to given IOMMU domains.
> > > > The attach operation involves the following:
> > > > - Programming the PASID into the device's PASID table
> > > > - Tracking device domain and the PASID relationship
> > > > - Managing IOTLB and device TLB invalidations
> > > > 
> > > > This patch add attach_dev_pasid functions to the default domain ops
> > > > which is used by DMA and identity domain types. It could be
> > > > extended to support other domain types whenever necessary.
> > > > 
> > > > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > >  drivers/iommu/intel/iommu.c | 72
> > > > +++++++++++++++++++++++++++++++++++-- 1 file changed, 70
> > > > insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/iommu/intel/iommu.c
> > > > b/drivers/iommu/intel/iommu.c index 1c2c92b657c7..75615c105fdf
> > > > 100644 +++ b/drivers/iommu/intel/iommu.c
> > > > @@ -1556,12 +1556,18 @@ static void __iommu_flush_dev_iotlb(struct
> > > > device_domain_info *info, u64 addr, unsigned int mask)
> > > >  {
> > > >  	u16 sid, qdep;
> > > > +	ioasid_t pasid;
> > > >  
> > > >  	if (!info || !info->ats_enabled)
> > > >  		return;
> > > >  
> > > >  	sid = info->bus << 8 | info->devfn;
> > > >  	qdep = info->ats_qdep;
> > > > +	pasid = iommu_get_pasid_from_domain(info->dev,
> > > > &info->domain->domain);    
> > > 
> > > No, a simgple domain can be attached to multiple pasids, all need to
> > > be flushed.
> > >   
> > Here is device TLB flush, why would I want to flush PASIDs other than my
> > own device attached?  
> 
> Again, a domain can be attached to multiple PASID's *on the same
> device*
> 
> The idea that there is only one PASID per domain per device is not
> right.
> 
Got you, I was under the impression that there is no use case yet for
multiple PASIDs per device-domain based on our early discussion.
https://lore.kernel.org/lkml/20220315142216.GV11336@nvidia.com/

Perhaps I misunderstood. I will make the API more future proof and search
through the pasid_array xa for *all* domain-device matches. Like you
suggested earlier, may need to retrieve the xa in the first place and use
xas_for_each to get a faster search.

Thanks,

Jacob
