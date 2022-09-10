Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7585B47FF
	for <lists+dmaengine@lfdr.de>; Sat, 10 Sep 2022 20:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiIJS5V (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 10 Sep 2022 14:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiIJS5U (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 10 Sep 2022 14:57:20 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7DF48E8B;
        Sat, 10 Sep 2022 11:57:19 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id r12so4330596ljg.10;
        Sat, 10 Sep 2022 11:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=76A7GHL2L8UG4HVxO3h23qrqx49uxNUAVqmZcmf8l6U=;
        b=TjOuJww3nWJHgG+FYP1gCAMtJH+Q+xFJW3lnvKQ/G5yTA272GC1mNIiBsOBT1sDJzh
         8HW1/yJH5KBCMj8GApH/A3y50dbEMJ/xVxCCTbC0XhYITOxcPq6q6AQFyKQfCmAN5HcW
         j6gG0VDtE+vEPAgAyYKJ8uHULs2zp3bkmR64+8NuJ82eYFieNc/e4QEvn5aom3QQSTaM
         yOQGoi96Hh7h84ZNAQUoK1kPtb8+JDerUtyNGxpgk+B1HgT5Fh948lsYD9iCkacI5nvp
         ys0HQXn9nAoKA8wzEqjMUpi8p8zSDLMdVpF/1OqVYOytfLHkIr8seEjUGK+GHOeLo7y0
         OMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=76A7GHL2L8UG4HVxO3h23qrqx49uxNUAVqmZcmf8l6U=;
        b=8MM23qg8NtoCBbGAidrRggV9jOCtChlIRy7EIUuy/ywWEXtegMdO5F8esfL+Dp28j9
         LdpTyCCndL51UJQwBcu1ESh5tMZA5HNeYNvpD/WYeCFLWQMoUidWme70zV5xZBI7Ng/C
         BedkXGQgc6KBdeVyJ65NCAGwL7x9WRJHNZ0fxX03aCy6jFSvstIrNXivcu4LHxkeCSjm
         oAeRQG/huDNrKOI3sU+NOuVydReOHj6e7UIpYyetwNa2tOQ/HiQ/hSYmgb3XNxS35oUz
         Xo8ZKAaQjvObd3BYh/sNDJAPdox2xF22vOd0+BJqOQlausu+Ly+u2cS/cIjB3uq1oq4N
         o+XA==
X-Gm-Message-State: ACgBeo0FN0VcL1MgchWO99j+Yp46YRFj8hfxqXUgyGSlpXgYYUCjMvwp
        9huvTqyZiThRoFdu8L4jHslfX6gOqxk=
X-Google-Smtp-Source: AA6agR7W6fJ3B5cqBLv/4P5bQQ4nOFhj2xFa1XuN3q9MBC7JKe+GdIixZuAvn7LnH2QaJlP9HrD4iw==
X-Received: by 2002:a2e:9a90:0:b0:26b:efd1:18fc with SMTP id p16-20020a2e9a90000000b0026befd118fcmr1131472lji.499.1662836237567;
        Sat, 10 Sep 2022 11:57:17 -0700 (PDT)
Received: from [10.0.0.127] (91-159-150-230.elisa-laajakaista.fi. [91.159.150.230])
        by smtp.gmail.com with ESMTPSA id m7-20020a056512358700b0049476667228sm345057lfr.65.2022.09.10.11.57.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 11:57:15 -0700 (PDT)
Message-ID: <607af3f8-9fb2-da00-1867-5ab59ce9d3e8@gmail.com>
Date:   Sat, 10 Sep 2022 21:57:20 +0300
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
 <7dae9f3f-88eb-d996-3cb3-89402ea9e31f@gmail.com>
 <a30e917d-e031-3829-36fb-b897e971825f@ti.com>
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <a30e917d-e031-3829-36fb-b897e971825f@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 05/09/2022 06:02, Vaishnav Achath wrote:
>> Let me think about over the weekend... Do you have performance numbers for this
>> change?
>>
> Thank you, yes we tested mainly for the SPI cases(Master and Slave mode), there
> we saw a peak delay of 400ms for transaction completion and this varied with CPU
> load, after adding the patch to not wait for DMA TX completion and use EOW
> interrupt the peak latency reduced to 2ms.

Thank you for the details.

>> If we make sure that this is only affecting non cyclic transfers with a in code
>> comment to explain the expectations from the user I think this can be safe.
>> \
> Sure I will add this in the next revision.

You can add my Acked-by when you send the next version:
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

>>>
>>>>>
>>>>> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
>>>>> ---
>>>>>    drivers/dma/ti/k3-udma.c | 5 ++++-
>>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
>>>>> index 39b330ada200..03d579068453 100644
>>>>> --- a/drivers/dma/ti/k3-udma.c
>>>>> +++ b/drivers/dma/ti/k3-udma.c
>>>>> @@ -263,6 +263,7 @@ struct udma_chan_config {
>>>>>        enum udma_tp_level channel_tpl; /* Channel Throughput Level */
>>>>>          u32 tr_trigger_type;
>>>>> +    unsigned long tx_flags;
>>>>>          /* PKDMA mapped channel */
>>>>>        int mapped_channel_id;
>>>>> @@ -1057,7 +1058,7 @@ static bool udma_is_desc_really_done(struct udma_chan
>>>>> *uc, struct udma_desc *d)
>>>>>          /* Only TX towards PDMA is affected */
>>>>>        if (uc->config.ep_type == PSIL_EP_NATIVE ||
>>>>> -        uc->config.dir != DMA_MEM_TO_DEV)
>>>>> +        uc->config.dir != DMA_MEM_TO_DEV || !(uc->config.tx_flags &
>>>>> DMA_PREP_INTERRUPT))
>>>>>            return true;
>>>>>          peer_bcnt = udma_tchanrt_read(uc, UDMA_CHAN_RT_PEER_BCNT_REG);
>>>>> @@ -3418,6 +3419,8 @@ udma_prep_slave_sg(struct dma_chan *chan, struct
>>>>> scatterlist *sgl,
>>>>>        if (!burst)
>>>>>            burst = 1;
>>>>>    +    uc->config.tx_flags = tx_flags;
>>>>> +
>>>>>        if (uc->config.pkt_mode)
>>>>>            d = udma_prep_slave_sg_pkt(uc, sgl, sglen, dir, tx_flags,
>>>>>                           context);
>>>>
>>>
>>
> 

-- 
Péter
