Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE5253A096
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jun 2022 11:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350282AbiFAJfm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Jun 2022 05:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348146AbiFAJfE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Jun 2022 05:35:04 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CED8FFA6
        for <dmaengine@vger.kernel.org>; Wed,  1 Jun 2022 02:34:59 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id er5so1329206edb.12
        for <dmaengine@vger.kernel.org>; Wed, 01 Jun 2022 02:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1np58l0Ga8gAPyEnQM7qbTnnn39ozk3WmSTf/pHhsMA=;
        b=FxTMvGpBCFeg1BoYbwmxDdCMOXat0Dl6sDzqkF2MpWnJq2pZtTCNhwmj6W3PeB75qP
         rcPx+5D0Z3FQ8MKmJFh/4q9tShdIZea0l5zEmH43NfBWqwvsk6nv0b014UeFfKZuOIJM
         7M6cZtmof8mF6X4ZH6LWCm95ou26ImCaBaNzOi46ZR1WrbeDHmwdISTvPIMCZ+QsDJVR
         uH4HT1Lkl+X2M7UexFy4Duv1Fo88VNVCnN9YDMcqSCBEKdUv05UNVIBxHxknJwA6DqC1
         c4qXXwjka6hHBGl8n5xtVoZrADjT5c1LU9AIHJO+9vwtz1FHXKKeq1M2uC0Ws2BGju+k
         uZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1np58l0Ga8gAPyEnQM7qbTnnn39ozk3WmSTf/pHhsMA=;
        b=4LhuOu8Z3yMpraTprObAwv4FaL707uscAfGyf35HvoeNVUcaueN7pxQBsqN2TR1be8
         TwG1YMeAhy2dkYOakWyN+8JIkSvFryDDp9tbkFoAkUch4YxNHsliSTKt/xhwvRH5nzDy
         /NhILEJZ9XMAlGFTd1YuPO93CAXiOf6/ejF87EYfWHhQ2lOiSwnQPiISKnyv8eA01kQz
         j/ZdNkHYM8uRmFUmy/t9nT7C5mZQVdQen4dM0Ssp0AOIP2Y1QdlMlqZhZ+aDHFJ+r3kS
         sHnkJ3n7qUZWXW1YDBwkGj3i9PQfQ/uN8eo8qMBzX1nLBPBwCoR98qSS7m2WcFkNeXQ6
         t8qg==
X-Gm-Message-State: AOAM531gOaR1yeeshBWSJTl+U9mDu0jCAeapZrvEWdCQA7c38GI18d9T
        4MvM/3TEfryktHUMUZkNh7ZPsQ==
X-Google-Smtp-Source: ABdhPJxEdF+CfXbx7tU2wd905loniQlDvsO66TbxWB3RqmGrBCz/WUwZDXZTrxvdJ4CljmwLTrODcA==
X-Received: by 2002:a05:6402:1941:b0:413:2555:53e3 with SMTP id f1-20020a056402194100b00413255553e3mr69664287edz.164.1654076097997;
        Wed, 01 Jun 2022 02:34:57 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id s9-20020a056402164900b0042ddfbea36asm709513edx.62.2022.06.01.02.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 02:34:57 -0700 (PDT)
Message-ID: <eab5fecb-8e75-06d5-d598-ff0221406252@linaro.org>
Date:   Wed, 1 Jun 2022 11:34:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 01/17] dt-bindings: i2c: i2c-mt65xx: add binding for
 MT8365 SoC
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        qii.wang@mediatek.com, matthias.bgg@gmail.com, jic23@kernel.org,
        chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, chunfeng.yun@mediatek.com,
        broonie@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Rob Herring <robh@kernel.org>
References: <20220531135026.238475-1-fparent@baylibre.com>
 <20220531135026.238475-2-fparent@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531135026.238475-2-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 31/05/2022 15:50, Fabien Parent wrote:
> Add binding documentation for the MT8365 I2C controllers.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml b/Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml
> index 16a1a3118204..a6fe0d8b0cbe 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml
> @@ -43,6 +43,10 @@ properties:
>            - enum:
>                - mediatek,mt8195-i2c
>            - const: mediatek,mt8192-i2c
> +      - items:
> +          - enum:
> +              - mediatek,mt8365-i2c
> +          - const: mediatek,mt8168-i2c

Order entries by last item, so this goes before mt8192

>  
>    reg:
>      items:


Best regards,
Krzysztof
