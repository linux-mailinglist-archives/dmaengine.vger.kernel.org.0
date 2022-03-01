Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C294C9444
	for <lists+dmaengine@lfdr.de>; Tue,  1 Mar 2022 20:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbiCATbF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Mar 2022 14:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbiCATbE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Mar 2022 14:31:04 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13F847069;
        Tue,  1 Mar 2022 11:30:22 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id r20so23275763ljj.1;
        Tue, 01 Mar 2022 11:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=R3P3YCKu/ibJWsGM92IPxsRHeUIexlT8V/EvXV5724w=;
        b=ZEjOreQ1AxhxOzefKMoPIckI3u/lrqaYvjW1QppEUk+t608ZGtENGqCGWThmrUxtB4
         aoA20y8AzmPzAZj1Op0ilfwTQC5vMqTGrmDNY6WSXS3x8NPR8lq8LKtSz4tWlHL3KtHL
         MeFq15JBWslEZDjkClArx6VnUL7/rrxlE3X96n+m2KUGJgGjku4diIPQGV3+02qKQzLj
         oNuilhlvvr1C1O5lhHOMu8mBoukfkes8v2OXH1hHAgewU3BDuCGzlm6DEMiygGPPrHk0
         Xa6G5m37L5v8iw8MwtZ2Q3MX6UThpLm2yC8vGyZf6FPUNY/hhZXh3NRLZid1RlpJkEWd
         Xztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=R3P3YCKu/ibJWsGM92IPxsRHeUIexlT8V/EvXV5724w=;
        b=dQVshW3fcbj3tBC6R7kgIy4/J6VMv0Y3+bfeHoXgX9vJsliE3NWAc3sZd5XZ1qmkIk
         vK5u0xniJflcdVEg7RlZ88MiHYndAqFgtIE47xbMO8nQudkgg3dAbALveibqvJu5+ey9
         6nlGZSB1x0HrC01TuXwYKbDkRcRWfzMgBz8J50pv3DemhCzscsHDFn62BKDzY4ospTXJ
         9o8e3YJ/Yr06u/z5z9yetwXY5STwwB1p4wXoscEwbIBYvW7P2DjZfCn/CyIHBXUgV0nh
         bXr0UaCuVPf1no1i9pkfpJnEbpN463LkuvscB9gYcP4BqYpbWjXwbr4+EGK60hcdswdu
         iCIw==
X-Gm-Message-State: AOAM532xMbIacAJamWNNSFUzAXZzm52XILpQ7TnlwoQvM3/bjmFkUa2q
        C3Kg60Hhz79RVzjsdNVm0NQO8Rs/d3VY3g==
X-Google-Smtp-Source: ABdhPJzTJmqcwQVNGbFY+t+Uj1L1YrI7rsDWBvt28luWaHZuHWJYmYW2b7XnI/iVVkmEbwLxufuU9Q==
X-Received: by 2002:a05:651c:1603:b0:246:652c:853 with SMTP id f3-20020a05651c160300b00246652c0853mr17651003ljq.202.1646163013755;
        Tue, 01 Mar 2022 11:30:13 -0800 (PST)
Received: from [10.0.0.127] (91-159-150-230.elisa-laajakaista.fi. [91.159.150.230])
        by smtp.gmail.com with ESMTPSA id k3-20020a05651239c300b00443c5f9175bsm1641015lfu.46.2022.03.01.11.30.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 11:30:13 -0800 (PST)
Message-ID: <4938f187-21f6-a97b-1a9d-e191353f1b5e@gmail.com>
Date:   Tue, 1 Mar 2022 21:31:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Jayesh Choudhary <j-choudhary@ti.com>
References: <20220215044112.161634-1-vigneshr@ti.com>
 <58fe0934-4853-714c-600d-9a2d86df5bc8@gmail.com>
 <35276e1e-e37c-f8e7-c452-799f8e778465@ti.com>
 <bfd85a56-5d78-695a-8687-ae05832a32c9@ti.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Avoid false error msg on chan
 teardown
In-Reply-To: <bfd85a56-5d78-695a-8687-ae05832a32c9@ti.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Vignesh,

