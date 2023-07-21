Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E130275C986
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jul 2023 16:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjGUOP4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Jul 2023 10:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjGUOPz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 Jul 2023 10:15:55 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6CF2D46
        for <dmaengine@vger.kernel.org>; Fri, 21 Jul 2023 07:15:49 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbc12181b6so17504855e9.2
        for <dmaengine@vger.kernel.org>; Fri, 21 Jul 2023 07:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689948948; x=1690553748;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tqJx1oLDur71YZiJ9AOk/HdT5XrHv+tqiGxKLoxchuQ=;
        b=WjgkHhw9slY4d3Z6rhH9MRWAmoxJOdHiTMsaLzOud/oL61qFUbAhjzSvIsrBHWN1uh
         BDALZFYyNktwjCYt1eWfN4GUEnHUss6+0fo2OMMIiBNF2H/Nge/ZHwi/8nQx8nadif0h
         a2A9oKoVxLf9RYedhCiXbV1/qRghPk37Dyxdfd6m2IGjgl9nOp9Ydk7qLXLIHHkMO9cF
         BoOCLRs/jgcmrD0mJ/FsrJ4asgJnL9UIbjM4+e3R6syjy6/SdpbS79VkOuhHyyVvF0FK
         zrjkB6kNYbO5r/xyrlh1AnqTpts++LQAEhbm6yDYskflrbHw9spLL0MEWo6DyMs9SwgH
         AOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689948948; x=1690553748;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tqJx1oLDur71YZiJ9AOk/HdT5XrHv+tqiGxKLoxchuQ=;
        b=HvpuJQO9XUxqBCoT3PqUBE7UZCAf4IFBTjIZJS8hB3dueSMkqeIhm82eqgJfgalBu1
         7KG5gy01KVXE4LBMF2F3MkCzlbzELdoxusyzFnnnQ1VK69XADNVyRX9JXAJRvG63p5aM
         T9sxWIiEFTLoNwQwEq1hn/rSTqXEHVH1q0Kum6LTMnoekf0Fi69fQisNxvggHNM1tDUG
         c6m8/map9XtDWexEgyIl7hKwgpq6Q2vxtWgK+S28+cPsTYlYEurUBuZBv5iT5aJqTYIH
         AHF51r5m2rrDmG68StBQnqiYrA4BHdPA3f17vHkWvZQ8+/rS0fZ3iJXbLPV2DOt4jmod
         sbrw==
X-Gm-Message-State: ABy/qLZAA95yVOpspV2m3wmBZtWhT2efdzZVX9QjmWBdDlilV/kbwQi/
        tjfxIu6IwCLKT2kr/E48jNpaiw==
X-Google-Smtp-Source: APBJJlE9uXOdt20pffUoDliLJ+LOAconiMnJAcQNWnII6TbgSCVakmiG2GqJbuFMcH+fKGT3+wtzSw==
X-Received: by 2002:a5d:4b0f:0:b0:314:3ac8:c277 with SMTP id v15-20020a5d4b0f000000b003143ac8c277mr1725645wrq.9.1689948947789;
        Fri, 21 Jul 2023 07:15:47 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id q7-20020a5d5747000000b0031434936f0dsm4334716wrw.68.2023.07.21.07.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 07:15:47 -0700 (PDT)
