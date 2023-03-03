Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC43C6A9046
	for <lists+dmaengine@lfdr.de>; Fri,  3 Mar 2023 05:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjCCEjY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Mar 2023 23:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCCEjX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Mar 2023 23:39:23 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CE715164;
        Thu,  2 Mar 2023 20:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677818359; x=1709354359;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yNOI4nJugovqnnUp7wrS9ogZ5UJYBWs7h9XxbeIA6N8=;
  b=DJK31nZdT1AmlPtZFXdTzXVFzrC3ZouWQVQpeFjAPrJ0VBKOVrnU/Whf
   YoeKGUIy71IFc+gvY3tJy+olctMuYi9Lbk0wIfcGzaw4M4I2aSQP1U3Bi
   41wsLsVTL012khAFkwvTIrU1n9B+QoyaL+uNXtxhppFi5//RgVc81WckM
   n/359UUUyZy20QG02Y/j1ItU6+xRtIdb0ka1P7/pguYBmeMeUchb52qQW
   tHwbDloUe/CD/sZeNLJY2EP6ue/C5XjaAgBLDZQZaXUXSLN+MmUrNv0Dr
   fklpfb6P64/6bDCR++LMK9k8q0Y3k4jeLyILChhzRcLca8cnMlwcyIZRM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="333675265"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="333675265"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 20:39:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="744126383"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="744126383"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga004.fm.intel.com with ESMTP; 02 Mar 2023 20:39:14 -0800
Message-ID: <7f8983c8-b703-4960-67b5-97f4053329db@linux.intel.com>
Date:   Fri, 3 Mar 2023 12:38:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH 1/4] iommu/vt-d: Implement set device pasid op for default
 domain
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
 <20230302005959.2695267-2-jacob.jun.pan@linux.intel.com>
 <fad7f28f-b4e8-c1c3-4ca4-a48c5c6d7f4a@linux.intel.com>
 <BN9PR11MB52762957011E60E935E82CC88CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <2c9115d0-f251-c284-63d6-73714edc96b4@linux.intel.com>
 <BN9PR11MB527634EA1ED5067D1FC0D7C68CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527634EA1ED5067D1FC0D7C68CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 3/3/23 11:02 AM, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Friday, March 3, 2023 10:49 AM
>>
>> On 3/3/23 10:36 AM, Tian, Kevin wrote:
>>>> From: Baolu Lu <baolu.lu@linux.intel.com>
>>>> Sent: Thursday, March 2, 2023 10:07 PM
>>>>> +
>>>>> +	if (!sm_supported(iommu) || !info)
>>>>
>>>> @info has been referenced. !info check makes no sense.
>>>>
>>>> Add pasid_supported(iommu).
>>>>
>>>> Do you need to check whether the domain is compatible for this rid
>>>> pasid?
>>>
>>> what kind of compatibility is concerned here? In concept a pasid
>>> can be attached to any domain if it has been successfully attached
>>> to rid. Probably we can add a check here that RID2PASID must
>>> point to the domain already.
>>
>> "...if it has been successfully attached to rid..."
>>
>> We should not have this assumption in iommu driver's callback. The iommu
>> driver has no (and should not have) knowledge about the history of any
>> domain.
> 
> but this is an op for default domain which must have been attached
> to RID2PASID and any compatibility check between this domain and device
> should be passed.

This is an op for DMA, DMA-FQ and UNMANAGED domain. The IOMMU driver
doesn't need to interpret the default domain concept. :-)

> 
> We can have another set_pasid for unmanaged which then need similar
> check as prepare_domain_attach_device() does.

 From the perspective of the iommu driver, there's no essential
difference between DMA and UNMANAGED domains. So almost all IOMMU
drivers maintain a single set of domain ops for them.

>>
>>>
>>>>
>>>>> +		return -ENODEV;
>>>>> +
>>>>> +	if (WARN_ON(pasid == PASID_RID2PASID))
>>>>> +		return -EINVAL;
>>>>
>>>> Add a call to domain_attach_iommu() here to get a refcount of the
>> domain
>>>> ID. And call domain_detach_iommu() in
>> intel_iommu_remove_dev_pasid().
>>>>
>>>
>>> Is it necessary? iommu core doesn't allow taking ownership
>>> if !xa_empty(&group->pasid_array) so if this pasid attach succeeds
>>> this device cannot be attached to another domain before pasid
>>> detach is done on the current domain.
>>
>> It's not about the pasid, but the domain id.
>>
>> This domain's id will be set to a field of the device's pasid entry. It
>> must get a refcount of that domain id to avoid use after free.
>>
> 
> If the domain still has attached device (due to this pasid usage) how could
> domain id be freed?

The Intel IOMMU driver uses a user counter to determine when the domain
id could be freed.

Best regards,
baolu
