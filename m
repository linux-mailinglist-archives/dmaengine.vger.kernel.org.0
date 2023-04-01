Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CE96D3122
	for <lists+dmaengine@lfdr.de>; Sat,  1 Apr 2023 15:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjDANso (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 1 Apr 2023 09:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDANso (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 1 Apr 2023 09:48:44 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D0A1D84C;
        Sat,  1 Apr 2023 06:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680356923; x=1711892923;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9MCRDrcqTn5jIv/7IOOmvCRTNHP2x/Uu3rpz7+Ba/Gg=;
  b=PDgTTIPYcl/yDsI0RpXo8mxRoWy3PAF39Hpu43EyzLBkCQcC6ae8zruh
   Gymo2u386SX1bzyCYcH9DHKzspJ2rE6R+no//f+7qnYOSBdtXpTR5uqes
   V0HbnSPrOqkDFQ5xCKq9QUuPuUQ89/Yh9PvB8kKR7qY0gdkkQ8MZVwbj5
   nk7rQwJhJ26gXbG4D80Mb5DO/7MHwisNbw0981HMJKvALRfem7AbmCFm8
   RRoZW6jAlZUfbSqNyc4qH4Zb9mR9733hNMxJGK/yxyslNGqsb9hh5d0xu
   zhdcVJxQP/4IIvlLU32gDo4zctPMpNh7tZdZc/UhwOXfjeOq6svVDekp3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="344199208"
X-IronPort-AV: E=Sophos;i="5.98,310,1673942400"; 
   d="scan'208";a="344199208"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 06:48:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="796461044"
X-IronPort-AV: E=Sophos;i="5.98,310,1673942400"; 
   d="scan'208";a="796461044"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.211.241]) ([10.254.211.241])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 06:48:38 -0700
Message-ID: <a63e70cc-8890-bb99-3326-0b19e81ea92e@linux.intel.com>
Date:   Sat, 1 Apr 2023 21:48:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Cc:     baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH v3 6/7] iommu/vt-d: Implement set_dev_pasid domain op
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org
References: <20230331231137.1947675-1-jacob.jun.pan@linux.intel.com>
 <20230331231137.1947675-7-jacob.jun.pan@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230331231137.1947675-7-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2023/4/1 7:11, Jacob Pan wrote:
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
>   drivers/iommu/intel/iommu.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 52b9d0d3a02c..1ad9c5a4bd8f 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4784,6 +4784,26 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>   	domain_detach_iommu(dmar_domain, info->iommu);
>   }
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

As the domain ID will be set to the pasid entry, need to get a refcount
of the domain ID. Call domain_attach_iommu() here, and release it after
the pasid entry is torn down.

> +	ret = prepare_domain_attach_device(domain, dev);
> +	if (ret)
> +		return ret;
> +
> +	return dmar_domain_attach_device_pasid(dmar_domain, dev, pasid);
> +}
> +
> +
> +
>   const struct iommu_ops intel_iommu_ops = {
>   	.capable		= intel_iommu_capable,
>   	.domain_alloc		= intel_iommu_domain_alloc,
> @@ -4803,6 +4823,7 @@ const struct iommu_ops intel_iommu_ops = {
>   #endif
>   	.default_domain_ops = &(const struct iommu_domain_ops) {
>   		.attach_dev		= intel_iommu_attach_device,
> +		.set_dev_pasid          = intel_iommu_attach_device_pasid,
>   		.map_pages		= intel_iommu_map_pages,
>   		.unmap_pages		= intel_iommu_unmap_pages,
>   		.iotlb_sync_map		= intel_iommu_iotlb_sync_map,

Best regards,
baolu
