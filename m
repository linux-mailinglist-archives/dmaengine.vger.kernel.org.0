Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055466F5054
	for <lists+dmaengine@lfdr.de>; Wed,  3 May 2023 08:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjECGuE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 May 2023 02:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjECGuD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 May 2023 02:50:03 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9CC2684;
        Tue,  2 May 2023 23:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683096601; x=1714632601;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iJ7gTbn3TGY2uVMAp3p07OP4QzdNfi6IggKfglIPbfg=;
  b=LwrkvPYYppdkoz+Sd3epQJYdpSti3FJ5raer+iCR2JeqlT2AWaJIiWQ4
   jHH5jvPAWC2Yf15vt2XeiJvnLSrWcmVS8OzQ29pO8mN9dXB+6Jzfw/uLs
   lslWhONaTP0keL40on2XwpDwSjk7h0QKEMi9TKv2pzw36Dy956Jw4t4eO
   BO/CSDdBfD1Bq5sFiTNgG9yqeYDVVhrejtwNs/exS+pEImaN069xGNNEh
   UlmHHDlvNaAOq48mdGw43OJE6Oj0AdLJq7goKSE+f4O8w3/QoVqG+hLva
   +UL+Fn5zX0tZVX6gfc6fCRS8ARedGiBg/Os4gSD9HHlDppusfgmfNXsAO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="414038482"
X-IronPort-AV: E=Sophos;i="5.99,246,1677571200"; 
   d="scan'208";a="414038482"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 23:50:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="696453731"
X-IronPort-AV: E=Sophos;i="5.99,246,1677571200"; 
   d="scan'208";a="696453731"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga002.jf.intel.com with ESMTP; 02 May 2023 23:49:56 -0700
Message-ID: <75bdf30c-d38f-ef95-7618-91ebf35ea297@linux.intel.com>
Date:   Wed, 3 May 2023 14:49:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        narayan.ranganathan@intel.com
Subject: Re: [PATCH v5 5/7] iommu/vt-d: Prepare PASID attachment beyond
 RID_PASID
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org
References: <20230427174937.471668-1-jacob.jun.pan@linux.intel.com>
 <20230427174937.471668-6-jacob.jun.pan@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230427174937.471668-6-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 4/28/23 1:49 AM, Jacob Pan wrote:
> @@ -2433,12 +2477,17 @@ static int dmar_domain_attach_device_pasid(struct dmar_domain *domain,
>   					   struct intel_iommu *iommu,
>   					   struct device *dev, ioasid_t pasid)
>   {
> +	struct device_pasid_info *dev_pasid;
> +	unsigned long flags;
>   	int ret;
>   
> -	/* PASID table is mandatory for a PCI device in scalable mode. */
>   	if (!sm_supported(iommu) && dev_is_real_dma_subdevice(dev))
>   		return -EOPNOTSUPP;
>   
> +	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
> +	if (!dev_pasid)
> +		return -ENOMEM;
> +
>   	if (hw_pass_through && domain_type_is_si(domain))
>   		ret = intel_pasid_setup_pass_through(iommu, domain, dev, pasid);
>   	else if (domain->use_first_level)
> @@ -2446,6 +2495,17 @@ static int dmar_domain_attach_device_pasid(struct dmar_domain *domain,
>   	else
>   		ret = intel_pasid_setup_second_level(iommu, domain, dev, pasid);
>   
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
>   	return 0;
>   }
>   
> @@ -2467,16 +2527,13 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
>   		return ret;
>   	info->domain = domain;
>   	spin_lock_irqsave(&domain->lock, flags);
> +	if (info->dev_attached) {
> +		spin_unlock_irqrestore(&domain->lock, flags);
> +		return 0;
> +	}
>   	list_add(&info->link, &domain->devices);
>   	spin_unlock_irqrestore(&domain->lock, flags);
>   
> -	ret = dmar_domain_attach_device_pasid(domain, iommu, dev,
> -					      IOMMU_DEF_RID_PASID);
> -	if (ret) {
> -		dev_err(dev, "Setup RID2PASID failed\n");
> -		device_block_translation(dev);
> -	}
> -
>   	ret = domain_context_mapping(domain, dev);
>   	if (ret) {
>   		dev_err(dev, "Domain context map failed\n");
> @@ -2485,8 +2542,9 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
>   	}
>   
>   	iommu_enable_pci_caps(info);
> +	info->dev_attached = 1;
>   
> -	return 0;
> +	return ret;
>   }
>   
>   static bool device_has_rmrr(struct device *dev)
> @@ -4044,6 +4102,7 @@ static void device_block_translation(struct device *dev)
>   
>   	spin_lock_irqsave(&info->domain->lock, flags);
>   	list_del(&info->link);
> +	info->dev_attached = 0;
>   	spin_unlock_irqrestore(&info->domain->lock, flags);
>   
>   	domain_detach_iommu(info->domain, iommu);
> @@ -4175,8 +4234,15 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
>   				     struct device *dev)
>   {
>   	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> +	struct intel_iommu *iommu;
> +	u8 bus, devfn;
>   	int ret;
>   
> +	iommu = device_to_iommu(dev, &bus, &devfn);
> +	if (!iommu)
> +		return -ENODEV;
> +
>   	if (domain->type == IOMMU_DOMAIN_UNMANAGED &&
>   	    device_is_rmrr_locked(dev)) {
>   		dev_warn(dev, "Device is ineligible for IOMMU domain attach due to platform RMRR requirement.  Contact your platform vendor.\n");
> @@ -4190,7 +4256,23 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
>   	if (ret)
>   		return ret;
>   
> -	return dmar_domain_attach_device(to_dmar_domain(domain), dev);
> +	ret = dmar_domain_attach_device(to_dmar_domain(domain), dev);
> +	if (ret) {
> +		dev_err(dev, "Attach device failed\n");
> +		return ret;
> +	}
> +
> +	/* PASID table is mandatory for a PCI device in scalable mode. */
> +	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
> +		/* Setup the PASID entry for requests without PASID: */
> +		ret = dmar_domain_attach_device_pasid(dmar_domain, iommu, dev,
> +						      IOMMU_DEF_RID_PASID);
> +		if (ret) {
> +			dev_err(dev, "Setup RID2PASID failed\n");
> +			device_block_translation(dev);
> +		}
> +	}
> +	return ret;
>   }
>   
>   static int intel_iommu_map(struct iommu_domain *domain,

I am not following why do you need to change the attach_device path in
this patch. Perhaps you want to make sure that context entry for the
device is configured before attach_device_pasid?

Best regards,
baolu
