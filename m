Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4265AB452
	for <lists+dmaengine@lfdr.de>; Fri,  2 Sep 2022 16:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbiIBOyO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Sep 2022 10:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236835AbiIBOxt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Sep 2022 10:53:49 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C985FB2CF5;
        Fri,  2 Sep 2022 07:17:56 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id k18so2370227lji.13;
        Fri, 02 Sep 2022 07:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=/+qv/qtVZLxZWjZaDQDBBWUqwZqD8Ult8cYyZQOZh8o=;
        b=Q5H04ZVMrIAhefDQpGO8RR97Okeo5Vw0US0RPNRsryFh6DUuQ3ZNk9G0A4SDnmeo21
         lOWXybJM0Cl/m1cuwid8E7HJbepJJSWGD8+l6QuDHNu82/OOMuFvNGoai/OsR0kxVph6
         Q9aiLPfmxjSuHgZbIo+53k9U0a3CeA+x+3pQksMbDgA+ooxLw3o5GQXsmXfhHnHm9Pw5
         8Ve+NZANM/bZodRLGl2MmK0kvwF9AIEc6ZwSOcXFnagzXQVZramA/8vNPhgP9okcX77C
         v+lHRmXuL2QNXrI5y785Fz/T9Kaxu9TajHSNnMIqy9bfkqySEg62KWdiq+ZZT1f1wOOF
         bceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/+qv/qtVZLxZWjZaDQDBBWUqwZqD8Ult8cYyZQOZh8o=;
        b=A5mAUfF2J+Vm+23qL9Bb6EORCiol8+m/u2mJl6iEI/Tt4JcFzB4U+ydXg3KXTQnMXT
         07sgWcqSl6S+UtP030rhibNx53g2WI2NKdYRc/2W5Kt1chnBfJWRRKt+O+Vu1yEY6yK/
         qbFuxfw90FEXrHb9i3D+4t9gYPkDltmssSX9c7jtMNVJphwSfBeop4KIeq2aDeUVhbzk
         wXHwHnejOzMMfA+Qzyk31Cq22bPzPoMcbxJoj29fMcEX+9BR3AThJ0kzp+mZJ254gkGm
         WoEbNpLgVtI3MVng6pnTWGimLqTDGhJAPN51GOsqbmq2F1H+jqWCp8TPNADQ9dXCYE1n
         fOFA==
X-Gm-Message-State: ACgBeo3AL7VfHc0v117fIn9+MBKbcW8yU7FO+7qjpmScvHbRSiv9rVK5
        G4/LL70eG6GczrOH7LmOthBjW7+G+22V+qWD
X-Google-Smtp-Source: AA6agR7baXn4SVJuzrf/vnZ6uXiphZvMo0i8uBoNHsA3EEIy6l2gKS5svbt6UQDxfL+jEx+73xbt2w==
X-Received: by 2002:a05:651c:1048:b0:268:f7bd:8043 with SMTP id x8-20020a05651c104800b00268f7bd8043mr599403ljm.52.1662128274974;
        Fri, 02 Sep 2022 07:17:54 -0700 (PDT)
Received: from [10.0.0.127] (91-159-150-230.elisa-laajakaista.fi. [91.159.150.230])
        by smtp.gmail.com with ESMTPSA id f17-20020a05651232d100b00492f1b2ac0bsm261258lfg.101.2022.09.02.07.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 07:17:54 -0700 (PDT)
Message-ID: <7dae9f3f-88eb-d996-3cb3-89402ea9e31f@gmail.com>
Date:   Fri, 2 Sep 2022 17:20:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 1/2] dmaengine: ti: k3-udma: Respond TX done if
 DMA_PREP_INTERRUPT is not requested
To:     Vaishnav Achath <vaishnav.a@ti.com>, vkoul@kernel.org,
        broonie@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     vigneshr@ti.com, kishon@ti.com
