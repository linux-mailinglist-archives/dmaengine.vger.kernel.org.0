Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45266210E66
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2020 17:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731343AbgGAPGy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Jul 2020 11:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731253AbgGAPGx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Jul 2020 11:06:53 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7BBC08C5C1;
        Wed,  1 Jul 2020 08:06:53 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a6so18443638wmm.0;
        Wed, 01 Jul 2020 08:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X6wYh/c2ar2SFHck6U/COCSxoXgwk5Hdsd8JPy550ZY=;
        b=Y6FWbB9ZaCYNrfrko7V5ZkWBTduEymS3bp6+cCuM5wYQTYr//ln+IBYY4MtLs3n7cD
         lmRqRAJHWyUImAIW4VbCpOeMqo/9ghh2NE8PHgKOGO+O/BdCidhOVPgdX5jYfiVwVTQR
         DtqX76rrf4TONrrFzGr8IPAkqUUrXn2yLmmuIUtVyhe/vdcIudyxhTLJKuhrQBvG7wS1
         TqQdMM63KGSllKYq8nM5B2rSExbZ1Y2NT1aMwyFV4X7Jxy6lq8xGB7OZUAkVguu/guR+
         AYCVi4LR2/5hv9kAz2zcfg/uX2l9XAsfTOavCtE1pF99kSyUhJ1o3jQVgA0PR4/l989F
         V1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=X6wYh/c2ar2SFHck6U/COCSxoXgwk5Hdsd8JPy550ZY=;
        b=OExWCZKM6tUSu5FSzernl9raNnKSjtdEwpUy2FF8iVZDNtq4dSwBb6yIzZDe3E69PO
         uZFhDOya22RkR0ovdNEQ3+syMcRy/BOpyQp1187ODcEPFO0annozJMYbWPtTkFaYySuR
         K62/7TLggzD/W72syFDHPBKZSrjf0v82BNvcnk47hMb6JkQ8wb6LpzSClotvS42F+CA+
         Dv/eHRXIXDYlrWxV8algGWBet7K3bY99rou/H65MJxlqNGegZyBHid15a8/6rgf6rs0E
         isrttqfLz+ex8tHBVa4aW50Z4r3jpn/RorrOH+4s9ua9nqLJ6wJJ6Ra4uUKKi5lTpoO+
         0M2A==
X-Gm-Message-State: AOAM530ZlSt12m8fs04AteyVY2owZIWTfuHVK8FbN2oiH8q6CSH6dEdY
        iwVTSCPc6ow6w/Zb3Xc0oyioftdcBtQ=
X-Google-Smtp-Source: ABdhPJzaU+kxlCBBgOSVmBafI3KofmbDB0FNT6Q+qqOAYL/tW400AJQZ8htwtmg7kaN+xuBd4jbVhg==
X-Received: by 2002:a1c:24c6:: with SMTP id k189mr28534473wmk.9.1593616011726;
        Wed, 01 Jul 2020 08:06:51 -0700 (PDT)
Received: from ziggy.stardust ([213.195.114.138])
        by smtp.gmail.com with ESMTPSA id u84sm7457138wme.42.2020.07.01.08.06.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 08:06:50 -0700 (PDT)
Subject: Re: [PATCH v5 1/4] dt-bindings: dmaengine: Add MediaTek Command-Queue
 DMA controller bindings
To:     EastL <EastL.Lee@mediatek.com>
Cc:     Sean Wang <sean.wang@mediatek.com>, vkoul@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wsd_upstream@mediatek.com
References: <1592553902-30592-1-git-send-email-EastL.Lee@mediatek.com>
 <1592553902-30592-2-git-send-email-EastL.Lee@mediatek.com>
 <4fc5f4b9-8f03-74b4-8bc9-bf86a6246ff0@gmail.com>
 <1593592716.26931.1.camel@mtkswgap22>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <76c146a2-75b7-bf92-f19c-c1862ae5943a@gmail.com>
Date:   Wed, 1 Jul 2020 17:06:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1593592716.26931.1.camel@mtkswgap22>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 01/07/2020 10:38, EastL wrote:
> On Fri, 2020-06-19 at 11:36 +0200, Matthias Brugger wrote:
>>
>> On 19/06/2020 10:04, EastL wrote:
>>> Document the devicetree bindings for MediaTek Command-Queue DMA controller
>>> which could be found on MT6779 SoC or other similar Mediatek SoCs.
>>>
>>> Signed-off-by: EastL <EastL.Lee@mediatek.com>
>>
>> Still missing the full name.
> 
> Sorry I thought it was only needed in the yaml file
> I will fix in next version.\

Just to make sure there is no missunderstanding, I mean your git settings. Your
Signed-off-by should look like:

