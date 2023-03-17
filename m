Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2016BDDC9
	for <lists+dmaengine@lfdr.de>; Fri, 17 Mar 2023 01:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjCQArn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Mar 2023 20:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCQArl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Mar 2023 20:47:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A84CA21BD;
        Thu, 16 Mar 2023 17:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679014061; x=1710550061;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ykYG82z5mHxoqH9AyNm4njZqoTQYz7loMeJ7mZo0a7o=;
  b=VyN5+pcw2NusjQ9TnPx79CThJFAHwmDG2Ye13qxhRd1xmK4/AYLhk7GZ
   zaQ7JEe4aZJscq2LPCw7fHSplsVp4s1mnUJ6Wz04/NvdQK7pJvw7Ws4u4
   T7JvayMcx4tvA/K22WH7GTgo7tvHNP6tGi+3WTnx5f8zwBL4w9CyqOtY4
   YSkDIAxFFZGJcgfu860K+pBdnlUuWtn+WXtOXcUE2Q8ZpJfO8cMbwk6wU
   SlFG43VpZpgBrK1Xv3seuLSk+BBsiuftS2mqKpv3ZhM4RW9c+HXboZ52j
   H95phtTZas7MCE/CJJsK3Ed5Jq9fDlzE900JO0vUuHYLON/h3nS0oFlgn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="338163899"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="338163899"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 17:47:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="744370389"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="744370389"
Received: from junjiego-mobl1.ccr.corp.intel.com (HELO [10.254.209.106]) ([10.254.209.106])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 17:47:38 -0700
Message-ID: <2e308d39-4f17-3b54-9f52-2b4b9ff7f951@linux.intel.com>
Date:   Fri, 17 Mar 2023 08:47:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] iommu/vt-d: Move PRI handling to IOPF feature path
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
References: <20230309025639.26109-1-baolu.lu@linux.intel.com>
 <20230309025639.26109-6-baolu.lu@linux.intel.com>
 <BN9PR11MB52766D4948FA00CB02D3F2188CBC9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4a9dd732-344d-64f3-0c9c-b21c196bf940@linux.intel.com>
 <BN9PR11MB527679AADCC5CA762C5BFAA68CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527679AADCC5CA762C5BFAA68CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2023/3/17 8:06, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Thursday, March 16, 2023 4:17 PM
>>
>> On 2023/3/16 15:17, Tian, Kevin wrote:
>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Sent: Thursday, March 9, 2023 10:57 AM
>>>>
>>>> @@ -4689,17 +4704,21 @@ static int intel_iommu_disable_iopf(struct
>> device
>>>> *dev)
>>>>    {
>>>>    	struct device_domain_info *info = dev_iommu_priv_get(dev);
>>>>    	struct intel_iommu *iommu = info->iommu;
>>>> -	int ret;
>>>>
>>>> -	ret = iommu_unregister_device_fault_handler(dev);
>>>> -	if (ret)
>>>> -		return ret;
>>>> +	if (!info->pri_enabled)
>>>> +		return -EINVAL;
>>>>
>>>> -	ret = iopf_queue_remove_device(iommu->iopf_queue, dev);
>>>> -	if (ret)
>>>> -		iommu_register_device_fault_handler(dev,
>>>> iommu_queue_iopf, dev);
>>>> +	pci_disable_pri(to_pci_dev(dev));
>>>> +	info->pri_enabled = 0;
>>>>
>>>> -	return ret;
>>>> +	/*
>>>> +	 * With pri_enabled checked, unregistering fault handler and
>>>> +	 * removing device from iopf queue should never fail.
>>>> +	 */
>>>> +	iommu_unregister_device_fault_handler(dev);
>>>> +	iopf_queue_remove_device(iommu->iopf_queue, dev);
>>>> +
>>>> +	return 0;
>>>>    }
>>>
>>> PCIe spec says that clearing the enable bit doesn't mean in-fly
>>> page requests are completed:
>>> --
>>> Enable (E) - This field, when set, indicates that the Page Request
>>> Interface is allowed to make page requests. If this field is Clear,
>>> the Page Request Interface is not allowed to issue page requests.
>>> If both this field and the Stopped field are Clear, then the Page
>>> Request Interface will not issue new page requests, but has
>>> outstanding page requests that have been transmitted or are
>>> queued for transmission
>>
>> Yes. So the iommu driver should drain the in-fly PRQs.
>>
>> The Intel VT-d implementation drains the PRQs when any PASID is unbound
>> from the iommu domain (see intel_svm_drain_prq()) before reuse. Before
>> disabling iopf, the device driver should unbind pasid and disable sva,
>> so when it comes here, the PRQ should have been drained.
>>
>> Perhaps I can add below comments to make this clear:
>>
>>           /*
>>            * PCIe spec states that by clearing PRI enable bit, the Page
>>            * Request Interface will not issue new page requests, but has
>>            * outstanding page requests that have been transmitted or are
>>            * queued for transmission. This is supposed to be called after
>>            * the device driver has stopped DMA, all PASIDs have been
>>            * unbound and the outstanding PRQs have been drained.
>>            */
>>
> 
> this is fine. But it should be a separate patch which removes
> check of return value. It's not caused by this PRI handling move
> patch.

Okay, that will be clearer.

Best regards,
baolu
