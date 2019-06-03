Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEA2732914
	for <lists+dmaengine@lfdr.de>; Mon,  3 Jun 2019 09:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfFCHFJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Jun 2019 03:05:09 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49080 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfFCHFJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Jun 2019 03:05:09 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5374mjJ113865;
        Mon, 3 Jun 2019 02:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559545488;
        bh=/ZfZnNhCBWvC2yMY89wicfcj6mJTgC9srlxSOwWvDs0=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=dnO4VySw7LF5w7Sq2ztKHlI3A/bmpWm9xQWWcTrtuIopyzcuI35kucUOn1k/nnNPY
         SGjCdbSH/3+kaji8NBSBrhqMzF7XRsnAv2dS/ljh/POOri7jBXCBWTiNYRCO0Q4gGp
         QMjVvLX1M/nDkJXOgwYGXbGJZ/t5mN55R7arEu5Y=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5374mRh104871
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Jun 2019 02:04:48 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 3 Jun
 2019 02:04:48 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 3 Jun 2019 02:04:48 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5374kix061216;
        Mon, 3 Jun 2019 02:04:47 -0500
Subject: Re: [PATCH] dmaengine: dmatest: Add support for completion polling
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>
References: <20190529083724.18182-1-peter.ujfalusi@ti.com>
 <4f327f4a-9e3d-c9d2-fe48-14e492b07417@ti.com>
Message-ID: <793f9f48-0609-4aa5-2688-bf30525e229c@ti.com>
Date:   Mon, 3 Jun 2019 10:05:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <4f327f4a-9e3d-c9d2-fe48-14e492b07417@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On 31/05/2019 9.54, Peter Ujfalusi wrote:
> 
> On 29/05/2019 11.37, Peter Ujfalusi wrote:
>> With the polled parameter the DMA drivers can be tested if they can work
>> correctly when no completion is requested (no DMA_PREP_INTERRUPT and no
>> callback is provided).
>>
>> If polled mode is selected then use dma_sync_wait() to execute the test
>> iteration instead of relying on the completion callback.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/dma/dmatest.c | 35 ++++++++++++++++++++++++++++-------
>>  1 file changed, 28 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
>> index b96814a7dceb..088086d041e9 100644
>> --- a/drivers/dma/dmatest.c
>> +++ b/drivers/dma/dmatest.c
>> @@ -75,6 +75,10 @@ static bool norandom;
>>  module_param(norandom, bool, 0644);
>>  MODULE_PARM_DESC(norandom, "Disable random offset setup (default: random)");
>>  
>> +static bool polled;
>> +module_param(polled, bool, S_IRUGO | S_IWUSR);
>> +MODULE_PARM_DESC(polled, "Use polling for completion instead of interrupts");
>> +
>>  static bool verbose;
>>  module_param(verbose, bool, S_IRUGO | S_IWUSR);
>>  MODULE_PARM_DESC(verbose, "Enable \"success\" result messages (default: off)");
>> @@ -113,6 +117,7 @@ struct dmatest_params {
>>  	bool		norandom;
>>  	int		alignment;
>>  	unsigned int	transfer_size;
>> +	bool		polled;
>>  };
>>  
>>  /**
>> @@ -654,7 +659,10 @@ static int dmatest_func(void *data)
>>  	/*
>>  	 * src and dst buffers are freed by ourselves below
>>  	 */
>> -	flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
>> +	if (params->polled)
>> +		flags = DMA_CTRL_ACK;
>> +	else
>> +		flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
>>  
>>  	ktime = ktime_get();
>>  	while (!kthread_should_stop()
>> @@ -783,8 +791,10 @@ static int dmatest_func(void *data)
>>  		}
>>  
>>  		done->done = false;
>> -		tx->callback = dmatest_callback;
>> -		tx->callback_param = done;
>> +		if (!params->polled) {
>> +			tx->callback = dmatest_callback;
>> +			tx->callback_param = done;
>> +		}
>>  		cookie = tx->tx_submit(tx);
>>  
>>  		if (dma_submit_error(cookie)) {
>> @@ -793,12 +803,22 @@ static int dmatest_func(void *data)
>>  			msleep(100);
>>  			goto error_unmap_continue;
>>  		}
>> -		dma_async_issue_pending(chan);
>>  
>> -		wait_event_freezable_timeout(thread->done_wait, done->done,
>> -					     msecs_to_jiffies(params->timeout));
>> +		if (params->polled) {
>> +			status = dma_sync_wait(chan, cookie);
>> +			dmaengine_terminate_sync(chan);
>> +			if (status == DMA_COMPLETE)
>> +				done->done = true;
> 
> I think the main question is how polling for completion should be
> handled when client does not request for completion interrupt, thus we
> will have no callback in the DMA driver when the transfer is completed.
> 
> If DMA_PREP_INTERRUPT is set for the tx_descriptor then the polling will
> wait until the DMA driver internally receives the interrupt that the
> transfer is done and sets the cookie to completed state.
> 
> However if DMA_PREP_INTERRUPT is not set, the DMA driver will not get
> notification from the HW that is the transfer is done, the only way to
> know is to check the tx_status and based on the residue (if it is 0 then
> it is done) decide what to tell the client.
> 
> Should the client call dmaengine_terminate_* after the polling returned
> unconditionally to free up the descriptor?

This is how omap-dma is handling the polled memcpy support.

> Or client should only call dmaengine_terminate_* in case the polling
> returned with !DMA_COMPLETE and the DMA driver must clean things up
> before returning if the transfer is completed (residue == 0)?
> 
>> +		} else {
>> +			dma_async_issue_pending(chan);
>> +
>> +			wait_event_freezable_timeout(thread->done_wait,
>> +					done->done,
>> +					msecs_to_jiffies(params->timeout));
>>  
>> -		status = dma_async_is_tx_complete(chan, cookie, NULL, NULL);
>> +			status = dma_async_is_tx_complete(chan, cookie, NULL,
>> +							  NULL);
>> +		}
>>  
>>  		if (!done->done) {
>>  			result("test timed out", total_tests, src->off, dst->off,
>> @@ -1068,6 +1088,7 @@ static void add_threaded_test(struct dmatest_info *info)
>>  	params->norandom = norandom;
>>  	params->alignment = alignment;
>>  	params->transfer_size = transfer_size;
>> +	params->polled = polled;
>>  
>>  	request_channels(info, DMA_MEMCPY);
>>  	request_channels(info, DMA_MEMSET);
>>
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
