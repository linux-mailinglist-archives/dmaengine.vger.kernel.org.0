Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FAC6FB56A
	for <lists+dmaengine@lfdr.de>; Mon,  8 May 2023 18:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbjEHQnr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 8 May 2023 12:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjEHQnq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 8 May 2023 12:43:46 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B01A137
        for <dmaengine@vger.kernel.org>; Mon,  8 May 2023 09:43:42 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50bc070c557so9313295a12.0
        for <dmaengine@vger.kernel.org>; Mon, 08 May 2023 09:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683564221; x=1686156221;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gVoO+D6jh3uEddslJ9bTwv8yD6ZuVi0l1fM6VuhGGf4=;
        b=GGaYfMk+0Uz0Wjd739Ki/QmYSPzGx3guAU2fZNDdGkf6iqbiGb8/53QsXPp/Qv7txH
         cuW2Kf4lgzzAoJC+DL92mWsBw+vOBo/2csEN7ty+lfWavbmuLyS6PHFsU5jPW2+f3y4t
         AqEw4/BrUNA059A+g0Xu0WAel96C2SP7urkQ7/6+eDYkqE3dzT/wrOGi4XlADi/xdfRd
         Bm08pye6+7Ym6NKNejgb0CFyav2W5g7tuxWlYr4JFngODNDBYZkWI5RMCz0vMP26L5qI
         BYP+4MjSDqREU2Xa1dCfgps3k5byF1ulu7cLRc/h6rpiDIWQ1uP7yjahTSYdzdgWSK1T
         /kfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683564221; x=1686156221;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gVoO+D6jh3uEddslJ9bTwv8yD6ZuVi0l1fM6VuhGGf4=;
        b=SMu0qe8hHXoNsHPE2gqgq0RdLoERQy9F7A4+vQaNBjAgHjjFhfbU6zzv53Z+tauKH/
         SANa+o+jtZXitstJw12Zs+W1N4vnBpTVcESuUUD3/fmxSy+HTNFtayf3qxfV+D232TyF
         lMgcvL9q6mHLHQYhdKYawRGoYrH7R5j5gwPQE1FHHR0cQISyX1ldE3b+5f6cgsj9aMdj
         UMuuCCNTH1atwd1Fs4k/GuvbKJLCyCl8fig+Qdu7KhuPb/p7MSBs7MgXWXC/w5YPEHzB
         mAHgnMX6CpLWttK+vD9yTntDAmb0dNm8tTbndxuGrPCkEwvsmtW6CSipRFvQZG+xPp2z
         kl8w==
X-Gm-Message-State: AC+VfDyV3TORgN6RwIRbQjKnoF1B8V1xka1+pPl6VfpHc9I4yEzf0nHQ
        VDAggGbiybZKcIerG8ejEbXGqQ==
X-Google-Smtp-Source: ACHHUZ6NwTw9mS39hZgf+cdt+NGK8MML5WdRhZ1Ve61AtKEij9hSPurRFgfb8LwTJJUcUlm+RlyWag==
X-Received: by 2002:a17:906:58cd:b0:966:350f:f42d with SMTP id e13-20020a17090658cd00b00966350ff42dmr6191404ejs.23.1683564221030;
        Mon, 08 May 2023 09:43:41 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:50e0:ebdf:b755:b300? ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id m4-20020a17090679c400b00953381ea1b7sm179654ejo.90.2023.05.08.09.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 09:43:40 -0700 (PDT)
Message-ID: <83b8d419-9d43-3c81-2014-a4380de45b88@linaro.org>
Date:   Mon, 8 May 2023 18:43:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 7/7] dt-bindings: dmaengine: pl330: Add new quirks
Content-Language: en-US
To:     Joy Chakraborty <joychakr@google.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, manugautam@google.com,
        danielmentz@google.com, sjadavani@google.com
References: <20230504145737.286444-1-joychakr@google.com>
 <20230504145737.286444-8-joychakr@google.com>
 <78616bc1-8d9e-4a1c-70d6-ad62c2cfa8a8@linaro.org>
 <CAOSNQF15UN2Rckes55UHxbUvN1PJcbj9aWirVGSLDOs5Y5EPnQ@mail.gmail.com>
 <3d9d545d-a620-85f6-b7bd-d57a8729f818@linaro.org>
 <CAOSNQF0jJLc78_1aGYY3=csJc7WqqvydwxmQ22rvXpLruQ-XRg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAOSNQF0jJLc78_1aGYY3=csJc7WqqvydwxmQ22rvXpLruQ-XRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 08/05/2023 13:58, Joy Chakraborty wrote:
