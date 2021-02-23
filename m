Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D56C3230E8
	for <lists+dmaengine@lfdr.de>; Tue, 23 Feb 2021 19:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbhBWSm6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Feb 2021 13:42:58 -0500
Received: from mga14.intel.com ([192.55.52.115]:21270 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230114AbhBWSm6 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 23 Feb 2021 13:42:58 -0500
IronPort-SDR: fkxo1KjMTKKMoVuxz9/IqlP8dZ5wUz5LMRGoWFiMFv3dyNcWRLsMq/bNXYoWUA8FJ/T4FhwOUn
 wwsbYLO5IFlg==
X-IronPort-AV: E=McAfee;i="6000,8403,9904"; a="184204934"
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="184204934"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 10:42:17 -0800
IronPort-SDR: i5GwP3eRvEE/n5X2iAqoVscjGF+DseN4GzuN7YSSxWaZAeR/nT78AO0hWZD9yrR2H8LhuEMvMd
 83WTW2x5yK4g==
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="431050287"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.209.140.167]) ([10.209.140.167])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 10:42:17 -0800
Subject: Re: [PATCH] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
To:     Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
References: <161368391486.325538.12829531932377771231.stgit@djiang5-desk3.ch.intel.com>
 <20210223125956.GY4247@nvidia.com>
 <397867c3-0b0d-82aa-37c1-deccd24d8f6c@intel.com>
 <20210223170851.GZ4247@nvidia.com>
 <CAPcyv4j3RTBqVmAKSRVOzdQ8yZVMU0_yunSGSiV93rYwHBEx9Q@mail.gmail.com>
 <20210223181015.GC4247@nvidia.com>
 <CAPcyv4gA8E9ehFQCnUkz72w-Z1qHV=f_Y8XK7O9w-P3_aap65g@mail.gmail.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <592ad3c7-1fc8-537d-a491-5013759109e1@intel.com>
Date:   Tue, 23 Feb 2021 11:42:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gA8E9ehFQCnUkz72w-Z1qHV=f_Y8XK7O9w-P3_aap65g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 2/23/2021 11:30 AM, Dan Williams wrote:
> On Tue, Feb 23, 2021 at 10:11 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>> On Tue, Feb 23, 2021 at 10:05:58AM -0800, Dan Williams wrote:
>>> On Tue, Feb 23, 2021 at 9:09 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>>>> On Tue, Feb 23, 2021 at 08:27:46AM -0700, Dave Jiang wrote:
>>>>> On 2/23/2021 5:59 AM, Jason Gunthorpe wrote:
>>>>>> On Thu, Feb 18, 2021 at 02:31:54PM -0700, Dave Jiang wrote:
>>>>>>> Remove devm_* allocation of memory of 'struct device' objects.
>>>>>>> The devm_* lifetime is incompatible with device->release() lifetime.
>>>>>>> Address issues flagged by CONFIG_DEBUG_KOBJECT_RELEASE. Add release
>>>>>>> functions for each component in order to free the allocated memory at
>>>>>>> the appropriate time. Each component such as wq, engine, and group now
>>>>>>> needs to be allocated individually in order to setup the lifetime properly.
>>>>>> I really don't understand why idxd has so many struct device objects.
>>>>>>
>>>>>> Typically I expect a simple driver to have exactly one, usually
>>>>>> provided by its subsystem.
>>>>>>
>>>>>> What is the purpose?
>>>>> When we initially designed this, Dan suggested to tie the device and
>>>>> workqueue enabling to the Linux device model so that the enabling/disabling
>>>>> can be done via bind/unbind of the sub drivers. So that's how we ended up
>>>>> with all the 'struct device' under idxd and one for each configurable
>>>>> component of the hardware device.
>>>> IDXD created its own little bus just for that?? :\
>>> Yes, for the dynamic configurability of the queues and engines it was
>>> either a pile of ioctls, configfs, or a dynamic sysfs organization. I
>>> did dynamic sysfs for libnvdimm and suggested idxd could use the same
>>> model.
>>>
>>>> It is really weird that something called a workqueue would show up in
>>>> the driver model at all.
>>> It's a partition of the hardware functionality.
>> But to what end? What else are you going to do with a slice of the
>> IDXD device other than assign it to the IDXD driver?
> idxd, unlike other dmaengines, has a dynamic relationship between
> backend hardware engines and frontend submission queues. The
> assignment of resources to queues is managed via sysfs. I think this
> would be clearer if there were some more upstream usage examples
> beyond dmaengine. However, consider one exploratory usage of
> offloading memory copies in the pmem driver. Each pmem device could be
> given a submission queue even if all pmem devices shared an engine on
> the backend.
>
>> Is it for vfio? If so then why doesn't the vfio just bind to the WQ -
>> why does it have an aux device??
> Hmm, Dave? Couldn't there be an alternate queue driver that attached
> vfio? At least that's how libnvdimm and dax devices change
> personality, they just load a different driver for the same device.

Would that work for a queue that's shared between multiple mdevs? And 
wasn't the main reason of pushing an aux dev under VFIO is so putting 
the code under the right maintainer for code review?


