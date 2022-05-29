Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E00053714E
	for <lists+dmaengine@lfdr.de>; Sun, 29 May 2022 16:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiE2OR4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 29 May 2022 10:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiE2OR4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 29 May 2022 10:17:56 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2171D4249B
        for <dmaengine@vger.kernel.org>; Sun, 29 May 2022 07:17:54 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x17so2504085wrg.6
        for <dmaengine@vger.kernel.org>; Sun, 29 May 2022 07:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/RnfxhSLHWEjSCyFNvqAeRKPEvIyVsMYATgYIDOeUYE=;
        b=gtGgZD/A1/wTM853GAqUrzpPiZ5JaqQgtxz+HIjUCukO7rPAU7rGdCnCHCuzr8IEOe
         xfEhOT4GDWCzwuF+23FGd3GCro32fdfh09W/IU4IJamxOQD1a52gVbQDC4vknRgz7TEo
         Wx4IUS0oRYKipYrAM8Sy2PbERc+c8+xf5u8sqe5kKPX91pX0r9b87Fj67VGTk4OkiFza
         d+6ofh9TpQaFhGKGRoG2A2vmOFguK1zlstIBAqrbl1Whcz6LKiC44n+eKMfAnmwjKPvy
         Oxm282ZARG3io0owHbZ6tNQx4nTQyLxfNmZah8lYdJMZMNjpNq2pCEQbyGCF/mhl1Q2k
         I0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/RnfxhSLHWEjSCyFNvqAeRKPEvIyVsMYATgYIDOeUYE=;
        b=YYkd5f030Uw5KTkQhgVp1aMgt7M9XViw/ohgMDt4UFd+xrwm6KAU/oLTt9R3JQ3af2
         5PutP89dp1hFuFmnTveiH7LwNswefcYjsvN8M/uHIx4fGllxBl5HAopzkdXzHhbWLd8C
         foWP/mQsvyb/urVfuxSlpABpY/y/rIgx6JpD7YtDmuDK5i1PoH/6NGfc6VI/5oX5Flhn
         nL0I80apqgVRoPbzpxoCNZG6wGz39dNuL8cI36jLuJ7O+N/RDLzG3RDmSE4PrkCnZ6iN
         jaMBAneNgQLmuIXIqTiXoxyzb5zmDRNbgUjooNqXFITIdIVAHfJk+qb2JbZWOd3BKKdC
         s1ag==
X-Gm-Message-State: AOAM531OX7d4I4z8svghdef6GuZW2Gtn0KltUwpcWQMPmzCp7n5WX1AC
        DLKKLy/jaaj9o7Ams5M0ZUkS+A==
X-Google-Smtp-Source: ABdhPJxxj2WCq+u40b+fBt+evXm6Gk2mAMTOS6PArrddcDWFCfj9E/42mU/De1uVcnixaNi7YmD03w==
X-Received: by 2002:a5d:59ae:0:b0:20f:d007:be25 with SMTP id p14-20020a5d59ae000000b0020fd007be25mr30003634wrr.336.1653833872723;
        Sun, 29 May 2022 07:17:52 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id e9-20020a5d5949000000b002103136623esm1230449wri.85.2022.05.29.07.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 May 2022 07:17:52 -0700 (PDT)
Message-ID: <bdbf2fa9-214e-e9f3-5389-87864104e07d@linaro.org>
Date:   Sun, 29 May 2022 16:17:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V3] dt-bindings: dma: fsl-edma: Convert to DT schema
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, joy.zou@nxp.com,
        Peng Fan <peng.fan@nxp.com>
References: <20220527020507.392765-1-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220527020507.392765-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27/05/2022 04:05, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert the eDMA controller binding to DT schema.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V3:
>   Address Krzysztof's comments, for reg/interrupts/clock-names
> 
> V2:
>   Typo fix
>   Correct interrupts/interrupt-names/AllOf
> 
> 
>  .../devicetree/bindings/dma/fsl,edma.yaml     | 155 ++++++++++++++++++
>  .../devicetree/bindings/dma/fsl-edma.txt      | 111 -------------
>  arch/arm64/boot/dts/freescale/imx93.dtsi      |   2 +-
>  3 files changed, 156 insertions(+), 112 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/fsl,edma.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/fsl-edma.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> new file mode 100644
> index 000000000000..050e6cd57727
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> @@ -0,0 +1,155 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale enhanced Direct Memory Access(eDMA) Controller
> +
> +description: |
> +  The eDMA channels have multiplex capability by programmable
> +  memory-mapped registers. channels are split into two groups, called
> +  DMAMUX0 and DMAMUX1, specific DMA request source can only be multiplexed
> +  by any channel of certain group, DMAMUX0 or DMAMUX1, but not both.
> +
> +maintainers:
> +  - Peng Fan <peng.fan@nxp.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - fsl,vf610-edma
> +          - fsl,imx7ulp-edma
> +      - items:
> +          - const: fsl,ls1028a-edma
> +          - const: fsl,vf610-edma
> +
> +  reg:
> +    minItems: 2
> +    maxItems: 3
> +
> +  interrupts:
> +    minItems: 2
> +    maxItems: 17
> +
> +  interrupt-names:
> +    minItems: 2
> +    maxItems: 17
> +
> +  "#dma-cells":
> +    const: 2
> +
> +  dma-channels:
> +    const: 32
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    maxItems: 2
> +
> +  big-endian:
> +    description: |
> +      If present registers and hardware scatter/gather descriptors of the
> +      eDMA are implemented in big endian mode, otherwise in little mode.
> +    type: boolean
> +
> +required:
> +  - "#dma-cells"
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - dma-channels
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,vf610-edma
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: dmamux0
> +            - const: dmamux1
> +        interrupts:
> +          maxItems: 2
> +        interrupt-names:
> +          items:
> +            - const: edma-tx
> +            - const: edma-err
> +        reg:
> +          maxItems: 3
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx7ulp-edma
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: dma
> +            - const: dmamux0
> +        interrupts:
> +          maxItems: 17

Looks good, although the information about order of interrupts is lost
during conversion. The original bindings had:
"total 16 channel interrupt and 1 error interrupt(located in the last)"

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
