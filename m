Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34576AE561
	for <lists+dmaengine@lfdr.de>; Tue,  7 Mar 2023 16:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjCGPv7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Mar 2023 10:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjCGPv5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Mar 2023 10:51:57 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AD98C514
        for <dmaengine@vger.kernel.org>; Tue,  7 Mar 2023 07:51:54 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id g3so54226854eda.1
        for <dmaengine@vger.kernel.org>; Tue, 07 Mar 2023 07:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678204313;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RcDQzVN19ofjg8Tgdw5tyOv/MuABZ5E/YdFtUvot80Q=;
        b=YFJygNIbp45Ch4nXFzOoHjdOtcWm38mODz32cOZACaptJnRWrDMIWR9xzC4+D1aXyB
         QUoUK6gEMMp6rabx4Hr1Uz50KlcGeOnUBPx6RCXOvBYGZoTgaraSCT15eVcTXieGo/SL
         id7Gt85z552OTBu98ZiqtTYdE/Rhc6Zs5a8SEJADZGQuUa+F5qIXCihEUGKlveW5/iV/
         T0h0Y9Oj3oolzzrWona14BG8KcuHcbW3eB9CRfoQeevRX0ceBnu82fIRdw5DMS0LRWaF
         gYlqrLdNrMBBxjA2SuK2d4T29F372atFGo7OYkpIJcpyXfN2qiFVfh4bKq3V/HfejG2C
         +VjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678204313;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RcDQzVN19ofjg8Tgdw5tyOv/MuABZ5E/YdFtUvot80Q=;
        b=nGkFev/DDa73g8GMFFUFoW/DZDG1BgRd0jGdPubEZVsiCO3DEHXMMjQ9SKpXyNuioK
         z0Fu2Ozz1OXuEaEa39HBGYsjhUYFLrCBZko/TOJgiPONkR6ER88xAiZGj2U5ZOCI7egt
         oramwT2ZiQW/sn9m9ihfTtO34axRMhDqWUnziafESVnzIkBkoAruE3A5ahYey6y2WelX
         i+2boco4VRGpqPbUdhROzNp/8KH3dZTB2ZmI6ORe/gqoKjUh4WujQPC03DqXuKmm3M/M
         B0kjxjUebS4ke1zzIe9ZFRRSvP0v6raac/UUA7AE213p0M1+MFZNFHS8ffMnb9ZcG29Q
         MztQ==
X-Gm-Message-State: AO0yUKWuZ6PIK2jlqx1ET21oJcsYyOPofDUJxQO5SSKqa2kjLCo9ZLlw
        //ZGj1PaVAbUnA2QAowUBXpgPQ==
X-Google-Smtp-Source: AK7set9L4TCnhGG3SxprVoNK/2nNWxTQQ0uvBtCv1oRmv5bm89yo39bZ/2uW8VInhxLWFZixBqCbUw==
X-Received: by 2002:a17:907:86a5:b0:8b1:7fe9:ac69 with SMTP id qa37-20020a17090786a500b008b17fe9ac69mr19571063ejc.75.1678204313020;
        Tue, 07 Mar 2023 07:51:53 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:a60f:e604:c252:1f3d? ([2a02:810d:15c0:828:a60f:e604:c252:1f3d])
        by smtp.gmail.com with ESMTPSA id qw15-20020a170906fcaf00b008d57e796dcbsm6238380ejb.25.2023.03.07.07.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 07:51:52 -0800 (PST)
Message-ID: <e3da08df-a5cb-3fbd-2356-64416f48c073@linaro.org>
Date:   Tue, 7 Mar 2023 16:51:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 1/3] dt-bindings: dma: snps,dw-axi-dmac: constrain
 resets items for JH7110 dma
Content-Language: en-US
To:     Walker Chen <walker.chen@starfivetech.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20230306140430.28951-1-walker.chen@starfivetech.com>
 <20230306140430.28951-2-walker.chen@starfivetech.com>
 <b2b36909-b0b1-7507-3145-141eb5ec0f3f@linaro.org>
 <0725e451-7c0b-0aac-ecd3-502b02276a9a@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0725e451-7c0b-0aac-ecd3-502b02276a9a@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07/03/2023 11:30, Walker Chen wrote:
> 
> 
> On 2023/3/7 17:03, Krzysztof Kozlowski wrote:
>> On 06/03/2023 15:04, Walker Chen wrote:
>>> The DMA controller needs two reset items to work properly on JH7110 SoC,
>>> so there is need to constrain the items' value to 2, other platforms
>>> have 1 reset item at most.
>>>
>>> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
>>> ---
>>>  .../bindings/dma/snps,dw-axi-dmac.yaml        | 24 +++++++++++++++----
>>>  1 file changed, 20 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
>>> index ad107a4d3b33..d8b5439f215c 100644
>>> --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
>>> +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
>>> @@ -12,14 +12,12 @@ maintainers:
>>>  description:
>>>    Synopsys DesignWare AXI DMA Controller DT Binding
>>>  
>>> -allOf:
>>> -  - $ref: "dma-controller.yaml#"
>>> -
>>>  properties:
>>>    compatible:
>>>      enum:
>>>        - snps,axi-dma-1.01a
>>>        - intel,kmb-axi-dma
>>> +      - starfive,jh7110-axi-dma
>>>  
>>>    reg:
>>>      minItems: 1
>>> @@ -58,7 +56,8 @@ properties:
>>>      maximum: 8
>>>  
>>>    resets:
>>> -    maxItems: 1
>>> +    minItems: 1
>>> +    maxItems: 2
>>>  
>>>    snps,dma-masters:
>>>      description: |
>>> @@ -109,6 +108,23 @@ required:
>>>    - snps,priority
>>>    - snps,block-size
>>>  
>>> +allOf:
>>> +  - $ref: "dma-controller.yaml#"
>>
>> Rebase your patches on something recent... I would argue that it should
>> be based on maintainer's (or linux-next) tree, but that would be too
>> good to be true.
> 
> This was written by referring to the syntax of other dt-binding, but your suggestion 
> is a good one, the next version of patches will be rebased on kernel 6.3.

Rebasing on old kernel was referring to syntax of other binding? I don't
understand this. How old code which you copied is related anyhow to
other binding? You are expected to send patches always based on recent
one, not something old.

> 
>>
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - starfive,jh7110-axi-dma
>>> +    then:
>>> +      properties:
>>> +        resets:
>>> +          minItems: 2
>>
>> What are the items expected here?
> 
> Do you mean to add descriptions for items here ?

Yes, because order of the items is fixed.



Best regards,
Krzysztof

