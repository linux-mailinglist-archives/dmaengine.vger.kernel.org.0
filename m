Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759006CC6EC
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 17:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbjC1Pp3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 11:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbjC1PpK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 11:45:10 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41BBEB46;
        Tue, 28 Mar 2023 08:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680018292; x=1711554292;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4pyh949E97gRjYQQaTn6XtjnpRmrAxMmEo978KIuT4s=;
  b=fbvIfUM7l8Z2BLXiD1GhoPWjWLHv2iNWOi/ypz5fv4Ue+sk1k8OduYqY
   YSJe6pn404OtSCNQ+5y7auuex10CvaRZizixptqYnSxcDOFHb3Rq5x/MI
   rLxj7cBeDh8AGLWzNeaFmbON7zAoZe1uWfQnSKLw6qwniyQdNUnOd/JiI
   J7jlcourEnkKBSZnLVcmm8nJlJxNbFgGd1HEWYqNs9rZ2Z4heoLD1NbDL
   jIPK9WeaVGugD+Vni/N0yYy2/S5YhwpY676AssMbiKl0s+amvjwlA8lUr
   ePYDGFQnMZqZc0h1kNIY1DRYvVlC75gVwHv61YC6j6hE4vG3OU5W7UYzf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="321005871"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="321005871"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:44:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="716525655"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="716525655"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:44:19 -0700
Date:   Tue, 28 Mar 2023 08:48:22 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 7/8] iommu: Export iommu_get_dma_domain
Message-ID: <20230328084822.4b46e649@jacob-builder>
In-Reply-To: <BN9PR11MB527623AC2CE25EDA10FF81548C889@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
        <20230327232138.1490712-8-jacob.jun.pan@linux.intel.com>
        <e7d53d04-6b7f-05a4-3077-42470c6d2823@linux.intel.com>
        <BN9PR11MB527623AC2CE25EDA10FF81548C889@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Kevin,

On Tue, 28 Mar 2023 07:52:23 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Tuesday, March 28, 2023 2:04 PM
> > 
> > On 3/28/23 7:21 AM, Jacob Pan wrote:  
> > > Devices that use ENQCMDS to submit work needs to retrieve its DMA
> > > domain. It can then attach PASID to the DMA domain for shared mapping
> > > (with RID) established by DMA API.
> > >
> > > Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
> > > ---
> > >   drivers/iommu/iommu.c | 1 +
> > >   include/linux/iommu.h | 5 +++++
> > >   2 files changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > index 10db680acaed..c51d343a75d2 100644
> > > --- a/drivers/iommu/iommu.c
> > > +++ b/drivers/iommu/iommu.c
> > > @@ -2118,6 +2118,7 @@ struct iommu_domain  
> > *iommu_get_dma_domain(struct device *dev)  
> > >   {
> > >   	return dev->iommu_group->default_domain;
> > >   }
> > > +EXPORT_SYMBOL_GPL(iommu_get_dma_domain);  
> > 
> > Directly exporting this function for external use seems unsafe. If the
> > caller is the kernel driver for this device, it's fine because default
> > domain remains unchanged during the life cycle of the driver. Otherwise,
> > using this function may cause UAF. Keep in mind that group's default
> > domain could be changed through sysfs.
> > 
> > However, iommu_get_domain_for_dev() has already done so and has been
> > exported. Maybe I'm worried too much. :-)
> >   
> 
> Agree. The kernel driver managing the device wants to get the current 
> domain of the device then iommu_get_domain_for_dev() is the right
> interface. It knows the domain is the dma domain.
This goes back to v1 then :)

I thought the comments from v1 is that we don't want to check the domain
type is DMA domain returned by iommu_get_domain_for_dev()

If the driver "knows" the domain is dma domain, why can't it use
iommu_get_dma_domain()? seems paradoxical.

Thanks,

Jacob
