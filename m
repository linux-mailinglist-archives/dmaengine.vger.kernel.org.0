Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4AE72EE36
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jun 2023 23:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjFMVni (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jun 2023 17:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjFMVni (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Jun 2023 17:43:38 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCE91BC9
        for <dmaengine@vger.kernel.org>; Tue, 13 Jun 2023 14:43:36 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b203360d93so76547821fa.3
        for <dmaengine@vger.kernel.org>; Tue, 13 Jun 2023 14:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686692614; x=1689284614;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YVBzURvgjDfJ2gYyhvgrYexXopFXZIPug6bdq/81hWE=;
        b=Xdi0/6K1NxhnAg5y9c0bvzbLp8+1t0LKXLb0wMbY3ijxhV4moAndWkqNAqB+eIax4D
         L12h0PpSJqkrsNof/Nm7YmYyxeoL8cbNLTLAmHfmNIyGClijwwgWWYSVPfZRUHLb/Hko
         4O6KvrYad5pmWfYkF1hGLeFFCi7Af83/IWLzaf3DGi0AokQflEZ7G7IlSK91Lu8h0INV
         MqCFNc6E540p26lhiOkl1zTzQQqYf6QVog8T+TDZloTW6nqcn6rCvhv+yYrt37773/WQ
         kbM8bf5AKqaO/g8VNoTvK0QLwgJvmYWb4uNoK6smTM1nYB23shr3YKisE7RcvevzrTpF
         JWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686692614; x=1689284614;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YVBzURvgjDfJ2gYyhvgrYexXopFXZIPug6bdq/81hWE=;
        b=DRBoObfJ0xAb8cF5mMEfpKSlbJUlsEbn0GU8/DVBdjF2zwd9aKoHg9QWrP70OKARnQ
         ZfdSRQz5We81HnFOEH0n4GPQGUwC/984I5g2q7pFipuWowSJqpe7lvY6N6vZlvSmp+us
         CSQqN6OPZzBvNSsTDOVWP3jMBbQqp/9DJb7vNYGFYBLBlji12ZS3e7fZkk8F9o5Zw3z6
         f0TCwZoZABW6A2Ni0r47l36FwbpbnvdNNS2g2CmDS5se5KvjOprf9BqWG6jQbB9EYYPm
         9r3WlRLOuYrUdBNaEaw+Jd6TFQLRDquxLrlk4aGpcc9X2KiHdeUQ389j8QdoYCtUt4B8
         OeUw==
X-Gm-Message-State: AC+VfDw52FqJSU4AhSkPzRZmVrbHFGC2ZvXUwopUkSbGFHakX1ocOfPf
        RqmXQ7TzPjhhVMVWIV77zbci5A==
X-Google-Smtp-Source: ACHHUZ7cENNYNtJ0+hM2eHjXCY90dPlU+xSJdz4xMbZeUL9j63eH3FC8d97cdb202+tzq5L/NR8ZAA==
X-Received: by 2002:a2e:a0ce:0:b0:2ab:19a0:667b with SMTP id f14-20020a2ea0ce000000b002ab19a0667bmr5053077ljm.0.1686692614315;
        Tue, 13 Jun 2023 14:43:34 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id n16-20020aa7c450000000b005187a749db8sm920472edr.21.2023.06.13.14.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 14:43:33 -0700 (PDT)
Message-ID: <b3a25a5a-d39a-81bd-0593-7a4b76aeb9bf@linaro.org>
Date:   Tue, 13 Jun 2023 23:43:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 12/12] dt-bindings: fsl-dma: fsl-edma: add edma3
 compatible string
Content-Language: en-US
To:     Frank Li <Frank.Li@nxp.com>, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
References: <20230613213149.2076358-1-Frank.Li@nxp.com>
 <20230613213149.2076358-13-Frank.Li@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230613213149.2076358-13-Frank.Li@nxp.com>
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

On 13/06/2023 23:31, Frank Li wrote:
> Extend Freescale eDMA driver bindings to support eDMA3 IP blocks in
> i.MX8QM and i.MX8QXP SoCs. In i.MX93, both eDMA3 and eDMA4 are now.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/dma/fsl,edma.yaml     | 118 +++++++++++++++---
>  1 file changed, 100 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> index 5fd8fc604261..2f79492fb332 100644
> --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> @@ -21,32 +21,20 @@ properties:
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
> -  reg:
> -    minItems: 2
> -    maxItems: 3
> -
> -  interrupts:
> -    minItems: 2
> -    maxItems: 17

What is happening here?

> -
> -  interrupt-names:
> -    minItems: 2
> -    maxItems: 17
> -
> -  "#dma-cells":
> -    const: 2
> -
> -  dma-channels:
> -    const: 32

No, why all these are being removed?

> -
>    clocks:
> +    minItems: 1
>      maxItems: 2
>  
>    clock-names:
> +    minItems: 1
>      maxItems: 2
>  
>    big-endian:
> @@ -55,6 +43,43 @@ properties:
>        eDMA are implemented in big endian mode, otherwise in little mode.
>      type: boolean
>  
> +if:

This should not be outside of your allOf. This patch looks entirely
different than your v4 and I don't really understand why.


> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - fsl,imx8qm-adma
> +          - fsl,imx8qm-edma
> +          - fsl,imx93-edma3
> +          - fsl,imx93-edma4
> +then:
> +  properties:
> +    reg:
> +      maxItems: 1
> +    interrupts:
> +      minItems: 1
> +      maxItems: 64

What's more, you don't have these properties defined in top-level.
Sorry, they should not be moved. I did not ask for this.

Best regards,
Krzysztof