> On Fri, May 5, 2023 at 5:53 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 05/05/2023 11:44, Joy Chakraborty wrote:
>>> On Thu, May 4, 2023 at 8:38 PM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 04/05/2023 16:57, Joy Chakraborty wrote:
>>>>> Add 2 new quirks added to the driver "arm,pl330-optimize-dev2mem-axsize"
>>>>> and "arm,pl330-periph-single-dregs"
>>>>
>>>> This we can see from the diff. You need to answer why?
>>>>
>>>
>>> Sure will change it to:
>>> "
>>> Addition of following quirks :
>>> - "arm,pl330-periph-use-diff-axsize"
>>>    AxSize of transactions to peripherals are limited by the peripheral
>>> address width which inturn limits the AxSize used for transactions
>>> towards memory.
>>>    This quirk will make transactions to memory use the maximum
>>> possible bus width(AxSize), store data in MFIFO and use narrow
>>> multi-beat transactions to move data to peripherals.
>>>    This only applies to transfers between memory and peripherals where
>>> bus widths available are different for memory and the peripheral.
>>> - "arm,pl330-periph-complete-with-singles" :
>>>    When transfer sizes are not a multiple of a block of burst
>>> transfers (AxLen * AxSize configured at the peripheral), certain
>>> peripherals might choose not to set the burst request at the
>>> peripheral request interface of the DMA.
>>>    This quirk moves the remaining bytes to the peripheral using single
>>> transactions.
>>> "
>>
>> This does not answer why. You just copied again the patch contents.
>>
> Hi Krzysztof,
> Both the changes could be useful for SOC's which have PL330 integrated
> with a peripheral 

What do you mean here by "PL330 integrated with a peripheral"?

> but I am not sure if all SOC's need/want this change
> hence wanted to keep it as a DT knob to avoid any regressions.
> But like you say it might not be the right thing to do.

Devicetree is for describing hardware, not the contents of registers of
a device. Your changes might fit or might not, I don't know this good
enough, so I wait for your justification. Without justification this
looks like controlling driver from DT...

> 
>>>
>>>>>
>>>>> Signed-off-by: Joy Chakraborty <joychakr@google.com>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/dma/arm,pl330.yaml | 8 ++++++++
>>>>>  1 file changed, 8 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/dma/arm,pl330.yaml b/Documentation/devicetree/bindings/dma/arm,pl330.yaml
>>>>> index 4a3dd6f5309b..0499a7fba88d 100644
>>>>> --- a/Documentation/devicetree/bindings/dma/arm,pl330.yaml
>>>>> +++ b/Documentation/devicetree/bindings/dma/arm,pl330.yaml
>>>>> @@ -53,6 +53,14 @@ properties:
>>>>>      type: boolean
>>>>>      description: quirk for performing burst transfer only
>>>>>
>>>>> +  arm,pl330-optimize-dev2mem-axsize:
>>>>> +    type: boolean
>>>>> +    description: quirk for optimizing AxSize used between dev<->mem
>>>>
>>>> This tells me nothing... Neither what it is about nor why this is
>>>> property of a board or PL330 hardware implementation. Please describe
>>>> hardware, not drivers.
>>>>
>>>
>>> Will change the name to "arm,pl330-periph-use-diff-axsize" and add description:
>>> "
>>> Quirk to use different AxSize for bursts while accessing source and
>>> destination when moving data between memory and peripheral.
>>> Maximum possible bus width is used as AxSize for transactions towards
>>> memory and transactions towards peripherals use AxSize as per
>>> peripheral address width.
>>> "
>>
>> Still no answer. Why this is property of a board or PL330 hardware
>> implementation?
>> I also asked to describe hardware but I still see "quirk to ...". We use
>> "quirk" as concept in Linux driver. Describe the hardware, not Linux driver.
>>
> 
> This comes to use when the bus width requirement between peripheral
> and memory is different, but buswidth is something we read from HW
> registers so this can be enabled by default.

Don't add discoverable stuff to DT.

> 
>>
>>>
>>>>> +
>>>>> +  arm,pl330-periph-single-dregs:
>>>>> +    type: boolean
>>>>> +    description: quirk for using dma-singles for peripherals in _dregs()
>>>>
>>>> Same concerns.
>>>>
> 
> An example of such a case is given in the ARM TRM for PL330, so maybe
> we can have this by default as well.
> Link : https://developer.arm.com/documentation/ddi0424/d/functional-overview/peripheral-request-interface/dmac-length-management#:~:text=DMAC%20length%20management-,Example%202.3,-shows%20a%20DMAC

I could not find here a case describing hardware. You pointed out some
code. What does the code have anything to do with DT?


Best regards,
Krzysztof

