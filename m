Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F031D1B24
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2020 18:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgEMQfS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 May 2020 12:35:18 -0400
Received: from mga18.intel.com ([134.134.136.126]:19341 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbgEMQfS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 13 May 2020 12:35:18 -0400
IronPort-SDR: yXsKDQy5fmUediNc/s4Deca6pPgyekc3y31T27VMpy7LgI95uuAIAo/uae5JgXiyypveqPKKj6
 cBEN7hJ9hNAw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 09:35:17 -0700
IronPort-SDR: 7D56FslyAFWgnn25jZCWZF15cQJ0tsUtIE3eVe3INsBfUJje45MPLAsIIk5m2H3HRdj6pfDo2A
 lZEZ4v+gvBPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,388,1583222400"; 
   d="scan'208";a="298418751"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.209.114.29]) ([10.209.114.29])
  by orsmga008.jf.intel.com with ESMTP; 13 May 2020 09:35:17 -0700
Subject: Re: [PATCH v4] dmaengine: cookie bypass for out of order completion
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, swathi.kovvuri@intel.com
References: <158924063387.26270.4363255780049839915.stgit@djiang5-desk3.ch.intel.com>
 <4d279eb4-baf8-f504-da30-6a6a963bc521@ti.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <f63a0895-914c-3509-1521-f978f30fb39b@intel.com>
Date:   Wed, 13 May 2020 09:35:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <4d279eb4-baf8-f504-da30-6a6a963bc521@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 5/13/2020 12:30 AM, Peter Ujfalusi wrote:
> 
> 
> On 12/05/2020 2.47, Dave Jiang wrote:
>> The cookie tracking in dmaengine expects all submissions completed in
>> order. Some DMA devices like Intel DSA can complete submissions out of
>> order, especially if configured with a work queue sharing multiple DMA
>> engines. Add a status DMA_OUT_OF_ORDER that tx_status can be returned for
>> those DMA devices. The user should use callbacks to track the completion
>> rather than the DMA cookie. This would address the issue of dmatest
>> complaining that descriptors are "busy" when the cookie count goes
>> backwards due to out of order completion. Add DMA_COMPLETION_NO_ORDER
>> DMA capability to allow the driver to flag the device's ability to complete
>> operations out of order.
> 
> I'm still a bit hesitant around this.
> If the DMA only support out of order completion then it is mandatory
> that each descriptor must have unique callback parameter in order the
> client could know which transfer has been completed.
> Kind of obvious, not sure if it worth documenting.

Agreed. I'll add a bit more notes to remind the reader.

> 
> It was/is on my to do list to support out of order completion as well,
> but the use case and setup is different and would need additional
> features for DMAengine (like 'classification' of a descriptor).
> I have planned to add optional DMA device level of cookie handling so I
> could track non ordered cookie statuses.
> In my case I mostly know which way the descriptor is going to go, but if
> I understand right in your case you have a pool of DMAs and it is mostly
> random which one is going to pick up (and complete) the descriptors,
> thus leading to cases when smaller transfers overtaking longer ones in
> completion.
> 
> I also believe this would not block optional DMA device level of cookie
> handling.

Looking forward to your enhancements.

