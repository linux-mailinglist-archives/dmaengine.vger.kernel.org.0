Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DBA6DC2E1
	for <lists+dmaengine@lfdr.de>; Mon, 10 Apr 2023 05:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjDJDOu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 Apr 2023 23:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjDJDOs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 9 Apr 2023 23:14:48 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD572D79;
        Sun,  9 Apr 2023 20:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681096487; x=1712632487;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HH/+WNmw+sIuvvRMZpiJbpaB6KWTeNkPHUruG4dRAvs=;
  b=H7SXcI+xnfktGl6du0WAFfghbcqiHasosCxICgro6w18YftLVap4RyDP
   c/INHEmMARvL2Jew7tjl5qVpQsmCdtemDXcvfulsmqQE4K9O5W17Tq++m
   HVEJnYCPgUA3fqnTehmazrKIxSQAlcR5OL/2Vd20oSt0kNTnNugoZptJ8
   Jg5SWSa05fQ7aTUgbtT7Eicq4WnW3mc8MJMCOIc22wQSSI1hWl3IVmqLt
   h/FM2qcoIcM0BH8z8gDNIDNvxsnYhz6Ts3IH7F4S8JjTDIYho5r7dnvWV
   ZL1YaIGDIYbuE/ucNK8oJyCTS7LEOGqVC67UtbCpKX2QBNKD5vuMOhVDI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10675"; a="406104126"
X-IronPort-AV: E=Sophos;i="5.98,332,1673942400"; 
   d="scan'208";a="406104126"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2023 20:14:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10675"; a="1017854029"
X-IronPort-AV: E=Sophos;i="5.98,332,1673942400"; 
   d="scan'208";a="1017854029"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 09 Apr 2023 20:14:42 -0700
Message-ID: <3e431fa5-c056-5b79-32f5-185c5980a678@linux.intel.com>
Date:   Mon, 10 Apr 2023 11:14:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc:     baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH v4 5/7] iommu/vt-d: Make device pasid attachment explicit
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org
References: <20230407180554.2784285-1-jacob.jun.pan@linux.intel.com>
 <20230407180554.2784285-6-jacob.jun.pan@linux.intel.com>
 <54591e4f-682b-cd4e-ee6b-9c9395d9c526@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <54591e4f-682b-cd4e-ee6b-9c9395d9c526@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 4/10/23 10:46 AM, Baolu Lu wrote:
>> @@ -4040,6 +4100,7 @@ static void device_block_translation(struct 
>> device *dev)
>>       spin_lock_irqsave(&info->domain->lock, flags);
>>       list_del(&info->link);
>> +    info->dev_attached = 0;
>>       spin_unlock_irqrestore(&info->domain->lock, flags);
>>       domain_detach_iommu(info->domain, iommu);
>> @@ -4186,7 +4247,7 @@ static int intel_iommu_attach_device(struct 
>> iommu_domain *domain,
>>       if (ret)
>>           return ret;
>> -    return dmar_domain_attach_device(to_dmar_domain(domain), dev);
>> +    return dmar_domain_attach_device_pasid(to_dmar_domain(domain), 
>> dev, PASID_RID2PASID);
>>   }
> 
> For VT-d driver, attach_dev and attach_dev_pasid have different
> meanings. Merging them into one helper may lead to confusion. What do
> you think of the following code? The dmar_domain_attach_device_pasid()
> helper could be reused for attach_dev_pasid path.
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 7c2f4bd33582..09ae62bc3724 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2434,6 +2434,40 @@ static int __init si_domain_init(int hw)
>       return 0;
>   }
> 
> +
> +static int dmar_domain_attach_device_pasid(struct dmar_domain *domain,
> +                       struct intel_iommu *iommu,
> +                       struct device *dev, ioasid_t pasid)
> +{
> +    struct device_pasid_info *dev_pasid;
> +    unsigned long flags;
> +    int ret;
> +
> +    dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
> +    if (!dev_pasid)
> +        return -ENOMEM;
> +
> +    if (hw_pass_through && domain_type_is_si(domain))
> +        ret = intel_pasid_setup_pass_through(iommu, domain, dev, pasid);
> +    else if (domain->use_first_level)
> +        ret = domain_setup_first_level(iommu, domain, dev, pasid);
> +    else
> +        ret = intel_pasid_setup_second_level(iommu, domain, dev, pasid);
> +
> +    if (ret) {
> +        kfree(dev_pasid);
> +        return ret;
> +    }
> +
> +    dev_pasid->pasid = pasid;
> +    dev_pasid->dev = dev;
> +    spin_lock_irqsave(&domain->lock, flags);
> +    list_add(&dev_pasid->link_domain, &domain->dev_pasids);
> +    spin_unlock_irqrestore(&domain->lock, flags);
> +
> +    return 0;
> +}
> +
>   static int dmar_domain_attach_device(struct dmar_domain *domain,
>                        struct device *dev)
>   {
> @@ -2458,15 +2492,8 @@ static int dmar_domain_attach_device(struct 
> dmar_domain *domain,
>       /* PASID table is mandatory for a PCI device in scalable mode. */
>       if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
>           /* Setup the PASID entry for requests without PASID: */
> -        if (hw_pass_through && domain_type_is_si(domain))
> -            ret = intel_pasid_setup_pass_through(iommu, domain,
> -                    dev, PASID_RID2PASID);
> -        else if (domain->use_first_level)
> -            ret = domain_setup_first_level(iommu, domain, dev,
> -                    PASID_RID2PASID);
> -        else
> -            ret = intel_pasid_setup_second_level(iommu, domain,
> -                    dev, PASID_RID2PASID);
> +        ret = dmar_domain_attach_device_pasid(domain, iommu, dev,
> +                              PASID_RID2PASID);
>           if (ret) {
>               dev_err(dev, "Setup RID2PASID failed\n");
>               device_block_translation(dev);

Sorry! I forgot one thing. The dev_pasid data allocated in attach_dev
path should be freed in device_block_translation(). Perhaps we need to
add below change?

@@ -4107,6 +4134,7 @@ static void device_block_translation(struct device 
*dev)
  {
         struct device_domain_info *info = dev_iommu_priv_get(dev);
         struct intel_iommu *iommu = info->iommu;
+       struct device_pasid_info *dev_pasid;
         unsigned long flags;

         iommu_disable_pci_caps(info);
@@ -4118,6 +4146,16 @@ static void device_block_translation(struct 
device *dev)
                         domain_context_clear(info);
         }

+       spin_lock_irqsave(&info->domain->lock, flags);
+       list_for_each_entry(dev_pasid, &domain->dev_pasids, link_domain) {
+               if (dev_pasid->dev != dev || dev_pasid->pasid != RID2PASID)
+                       continue;
+
+               list_del(&dev_pasid->link_domain);
+               kfree(dev_pasid);
+       }
+       spin_unlock_irqrestore(&info->domain->lock, flags);
+
         if (!info->domain)
                 return;

Best regards,
baolu
