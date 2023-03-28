Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2386CB5C5
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 07:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjC1FK7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 01:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjC1FK6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 01:10:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F18D199A;
        Mon, 27 Mar 2023 22:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679980257; x=1711516257;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Un8dKs5y4eyj3uC1NIu/eO1SaITBeaVWV+VT0Cb7HVs=;
  b=bpgPwBmRBnp7Cd34fDnL6kmLmuwTfD6mlRKS+Q9w6H1D6qBYnkch6UeI
   GZxGD4MzQr3cDBqGl3vQSjr7oAGq01aPp3ptVYOEp1oMlTGHE7Hq+xhpd
   QU+RzdTaxb7BLsZ6DfAPnIRrvmk1jl1z2vpON1Gza0L81igriOSzDfuJ5
   7on7naAXGSEt2YMvWaFxmNpnc7upI7J0Krf9v8t1vg2XnsAXuimWaDcN6
   76+vbdCnlLwrSMsXhN3Tn7+dCJkppyaP9XOZS4jJbzvmqlthKY2wLGBhg
   vyoN+RaMj2QVNRBvt5hc9LB26Mq6WjopsX03Yvcg+PDoOE8TAbIXysBnC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="426737319"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="426737319"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 22:10:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="929721831"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="929721831"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga006.fm.intel.com with ESMTP; 27 Mar 2023 22:10:52 -0700
Message-ID: <e1e23af3-b627-ac5d-64d0-9547ed982dc4@linux.intel.com>
Date:   Tue, 28 Mar 2023 13:11:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH v2 3/8] iommu/sva: Support reservation of global SVA
 PASIDs
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
 <20230327232138.1490712-4-jacob.jun.pan@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230327232138.1490712-4-jacob.jun.pan@linux.intel.com>
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

On 3/28/23 7:21 AM, Jacob Pan wrote:
> Devices that use Intel ENQCMD to submit work must use global PASIDs in
> that the PASID are stored in a per CPU MSR. When such device need to
> submit work for in-kernel DMA with PASID, it must allocate PASIDs from
> the same global number space to avoid conflict.
> 
> This patch introduces IOMMU SVA APIs to reserve and release global PASIDs.
> It is expected that device drivers will use the allocated PASIDs to attach
> to appropriate IOMMU domains for use.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/iommu-sva.c | 33 +++++++++++++++++++++++++++++++++
>   include/linux/iommu.h     | 14 ++++++++++++++
>   2 files changed, 47 insertions(+)
> 
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index c434b95dc8eb..84b9de84b3e0 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -148,6 +148,39 @@ u32 iommu_sva_get_pasid(struct iommu_sva *handle)
>   }
>   EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
>   
> +/**
> + * @brief
> + *	Reserve a PASID from the SVA global number space.
> + *
> + * @param min starting range, inclusive
> + * @param max ending range, inclusive
> + * @return The reserved PASID on success or IOMMU_PASID_INVALID on failure.
> + */
> +ioasid_t iommu_sva_reserve_pasid(ioasid_t min, ioasid_t max)
> +{
> +	int ret;
> +
> +	if (!pasid_valid(min) || !pasid_valid(max) ||
> +	    min == 0 || max < min)

I still think we should make "min == 0" a valid case. The ARM/AMD/Intel
drivers should reserve PASID 0 for special usage with this interface.

Probably we should also make "min == max" a valid case. Both @min and
@max are inclusive.

> +		return IOMMU_PASID_INVALID;
> +
> +	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max, GFP_KERNEL);
> +	if (ret < 0)
> +		return IOMMU_PASID_INVALID;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_reserve_pasid);
> +
> +void iommu_sva_release_pasid(ioasid_t pasid)
> +{
> +	if (!pasid_valid(pasid))

The caller should never release an invalid pasid. So perhaps,

	if (WARN_ON(!pasid_valid(pasid)))
		return;

to discover bugs during development.

> +		return;
> +
> +	ida_free(&iommu_global_pasid_ida, pasid);
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_release_pasid);
> +
>   /*
>    * I/O page fault handler for SVA
>    */
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 54f535ff9868..0471089dc1d0 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1187,6 +1187,9 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev,
>   					struct mm_struct *mm);
>   void iommu_sva_unbind_device(struct iommu_sva *handle);
>   u32 iommu_sva_get_pasid(struct iommu_sva *handle);
> +ioasid_t iommu_sva_reserve_pasid(ioasid_t min, ioasid_t max);
> +void iommu_sva_release_pasid(ioasid_t pasid);
> +
>   #else
>   static inline struct iommu_sva *
>   iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
> @@ -1202,6 +1205,17 @@ static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
>   {
>   	return IOMMU_PASID_INVALID;
>   }
> +
> +static inline ioasid_t iommu_sva_reserve_pasid(ioasid_t min, ioasid_t max)
> +{
> +	return IOMMU_PASID_INVALID;
> +}
> +
> +static inline void iommu_sva_release_pasid(ioasid_t pasid)
> +{
> +
> +}
> +
>   static inline void mm_pasid_init(struct mm_struct *mm) {}
>   static inline void mm_pasid_drop(struct mm_struct *mm) {}
>   #endif /* CONFIG_IOMMU_SVA */

Best regards,
baolu
