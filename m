Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D525771538B
	for <lists+dmaengine@lfdr.de>; Tue, 30 May 2023 04:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjE3CUG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 May 2023 22:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjE3CUF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 May 2023 22:20:05 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CFBF3;
        Mon, 29 May 2023 19:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685413204; x=1716949204;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lFYn7kOvp6cOxyKCTax16qx7apM/MziGizg65AamduI=;
  b=iDxsoZTFnXHDeTNNpTp+n9BFbS2no/ELA6LrZSvor+eGryRbf+AcFbP7
   wU7QJRcPeS8laSRX1ikU6Vx+kJMh8E0NSRYljHQmfJBlgsJhPWNHFjcGn
   7d+88Batd+N8TVllkVJJn485ByC1bPPTxsauSK0LbGUr8e2e/358zcZO7
   1UnaZclohYkvF/CZitm6UgV7bGbyeIbyNV2jVAYm17Ibi0rx02Nk7P7cb
   pqfuBIZouOzLR0AWA+ef/SMPi6md9pmn3jcx9YwgOTeQLvwJ0vYKyvXFN
   aKrFeyUBdTQcexAeaJGiShjPq1vqsGXywNpDNQOzkx/RwXAmSBozIqUb8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="418284089"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="418284089"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 19:20:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="880595918"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="880595918"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga005.jf.intel.com with ESMTP; 29 May 2023 19:19:58 -0700
Message-ID: <ba26db48-4102-d6bc-add8-5449423158ca@linux.intel.com>
Date:   Tue, 30 May 2023 10:19:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     baolu.lu@linux.intel.com, LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        dmaengine@vger.kernel.org, vkoul@kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
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
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20230519203223.2777255-1-jacob.jun.pan@linux.intel.com>
 <20230519203223.2777255-4-jacob.jun.pan@linux.intel.com>
 <ZHUBoBev2Vzp8nGF@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZHUBoBev2Vzp8nGF@nvidia.com>
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

On 5/30/23 3:48 AM, Jason Gunthorpe wrote:
> On Fri, May 19, 2023 at 01:32:22PM -0700, Jacob Pan wrote:
> 
>> @@ -4720,25 +4762,99 @@ static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
>>   static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>>   {
>>   	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
>> +	struct dev_pasid_info *curr, *dev_pasid = NULL;
>> +	struct dmar_domain *dmar_domain;
>>   	struct iommu_domain *domain;
>> +	unsigned long flags;
>>   
>> -	/* Domain type specific cleanup: */
>>   	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
>> -	if (domain) {
>> -		switch (domain->type) {
>> -		case IOMMU_DOMAIN_SVA:
>> -			intel_svm_remove_dev_pasid(dev, pasid);
>> -			break;
>> -		default:
>> -			/* should never reach here */
>> -			WARN_ON(1);
>> +	if (!domain)
>> +		goto out_tear_down;
>> +
>> +	/*
>> +	 * The SVA implementation needs to stop mm notification, drain the
>> +	 * pending page fault requests before tearing down the pasid entry.
>> +	 * The VT-d spec (section 6.2.3.1) also recommends that software
>> +	 * could use a reserved domain id for all first-only and pass-through
>> +	 * translations. Hence there's no need to call domain_detach_iommu()
>> +	 * in the sva domain case.
>> +	 */
>> +	if (domain->type == IOMMU_DOMAIN_SVA) {
>> +		intel_svm_remove_dev_pasid(dev, pasid);
>> +		goto out_tear_down;
>> +	}
> 
> But why don't you need to do all the other
> intel_pasid_tear_down_entry(), intel_svm_drain_prq() (which is
> misnamed) and other stuff from intel_svm_remove_dev_pasid() ?

Perhaps,

	if (domain->type == IOMMU_DOMAIN_SVA) {
		intel_svm_remove_dev_pasid(dev, pasid);
		return;
	}

?

> 
> There still seems to be waaay too much "SVM" in the PASID code.

This segment of code is destined to be temporary. From a long-term
perspective, I hope to move SVA specific staffs such as mm notification,
prq draining, etc. to the iommu core. They are generic rather than Intel
iommu specific.

After the code consolidation done, the code here will become simpler and
appealing. We just need to tear down the pasid entry.

> 
>> +static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
>> +				     struct device *dev, ioasid_t pasid)
>> +{
>> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
>> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>> +	struct intel_iommu *iommu = info->iommu;
>> +	struct dev_pasid_info *dev_pasid;
>> +	unsigned long flags;
>> +	int ret;
>> +
>> +	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
>> +		return -EOPNOTSUPP;
>> +
>> +	if (context_copied(iommu, info->bus, info->devfn))
>> +		return -EBUSY;
>> +
>> +	ret = prepare_domain_attach_device(domain, dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
>> +	if (!dev_pasid)
>> +		return -ENOMEM;
>> +
>> +	ret = domain_attach_iommu(dmar_domain, iommu);
>> +	if (ret)
>> +		goto out_free;
>> +
>> +	if (domain_type_is_si(dmar_domain))
>> +		ret = intel_pasid_setup_pass_through(iommu, dmar_domain,
>> +						     dev, pasid);
>> +	else if (dmar_domain->use_first_level)
>> +		ret = domain_setup_first_level(iommu, dmar_domain,
>> +					       dev, pasid);
>> +	else
>> +		ret = intel_pasid_setup_second_level(iommu, dmar_domain,
>> +						     dev, pasid);
> 
> It would be nice if the different domain types had their own ops..

Good suggestion!

We can add a domain ops in the Intel domain structure which is
responsible for how to install an Intel iommu domain onto the VT-d
hardware.

It worth a separated refactoring series. Let me do it afterward.

Best regards,
baolu
