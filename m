Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC2375AFD5
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jul 2023 15:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjGTN3P (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Jul 2023 09:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGTN3B (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Jul 2023 09:29:01 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC502D77;
        Thu, 20 Jul 2023 06:28:36 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b852785a65so6073965ad.0;
        Thu, 20 Jul 2023 06:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689859715; x=1690464515;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3o5zfhOrGvbkMhIZNHbLcgV0VOFO8KOUPcq8qPlAWh4=;
        b=II3kNkpXwPdcCl5YHO4c2SdZlaof4sRkgoc/bpxKmFONK+AnVHwT1l7cn4fep4l2pZ
         RKQPLK4YtMeQSGR5iqY/qohmxFaLzZ1ClUnoBaAnXkyj8ZtgLGPZrxlSRrbXTRR6JuFE
         1/XRgM2FIIeAEdO8c6Bnsmo11XN81iFNABpU1uWMfxl2AT70aV2t6lD+Lvsz3z0sVruD
         Uow4lWraZWjlX9pw2usWm2WakkdaoKw1c6bRllOiAPjWueKo+tDHsJogOPb38guW70UF
         VU2sVcwD6/G14KhffAcn6pAqokkebSFot2kkwvOG6VTqnh2LdN7nEmxQT8ylWbgSo4Lq
         gfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689859715; x=1690464515;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3o5zfhOrGvbkMhIZNHbLcgV0VOFO8KOUPcq8qPlAWh4=;
        b=TqjV+s1zQkdYN47mIkCCe5FpwDkxLvduj45yNSd8nQHNO10uVHPp22/1+VUUS4j+GJ
         q5gcshwfruENAO9bhjtVzn4D1smLqXzhBbyXQLxMi+pIYdzCy7WaEX6vhhyKdo4qBFU/
         Qu75T3Ld1VMW4ma8UuB6+JVd33fjDdA/K7xXqnc4LPTZy/mHIBRZjBRQVKJeJr2spnAX
         eAnQW0/FHZQvM6m+YPlRgXXgKBWLr9jmLi0FM6iXr2MBb90i7Ps3yjkckLeBVCvaNqxI
         hCjzMYpAJbdXq1CLRG3cgombPJUcMr8xviCQtUroKCGt4DEWhlVcPwWiOK7KVW9/o1RS
         8wHA==
X-Gm-Message-State: ABy/qLaFVp/M30aIwkZq8a7ntKoFRzom3T4uRveoyR5IFgXi/lVfVBq2
        amuhaoni2DIzQvmb1BQ7Dgk=
X-Google-Smtp-Source: APBJJlHUPUivfHOgoXJP79qDNd5D4J3nF3SUABKNXv3IzHnbDE0pcAqJjXDoFhMrl2kqZtr0UmSiBg==
X-Received: by 2002:a17:902:c94c:b0:1b7:ca9c:4f5c with SMTP id i12-20020a170902c94c00b001b7ca9c4f5cmr6694496pla.28.1689859715396;
        Thu, 20 Jul 2023 06:28:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jc15-20020a17090325cf00b001b5247cac3dsm1346340plb.110.2023.07.20.06.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 06:28:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <def5b29c-3318-2db1-a7fa-612ed1e81be6@roeck-us.net>
Date:   Thu, 20 Jul 2023 06:28:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 12/42] dt-bindings: watchdog: Add Cirrus EP93x
Content-Language: en-US
To:     nikita.shubin@maquefel.me,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Lennert Buytenhek <kernel@wantstofly.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Lukasz Majewski <lukma@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
        netdev@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-input@vger.kernel.org, alsa-devel@alsa-project.org
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
 <20230605-ep93xx-v3-12-3d63a5f1103e@maquefel.me>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230605-ep93xx-v3-12-3d63a5f1103e@maquefel.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 7/20/23 04:29, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> This adds device tree bindings for the Cirrus Logic EP93xx
> watchdog block used in these SoCs.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>   .../bindings/watchdog/cirrus,ep9301-wdt.yaml       | 46 ++++++++++++++++++++++
>   1 file changed, 46 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/cirrus,ep9301-wdt.yaml b/Documentation/devicetree/bindings/watchdog/cirrus,ep9301-wdt.yaml
> new file mode 100644
> index 000000000000..d54595174a12
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/cirrus,ep9301-wdt.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/cirrus,ep9301-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logic EP93xx Watchdog Timer
> +
> +maintainers:
> +  - Nikita Shubin <nikita.shubin@maquefel.me>
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +
> +description:
> +  Cirrus Logic EP93xx SoC family has it's own watchdog implementation
> +

Odd description. Isn't that true for pretty much every devicetree
bindings file, and pretty much every hardware driver ?

> +allOf:
> +  - $ref: watchdog.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: cirrus,ep9301-wdt
> +      - items:
> +          - enum:
> +              - cirrus,ep9302-wdt
> +              - cirrus,ep9307-wdt
> +              - cirrus,ep9312-wdt
> +              - cirrus,ep9315-wdt
> +          - const: cirrus,ep9301-wdt
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    watchdog@80940000 {
> +        compatible = "cirrus,ep9301-wdt";
> +        reg = <0x80940000 0x08>;
> +    };
> +
> 

