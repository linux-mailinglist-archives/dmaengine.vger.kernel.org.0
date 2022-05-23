Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E698531323
	for <lists+dmaengine@lfdr.de>; Mon, 23 May 2022 18:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237652AbiEWPUJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 May 2022 11:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237573AbiEWPUI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 May 2022 11:20:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAA75DA69;
        Mon, 23 May 2022 08:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653319207; x=1684855207;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PbNyLowZXXyeR9OxM1xpX367cO5XzR8kGQzWfh6uwwU=;
  b=W/YY8/PECOJKL7iU21kDnCHLTzwA63tY8w9AnEEjlvuOlfPksgCzTXkS
   A9BSyrpx8E5VyYsRhzBNmEyJ90Xd60hb7wMz5RfxTFsGwH4q9AeyGPCLH
   7IsGxLK7wSH+vgwhXDhD2chjE2CNiFT7Ht5syXExJetPtdmOfh/eGvwg+
   RHs4eJN8cxBqBWHOixVXWNHww+lG3EbIuxOLclqAnoSoMf3lj862hI94y
   FtDhCTA7MvWbs8jbWR3YOUkrSMKUnSe7PqAxVHhk8LP6VkOODiZ7Z916m
   O0nSZHIWqDbTlGp02xYcP486prLneYcj+KH/E5M4sXUr280miuS5uqH57
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="333897855"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="333897855"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 08:20:07 -0700
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="548021388"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 08:20:07 -0700
Date:   Mon, 23 May 2022 08:23:59 -0700
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
Subject: Re: [PATCH v4 4/6] iommu: Add PASID support for DMA mapping API
 users
Message-ID: <20220523082359.74fb435b@jacob-builder>
In-Reply-To: <BL1PR11MB5271E995E160E0C6A6C0C89A8CD49@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
        <20220518182120.1136715-5-jacob.jun.pan@linux.intel.com>
        <BL1PR11MB5271E995E160E0C6A6C0C89A8CD49@BL1PR11MB5271.namprd11.prod.outlook.com>
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

On Mon, 23 May 2022 08:25:33 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Thursday, May 19, 2022 2:21 AM
> > 
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
> > ---
> >  drivers/iommu/dma-iommu.c | 114
> > ++++++++++++++++++++++++++++++++++++++
> >  include/linux/dma-iommu.h |   3 +
> >  2 files changed, 117 insertions(+)
> > 
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 1ca85d37eeab..6ad7ba619ef0 100644
> > --- a/drivers/iommu/dma-iommu.c
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
> > @@ -370,6 +372,118 @@ void iommu_put_dma_cookie(struct
> > iommu_domain *domain)
> >  	domain->iova_cookie = NULL;
> >  }
> > 
> > +/* Protect iommu_domain DMA PASID data */
> > +static DEFINE_MUTEX(dma_pasid_lock);
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
> 
> iommu_attach_dma_domain_pasid? 'dma_pasid' is too broad from
> a API p.o.v.
> 
I agree dma_pasid is too broad, technically it is dma_api_pasid but seems
too long.
My concern with dma_domain_pasid is that the pasid can also be used for
identity domain.

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
> > +		return -EPERM;
> > +	}  
> 
> WARN_ON.
> 
> and probably we can just check whether domain is default domain here.
> 
good point, I will just use
struct iommu_domain *def_domain = iommu_get_dma_domain(dev);

> > +
> > +	mutex_lock(&dma_pasid_lock);
> > +	id = dom->dma_pasid;
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
> > +		if (!max) {
> > +			ret = -EINVAL;
> > +			goto done_unlock;
> > +		}
> > +
> > +		id = ioasid_alloc(&iommu_dma_pasid, 1, max, dev);
> > +		if (id == INVALID_IOASID) {
> > +			ret = -ENOMEM;
> > +			goto done_unlock;
> > +		}
> > +
> > +		dom->dma_pasid = id;
> > +		atomic_set(&dom->dma_pasid_users, 1);  
> 
> this is always accessed with lock held hence no need to be atomic.
> 
good catch, will fix

> > +	}
> > +
> > +	ret = iommu_attach_device_pasid(dom, dev, id);
> > +	if (!ret) {
> > +		*pasid = id;
> > +		atomic_inc(&dom->dma_pasid_users);
> > +		goto done_unlock;
> > +	}
> > +
> > +	if (atomic_dec_and_test(&dom->dma_pasid_users)) {
> > +		ioasid_free(id);
> > +		dom->dma_pasid = 0;
> > +	}
> > +done_unlock:
> > +	mutex_unlock(&dma_pasid_lock);
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
> > +	if (WARN_ON(!dom || !dom->ops || !dom->ops->detach_dev_pasid))
> > +		return;
> > +
> > +	/* Only support DMA API managed domain type */
> > +	if (WARN_ON(dom->type == IOMMU_DOMAIN_UNMANAGED ||
> > +		    dom->type == IOMMU_DOMAIN_BLOCKED))
> > +		return;
> > +
> > +	mutex_lock(&dma_pasid_lock);
> > +	pasid = iommu_get_pasid_from_domain(dev, dom);
> > +	if (!pasid || pasid == INVALID_IOASID) {
> > +		dev_err(dev, "No valid DMA PASID attached\n");
> > +		mutex_unlock(&dma_pasid_lock);
> > +		return;
> > +	}  
> 
> here just use dom->dma_pasid and let iommu driver to figure out
> underlying whether this device has been attached to the domain
> with the said pasid.
> 
Yeah, I am checking the pasid matching in the iommu driver. My thinking is
that here is a quick sanity check in the common code to rule out invalid value.


Thanks a lot!


Jacob
