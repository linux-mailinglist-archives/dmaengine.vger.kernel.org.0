Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0A11CB2D8
	for <lists+dmaengine@lfdr.de>; Fri,  8 May 2020 17:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgEHPau (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 8 May 2020 11:30:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:57612 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727030AbgEHPau (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 8 May 2020 11:30:50 -0400
IronPort-SDR: DQ+yOgvuYWfqGi1qOqNN+B2SjrUJKttmXr1kqWuakdlzMOWTjS71gHBjHEg/qO9mv0wL5VL2ii
 qB1pnbsTD9FQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 08:30:50 -0700
IronPort-SDR: CnYmUcfZZG9SSTo/++H2UeYnYUMcsUJAk9RaDDUX47boDVludLdUKpOtaNYXti4gIKJTS3Fwjl
 ebSucP+ZTzlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,368,1583222400"; 
   d="scan'208";a="296172293"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.209.47.49]) ([10.209.47.49])
  by fmsmga002.fm.intel.com with ESMTP; 08 May 2020 08:30:49 -0700
Subject: Re: [PATCH v3] dmaengine: cookie bypass for out of order completion
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, swathi.kovvuri@intel.com
References: <158877653369.51303.5331705116646956272.stgit@djiang5-desk3.ch.intel.com>
 <4e9802fc-81f6-d293-99b1-8104942c5110@ti.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <72b6e5c4-86fd-2c5d-9f98-506b8238fa8b@intel.com>
Date:   Fri, 8 May 2020 08:30:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <4e9802fc-81f6-d293-99b1-8104942c5110@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,

On 5/8/2020 1:10 AM, Peter Ujfalusi wrote:
> Hi Dave,
> 
> On 06/05/2020 17.50, Dave Jiang wrote:
>> The cookie tracking in dmaengine expects all submissions completed in
>> order. Some DMA devices like Intel DSA can complete submissions out of
>> order, especially if configured with a work queue sharing multiple DMA
>> engines. Add a status DMA_OUT_OF_ORDER that tx_status can be returned for
>> those DMA devices. The user should use callbacks to track the completion
>> rather than the DMA cookie. This would address the issue of dmatest
>> complaining that descriptors are "busy" when the cookie count goes
>> backwards due to out of order completion. Add DMA_NO_COMPLETION_ORDER
>> DMA capability to allow the driver to flag the device's ability to complete
>> operations out of order.
>>
>> Reported-by: Swathi Kovvuri <swathi.kovvuri@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> Tested-by: Swathi Kovvuri <swathi.kovvuri@intel.com>
>> ---
>>
>> v3:
>> - v2 mailed wrong patch
>> v2:
>> - Add DMA capability (vinod)
>> - Add documentation (vinod)
>>
>>   Documentation/driver-api/dmaengine/provider.rst |   11 +++++++++++
>>   drivers/dma/dmatest.c                           |    5 ++++-
>>   drivers/dma/idxd/dma.c                          |    3 ++-
>>   include/linux/dmaengine.h                       |    2 ++
>>   4 files changed, 19 insertions(+), 2 deletions(-)
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
>> +
>>     - This function can be called in an interrupt context.
>>   
>>   - device_config
>> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
>> index a2cadfa2e6d7..8953e096a05c 100644
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
> 
> What would be the appropriate action if polled is set for dmatest? IN
> that case it is using dma_sync_wait(), it will break out if the status
> is != DMA_IN_PROGRESS for the cookie.
> 
> I believe that polling mode as we know it, is incompatible with this out
> of order completion handling.
> 
> It should be possible to just disallow polled mode in case
> dma_has_cap(DMA_COMPLETION_NO_ORDER, dev->cap_mask) == true

Ok sure. But looks like we need to come up with a way to not break your usages.

> 
> But I have a DMA where the out of order is not in DMA level, it can be
> achieved per channel bases if needed.
> I can not set this flag for UDMA as it would disable the polling mode
> for channels where it works.

Thoughts on introducing per channel cap mask in addition to the existing per 
device mask? Sounds like we already have devices with some channels having 
different capabilities and may expand with future devices. This way we can do 
this on a per channel basis?

> 
> Yes, I'm also interested in out of order cookie completion and even
> beyond that, when you don't really have cookies, but you have a pool
> given to the DMA and it is going to return them back when data arrived
> (or internally manages the pool and summons the packets out of thin air).
> 
>>   			result(status == DMA_ERROR ?
>>   			       "completion error status" :
>>   			       "completion busy status", total_tests, src->off,
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
> 
> There is no condition? It is always out of order?
> 
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
