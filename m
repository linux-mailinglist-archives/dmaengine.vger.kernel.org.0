Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007EA522855
	for <lists+dmaengine@lfdr.de>; Wed, 11 May 2022 02:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiEKAT1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 May 2022 20:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237296AbiEKAT0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 May 2022 20:19:26 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E5427E3EA;
        Tue, 10 May 2022 17:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652228364; x=1683764364;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LNZ2ZyGFyAlorvMsKBypZZXVIJmC3rzFpuJmCI9ge4U=;
  b=MH8DUCQmxnxkaw1P4wEbP5x5QcWjRj+mFjD6IqWXRDm0YJZnKYe8pTD1
   c0yDGjyRS07Hkfe1YkE5OEO+C9s+xYf/+QEm6YOtbHdqljKp5f8JJuXcW
   32APze3XaBglKCEibGd4WMbyw/q/s7ax8+4iKQvrI03V/WeXnB6wzkv9D
   64g2AkYLXZCypcNHFppj1LottG3lbNHwfLr80m4F94pYXc9bNrjXsikWi
   1qPT2eMgD4Zsf5YbZRjD8GqgEYtMjHK8511Gf4HlQECF67m4bgPsaciI2
   jk10gwbXvl1OC57rE9924/ew15DWhRN11YUCq889EjxNA9oiyzW0M6qkj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="269675101"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="269675101"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 17:19:24 -0700
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="738965315"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 17:19:23 -0700
Date:   Tue, 10 May 2022 17:23:09 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, vkoul@kernel.org,
        robin.murphy@arm.com, will@kernel.org, Yi Liu <yi.l.liu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 1/4] iommu/vt-d: Implement domain ops for
 attach_dev_pasid
Message-ID: <20220510172309.3c4e7512@jacob-builder>
In-Reply-To: <20220510232121.GP49344@nvidia.com>
References: <20220510210704.3539577-1-jacob.jun.pan@linux.intel.com>
        <20220510210704.3539577-2-jacob.jun.pan@linux.intel.com>
        <20220510232121.GP49344@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Jason,

On Tue, 10 May 2022 20:21:21 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, May 10, 2022 at 02:07:01PM -0700, Jacob Pan wrote:
> > +static int intel_iommu_attach_dev_pasid(struct iommu_domain *domain,
> > +					struct device *dev,
> > +					ioasid_t pasid)
> > +{
> > +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> > +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> > +	struct intel_iommu *iommu = info->iommu;
> > +	unsigned long flags;
> > +	int ret = 0;
> > +
> > +	if (!sm_supported(iommu) || !info)
> > +		return -ENODEV;
> > +
> > +	spin_lock_irqsave(&device_domain_lock, flags);
> > +	/*
> > +	 * If the same device already has a PASID attached, just
> > return.
> > +	 * DMA layer will return the PASID value to the caller.
> > +	 */
> > +	if (pasid != PASID_RID2PASID && info->pasid) {  
> 
> Why check for PASID == 0 like this? Shouldn't pasid == 0 be rejected
> as an invalid argument?
Right, I was planning on reuse the attach function for RIDPASID as clean
up, but didn't include here. Will fix.

> 
> > +		if (info->pasid == pasid)
> > +			ret = 0;  
> 
> Doesn't this need to check that the current domain is the requested
> domain as well? How can this happen anyhow - isn't it an error to
> double attach?
> 
> > diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> > index 5af24befc9f1..55845a8c4f4d 100644
> > +++ b/include/linux/intel-iommu.h
> > @@ -627,6 +627,7 @@ struct device_domain_info {
> >  	struct intel_iommu *iommu; /* IOMMU used by this device */
> >  	struct dmar_domain *domain; /* pointer to domain */
> >  	struct pasid_table *pasid_table; /* pasid table */
> > +	ioasid_t pasid; /* DMA request with PASID */  
> 
> And this seems wrong - the DMA API is not the only user of
> attach_dev_pasid, so there should not be any global pasid for the
> device.
> 
True but the attach_dev_pasid() op is domain type specific. i.e. DMA API
has its own attach_dev_pasid which is different than sva domain
attach_dev_pasid().
device_domain_info is only used by DMA API.

> I suspect this should be a counter of # of pasid domains attached so
> that the special flush logic triggers
> 
This field is only used for devTLB, so it is per domain-device. struct
device_domain_info is allocated per device-domain as well. Sorry, I might
have totally missed your point.

> And rely on the core code to worry about assigning only one domain per
> pasid - this should really be a 'set' function.
> 
Yes, in this set the core code (in dma-iommu.c) only assign one PASID per
DMA domain type.

Are you suggesting the dma-iommu API should be called
iommu_set_dma_pasid instead of iommu_attach_dma_pasid?

Thanks a lot for the quick review!

Jacob
