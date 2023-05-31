Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF0E7174AB
	for <lists+dmaengine@lfdr.de>; Wed, 31 May 2023 06:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjEaEEN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 31 May 2023 00:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbjEaEEL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 31 May 2023 00:04:11 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5675010E;
        Tue, 30 May 2023 21:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685505850; x=1717041850;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WHj2RuuzQ5MIhm5hULZNZ/8NBi6foHkjop6klLlJc2w=;
  b=lavY90dn6lWjEzDmQP5i9X8vqe312UywDRr6TPB+5inYb5c+ML+dZxv6
   5GaBCPs7CLfu1/DSMDtjkaWWZZK49BZ4VOL7hmYFzhOE6mFhB5AV+p097
   qUAKJIAmAM5JuYroL/1cxAYorI6OPyALlEh0ltG2dlYF5tHRyMoGwngwb
   76Et+7f2W0Muill5AtYJyX+MrLbzgkdd1a9IxJnbavEAfdy8DtDa7DQwZ
   LUoRDP7OGavTnGYerbn1XwPUMTq1THpTbNmMj7XGw0/vFkA54f0tGWMBD
   EHMFEnnTTk17cL0UJlclPEX3O98aJQFwv6oGpn8I3/jJLZz8aSNlA3/Ib
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="335477389"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="335477389"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 21:03:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="881013685"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="881013685"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga005.jf.intel.com with ESMTP; 30 May 2023 21:03:03 -0700
Message-ID: <325046c8-cfc3-c42a-0b39-bafc1acae800@linux.intel.com>
Date:   Wed, 31 May 2023 12:02:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     baolu.lu@linux.intel.com,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        narayan.ranganathan@intel.com
Subject: Re: [PATCH v6 3/4] iommu/vt-d: Add set_dev_pasid callback for dma
 domain
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20230519203223.2777255-1-jacob.jun.pan@linux.intel.com>
 <20230519203223.2777255-4-jacob.jun.pan@linux.intel.com>
 <ZHUBoBev2Vzp8nGF@nvidia.com>
 <ba26db48-4102-d6bc-add8-5449423158ca@linux.intel.com>
 <ZHYqebpMC12ck6gQ@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZHYqebpMC12ck6gQ@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 5/31/23 12:55 AM, Jason Gunthorpe wrote:
> On Tue, May 30, 2023 at 10:19:05AM +0800, Baolu Lu wrote:
>> On 5/30/23 3:48 AM, Jason Gunthorpe wrote:
>>> On Fri, May 19, 2023 at 01:32:22PM -0700, Jacob Pan wrote:
>>>
>>>> @@ -4720,25 +4762,99 @@ static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
>>>>    static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>>>>    {
>>>>    	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
>>>> +	struct dev_pasid_info *curr, *dev_pasid = NULL;
>>>> +	struct dmar_domain *dmar_domain;
>>>>    	struct iommu_domain *domain;
>>>> +	unsigned long flags;
>>>> -	/* Domain type specific cleanup: */
>>>>    	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
>>>> -	if (domain) {
>>>> -		switch (domain->type) {
>>>> -		case IOMMU_DOMAIN_SVA:
>>>> -			intel_svm_remove_dev_pasid(dev, pasid);
>>>> -			break;
>>>> -		default:
>>>> -			/* should never reach here */
>>>> -			WARN_ON(1);
>>>> +	if (!domain)
>>>> +		goto out_tear_down;
>>>> +
>>>> +	/*
>>>> +	 * The SVA implementation needs to stop mm notification, drain the
>>>> +	 * pending page fault requests before tearing down the pasid entry.
>>>> +	 * The VT-d spec (section 6.2.3.1) also recommends that software
>>>> +	 * could use a reserved domain id for all first-only and pass-through
>>>> +	 * translations. Hence there's no need to call domain_detach_iommu()
>>>> +	 * in the sva domain case.
>>>> +	 */
>>>> +	if (domain->type == IOMMU_DOMAIN_SVA) {
>>>> +		intel_svm_remove_dev_pasid(dev, pasid);
>>>> +		goto out_tear_down;
>>>> +	}
>>>
>>> But why don't you need to do all the other
>>> intel_pasid_tear_down_entry(), intel_svm_drain_prq() (which is
>>> misnamed) and other stuff from intel_svm_remove_dev_pasid() ?
>>
>> Perhaps,
>>
>> 	if (domain->type == IOMMU_DOMAIN_SVA) {
>> 		intel_svm_remove_dev_pasid(dev, pasid);
>> 		return;
>> 	}
>>
>> ?
> 
> I would expect only stuff directly connected to SVM be in the SVM
> function.
> 
> De-initalizing PRI and any other pasid destruction should be in this
> function.
> 
>>> There still seems to be waaay too much "SVM" in the PASID code.
>>
>> This segment of code is destined to be temporary. From a long-term
>> perspective, I hope to move SVA specific staffs such as mm notification,
>> prq draining, etc. to the iommu core. They are generic rather than Intel
>> iommu specific.
> 
> Yes, sort of, but.. That is just the mmu notifier bits
> 
> All the PRI/PASID teardown needs to be unlinked from SVM

Get your point now. Yes. PRI and PASID teardown are not SVA-specific.
Sorry that we should rename SVM to SVA to unify the Linux terminology.

> 
>>> It would be nice if the different domain types had their own ops..
>>
>> Good suggestion!
>>
>> We can add a domain ops in the Intel domain structure which is
>> responsible for how to install an Intel iommu domain onto the VT-d
>> hardware.
> 
> We should have seperate iommu_domain_ops at least, I think that would
> cover alot of it?

Are you suggesting adding this ops in common iommu_domain or intel's
dmar_domain? My understanding is the latter. To do so, probably we need
to define various callbacks for different type of domains: identity,
blocking, dma remapping, sva and possibly nested. Also need to care
about legacy vs. scalable mode.

That's the reason why I hoped to do all these in separated series with
carefully reviewing and testing.

Best regards,
baolu
