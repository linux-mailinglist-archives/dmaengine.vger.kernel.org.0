Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4AE6DE903
	for <lists+dmaengine@lfdr.de>; Wed, 12 Apr 2023 03:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjDLBhu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Apr 2023 21:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjDLBht (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Apr 2023 21:37:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FBB127;
        Tue, 11 Apr 2023 18:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681263469; x=1712799469;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ata9j+ZswHLaGP/PHNwL4yocWtHRfpgEJsv6Q2EQZTk=;
  b=CH19JVrAzctTdPFY6rjbffgTL+NzoBwmsvR/bY7fSQaMsObMZrEZB1Ew
   ZoF40QNV6Z16K/uMGIG6rRnFCtTNiRCpcCPfwkIAveRQ0HXv8V9mN3Fv4
   nF3p1HnOn7UUO5/KRrn0LdNJzwzt+HL/GRANRQlgBI1yegxkn735K95S3
   Aog/X87TKofWvtaT0u4EhNA2C627aNRQDBLqqhksEwSg/wJVvsNdmzEw9
   xDmfkIW0W4MKtpTHejfqWlwNHfOu1bCuNMMiHVEyELKxcEhAxX/uGiEhv
   d09lD631Y6zEl3ZPK8KZ12zMDB4SJ2S496/vTq/72wmXZX+qX7eu5OKsM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="343781731"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="343781731"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 18:37:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="812799318"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="812799318"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga004.jf.intel.com with ESMTP; 11 Apr 2023 18:37:43 -0700
Message-ID: <5882ee52-9657-250d-0474-13edffa7b6b9@linux.intel.com>
Date:   Wed, 12 Apr 2023 09:37:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc:     baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH v4 3/7] iommu: Support allocation of global PASIDs outside
 SVA
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>
References: <20230407180554.2784285-1-jacob.jun.pan@linux.intel.com>
 <20230407180554.2784285-4-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB5276D09F18BA65AD074777948C9A9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276D09F18BA65AD074777948C9A9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 4/11/23 4:02 PM, Tian, Kevin wrote:
>> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Sent: Saturday, April 8, 2023 2:06 AM
>> @@ -28,8 +26,8 @@ static int iommu_sva_alloc_pasid(struct mm_struct
>> *mm, ioasid_t min, ioasid_t ma
>>   		goto out;
>>   	}
>>
>> -	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max,
>> GFP_KERNEL);
>> -	if (ret < min)
>> +	ret = iommu_alloc_global_pasid(min, max);
> 
> I wonder whether this can take a device pointer so dev->iommu->max_pasids
> is enforced inside the alloc function.

Agreed. Instead of using the open code, it looks better to have a helper
like dev_iommu_max_pasids().

> 
> and do we even need the min/max parameters? With special pasids reserved
> then what driver needs is just to get a free pasid from the global space within
> dev->iommu->max_pasids constraint...
> 
> iommu_sva_alloc_pasid() can be reworked to avoid min/max by taking a
> device pointer too.

Best regards,
baolu
