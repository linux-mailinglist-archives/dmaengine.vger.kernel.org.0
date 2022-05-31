Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3F053956A
	for <lists+dmaengine@lfdr.de>; Tue, 31 May 2022 19:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345142AbiEaR0B (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 31 May 2022 13:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiEaR0A (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 31 May 2022 13:26:00 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F112991543;
        Tue, 31 May 2022 10:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654017959; x=1685553959;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F1LP91ckbHLgWmDLUjQwFgYUu+IFdFHPe+7fW6HdfRo=;
  b=LDABc9Azq744XljTi0h38HKy9wS3ndgWlV+Dwt42IFAW5JQDdFk9JJGW
   K6bD+fNNXEmhvRtkTigWKephMD7ZtSuQ/9qI/xh0cVW5Ok0ahSwZDXxY4
   pmSi2KowqG4NXXTKv8NI2kH7T+sYsbBbPgdrtk3GEA9DX2rQBRIkm+6f7
   InmkbMVRRosvgc7yni+pQmT+oRnfZxEuE7XeqEJRgyKvnuMYC+j196N1c
   FRohlQYFTliNaXh8O+ByHAuH624Mh+clsrigF/ABkoZhIJvpXApcseDUZ
   wf7yL5tIpH9Z3CykQJ+lbgaSFFWlZBxQZnIDHKTqla3VFLwnQ1U+HqfVG
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="255809548"
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="255809548"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 10:25:59 -0700
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="551889469"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 10:25:59 -0700
Date:   Tue, 31 May 2022 10:29:55 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Christoph Hellwig <hch@infradead.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 1/6] iommu: Add a per domain PASID for DMA API
Message-ID: <20220531102955.6618b540@jacob-builder>
In-Reply-To: <628aa885-dd12-8bcd-bfc6-446345bf69ed@linux.intel.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
        <20220518182120.1136715-2-jacob.jun.pan@linux.intel.com>
        <20220524135034.GU1343366@nvidia.com>
        <20220524081727.19c2dd6d@jacob-builder>
        <20220530122247.GY1343366@nvidia.com>
        <BN9PR11MB52768105FC4FB959298F8A188CDC9@BN9PR11MB5276.namprd11.prod.outlook.com>
        <628aa885-dd12-8bcd-bfc6-446345bf69ed@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Baolu,

On Tue, 31 May 2022 20:45:28 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 2022/5/31 18:12, Tian, Kevin wrote:
> >>>> +++ b/include/linux/iommu.h
> >>>> @@ -105,6 +105,8 @@ struct iommu_domain {
> >>>>   	enum iommu_page_response_code (*iopf_handler)(struct  
> >> iommu_fault *fault,  
> >>>>   						      void *data);
> >>>>   	void *fault_data;
> >>>> +	ioasid_t pasid;		/* Used for DMA requests
> >>>> with PASID */
> >>>> +	atomic_t pasid_users;  
> >>> These are poorly named, this is really the DMA API global PASID and
> >>> shouldn't be used for other things.
> >>>
> >>>
> >>>
> >>> Perhaps I misunderstood, do you mind explaining more?  
> >> You still haven't really explained what this is for in this patch,
> >> maybe it just needs a better commit message, or maybe something is
> >> wrong.
> >>
> >> I keep saying the DMA API usage is not special, so why do we need to
> >> create a new global pasid and refcount? Realistically this is only
> >> going to be used by IDXD, why can't we just allocate a PASID and
> >> return it to the driver every time a driver asks for DMA API on PASI
> >> mode? Why does the core need to do anything special?
> >>  
The reason why I store PASID at IOMMU domain is for IOTLB flush within the
domain. Device driver is not aware of domain level IOTLB flush. We also
have iova_cookie for each domain which essentially is for RIDPASID.

> > Agree. I guess it was a mistake caused by treating ENQCMD as the
> > only user although the actual semantics of the invented interfaces
> > have already evolved to be quite general.
> > 
> > This is very similar to what we have been discussing for iommufd.
> > a PASID is just an additional routing info when attaching a device
> > to an I/O address space (DMA API in this context) and by default
> > it should be a per-device resource except when ENQCMD is
> > explicitly opt in.
> > 
> > Hence it's right time for us to develop common facility working
> > for both this DMA API usage and iommufd, i.e.:
> > 
> > for normal PASID attach to a domain, driver:
> > 
> > 	allocates a local pasid from device local space;
> > 	attaches the local pasid to a domain;
> > 
> > for PASID attach in particular for ENQCMD, driver:
> > 
> > 	allocates a global pasid in system-wide;
> > 	attaches the global pasid to a domain;
> > 	set the global pasid in PASID_MSR;
> > 
> > In both cases the pasid is stored in the attach data instead of the
> > domain.
> > 
So during IOTLB flush for the domain, do we loop through the attach data?

> > DMA API pasid is no special from above except it needs to allow
> > one device attached to the same domain twice (one with RID
> > and the other with RID+PASID).
> > 
> > for iommufd those operations are initiated by userspace via
> > iommufd uAPI.  
> 
> My understanding is that device driver owns its PASID policy. If ENQCMD
> is supported on the device, the PASIDs should be allocated through
> ioasid_alloc(). Otherwise, the whole PASID pool is managed by the device
> driver.
> 
It seems the changes we want for this patchset are:
1. move ioasid_alloc() from the core to device (allocation scope will be
based on whether ENQCMD is intended or not)
2. store pasid in the attach data
3. use the same iommufd api to attach/set pasid on its default domain
Am I summarizing correctly?

> For kernel DMA w/ PASID, after the driver has a PASID for this purpose,
> it can just set the default domain to the PASID on device. There's no
> need for enable/disable() interfaces.
> 
> Best regards,
> baolu


Thanks,

Jacob
