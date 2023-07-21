Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AEB75C94D
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jul 2023 16:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjGUONG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Jul 2023 10:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjGUOMw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 Jul 2023 10:12:52 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644092D7B
        for <dmaengine@vger.kernel.org>; Fri, 21 Jul 2023 07:12:48 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fd18b1d924so16528835e9.1
        for <dmaengine@vger.kernel.org>; Fri, 21 Jul 2023 07:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689948767; x=1690553567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OglWMXk0Y4Go+Z7ASGVUZDhO5twiAsCsGhAeu+lIpcA=;
        b=r5Lp4rMJnn5eIKyD1NIqsg5BJW/qu3+FjJO8B3q8gjwG/SSLpHM9ldbFstWdggN0Lp
         +wTkC+HzclMKhPXnJlcoIVPJMjhaSSQETNuyvyG8i86fFrBYypOc/9ZSTFW29pKIiWVQ
         YbblClTDb5x/UMbDwhzym7VHIjAs7iDQ2iiioKpCd1Gi4LWybp18Uz9KkUDHsHUMv0si
         i00ljiBLH6bvs8afILzI1jXC8ebG0g8mLIp997cecl3ofYyoUzRFuTtUlzn+c4VR0YR1
         X47E5xuCPcxrk3KSxZ1ZoKOsGy5+qkr6bUzKjcJZVNjh/r+4VHnsvmOge8W81+QVTLZo
         w1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689948767; x=1690553567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OglWMXk0Y4Go+Z7ASGVUZDhO5twiAsCsGhAeu+lIpcA=;
        b=cvJUU/NeGG2OpnMOq7kPjWCJ2XQty0ogPY80PXZdvGrU9z6vXA2EomCKqpZYZt4iQU
         BrcijQHjA6o6/C9rabIzx7M732TtZDjrWzbBCX+jvYuOCneHfTtYoc7Jx2qOPR4LmQrV
         2hFJf9bTt2evxG/Z/Hsethl3BtsgMrV97bhlLQtzW72Sc8+5hIryYJyUoZtMpW6wDhnF
         nx4IlsU4LbVG0ebLr/d47+bAIOa3367Y0tGMhgE2VlMTizJi/WWUpCr3K2SbQR7QV+Uo
         hkQRhWl/buOAIiVsZcS1kXYOpx+XojuXQEhVKOrmmgz4BQ3Ln2txLlgbMuggjTqHzzuf
         ndtg==
X-Gm-Message-State: ABy/qLZ5ddsZmlh61Bd3bZvmQLimxDk9bJSrPtwG2idjvLLSWLHXiUi9
        CaDyoC9Urocb3yHDAuZ41ArRog==
X-Google-Smtp-Source: APBJJlEStVaia+3u6ayM56SyBeTVqjBg5h0ggV22D2IH/aXxEJBn1QpA5N4d2Ym3PU3h7h5Cn6Wiig==
X-Received: by 2002:a1c:e902:0:b0:3fc:521:8492 with SMTP id q2-20020a1ce902000000b003fc05218492mr1495617wmc.5.1689948766712;
        Fri, 21 Jul 2023 07:12:46 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id f14-20020a7bcd0e000000b003fc01f7b415sm6205183wmj.39.2023.07.21.07.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 07:12:46 -0700 (PDT)
