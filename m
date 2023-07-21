Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD87775C8F4
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jul 2023 16:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjGUOEr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Jul 2023 10:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjGUOEp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 Jul 2023 10:04:45 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E70A2D46
        for <dmaengine@vger.kernel.org>; Fri, 21 Jul 2023 07:04:41 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fc03aa6e04so16466625e9.2
        for <dmaengine@vger.kernel.org>; Fri, 21 Jul 2023 07:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689948280; x=1690553080;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i0hqft4rLykA1Qm+aWWngJrri1KXMWVHpmrflE+PpLU=;
        b=PuGwprqKdpq8LkzNLASjiLmbz8p+yLCZy03ATCdJs8insWuhZan57oKC4jNZCzS4ND
         E7w8hDj2JEk/yaK001S70oJdFPQrhUiTFfWV3ga4MQCxDAA5JM/JTtabf+JXMWw8QZqr
         uoSOVXGMsahKvU4F69owM+VtHTiwZXV4Sac3eBA92YtCWMRlMuuTlEdryO1jsFqitT9q
         Y1i7MCt3snL55MX8kx8uOg3fD3m9IlBurQS/nGi/qx0D8zW2mRSuqw3P0325+pIM+Zak
         ouue3EcgaEHjRHxqHf3v/fAkDRZkz6EaGTuc3CsJGpLhr2+Jc9UQriimeNAwdK1RDAD2
         VUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689948280; x=1690553080;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i0hqft4rLykA1Qm+aWWngJrri1KXMWVHpmrflE+PpLU=;
        b=IVTzsJGwdcYRpv6TuSIQuzJuN/ft7ProrL4s/4IozhBwpx4+7bebsAx3N0DU9hLrNr
         k5a7t7fgQWkt25BwDJHBvrAp9Rj4+4f5+y6VbSu44jUpxJGH013DMLRLLUB9tty15qeQ
         4uHM11GKXzAGvF/Y1Bb5VfykLa4SHVURDL32zAw3+/bDHUDb/sueXMsdLvFwSH0Kdqdb
         tCOT0FVdCxBEpmN6cya4rYRd7R/aW+ir6349SEjVCfvbosWvEnjOdMA0A91xFRrGdcnc
         QoTABU6fQZYy6+5HZ66KyYPECaSO1+3ML7FwzS+S90BlxYu8s4s6+H1RGB72uyUym4+k
         rH9Q==
X-Gm-Message-State: ABy/qLbG9xlz0UOjqu8nF09cd2j78UqHKInKz1EOec8GD38oBDFaLIT/
        jv+mbCvoHii12fIhJrbUF8Y4ZQ==
X-Google-Smtp-Source: APBJJlEsMYe5JQ+pU4AezELFYdRQHmI7TefsDs6cDm78/h68oOlcICdvW129lDjtJ/t6VHgFfG467Q==
X-Received: by 2002:adf:fc03:0:b0:314:1634:491e with SMTP id i3-20020adffc03000000b003141634491emr1269926wrr.20.1689948279591;
        Fri, 21 Jul 2023 07:04:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id x8-20020a1c7c08000000b003f90b9b2c31sm6142028wmc.28.2023.07.21.07.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 07:04:38 -0700 (PDT)
Message-ID: <5603264e-2efe-48ce-b025-797501f29fde@linaro.org>
Date:   Fri, 21 Jul 2023 16:04:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 06/42] dt-bindings: soc: Add Cirrus EP93xx
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
        Guenter Roeck <linux@roeck-us.net>,
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
 <20230605-ep93xx-v3-6-3d63a5f1103e@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230605-ep93xx-v3-6-3d63a5f1103e@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20/07/2023 13:29, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> This adds device tree bindings for the Cirrus Logic EP93xx.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  .../bindings/arm/cirrus/ep9301-syscon.yaml         | 59 ++++++++++++++++++++++

syscon goes to soc directory. Also, please add vendor prefix to the
filenames.

>  .../devicetree/bindings/arm/cirrus/ep9301.yaml     | 39 ++++++++++++++
>  2 files changed, 98 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cirrus/ep9301-syscon.yaml b/Documentation/devicetree/bindings/arm/cirrus/ep9301-syscon.yaml
> new file mode 100644
> index 000000000000..77fbe1f006fd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/cirrus/ep9301-syscon.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/cirrus/ep9301-syscon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logic EP93xx Platforms System Controller
> +
> +maintainers:
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +  - Nikita Shubin <nikita.shubin@maquefel.me>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - cirrus,ep9302-syscon
> +              - cirrus,ep9307-syscon
> +              - cirrus,ep9312-syscon
> +              - cirrus,ep9315-syscon
> +          - const: cirrus,ep9301-syscon
> +          - const: syscon
> +          - const: simple-mfd
> +      - items:
> +          - const: cirrus,ep9301-syscon
> +          - const: syscon
> +          - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  reboot:
> +    type: object
> +    properties:
> +      compatible:
> +        const: cirrus,ep9301-reboot

Patch introducing it should be before this one. Also, do not use
different styles for your child nodes. Your other nodes use $ref.

> +
> +  clock-controller:
> +    type: object
> +    $ref: ../../clock/cirrus,ep9301-clk.yaml

Absolute path, so /schemas/clock/cirrus.....

> +
> +  pinctrl:
> +    type: object
> +    $ref: ../../pinctrl/cirrus,ep9301-pinctrl.yaml

Ditto

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    syscon@80930000 {
> +      compatible = "cirrus,ep9301-syscon",
> +                   "syscon", "simple-mfd";
> +      reg = <0x80930000 0x1000>;

Incomplete example.

> +    };
> diff --git a/Documentation/devicetree/bindings/arm/cirrus/ep9301.yaml b/Documentation/devicetree/bindings/arm/cirrus/ep9301.yaml
> new file mode 100644
> index 000000000000..6087784e93fb
> --- /dev/null


Best regards,
Krzysztof

