Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6103522889
	for <lists+dmaengine@lfdr.de>; Wed, 11 May 2022 02:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237707AbiEKAkB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 May 2022 20:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239799AbiEKAkB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 May 2022 20:40:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E75113325D;
        Tue, 10 May 2022 17:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652229600; x=1683765600;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DE2oBIK7BGDbN+fpmpl0HxZv5AkQDJetPoSGfAJhg4s=;
  b=mmOOCFd16u1UwD+YTZi4sQ18PaOVkrxNGA0OvnMBZ8yB012IT7kq7PW+
   eCEFl/yQPueOowiWLtHocl2TrxoBcEvxawanRhSNWr2jrKjAfv+kwnoZq
   eZhQKXQhyzah+Zh0V2Tn4vtcl7auywCw0sWsLZqYeA7Fh9YBLT2U1hMwM
   aWikW2X9xCu2m0c8XJ+FrA/vVWwh2jsS623o5WWxVjhArwGg3IG7o7WUD
   U/q1JiSwD1mLjHfy2jlWwUZnPYAnPHITMEDjcfVB3JDJC0mgsODAx7RXb
   fc0SvEQOXEiaCEhjRWrmiqi20NpuRcL9FJNIRafzpFcAgKFOq8AbkmA5B
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="251590959"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="251590959"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 17:39:59 -0700
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="542056357"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 17:39:59 -0700
Date:   Tue, 10 May 2022 17:43:45 -0700
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
Subject: Re: [PATCH v3 2/4] iommu: Add PASID support for DMA mapping API
 users
Message-ID: <20220510174345.27fdaeb8@jacob-builder>
In-Reply-To: <20220510232804.GQ49344@nvidia.com>
References: <20220510210704.3539577-1-jacob.jun.pan@linux.intel.com>
        <20220510210704.3539577-3-jacob.jun.pan@linux.intel.com>
        <20220510232804.GQ49344@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Jason,

