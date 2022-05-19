Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3312F52CC13
	for <lists+dmaengine@lfdr.de>; Thu, 19 May 2022 08:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbiESGlh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 May 2022 02:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbiESGlT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 May 2022 02:41:19 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42AB19F9B;
        Wed, 18 May 2022 23:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652942477; x=1684478477;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iZMFcG0XywxoHyOC1CFZNXhVD9jrMWWC6XRQyrV/69k=;
  b=LW+b4Wp6alZxE3GtZ05VmfMg6fv9k9QUAVb5vGhk3yl7frAHnR9iCMXj
   86ctvJTSKa0S1zO2J3RUKnJ8IpJpKObkvbSQehG0C46lKSwmhkjQavLSL
   7CJMbpv96PoQuPt5GD1Ovu2xMpLXbGMzY6SuCdO885lcdz9+Diuj/xArr
   Z+ixJISkVzpM+v6vY82XWwxgNQ3zAD4QGyzeHilHWJ2eQ0LXmPmwKGrSe
   msAqX9GxSRLqyq+4aoCUW8+ZityjYZhCHevzLSHJ0CJHC3kErP+VcFc9n
   uHI/7CUtQjGFa9N+/grATU+8S7YjQ1BAwcuJih5VKlKGPnUSuxFbWMDuf
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="335096289"
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; 
   d="scan'208";a="335096289"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 23:41:12 -0700
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; 
   d="scan'208";a="742749075"
Received: from zhongz9x-mobl.ccr.corp.intel.com (HELO [10.255.28.182]) ([10.255.28.182])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 23:41:08 -0700
Message-ID: <41c717e3-2965-67ac-9140-72f4b071cd9a@linux.intel.com>
Date:   Thu, 19 May 2022 14:41:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Cc:     baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v4 2/6] iommu: Add a helper to do PASID lookup from domain
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>, vkoul@kernel.org,
        robin.murphy@arm.com, will@kernel.org
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
 <20220518182120.1136715-3-jacob.jun.pan@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220518182120.1136715-3-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2022/5/19 02:21, Jacob Pan wrote:
> IOMMU group maintains a PASID array which stores the associated IOMMU
> domains. This patch introduces a helper function to do domain to PASID
> look up. It will be used by TLB flush and device-PASID attach verification.

Do you really need this?

The IOMMU driver has maintained a device tracking list for each domain.
It has been used for cache invalidation when unmap() is called against
dma domain.

Best regards,
baolu

> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/iommu.c | 22 ++++++++++++++++++++++
>   include/linux/iommu.h |  6 +++++-
>   2 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 00d0262a1fe9..22f44833db64 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3199,3 +3199,25 @@ struct iommu_domain *iommu_get_domain_for_iopf(struct device *dev,
>   
>   	return domain;
>   }
> +
> +ioasid_t iommu_get_pasid_from_domain(struct device *dev, struct iommu_domain *domain)
> +{
> +	struct iommu_domain *tdomain;
> +	struct iommu_group *group;
> +	unsigned long index;
> +	ioasid_t pasid = INVALID_IOASID;
> +
> +	group = iommu_group_get(dev);
> +	if (!group)
> +		return pasid;
> +
> +	xa_for_each(&group->pasid_array, index, tdomain) {
> +		if (domain == tdomain) {
> +			pasid = index;
> +			break;
> +		}
> +	}
> +	iommu_group_put(group);
> +
> +	return pasid;
> +}
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 36ad007084cc..c0440a4be699 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -694,7 +694,7 @@ void iommu_detach_device_pasid(struct iommu_domain *domain,
>   			       struct device *dev, ioasid_t pasid);
>   struct iommu_domain *
>   iommu_get_domain_for_iopf(struct device *dev, ioasid_t pasid);
> -
> +ioasid_t iommu_get_pasid_from_domain(struct device *dev, struct iommu_domain *domain);
>   #else /* CONFIG_IOMMU_API */
>   
>   struct iommu_ops {};
> @@ -1070,6 +1070,10 @@ iommu_get_domain_for_iopf(struct device *dev, ioasid_t pasid)
>   {
>   	return NULL;
>   }
> +static ioasid_t iommu_get_pasid_from_domain(struct device *dev, struct iommu_domain *domain)
> +{
> +	return INVALID_IOASID;
> +}
>   #endif /* CONFIG_IOMMU_API */
>   
>   #ifdef CONFIG_IOMMU_SVA

