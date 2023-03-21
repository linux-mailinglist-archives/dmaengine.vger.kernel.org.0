Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0E46C29F8
	for <lists+dmaengine@lfdr.de>; Tue, 21 Mar 2023 06:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjCUFoS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Mar 2023 01:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCUFoR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Mar 2023 01:44:17 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9EB1589F;
        Mon, 20 Mar 2023 22:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679377456; x=1710913456;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aYKfSTlUBleYkVyElMNA3zlWKwAfGp8fUVwgAyZJIkA=;
  b=YBkpovjt8h4SpfYp15oKHgfnfzUM0A8n8IG+2gXa1XtQKRKaBLt7tSnQ
   1RMWMKgJcZfOzKgCrCCFq8Xai+diIriYTuuTiMxh98g2OCjwJi+v29tDl
   +or5MT7Qddxp7Pr+XWbpdU52JtYm+50GKC/C8+VfKxhXQ+S7CyVgF1lG/
   BgfGdntJK+W2KuFwaGkIOmIy/DxkqLJabwPvb5JZVT/6K4Yop+XvXUWB6
   juYXVyTNq/nhpM+K+fLgBqd7HHeXXYCid5NekQLiPvZbJUUTRGXKPi4w7
   NZKauTCApeRZz/Jl1GFgllcQf7rGe+aOsqG5sehS9HjjoC9zRn24uLHO2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="340397929"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="340397929"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 22:44:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="791933553"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="791933553"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga002.fm.intel.com with ESMTP; 20 Mar 2023 22:44:11 -0700
Message-ID: <9c5d1951-5475-863b-b258-1a4cbc242f0b@linux.intel.com>
Date:   Tue, 21 Mar 2023 13:43:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        dmaengine@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iommu/vt-d: Allow SVA with device-specific IOPF
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20230309025639.26109-1-baolu.lu@linux.intel.com>
 <20230309025639.26109-3-baolu.lu@linux.intel.com>
 <20230320090006.180efbed@jacob-builder>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230320090006.180efbed@jacob-builder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 3/21/23 12:00 AM, Jacob Pan wrote:
> Hi BaoLu,

Hi Jacob,

> 
> On Thu,  9 Mar 2023 10:56:36 +0800, Lu Baolu<baolu.lu@linux.intel.com>
> wrote:
> 
>> Currently enabling SVA requires IOPF support from the IOMMU and device
>> PCI PRI. However, some devices can handle IOPF by itself without ever
>> sending PCI page requests nor advertising PRI capability.
>>
>> Allow SVA support with IOPF handled either by IOMMU (PCI PRI) or device
>> driver (device-specific IOPF). As long as IOPF could be handled, SVA
>> should continue to work.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 7c2f4bd33582..d2fcab9d8f61 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -4650,7 +4650,18 @@ static int intel_iommu_enable_sva(struct device
>> *dev) if (!(iommu->flags & VTD_FLAG_SVM_CAPABLE))
>>   		return -ENODEV;
>>   
>> -	if (!info->pasid_enabled || !info->pri_enabled ||
>> !info->ats_enabled)
>> +	if (!info->pasid_enabled)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * Devices having device-specific I/O fault handling should not
>> +	 * support PCI/PRI.
>> +	 */
>> +	if (!info->pri_supported)
>> +		return 0;
> If you put this check at the very beginning, everything else should it be
> the same, right?

Even for device specific IOPF, PASID/ATS are still required on the IOMMU
side.

> 
> Still feel a little weird that, SVA is tied to PRI for PCI PRI but not for
> device specific IOPF.

PCI PRI and device specific IOPF *should* be equivalent. But the IOMMU
side has no means to check the capability of device-specific IOPF.
Therefore, IOMMU can only default that if the device driver enables SVA
on a non-PRI device, it will handle IOPF in its own way.

Best regards,
baolu
