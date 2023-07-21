Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2751075C8BB
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jul 2023 15:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjGUN6w (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Jul 2023 09:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjGUN6u (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 Jul 2023 09:58:50 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFF23A94
        for <dmaengine@vger.kernel.org>; Fri, 21 Jul 2023 06:58:29 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fb5bcb9a28so3250948e87.3
        for <dmaengine@vger.kernel.org>; Fri, 21 Jul 2023 06:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689947907; x=1690552707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uoi5Y4jjgnWGfQC+MA3PSzDO/nJ69a0U86XqjtM9qm4=;
        b=hovoUSXRq28HNft26oRNivk53rfhvkFzFlsE+3eJGaPu6W9o4Hh4e/ClQ4euEk52Lc
         Ek5BSaAroh2dCUY6scEF0qTX6SJCRLeM3gAKGHAwhgN2TXx3tl8zBKhqZNypY/tWkFHc
         oe7SRYPVtulOU518is+mkTPudusWNGrbXpmSCwGn9SIS+3Qdck423+6xju48zvzmYRLu
         SrCXzGzyT5RKNGORyZpIV27gIbAKSA970kJAUEzrStzCaI6yIn2cD69S96IGPnLOrWz9
         MC4iNZlM1SAONUv1Jf8RdW+s5o5HTVZUOtOFBP3reutBNZI02r+6aCCx7r231ZzUbq/y
         Rnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689947907; x=1690552707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uoi5Y4jjgnWGfQC+MA3PSzDO/nJ69a0U86XqjtM9qm4=;
        b=lCMU4yIisT/OgL2v/ONtLwjoNVozwJK9CMBFAoBNjuJPgsXHNiQaiyXGIJ0SrM7XFr
         nJimbbwumTq6TpeGXwR8jY/98yz4ICUs6RGdOYDhRGZplSrbCizoNktIpz+eioro3lF6
         1HpwhEGfijjbNazHyyBZ9Hz1g6fpPhPVifFPKfsZXuP7cR+gUTQmBiGNzrO/CTOmJXcl
         tRSMZm1Hn1JTZCfIprUfimohZWFYwzblxzXxL86oQEn0gwp499R6uQf9Gv+BNR6KhdDT
         yRQ9kJ4tL3gei5B7AK3QaLNi44Le3VDvo74aMbdwQaOx03pzXN9Us2Cj3ipmmXQGBcDe
         19vg==
X-Gm-Message-State: ABy/qLalA/k/AJgwr1fMkCwPxJcq80FrNCNroa4Y1X93UORpJ+XppMWO
        6G/0/DhMyWMAaIx/Cu+8TGEWww==
X-Google-Smtp-Source: APBJJlFJQPGeO+dM+/CogGYGFX3IbIoIu/R+CmmEzNoP5XS6uM+gVvd5Uqi6hxrOAM8nRxnGkKL4wA==
X-Received: by 2002:a05:6512:1095:b0:4f8:cd67:88e6 with SMTP id j21-20020a056512109500b004f8cd6788e6mr1382568lfg.44.1689947907244;
        Fri, 21 Jul 2023 06:58:27 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id h15-20020aa7c94f000000b0051d890b2407sm2111001edt.81.2023.07.21.06.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 06:58:26 -0700 (PDT)
Message-ID: <53c26a74-3374-cbc4-57cf-3b1cc0904300@linaro.org>
Date:   Fri, 21 Jul 2023 15:58:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 02/42] dt-bindings: clock: Add Cirrus EP93xx
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
 <20230605-ep93xx-v3-2-3d63a5f1103e@maquefel.me>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230605-ep93xx-v3-2-3d63a5f1103e@maquefel.me>
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

On 20/07/2023 13:29, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> This adds device tree bindings for the Cirrus Logic EP93xx
> clock block used in these SoCs.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  .../bindings/clock/cirrus,ep9301-clk.yaml          | 46 ++++++++++++++++++++++
>  include/dt-bindings/clock/cirrus,ep93xx-clock.h    | 41 +++++++++++++++++++
>  2 files changed, 87 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/cirrus,ep9301-clk.yaml b/Documentation/devicetree/bindings/clock/cirrus,ep9301-clk.yaml
> new file mode 100644
> index 000000000000..111e016601fb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/cirrus,ep9301-clk.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/cirrus,ep9301-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logic ep93xx SoC's clock controller
> +
> +maintainers:
> +  - Nikita Shubin <nikita.shubin@maquefel.me>
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: cirrus,ep9301-clk
> +      - items:
> +          - enum:
> +              - cirrus,ep9302-clk
> +              - cirrus,ep9307-clk
> +              - cirrus,ep9312-clk
> +              - cirrus,ep9315-clk
> +          - const: cirrus,ep9301-clk
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  clocks:
> +    items:
> +      - description: reference clock
> +
> +required:
> +  - compatible
> +  - "#clock-cells"
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clock-controller {
> +      compatible = "cirrus,ep9301-clk";
> +      #clock-cells = <1>;
> +      clocks = <&xtali>;
> +    };
> +...
> diff --git a/include/dt-bindings/clock/cirrus,ep93xx-clock.h b/include/dt-bindings/clock/cirrus,ep93xx-clock.h
> new file mode 100644
> index 000000000000..3cd053c0fdea
> --- /dev/null
> +++ b/include/dt-bindings/clock/cirrus,ep93xx-clock.h

Keep the same filename as bindings file.

Best regards,
Krzysztof

