Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3765E2308
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2019 21:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389633AbfJWTCY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Oct 2019 15:02:24 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59714 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387929AbfJWTCY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Oct 2019 15:02:24 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9NJ1m6l127082;
        Wed, 23 Oct 2019 14:01:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571857308;
        bh=DArSh++5WRoZXRi3QoMQ7+JP/thbu0dyM5JtKPXhT5o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ByASIwerYq+UR52KykEvPRoEH6CbXkJ4hgoDyO7s+vCcW9t1O6MgyaUjKTKoArUCZ
         xWXPaTJM2Qi0lj+Y2vHWx7E1ld7NbTpE0W4bsU1uxNuI5Bgvjwvg8n0xm3+a41cOHc
         DJyt4nXHET5RzeBRAGFG68Z0IJxbS6fnpxkHxCcA=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9NJ1m0q127824;
        Wed, 23 Oct 2019 14:01:48 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 23
 Oct 2019 14:01:37 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 23 Oct 2019 14:01:37 -0500
Received: from [192.168.2.10] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9NJ1ftx063558;
        Wed, 23 Oct 2019 14:01:42 -0500
Subject: Re: [PATCH] dmaengine: cppi41: Fix cppi41_dma_prep_slave_sg() when
 idle
To:     Tony Lindgren <tony@atomide.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bin Liu <b-liu@ti.com>, Daniel Mack <zonque@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Johan Hovold <johan@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        <dmaengine@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <giulio.benetti@benettiengineering.com>,
        Sebastian Reichel <sre@kernel.org>,
        Skvortsov <andrej.skvortzov@gmail.com>,
        Yegor Yefremov <yegorslists@googlemail.com>
References: <20191023153138.23442-1-tony@atomide.com>
 <245e1e8f-7933-bae1-b779-239f33d4d449@ti.com>
 <20191023171628.GO5610@atomide.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <5deab8a9-5796-5367-213e-90c5961b8498@ti.com>
Date:   Wed, 23 Oct 2019 22:02:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023171628.GO5610@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 10/23/19 8:16 PM, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [191023 17:04]:
>> On 10/23/19 6:31 PM, Tony Lindgren wrote:
>>> diff --git a/drivers/dma/ti/cppi41.c b/drivers/dma/ti/cppi41.c
>>> --- a/drivers/dma/ti/cppi41.c
>>> +++ b/drivers/dma/ti/cppi41.c
>>> @@ -586,9 +586,22 @@ static struct dma_async_tx_descriptor *cppi41_dma_prep_slave_sg(
>>>  	enum dma_transfer_direction dir, unsigned long tx_flags, void *context)
>>>  {
>>>  	struct cppi41_channel *c = to_cpp41_chan(chan);
>>> +	struct dma_async_tx_descriptor *txd = NULL;
>>> +	struct cppi41_dd *cdd = c->cdd;
>>>  	struct cppi41_desc *d;
>>>  	struct scatterlist *sg;
>>>  	unsigned int i;
>>> +	int error;
>>> +
>>> +	error = pm_runtime_get(cdd->ddev.dev);
>>
>> If pm_runtime_get()
>> pm_runtime_mark_last_busy()+pm_runtime_put_autosuspend() around a code
>> which updates a descriptor in _memory_ helps then this best described as
>> works by luck ;)
> 
> It also checks the cpp41 state for cdd->is_suspended
> though.

Which is cleared/set in the suspend/resume callbacks and they are called
from a work (the driver uses async runtime_get).

> AFAIK we do not currently have any other place
> to tell the driver a DMA request is about to start at
> some point soon.

True, but still.

>> I have a feeling that if you put enough delay between prepare_sg and
>> issue_pending in the usb driver then it will keep failing, no?
> 
> Nope, it will just queue it and run the queue when awake.

the autosuspend_delay is set 100 ms, so if you put a udelay(101) between
prep_sg and issue_pending in the usb driver this trickery will be for
nothing, right?
If the usb driver is preempted for longer than 100ms between the two
calls, same issue.
Not sure, but if for some reason the transfer would take longer than
100ms than pm_runtime will bring down the dma, no?

>> fwiw, in the cppi41_dma_issue_pending() the driver does:
>>
>> 	error = pm_runtime_get(cdd->ddev.dev);
>> ...
>> 	if (!cdd->is_suspended)
>> 		cppi41_run_queue(cdd);
>> ...
>> 	pm_runtime_mark_last_busy(cdd->ddev.dev);
>> 	pm_runtime_put_autosuspend(cdd->ddev.dev);
>>
>> Without waiting for the transfer to complete?
> 
> The queue gets run when cpp41 is awake, runtime PM
> reference is not released until completed.
> 
>> If issue_pending is not starting the transfer right away then the whole
>> pm handling is broken in there. imho.
> 
> AFAIK there is no other way to do this without tagging
> devices with pm_runtime_irq_safe(), which is nasty as
> it takes a permanent use count on the parent device.
> 
> But yeah, some dmaengine API that can sleep to tell
> a request is about to come would simplify things.

any of the prep callbacks kind of indicates that a client is preparing a
transfer so in a perfect world it is going to want to execute it..

> I don't think we have anything like that available
> right now?

Well, it would have the same issues. If the time between
dmaengine_be_warned_i_m_going_to_call_issue_pending_soon and
issue_pending is more than the autosuspend_delay then it is not going to
help.

On the other hand: if the usb driver assumes that the dma transfer is
already finished when issue_pending returned and carry on with
subsequent request, that is also a problematic assumption. One can only
consider a transfer to be done if the completion callback is called or
you have polled for the completion and it tells you the same.
This is problematic if you are in atomic context as the DMA completion
interrupt might not come while you are there.

imho, this fix is working by lucky constellation of the stars ;)
Or we can assume that there will never be more than 100ms delay between
prepare_sg and issue_pending...

- Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
