Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8734753A197
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jun 2022 12:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351640AbiFAKBx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Jun 2022 06:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351607AbiFAKBj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Jun 2022 06:01:39 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC89A0D29
        for <dmaengine@vger.kernel.org>; Wed,  1 Jun 2022 03:01:29 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w27so1441955edl.7
        for <dmaengine@vger.kernel.org>; Wed, 01 Jun 2022 03:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QSApg3zP7Z2bZgVUXXqGLSarJ97nSfaQBXxCViUt7Hc=;
        b=gDUdEpnQlTwJ+UoHJqSKw+mWBY42AIb0eL1+mhpdGBaRvsyxAy83M8gp1CJiPKW4Bk
         sFqVTeX+V63H8USm8zbKL2hbaCkT2fsQJP6+oMO1WtGC4DNC2X8B53oCXInPFH2HQVSG
         ifBGz3vEMVdfJC54uS1LuuUkRjk1kiMWYev67kWZ3McMI7ogL4ZWwV0IMHee9QSKHIbC
         XsT6767NxHkkbPjdlYT9xzQ4ZZM3dUplCmbg5ZoGB2eWpTq1LhiRugnhBaNxeFrAdMpN
         Y+O/SSR9ExgFn+oMMM7NDh34MioyJQgC633Xw2J0JIKtecj7gVoTWjKiv7qInefhHr4u
         FIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QSApg3zP7Z2bZgVUXXqGLSarJ97nSfaQBXxCViUt7Hc=;
        b=KoqjVPDpzWAHdM0oyfbt4IauS1bwkbWdjhLJ+0UXxJXdusJu8ImXT08SGG/wGom0WB
         Lu5us0ZqWvUPEEPEHlBxbL6/JJzhVV/ujGWnD4n6hnJ2ITxS98/kD2HglHYr5cpiMyPx
         mMuPe9aKCMrWMVJG1DLvYlJWMhIfmPYjUdWn+/hcUY5wsoChr1k2dbIHS6S72NuTFlTZ
         KvKt9iCeDbh4reD8F3JlF/ewLZzs+Dvd2kG8b+se2Tdb8zGJnJD51b1uSdN7l49if4OK
         niZkOIcx7wiT9Xt314nFwqYDNgmAK/rGb8kGtHN+bp1F5Fj4s2I8A/8PglBBoeUt3gMT
         YdxA==
X-Gm-Message-State: AOAM5314Sk77OF4ujBIYRMFy2bMbnw77QwYxwysoPVbg6ZjLH1ZNi9U2
        Ea/tOay+MCse09p2NlhCGDhAEQ==
X-Google-Smtp-Source: ABdhPJyRk45v+ntqucr36rTJSC9/t27Qx1QlAg3pEUAacHKMmQhzqIDfHc6nFbyKIh7EpRG8OxWDXw==
X-Received: by 2002:a05:6402:f14:b0:42d:f989:4a21 with SMTP id i20-20020a0564020f1400b0042df9894a21mr1909557eda.168.1654077687864;
        Wed, 01 Jun 2022 03:01:27 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b9-20020a056402138900b0042acd78014esm710783edv.11.2022.06.01.03.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 03:01:27 -0700 (PDT)
Message-ID: <5bdbe79b-f1c4-695d-0810-3c8dcdfb7817@linaro.org>
Date:   Wed, 1 Jun 2022 12:01:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 06/17] dt-bindings: iio: adc: mediatek: add MT8365 SoC
 bindings
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        qii.wang@mediatek.com, matthias.bgg@gmail.com, jic23@kernel.org,
        chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, chunfeng.yun@mediatek.com,
        broonie@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net,
        Lars-Peter Clausen <lars@metafoo.de>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20220531135026.238475-1-fparent@baylibre.com>
 <20220531135026.238475-7-fparent@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531135026.238475-7-fparent@baylibre.com>
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
> Add binding for the ADC present in MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml      | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
> index 65581ad4b816..364a23be73bc 100644
> --- a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
> @@ -37,6 +37,7 @@ properties:
>                - mediatek,mt8186-auxadc
>                - mediatek,mt8195-auxadc
>                - mediatek,mt8516-auxadc
> +              - mediatek,mt8365-auxadc

Alphabetical order.

Best regards,
Krzysztof
