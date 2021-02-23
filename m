Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE8C323063
	for <lists+dmaengine@lfdr.de>; Tue, 23 Feb 2021 19:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbhBWSPB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Feb 2021 13:15:01 -0500
Received: from mga03.intel.com ([134.134.136.65]:5162 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233108AbhBWSOz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 23 Feb 2021 13:14:55 -0500
IronPort-SDR: LgjQMVe6ClH57QzaPUd5Df96o1HakkVBSijs2yFSVT2mto3zbIFioEAoWsxqqnTNHfXysXNF81
 miPkSq7l5WjA==
X-IronPort-AV: E=McAfee;i="6000,8403,9904"; a="184955261"
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="184955261"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 10:14:30 -0800
IronPort-SDR: E4xYunHW8u4xejL3ishzeudyUNVV5Dz9oBDmDuKptz5H9FGc30eqwhvyZSbTYJVhrJ92tHOZBG
 Ly4poQsMg/2Q==
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="431039943"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.209.140.167]) ([10.209.140.167])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 10:14:29 -0800
Subject: Re: [PATCH] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
References: <161368391486.325538.12829531932377771231.stgit@djiang5-desk3.ch.intel.com>
 <20210223125956.GY4247@nvidia.com>
 <397867c3-0b0d-82aa-37c1-deccd24d8f6c@intel.com>
 <20210223170851.GZ4247@nvidia.com>
 <CAPcyv4j3RTBqVmAKSRVOzdQ8yZVMU0_yunSGSiV93rYwHBEx9Q@mail.gmail.com>
 <20210223181015.GC4247@nvidia.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <73776ebc-fac8-52b8-a2de-2bc42e1d489a@intel.com>
Date:   Tue, 23 Feb 2021 11:14:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210223181015.GC4247@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 2/23/2021 11:10 AM, Jason Gunthorpe wrote:
> On Tue, Feb 23, 2021 at 10:05:58AM -0800, Dan Williams wrote:
>> On Tue, Feb 23, 2021 at 9:09 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>>> On Tue, Feb 23, 2021 at 08:27:46AM -0700, Dave Jiang wrote:
>>>> On 2/23/2021 5:59 AM, Jason Gunthorpe wrote:
>>>>> On Thu, Feb 18, 2021 at 02:31:54PM -0700, Dave Jiang wrote:
>>>>>> Remove devm_* allocation of memory of 'struct device' objects.
>>>>>> The devm_* lifetime is incompatible with device->release() lifetime.
>>>>>> Address issues flagged by CONFIG_DEBUG_KOBJECT_RELEASE. Add release
>>>>>> functions for each component in order to free the allocated memory at
>>>>>> the appropriate time. Each component such as wq, engine, and group now
>>>>>> needs to be allocated individually in order to setup the lifetime properly.
>>>>> I really don't understand why idxd has so many struct device objects.
>>>>>
>>>>> Typically I expect a simple driver to have exactly one, usually
>>>>> provided by its subsystem.
>>>>>
>>>>> What is the purpose?
>>>> When we initially designed this, Dan suggested to tie the device and
>>>> workqueue enabling to the Linux device model so that the enabling/disabling
>>>> can be done via bind/unbind of the sub drivers. So that's how we ended up
>>>> with all the 'struct device' under idxd and one for each configurable
>>>> component of the hardware device.
>>> IDXD created its own little bus just for that?? :\
>> Yes, for the dynamic configurability of the queues and engines it was
>> either a pile of ioctls, configfs, or a dynamic sysfs organization. I
>> did dynamic sysfs for libnvdimm and suggested idxd could use the same
>> model.
>>
>>> It is really weird that something called a workqueue would show up in
>>> the driver model at all.
>> It's a partition of the hardware functionality.
> But to what end? What else are you going to do with a slice of the
> IDXD device other than assign it to the IDXD driver?
>
> Is it for vfio? If so then why doesn't the vfio just bind to the WQ -
> why does it have an aux device??
No this is unrelated to vfio. It's for general configuration of the device.
