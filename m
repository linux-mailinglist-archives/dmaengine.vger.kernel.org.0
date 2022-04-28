Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F91512D0D
	for <lists+dmaengine@lfdr.de>; Thu, 28 Apr 2022 09:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245479AbiD1Hil (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Apr 2022 03:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245427AbiD1Hif (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Apr 2022 03:38:35 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B509BAF1
        for <dmaengine@vger.kernel.org>; Thu, 28 Apr 2022 00:35:19 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id kq17so7800310ejb.4
        for <dmaengine@vger.kernel.org>; Thu, 28 Apr 2022 00:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=5c6uwqXlBRU9bpJ9pSPHIXx5eNprORPrld9pozTs8Tw=;
        b=H75j/3VRi9fqMtQbn+w04QsT6K235C5ROMHuhSVSFmFZ/koa2PILvH3Ept+2Sr0mYO
         WSOqyZXTv2PlXVd3TVxfSGINFtTlQic8/pEjyg8PSWB9elu9fPZV1grj2ULvGOXndrZX
         C9jJxsSXlWkhLIGVEqHfye8ciAa4iIuahGDIvYsa3ersPJ+sACW2zT14sAKrhyEwgZ5a
         nDqxMaGXDvxTvbcBKuOqaQKsmGt8JHV1XOv7Zi/8Wlf+gOnA/37yWHKfRL69pktHOX8s
         uK0plqWDOlwXYG1uzhfDSiTs1GShXhFLCm9QGVWSQ9sBHhqFQA05pE5maHX4pcy0NtGU
         xYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5c6uwqXlBRU9bpJ9pSPHIXx5eNprORPrld9pozTs8Tw=;
        b=WJVbXj9Jlu38dshGEjjAR4/fB0ivaKeNIH6njZ2VvVyy9qflLogaaw7NjZQUJYjwEo
         kL1IEC6Q8mKlNVllodqxC/zCMLCEoFoyGdslC1K7hqrzF8Nz+7iVo690LZKJqBdYC1Un
         Uzd2NFXKjBOYs5Of8Y5wcb1U2jJCJN6tL1wlgIsEOplDTBJJhaKAiHWCNcRONPx7NgkY
         En//9R86sad4yU+nUHlyxXkG30MQQv8aeDWkG70yEl4C7gEoN175/kLH4HrEX8uRnjKr
         6ASrm+f/YySG2bTDkcOP7YO/F+dbI8IuX0vruWSUZuQ+ZcFIzyWR7Skf6eYeFvSk0zkR
         44Sw==
X-Gm-Message-State: AOAM532USmdjvnOkBxMNRbpybFWO2BqcIjCETd2hQ6OcDFbchjVkrpc7
        GnHIxDygEAHTVF9M1/4ZgolQww==
X-Google-Smtp-Source: ABdhPJxQABhDMXxKQC9B69m+aqrtRZFN3sKdbOUkg4a5i6dj/makIccAEAbNy2MqAD8h+bIFQVIExQ==
X-Received: by 2002:a17:906:c113:b0:6e8:89f7:56da with SMTP id do19-20020a170906c11300b006e889f756damr30833813ejc.174.1651131318027;
        Thu, 28 Apr 2022 00:35:18 -0700 (PDT)
Received: from [192.168.0.160] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n10-20020a170906378a00b006f3cd3e7b94sm2127377ejc.213.2022.04.28.00.35.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 00:35:17 -0700 (PDT)
Message-ID: <703d4811-e46a-202e-c4ca-578ecdbd3e35@linaro.org>
Date:   Thu, 28 Apr 2022 09:35:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/3] arm64: dts: sprd: use new 'dma-channels' property
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220427161423.647534-1-krzysztof.kozlowski@linaro.org>
 <20220427161423.647534-4-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220427161423.647534-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27/04/2022 18:14, Krzysztof Kozlowski wrote:
> The '#dma-channels' property was deprecated in favor of one defined by
> generic dma-common DT bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/sprd/whale2.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
> index 79b9591c37aa..945f0e02d364 100644
> --- a/arch/arm64/boot/dts/sprd/whale2.dtsi
> +++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
> @@ -126,7 +126,7 @@ ap_dma: dma-controller@20100000 {
>  				reg = <0 0x20100000 0 0x4000>;
>  				interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
>  				#dma-cells = <1>;
> -				#dma-channels = <32>;
> +				dma-channels = <32>;


As Rob proposed, the removal of old property does not have to happen in
this patch (but much later). This would allow merging DTS change
immediately.

I will resend in that spirit, unless SoC maintainers prefer the original
approach (where DTS has to wait for next release)?


Best regards,
Krzysztof