EastL Lee <EastL.Lee@mediatek.com>

Regards,
Matthias

>>
>>> ---
>>>  .../devicetree/bindings/dma/mtk-cqdma.yaml         | 114 +++++++++++++++++++++
>>>  1 file changed, 114 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/dma/mtk-cqdma.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/dma/mtk-cqdma.yaml b/Documentation/devicetree/bindings/dma/mtk-cqdma.yaml
>>> new file mode 100644
>>> index 0000000..e6fdf05
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/dma/mtk-cqdma.yaml
>>> @@ -0,0 +1,114 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>
>> You missed the brackets ().
> OK
>>
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/dma/mtk-cqdma.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: MediaTek Command-Queue DMA controller Device Tree Binding
>>> +
>>> +maintainers:
>>> +  - EastL Lee <EastL.Lee@mediatek.com>
>>> +
>>> +description:
>>> +  MediaTek Command-Queue DMA controller (CQDMA) on Mediatek SoC
>>> +  is dedicated to memory-to-memory transfer through queue based
>>> +  descriptor management.
>>> +
>>> +allOf:
>>> +  - $ref: "dma-controller.yaml#"
>>> +
>>> +properties:
>>> +  "#dma-cells":
>>> +    minimum: 1
>>> +    maximum: 255
>>> +    description:
>>> +      Used to provide DMA controller specific information.
>>> +
>>> +  compatible:
>>> +    oneOf:
>>> +      - const: mediatek,common-cqdma
>>
>> What is the common-cqdma for if we have only one compatible specifying the SoC.
>> Actually I'm not a great fan of the common-cqdma thing. I'd prefer a fallback
>> compatible that has the name of the first SoC implementing the same device.
>>
>> Regards,
>> Matthias
>>
> OK, I'll remove common compatible.
> 
>>> +      - const: mediatek,mt6765-cqdma
>>> +      - const: mediatek,mt6779-cqdma
>>> +
>>> +  reg:
>>> +    minItems: 1
>>> +    maxItems: 5
>>> +    description:
>>> +        A base address of MediaTek Command-Queue DMA controller,
>>> +        a channel will have a set of base address.
>>> +
>>> +  interrupts:
>>> +    minItems: 1
>>> +    maxItems: 5
>>> +    description:
>>> +        A interrupt number of MediaTek Command-Queue DMA controller,
>>> +        one interrupt number per dma-channels.
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +
>>> +  clock-names:
>>> +    const: cqdma
>>> +
>>> +  dma-channel-mask:
>>> +    $ref: /schemas/types.yaml#definitions/uint32
>>> +    description:
>>> +       For DMA capability, We will know the addressing capability of
>>> +       MediaTek Command-Queue DMA controller through dma-channel-mask.
>>> +    items:
>>> +      minItems: 1
>>> +      maxItems: 63
>>> +
>>> +  dma-channels:
>>> +    $ref: /schemas/types.yaml#definitions/uint32
>>> +    description:
>>> +      Number of DMA channels supported by MediaTek Command-Queue DMA
>>> +      controller, support up to five.
>>> +    items:
>>> +      minItems: 1
>>> +      maxItems: 5
>>> +
>>> +  dma-requests:
>>> +    $ref: /schemas/types.yaml#definitions/uint32
>>> +    description:
>>> +      Number of DMA request (virtual channel) supported by MediaTek
>>> +      Command-Queue DMA controller, support up to 32.
>>> +    items:
>>> +      minItems: 1
>>> +      maxItems: 32
>>> +
>>> +required:
>>> +  - "#dma-cells"
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts
>>> +  - clocks
>>> +  - clock-names
>>> +  - dma-channel-mask
>>> +  - dma-channels
>>> +  - dma-requests
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +    #include <dt-bindings/clock/mt6779-clk.h>
>>> +    cqdma: dma-controller@10212000 {
>>> +        compatible = "mediatek,mt6779-cqdma";
>>> +        reg = <0x10212000 0x80>,
>>> +            <0x10212080 0x80>,
>>> +            <0x10212100 0x80>;
>>> +        interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_LOW>,
>>> +            <GIC_SPI 140 IRQ_TYPE_LEVEL_LOW>,
>>> +            <GIC_SPI 141 IRQ_TYPE_LEVEL_LOW>;
>>> +        clocks = <&infracfg_ao CLK_INFRA_CQ_DMA>;
>>> +        clock-names = "cqdma";
>>> +        dma-channel-mask = <63>;
>>> +        dma-channels = <3>;
>>> +        dma-requests = <32>;
>>> +        #dma-cells = <1>;
>>> +    };
>>> +
>>> +...
>>>
> 
