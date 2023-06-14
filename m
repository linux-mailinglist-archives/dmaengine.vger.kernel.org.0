Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E3372F50A
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jun 2023 08:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243333AbjFNGkX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jun 2023 02:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242549AbjFNGjq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Jun 2023 02:39:46 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBB010E3
        for <dmaengine@vger.kernel.org>; Tue, 13 Jun 2023 23:39:45 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f61b45ee0dso8025399e87.0
        for <dmaengine@vger.kernel.org>; Tue, 13 Jun 2023 23:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686724783; x=1689316783;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Q8Ite1Y2wooAZNS/2RrLNMbn3Ax42VQdzwJmVMSBFY=;
        b=lfk7ZaXsqgxVJ2Go/4Vk4ajvcbFYZlHMDvkZO9hw8UNxtHawnH/CViSGFam+265v6T
         Pwohy158+Dy8W8vDlkz8lRfR+fqkdu9dr9ZscDNbySYAumEffLLsVI3fd9AptFOFCERV
         fF/7tDTj83x+tlIm6318ki75AFwjLEW2E+Lic14eQfk7im2xaPgzW41CONpN+enlPNj8
         Yt3t2GaNBYhqyusLRyyCcslZks6C89BQIZjfpSnc7120bAhElHMIcsFA87VAR3bH8ZV1
         He6cEe+gtHU+IpyIJHb/9nSGtsUmU1dKbOmTbrnlI5m9YbEs3Kz7GhkNZxUpmxsdSJcR
         ZP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686724783; x=1689316783;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Q8Ite1Y2wooAZNS/2RrLNMbn3Ax42VQdzwJmVMSBFY=;
        b=Ms13/RMaTPUvgyI8dQFWvf4qLEhuqX0XXlTxJFfUD+khKMyYcDT+T/VciQG/w7+tll
         cw8ZeznGfKgd5Ja8uTXFEAEghBhsfVl6tbVcH+o9mjkwNm40Cu8tQ1eqAf/l/28UGDCq
         Tl8onqDZdhlPl3KlR2drknSuYQapdyKiX6m/jvY90cosnXwI6SVTV/wSq6vRVHK923hO
         VJLxIkB0K5mq8DPWLSjxbYFH3YVf8jjblqyr6zVQMKBptrZptJ9Z9Lxk9PYvEi7ag34O
         JSNYq+4Y+DOcoz9V41suCQMwN2syeRr1DTYZwFj+w1udfZm+g3+1bmHK6APrcDloHkcW
         DjsA==
X-Gm-Message-State: AC+VfDzRL4Os0d///IZQFYpWAdPFohQYc9DFIX9L3z3Lxwz7/Do2yD0z
        5Ngd5H5m9LqSdwhlHv2MTJgLFA==
X-Google-Smtp-Source: ACHHUZ6OLlLpfxP5/b76GWeAGDJQ++2yHCREYPo2cXWux82fNIjP/1qeMBe9cGMnVm76aZG3s1I8MA==
X-Received: by 2002:a19:da12:0:b0:4f7:4098:9905 with SMTP id r18-20020a19da12000000b004f740989905mr5251736lfg.65.1686724783462;
        Tue, 13 Jun 2023 23:39:43 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id m12-20020a50ef0c000000b0051891fc318dsm387145eds.23.2023.06.13.23.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 23:39:42 -0700 (PDT)
Message-ID: <95bd381d-0851-dca7-031d-0da5060237fe@linaro.org>
Date:   Wed, 14 Jun 2023 08:39:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 12/12] dt-bindings: fsl-dma: fsl-edma: add edma3
 compatible string
Content-Language: en-US
To:     Frank Li <Frank.li@nxp.com>
Cc:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
References: <20230613213149.2076358-1-Frank.Li@nxp.com>
 <20230613213149.2076358-13-Frank.Li@nxp.com>
 <b3a25a5a-d39a-81bd-0593-7a4b76aeb9bf@linaro.org>
 <ZIjnNzemHm17MNzV@lizhi-Precision-Tower-5810>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZIjnNzemHm17MNzV@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14/06/2023 00:01, Frank Li wrote:
> On Tue, Jun 13, 2023 at 11:43:31PM +0200, Krzysztof Kozlowski wrote:
>> On 13/06/2023 23:31, Frank Li wrote:
>>> Extend Freescale eDMA driver bindings to support eDMA3 IP blocks in
>>> i.MX8QM and i.MX8QXP SoCs. In i.MX93, both eDMA3 and eDMA4 are now.
>>>
>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>>> ---
>>>  .../devicetree/bindings/dma/fsl,edma.yaml     | 118 +++++++++++++++---
>>>  1 file changed, 100 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
>>> index 5fd8fc604261..2f79492fb332 100644
>>> --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
>>> +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
>>> @@ -21,32 +21,20 @@ properties:
>>>        - enum:
>>>            - fsl,vf610-edma
>>>            - fsl,imx7ulp-edma
>>> +          - fsl,imx8qm-adma
>>> +          - fsl,imx8qm-edma
>>> +          - fsl,imx93-edma3
>>> +          - fsl,imx93-edma4
>>>        - items:
>>>            - const: fsl,ls1028a-edma
>>>            - const: fsl,vf610-edma
>>>  
>>> -  reg:
>>> -    minItems: 2
>>> -    maxItems: 3
>>> -
>>> -  interrupts:
>>> -    minItems: 2
>>> -    maxItems: 17
>>
>> What is happening here?
> 
> I found dt_check always check this part firstly, then check allOf.
> 
>>
>>> -
>>> -  interrupt-names:
>>> -    minItems: 2
>>> -    maxItems: 17
>>> -
>>> -  "#dma-cells":
>>> -    const: 2
>>> -
>>> -  dma-channels:
>>> -    const: 32
>>
>> No, why all these are being removed?
> 
> I move common part ahead of if-then-else branch to read early.
> 
>>
>>> -
>>>    clocks:
>>> +    minItems: 1
>>>      maxItems: 2
>>>  
>>>    clock-names:
>>> +    minItems: 1
>>>      maxItems: 2
>>>  
>>>    big-endian:
>>> @@ -55,6 +43,43 @@ properties:
>>>        eDMA are implemented in big endian mode, otherwise in little mode.
>>>      type: boolean
>>>  
>>> +if:
>>
>> This should not be outside of your allOf. This patch looks entirely
>> different than your v4 and I don't really understand why.
>>
> 
> allOf looks like addtional constraints addition to previous define.
> for example: 
>     if previous interrupts is 17, I can't overwrite to bigger value 64
> in this sesson. 

Yes, because the top-level had wrong constraint. Fix top-level, don't
remove it.

> 
> previous version: dts check report two error, 
> first: interrupt is too long. (look like check top one)
> then: interrupt is too short. (look like check allOf part)
> 
>>
>>> +  properties:
>>> +    compatible:
>>> +      contains:
>>> +        enum:
>>> +          - fsl,imx8qm-adma
>>> +          - fsl,imx8qm-edma
>>> +          - fsl,imx93-edma3
>>> +          - fsl,imx93-edma4
>>> +then:
>>> +  properties:
>>> +    reg:
>>> +      maxItems: 1
>>> +    interrupts:
>>> +      minItems: 1
>>> +      maxItems: 64
>>
>> What's more, you don't have these properties defined in top-level.
>> Sorry, they should not be moved. I did not ask for this.
> 
> It is there. 
> if-then-else before "required"

It's in if, not in top-level properties.


Best regards,
Krzysztof

