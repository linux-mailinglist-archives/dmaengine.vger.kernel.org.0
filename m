Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E270F70AC9E
	for <lists+dmaengine@lfdr.de>; Sun, 21 May 2023 08:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjEUGWP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 21 May 2023 02:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEUGWP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 21 May 2023 02:22:15 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F71011F;
        Sat, 20 May 2023 23:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684650132; x=1716186132;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j6etV54vLDYQsk7EaR3zrPLZ624iGEMcadQ9BAL8R8Y=;
  b=DS07kCbVsvIWf2qu8WJu4WYwTrYzkbKJRUoGpGBocCOr9ImjdOnPUI2Y
   HrwEGyz6/mXnaAGRcqFI8qhwnHRG3GpvyAjTW1M6BGPGhjkloE1jfnXGa
   M0LnGm7O7uBQApSfLWPPfN19aWHeKWBPbUb98fzuNaNfZjs3O8pwL9JfU
   SsRyPbZRDD4/EVMRCJ537oGG3fBY2gDScC7TBiOSVI0bDgzGWX37j1I5D
   8KVgWckpChDEdXS9OU1spGMANcPZ72DwWkrucTwAG5dMn88vyE4ICbg5U
   BOV0bI6WJ5tk7ohMUDeNSoDZy3IkXk+RKXo/DwYfhHyrnq1mQbt939sp6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10716"; a="332282548"
X-IronPort-AV: E=Sophos;i="6.00,181,1681196400"; 
   d="scan'208";a="332282548"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2023 23:22:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10716"; a="1033113447"
X-IronPort-AV: E=Sophos;i="6.00,181,1681196400"; 
   d="scan'208";a="1033113447"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 20 May 2023 23:22:07 -0700
Message-ID: <b3c543e0-699a-0779-fdd9-b799c5230da0@linux.intel.com>
Date:   Sun, 21 May 2023 14:21:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        narayan.ranganathan@intel.com
Subject: Re: [PATCH v6 2/4] iommu: Move global PASID allocation from SVA to
 core
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org
References: <20230519203223.2777255-1-jacob.jun.pan@linux.intel.com>
 <20230519203223.2777255-3-jacob.jun.pan@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230519203223.2777255-3-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 5/20/23 4:32 AM, Jacob Pan wrote:
> Global PASID can be used beyond SVA. For example, drivers that use
> Intel ENQCMD to submit work must use global PASIDs in that PASID
> is stored in a per CPU MSR. When such device need to submit work
> for in-kernel DMA with PASID, it must allocate PASIDs from the same
> global number space to avoid conflict.
> 
> This patch moves global PASID allocation APIs from SVA to IOMMU APIs.
> Reserved PASIDs, currently only RID_PASID, are excluded from the global
> PASID allocation.
> 
> It is expected that device drivers will use the allocated PASIDs to
> attach to appropriate IOMMU domains for use.
> 
> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
> ---
> v6: explicitly exclude reserved a range from SVA PASID allocation
>      check mm PASID compatibility with device
> v5: move PASID range check inside API so that device drivers only pass
>      in struct device* (Kevin)
> v4: move dummy functions outside ifdef CONFIG_IOMMU_SVA (Baolu)
> ---
>   drivers/iommu/iommu-sva.c | 33 ++++++++++++++-------------------
>   drivers/iommu/iommu.c     | 24 ++++++++++++++++++++++++
>   include/linux/iommu.h     | 10 ++++++++++
>   3 files changed, 48 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 9821bc44f5ac..7fe8e977d8eb 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -10,33 +10,33 @@
>   #include "iommu-sva.h"
>   
>   static DEFINE_MUTEX(iommu_sva_lock);
> -static DEFINE_IDA(iommu_global_pasid_ida);
>   
>   /* Allocate a PASID for the mm within range (inclusive) */
> -static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
> +static int iommu_sva_alloc_pasid(struct mm_struct *mm, struct device *dev)
>   {
> +	ioasid_t pasid;
>   	int ret = 0;
>   
> -	if (min == IOMMU_PASID_INVALID ||
> -	    max == IOMMU_PASID_INVALID ||
> -	    min == 0 || max < min)
> -		return -EINVAL;
> -
>   	if (!arch_pgtable_dma_compat(mm))
>   		return -EBUSY;
>   
>   	mutex_lock(&iommu_sva_lock);
>   	/* Is a PASID already associated with this mm? */
>   	if (mm_valid_pasid(mm)) {
> -		if (mm->pasid < min || mm->pasid > max)
> -			ret = -EOVERFLOW;
> +		if (mm->pasid <= dev->iommu->max_pasids)
> +			goto out;
> +		dev_err(dev, "current mm PASID %d exceeds device range %d!",
> +			mm->pasid, dev->iommu->max_pasids);
> +		ret = -ERANGE;
>   		goto out;
>   	}

Nit: Above is just refactoring, so it's better to keep the code behavior
consistent. For example, no need to change the error# from -EOVERFLOW to
-ERANGE, and no need to leave a new kernel message.

Anyway, if you think these changes are helpful, it's better to have them
in separated patches.

In the end, perhaps we can simply have code like this:

	if (mm_valid_pasid(mm)) {
		if (mm->pasid > dev->iommu->max_pasids)
			ret = -EOVERFLOW;
		goto out;
	}

Others look good to me, with above addressed,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
