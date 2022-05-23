Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B69E531CD3
	for <lists+dmaengine@lfdr.de>; Mon, 23 May 2022 22:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244055AbiEWSZk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 May 2022 14:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242545AbiEWSZb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 May 2022 14:25:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6EEA005F;
        Mon, 23 May 2022 10:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653328693; x=1684864693;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=See9p7fez/HBRV0YvEYQHd38Yl91KOYmJwyLfKNrjK8=;
  b=GjwYdJHgteANkGXGRxphMfPuhMSMrokVrdUeD6zifSr8xP/5tKVwe39E
   1BeAvQUJ2O0cWG8MIXXJHavA/78YMLjyAu7e8+cZ6/mgSpnuEdsDcEPyv
   8Nl+A2EElqXwgVu/BClfPrRs7ZqquOB3zUirTyKNEbM1qZ06E2bV+npMO
   pabRbgTYAsUB0LSNY10mprj0d//VNPFvBZ86iTp9I75QiAf6h89550B7t
   4Oj/2n8vG/QnFDyPBQEN5giEgfDqAp2X2Tkd3gnQmiizB/kU1RA9qI4Gr
   nvTsU9WmgOIQFfFNtHdu9TM+gwBn4hsOMCcP9jqD9aX60thkaieLl0/X8
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="273300244"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="273300244"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 10:58:06 -0700
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="744857037"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 10:58:05 -0700
Date:   Mon, 23 May 2022 11:01:58 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 2/6] iommu: Add a helper to do PASID lookup from
 domain
Message-ID: <20220523110158.3382b5fd@jacob-builder>
In-Reply-To: <BN9PR11MB5276622272BCA2ED982EE3C18CD49@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
        <20220518182120.1136715-3-jacob.jun.pan@linux.intel.com>
        <BN9PR11MB5276622272BCA2ED982EE3C18CD49@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Kevin,

On Mon, 23 May 2022 09:14:04 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Tian, Kevin
> > Sent: Monday, May 23, 2022 3:55 PM
> >   
> > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > +ioasid_t iommu_get_pasid_from_domain(struct device *dev, struct
> > > iommu_domain *domain)
> > > +{
> > > +	struct iommu_domain *tdomain;
> > > +	struct iommu_group *group;
> > > +	unsigned long index;
> > > +	ioasid_t pasid = INVALID_IOASID;
> > > +
> > > +	group = iommu_group_get(dev);
> > > +	if (!group)
> > > +		return pasid;
> > > +
> > > +	xa_for_each(&group->pasid_array, index, tdomain) {
> > > +		if (domain == tdomain) {
> > > +			pasid = index;
> > > +			break;
> > > +		}
> > > +	}  
> > 
> > Don't we need to acquire the group lock here?
> > 
pasid_array is under RCU read lock so it is protected though may have stale
data. It also used in atomic context for TLB flush, cannot take the
group mutex. If the caller does detach_dev_pasid while doing TLB flush, it
could result in extra flush but harmless.

> > Btw the intention of this function is a bit confusing. Patch01 already
> > stores the pasid under domain hence it's redundant to get it
> > indirectly from xarray index. You could simply introduce a flag bit
> > (e.g. dma_pasid_enabled) in device_domain_info and then directly
> > use domain->dma_pasid once the flag is true.
> >   
> 
> Just saw your discussion with Jason about v3. While it makes sense
> to not specialize DMA domain in iommu driver, the use of this function
> should only be that when the call chain doesn't pass down a pasid
> value e.g. when doing cache invalidation for domain map/unmap. If
> the upper interface already carries a pasid e.g. in detach_dev_pasid()
> iommu driver can simply verify that the corresponding pasid xarray 
> entry points to the specified domain instead of using this function to
> loop xarray and then verify the returned pasid (as done in patch03/04).
Excellent point, I could just use xa_load(pasid) to compare the domain
instead of loop through xa.
I will add another helper.

bool iommu_is_pasid_domain_attached(struct device *dev, struct iommu_domain *domain, ioasid_t pasid)
{
	struct iommu_group *group;
	bool ret = false;

	group = iommu_group_get(dev);
	if (WARN_ON(!group))
		return false;

	if (domain == xa_load(&group->pasid_array, pasid))
		ret = true;

	iommu_group_put(group);

	return ret;
}

Thanks,

Jacob
