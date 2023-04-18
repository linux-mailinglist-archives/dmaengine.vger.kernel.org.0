Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DB56E6951
	for <lists+dmaengine@lfdr.de>; Tue, 18 Apr 2023 18:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjDRQWS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Apr 2023 12:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbjDRQWR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Apr 2023 12:22:17 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4AD4C3D
        for <dmaengine@vger.kernel.org>; Tue, 18 Apr 2023 09:22:12 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id q23so65189938ejz.3
        for <dmaengine@vger.kernel.org>; Tue, 18 Apr 2023 09:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681834931; x=1684426931;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k98D+MM4titXN7w20iwONXxFJ0odD41kpbay6J8HXis=;
        b=SzHewHB/02UShAzIFK1WG4yqAl6Y8Da71xVqO4YQYaW56xzTjcPtCYsPFdF/n0W3GB
         d6i3R17KAcgeQ5AsGovPG4u1jBsAAhI1wtaoDwbE0PD+lbW5V/fNVl7KqcjwbzU/frT2
         1FLc94AmgZKpkQKBXmZq7RFMISVw+3QdSe7SwoHtF5e44qGNKtTHQh0k4bT4rDNOF8bR
         KTuAJeGl4PukUSjvOVUnLD+DLw9/JI6/j1vgOj6PPOeTPxt11yE56VB/msRBfoWZU6cs
         FXuNraqR+E5kU7plykCNM21hZsNYgZvJhbvE/2dx0uNQrD112q3MHZAcAK5FHfuHkpLv
         ulOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681834931; x=1684426931;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k98D+MM4titXN7w20iwONXxFJ0odD41kpbay6J8HXis=;
        b=PLQkHTj1z/5srZsw+g/Bp+GmI6cIAD+fErdVyn4tkHEhWmsoTaqSYDt5uVtZu2EkUO
         jtbKS3UOlWqpb81MRNPoge3n9/MdglvCBhsiMGM3gbaP33bAj+mi33LoSt2OhM9vh27x
         wrDhQQHEl64OoYOqts/e/ZgoIZ8XdxUnuuVdgU9uUBLIy1PQo3k0o0OW6ld/yxwKubsP
         cz+dYgvpdQ1VQRt6PVB9z66mnketiCslpLU8LpDiwngU/ag3pRKnj/OEjoiodsMpF06O
         3RkPqal27iibNKo0KPt8giNVVpbeuyl7XP6Bzh4zD/+OMV65lzovFV1JAhv5lLLSUYw8
         oZSg==
X-Gm-Message-State: AAQBX9eJ5RNKthg1JQO6AGnP0EsoMamJEl5HGBwsO8v/p80DfvcZUoNl
        g4e1odXiKn3ag7zcBEB5BCnMaYkaYwxqucX0OVCqgw==
X-Google-Smtp-Source: AKy350aGmAOX2K2KQvNkA5nXhLraYUvIOg/abbxC+diFj/BPIs5hIgb21hHHYtgUapkSS88GcYuPyA==
X-Received: by 2002:a17:907:94d0:b0:94f:6218:191d with SMTP id dn16-20020a17090794d000b0094f6218191dmr9318052ejc.32.1681834930898;
        Tue, 18 Apr 2023 09:22:10 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a276:7d35:5226:1c77? ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id p7-20020a170906784700b00947740a4373sm8191962ejm.81.2023.04.18.09.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 09:22:10 -0700 (PDT)
Message-ID: <6344a399-5ebb-f244-d0a4-91ec74263a7c@linaro.org>
Date:   Tue, 18 Apr 2023 18:22:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/7] dt-bindings: dma: dma40: Prefer to pass sram through
 phandle
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230417-ux500-dma40-cleanup-v1-0-b26324956e47@linaro.org>
 <20230417-ux500-dma40-cleanup-v1-1-b26324956e47@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230417-ux500-dma40-cleanup-v1-1-b26324956e47@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17/04/2023 09:55, Linus Walleij wrote:
> Extend the DMA40 bindings so that we can pass two SRAM
> segments as phandles instead of directly referring to the
> memory address in the second reg cell. This enables more
> granular control over the SRAM, and adds the optiona LCLA
> SRAM segment as well.
> 
> Deprecate the old way of passing LCPA as a second reg cell,
> make sram compulsory.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/dma/stericsson,dma40.yaml  | 35 +++++++++++++++++-----
>  1 file changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml b/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml
> index 64845347f44d..4fe0df937171 100644
> --- a/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml
> +++ b/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml
> @@ -112,14 +112,23 @@ properties:
>        - const: stericsson,dma40
>  
>    reg:
> -    items:
> -      - description: DMA40 memory base
> -      - description: LCPA memory base
> +    oneOf:
> +      - items:
> +          - description: DMA40 memory base
> +      - items:
> +          - description: DMA40 memory base
> +          - description: LCPA memory base, deprecated, use eSRAM pool instead
> +        deprecated: true
> +
>  
>    reg-names:
> -    items:
> -      - const: base
> -      - const: lcpa
> +    oneOf:
> +      - items:
> +          - const: base
> +      - items:
> +          - const: base
> +          - const: lcpa
> +        deprecated: true
>  
>    interrupts:
>      maxItems: 1
> @@ -127,6 +136,14 @@ properties:
>    clocks:
>      maxItems: 1
>  
> +  sram:
> +    $ref: '/schemas/types.yaml#/definitions/phandle-array'

Drop quotes


> +    items:

Drop items...

> +      maxItems: 2

and this...

> +    description:
> +      List of phandles for the SRAM used by the DMA40 block, the first
> +      phandle is the LCPA memory, the second is the LCLA memory.

and all this, to write everything like:

items:
  - description: LCPA SRAM memory
  - description: ....


> +

> 

Best regards,
Krzysztof

