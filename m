Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096CB645509
	for <lists+dmaengine@lfdr.de>; Wed,  7 Dec 2022 09:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiLGIDm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Dec 2022 03:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiLGIDl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 7 Dec 2022 03:03:41 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45F729367
        for <dmaengine@vger.kernel.org>; Wed,  7 Dec 2022 00:03:39 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id cf42so21688341lfb.1
        for <dmaengine@vger.kernel.org>; Wed, 07 Dec 2022 00:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yn9nDIGn57BVhUGGyUSUzD23S1rxXpzrdnXEfSzJBj0=;
        b=UIW5zMXgASAy+T2xjE2boa7e+J0qIv/9iCmwUo7tlbUZebVcBBNhTJP+sxPJmP0tZQ
         k8njJByoFb+Ie9stov3JZI0U54YrvKHw8QEenO03owZGsMQOXOSx4H5m5nie5n/lysPm
         pAtT26EDd+qJ7efs4OWJpO+mxCIx420wLdmUghd/z57NdlUTn/BM7Jt9OBobtM8cb2H/
         Us8yg3iPm5mmcyjvHoVmfqrGcd1l9tX/Rojlio0NSvauNYu/vw7jhDQzVGWi0+J149Li
         30/1cPK6aFfjxZbWgB1vcMmRkeQ+El2UeTxuVIfUTN4H23TKeluHhsEu8RNjroftQBy0
         g63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yn9nDIGn57BVhUGGyUSUzD23S1rxXpzrdnXEfSzJBj0=;
        b=08oQsCU0jlrApNgb1LtIs3O5rlMqb0AWJfDNvJOrM6HCbSJmjuoYi7kGt8aZu23lLi
         4cQgX9M6m5RMcWGpWAgtBbfvi5mnyqLBwYh6F7V16/RGG5GeX/zonuHz3apyZTnzNBv/
         JdeeSrWaSC6//NjyQWimftRO1IcBQ+EQVGL8xi3MD+Z19LS5Sapk72fDRSoyUOFnJgn7
         tIsxRa8tf3b7+FKGZtLh2bxEgQt2LTlXivZUT1ugzoSaWd/kOXOfqMsaseqcTZ6MsMrS
         fR33fYWF2p1IrLO+uU2NMU1lKLhObfPEsAd3mbY5o9+rdJNoAXWwqANs0586It8XPSIk
         u/SQ==
X-Gm-Message-State: ANoB5plFnpxJrxVWNbDr3cczXF6ZirDxPkwTiR2xcieMw063kpu28g4U
        AS2WjD8HyAQ4qP0TOsSgkahiPw==
X-Google-Smtp-Source: AA0mqf5NJN1ww/UQ0wHfpUCGJftcWeph6OoozsXSushoSpf3klqVk//uK8UNhsA/fIpfwc9vl3w7jg==
X-Received: by 2002:a19:4f5d:0:b0:4b5:6704:e547 with SMTP id a29-20020a194f5d000000b004b56704e547mr5078003lfk.494.1670400218155;
        Wed, 07 Dec 2022 00:03:38 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f19-20020ac251b3000000b004b583198d83sm636556lfk.186.2022.12.07.00.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 00:03:37 -0800 (PST)
Message-ID: <cd6e259f-4216-17c2-fab0-a952c0177fee@linaro.org>
Date:   Wed, 7 Dec 2022 09:03:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/5] dt-bindings: dma: ti: k3-bcdma: Add bindings for
 BCDMA CSI RX
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221206043554.1521522-1-vigneshr@ti.com>
 <20221206043554.1521522-2-vigneshr@ti.com>
 <63e1e565-b1e7-ecfc-009a-ee036108f160@linaro.org>
 <8e93f459-53e0-ee39-96cc-2c9e51a72547@ti.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8e93f459-53e0-ee39-96cc-2c9e51a72547@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07/12/2022 07:09, Vignesh Raghavendra wrote:
