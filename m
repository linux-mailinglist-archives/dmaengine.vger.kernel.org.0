Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF305241E2
	for <lists+dmaengine@lfdr.de>; Thu, 12 May 2022 03:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344245AbiELBQZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 May 2022 21:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343712AbiELBQY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 May 2022 21:16:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A4224969;
        Wed, 11 May 2022 18:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652318183; x=1683854183;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PjnwnCvMOfrROyLyIiruOlckwW/nR8ozbPMZ/HEaMUk=;
  b=B+V4rsi0p0Vghm9os1P9g36voYpMeU+xMuvye8zQKfa1MmgxAxgRzEBM
   QvbAjm/uEp5+RS89pIKfeoiSvFwek1MofmUaZvLPPNMkeKbZMkD53BKXl
   JpetGhPGSVY6Z6FGK3K7h9MywXlzjRxfn0zwdj7QIek85iiKXJwyve/fR
   UepxPxzGRiMUX7cOWNCU92vXMa4TgyZ3Xis0EjQ79qVjR0eTfbc7yb8su
   y82jD0rW/j0mCnzb8dsJEDAESyYfZgrP0+MAkP2ZBb2XVJY7gXSs/Hg6d
   DrPuu7D/3+70usi6ev2+HSIc4YFwSJC9A+RrQQfgWl7/NZxNd2N+hVa93
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="269986305"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="269986305"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 18:16:23 -0700
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="594415841"
Received: from hezhu1-mobl1.ccr.corp.intel.com (HELO [10.255.29.168]) ([10.255.29.168])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 18:16:19 -0700
Message-ID: <00a972f4-1fe2-2eb0-fcf5-d454f3b9dcc6@linux.intel.com>
Date:   Thu, 12 May 2022 09:16:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        vkoul@kernel.org, robin.murphy@arm.com, will@kernel.org,
        Yi Liu <yi.l.liu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v3 1/4] iommu/vt-d: Implement domain ops for
 attach_dev_pasid
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20220510210704.3539577-1-jacob.jun.pan@linux.intel.com>
 <20220510210704.3539577-2-jacob.jun.pan@linux.intel.com>
 <20220510232121.GP49344@nvidia.com> <20220510172309.3c4e7512@jacob-builder>
 <20220511115427.GU49344@nvidia.com> <20220511082958.79d5d8ee@jacob-builder>
 <20220511161237.GB49344@nvidia.com> <20220511100216.7615e288@jacob-builder>
 <20220511170025.GF49344@nvidia.com> <20220511102521.6b7c578c@jacob-builder>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220511102521.6b7c578c@jacob-builder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2022/5/12 01:25, Jacob Pan wrote:
> Hi Jason,
> 
> On Wed, 11 May 2022 14:00:25 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
>> On Wed, May 11, 2022 at 10:02:16AM -0700, Jacob Pan wrote:
>>>>> If not global, perhaps we could have a list of pasids (e.g. xarray)
>>>>> attached to the device_domain_info. The TLB flush logic would just
>>>>> go through the list w/o caring what the PASIDs are for. Does it
>>>>> make sense to you?
>>>>
>>>> Sort of, but we shouldn't duplicate xarrays - the group already has
>>>> this xarray - need to find some way to allow access to it from the
>>>> driver.
>>>>    
>>> I am not following,  here are the PASIDs for devTLB flush which is per
>>> device. Why group?
>>
>> Because group is where the core code stores it.
> I see, with singleton group. I guess I can let dma-iommu code call
> 
> iommu_attach_dma_pasid {
> 	iommu_attach_device_pasid();
> Then the PASID will be stored in the group xa.
> The flush code can retrieve PASIDs from device_domain_info.device -> group
> -> pasid_array.
> Thanks for pointing it out, I missed the new pasid_array.
>>
>>> We could retrieve PASIDs from the device PASID table but xa would be
>>> more efficient.
>>>    
>>>>>>> Are you suggesting the dma-iommu API should be called
>>>>>>> iommu_set_dma_pasid instead of iommu_attach_dma_pasid?
>>>>>>
>>>>>> No that API is Ok - the driver ops API should be 'set' not
>>>>>> attach/detach
>>>>> Sounds good, this operation has little in common with
>>>>> domain_ops.dev_attach_pasid() used by SVA domain. So I will add a
>>>>> new domain_ops.dev_set_pasid()
>>>>
>>>> What? No, their should only be one operation, 'dev_set_pasid' and it
>>>> is exactly the same as the SVA operation. It configures things so that
>>>> any existing translation on the PASID is removed and the PASID
>>>> translates according to the given domain.
>>>>
>>>> SVA given domain or UNMANAGED given domain doesn't matter to the
>>>> higher level code. The driver should implement per-domain ops as
>>>> required to get the different behaviors.
>>> Perhaps some code to clarify, we have
>>> sva_domain_ops.dev_attach_pasid() = intel_svm_attach_dev_pasid;
>>> default_domain_ops.dev_attach_pasid() = intel_iommu_attach_dev_pasid;
>>
>> Yes, keep that structure
>>   
>>> Consolidate pasid programming into dev_set_pasid() then called by both
>>> intel_svm_attach_dev_pasid() and intel_iommu_attach_dev_pasid(), right?
>>>   
>>
>> I was only suggesting that really dev_attach_pasid() op is misnamed,
>> it should be called set_dev_pasid() and act like a set, not a paired
>> attach/detach - same as the non-PASID ops.
>>
> Got it. Perhaps another patch to rename, Baolu?

Yes. I can rename it in my sva series if others are also happy with this
naming.

Best regards,
baolu