On 28/02/2022 13:18, Vignesh Raghavendra wrote:
> 
> 
> On 28/02/22 2:52 pm, Vignesh Raghavendra wrote:
>> Hi Peter,
>>
>> On 21/02/22 1:42 am, Péter Ujfalusi wrote:
>>> Hi Vignesh,
>>>
>>> On 15/02/2022 06:41, Vignesh Raghavendra wrote:
>>>> In cyclic mode, there is no additional descriptor pushed to collect
>>>> outstanding data on channel teardown. Therefore no need to wait for this
>>>> descriptor to come back.
>>>>
>>>> Without this terminating aplay cmd outputs false error msg like:
>>>> [  116.402800] ti-bcdma 485c0100.dma-controller: chan1 teardown timeout!
>>>
>>> are you sure it is aplay? It is MEM_TO_DEV, we only use the flush
>>> descriptor for DEV_TO_MEM. MEM_TO_DEV can 'disconnect' from the
>>> peripheral to flush out the FIFO.
>>>
>>
>> Yes, this is with aplay. You are right that MEM_TO_DEV should have
>> worked w/o this patch.
>>
>>
>>> I have not seen this on am654, j721e. I can not recall seeing this on
>>> the capture side either.
>>>
>>
>> I dont see it either
>>
>>> The cyclic TR should be able to drain the DEV_TO_MEM by itself and the
>>> TR should terminate.
>>>
>>
>> You are right. There seems to be a trobule with McASP + BCDMA on AM62
>> which needs more investigation. I see
>>
>>  RT c0000000 peer RT 90000000
>>  BCNT 5dc00, peer BCNT 46400

In case of MEM_TO_DEV stop we set the peer DMA (PDMA) to flush and set
the UDMA/BCDMA/PKTDMA to tdown.
If the flush is set for the PDMA, it will (should) disconnect it's
trigger from the peripheral and 'free run' to flush all data.

Afaik the PDMA on am62 is the same as it is on j721e, no?

>> So there is some data stuck in pipe which prevents channel from
>> disabling and TDCM being signaled. My guess is McASP is no longer
>> requesting more data from PDMA. Any way to look at McASP FIFO state/ DMA
>> req enable state? Wondering what else can prevent draining of data.
>>
>> One difference is that AM62 has ti,tlv320aic3106 codec (codec is the
>> master) where J7 uses PCM.
>>
> 
> I see couple of issues with DMA usage by McASP/sound:
> 
> McASP TX FIFO events are disabled first and then DMA channel is stopped.
> This does not work for K3 SoCs as some data remains stuck in DMA pipe
> and channel never goes to disable state.

You can not really stop the DMA first because the McASP would undeflow
right away. The McASP FIFO should be in bypass mode for K3 devices, the
PDMA can handle the feeding of McASP just fine.

One of the reasons to have the FLUSH on the peer (PDMA) side is exactly
this: to be able to drain the MEM_TO_DEV DMA FIFO to /dev/null even if
the peripheral is long gone (disabled, even powered down).

> I see .stop_dma_first flag in snd_soc_dai_link to force DMA to be
> stopped first, but I am not quite familiar on where to set this flag?

The stop_dma_first might work, but it is actually added to support pxa
(I think?) where they have two separate DMAs on two side of an external
FIFO. The DMAengine side need to be stopped first and then they have
open coded DMA code to busy loop to wait for the other DMA (non
DMAengine) to drain out the data.

> Even so, snd_dmaengine_pcm_trigger() calls dmaengine_terminate_async()
> and does not call dmaengine_synchronize() before disabling McASP TX, so
> channel teardown would still be unsuccessful.

We can not do a dmaengine_synchronize() in pcm.trigger as it is in
atomic context and we can not sleep.

> Alternately, we could reduce dev_warn() in udma_synchronize() to
> dev_dbg() as channel is still recoverable via  udma_reset_chan() which
> is done immediately after.
> There is a further dev_warn() message to indicate if channel refused to
> stop even after a reset?

The problem is that it is also possible that after a forced shutdown the
channel is not going to work anymore (we have this issue with am65, if I
recall right).

I would consult with the hardware team to understand what is going on,
make sure that the McASP AFIFO is disabled (evnums are 0).

If it is really something in the hardware that behaves differently in
am62 then add a quirk to handle it and implement a workaround.

> 
> Regards
> Vignesh
> 
>> Regards
>> Vignesh
>>
>>
>>>
>>>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>>>> ---
>>>>  drivers/dma/ti/k3-udma.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
>>>> index 9abb08d353ca0..c9a1b2f312603 100644
>>>> --- a/drivers/dma/ti/k3-udma.c
>>>> +++ b/drivers/dma/ti/k3-udma.c
>>>> @@ -3924,7 +3924,7 @@ static void udma_synchronize(struct dma_chan *chan)
>>>>  
>>>>  	vchan_synchronize(&uc->vc);
>>>>  
>>>> -	if (uc->state == UDMA_CHAN_IS_TERMINATING) {
>>>> +	if (uc->state == UDMA_CHAN_IS_TERMINATING && !uc->cyclic) {
>>>>  		timeout = wait_for_completion_timeout(&uc->teardown_completed,
>>>>  						      timeout);
>>>>  		if (!timeout) {
>>>

-- 
Péter
