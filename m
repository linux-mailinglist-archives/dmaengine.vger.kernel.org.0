Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6156CD1FD
	for <lists+dmaengine@lfdr.de>; Wed, 29 Mar 2023 08:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjC2GSF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Mar 2023 02:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjC2GSE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Mar 2023 02:18:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCBD211B;
        Tue, 28 Mar 2023 23:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680070677; x=1711606677;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gVnHv8TxASbwyC2M6m+IsgDfGT5ehk6AjvnH2JDmsGY=;
  b=hPTR791UspPNh2qTiqXDG6/7Im+xC/XRUNDJu/zgeMshhF2SBPZOoWeK
   0VVPkb1Wc4wNTyGdHRz1hRfZuK8vyJijGa4ds5zB3oKCVS4+HHHzAaL3N
   K1c41xqla0Z7bW2T7I9xvjIwRY3ks+LIEXgHzSRgrDDd4NzHdM2012L4I
   +EhKUHIbcsZ6kst6KqYngty5mcr0o1hi0c/m+shP0zVRqmawKrTA32sC7
   pVgnDF0hAVjy5J9Me47XzdHsorj31BHbzaQWhwYXDS/iahKGQMMH9Vnby
   LSYVWJekrEebxHPDh0xszsrArZzWdw0IfYjXh84NhhRpQObL7n1HMdqqI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320442803"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="320442803"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 23:17:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="808080264"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="808080264"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga004.jf.intel.com with ESMTP; 28 Mar 2023 23:17:52 -0700
Message-ID: <a51088f8-6d63-5a22-817f-602c83a648ed@linux.intel.com>
Date:   Wed, 29 Mar 2023 14:18:10 +0800
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
Subject: Re: [PATCH v2 5/8] iommu/vt-d: Make device pasid attachment explicit
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
 <20230327232138.1490712-6-jacob.jun.pan@linux.intel.com>
 <71b60cc2-4ab0-3777-6bc9-3a6a4174f743@linux.intel.com>
 <BN9PR11MB5276BCF726D0B813046479A18C889@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276BCF726D0B813046479A18C889@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 3/28/23 3:44 PM, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, March 28, 2023 1:49 PM
>>
>> On 3/28/23 7:21 AM, Jacob Pan wrote:
>>> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
>>> index 65b15be72878..b6c26f25d1ba 100644
>>> --- a/drivers/iommu/intel/iommu.h
>>> +++ b/drivers/iommu/intel/iommu.h
>>> @@ -595,6 +595,7 @@ struct dmar_domain {
>>>
>>>    	spinlock_t lock;		/* Protect device tracking lists */
>>>    	struct list_head devices;	/* all devices' list */
>>> +	struct list_head dev_pasids;	/* all attached pasids */
>>>
>>>    	struct dma_pte	*pgd;		/* virtual address */
>>>    	int		gaw;		/* max guest address width */
>>> @@ -708,6 +709,7 @@ struct device_domain_info {
>>>    	u8 ats_supported:1;
>>>    	u8 ats_enabled:1;
>>>    	u8 dtlb_extra_inval:1;	/* Quirk for devices need extra flush */
>>> +	u8 dev_attached:1;	/* Device context activated */
>>>    	u8 ats_qdep;
>>>    	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
>>>    	struct intel_iommu *iommu; /* IOMMU used by this device */
>>> @@ -715,6 +717,12 @@ struct device_domain_info {
>>>    	struct pasid_table *pasid_table; /* pasid table */
>>>    };
>>>
>>> +struct device_pasid_info {
>>> +	struct list_head link_domain;	/* link to domain siblings */
>>> +	struct device *dev;		/* physical device derived from */
>>> +	ioasid_t pasid;			/* PASID on physical device */
>>> +};
>>
>> The dev_pasids list seems to be duplicate with iommu_group::pasid_array.
>>
>> The pasid_array is de facto per-device as the PCI subsystem requires ACS
>> to be enabled on the upstream path to the root port.
>>
>> pci_enable_pasid():
>> 385         if (!pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR | PCI_ACS_UF))
>> 386                 return -EINVAL;
>>
>> For such PCI topology, pci_device_group() always assigns an exclusive
>> iommu group (a.k.a. singleton group).
>>
>> So, how about moving the pasid_array from struct iommu_group to struct
>> dev_iommu? With this refactoring, the individual iommu driver has no
>> need to create their own pasid array or list.
>>
>> Instead of using iommu_group::mutex, perhaps the pasid_array needs its
>> own lock in struct dev_iommu after moving.
>>
> 
> What you suggested is a right thing and more friendly to pasid attach
> in iommufd [1].
> 
> but dev_pasids list here is a different thing. It tracks which [device, pasid]
> is attached to the domain. w/o this information you'll have to walk the
> pasid_array of every attached device under the domain and search for
> every pasid entry pointing to the said domain. It's very inefficient.
> 
> of course if this can be done more generally it'd be nice.😊
> 
> [1] https://lore.kernel.org/linux-iommu/ZAjbDxSzxYPqSCjo@nvidia.com/

Ah, yes. You are right. I was confused.

Best regards,
baolu
