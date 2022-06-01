Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD8653A0C4
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jun 2022 11:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243015AbiFAJiH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Jun 2022 05:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351184AbiFAJhK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Jun 2022 05:37:10 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D0CE085
        for <dmaengine@vger.kernel.org>; Wed,  1 Jun 2022 02:36:57 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id f21so2495800ejh.11
        for <dmaengine@vger.kernel.org>; Wed, 01 Jun 2022 02:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BvJY1lFnsr0Ymr0p7fEBBy1zBdInDHqv2gZieFwic/w=;
        b=H9oMDfi9FTLslshDgNUeUCSTiDMS6SPqQwQ4xmvp2YZvpk8mRC3cDlTC3xpYhnqMtp
         nPH5zKM7d+MOUcflu/CWX3v4wWpaT9OposzSM/Dxx78jsQELZDS5MGcQrSkywIX6o5Uh
         4MpGtaojX5vTHNuVIp8cnOB/0ztfpdpeB3mh/avFuWHvaJ19hKjRBAfWOWCvpf81qUhb
         PX1Cb+q3YAxaR3A5LiSjRG9kjKmrWrFqrOgbDUopVp1qK7P6ID4hzxjnsii4gTsV3W5k
         rOX8IHcJbZ2vzaD1PmxLhGXES4FfrspfYMIIDx5GmxITFiWW0RHW7uODZtl6Lpz4t4Xu
         p4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BvJY1lFnsr0Ymr0p7fEBBy1zBdInDHqv2gZieFwic/w=;
        b=JT9+rnhfq8i7MwEGBP+MEk+WznBrhZhI9F3LQF8rT4lVJ9oxQgF2nFRFm32s4RF7/4
         08HlO5VP0sRGy6xjh80L+h9sZUU/juzw0M64AFJNNq962JXx0DcoKCRPV+rqXIIW0gYA
         I0L4uwnLSome/U61NOpXpSbFVyv9Ne3EIJZWpTTKBlIPOxQETiUyY0z5NCvzn6qiCuN4
         l9eZaF9+Jzr+i1qsqqEYuQQwuYURjiYfLB8pAN0tlXMgPJ3x/r1aipVmX+Zlg0/0IAg9
         1Bfzu1NzGM25qMpE7dIF1hWRdOOk+rdkWs0AUNa4IF2kiN8CDJ7SABnuNUPUv5dkpLTb
         Aszw==
X-Gm-Message-State: AOAM533i4miwlGDxjSxKyOQeHt3MoOmEkoH6QtD/nZmht/1mQIVQ/q8b
        AVyyo0Duqpm0i8e9IRszfX2Ldw==
X-Google-Smtp-Source: ABdhPJw2rvaPJFhu2OJTcgjX9RCpncnnG8SPTMWTUMQWrgzBxKr8ze5Lrm8qBjOHLVpPw2RtdL3afA==
X-Received: by 2002:a17:907:97d2:b0:6ff:288d:1bf2 with SMTP id js18-20020a17090797d200b006ff288d1bf2mr26274477ejc.664.1654076217545;
        Wed, 01 Jun 2022 02:36:57 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u18-20020a170906069200b006f3ef214e13sm494920ejb.121.2022.06.01.02.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 02:36:57 -0700 (PDT)
Message-ID: <8924ef92-d8f7-1f10-b1f7-7f9bc1e2d444@linaro.org>
Date:   Wed, 1 Jun 2022 11:36:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 05/17] dt-bindings: dma: mediatek,uart-dma: add MT8365
 bindings
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        qii.wang@mediatek.com, matthias.bgg@gmail.com, jic23@kernel.org,
        chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, chunfeng.yun@mediatek.com,
        broonie@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net,
        Long Cheng <long.cheng@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20220531135026.238475-1-fparent@baylibre.com>
 <20220531135026.238475-6-fparent@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531135026.238475-6-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 31/05/2022 15:50, Fabien Parent wrote:
> Add binding documentation in order to support the MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml | 1 +
>  1 file changed, 1 insertion(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