> 
>> Reported-by: Swathi Kovvuri <swathi.kovvuri@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> Tested-by: Swathi Kovvuri <swathi.kovvuri@intel.com>
>> ---
>> v4:
>> - Add block for polled in dmatest. Need better enabling in future to solve
>>    per channel capability for out of order vs poll. (peter)
> 
> Thanks, it is just too bad that dma_has_cap() is so widely used to be
> easily repurposed :(

yes...

> 
>> v3:
>> - v2 mailed wrong patch
>> v2:
>> - Add DMA capability (vinod)
>> - Add documentation (vinod)
>>
>>   Documentation/driver-api/dmaengine/provider.rst |   11 +++++++++++
>>   drivers/dma/dmatest.c                           |   11 ++++++++++-
>>   drivers/dma/idxd/dma.c                          |    3 ++-
>>   include/linux/dmaengine.h                       |    2 ++
>>   4 files changed, 25 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
>> index 56e5833e8a07..783ca141e147 100644
>> --- a/Documentation/driver-api/dmaengine/provider.rst
>> +++ b/Documentation/driver-api/dmaengine/provider.rst
>> @@ -239,6 +239,14 @@ Currently, the types available are:
>>       want to transfer a portion of uncompressed data directly to the
>>       display to print it
>>   
>> +- DMA_COMPLETION_NO_ORDER
>> +
>> +  - The device supports out of order completion of the operations.
>> +
>> +  - The driver should return DMA_OUT_OF_ORDER for device_tx_status if
>> +    the device supports out of order completion and the completion is
>> +    is expected to be completed out of order.
> 
> It is not just supports out of order, but does not support in order
> completion. Iow it can not guarantee in order completion.
> As a not: all cookie tracking and checking API should be treated as
> invalid. For example dma_sync_wait() is unusable.
> 
> and one extra 'is'

I will clarify and add the additional note.

> 
>> +
>>   These various types will also affect how the source and destination
>>   addresses change over time.
>>   
>> @@ -399,6 +407,9 @@ supported.
>>     - In the case of a cyclic transfer, it should only take into
>>       account the current period.
>>   
>> +  - Should return DMA_OUT_OF_ORDER if the device supports out of order
>> +    completion and is completing the operation out of order.
> 
> Same here.
> 
>> +
>>     - This function can be called in an interrupt context.
>>   
>>   - device_config
>> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
>> index a2cadfa2e6d7..93c7c56af5f2 100644
>> --- a/drivers/dma/dmatest.c
>> +++ b/drivers/dma/dmatest.c
>> @@ -821,7 +821,10 @@ static int dmatest_func(void *data)
>>   			result("test timed out", total_tests, src->off, dst->off,
>>   			       len, 0);
>>   			goto error_unmap_continue;
>> -		} else if (status != DMA_COMPLETE) {
>> +		} else if (status != DMA_COMPLETE &&
>> +			   !(dma_has_cap(DMA_COMPLETION_NO_ORDER,
>> +					 dev->cap_mask) &&
>> +			     status == DMA_OUT_OF_ORDER)) {
>>   			result(status == DMA_ERROR ?
>>   			       "completion error status" :
>>   			       "completion busy status", total_tests, src->off,
>> @@ -999,6 +1002,12 @@ static int dmatest_add_channel(struct dmatest_info *info,
>>   	dtc->chan = chan;
>>   	INIT_LIST_HEAD(&dtc->threads);
>>   
>> +	if (dma_has_cap(DMA_COMPLETION_NO_ORDER, dma_dev->cap_mask) &&
>> +	    info->params.polled) {
>> +		info->params.polled = false;
>> +		pr_warn("DMA_COMPLETION_NO_ORDER, polled disabled\n");
>> +	}
>> +
>>   	if (dma_has_cap(DMA_MEMCPY, dma_dev->cap_mask)) {
>>   		if (dmatest == 0) {
>>   			cnt = dmatest_add_threads(info, dtc, DMA_MEMCPY);
>> diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
>> index c64c1429d160..0c892cbd72e0 100644
>> --- a/drivers/dma/idxd/dma.c
>> +++ b/drivers/dma/idxd/dma.c
>> @@ -133,7 +133,7 @@ static enum dma_status idxd_dma_tx_status(struct dma_chan *dma_chan,
>>   					  dma_cookie_t cookie,
>>   					  struct dma_tx_state *txstate)
>>   {
>> -	return dma_cookie_status(dma_chan, cookie, txstate);
>> +	return DMA_OUT_OF_ORDER;
>>   }
>>   
>>   /*
>> @@ -174,6 +174,7 @@ int idxd_register_dma_device(struct idxd_device *idxd)
>>   	INIT_LIST_HEAD(&dma->channels);
>>   	dma->dev = &idxd->pdev->dev;
>>   
>> +	dma_cap_set(DMA_COMPLETION_NO_ORDER, dma->cap_mask);
>>   	dma->device_release = idxd_dma_release;
>>   
>>   	if (idxd->hw.opcap.bits[0] & IDXD_OPCAP_MEMMOVE) {
>> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
>> index 21065c04c4ac..1123f4d15bae 100644
>> --- a/include/linux/dmaengine.h
>> +++ b/include/linux/dmaengine.h
>> @@ -39,6 +39,7 @@ enum dma_status {
>>   	DMA_IN_PROGRESS,
>>   	DMA_PAUSED,
>>   	DMA_ERROR,
>> +	DMA_OUT_OF_ORDER,
>>   };
>>   
>>   /**
>> @@ -61,6 +62,7 @@ enum dma_transaction_type {
>>   	DMA_SLAVE,
>>   	DMA_CYCLIC,
>>   	DMA_INTERLEAVE,
>> +	DMA_COMPLETION_NO_ORDER,
>>   /* last transaction type for creation of the capabilities mask */
>>   	DMA_TX_TYPE_END,
>>   };
>>
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
