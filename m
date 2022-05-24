Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD0C532EA4
	for <lists+dmaengine@lfdr.de>; Tue, 24 May 2022 18:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbiEXQJB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 May 2022 12:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbiEXQJB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 May 2022 12:09:01 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9B9BD6;
        Tue, 24 May 2022 09:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653408540; x=1684944540;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5Gcuxx4a6dpgfqmvk6ReqxoKJmrbkWXrK0zygSxYLWc=;
  b=ConMUETlXye9adA/pIsAy3HIYsEQfhQ2/9m3jKY+F1rwzZTjeVM/94No
   JWFY9KZ4cHm02HZjeqdWqnt234QdVSUpR+2Wpy0tV6vkYy+FWJdV+gAAL
   WepZ1y9q/23cqpLuN6HtLI3KsfIXNivAaq9HbeEaxxqKC6VueSw/CApgd
   qOQMkFKRUGpf0SAJNGJXspyllTSyq/dcuCSqJa9YIJlhkLp56F5hNHIQa
   EGlvfLzOx3sYzrgCaN+IdTAUg5QR+eDuCHb4i+/JdMT4fm5A6LRWx+wYQ
   qw+x2QLp8TlSgV+VhRhIyB4sx7D91A0NqJGv75sDuqFr8Bo8c3wW2sqpo
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="271147410"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="271147410"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 09:08:42 -0700
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="703531762"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 09:08:42 -0700
Date:   Tue, 24 May 2022 09:12:35 -0700
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
Message-ID: <20220524091235.6dddfab4@jacob-builder>
In-Reply-To: <20220524135135.GV1343366@nvidia.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
        <20220518182120.1136715-4-jacob.jun.pan@linux.intel.com>
        <20220524135135.GV1343366@nvidia.com>
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

On Tue, 24 May 2022 10:51:35 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, May 18, 2022 at 11:21:17AM -0700, Jacob Pan wrote:
> > On VT-d platforms with scalable mode enabled, devices issue DMA requests
> > with PASID need to attach PASIDs to given IOMMU domains. The attach
> > operation involves the following:
> > - Programming the PASID into the device's PASID table
> > - Tracking device domain and the PASID relationship
> > - Managing IOTLB and device TLB invalidations
> > 
> > This patch add attach_dev_pasid functions to the default domain ops
> > which is used by DMA and identity domain types. It could be extended to
> > support other domain types whenever necessary.
> > 
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >  drivers/iommu/intel/iommu.c | 72 +++++++++++++++++++++++++++++++++++--
> >  1 file changed, 70 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 1c2c92b657c7..75615c105fdf 100644
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -1556,12 +1556,18 @@ static void __iommu_flush_dev_iotlb(struct
> > device_domain_info *info, u64 addr, unsigned int mask)
> >  {
> >  	u16 sid, qdep;
> > +	ioasid_t pasid;
> >  
> >  	if (!info || !info->ats_enabled)
> >  		return;
> >  
> >  	sid = info->bus << 8 | info->devfn;
> >  	qdep = info->ats_qdep;
> > +	pasid = iommu_get_pasid_from_domain(info->dev,
> > &info->domain->domain);  
> 
> No, a simgple domain can be attached to multiple pasids, all need to
> be flushed.
> 
Here is device TLB flush, why would I want to flush PASIDs other than my
own device attached?

At one level up, we do have a list of device to be flushed.
	list_for_each_entry(info, &domain->devices, link)
		__iommu_flush_dev_iotlb(info, addr, mask);

	
Note that RID2PASID is not in the pasid_array, its DEVTLB flush also needs
special handling in that the device is doing DMA w/o PASID, thus not aware
of RID2PASID.


> This whole API isn't suitable.
> 
> Jason


Thanks,

Jacob
