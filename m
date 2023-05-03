Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B346F517C
	for <lists+dmaengine@lfdr.de>; Wed,  3 May 2023 09:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjECH3P (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 May 2023 03:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjECH2a (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 May 2023 03:28:30 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DB840F1;
        Wed,  3 May 2023 00:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683098907; x=1714634907;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d4DKNUU0DxmVCnkiG4xMBRIAG1ZX8L1Ijj7vjG7BGh8=;
  b=HfZZ6vxR0//cB65iMOkGqa7S5hkL5i5jwlr4mUUKDJ8GYf+Xnx0yaIfC
   Z2572UzFAcLxoNqV6n5HL1RYNSj1ZyZzW7C8L98LnoZTdk6uYGZ1cjlIl
   la98QyasNyTvh1SD1qerJMYgGqgqeWOhJR5fgliZ884JYzfKvHH/bCxZq
   ka4G+X7OYD926iZVP+0bDo1NsrpDbx/1qWXP0/aRkdY4QGVx+SXxEEwjr
   68FPukunAeii0uvdTVRHgf7cBBxfxa+7JjtUkE7uMBk33X/KzaScjwlZa
   8s9LDPODsE8Wh/mgL8uVkOia9Br6PCI6J/YIa9NByEfuSwgbVBkkQT8tB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="328217444"
X-IronPort-AV: E=Sophos;i="5.99,246,1677571200"; 
   d="scan'208";a="328217444"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 00:26:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="785981533"
X-IronPort-AV: E=Sophos;i="5.99,246,1677571200"; 
   d="scan'208";a="785981533"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by FMSMGA003.fm.intel.com with ESMTP; 03 May 2023 00:26:20 -0700
Message-ID: <76c98e62-1cac-2ab6-7721-08ec2c1fceb8@linux.intel.com>
Date:   Wed, 3 May 2023 15:26:00 +0800
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
Subject: Re: [PATCH v5 6/7] iommu/vt-d: Implement set_dev_pasid domain op
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org
References: <20230427174937.471668-1-jacob.jun.pan@linux.intel.com>
 <20230427174937.471668-7-jacob.jun.pan@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230427174937.471668-7-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 4/28/23 1:49 AM, Jacob Pan wrote:
> Devices that use ENQCMDS to submit work on buffers mapped by DMA API
> must attach a PASID to the default domain of the device. In preparation
> for this use case, this patch implements set_dev_pasid() for the
> default_domain_ops.
> 
> If the device context has not been set up prior to this call, this will
> set up the device context in addition to PASID attachment.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 92 ++++++++++++++++++++++++++++++-------
>   1 file changed, 76 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 388453a7415e..f9d6c31cdc8e 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -278,6 +278,8 @@ static LIST_HEAD(dmar_satc_units);
>   	list_for_each_entry(rmrr, &dmar_rmrr_units, list)
>   
>   static void device_block_translation(struct device *dev);
> +static void intel_iommu_detach_device_pasid(struct iommu_domain *domain,
> +					    struct device *dev, ioasid_t pasid);
>   static void intel_iommu_domain_free(struct iommu_domain *domain);
>   
>   int dmar_disabled = !IS_ENABLED(CONFIG_INTEL_IOMMU_DEFAULT_ON);
> @@ -4091,8 +4093,7 @@ static void device_block_translation(struct device *dev)
>   	iommu_disable_pci_caps(info);
>   	if (!dev_is_real_dma_subdevice(dev)) {
>   		if (sm_supported(iommu))
> -			intel_pasid_tear_down_entry(iommu, dev,
> -						    IOMMU_DEF_RID_PASID, false);
> +			intel_iommu_detach_device_pasid(&info->domain->domain, dev, IOMMU_DEF_RID_PASID);

device_block_translation() is called when switch RID's domain or release
the device. I assume that we don't need to touch this path when we add
the attach_dev_pasid support.

Blocking DMA translation through RID/PASID should be done in
remove_dev_pasid path.

Or, I overlooked anything?

[...]

>   
> +static int intel_iommu_attach_device_pasid(struct iommu_domain *domain,
> +					   struct device *dev, ioasid_t pasid)
> +{
> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> +	struct intel_iommu *iommu = info->iommu;
> +	int ret;
> +
> +	if (!pasid_supported(iommu))
> +		return -ENODEV;
> +
> +	ret = prepare_domain_attach_device(domain, dev);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Most likely the device context has already been set up, will only
> +	 * take a domain ID reference. Otherwise, device context will be set
> +	 * up here.

The "otherwise" case is only default domain deferred attaching case,
right?

When the device driver starts to call attach_dev_pasid api, it means
that the bus and device DMA configuration have been done. We could do
the deferred default domain attaching now. So, perhaps we should add
below code in the core:

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f1dcfa3f1a1b..633b5ca53606 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3296,6 +3296,12 @@ int iommu_attach_device_pasid(struct iommu_domain 
*domain,
         if (!group)
                 return -ENODEV;

+       ret = iommu_deferred_attach(dev, group->default_domain);
+       if (ret) {
+               iommu_group_put(group);
+               return ret;
+       }
+
         mutex_lock(&group->mutex);
         curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, 
GFP_KERNEL);
         if (curr) {

Perhaps need to call iommu_deferred_attach() inside the group->mutex
critical region?

> +	 * The upper layer APIs make no assumption about the ordering between
> +	 * device attachment and the PASID attachment.
> +	 */
> +	ret = dmar_domain_attach_device(to_dmar_domain(domain), dev);

Calling attach_device on the attach_dev_pasid path is not right.

> +	if (ret) {
> +		dev_err(dev, "Attach device failed\n");
> +		return ret;
> +	}
> +	return dmar_domain_attach_device_pasid(dmar_domain, iommu, dev, pasid);
> +}
> +
> +
> +
>   const struct iommu_ops intel_iommu_ops = {
>   	.capable		= intel_iommu_capable,
>   	.domain_alloc		= intel_iommu_domain_alloc,
> @@ -4802,6 +4861,7 @@ const struct iommu_ops intel_iommu_ops = {
>   #endif
>   	.default_domain_ops = &(const struct iommu_domain_ops) {
>   		.attach_dev		= intel_iommu_attach_device,
> +		.set_dev_pasid          = intel_iommu_attach_device_pasid,
>   		.map_pages		= intel_iommu_map_pages,
>   		.unmap_pages		= intel_iommu_unmap_pages,
>   		.iotlb_sync_map		= intel_iommu_iotlb_sync_map,

Best regards,
baolu
