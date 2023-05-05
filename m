Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B1D6F82D5
	for <lists+dmaengine@lfdr.de>; Fri,  5 May 2023 14:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjEEMX0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 May 2023 08:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbjEEMXZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 5 May 2023 08:23:25 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CDC1C0DA
        for <dmaengine@vger.kernel.org>; Fri,  5 May 2023 05:23:23 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bc075d6b2so3262474a12.0
        for <dmaengine@vger.kernel.org>; Fri, 05 May 2023 05:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683289402; x=1685881402;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1HOLYat53OzMdJvFHJRHOISwzlfpZ6pkm9SR4ZOQdmk=;
        b=arXhWxR6k7ZnyjSBCTJhnTuaTBWpGXt66C1xmvs0SgR7Cd7EgjK32zZXJnhck6k8NM
         XDC3AnhtJdPDzPXUOAcDe8Xqm5EbUT8orUHnkKlafZBBdr4yWseqzfZ70txIGEcuyBld
         C7e0y3acOHcGaVwZ0R+J9RIGDSlJ5i7AbcarubtJreyXb+BYjA2X9ttuhVa6MjE3Hih5
         ZbVxZ4KQHFEeQKrYFkKV6niLVgrd3IzcASk9HOjRbPnL1k0rwXPj3fw1uA7LBAYB5d38
         PTTX0JxLCi8cPF6saVKS2Xi/8q19Idx0voC2W9Qzzl/CDZxGHycf0fclvgKDUBt5xJYY
         iZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683289402; x=1685881402;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1HOLYat53OzMdJvFHJRHOISwzlfpZ6pkm9SR4ZOQdmk=;
        b=VpjZ1WHNdEmKbLok0otigKZWJv1SeXSiifmxE+K8tdsutgwq6Y1T6s4ghDma6RDqmX
         LQRJsBocydj/uG2pztljdutRikPsGE3X7H5/N6CIxqN9XpcAmh7JPBNl3vIJIsSD/m9p
         09taPUhwpbOcJcf/WBZQMpuLHs5jb7h+crkqiZ+1WD6MzLeaXcfaHiFofgWkP7cCUsp4
         NHiHuXSjWPH4vkYaYJJ74PH+pr1RP35C9RYfvNJLrn88m+mR2zMpVfQiqOi7+uINaTvb
         HldXYk4UUNeoPxzGnNTnx2HkaYwM2Ofx5Djc2C+Jew+zW0SMqruh9ZhDzBGseWOQrLxv
         JoKg==
X-Gm-Message-State: AC+VfDzS885kltHno1gnMOXJKl/CucSgzNwyWrbvFwEl9JbRuyFinKqe
        d3PgkavnN02b100XdRzb/2c0LA==
X-Google-Smtp-Source: ACHHUZ40WJM3/ZIRvVnyMJtaMV3/I1uRYWfYNrtRy0PWwomfwJ/enziHpy4tGWGVHj6dEUSFfqO4Gw==
X-Received: by 2002:a05:6402:1a27:b0:50b:d5e5:519d with SMTP id be7-20020a0564021a2700b0050bd5e5519dmr1315564edb.4.1683289402136;
        Fri, 05 May 2023 05:23:22 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:52e:24ce:bbc1:127d? ([2a02:810d:15c0:828:52e:24ce:bbc1:127d])
        by smtp.gmail.com with ESMTPSA id x2-20020aa7d6c2000000b0050bd47f9073sm2906899edr.39.2023.05.05.05.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 05:23:21 -0700 (PDT)
Message-ID: <3d9d545d-a620-85f6-b7bd-d57a8729f818@linaro.org>
Date:   Fri, 5 May 2023 14:23:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAOSNQF15UN2Rckes55UHxbUvN1PJcbj9aWirVGSLDOs5Y5EPnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05/05/2023 11:44, Joy Chakraborty wrote:
> On Thu, May 4, 2023 at 8:38 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 04/05/2023 16:57, Joy Chakraborty wrote:
>>> Add 2 new quirks added to the driver "arm,pl330-optimize-dev2mem-axsize"
>>> and "arm,pl330-periph-single-dregs"
>>
>> This we can see from the diff. You need to answer why?
>>
> 
> Sure will change it to:
> "
> Addition of following quirks :
> - "arm,pl330-periph-use-diff-axsize"
>    AxSize of transactions to peripherals are limited by the peripheral
> address width which inturn limits the AxSize used for transactions
> towards memory.
>    This quirk will make transactions to memory use the maximum
> possible bus width(AxSize), store data in MFIFO and use narrow
> multi-beat transactions to move data to peripherals.
>    This only applies to transfers between memory and peripherals where
> bus widths available are different for memory and the peripheral.
> - "arm,pl330-periph-complete-with-singles" :
>    When transfer sizes are not a multiple of a block of burst
> transfers (AxLen * AxSize configured at the peripheral), certain
> peripherals might choose not to set the burst request at the
> peripheral request interface of the DMA.
>    This quirk moves the remaining bytes to the peripheral using single
> transactions.
> "

This does not answer why. You just copied again the patch contents.

> 
>>>
>>> Signed-off-by: Joy Chakraborty <joychakr@google.com>
>>> ---
>>>  Documentation/devicetree/bindings/dma/arm,pl330.yaml | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/dma/arm,pl330.yaml b/Documentation/devicetree/bindings/dma/arm,pl330.yaml
>>> index 4a3dd6f5309b..0499a7fba88d 100644
>>> --- a/Documentation/devicetree/bindings/dma/arm,pl330.yaml
>>> +++ b/Documentation/devicetree/bindings/dma/arm,pl330.yaml
>>> @@ -53,6 +53,14 @@ properties:
>>>      type: boolean
>>>      description: quirk for performing burst transfer only
>>>
>>> +  arm,pl330-optimize-dev2mem-axsize:
>>> +    type: boolean
>>> +    description: quirk for optimizing AxSize used between dev<->mem
>>
>> This tells me nothing... Neither what it is about nor why this is
>> property of a board or PL330 hardware implementation. Please describe
>> hardware, not drivers.
>>
> 
> Will change the name to "arm,pl330-periph-use-diff-axsize" and add description:
> "
> Quirk to use different AxSize for bursts while accessing source and
> destination when moving data between memory and peripheral.
> Maximum possible bus width is used as AxSize for transactions towards
> memory and transactions towards peripherals use AxSize as per
> peripheral address width.
> "

Still no answer. Why this is property of a board or PL330 hardware
implementation?

I also asked to describe hardware but I still see "quirk to ...". We use
"quirk" as concept in Linux driver. Describe the hardware, not Linux driver.


> 
>>> +
>>> +  arm,pl330-periph-single-dregs:
>>> +    type: boolean
>>> +    description: quirk for using dma-singles for peripherals in _dregs()
>>
>> Same concerns.
>>
> 
> Will change the name to  "arm,pl330-periph-complete-with-singles" and
> add description:
> "
> Quirk to use dma singles n times instead of an n beat burst to
> complete a transfer when the transfer size is not a multiple of the

No, how you wrote it sounds like driver. Don't add driver quirks to DT.

Best regards,
Krzysztof

