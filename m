Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AB97315CA
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jun 2023 12:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239287AbjFOKw0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Jun 2023 06:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240308AbjFOKwY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 15 Jun 2023 06:52:24 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B702103
        for <dmaengine@vger.kernel.org>; Thu, 15 Jun 2023 03:52:23 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-982b1a18daeso49293066b.2
        for <dmaengine@vger.kernel.org>; Thu, 15 Jun 2023 03:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686826341; x=1689418341;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=utjDDOKSdywXvqy83VTqNIGTgbsgC3M+2PZw+Kce6sM=;
        b=jMxmfFyWyjWPG1BBJFqu7ITbVdSbOJc+kZnPxcrFjMnrqW8CgSpUNKKRq3Lh6lYBDC
         wfLpqvqyxwHwoRJnmanXLhx7/widM7u7ZK3BKxD585LF/e1rgRj6Xwpi0/bPvj16Iyk7
         erZDOdKqgdkP7RtKevIGVqVn+/fCntNyDzKi265xL+yZzYybJvuuttWdWdkHiGH5NDmr
         4cuY/Iag1OgJ6uY7Gspjh7hoI76PzCkh0ftku3A81zogEi06szELcSSdacIGCNE420JL
         /Wh9OakOZG3sWBhKKKEYDAx/PHxNQvcSU7tYzEj9EOv651PmEsv86w0WoRn6VW71DUXp
         ZmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686826341; x=1689418341;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=utjDDOKSdywXvqy83VTqNIGTgbsgC3M+2PZw+Kce6sM=;
        b=BK6f67JvmyeIRg4G3J0cUwRG35+CPqJztPIczr3Uaq5BDlcyDeKZmyPS1ML5aXyoaR
         R9jgAPS0UZCaQbH29gqBAmqjbk2dkg+G7TVj8r0Sn4kaYfOBB08okkbBf8u8BSV5oGa5
         t09VWTPavK4SRGU2M4f0mKxsJaW/wh9d2HbvMNxlJpKKtPyIPzUsYDqlHUqWnE2a3TYm
         1Bsq6me/bv66HFOe7G9ivZACranipaYMnU4jX1ITL04viMPAEabzWd+R0FT1GnwY/rja
         TWjUDnyRz5LRa7fQCC+M3m3wY2SCBiXX3+a0oY7S0vi+XiTCZVcjvwqG/ik3fvR37tzN
         AyQg==
X-Gm-Message-State: AC+VfDxKMM7yma3m9jUqY5Vgd1SUm0DSgioG/9FVzVY3SuafsKZVfTXU
        MfthpXu07fsY6Jl1e8PZwmRpUA==
X-Google-Smtp-Source: ACHHUZ4Zd7QenZN7bznsbb9rzk810MzuMCf4/T0SCZwLsNuT+24Ngk0O8vLf6fuM3CBh7UAmyym6KQ==
X-Received: by 2002:a17:906:d54b:b0:978:94b1:25ac with SMTP id cr11-20020a170906d54b00b0097894b125acmr21518784ejc.40.1686826341146;
        Thu, 15 Jun 2023 03:52:21 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id jt18-20020a170906ca1200b009823e0bfb05sm3396417ejb.162.2023.06.15.03.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 03:52:20 -0700 (PDT)
Message-ID: <0cddd5e8-3de1-1b6a-b4b8-6304e4c674cf@linaro.org>
Date:   Thu, 15 Jun 2023 12:52:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 12/12] dt-bindings: fsl-dma: fsl-edma: add edma3
 compatible string
Content-Language: en-US
To:     Frank Li <Frank.Li@nxp.com>, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
References: <20230614193544.2114603-1-Frank.Li@nxp.com>
 <20230614193544.2114603-13-Frank.Li@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230614193544.2114603-13-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14/06/2023 21:35, Frank Li wrote:
> Extend Freescale eDMA driver bindings to support eDMA3 IP blocks in
> i.MX8QM and i.MX8QXP SoCs. In i.MX93, both eDMA3 and eDMA4 are now.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/dma/fsl,edma.yaml     | 99 +++++++++++++++++--
>  1 file changed, 92 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> index 5fd8fc604261..de8c44bd8a89 100644
> --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> @@ -21,32 +21,41 @@ properties:
>        - enum:
>            - fsl,vf610-edma
>            - fsl,imx7ulp-edma
> +          - fsl,imx8qm-adma
> +          - fsl,imx8qm-edma
> +          - fsl,imx93-edma3
> +          - fsl,imx93-edma4
>        - items:
>            - const: fsl,ls1028a-edma
>            - const: fsl,vf610-edma
>  
>    reg:
> -    minItems: 2
> +    minItems: 1
>      maxItems: 3
>  
>    interrupts:
> -    minItems: 2
> -    maxItems: 17
> +    minItems: 1
> +    maxItems: 64
>  
>    interrupt-names:
> -    minItems: 2
> -    maxItems: 17
> +    minItems: 1
> +    maxItems: 64
>  
>    "#dma-cells":
> -    const: 2
> +    enum:
> +      - 2
> +      - 3
>  
>    dma-channels:
> -    const: 32
> +    minItems: 1
> +    maxItems: 64
>  
>    clocks:
> +    minItems: 1
>      maxItems: 2
>  
>    clock-names:
> +    minItems: 1
>      maxItems: 2
>  
>    big-endian:
> @@ -65,6 +74,38 @@ required:
>  
>  allOf:
>    - $ref: dma-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8qm-adma
> +              - fsl,imx8qm-edma
> +              - fsl,imx93-edma3
> +              - fsl,imx93-edma4
> +    then:
> +      properties:
> +        "#dma-cells":
> +          const: 3
> +        # It is not necessary to write the interrupt name for each channel.
> +        # instead, you can simply maintain the sequential IRQ numbers as
> +        # defined for the DMA channels.
> +        interrupt-names: false
> +        clock-names:

items:
  - const: dma

clocks:
  maxItems: 1

You do not allow more than one clock, right?

> +          const: dma
> +    else:

You already have two ifs, so you should not have else here, but rather
make each if clause proper for your setup.

BTW, the amount of differences point to very complicated schema, so you
should think whether it makes sense to keep binding growing in the first
place.

> +      properties:
> +        reg:
> +          minItems: 2
> +          maxItems: 3
> +        interrupts:
> +          minItems: 2
> +          maxItems: 17

missing clocks restriction to minItems: 2


> +        "#dma-cells":
> +          const: 2
> +        dma-channels:
> +          const: 32
> +



Best regards,
Krzysztof

