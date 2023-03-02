Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494BF6A83F7
	for <lists+dmaengine@lfdr.de>; Thu,  2 Mar 2023 15:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCBOIq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Mar 2023 09:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCBOIp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Mar 2023 09:08:45 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABE413533;
        Thu,  2 Mar 2023 06:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677766124; x=1709302124;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hoNV9oT979Y/xsZ4DB3Eb6IU52u2ldgyiHFC0R+EXOg=;
  b=JseNkWLrWoVMW1LpF8OWjhWmaTCkF8WiOtb7lxQoygTyPVxapil+s2gY
   aGfHwOPv/T03Fp3KK0J14+Ifi1MvK6JfK92HEpTOaAFwZAqEmzJLVmt3o
   NjMFrQbTMPffGE+SxGd+q+OVbri2T7bTDfBZ/QvYvuBOaQ7mxt8fyBOId
   GpfbsvMeSgxTXwzLEoxXKiEkxuabbK8lQgxiO5g0ATbl5ttBHilNF300m
   csBtVL3cqRqfQb/iPaAIQQ/UHo0ZsFBIardoEicGWUrYEfl41eZGySHMe
   EjSn5VXI4RKYnEGxBRfMP4SAB2O1D1S9vFWOeErofhQq5t1Xwh2H1nNo7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="397294274"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="397294274"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 06:06:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="784826291"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="784826291"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.214.218]) ([10.254.214.218])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 06:06:42 -0800
Message-ID: <fad7f28f-b4e8-c1c3-4ca4-a48c5c6d7f4a@linux.intel.com>
Date:   Thu, 2 Mar 2023 22:06:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH 1/4] iommu/vt-d: Implement set device pasid op for default
 domain
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
 <20230302005959.2695267-2-jacob.jun.pan@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230302005959.2695267-2-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2023/3/2 8:59, Jacob Pan wrote:
> On VT-d platforms, legacy DMA requests without PASID use device’s
> default domain, where RID_PASID is always attached. Device drivers
> can then use the DMA API for all in-kernel DMA on the RID.
> 
> Ideally, devices capable of using ENQCMDS can also transparently use the
> default domain, consequently DMA API. However, VT-d architecture
> dictates that the PASID used by ENQCMDS must be different from the
> RID_PASID value.
> 
> To provide support for transparent use of DMA API with non-RID_PASID
> value, this patch implements the set_dev_pasid() function for the
> default domain. The idea is that device drivers wishing to use ENQCMDS
> to submit work on buffers mapped by DMA API will call
> iommu_attach_device_pasid() beforehand.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 10f657828d3a..a0cb3bc851ac 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4665,6 +4665,10 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>   		case IOMMU_DOMAIN_SVA:
>   			intel_svm_remove_dev_pasid(dev, pasid);
>   			break;
> +		case IOMMU_DOMAIN_DMA:
> +		case IOMMU_DOMAIN_DMA_FQ:
> +		case IOMMU_DOMAIN_IDENTITY:
> +			break;
>   		default:
>   			/* should never reach here */
>   			WARN_ON(1);
> @@ -4675,6 +4679,33 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>   	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
>   }
>   
> +static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
> +				   struct device *dev, ioasid_t pasid)
> +{
> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> +	struct intel_iommu *iommu = info->iommu;
> +	int ret = 0;
> +
> +	if (!sm_supported(iommu) || !info)

@info has been referenced. !info check makes no sense.

Add pasid_supported(iommu).

Do you need to check whether the domain is compatible for this rid
pasid?

> +		return -ENODEV;
> +
> +	if (WARN_ON(pasid == PASID_RID2PASID))
> +		return -EINVAL;

Add a call to domain_attach_iommu() here to get a refcount of the domain
ID. And call domain_detach_iommu() in intel_iommu_remove_dev_pasid().

> +
> +	if (hw_pass_through && domain_type_is_si(dmar_domain))
> +		ret = intel_pasid_setup_pass_through(iommu, dmar_domain,
> +						     dev, pasid);
> +	else if (dmar_domain->use_first_level)
> +		ret = domain_setup_first_level(iommu, dmar_domain,
> +					       dev, pasid);
> +	else
> +		ret = intel_pasid_setup_second_level(iommu, dmar_domain,
> +						     dev, pasid);
> +
> +	return ret;
> +}

Do you need to consider pasid cache invalidation?

> +
>   const struct iommu_ops intel_iommu_ops = {
>   	.capable		= intel_iommu_capable,
>   	.domain_alloc		= intel_iommu_domain_alloc,
> @@ -4702,6 +4733,7 @@ const struct iommu_ops intel_iommu_ops = {
>   		.iova_to_phys		= intel_iommu_iova_to_phys,
>   		.free			= intel_iommu_domain_free,
>   		.enforce_cache_coherency = intel_iommu_enforce_cache_coherency,
> +		.set_dev_pasid		= intel_iommu_set_dev_pasid,
>   	}
>   };
>   

Best regards,
baolu