References: <20220822091531.27827-1-vaishnav.a@ti.com>
 <20220822091531.27827-2-vaishnav.a@ti.com>
 <1d4eb194-aab7-42c7-f33f-4b89e607dc6c@gmail.com>
 <37d51cde-de15-0cee-cd4b-ecaf5511fd2b@ti.com>
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <37d51cde-de15-0cee-cd4b-ecaf5511fd2b@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Achath,

On 23/08/2022 09:57, Vaishnav Achath wrote:
> Hi Peter,
> 
> On 22/08/22 18:42, Péter Ujfalusi wrote:
>>
>>
>> On 22/08/2022 12:15, Vaishnav Achath wrote:
>>> When the DMA consumer driver does not expect the callback for TX done,
>>> There is no need to perform the channel RT byte counter calculations
>>> and estimate the completion but return complete on first attempt itself.
>>> This assumes that the consumer who did not request DMA_PREP_INTERRUPT
>>> has its own mechanism for understanding TX completion, example: MCSPI
>>> EOW interrupt can be used as TX completion signal for a SPI transaction.
>>
>> The check is in place to make sure that we don't leave stale data in the
>> DMA fabric.
>> If you drop the check then it is going to be possible that some TX data
>> is going to be lost.
>> Could be one out of 10K transfers or 100K, but if that happens it is not
>> going to be easy to figure out.
>> Let's say we go the packet back, but PDMA is still have data to send and
>> the IP stops transmitting (externally clocked bus, some delay, etc).
>> Is it going to be OK to disable the channel?
>>
> Thanks for the feedback, yes the check is necessary for most of the cases
> but there needs to be  a way to disable the check for consumers which can
> identify the end of transaction using some other internal mechanism/interrupt.
> 
> For example the MCSPI controller has an End of Word(EOW) interrupt when the
> said number of bytes has been clocked out, in this case the EOW interrupt
> being raised guarantees that there is no stale data in DMA fabric.Using
> the EOW interrupt to identify the completion of a transaction significantly
> improves the transaction speed since we need not now wait for the slower DMA
> TX completion calculation.
> 
> This commit tries to bypass the check only if the consumer did not request
> it by not passing the DMA_PREP_INTERRUPT flag, in other cases the check
> should not be bypassed.

Let me think about over the weekend... Do you have performance numbers 
for this change?

If we make sure that this is only affecting non cyclic transfers with a 
in code comment to explain the expectations from the user I think this 
can be safe.

> 
>>>
>>> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
>>> ---
>>>   drivers/dma/ti/k3-udma.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
>>> index 39b330ada200..03d579068453 100644
>>> --- a/drivers/dma/ti/k3-udma.c
>>> +++ b/drivers/dma/ti/k3-udma.c
>>> @@ -263,6 +263,7 @@ struct udma_chan_config {
>>>   	enum udma_tp_level channel_tpl; /* Channel Throughput Level */
>>>   
>>>   	u32 tr_trigger_type;
>>> +	unsigned long tx_flags;
>>>   
>>>   	/* PKDMA mapped channel */
>>>   	int mapped_channel_id;
>>> @@ -1057,7 +1058,7 @@ static bool udma_is_desc_really_done(struct udma_chan *uc, struct udma_desc *d)
>>>   
>>>   	/* Only TX towards PDMA is affected */
>>>   	if (uc->config.ep_type == PSIL_EP_NATIVE ||
>>> -	    uc->config.dir != DMA_MEM_TO_DEV)
>>> +	    uc->config.dir != DMA_MEM_TO_DEV || !(uc->config.tx_flags & DMA_PREP_INTERRUPT))
>>>   		return true;
>>>   
>>>   	peer_bcnt = udma_tchanrt_read(uc, UDMA_CHAN_RT_PEER_BCNT_REG);
>>> @@ -3418,6 +3419,8 @@ udma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>>>   	if (!burst)
>>>   		burst = 1;
>>>   
>>> +	uc->config.tx_flags = tx_flags;
>>> +
>>>   	if (uc->config.pkt_mode)
>>>   		d = udma_prep_slave_sg_pkt(uc, sgl, sglen, dir, tx_flags,
>>>   					   context);
>>
> 

-- 
Péter
