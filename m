Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA03568CF7F
	for <lists+dmaengine@lfdr.de>; Tue,  7 Feb 2023 07:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjBGGax (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Feb 2023 01:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBGGax (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Feb 2023 01:30:53 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA402684A;
        Mon,  6 Feb 2023 22:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675751452; x=1707287452;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XGpDqMmlKTFoQbf8f87+7luNAIUv19q3bV8zMHyUdOc=;
  b=LvRw6D88hGad0Mf9+0rWSdPPJ64d0zwPW/dgx3+83RvkQMFGouLTqqQi
   3js36AA81icYYejqEPrKkpNi/1oT1rlMJR1QBrA7ftTVj5bwB4wQSxPnf
   WN+kwYwu9PNqE00yeeBxwJsUQGzEyzNuPjHUh3iYuN48bj9Q2Euqq1VU/
   sK9d5uJvV+Lik3prOQJa+btOfELNn2ozOzYnCqtm+Lc8TkmoVMAfjEf4h
   2u68wvQOdAlV9NFubnm3xtJcpVyDwda384Fi7A1wbGrvGg6/zcyHfs9nG
   7AQKffcOnbOgOm7VpelZuexWou+IA7fvSW7gqoio8PWRyXd1zA+Ef1ZLE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="313070482"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="313070482"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 22:30:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="699128077"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="699128077"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.209.26]) ([10.254.209.26])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 22:30:48 -0800
Message-ID: <615663e4-59e8-deec-93ab-8d2ebd2f35b7@linux.intel.com>
Date:   Tue, 7 Feb 2023 14:30:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iommu/vt-d: Move iopf code from SVA to IOPF enabling
 path
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
References: <20230203084456.469641-1-baolu.lu@linux.intel.com>
 <20230203084456.469641-2-baolu.lu@linux.intel.com>
 <BN9PR11MB527659435BA073B21A1291588CDA9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527659435BA073B21A1291588CDA9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2023/2/6 11:28, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Friday, February 3, 2023 4:45 PM
>>
>> Generally enabling IOMMU_DEV_FEAT_SVA requires
>> IOMMU_DEV_FEAT_IOPF, but
>> some devices manage I/O Page Faults themselves instead of relying on the
>> IOMMU. Move IOPF related code from SVA to IOPF enabling path to make
>> the
>> driver work for devices that manage IOPF themselves.
>>
>> For the device drivers that relies on the IOMMU for IOPF through PCI/PRI,
>> IOMMU_DEV_FEAT_IOPF must be enabled before and disabled after
>> IOMMU_DEV_FEAT_SVA.
> 
> ARM still handles this differently:
> 
> arm_smmu_master_enable_sva()
>    arm_smmu_master_sva_enable_iopf():
> {
> 	/*
> 	 * Drivers for devices supporting PRI or stall should enable IOPF first.
> 	 * Others have device-specific fault handlers and don't need IOPF.
> 	 */
> 	if (!arm_smmu_master_iopf_supported(master))
> 		return 0;
> 
> 	if (!master->iopf_enabled)
> 		return -EINVAL;
> }
> 
> i.e. device specific IOPF is allowed only when PRI or stall is not supported.
> 
> it's different from what this patch does to allow device specific IOPF even
> when PRI is supported.
> 
> should we make them consistent given SVA/IOPF capabilities are general
> iommu definitions or fine to leave each iommu driver with different
> restriction?

Good point! I prefer the former. I will add a check in sva enabling path
and return failure if device supports PRI but not enabled (that
implies device has its specific IOPF handling).

> 
>>
>> -	ret = iopf_queue_add_device(iommu->iopf_queue, dev);
>> -	if (!ret)
>> -		ret = iommu_register_device_fault_handler(dev,
>> iommu_queue_iopf, dev);
>> -
>> -	return ret;
>> +	return 0;
>>   }
> 
> here and below...
> 
>> +	ret = iopf_queue_add_device(info->iommu->iopf_queue, dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf,
>> dev);
>> +	if (ret)
>> +		iopf_queue_remove_device(info->iommu->iopf_queue, dev);
>> +
>> +	return ret;
>>   }
> 
> ...indicate a bug fix on error handling. better to have the fix as
> a separate patch and then move code.
> 

Yes. I will post a fix patch before this move.

Best regards,
baolu
