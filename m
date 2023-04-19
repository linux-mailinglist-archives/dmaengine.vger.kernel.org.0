Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54116E711A
	for <lists+dmaengine@lfdr.de>; Wed, 19 Apr 2023 04:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjDSC0b (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Apr 2023 22:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjDSC0a (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Apr 2023 22:26:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FCD273C;
        Tue, 18 Apr 2023 19:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681871188; x=1713407188;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k5o+e9OFDKx8HbGbYH4eChwwHrJNFCKaDwBuFDiOPqU=;
  b=HkxAr/7wxteLKrwJPWbrAcv1uPq4OcxXsgaYFgV8BQbv0RjLXcbfbsQW
   3QRFLm4a3yrd/0QPOdnx5syjy7KcrS6gJPR7dM0/hDlL4xzjwGDOYfQMY
   a3H7rEWrpIySp1u58Nq6/lqOCSL2VoWrIP8U3u3hxWEYhfIKcmK9hRRD/
   y/1T8/LNua7RqJGTQEt2A9C6F5CC9ngP7lu+LdzS4QoRB+iNLQd9afQd6
   WV1w67qJcrQdcG2vsGPQLes9pf401mB5LCe8qG9DeOIQgCcTqHre0/FBq
   sZtZUhyNhJiPw9FJyy8T7MtyNMRiuYrvGyGlroYL/bYfl1GP81vywmlOb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="373211999"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="373211999"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 19:26:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="780699282"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="780699282"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Apr 2023 19:26:24 -0700
Message-ID: <dfe89fc9-f73d-7cbd-7475-e4f4170d1a1c@linux.intel.com>
Date:   Wed, 19 Apr 2023 10:26:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     baolu.lu@linux.intel.com, LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH v4 5/7] iommu/vt-d: Make device pasid attachment explicit
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20230407180554.2784285-1-jacob.jun.pan@linux.intel.com>
 <20230407180554.2784285-6-jacob.jun.pan@linux.intel.com>
 <54591e4f-682b-cd4e-ee6b-9c9395d9c526@linux.intel.com>
 <20230418143254.064933d8@jacob-builder>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230418143254.064933d8@jacob-builder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 4/19/23 5:32 AM, Jacob Pan wrote:
> On Mon, 10 Apr 2023 10:46:02 +0800, Baolu Lu<baolu.lu@linux.intel.com>
> wrote:
> 
>> On 4/8/23 2:05 AM, Jacob Pan wrote:
>>> @@ -2429,10 +2475,11 @@ static int __init si_domain_init(int hw)
>>>    	return 0;
>>>    }
>>>    
>>> -static int dmar_domain_attach_device(struct dmar_domain *domain,
>>> -				     struct device *dev)
>>> +static int dmar_domain_attach_device_pasid(struct dmar_domain *domain,
>>> +				     struct device *dev, ioasid_t
>>> pasid) {
>>>    	struct device_domain_info *info = dev_iommu_priv_get(dev);
>>> +	struct device_pasid_info *dev_pasid;
>>>    	struct intel_iommu *iommu;
>>>    	unsigned long flags;
>>>    	u8 bus, devfn;
>>> @@ -2442,43 +2489,57 @@ static int dmar_domain_attach_device(struct
>>> dmar_domain *domain, if (!iommu)
>>>    		return -ENODEV;
>>>    
>>> +	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
>>> +	if (!dev_pasid)
>>> +		return -ENOMEM;
>>> +
>>>    	ret = domain_attach_iommu(domain, iommu);
>>>    	if (ret)
>>> -		return ret;
>>> +		goto exit_free;
>>> +
>>>    	info->domain = domain;
>>> +	dev_pasid->pasid = pasid;
>>> +	dev_pasid->dev = dev;
>>>    	spin_lock_irqsave(&domain->lock, flags);
>>> -	list_add(&info->link, &domain->devices);
>>> +	if (!info->dev_attached)
>>> +		list_add(&info->link, &domain->devices);
>>> +
>>> +	list_add(&dev_pasid->link_domain, &domain->dev_pasids);
>>>    	spin_unlock_irqrestore(&domain->lock, flags);
>>>    
>>>    	/* PASID table is mandatory for a PCI device in scalable
>>> mode. */ if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
>>>    		/* Setup the PASID entry for requests without PASID:
>>> */ if (hw_pass_through && domain_type_is_si(domain))
>>> -			ret = intel_pasid_setup_pass_through(iommu,
>>> domain,
>>> -					dev, PASID_RID2PASID);
>>> +			ret = intel_pasid_setup_pass_through(iommu,
>>> domain, dev, pasid); else if (domain->use_first_level)
>>> -			ret = domain_setup_first_level(iommu, domain,
>>> dev,
>>> -					PASID_RID2PASID);
>>> +			ret = domain_setup_first_level(iommu, domain,
>>> dev, pasid); else
>>> -			ret = intel_pasid_setup_second_level(iommu,
>>> domain,
>>> -					dev, PASID_RID2PASID);
>>> +			ret = intel_pasid_setup_second_level(iommu,
>>> domain, dev, pasid); if (ret) {
>>> -			dev_err(dev, "Setup RID2PASID failed\n");
>>> +			dev_err(dev, "Setup PASID %d failed\n", pasid);
>>>    			device_block_translation(dev);
>>> -			return ret;
>>> +			goto exit_free;
>>>    		}
>>>    	}
>>> +	/* device context already activated,  we are done */
>>> +	if (info->dev_attached)
>>> +		goto exit;
>>>    
>>>    	ret = domain_context_mapping(domain, dev);
>>>    	if (ret) {
>>>    		dev_err(dev, "Domain context map failed\n");
>>>    		device_block_translation(dev);
>>> -		return ret;
>>> +		goto exit_free;
>>>    	}
>>>    
>>>    	iommu_enable_pci_caps(info);
>>> -
>>> +	info->dev_attached = 1;
>>> +exit:
>>>    	return 0;
>>> +exit_free:
>>> +	kfree(dev_pasid);
>>> +	return ret;
>>>    }
>>>    
>>>    static bool device_has_rmrr(struct device *dev)
>>> @@ -4029,8 +4090,7 @@ static void device_block_translation(struct
>>> device *dev) iommu_disable_pci_caps(info);
>>>    	if (!dev_is_real_dma_subdevice(dev)) {
>>>    		if (sm_supported(iommu))
>>> -			intel_pasid_tear_down_entry(iommu, dev,
>>> -						    PASID_RID2PASID,
>>> false);
>>> +
>>> intel_iommu_detach_device_pasid(&info->domain->domain, dev,
>>> PASID_RID2PASID); else domain_context_clear(info);
>>>    	}
>>> @@ -4040,6 +4100,7 @@ static void device_block_translation(struct
>>> device *dev)
>>>    	spin_lock_irqsave(&info->domain->lock, flags);
>>>    	list_del(&info->link);
>>> +	info->dev_attached = 0;
>>>    	spin_unlock_irqrestore(&info->domain->lock, flags);
>>>    
>>>    	domain_detach_iommu(info->domain, iommu);
>>> @@ -4186,7 +4247,7 @@ static int intel_iommu_attach_device(struct
>>> iommu_domain *domain, if (ret)
>>>    		return ret;
>>>    
>>> -	return dmar_domain_attach_device(to_dmar_domain(domain), dev);
>>> +	return dmar_domain_attach_device_pasid(to_dmar_domain(domain),
>>> dev, PASID_RID2PASID); }
>> For VT-d driver, attach_dev and attach_dev_pasid have different
>> meanings. Merging them into one helper may lead to confusion. What do
>> you think of the following code? The dmar_domain_attach_device_pasid()
>> helper could be reused for attach_dev_pasid path.
> Per our previous discussion
> https://lore.kernel.org/lkml/ZAY4zd4OlgSz+puZ@nvidia.com/
> We wanted to remove the ordering dependency between attaching device and
> device_pasid. i.e. making the two equal at IOMMU API level.

Yes. That still holds.

> 
> So from that perspective, attach_dev_pasid will include attach_dev if the
> device has not been attached. i.e.

I don't follow here. attach_dev and attach_dev_pasid are independent of
each other. So in any case, attach_dev_pasid shouldn't include
attach_dev.

> attach_dev includes set up device context and RID_PASID
> attach_dev_pasid also include set up device context and another PASID.

I guess that you are worrying about the case where the context entry and
pasid table are not setup yet in attach_dev_pasid path? In theory yes,
but not exist in reality. The best case is that we setup context entry
in probe_device path, but at present, perhaps we can simply check and
return failure in this case.

Any way, I'd suggest not mix two ops in a single function.

> 
> No ordering requirement.
> 

Best regards,
baolu