Message-ID: <68f52a83-ac01-ff68-1eee-20713ae8eb26@linaro.org>
Date:   Fri, 21 Jul 2023 16:12:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 34/42] ARM: dts: add Cirrus EP93XX SoC .dtsi
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
 <20230605-ep93xx-v3-34-3d63a5f1103e@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230605-ep93xx-v3-34-3d63a5f1103e@maquefel.me>
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
> Add support for Cirrus Logic EP93XX SoC's family.
> 
> Co-developed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  arch/arm/boot/dts/cirrus/ep93xx.dtsi | 449 +++++++++++++++++++++++++++++++++++
>  1 file changed, 449 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/cirrus/ep93xx.dtsi b/arch/arm/boot/dts/cirrus/ep93xx.dtsi
> new file mode 100644
> index 000000000000..1e04f39d7b80
> --- /dev/null
> +++ b/arch/arm/boot/dts/cirrus/ep93xx.dtsi
> @@ -0,0 +1,449 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree file for Cirrus Logic systems EP93XX SoC
> + */
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/clock/cirrus,ep93xx-clock.h>
> +/ {
> +	soc: soc {
> +		compatible = "simple-bus";
> +		ranges;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		syscon: syscon@80930000 {
> +			compatible = "cirrus,ep9301-syscon",
> +						 "syscon", "simple-mfd";

Fix alignment.

> +			reg = <0x80930000 0x1000>;
> +
> +			eclk: clock-controller {
> +				compatible = "cirrus,ep9301-clk";
> +				#clock-cells = <1>;
> +				clocks = <&xtali>;
> +				status = "okay";

Drop statuses when not needed.

> +			};
> +
> +			pinctrl: pinctrl {
> +				compatible = "cirrus,ep9301-pinctrl";
> +
> +				spi_default_pins: pins-spi {
> +					function = "spi";
> +					groups = "ssp";
> +				};
> +

...

> +
> +		keypad: keypad@800f0000 {
> +			compatible = "cirrus,ep9307-keypad";
> +			reg = <0x800f0000 0x0c>;
> +			interrupt-parent = <&vic0>;
> +			interrupts = <29>;
> +			clocks = <&eclk EP93XX_CLK_KEYPAD>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&keypad_default_pins>;
> +			linux,keymap =

No need for line break.

> +					<KEY_UP>,
> +					<KEY_DOWN>,
> +					<KEY_VOLUMEDOWN>,
> +					<KEY_HOME>,
> +					<KEY_RIGHT>,
> +					<KEY_LEFT>,
> +					<KEY_ENTER>,
> +					<KEY_VOLUMEUP>,
> +					<KEY_F6>,
> +					<KEY_F8>,
> +					<KEY_F9>,
> +					<KEY_F10>,
> +					<KEY_F1>,
> +					<KEY_F2>,
> +					<KEY_F3>,
> +					<KEY_POWER>;
> +		};
> +
> +		pwm0: pwm@80910000 {
> +			compatible = "cirrus,ep9301-pwm";
> +			reg = <0x80910000 0x10>;
> +			clocks = <&eclk EP93XX_CLK_PWM>;
> +			status = "disabled";
> +		};
> +
> +		pwm1: pwm@80910020 {
> +			compatible = "cirrus,ep9301-pwm";
> +			reg = <0x80910020 0x10>;
> +			clocks = <&eclk EP93XX_CLK_PWM>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pwm1_default_pins>;
> +			status = "disabled";
> +		};
> +
> +		rtc0: rtc@80920000 {
> +			compatible = "cirrus,ep9301-rtc";
> +			reg = <0x80920000 0x100>;
> +		};
> +
> +		spi0: spi@808a0000 {
> +			compatible = "cirrus,ep9301-spi";
> +			reg = <0x808a0000 0x18>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupt-parent = <&vic1>;
> +			interrupts = <21>;
> +			clocks = <&eclk EP93XX_CLK_SPI>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&spi_default_pins>;
> +			status = "disabled";
> +		};
> +
> +		timer: timer@80810000 {
> +			compatible = "cirrus,ep9301-timer";
> +			reg = <0x80810000 0x100>;
> +			interrupt-parent = <&vic1>;
> +			interrupts = <19>;
> +		};
> +
> +		uart0: uart@808c0000 {
> +			compatible = "arm,primecell";

This looks incomplete.

> +			reg = <0x808c0000 0x1000>;
> +			arm,primecell-periphid = <0x00041010>;
> +			clocks = <&eclk EP93XX_CLK_UART1>, <&eclk EP93XX_CLK_UART>;
> +			clock-names = "apb:uart1", "apb_pclk";

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +			interrupt-parent = <&vic1>;
> +			interrupts = <20>;
> +			status = "disabled";
> +		};
> +
> +		uart1: uart@808d0000 {
> +			compatible = "arm,primecell";
> +			reg = <0x808d0000 0x1000>;
> +			arm,primecell-periphid = <0x00041010>;
> +			clocks = <&eclk EP93XX_CLK_UART2>, <&eclk EP93XX_CLK_UART>;
> +			clock-names = "apb:uart2", "apb_pclk";

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +			interrupt-parent = <&vic1>;
> +			interrupts = <22>;
> +			status = "disabled";
> +		};
> +
> +		uart2: uart@808b0000 {
> +			compatible = "arm,primecell";
> +			reg = <0x808b0000 0x1000>;
> +			arm,primecell-periphid = <0x00041010>;
> +			clocks = <&eclk EP93XX_CLK_UART3>, <&eclk EP93XX_CLK_UART>;
> +			clock-names = "apb:uart3", "apb_pclk";
> +			interrupt-parent = <&vic1>;
> +			interrupts = <23>;
> +			status = "disabled";
> +		};
> +
> +		usb0: usb@80020000 {
> +			compatible = "generic-ohci";
> +			reg = <0x80020000 0x10000>;
> +			interrupt-parent = <&vic1>;
> +			interrupts = <24>;
> +			clocks = <&eclk EP93XX_CLK_USB>;
> +			status = "disabled";
> +		};
> +
> +		watchdog0: watchdog@80940000 {
> +			compatible = "cirrus,ep9301-wdt";
> +			reg = <0x80940000 0x08>;
> +		};
> +	};
> +
> +	xtali: oscillator {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <14745600>;
> +		clock-output-names = "xtali";
> +	};
> +
> +	i2c0: i2c {
> +		compatible = "i2c-gpio";
> +		sda-gpios = <&gpio6 1 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> +		scl-gpios = <&gpio6 0 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;

Are you sure this is part of SoC? It is rather unusual... I would say
this would be the first SoC, where GPIO pins must be an I2C.



Best regards,
Krzysztof

