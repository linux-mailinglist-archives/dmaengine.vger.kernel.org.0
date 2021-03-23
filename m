Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03094346338
	for <lists+dmaengine@lfdr.de>; Tue, 23 Mar 2021 16:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbhCWPpB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Mar 2021 11:45:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:27804 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232968AbhCWPob (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 23 Mar 2021 11:44:31 -0400
IronPort-SDR: xGf6kKs3UQDL/FzysqJ+fplSet2z8fZTvedzXG0FZkJUqoGJHDeGI+Zx87cjjDIKv9i7ILmmj7
 YDXi/MGKU+qA==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="251861112"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="251861112"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 08:44:31 -0700
IronPort-SDR: luX9SPVTJ7fBc1gfpl/TuCm6iQ7c2jQqTzVXUpUIA4JTeV/BtKNv5vPGvGxabJJkpw060SdJqn
 57QxrvnxqvyQ==
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="513791705"
Received: from mkobayas-mobl1.gar.corp.intel.com (HELO [10.212.157.78]) ([10.212.157.78])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 08:44:30 -0700
Subject: Re: [PATCH v7 0/8] idxd 'struct device' lifetime handling fixes
To:     Jason Gunthorpe <jgg@nvidia.com>, Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
References: <161645534083.2002542.11583610276394664799.stgit@djiang5-desk3.ch.intel.com>
 <YFnU2oqNavQEsmNZ@vkoul-mobl.Dlink> <20210323115600.GA2356281@nvidia.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <3e68045f-8901-c81e-a1d8-506c591060bf@intel.com>
Date:   Tue, 23 Mar 2021 08:44:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210323115600.GA2356281@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 3/23/2021 4:56 AM, Jason Gunthorpe wrote:
> On Tue, Mar 23, 2021 at 05:15:30PM +0530, Vinod Koul wrote:
>> Hi Dave,
>>
>> On 22-03-21, 16:31, Dave Jiang wrote:
>>> v7:
>>> - Fix up the 'struct device' setup in char device code (Jason)
>>> - Split out the char dev fixes (Jason)
>>> - Split out the DMA dev fixes (Dan)
>>> - Split out the each of the conf_dev fixes
>>> - Split out removal of the pcim_* calls
>>> - Split out removal of the devm_* calls
>>> - Split out the fixes for interrupt config calls
>>> - Reviewed by Dan.
>>>
>>> v6:
>>> - Fix char dev initialization issues (Jason)
>>> - Fix other 'struct device' initialization issues.
>>>
>>> v5:
>>> - Rebased against 5.12-rc dmaengine/fixes
>>> v4:
>>> - fix up the life time of cdev creation/destruction (Jason)
>>> - Tested with KASAN and other memory allocation leak detections. (Jason)
>>>
>>> v3:
>>> - Remove devm_* for irq request and cleanup related bits (Jason)
>>> v2:
>>> - Remove all devm_* alloc for idxd_device (Jason)
>>> - Add kref dep for dma_dev (Jason)
>>>
>>> Vinod,
>>> The series fixes the various 'struct device' lifetime handling in the
>>> idxd driver. The devm managed lifetime is incompatible with 'struct device'
>>> objects that resides in the idxd context. Tested with
>>> CONFIG_DEBUG_KOBJECT_RELEASE and address all issues from that.
>> Sorry for not looking into this earlier.. But I would like to check on
>> the direction idxd is taking. Somehow I get the feel the dmaengine is
>> not the right place for this. Considering that now we have auxdev merged
>> in, should the idxd be spilt into smaller function and no dmaengine
>> parts moved away from dmaengine... I think we do lack a subsystem for
>> all things accelerator in kernel atm...
> auxdev shouldn't be over-used IMHO.
>
> If the main purpose of the driver is dma engine then it is OK if the
> "core" part lives there too.

Hi Vinod,

So this patch series serves as the basis of getting the idxd 
dsa_bus_type related bits fixed up so that auxdev is not necessary. When 
Jason reviewed previous iterations of the mdev series, he noted that the 
mdev driver needs to go under VFIO. After the auxdev conversion of the 
mdev series, Jason and Dan after further review suggested that given 
there's an internal bus in idxd driver already (dsa_bus_type), that can 
be used to load drivers rather than needing to rely on auxiliary bus. 
But the implementation of the dsa_bus_type needs some fixes. After this 
series, I have another series that's going through internal review right 
now that will fixup the driver setup and initialization of dsa_bus_type 
and allow us to load external drivers for the wq. The in kernel use 
cases for DSA is still valid under dmaengine so the core parts remains 
valid for dmaengine. The plan going forward is after getting all the 
fixups in we are planning to:

1. Introduce UACCE framework support for idxd and have a wq driver 
resides under drivers/misc/uacce/idxd to support the char device 
operations and deprecate the current custom char dev in idxd. This 
should remove the burden on you to deal with the char device.

2. Resubmit the mdev driver under drivers/vfio/mdev/idxd after Jason's 
latest VFIO refactoring is done.

3. Introduce new kernel use cases with dmanegine API support for SVA 
operations.

Let me know if this sounds ok to you. Thanks!

