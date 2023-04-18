Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846006E6E34
	for <lists+dmaengine@lfdr.de>; Tue, 18 Apr 2023 23:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjDRV34 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Apr 2023 17:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjDRV3z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Apr 2023 17:29:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9531027D;
        Tue, 18 Apr 2023 14:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681853364; x=1713389364;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ytu1jBKyFn8ZVXTAxlUC15ozn0Sj0b3bIeS0+OOfiXo=;
  b=LWLJXGjFjAvNURzGFu1XqKnLBvpTCobcZFHrmFrx0eCJdyHwcmf8Tcoh
   uPsavDwkyMwHj0aiqQq+bN33KMhpYoBilESJgqtMDx54JKOf2bu+DBmyD
   1VecC2iNpvBCYHuLtx6nOwlTR2YRK6UZRZz9595u3rsTKlLyPFsTfJtPa
   YVWLPDIQOGw3SYkFV2LzL0ZttZ85iMs8Tf3sF4P8UsMKcRpvJRJ+u7c9i
   zX701iD0z8DzNmX+OB7vBpd23ztv1agaD0KPbK95TzfriA4zN3FPWoM7r
   tuW+0J77hsNoFizHyYgEnlgjkHGbpqzhbIXEQMAPWV9EI/gmR4XPcCYIv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="325624729"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="325624729"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 14:28:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="780633869"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="780633869"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 14:28:40 -0700
Date:   Tue, 18 Apr 2023 14:32:54 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 5/7] iommu/vt-d: Make device pasid attachment
 explicit
Message-ID: <20230418143254.064933d8@jacob-builder>
In-Reply-To: <54591e4f-682b-cd4e-ee6b-9c9395d9c526@linux.intel.com>
References: <20230407180554.2784285-1-jacob.jun.pan@linux.intel.com>
        <20230407180554.2784285-6-jacob.jun.pan@linux.intel.com>
        <54591e4f-682b-cd4e-ee6b-9c9395d9c526@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Baolu,

On Mon, 10 Apr 2023 10:46:02 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 4/8/23 2:05 AM, Jacob Pan wrote:
> > @@ -2429,10 +2475,11 @@ static int __init si_domain_init(int hw)
> >   	return 0;
> >   }
> >   
> > -static int dmar_domain_attach_device(struct dmar_domain *domain,
> > -				     struct device *dev)
> > +static int dmar_domain_attach_device_pasid(struct dmar_domain *domain,
> > +				     struct device *dev, ioasid_t
> > pasid) {
> >   	struct device_domain_info *info = dev_iommu_priv_get(dev);
> > +	struct device_pasid_info *dev_pasid;
> >   	struct intel_iommu *iommu;
> >   	unsigned long flags;
> >   	u8 bus, devfn;
> > @@ -2442,43 +2489,57 @@ static int dmar_domain_attach_device(struct
> > dmar_domain *domain, if (!iommu)
> >   		return -ENODEV;
> >   
> > +	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
> > +	if (!dev_pasid)
> > +		return -ENOMEM;
> > +
> >   	ret = domain_attach_iommu(domain, iommu);
> >   	if (ret)
> > -		return ret;
> > +		goto exit_free;
> > +
> >   	info->domain = domain;
> > +	dev_pasid->pasid = pasid;
> > +	dev_pasid->dev = dev;
> >   	spin_lock_irqsave(&domain->lock, flags);
> > -	list_add(&info->link, &domain->devices);
> > +	if (!info->dev_attached)
> > +		list_add(&info->link, &domain->devices);
> > +
> > +	list_add(&dev_pasid->link_domain, &domain->dev_pasids);
> >   	spin_unlock_irqrestore(&domain->lock, flags);
> >   
> >   	/* PASID table is mandatory for a PCI device in scalable
> > mode. */ if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
> >   		/* Setup the PASID entry for requests without PASID:
> > */ if (hw_pass_through && domain_type_is_si(domain))
> > -			ret = intel_pasid_setup_pass_through(iommu,
> > domain,
> > -					dev, PASID_RID2PASID);
> > +			ret = intel_pasid_setup_pass_through(iommu,
> > domain, dev, pasid); else if (domain->use_first_level)
> > -			ret = domain_setup_first_level(iommu, domain,
> > dev,
> > -					PASID_RID2PASID);
> > +			ret = domain_setup_first_level(iommu, domain,
> > dev, pasid); else
> > -			ret = intel_pasid_setup_second_level(iommu,
> > domain,
> > -					dev, PASID_RID2PASID);
> > +			ret = intel_pasid_setup_second_level(iommu,
> > domain, dev, pasid); if (ret) {
> > -			dev_err(dev, "Setup RID2PASID failed\n");
> > +			dev_err(dev, "Setup PASID %d failed\n", pasid);
> >   			device_block_translation(dev);
> > -			return ret;
> > +			goto exit_free;
> >   		}
> >   	}
> > +	/* device context already activated,  we are done */
> > +	if (info->dev_attached)
> > +		goto exit;
> >   
> >   	ret = domain_context_mapping(domain, dev);
> >   	if (ret) {
> >   		dev_err(dev, "Domain context map failed\n");
> >   		device_block_translation(dev);
> > -		return ret;
> > +		goto exit_free;
> >   	}
> >   
> >   	iommu_enable_pci_caps(info);
> > -
> > +	info->dev_attached = 1;
> > +exit:
> >   	return 0;
> > +exit_free:
> > +	kfree(dev_pasid);
> > +	return ret;
> >   }
> >   
> >   static bool device_has_rmrr(struct device *dev)
> > @@ -4029,8 +4090,7 @@ static void device_block_translation(struct
> > device *dev) iommu_disable_pci_caps(info);
> >   	if (!dev_is_real_dma_subdevice(dev)) {
> >   		if (sm_supported(iommu))
> > -			intel_pasid_tear_down_entry(iommu, dev,
> > -						    PASID_RID2PASID,
> > false);
> > +
> > intel_iommu_detach_device_pasid(&info->domain->domain, dev,
> > PASID_RID2PASID); else domain_context_clear(info);
> >   	}
> > @@ -4040,6 +4100,7 @@ static void device_block_translation(struct
> > device *dev) 
> >   	spin_lock_irqsave(&info->domain->lock, flags);
> >   	list_del(&info->link);
> > +	info->dev_attached = 0;
> >   	spin_unlock_irqrestore(&info->domain->lock, flags);
> >   
> >   	domain_detach_iommu(info->domain, iommu);
> > @@ -4186,7 +4247,7 @@ static int intel_iommu_attach_device(struct
> > iommu_domain *domain, if (ret)
> >   		return ret;
> >   
> > -	return dmar_domain_attach_device(to_dmar_domain(domain), dev);
> > +	return dmar_domain_attach_device_pasid(to_dmar_domain(domain),
> > dev, PASID_RID2PASID); }  
> 
> For VT-d driver, attach_dev and attach_dev_pasid have different
> meanings. Merging them into one helper may lead to confusion. What do
> you think of the following code? The dmar_domain_attach_device_pasid()
> helper could be reused for attach_dev_pasid path.
Per our previous discussion
https://lore.kernel.org/lkml/ZAY4zd4OlgSz+puZ@nvidia.com/
We wanted to remove the ordering dependency between attaching device and
device_pasid. i.e. making the two equal at IOMMU API level.