Message-ID: <4b0f8b39-bec5-6f5d-1b98-8145e334ed94@linaro.org>
Date:   Fri, 21 Jul 2023 16:15:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 35/42] ARM: dts: ep93xx: add ts7250 board
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
 <20230605-ep93xx-v3-35-3d63a5f1103e@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230605-ep93xx-v3-35-3d63a5f1103e@maquefel.me>
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
> Add device tree file for Technologic Systems ts7250 board and
> Liebherr bk3 board which have many in common, both are based on
> ep9302 SoC variant.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  arch/arm/boot/dts/cirrus/Makefile          |   3 +
>  arch/arm/boot/dts/cirrus/ep93xx-bk3.dts    | 126 +++++++++++++++++++++++++
>  arch/arm/boot/dts/cirrus/ep93xx-ts7250.dts | 145 +++++++++++++++++++++++++++++
>  3 files changed, 274 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/cirrus/Makefile b/arch/arm/boot/dts/cirrus/Makefile
> index e944d3e2129d..211a7e2f2115 100644
> --- a/arch/arm/boot/dts/cirrus/Makefile
> +++ b/arch/arm/boot/dts/cirrus/Makefile
> @@ -3,3 +3,6 @@ dtb-$(CONFIG_ARCH_CLPS711X) += \
>  	ep7211-edb7211.dtb
>  dtb-$(CONFIG_ARCH_CLPS711X) += \
>  	ep7211-edb7211.dtb
> +dtb-$(CONFIG_ARCH_EP93XX) += \
> +	ep93xx-bk3.dtb \
> +	ep93xx-ts7250.dtb
> diff --git a/arch/arm/boot/dts/cirrus/ep93xx-bk3.dts b/arch/arm/boot/dts/cirrus/ep93xx-bk3.dts
> new file mode 100644
> index 000000000000..91d76a1a8571
> --- /dev/null
> +++ b/arch/arm/boot/dts/cirrus/ep93xx-bk3.dts
> @@ -0,0 +1,126 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree file for Liebherr controller BK3.1 based on Cirrus EP9302 SoC
> + */
> +/dts-v1/;
> +#include "ep93xx.dtsi"
> +
> +/ {
> +	model = "Liebherr controller BK3.1";
> +	compatible = "liebherr,bk3", "cirrus,ep9301";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	chosen {
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		/* should be set from ATAGS */
> +		reg = <0x00000000 0x02000000>,
> +		      <0x000530c0 0x01fdd000>;
> +	};
> +
> +	nand-controller@60000000 {
> +		compatible = "technologic,ts7200-nand";
> +		reg = <0x60000000 0x8000000>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		nand@0 {
> +			reg = <0>;
> +			partitions {
> +				compatible = "fixed-partitions";
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +
> +				partition@0 {
> +					label = "System";
> +					reg = <0x00000000 0x01e00000>;
> +					read-only;
> +				};
> +
> +				partition@1e00000 {
> +					label = "Data";
> +					reg = <0x01e00000 0x05f20000>;
> +				};
> +
> +				partition@7d20000 {
> +					label = "RedBoot";
> +					reg = <0x07d20000 0x002e0000>;
> +					read-only;
> +				};
> +			};
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		led-0 {
> +			label = "grled";
> +			gpios = <&gpio4 0 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +			function = LED_FUNCTION_HEARTBEAT;
> +		};
> +
> +		led-1 {
> +			label = "rdled";
> +			gpios = <&gpio4 1 GPIO_ACTIVE_HIGH>;
> +			function = LED_FUNCTION_FAULT;
> +		};
> +	};
> +};
> +
> +&eth0 {
> +	phy-handle = <&phy0>;
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +};
> +
> +&i2s {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2s_on_ac97_pins>;
> +	status = "okay";
> +};
> +
> +&gpio1 {
> +	/* PWM */
> +	gpio-ranges = <&pinctrl 6 163 1>;
> +};
> +
> +&gpio4 {
> +	gpio-ranges = <&pinctrl 0 97 2>;
> +	status = "okay";
> +};
> +
> +&gpio6 {
> +	gpio-ranges = <&pinctrl 0 87 2>;
> +	status = "okay";
> +};
> +
> +&gpio7 {
> +	gpio-ranges = <&pinctrl 2 199 4>;
> +	status = "okay";
> +};
> +
> +&mdio0 {
> +	phy0: ethernet-phy@1 {
> +		reg = <1>;
> +		device_type = "ethernet-phy";
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> +
> +&usb0 {
> +	status = "okay";
> +};
> +
> diff --git a/arch/arm/boot/dts/cirrus/ep93xx-ts7250.dts b/arch/arm/boot/dts/cirrus/ep93xx-ts7250.dts
> new file mode 100644
> index 000000000000..625202f8cd25
> --- /dev/null
> +++ b/arch/arm/boot/dts/cirrus/ep93xx-ts7250.dts
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree file for Technologic Systems ts7250 board based on Cirrus EP9302 SoC
> + */
> +/dts-v1/;
> +#include "ep93xx.dtsi"
> +#include <dt-bindings/dma/cirrus,ep93xx-dma.h>
> +
> +/ {
> +	compatible = "technologic,ts7250", "cirrus,ep9301";
> +	model = "TS-7250 SBC";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	chosen {
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		/* should be set from ATAGS */
> +		reg = <0x00000000 0x02000000>,
> +		      <0x000530c0 0x01fdd000>;
> +	};
> +
> +	nand-controller@60000000 {

Where is this address? It does not work like that. If this is part of
SoC, then should be in DTSI and part of soc node. If not, then it is
some other bus which needs some description. Top-level is not a bus.

You should see errors when testing dtbs with W=1.


> +		compatible = "technologic,ts7200-nand";
> +		reg = <0x60000000 0x8000000>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		nand@0 {
> +			reg = <0>;
> +			partitions {
> +				compatible = "fixed-partitions";
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +
> +				partition@0 {
> +					label = "TS-BOOTROM";
> +					reg = <0x00000000 0x00020000>;
> +					read-only;
> +				};
> +
> +				partition@20000 {
> +					label = "Linux";
> +					reg = <0x00020000 0x07d00000>;
> +				};
> +
> +				partition@7d20000 {
> +					label = "RedBoot";
> +					reg = <0x07d20000 0x002e0000>;
> +					read-only;
> +				};
> +			};
> +		};
> +	};
> +
> +	rtc1: rtc@10800000 {

Same problems

> +		compatible = "st,m48t86";
> +		reg = <0x10800000 0x1>,
> +		      <0x11700000 0x1>;
> +	};
> +
> +	watchdog1: watchdog@23800000 {

Same problems

> +		compatible = "technologic,ts7200-wdt";
> +		reg = <0x23800000 0x01>,
> +		      <0x23c00000 0x01>;
> +		timeout-sec = <30>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		led-0 {
> +			label = "grled";
> +			gpios = <&gpio4 0 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +			function = LED_FUNCTION_HEARTBEAT;
> +		};
> +
> +		led-1 {
> +			label = "rdled";
> +			gpios = <&gpio4 1 GPIO_ACTIVE_HIGH>;
> +			function = LED_FUNCTION_FAULT;
> +		};
> +	};
> +};
> +
> +&eth0 {
> +	phy-handle = <&phy0>;
> +};
> +
> +&gpio1 {
> +	/* PWM */
> +	gpio-ranges = <&pinctrl 6 163 1>;
> +};
> +
> +&gpio4 {
> +	gpio-ranges = <&pinctrl 0 97 2>;
> +	status = "okay";
> +};
> +
> +&gpio6 {
> +	gpio-ranges = <&pinctrl 0 87 2>;
> +	status = "okay";
> +};
> +
> +&gpio7 {
> +	gpio-ranges = <&pinctrl 2 199 4>;
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +};
> +
> +&spi0 {
> +	cs-gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;
> +	dmas = <&dma1 EP93XX_DMA_SSP>;
> +	status = "okay";
> +
> +	tmp122_spi: tmp122@0 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +		compatible = "ti,tmp122";
> +		reg = <0>;
> +		spi-max-frequency = <2000000>;
> +	};
> +};
> +


Best regards,
Krzysztof

