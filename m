Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE0BE17C0DB
	for <lists+dmaengine@lfdr.de>; Fri,  6 Mar 2020 15:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgCFOtH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Mar 2020 09:49:07 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38150 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgCFOtG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 6 Mar 2020 09:49:06 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 026En3AQ103047;
        Fri, 6 Mar 2020 08:49:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583506143;
        bh=Ojdue2/HqCAWX6KVQYEIjLRmgy46HesemuPvWi0Tj9g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=M/QsGReJvy6L9qMXR0c1uL765kaDwVPJw5qDOY1irIYl3kiTSUZvoomJQEknVoMTI
         AQAgBKT+CwvWjxX88NyRfJdBgpkkwViYdJTmHPzEj0TdvJl80UYjIvmX5Q9yErZ7hR
         3lx3Ggl/4XiWsZn5iS8ETCmjj4F0F7IJNIQTAdik=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 026En2a8005086
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Mar 2020 08:49:02 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 6 Mar
 2020 08:49:01 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 6 Mar 2020 08:49:01 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 026EmxQB020080;
        Fri, 6 Mar 2020 08:49:00 -0600
Subject: Re: [PATCH v3 2/6] dmaengine: Add interleaved cyclic transaction type
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
References: <becf8212-7fe6-9fb6-eb2c-7a03a9b286b1@ti.com>
 <20200219092514.GG2618@vkoul-mobl>
 <20200226163011.GE4770@pendragon.ideasonboard.com>
 <20200302034735.GD4148@vkoul-mobl>
 <20200302073728.GB9177@pendragon.ideasonboard.com>
 <20200303043254.GN4148@vkoul-mobl>
 <20200303192255.GN11333@pendragon.ideasonboard.com>
 <20200304051301.GS4148@vkoul-mobl>
 <20200304080128.GA4712@pendragon.ideasonboard.com>
 <20200304153718.GU4148@vkoul-mobl>
 <20200304160016.GB4712@pendragon.ideasonboard.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <aa7addf1-f7cf-c89f-9bf8-e937fe84f213@ti.com>
Date:   Fri, 6 Mar 2020 16:49:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200304160016.GB4712@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Laureant,

On 04/03/2020 18.00, Laurent Pinchart wrote:
> I still think this is a different API. We'll have
> 
> 1. Existing .issue_pending(), queueing the next transfer for non-cyclic
>    cases, and being a no-op for cyclic cases.
> 2. New .terminate_cookie(AT_END_OF_TRANSFER), being a no-op for
>    non-cyclic cases, and moving to the next transfer for cyclic cases.
> 3. New .terminate_cookie(ABORT_IMMEDIATELY), applicable to both cyclic
>    and non-cyclic cases.
> 
> 3. is an API I don't need, and can't easily test. I agree that it can
> have use cases (provided the DMA device can abort an ongoing transfer
> *and* still support DMA_RESIDUE_GRANULARITY_BURST in that case).
> 
> I'm troubled by my inability to convince you that 1. and 2. are really
> the same, with 1. addressing the non-cyclic case and 2. addressing the
> cyclic case :-) This is why I think they should both be implemeted using
> .issue_pending() (no other option for 1., that's what it uses today).
> This wouldn't prevent implementing 3. with a new .terminate_cookie()
> operation, that wouldn't need to take a flag as it would always operate
> in ABORT_IMMEDIATELY mode. There would also be no need to report a new
> capability for 3., as the presence of the .terminate_cookie() handler
> would be enough to tell clients that the API is supported. Only a new
> capability for 2. would be needed.

Let's see the two cases, AT_END_OF_TRANSFER and ABORT_IMMEDIATELY
against cyclic and slave for simplicity:
- AT_END_OF_TRANSFER
...
issue_pending(1)
issue_pending(2)
terminate_cookie(AT_END_OF_TRANSFER)

In case of cyclic:
When cookie1 finishes a tx cookie2 will start.

Same sequence in case of slave:
When cookie1 finishes a tx cookie2 will start.
 Yes, terminate_cookie(AT_END_OF_TRANSFER) is NOP

- ABORT_IMMEDIATELY
...
issue_pending(1)
issue_pending(2)
terminate_cookie(ABORT_IMMEDIATELY)

In case of cyclic and slave:
Abort cookie1 right away and start cookie2.

In case of cyclic:
When cookie1 finishes a tx cookie2 will start.

True, we have NOP operation, but as you can see the semantics of the two
cases are well defined and consistent among different operations.

Imho the only thing which is not really defined is the
AT_END_OF_TRANSFER, is it after the current period, or when finishing
the buffer / after a frame or all frames are consumed in the current tx
for interleaved.


>>>> And with this I think it would make sense to also add this to
>>>> capabilities :)
>>>
>>> I'll repeat the comment I made to Peter: you want me to implement a
>>> feature that you think would be useful, but is completely unrelated to
>>> my use case, while there's a more natural way to handle my issue with
>>> the current API, without precluding in any way the addition of your new
>>> feature in the future. Not fair.
>>
>> So from API design pov, I would like this to support both the features.
>> This helps us to not rework the API again for the immediate abort.
>>
>> I am not expecting this to be implemented by you if your hw doesn't
>> support it. The core changes are pretty minimal and callback in the
>> driver is the one which does the job and yours wont do this
> 
> Xilinx DMA drivers don't support DMA_RESIDUE_GRANULARITY_BURST so I
> can't test this indeed.

All TI DMA supports it ;)

> 
>>>>>> So, the .terminate_cookie() should be a feature for all type of txn's.
>>>>>> If for some reason (dont discount what hw designers can do) a controller
>>>>>> supports this for some specific type(s), then they should return
>>>>>> -ENOTSUPP for cookies that do not support and let the caller know.
>>>>>
>>>>> But then the caller can't know ahead of time, it will only find out when
>>>>> it's too late, and can't decide not to use the DMA engine if it doesn't
>>>>> support the feature. I don't think that's a very good option.
>>>>
>>>> Agreed so lets go with adding these in caps.
>>>
>>> So if there's a need for caps anyway, why not a cap that marks
>>> .issue_pending() as moving from the current cyclic transfer to the next
>>> one ? 
>>
>> Is the overhead really too much on that :) If you like I can send the
>> core patches and you would need to implement the driver side?
> 
> We can try that as a compromise. One of main concerns with developing
> the core patches myself is that the .terminate_cookie() API still seems
> ill-defined to me, so it would be much more efficient if you translate
> the idea you have in your idea into code than trying to communicate it
> to me in all details (one of the grey areas is what should
> .terminate_cookie() do if the cookie passed to the function corresponds
> to an already terminated or, more tricky from a completion callback
> point of view, an issued but not-yet-started transfer, or also a
> submitted but not issued transfer). If you implement the core part, then
> that problem will go away.
> 
> How about the implementation in virt-dma.[ch] by the way ?
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
