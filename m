Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C167175F7
	for <lists+dmaengine@lfdr.de>; Wed, 31 May 2023 07:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjEaFAr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 31 May 2023 01:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjEaFAq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 31 May 2023 01:00:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BE4E5;
        Tue, 30 May 2023 22:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685509245; x=1717045245;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Mxzw9zYTykOHn7N954LEKaf1cblcwqFC37xLIQx1JMw=;
  b=hLBwIp6FaGA1OhR5JH78nCJ1c62INONwn5p2iz/NC/ZmbFW4cyVnMoIU
   5vqkv7KWZx7U4hL26t1yEaWfi7dkxZHtv9JstOFOv9ZwEhPoqAPgXKdRN
   xSV3pI1KcatakoOU/CdZD71v0iJfIjC/2PWfVAFfw2u+ViOElyoc360WD
   VZyERDvgX/dEW7wyUuYCU0fuQZm5Qsc8P75LXKzUpUX1izXhmPQrC8bQW
   WtFmCIuwxOzOYZYJbF9ChtmnrkINouWvYXlfmSwEAqCVRywRCkzbEO+RB
   CMhpt917Xt3vebSyeBQEH9ljzo/ED2Qmo2U/BgprW+kUYhzjV+8+Tz5xh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="357525020"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="357525020"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 22:00:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="684263058"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="684263058"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga006.jf.intel.com with ESMTP; 30 May 2023 22:00:39 -0700
Message-ID: <c5a1a51d-b309-4237-b2c5-fbdaa1f4f9a8@linux.intel.com>
Date:   Wed, 31 May 2023 12:59:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     baolu.lu@linux.intel.com,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Ranganathan, Narayan" <narayan.ranganathan@intel.com>
Subject: Re: [PATCH v7 3/4] iommu/vt-d: Add set_dev_pasid callback for dma
 domain
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
References: <20230523173451.2932113-1-jacob.jun.pan@linux.intel.com>
 <20230523173451.2932113-4-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB52760139A4844C8DF0EE1BE98C469@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZHYtkioNR2YfC18C@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZHYtkioNR2YfC18C@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 5/31/23 1:08 AM, Jason Gunthorpe wrote:
>>> +	/*
>>> +	 * The SVA implementation needs to stop mm notification, drain the
>>> +	 * pending page fault requests before tearing down the pasid entry.
>>> +	 * The VT-d spec (section 6.2.3.1) also recommends that software
>>> +	 * could use a reserved domain id for all first-only and pass-through
>>> +	 * translations. Hence there's no need to call
>>> domain_detach_iommu()
>>> +	 * in the sva domain case.
>>> +	 */
>>
>> It's probably clearer to say:
> 
> Is this what is going on ??
> 
>> /*
>>   * SVA domain requires special treatment before tearing down the pasid
>>   * entry:
>>   *   1) pasid is stored in mm instead of in dev_pasid;
> 
> Why? The mm pasid should not be used by any driver code, the PASID the
> SVA is hooked to does NOT have to be the mm PASID.

Yes. The individual driver should not be aware of mm->pasid. The
set/remove_dev_pasid callbacks have already take pasid as the inputs.

> 
>>   *   2) all SVA domains share a reserved domain id per recommendation
>>   *      from VT-d spec (section 6.2.3.1) so domain_detach_iommu() is
>>   *      not required;
> 
> The DID should be managed and allocated for the S2 pointer and the
> flushing logic should work genericly by tracking the S2's being used
> and flushing their DIDs when all the S2s fall out of use. The special
> identity S2 just gets a static DID that never falls out of use.

The DID logic in this case is not about invalidating the DID. Instead,
it is about managing the DID's reference count to track its allocation
and release. The reference count is increased every time the DID is
assigned to hardware, and it is decreased when the DID is removed from
hardware. The DID is released when the count hits 0.

Some DIDs are reserved for special domains, like identity domain, SVA
domain, etc. For those DIDs, there's no need for reference count, hence
no need to call the helper.

For code simplify, perhaps we can enhance the helpers to take no action
for those special DIDs.

Best regards,
baolu
