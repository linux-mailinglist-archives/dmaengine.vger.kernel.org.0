Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6205A6D57F1
	for <lists+dmaengine@lfdr.de>; Tue,  4 Apr 2023 07:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjDDFYk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Apr 2023 01:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjDDFYj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Apr 2023 01:24:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD511BF3;
        Mon,  3 Apr 2023 22:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680585878; x=1712121878;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/rQChDDRaigJECGMBoQaK+on5fRAcrFk8WAsiIoHF2g=;
  b=cIZ+ad/u1nh9GRAKEqTgQUExryUHDhG2u+007xnGAOiuSRtDNfb0VAhu
   XyRCaZMLdwAHahWFBK0as1fm9nOOkiVvOg9g9X8JQZvO9Id2cckzU8wsP
   PUYmsWKJN/3WrsoLMP9UDmsoe9UO0RF9CCXBuy8uPluleeZ7v5SO6UfOj
   XERlgZPhf/rlkEpb1QpRFbjn9W9x2SgLCSDOrHQ529EWoU78xrbgxk3ck
   u/YrdILiItzTAZXQ6W/lXwJTyx02u98LdQY32DeLcS1JB/uR9vuIWo15U
   nOqiY4xj8nvq21iA379CZ5WWx0xTW7lUKjuaRpDbK4u69HAdNOMelQhKv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="407153330"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="407153330"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 22:24:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="810095617"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="810095617"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga004.jf.intel.com with ESMTP; 03 Apr 2023 22:24:33 -0700
Message-ID: <505a0392-57e0-312b-9350-36162e84577c@linux.intel.com>
Date:   Tue, 4 Apr 2023 13:24:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc:     baolu.lu@linux.intel.com, LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH v3 6/7] iommu/vt-d: Implement set_dev_pasid domain op
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20230331231137.1947675-1-jacob.jun.pan@linux.intel.com>
 <20230331231137.1947675-7-jacob.jun.pan@linux.intel.com>
 <a63e70cc-8890-bb99-3326-0b19e81ea92e@linux.intel.com>
 <20230403144827.7b2c1ccb@jacob-builder>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230403144827.7b2c1ccb@jacob-builder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 4/4/23 5:48 AM, Jacob Pan wrote:
> On Sat, 1 Apr 2023 21:48:36 +0800, Baolu Lu<baolu.lu@linux.intel.com>
> wrote:
> 
>> On 2023/4/1 7:11, Jacob Pan wrote:
>>> Devices that use ENQCMDS to submit work on buffers mapped by DMA API
>>> must attach a PASID to the default domain of the device. In preparation
>>> for this use case, this patch implements set_dev_pasid() for the
>>> default_domain_ops.
>>>
>>> If the device context has not been set up prior to this call, this will
>>> set up the device context in addition to PASID attachment.
>>>
>>> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
>>> ---
>>>    drivers/iommu/intel/iommu.c | 21 +++++++++++++++++++++
>>>    1 file changed, 21 insertions(+)
>>>
>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>> index 52b9d0d3a02c..1ad9c5a4bd8f 100644
>>> --- a/drivers/iommu/intel/iommu.c
>>> +++ b/drivers/iommu/intel/iommu.c
>>> @@ -4784,6 +4784,26 @@ static void intel_iommu_remove_dev_pasid(struct
>>> device *dev, ioasid_t pasid) domain_detach_iommu(dmar_domain,
>>> info->iommu); }
>>>    
>>> +static int intel_iommu_attach_device_pasid(struct iommu_domain *domain,
>>> +					   struct device *dev,
>>> ioasid_t pasid) +{
>>> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
>>> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>>> +	struct intel_iommu *iommu = info->iommu;
>>> +	int ret;
>>> +
>>> +	if (!pasid_supported(iommu))
>>> +		return -ENODEV;
>> As the domain ID will be set to the pasid entry, need to get a refcount
>> of the domain ID. Call domain_attach_iommu() here, and release it after
>> the pasid entry is torn down.
> dmar_domain_attach_device_pasid() below will call domain_attach_iommu() and
> release in intel_iommu_remove_dev_pasid(). The previous patch has
> consolidated the code path with device attachment.
> would it be sufficient?

It's fine. Sorry, I overlooked this.

Best regards,
baolu
