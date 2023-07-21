Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D44975C99E
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jul 2023 16:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjGUOQv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Jul 2023 10:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjGUOQt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 Jul 2023 10:16:49 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E34730D0
        for <dmaengine@vger.kernel.org>; Fri, 21 Jul 2023 07:16:46 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fd0f000f1cso12582735e9.1
        for <dmaengine@vger.kernel.org>; Fri, 21 Jul 2023 07:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689949004; x=1690553804;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dVWIG+zijfB5XhEq5zqARsQ/CZyE7I/cG3PK9Bqxgac=;
        b=c5IPu3l7Sljsuw8jE0dZSGTgwVaAaA15v8daFob2kFib1Kge23eCgMtTLUlSK2+3nr
         PhJjEf2k48l0PgLeujngSROlbV7nmbipQxuFV3YtQwrf4lT3QrD3ncnmj+kCl1Wg1jRB
         toc5x/2xxrOAk1NjWtBbN6z0hkbIKuAm8Hc4PhBm1jeeJEDSJauYMjQoEkd1oDNOIv9w
         ToV4lUwRuJ22MJRff09zYDpvlEzKnuk3wVkHH4Irz6Pl08wBA5xKMC/KCKm5yogWxDRc
         ya8nD4hZKqjhgz5KzQypLrv57FgjUxaRXCKYTbv24tKi31JvRYvzhhTTYlLWm8aF8rxG
         /4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689949004; x=1690553804;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dVWIG+zijfB5XhEq5zqARsQ/CZyE7I/cG3PK9Bqxgac=;
        b=Bj+lBJTToouRAkbUKn+D4pErm/8aYHWXRaw4imErsuQt5FWbyhRJAtq+B9KnEY2L6Z
         axjo4HdMH5h3VlFUGtunbQqvq4XsRKg4KLzlGkOlKVUXIq5ABEs6EPPKW3Xq9EVw/+oW
         lqEXhfznR/okxOW6ooON/iWG3mvkKaevIB1/MK+4QH1AApTKxTRzH1Wc9EzDH4owIAAB
         2Ak2gaFLu9teoI/tdFBdi1S/ULvuZtSo4uWTnhIKN4tAg8SoRNSVkYcLNf7ToCVAKXtL
         t0fsj+yriMZSUv4TdMUFE1wbpOXbt/OHQPr6NHVYZX+jgqFAsEOlniKx++ploLPT9hwF
         Q2ew==
X-Gm-Message-State: ABy/qLa2G9sFM2CKBI3aAUeBQzT748V5QzbphEgs8+HcbxAfz+KudXpD
        5I0lAbmi23cB++d9o9wo/+BuCA==
X-Google-Smtp-Source: APBJJlEn7W+o2Bc6tyoiQSmNE/IQp4AIiomxaKVG4rHFx1ctjSGpFRRBne+e459IpFKtG8dU4OnJ2w==
X-Received: by 2002:a1c:770a:0:b0:3f6:d90:3db with SMTP id t10-20020a1c770a000000b003f60d9003dbmr1919079wmi.3.1689949004610;
        Fri, 21 Jul 2023 07:16:44 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id a21-20020a05600c225500b003fbb8c7c799sm6229313wmm.30.2023.07.21.07.16.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 07:16:43 -0700 (PDT)
Message-ID: <283c68a9-fdb5-8813-a68b-b2bdbaa51e26@linaro.org>
Date:   Fri, 21 Jul 2023 16:16:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 41/42] ARM: dts: ep93xx: Add EDB9302 DT
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
 <20230605-ep93xx-v3-41-3d63a5f1103e@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230605-ep93xx-v3-41-3d63a5f1103e@maquefel.me>
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
> From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> 
> Add device tree for Cirrus EDB9302.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  arch/arm/boot/dts/cirrus/Makefile           |   1 +
>  arch/arm/boot/dts/cirrus/ep93xx-edb9302.dts | 178 ++++++++++++++++++++++++++++
>  2 files changed, 179 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/cirrus/Makefile b/arch/arm/boot/dts/cirrus/Makefile
> index 211a7e2f2115..e6015983e464 100644
> --- a/arch/arm/boot/dts/cirrus/Makefile
> +++ b/arch/arm/boot/dts/cirrus/Makefile
> @@ -4,5 +4,6 @@ dtb-$(CONFIG_ARCH_CLPS711X) += \
>  dtb-$(CONFIG_ARCH_CLPS711X) += \
>  	ep7211-edb7211.dtb
>  dtb-$(CONFIG_ARCH_EP93XX) += \
> +	ep93xx-edb9302.dtb \
>  	ep93xx-bk3.dtb \
>  	ep93xx-ts7250.dtb
> diff --git a/arch/arm/boot/dts/cirrus/ep93xx-edb9302.dts b/arch/arm/boot/dts/cirrus/ep93xx-edb9302.dts
> new file mode 100644
> index 000000000000..b048fd131aa5
> --- /dev/null
> +++ b/arch/arm/boot/dts/cirrus/ep93xx-edb9302.dts
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +/*
> + * Device Tree file for Cirrus Logic EDB9302 board based on EP9302 SoC
> + */
> +/dts-v1/;
> +#include "ep93xx.dtsi"
> +#include <dt-bindings/dma/cirrus,ep93xx-dma.h>
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	compatible = "cirrus,edb9302", "cirrus,ep9301";
> +	model = "cirrus,edb9302";
> +
> +	chosen {
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		/* should be set from ATAGS */
> +		reg = <0x0000000 0x800000>,
> +		      <0x1000000 0x800000>,
> +		      <0x4000000 0x800000>,
> +		      <0x5000000 0x800000>;
> +	};
> +
> +	flash@60000000 {

Same problems - it's root, not soc bus.

> +		compatible = "cfi-flash";
> +		reg = <0x60000000 0x1000000>;
> +		bank-width = <2>;
> +	};
> +

Best regards,
Krzysztof

