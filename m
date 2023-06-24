Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A9E73C82D
	for <lists+dmaengine@lfdr.de>; Sat, 24 Jun 2023 10:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjFXICI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 24 Jun 2023 04:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjFXICF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 24 Jun 2023 04:02:05 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B966D2D7C
        for <dmaengine@vger.kernel.org>; Sat, 24 Jun 2023 01:01:43 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-988b204ce5fso164256466b.3
        for <dmaengine@vger.kernel.org>; Sat, 24 Jun 2023 01:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687593702; x=1690185702;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9HaHZDehClxR9T/qxmaslajrl1EPqKVL0R9NY/jGTsg=;
        b=F3QDL4q8VywBoEOgLA003XEmcfdYtm3Ea0matX93IHzoJEv8hWPz4+c37arSFLlHPJ
         KJiKcZZsCJW3EISQa/0WZr7GmFkHehvHcqCTL77aPrpRtf7wWxpMpUHHteIIi/i6WgrA
         P+PyBeA1xhafgy3H/e2UWInSjheEjPAhT1BMP3IiTNbjmRYdvtR5v1zPluKBxz0S3DCW
         wy2fTJI3bg3cbA/DNbDMu9pAzD0bF/mNG4WsH3QsxXMLCCGLPK6NC8MJ9l8TNSf1hLUM
         58xmuXiAu9nxjdyxt5KPAyhabLHOsvTKYI7E3U6I1s7LAWe0FlD5wup3cDa7Ngf3ArIy
         5drQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687593702; x=1690185702;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9HaHZDehClxR9T/qxmaslajrl1EPqKVL0R9NY/jGTsg=;
        b=iKs/xAS1jktRdz0tgBTL127CJdGXn4aN2GgnFsbnw6xf3maxYZINOyk7LZaLIoBljN
         o+Pp48msLbmbu0cdyaBlJ1HJ9TV1fcu7CnBmXJRaq7vRQuHW13c4omqoZ5cY+ULqzMp9
         q97PxZGT0U6dR07z2V9Zs12Ei2bQ+i7d8Nwig0OBBneqB41lXw9ciYURgzSGP8eP2U4r
         TxgOiAww90cVsFyuulHCJATiGlv8wpFbHbv9fy8KUQ7UItSAyn32f+oGx1UGvYGDeJsE
         rYT/9nu+k/TsTvWExEGKQcGzoMN9sglPnhoiEIhq9jr2wrM8AZg9AHKWvkFZ6wm9qi0p
         ka3Q==
X-Gm-Message-State: AC+VfDwIMtlApJBXjIhdG4ksN496qUF6+5Sx3HV1tmgYO/O4Xo2HKNZZ
        rrp7b49Q7xRGuuMaYyEL+ko6PQ==
X-Google-Smtp-Source: ACHHUZ7LZUuSsLPmwaJcMGBzTaxcrMKmP11V5Fuvqcxhksu+1Vgcylqr7l5RCc1ndNOBQHLG9wFOKg==
X-Received: by 2002:a17:907:3f18:b0:978:6e73:e837 with SMTP id hq24-20020a1709073f1800b009786e73e837mr23104557ejc.4.1687593702085;
        Sat, 24 Jun 2023 01:01:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id qh15-20020a170906ecaf00b009885462a644sm587108ejb.215.2023.06.24.01.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 01:01:41 -0700 (PDT)
Message-ID: <44780d35-5c90-7195-1dc6-019e54944af0@linaro.org>
Date:   Sat, 24 Jun 2023 10:01:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 27/45] dt-bindings: rng: atmel,at91-trng: document
 sam9x7 TRNG
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org,
        tglx@linutronix.de, maz@kernel.org, lee@kernel.org,
        ulf.hansson@linaro.org, tudor.ambarus@linaro.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linus.walleij@linaro.org, p.zabel@pengutronix.de,
        olivia@selenic.com, a.zummo@towertech.it,
        radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com,
        broonie@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, sre@kernel.org, jerry.ray@microchip.com,
        horatiu.vultur@microchip.com, durai.manickamkr@microchip.com,
        andrew@lunn.ch, alain.volmat@foss.st.com,
        neil.armstrong@linaro.org, mihai.sain@microchip.com,
        eugen.hristev@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Hari.PrasathGE@microchip.com, cristian.birsan@microchip.com,
        balamanikandan.gunasundar@microchip.com,
        manikandan.m@microchip.com, dharma.b@microchip.com,
        nayabbasha.sayed@microchip.com, balakrishnan.s@microchip.com
References: <20230623203056.689705-1-varshini.rajendran@microchip.com>
 <20230623203056.689705-28-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230623203056.689705-28-varshini.rajendran@microchip.com>
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

On 23/06/2023 22:30, Varshini Rajendran wrote:
> Add compatbile for Microchip sam9x7 TRNG.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml b/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
> index 3ce45456d867..7e4dbf5e22b4 100644
> --- a/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
> +++ b/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
> @@ -17,6 +17,7 @@ properties:
>        - enum:
>            - atmel,at91sam9g45-trng
>            - microchip,sam9x60-trng
> +          - microchip,sam9x7-trng

Same as in other cases, so just to avoid applying by submaintainer:
looks not tested and not working.

Best regards,
Krzysztof

