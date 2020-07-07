Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C622172CC
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2020 17:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgGGPpD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Jul 2020 11:45:03 -0400
Received: from mga18.intel.com ([134.134.136.126]:25714 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbgGGPpD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 7 Jul 2020 11:45:03 -0400
IronPort-SDR: e1WUmIK+5IVnrmNESnkWnP3k6G7ueM6YyM3gygMpW/IRj3RcGze8VZ9c8sBwOFxEuMduvCL4bw
 XRytHn/vpjNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="135093893"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="135093893"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 08:45:01 -0700
IronPort-SDR: M5WDlY/U4HMrLJB3zhaZzOVUiko6O0zyDMW4YVtx1zabIGbDZvm80rgedSgfoFokhzFpH/Ik14
 0Pwx7PydftHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="322693622"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.176.45]) ([10.212.176.45])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Jul 2020 08:45:00 -0700
Subject: Re: [PATCH v2] dmaengine: check device and channel list for empty
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jiri Slaby <jirislaby@kernel.org>, vkoul@kernel.org
Cc:     Swathi Kovvuri <swathi.kovvuri@intel.com>,
        dmaengine@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <159319496403.69045.16298280729899651363.stgit@djiang5-desk3.ch.intel.com>
 <ea3ef860-0b7a-e8da-8cf9-5930a8f3b7ed@kernel.org>
 <f5557e02-a9b8-8d43-7ff0-6a04bdc920fc@ti.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <44c03814-f5d7-4794-f89a-e6a83dd29cd5@intel.com>
Date:   Tue, 7 Jul 2020 08:45:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f5557e02-a9b8-8d43-7ff0-6a04bdc920fc@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 7/7/2020 1:50 AM, Peter Ujfalusi wrote:
> 
> 
> On 07/07/2020 9.05, Jiri Slaby wrote:
>> On 26. 06. 20, 20:09, Dave Jiang wrote:
>>> Check dma device list and channel list for empty before iterate as the
>>> iteration function assume the list to be not empty. With devices and
>>> channels now being hot pluggable this is a condition that needs to be
>>> checked. Otherwise it can cause the iterator to spin forever.
>>
>> Could you be a little bit more specific how this can spin forever? I.e.
>> can you attach a stacktrace of such a behaviour?
>>
>> As in the empty case, "&pos->member" is "head" (look into
>> list_for_each_entry) and the for loop should loop exactly zero times.
> 
> This is my understanding as well.
> 
> Isn't it more plausible that you have race between
> dma_async_device_register() / dma_async_device_unregister() /
> dma_async_device_channel_register() /
> dma_async_device_channel_unregister() ?
> 
> It looks like that there is unbalanced locking between
> dma_async_device_channel_register() and
> dma_async_device_channel_unregister().
> 
> The later locks the dma_list_mutex for a short while, while the former
> does not.
> Both device_register/unregister locks the same dma_list_mutex in some point.


It is possible there's a race as well in addition to the issue that the patch 
fixes. I'll take a look and see if there's an additional fix for the unbalanced 
locking. Thanks for checking Peter.