> Hi Krzysztof,
> 
> On 06/12/22 14:02, Krzysztof Kozlowski wrote:
>> On 06/12/2022 05:35, Vignesh Raghavendra wrote:
>>> AM62A SoC has a dedicated BCDMA that serves Camera Serial Interface
>>> (CSI) IP. Add new compatible for the same. Unlike system
>>> BCDMA, this instance only has RX DMA channels and lack TX or block copy
>>> channel. Thus make those properties optional. Additionally CSI RX has
>>> independent power domain, add the binding for the same.
>>>
>>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>>> ---
>>>  .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 87 ++++++++++++++-----
>>>  1 file changed, 63 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
>>> index 08627d91e607..d7b5adbb9b2e 100644
>>> --- a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
>>> +++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
>>> @@ -32,9 +32,66 @@ allOf:
>>>    - $ref: /schemas/dma/dma-controller.yaml#
>>>    - $ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
>>>  
>>
>> When adding if:then:, please move entire allOf after "required:" part.
> 
> Sure, will do
> 
>>
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            const: ti,am62a-dmss-bcdma-csirx
>>> +    then:
>>> +      properties:
>>> +        ti,sci-rm-range-bchan: false
>>> +        ti,sci-rm-range-tchan: false
>>> +
>>> +        reg:
>>> +          maxItems: 3
>>> +
>>> +        reg-names:
>>> +          items:
>>> +            - const: gcfg
>>> +            - const: rchanrt
>>> +            - const: ringrt
>>
>> With my changes further this can be only "maxItems: 3"
> 
> Yes, but wont that mean any of the 3 reg-names out of the 5? Would it
> not be better to further restrict specifically to above 3 reg-names (as
> thats how the IP is)

I thought that first three entries are the same, but they are not, so
indeed keep it like you have it now.

> 
>>
>>> +
>>> +      required:
>>> +        - compatible
>>> +        - "#dma-cells"
>>> +        - reg
>>> +        - reg-names
>>> +        - msi-parent
>>> +        - ti,sci
>>> +        - ti,sci-dev-id
>>> +        - ti,sci-rm-range-rchan
>>> +        - power-domains
>>> +
>>> +    else:
>>> +      properties:
>>> +        reg:
>>> +          maxItems: 5
>>> +
>>> +        reg-names:
>>> +          items:
>>> +            - const: gcfg
>>> +            - const: bchanrt
>>> +            - const: rchanrt
>>> +            - const: tchanrt
>>> +            - const: ringrt
>>
>> With my changes further this can be only "minItems: 5"
> 
> Ok.

I was wrong, keep it.

> 
>>
>>> +
>>> +      required:
>>> +        - compatible
>>> +        - "#dma-cells"
>>> +        - reg
>>> +        - reg-names
>>> +        - msi-parent
>>> +        - ti,sci
>>> +        - ti,sci-dev-id
>>> +        - ti,sci-rm-range-bchan
>>> +        - ti,sci-rm-range-tchan
>>> +        - ti,sci-rm-range-rchan
>>> +
>>>  properties:
>>>    compatible:
>>> -    const: ti,am64-dmss-bcdma
>>> +    enum:
>>> +      - ti,am64-dmss-bcdma
>>> +      - ti,am62a-dmss-bcdma-csirx
>>
>> Keep some order, e.g. alphabetical. This reduces later conflicts on
>> simultaneous edits.
> 
> Will fix!
> 
>>
>>>  
>>>    "#dma-cells":
>>>      const: 3
>>> @@ -65,19 +122,13 @@ properties:
>>>  
>>>        cell 3: ASEL value for the channel
>>>  
>>> -  reg:
>>> -    maxItems: 5
>>
>> Keep it here with widest constrains - minItems: 3, maxItems: 5
>>
>>> -
>>> -  reg-names:
>>> -    items:
>>> -      - const: gcfg
>>> -      - const: bchanrt
>>> -      - const: rchanrt
>>> -      - const: tchanrt
>>> -      - const: ringrt
>>
>> Keep the list here with minItems: 3

So here minItems:3, maxItems:5


Best regards,
Krzysztof

