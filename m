Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A174C5390FB
	for <lists+dmaengine@lfdr.de>; Tue, 31 May 2022 14:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242495AbiEaMpf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 31 May 2022 08:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239853AbiEaMpf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 31 May 2022 08:45:35 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F376EB22;
        Tue, 31 May 2022 05:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654001134; x=1685537134;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=E2ntfHjCIkuUyHhmuXAzUVCFkINVleA6ROwALxGHnvM=;
  b=CVtistdmUYgQ9RoNZ3kivk1aSK2dMRCMwsd5IccMq6lOCCTVOL2zUWhQ
   LaFnTl+QowXxRa8+3dozV2OTxSF418Sio47Je/DtJLHNfrr3XbH6eyxGu
   +xlXhMeuDPVICGMkq53oWxOVXuO7KSgn9AmIOEByepvP1V41mBm1+nKmn
   2ZC4+XHqGUXlOWwPDayEC2ESyJQ3jy2nYQ2ohkgYLrLFk2S1O2DGwPtmh
   6xuYxMNK2g+DHfr5nJyc0COPi2dqoaqMeZmtKx/k6xgc2elNm3Lk7H3og
   Lm0Dci8Ce+CCbCUHtqeCp91MtpvreFDrdz0E0pfTckkY/Jh+Nb72zBGlu
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="275246180"
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="275246180"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 05:45:33 -0700
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="706557881"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.249.170.74]) ([10.249.170.74])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 05:45:30 -0700
Message-ID: <628aa885-dd12-8bcd-bfc6-446345bf69ed@linux.intel.com>
Date:   Tue, 31 May 2022 20:45:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Christoph Hellwig <hch@infradead.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v4 1/6] iommu: Add a per domain PASID for DMA API
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
 <20220518182120.1136715-2-jacob.jun.pan@linux.intel.com>
 <20220524135034.GU1343366@nvidia.com> <20220524081727.19c2dd6d@jacob-builder>
 <20220530122247.GY1343366@nvidia.com>
 <BN9PR11MB52768105FC4FB959298F8A188CDC9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52768105FC4FB959298F8A188CDC9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2022/5/31 18:12, Tian, Kevin wrote:
>>>> +++ b/include/linux/iommu.h
>>>> @@ -105,6 +105,8 @@ struct iommu_domain {
>>>>   	enum iommu_page_response_code (*iopf_handler)(struct
>> iommu_fault *fault,
>>>>   						      void *data);
>>>>   	void *fault_data;
>>>> +	ioasid_t pasid;		/* Used for DMA requests with PASID */
>>>> +	atomic_t pasid_users;
>>> These are poorly named, this is really the DMA API global PASID and
>>> shouldn't be used for other things.
>>>
>>>
>>>
>>> Perhaps I misunderstood, do you mind explaining more?
>> You still haven't really explained what this is for in this patch,
>> maybe it just needs a better commit message, or maybe something is
>> wrong.
>>
>> I keep saying the DMA API usage is not special, so why do we need to
>> create a new global pasid and refcount? Realistically this is only
>> going to be used by IDXD, why can't we just allocate a PASID and
>> return it to the driver every time a driver asks for DMA API on PASI
>> mode? Why does the core need to do anything special?
>>
> Agree. I guess it was a mistake caused by treating ENQCMD as the
> only user although the actual semantics of the invented interfaces
> have already evolved to be quite general.
> 
> This is very similar to what we have been discussing for iommufd.
> a PASID is just an additional routing info when attaching a device
> to an I/O address space (DMA API in this context) and by default
> it should be a per-device resource except when ENQCMD is
> explicitly opt in.
> 
> Hence it's right time for us to develop common facility working
> for both this DMA API usage and iommufd, i.e.:
> 
> for normal PASID attach to a domain, driver:
> 
> 	allocates a local pasid from device local space;
> 	attaches the local pasid to a domain;
> 
> for PASID attach in particular for ENQCMD, driver:
> 
> 	allocates a global pasid in system-wide;
> 	attaches the global pasid to a domain;
> 	set the global pasid in PASID_MSR;
> 
> In both cases the pasid is stored in the attach data instead of the
> domain.
> 
> DMA API pasid is no special from above except it needs to allow
> one device attached to the same domain twice (one with RID
> and the other with RID+PASID).
> 
> for iommufd those operations are initiated by userspace via
> iommufd uAPI.

My understanding is that device driver owns its PASID policy. If ENQCMD
is supported on the device, the PASIDs should be allocated through
ioasid_alloc(). Otherwise, the whole PASID pool is managed by the device
driver.

For kernel DMA w/ PASID, after the driver has a PASID for this purpose,
it can just set the default domain to the PASID on device. There's no
need for enable/disable() interfaces.

Best regards,
baolu