So from that perspective, attach_dev_pasid will include attach_dev if the
device has not been attached. i.e.

attach_dev includes set up device context and RID_PASID
attach_dev_pasid also include set up device context and another PASID.

No ordering requirement.

> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 7c2f4bd33582..09ae62bc3724 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2434,6 +2434,40 @@ static int __init si_domain_init(int hw)
>   	return 0;
>   }
> 
> +
> +static int dmar_domain_attach_device_pasid(struct dmar_domain *domain,
> +					   struct intel_iommu *iommu,
> +					   struct device *dev, ioasid_t
> pasid) +{
> +	struct device_pasid_info *dev_pasid;
> +	unsigned long flags;
> +	int ret;
> +
> +	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
> +	if (!dev_pasid)
> +		return -ENOMEM;
> +
> +	if (hw_pass_through && domain_type_is_si(domain))
> +		ret = intel_pasid_setup_pass_through(iommu, domain, dev,
> pasid);
> +	else if (domain->use_first_level)
> +		ret = domain_setup_first_level(iommu, domain, dev,
> pasid);
> +	else
> +		ret = intel_pasid_setup_second_level(iommu, domain, dev,
> pasid); +
> +	if (ret) {
> +		kfree(dev_pasid);
> +		return ret;
> +	}
> +
> +	dev_pasid->pasid = pasid;
> +	dev_pasid->dev = dev;
> +	spin_lock_irqsave(&domain->lock, flags);
> +	list_add(&dev_pasid->link_domain, &domain->dev_pasids);
> +	spin_unlock_irqrestore(&domain->lock, flags);
> +
> +	return 0;
> +}
> +
>   static int dmar_domain_attach_device(struct dmar_domain *domain,
>   				     struct device *dev)
>   {
> @@ -2458,15 +2492,8 @@ static int dmar_domain_attach_device(struct 
> dmar_domain *domain,
>   	/* PASID table is mandatory for a PCI device in scalable mode.
> */ if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
>   		/* Setup the PASID entry for requests without PASID: */
> -		if (hw_pass_through && domain_type_is_si(domain))
> -			ret = intel_pasid_setup_pass_through(iommu,
> domain,
> -					dev, PASID_RID2PASID);
> -		else if (domain->use_first_level)
> -			ret = domain_setup_first_level(iommu, domain,
> dev,
> -					PASID_RID2PASID);
> -		else
> -			ret = intel_pasid_setup_second_level(iommu,
> domain,
> -					dev, PASID_RID2PASID);
> +		ret = dmar_domain_attach_device_pasid(domain, iommu, dev,
> +						      PASID_RID2PASID);
>   		if (ret) {
>   			dev_err(dev, "Setup RID2PASID failed\n");
>   			device_block_translation(dev);
> 
> >   
> >   static int intel_iommu_map(struct iommu_domain *domain,
> > @@ -4675,26 +4736,52 @@ static void intel_iommu_iotlb_sync_map(struct
> > iommu_domain *domain, __mapping_notify_one(info->iommu, dmar_domain,
> > pfn, pages); }
> >   
> > -static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t
> > pasid) +static void intel_iommu_detach_device_pasid(struct iommu_domain
> > *domain,
> > +					    struct device *dev,
> > ioasid_t pasid) {
> > -	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
> > -	struct iommu_domain *domain;
> > +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> > +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> > +	struct device_pasid_info *i, *dev_pasid = NULL;
> > +	struct intel_iommu *iommu = info->iommu;
> > +	unsigned long flags;
> >   
> > -	/* Domain type specific cleanup: */
> > -	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
> > -	if (domain) {
> > -		switch (domain->type) {
> > -		case IOMMU_DOMAIN_SVA:
> > -			intel_svm_remove_dev_pasid(dev, pasid);
> > -			break;
> > -		default:
> > -			/* should never reach here */
> > -			WARN_ON(1);
> > +	spin_lock_irqsave(&dmar_domain->lock, flags);
> > +	list_for_each_entry(i, &dmar_domain->dev_pasids, link_domain) {
> > +		if (i->dev == dev && i->pasid == pasid) {
> > +			list_del(&i->link_domain);
> > +			dev_pasid = i;
> >   			break;
> >   		}
> >   	}
> > +	spin_unlock_irqrestore(&dmar_domain->lock, flags);
> > +	if (WARN_ON(!dev_pasid))
> > +		return;
> > +
> > +	/* PASID entry already cleared during SVA unbind */
> > +	if (domain->type != IOMMU_DOMAIN_SVA)
> > +		intel_pasid_tear_down_entry(iommu, dev, pasid, false);
> > +
> > +	kfree(dev_pasid);
> > +}
> > +
> > +static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t
> > pasid) +{
> > +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> > +	struct dmar_domain *dmar_domain;
> > +	struct iommu_domain *domain;
> > +
> > +	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
> > +	dmar_domain = to_dmar_domain(domain);
> > +
> > +	/*
> > +	 * SVA Domain type specific cleanup: Not ideal but not until
> > we have
> > +	 * IOPF capable domain specific ops, we need this special case.
> > +	 */
> > +	if (domain->type == IOMMU_DOMAIN_SVA)
> > +		return intel_svm_remove_dev_pasid(dev, pasid);
> >   
> > -	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
> > +	intel_iommu_detach_device_pasid(domain, dev, pasid);
> > +	domain_detach_iommu(dmar_domain, info->iommu);
> >   }  
> 
> The remove_dev_pasid path need to change only after attach_dev_pasid op
> is added, right? If so, we should move such change into the next patch.
yes, you are right, will do.

> >   
> >   const struct iommu_ops intel_iommu_ops = {
> > diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> > index 65b15be72878..b6c26f25d1ba 100644
> > --- a/drivers/iommu/intel/iommu.h
> > +++ b/drivers/iommu/intel/iommu.h
> > @@ -595,6 +595,7 @@ struct dmar_domain {
> >   
> >   	spinlock_t lock;		/* Protect device tracking
> > lists */ struct list_head devices;	/* all devices' list */
> > +	struct list_head dev_pasids;	/* all attached pasids */
> >   
> >   	struct dma_pte	*pgd;		/* virtual address
> > */ int		gaw;		/* max guest address width */
> > @@ -708,6 +709,7 @@ struct device_domain_info {
> >   	u8 ats_supported:1;
> >   	u8 ats_enabled:1;
> >   	u8 dtlb_extra_inval:1;	/* Quirk for devices need extra
> > flush */
> > +	u8 dev_attached:1;	/* Device context activated */
> >   	u8 ats_qdep;
> >   	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
> >   	struct intel_iommu *iommu; /* IOMMU used by this device */
> > @@ -715,6 +717,12 @@ struct device_domain_info {
> >   	struct pasid_table *pasid_table; /* pasid table */
> >   };
> >   
> > +struct device_pasid_info {
> > +	struct list_head link_domain;	/* link to domain
> > siblings */
> > +	struct device *dev;		/* physical device derived
> > from */
> > +	ioasid_t pasid;			/* PASID on physical
> > device */ +};
> > +
> >   static inline void __iommu_flush_cache(
> >   	struct intel_iommu *iommu, void *addr, int size)
> >   {  
> 
> Best regards,
> baolu


Thanks,

Jacob