> 
>>> Fixes: e81274cd6b52 ("dmaengine: add support to dynamic register/unregister of channels")
>>> Reported-by: Swathi Kovvuri <swathi.kovvuri@intel.com>
>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>> Tested-by: Swathi Kovvuri <swathi.kovvuri@intel.com>
>>> ---
>>>
>>> Rebased to dmaengine next tree
>>>
>>>   drivers/dma/dmaengine.c |  119 +++++++++++++++++++++++++++++++++++++----------
>>>   1 file changed, 94 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
>>> index 2b06a7a8629d..0d6529eff66f 100644
>>> --- a/drivers/dma/dmaengine.c>> +++ b/drivers/dma/dmaengine.c
> 
> ...
> 
>>> +static int dma_channel_enumeration(struct dma_device *device)
>>> +{
>>> +	struct dma_chan *chan;
>>> +	int rc;
>>> +
>>> +	if (list_empty(&device->channels))
>>> +		return 0;
>>> +
>>> +	/* represent channels in sysfs. Probably want devs too */
>>> +	list_for_each_entry(chan, &device->channels, device_node) {
>>> +		rc = __dma_async_device_channel_register(device, chan);
>>> +		if (rc < 0)
>>> +			return rc;
>>> +	}
>>> +
>>> +	/* take references on public channels */
>>> +	if (dmaengine_ref_count && !dma_has_cap(DMA_PRIVATE, device->cap_mask))
>>> +		list_for_each_entry(chan, &device->channels, device_node) {
>>> +			/* if clients are already waiting for channels we need
>>> +			 * to take references on their behalf
>>> +			 */
>>> +			if (dma_chan_get(chan) == -ENODEV) {
>>> +				/* note we can only get here for the first
>>> +				 * channel as the remaining channels are
>>> +				 * guaranteed to get a reference
>>> +				 */
>>> +				return -ENODEV;
>>> +			}
>>> +		}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>   /**
>>>    * dma_async_device_register - registers DMA devices found
>>>    * @device:	pointer to &struct dma_device
>>> @@ -1247,33 +1330,15 @@ int dma_async_device_register(struct dma_device *device)
>>>   	if (rc != 0)
>>>   		return rc;
>>>   
>>> +	mutex_lock(&dma_list_mutex);
>>>   	mutex_init(&device->chan_mutex);
>>>   	ida_init(&device->chan_ida);
>>> -
>>> -	/* represent channels in sysfs. Probably want devs too */
>>> -	list_for_each_entry(chan, &device->channels, device_node) {
>>> -		rc = __dma_async_device_channel_register(device, chan);
>>> -		if (rc < 0)
>>> -			goto err_out;
>>>
>>> +	rc = dma_channel_enumeration(device);
>>> +	if (rc < 0) {
>>> +		mutex_unlock(&dma_list_mutex);
>>> +		goto err_out;
>>>   	}
> 
> Here you effectively moved the __dma_async_device_channel_register()
> under dma_list_mutex.
> 
> 
>>>   
>>> -	mutex_lock(&dma_list_mutex);
>>> -	/* take references on public channels */
>>> -	if (dmaengine_ref_count && !dma_has_cap(DMA_PRIVATE, device->cap_mask))
>>> -		list_for_each_entry(chan, &device->channels, device_node) {
>>> -			/* if clients are already waiting for channels we need
>>> -			 * to take references on their behalf
>>> -			 */
>>> -			if (dma_chan_get(chan) == -ENODEV) {
>>> -				/* note we can only get here for the first
>>> -				 * channel as the remaining channels are
>>> -				 * guaranteed to get a reference
>>> -				 */
>>> -				rc = -ENODEV;
>>> -				mutex_unlock(&dma_list_mutex);
>>> -				goto err_out;
>>> -			}
>>> -		}
>>>   	list_add_tail_rcu(&device->global_node, &dma_device_list);
>>>   	if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
>>>   		device->privatecnt++;	/* Always private */
>>> @@ -1291,6 +1356,9 @@ int dma_async_device_register(struct dma_device *device)
>>>   		return rc;
>>>   	}
>>>   
>>> +	if (list_empty(&device->channels))
>>> +		return rc;
>>> +
>>>   	list_for_each_entry(chan, &device->channels, device_node) {
>>>   		if (chan->local == NULL)
>>>   			continue;
>>> @@ -1317,8 +1385,9 @@ void dma_async_device_unregister(struct dma_device *device)
>>>   
>>>   	dmaengine_debug_unregister(device);
>>>   
>>> -	list_for_each_entry_safe(chan, n, &device->channels, device_node)
>>> -		__dma_async_device_channel_unregister(device, chan);
>>> +	if (!list_empty(&device->channels))
>>> +		list_for_each_entry_safe(chan, n, &device->channels, device_node)
>>> +			__dma_async_device_channel_unregister(device, chan);
>>>   
>>>   	mutex_lock(&dma_list_mutex);
>>>   	/*
>>
>>
>>
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