On Tue, 10 May 2022 20:28:04 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, May 10, 2022 at 02:07:02PM -0700, Jacob Pan wrote:
> > DMA mapping API is the de facto standard for in-kernel DMA. It operates
> > on a per device/RID basis which is not PASID-aware.
> > 
> > Some modern devices such as Intel Data Streaming Accelerator, PASID is
> > required for certain work submissions. To allow such devices use DMA
> > mapping API, we need the following functionalities:
> > 1. Provide device a way to retrieve a PASID for work submission within
> > the kernel
> > 2. Enable the kernel PASID on the IOMMU for the device
> > 3. Attach the kernel PASID to the device's default DMA domain, let it
> > be IOVA or physical address in case of pass-through.
> > 
> > This patch introduces a driver facing API that enables DMA API
> > PASID usage. Once enabled, device drivers can continue to use DMA APIs
> > as is. There is no difference in dma_handle between without PASID and
> > with PASID.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >  drivers/iommu/dma-iommu.c | 107 ++++++++++++++++++++++++++++++++++++++
> >  include/linux/dma-iommu.h |   3 ++
> >  include/linux/iommu.h     |   2 +
> >  3 files changed, 112 insertions(+)
> > 
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 1ca85d37eeab..5984f3129fa2 100644
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -34,6 +34,8 @@ struct iommu_dma_msi_page {
> >  	phys_addr_t		phys;
> >  };
> >  
> > +static DECLARE_IOASID_SET(iommu_dma_pasid);
> > +
> >  enum iommu_dma_cookie_type {
> >  	IOMMU_DMA_IOVA_COOKIE,
> >  	IOMMU_DMA_MSI_COOKIE,
> > @@ -370,6 +372,111 @@ void iommu_put_dma_cookie(struct iommu_domain
> > *domain) domain->iova_cookie = NULL;
> >  }
> >  
> > +/**
> > + * iommu_attach_dma_pasid --Attach a PASID for in-kernel DMA. Use the
> > device's
> > + * DMA domain.
> > + * @dev: Device to be enabled
> > + * @pasid: The returned kernel PASID to be used for DMA
> > + *
> > + * DMA request with PASID will be mapped the same way as the legacy
> > DMA.
> > + * If the device is in pass-through, PASID will also pass-through. If
> > the
> > + * device is in IOVA, the PASID will point to the same IOVA page table.
> > + *
> > + * @return err code or 0 on success
> > + */
> > +int iommu_attach_dma_pasid(struct device *dev, ioasid_t *pasid)
> > +{
> > +	struct iommu_domain *dom;
> > +	ioasid_t id, max;
> > +	int ret = 0;
> > +
> > +	dom = iommu_get_domain_for_dev(dev);
> > +	if (!dom || !dom->ops || !dom->ops->attach_dev_pasid)
> > +		return -ENODEV;
> > +
> > +	/* Only support domain types that DMA API can be used */
> > +	if (dom->type == IOMMU_DOMAIN_UNMANAGED ||
> > +	    dom->type == IOMMU_DOMAIN_BLOCKED) {
> > +		dev_warn(dev, "Invalid domain type %d", dom->type);  
> 
> This should be a WARN_ON
> 
will do, thanks

> > +		return -EPERM;
> > +	}
> > +
> > +	id = dom->pasid;
> > +	if (!id) {
> > +		/*
> > +		 * First device to use PASID in its DMA domain,
> > allocate
> > +		 * a single PASID per DMA domain is all we need, it is
> > also
> > +		 * good for performance when it comes down to IOTLB
> > flush.
> > +		 */
> > +		max = 1U << dev->iommu->pasid_bits;
> > +		if (!max)
> > +			return -EINVAL;
> > +
> > +		id = ioasid_alloc(&iommu_dma_pasid, 1, max, dev);
> > +		if (id == INVALID_IOASID)
> > +			return -ENOMEM;
> > +
> > +		dom->pasid = id;
> > +		atomic_set(&dom->pasid_users, 1);  
> 
> All of this needs proper locking.
> 
good catch, will add a mutex for domain updates, detach as well.

> > +	}
> > +
> > +	ret = dom->ops->attach_dev_pasid(dom, dev, id);
> > +	if (!ret) {
> > +		*pasid = id;
> > +		atomic_inc(&dom->pasid_users);
> > +		return 0;
> > +	}
> > +
> > +	if (atomic_dec_and_test(&dom->pasid_users)) {
> > +		ioasid_free(id);
> > +		dom->pasid = 0;
> > +	}
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL(iommu_attach_dma_pasid);
> > +
> > +/**
> > + * iommu_detach_dma_pasid --Disable in-kernel DMA request with PASID
> > + * @dev:	Device's PASID DMA to be disabled
> > + *
> > + * It is the device driver's responsibility to ensure no more incoming
> > DMA
> > + * requests with the kernel PASID before calling this function. IOMMU
> > driver
> > + * ensures PASID cache, IOTLBs related to the kernel PASID are cleared
> > and
> > + * drained.
> > + *
> > + */
> > +void iommu_detach_dma_pasid(struct device *dev)
> > +{
> > +	struct iommu_domain *dom;
> > +	ioasid_t pasid;
> > +
> > +	dom = iommu_get_domain_for_dev(dev);
> > +	if (!dom || !dom->ops || !dom->ops->detach_dev_pasid) {
> > +		dev_warn(dev, "No ops for detaching PASID %u", pasid);
> > +		return;
> > +	}
> > +	/* Only support DMA API managed domain type */
> > +	if (dom->type == IOMMU_DOMAIN_UNMANAGED ||
> > +	    dom->type == IOMMU_DOMAIN_BLOCKED) {
> > +		dev_err(dev, "Invalid domain type %d to detach DMA
> > PASID %u\n",
> > +			 dom->type, pasid);
> > +		return;
> > +	}
> > +	pasid = dom->pasid;
> > +	if (!pasid) {
> > +		dev_err(dev, "No DMA PASID attached\n");
> > +		return;
> > +	}  
> 
> All WARN_ON's too
> 
will do.

> > +	dom->ops->detach_dev_pasid(dom, dev, pasid);
> > +	if (atomic_dec_and_test(&dom->pasid_users)) {
> > +		ioasid_free(pasid);
> > +		dom->pasid = 0;
> > +	}
> > +}
> > +EXPORT_SYMBOL(iommu_detach_dma_pasid);
> > +
> >  /**
> >   * iommu_dma_get_resv_regions - Reserved region driver helper
> >   * @dev: Device from iommu_get_resv_regions()
> > diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> > index 24607dc3c2ac..538650b9cb75 100644
> > +++ b/include/linux/dma-iommu.h
> > @@ -18,6 +18,9 @@ int iommu_get_dma_cookie(struct iommu_domain *domain);
> >  int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
> >  void iommu_put_dma_cookie(struct iommu_domain *domain);
> >  
> > +int iommu_attach_dma_pasid(struct device *dev, ioasid_t *pasid);
> > +void iommu_detach_dma_pasid(struct device *dev);
> > +
> >  /* Setup call for arch DMA mapping code */
> >  void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64
> > dma_limit); int iommu_dma_init_fq(struct iommu_domain *domain);
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 1164524814cb..281a87fdce77 100644
> > +++ b/include/linux/iommu.h
> > @@ -105,6 +105,8 @@ struct iommu_domain {
> >  	enum iommu_page_response_code (*iopf_handler)(struct
> > iommu_fault *fault, void *data);
> >  	void *fault_data;
> > +	ioasid_t pasid;		/* Used for DMA requests with
> > PASID */
> > +	atomic_t pasid_users;  
> 
> These are poorly named, this is really the DMA API global PASID and
> shouldn't be used for other things.
> 
I was hoping it can be generic since sva_cookie also has a pasid field but
it looks like sva uses mm->pasid now.

Shall we call it dma_api_pasid, dma_pasid, or something else?

> Jason


Thanks,

Jacob
