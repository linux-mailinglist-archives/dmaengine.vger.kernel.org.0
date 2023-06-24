Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E9373C848
	for <lists+dmaengine@lfdr.de>; Sat, 24 Jun 2023 10:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbjFXICs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 24 Jun 2023 04:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbjFXICc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 24 Jun 2023 04:02:32 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E6D26BD
        for <dmaengine@vger.kernel.org>; Sat, 24 Jun 2023 01:02:31 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51d5569e4d1so403256a12.2
        for <dmaengine@vger.kernel.org>; Sat, 24 Jun 2023 01:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687593749; x=1690185749;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L8LUDdIDqS/S81pzeykwMUjVd54i6Iidt8jcXJziYFU=;
        b=IGISLJU8aL9N8mVg5tva0FYJZ4ypiF8eDRpd6Rn8HPZy48/jSbTIltoLQMlSeM3L7i
         Gej8neMhutSWohQ24tzO80Lpn3kaLt9qqqRwOONjtjD/gRLklgEGqn2uq8r8WCnVjZU/
         0lc99U58ylKcCJEJPP/lfFSYAUX12mhkOhQvyuZPdyou9/jz69f1vvrBPa+sEfa9ZPnr
         OzxyhRY7ALK8r11IHXFwC/0P7k4XIkrn4WIr9sRXhRuL4JMOb+f4XV9bQ2F2Sun3Kdd+
         RFW9JXqw22CUXQ81UiEc3zXhCcs0R+mF6aloRmSsO6/VuzfhI6dXXM3pwXPg/wwzOsi/
         XO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687593749; x=1690185749;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L8LUDdIDqS/S81pzeykwMUjVd54i6Iidt8jcXJziYFU=;
        b=Q7vFsMxXTer9uyaxnHJL8skG4PhGKa5J//cOaHTo4LSrEhEfBDQdR5MmFamnv3zXKU
         W9tMQUF0LGT/7apwx+kiFi+3w9kokVQyustQFvCABAdhRMNcg4fAPrvqP8F+huZ9bsCu
         E8c/dS62HDrrIFrMPN8ikiBZFvlVwvZFvefK1O8Yud2aTtSOE8MAfjgSGnyeCrmLkHot
         R7NkBS0B1g8ekATsBpMIfrmM5V5Puasj2NbiY3tGFYVL/RdI3Zp4v935AU+u5A0/p6cD
         pvg26JkTjJ19lW9HaErxUp2WM97TbCvQJJy4k7ffGP/KK7pLmFFJ/4B5Dx6F0DZoSBRA
         squA==
X-Gm-Message-State: AC+VfDwYEJnhvR3EROMh0GCQN6JprCnKMbg2JQeF3HVpDcHYJI8ZeTdT
        cre06m/YfiLpfmH1UTzlW13KLg==
X-Google-Smtp-Source: ACHHUZ4K2H7+wCUg6ioqFCkyucKiFbP5cpiH1/A295WcgwuRd8qHBW0eTaeYJOTsq1BbRpdDIU7d9Q==
X-Received: by 2002:aa7:d88c:0:b0:51b:e9a1:8831 with SMTP id u12-20020aa7d88c000000b0051be9a18831mr4249258edq.34.1687593749577;
        Sat, 24 Jun 2023 01:02:29 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id w15-20020a50fa8f000000b0051bfa07af4asm401283edr.93.2023.06.24.01.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 01:02:28 -0700 (PDT)
Message-ID: <b49ec52f-094e-fe83-ba9f-cf03c01b782c@linaro.org>
Date:   Sat, 24 Jun 2023 10:02:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 30/45] dt-bindings: serial: atmel,at91-usart: add
 compatible for sam9x7
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
 <20230623203056.689705-31-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230623203056.689705-31-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23/06/2023 22:30, Varshini Rajendran wrote:
> Add sam9x7 compatible to DT bindings documentation.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
> index 30b2131b5860..d836224f99c6 100644
> --- a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
> +++ b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
> @@ -17,6 +17,7 @@ properties:
>            - atmel,at91rm9200-usart
>            - atmel,at91sam9260-usart
>            - microchip,sam9x60-usart
> +          - microchip,sam9x7-usart
>        - items:
>            - const: atmel,at91rm9200-dbgu
>            - const: atmel,at91rm9200-usart
> @@ -26,6 +27,8 @@ properties:
>        - items:
>            - const: microchip,sam9x60-dbgu
>            - const: microchip,sam9x60-usart
> +          - const: microchip,sam9x7-dbgu
> +          - const: microchip,sam9x7-usart

Same as in other cases, so just to avoid applying by submaintainer: not
tested, broken.

Best regards,
Krzysztof

