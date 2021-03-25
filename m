Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0020349565
	for <lists+dmaengine@lfdr.de>; Thu, 25 Mar 2021 16:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhCYP0g (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Mar 2021 11:26:36 -0400
Received: from mga12.intel.com ([192.55.52.136]:1205 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229731AbhCYP0H (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 25 Mar 2021 11:26:07 -0400
IronPort-SDR: IB0X30r2CY18/cmdqlXclXkrLV4f+q5MknhOM3RtpRNsx623knqM/e/P+SDINq6ULRa5Y+pup7
 IJScQH3KuXsA==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="170303790"
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="170303790"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 08:25:51 -0700
IronPort-SDR: XnV758Z/pRw1YChgBnIznZArvwn7tn51643sBmcSb28Q+viYjeLJc9Yd1eS2KN1x3zqMN1pEoQ
 tGUgY/pPV3uQ==
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="416052111"
Received: from ukorat-mobl2.amr.corp.intel.com (HELO [10.212.18.208]) ([10.212.18.208])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 08:25:50 -0700
Subject: Re: [PATCH v7 0/8] idxd 'struct device' lifetime handling fixes
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
References: <161645534083.2002542.11583610276394664799.stgit@djiang5-desk3.ch.intel.com>
 <YFnU2oqNavQEsmNZ@vkoul-mobl.Dlink> <20210323115600.GA2356281@nvidia.com>
 <3e68045f-8901-c81e-a1d8-506c591060bf@intel.com>
 <YFwtk7tnPmzVYGl0@vkoul-mobl.Dlink>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <02e9bcdc-0a47-0042-f852-836253b201f6@intel.com>
Date:   Thu, 25 Mar 2021 08:25:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YFwtk7tnPmzVYGl0@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 3/24/2021 11:28 PM, Vinod Koul wrote:
> On 23-03-21, 08:44, Dave Jiang wrote:
>> On 3/23/2021 4:56 AM, Jason Gunthorpe wrote:
>>> On Tue, Mar 23, 2021 at 05:15:30PM +0530, Vinod Koul wrote:
>>>>> Vinod,
>>>>> The series fixes the various 'struct device' lifetime handling in the
>>>>> idxd driver. The devm managed lifetime is incompatible with 'struct device'
>>>>> objects that resides in the idxd context. Tested with
>>>>> CONFIG_DEBUG_KOBJECT_RELEASE and address all issues from that.
>>>> Sorry for not looking into this earlier.. But I would like to check on
>>>> the direction idxd is taking. Somehow I get the feel the dmaengine is
>>>> not the right place for this. Considering that now we have auxdev merged
>>>> in, should the idxd be spilt into smaller function and no dmaengine
>>>> parts moved away from dmaengine... I think we do lack a subsystem for
>>>> all things accelerator in kernel atm...
>>> auxdev shouldn't be over-used IMHO.
>>>
>>> If the main purpose of the driver is dma engine then it is OK if the
>>> "core" part lives there too.
>> Hi Vinod,
>>
>> So this patch series serves as the basis of getting the idxd dsa_bus_type
>> related bits fixed up so that auxdev is not necessary. When Jason reviewed
>> previous iterations of the mdev series, he noted that the mdev driver needs
>> to go under VFIO. After the auxdev conversion of the mdev series, Jason and
>> Dan after further review suggested that given there's an internal bus in
>> idxd driver already (dsa_bus_type), that can be used to load drivers rather
>> than needing to rely on auxiliary bus. But the implementation of the
>> dsa_bus_type needs some fixes. After this series, I have another series
>> that's going through internal review right now that will fixup the driver
>> setup and initialization of dsa_bus_type and allow us to load external
>> drivers for the wq. The in kernel use cases for DSA is still valid under
>> dmaengine so the core parts remains valid for dmaengine. The plan going
>> forward is after getting all the fixups in we are planning to:
>>
>> 1. Introduce UACCE framework support for idxd and have a wq driver resides
>> under drivers/misc/uacce/idxd to support the char device operations and
>> deprecate the current custom char dev in idxd. This should remove the burden
>> on you to deal with the char device.
>>
>> 2. Resubmit the mdev driver under drivers/vfio/mdev/idxd after Jason's
>> latest VFIO refactoring is done.
>>
>> 3. Introduce new kernel use cases with dmanegine API support for SVA
>> operations.
>>
>> Let me know if this sounds ok to you. Thanks!
> Yes that does sound reasonable to me, when should I expect this move to
> show up on list?

We will try to do this in stages. So first we need to get this 'struct 
device' lifetime fixes series into the kernel. Next I have the 'struct 
device_driver' setup/shutdown series fix that Dan is reviewing 
internally right now that I will post as soon as he okays it. I also 
have the uacce conversion series ready and pending Dan's review. The 
mdev series I need to rebase it to Jason's new VFIO code refactor. Some 
of that refactor code is not yet posted public (I think?). So that will 
take a little longer. For the kernel SVA support, I have internal code 
but need to discuss with Dan on the implementation. Also we need to 
measure performance on hardware to make our case for the new kernel 
usage enablings. So that will come later.



