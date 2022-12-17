Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C84164F8D2
	for <lists+dmaengine@lfdr.de>; Sat, 17 Dec 2022 12:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiLQLF0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 17 Dec 2022 06:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiLQLFZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 17 Dec 2022 06:05:25 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AEDDFE1
        for <dmaengine@vger.kernel.org>; Sat, 17 Dec 2022 03:05:23 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id o6so2319408lfi.5
        for <dmaengine@vger.kernel.org>; Sat, 17 Dec 2022 03:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xj4DQ1GOM3k/W43IzdJyX/2s4vba2cXo55x8d2hFPXs=;
        b=bg8AX68WuagpjWXrSZydWWNhLySXCMZ6EtlQ6m8Zf5GURQ+xWE5+5f4lXRLAmj6TJk
         +sRzTrKMWBEYPGMqHhSRsfZdDFdzM5BA7htNAWngbh5OVNSUC9oqreKfMg6cFw4GZyW+
         tgxoeLPFYV5HrOj6pxsfLMCvNcS+Q8OcXvFGx/OH/Cg5a0DQgh55+sf0cR+7Cu07tXvP
         seeeC7DSw7ZlvygoX4MEJagDvIZsO22cCZNbsg4CssmDjfkp0MBUudk8b/Q6jXm2mFnz
         MtzgggC8ltnMisEboXoY8hWqxvpWqSewri+J9wdihYDfnZSoYdzatPnBEnvopaemf/F8
         cGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xj4DQ1GOM3k/W43IzdJyX/2s4vba2cXo55x8d2hFPXs=;
        b=yuQd+xjSLPv6J5oIBuCEkM9hdq2URW2QO6FhQn/DYfg6/kZjO/uEYQu0URJsGXoPw/
         xg0YfCj4Ml8o8l/aC/6u90IBsWUFZT0qmIX6/Vf/HCvSs9Biyay3rpo8QcQeHm3bXSrs
         3OfwXwsgR1C9vigs3s4yG2mTz1AuvbRP7A+1tFX7SX54Nji1A9MV0tNWYySI6qddXSRL
         u5aIoizPt9yfLMOjWpyXGJDTj5MEDaEtQfwIAk/GW8MJIhQMJ/raTSM7sDlwKAM1osN4
         qyNjLy6Z663g4l+NiS/A0SRInbzlYZVjUL+nFMC5fEIyXOrLZnExZwI3SbLLh4EqaKsN
         tQAA==
X-Gm-Message-State: ANoB5pm7ZI/xJ+xuHFLSgwqoC+sTN7+KM62Q5/Lw8Nhy5rbfs7T2NNPC
        2TayeCUHWtr2cgHKUAloGrc42A==
X-Google-Smtp-Source: AA0mqf6yw/xcd1p3DUq/S8ff/vfITEbDcAvZWiYamNuuHB2/TBeOI0/kQQk7ULGVsafimoDlXw6bFA==
X-Received: by 2002:ac2:4950:0:b0:4b5:7925:870d with SMTP id o16-20020ac24950000000b004b57925870dmr9582948lfi.12.1671275122051;
        Sat, 17 Dec 2022 03:05:22 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f19-20020a056512361300b004a03fd4476esm481673lfs.287.2022.12.17.03.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Dec 2022 03:05:21 -0800 (PST)
Message-ID: <b74776b4-0885-f519-8ef7-e01048a8be15@linaro.org>
Date:   Sat, 17 Dec 2022 12:05:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] dt-bindings: dma: fsl-mxs-dma: Convert MXS DMA to DT
 schema
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221217010724.632088-1-marex@denx.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221217010724.632088-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17/12/2022 02:07, Marek Vasut wrote:
> Convert the MXS DMA binding to DT schema format using json-schema.
> 
> Drop "interrupt-names" property, since it is broken. The drivers/dma/mxs-dma.c
> in Linux kernel does not use it, the property contains duplicate array entries
> in existing DTs, and even malformed entries (gmpi, should have been gpmi). Get
> rid of that optional property altogether.
> 
> Update example node names to be standard dma-controller@ ,
> add global interrupt-parent property into example.

Thank you for your patch. There is something to discuss/improve.

> +
> +title: Freescale Direct Memory Access (DMA) Controller from i.MX23/i.MX28
> +
> +maintainers:
> +  - Marek Vasut <marex@denx.de>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - fsl,imx6q-dma-apbh
> +              - fsl,imx6sx-dma-apbh
> +              - fsl,imx7d-dma-apbh
> +          - const: fsl,imx28-dma-apbh
> +      - items:

No need for items here, make it just an enum.

> +          - enum:
> +              - fsl,imx23-dma-apbh
> +              - fsl,imx23-dma-apbx
> +              - fsl,imx28-dma-apbh
> +              - fsl,imx28-dma-apbx
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 4
> +    maxItems: 16
> +
> +  "#dma-cells":
> +    const: 1
> +
> +  dma-channels:
> +    enum: [4, 8, 16]
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#dma-cells"
> +  - dma-channels
> +  - interrupts
> +
> +allOf:
> +  - $ref: dma-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          not:

I think "not:" goes just after "if:". Please double check that it's correct.

Anyway it is easier to have this without negation and you already
enumerate all variants (here and below).


> +            contains:
> +              enum:
> +                - fsl,imx6q-dma-apbh
> +                - fsl,imx6sx-dma-apbh
> +                - fsl,imx7d-dma-apbh
> +                - fsl,imx23-dma-apbx
> +                - fsl,imx28-dma-apbh
> +                - fsl,imx28-dma-apbx
> +    then:
> +      properties:
> +        dma-channels:
> +          const: 8
> +        interrupts:
> +          maxItems: 8

Blank line here, please.

> +  - if:
> +      properties:
> +        compatible:
> +          not:
> +            contains:
> +              enum:
> +                - fsl,imx6q-dma-apbh
> +                - fsl,imx6sx-dma-apbh
> +                - fsl,imx7d-dma-apbh
> +                - fsl,imx23-dma-apbh
> +    then:
> +      properties:
> +        dma-channels:
> +          const: 16
> +        interrupts:
> +          maxItems: 16
> +
> +additionalProperties: false
> +

Best regards,
Krzysztof

