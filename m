Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD866E5746
	for <lists+dmaengine@lfdr.de>; Tue, 18 Apr 2023 04:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjDRCGV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Apr 2023 22:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjDRCGV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Apr 2023 22:06:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8388E6;
        Mon, 17 Apr 2023 19:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681783579; x=1713319579;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jrGahduSx1jTliqVgyAzSxB4f5ogqDMA2L/hqxkw/Es=;
  b=XzAT8vGo89t/Yz3XLrVPg1QTA/KV92klkMMTrpD6DFoLyXQm0gSSpGcj
   IeVNpbU4TrrmkhpbYPMqZXUMCmUFCD59s4w7/O6DQSOmUfYcFH4djmmcn
   stwi2tPhFNQ81T6e5e/ZSDNnHtkg+iiCTxXuT9T20RRd58Ff0NPRSpsz5
   oj9iIicoLoHPj70mnEO45/1Z+D97mkcE6GyiPWQNFBSi0/oBoV4FrpDOt
   YWxPm33SN8Q84jn6lCnHFbCbrAH6vwtE/DPSqaCDwnxNz+NkbHOzkuTTf
   fAeTewqrfdP80RI4uQUXd2+sGOAmG8zENJicQN4kf4b3tVooqsF2UPTlz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="431341453"
X-IronPort-AV: E=Sophos;i="5.99,205,1677571200"; 
   d="scan'208";a="431341453"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 19:06:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="755511431"
X-IronPort-AV: E=Sophos;i="5.99,205,1677571200"; 
   d="scan'208";a="755511431"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga008.fm.intel.com with ESMTP; 17 Apr 2023 19:06:14 -0700
Message-ID: <a1a82bc0-9a7a-5363-cda8-a0226eff0073@linux.intel.com>
Date:   Tue, 18 Apr 2023 10:06:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc:     baolu.lu@linux.intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>,
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
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20230407180554.2784285-1-jacob.jun.pan@linux.intel.com>
 <20230407180554.2784285-4-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB5276D09F18BA65AD074777948C9A9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <5882ee52-9657-250d-0474-13edffa7b6b9@linux.intel.com>
 <20230417094629.59fcfde6@jacob-builder>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230417094629.59fcfde6@jacob-builder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 4/18/23 12:46 AM, Jacob Pan wrote:
> On Wed, 12 Apr 2023 09:37:48 +0800, Baolu Lu<baolu.lu@linux.intel.com>
> wrote:
> 
>> On 4/11/23 4:02 PM, Tian, Kevin wrote:
>>>> From: Jacob Pan<jacob.jun.pan@linux.intel.com>
>>>> Sent: Saturday, April 8, 2023 2:06 AM
>>>> @@ -28,8 +26,8 @@ static int iommu_sva_alloc_pasid(struct mm_struct
>>>> *mm, ioasid_t min, ioasid_t ma
>>>>    		goto out;
>>>>    	}
>>>>
>>>> -	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max,
>>>> GFP_KERNEL);
>>>> -	if (ret < min)
>>>> +	ret = iommu_alloc_global_pasid(min, max);
>>> I wonder whether this can take a device pointer so
>>> dev->iommu->max_pasids is enforced inside the alloc function.
>> Agreed. Instead of using the open code, it looks better to have a helper
>> like dev_iommu_max_pasids().
> yes, probably export dev_iommu_get_max_pasids(dev)?
> 
> But if I understood Kevin correctly, he's also suggesting that the
> interface should be changed to iommu_alloc_global_pasid(dev), my concern is
> that how do we use this function to reserve RID_PASID which is not specific
> to a device?

Probably we can introduce a counterpart dev->iommu->min_pasids, so that
there's no need to reserve the RID_PASID. At present, we can set it to 1
in the core as ARM/AMD/Intel all treat PASID 0 as a special pasid.

In the future, if VT-d supports using arbitrary number as RID_PASID for
any specific device, we can call iommu_alloc_global_pasid() for that
device.

The device drivers don't know and don't need to know the range of viable
PASIDs, so the @min, @max parameters seem to be unreasonable.

Best regards,
baolu
