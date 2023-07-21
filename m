Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AA375C9CA
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jul 2023 16:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbjGUOXD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Jul 2023 10:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjGUOWy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 Jul 2023 10:22:54 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E2D30C4
        for <dmaengine@vger.kernel.org>; Fri, 21 Jul 2023 07:22:45 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbf1b82d9cso16954385e9.2
        for <dmaengine@vger.kernel.org>; Fri, 21 Jul 2023 07:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689949364; x=1690554164;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VDX19vDEIXyu3IFb94kHKgIM7QuqKWcHAhwogKCp3HA=;
        b=xRkeCtCOHRy6PlqUYvtoT21Emi/YIis3tpnx2n/9B8tsJb7DUOmRf+4YdlSTo4YmHL
         8Be2Yd9uvZL+FsIPLjGTeuz1LhYRJ2LmTUYtGe1cPUj/+2l+fFrp6z94IMje8ZH5nnKJ
         0oR4ie8KwSA7ItvHO8Q8isNQlqBFXRaMHxzhwAa7BEUztIHMjsgDc/GkSGYloFdAfdR/
         aE4EIESoy8zMrcnZaGGmbCkfr64ffZcxJkLS+JeepwSHs5PdC0zcrspU6EkyteqYzBFY
         HhzUHmfO4DNRF8jlHt3i1k0Rg153t74cc1c1qw/SwbmX+VvSe8s6GAYTD/gyaO2i1BJv
         QH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689949364; x=1690554164;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VDX19vDEIXyu3IFb94kHKgIM7QuqKWcHAhwogKCp3HA=;
        b=AxeSE7XKUz9kENcDUyh5rzEzEFVKYQyoixqgtP+MS3sJ0+12iCwo0xhhP39l8aCm68
         TPszPckcjOJfAOHryOp2ataUbLJEBOYFvro9eeTZ/wl9gtxGBpd36PGikkWCyIs7eLP1
         4SdQlHLOrAtRv4q4UvZqcOJnNoZEov8RfTJZB8kxV9aBi7Pd6G36tLev/OdpkZofpOUj
         NqD03y83YvzLvtkQpEQqt+ONRkTtFdWiXK8SUiRa9QLyoyKjSpP0tmPxVmOeF7j1ZDwa
         wnYQJhMf0kiujsH44JxCtT52BIT76kA7/9l7vDZSEQ6pfWK9x68ulhit5PIj9OHL1bD6
         Z/gQ==
X-Gm-Message-State: ABy/qLZDrTYnTpSm+yVyAd6jWnE9a9JIekEqq50n7n56fszDoHy6XbHJ
        zokKPqgoMJmqEc+OpJEW4tHd5Q==
X-Google-Smtp-Source: APBJJlH7uQOeBsgKWGvO5Rmly7OItltRcCFNbXEVqWnWKB44qAlI8c74MMOCZZ4OQhY6Wj7y/LID/Q==
X-Received: by 2002:a1c:7518:0:b0:3fc:85c:5ef7 with SMTP id o24-20020a1c7518000000b003fc085c5ef7mr1575647wmc.22.1689949363637;
        Fri, 21 Jul 2023 07:22:43 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id f12-20020a7bcc0c000000b003fc0062f0f8sm3513929wmh.9.2023.07.21.07.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 07:22:42 -0700 (PDT)
Message-ID: <0ec81b89-4d4c-4e13-5ea0-697f5c0af835@linaro.org>
Date:   Fri, 21 Jul 2023 16:22:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 07/42] soc: Add SoC driver for Cirrus ep93xx
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
 <20230605-ep93xx-v3-7-3d63a5f1103e@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230605-ep93xx-v3-7-3d63a5f1103e@maquefel.me>
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
> This adds an SoC driver for the ep93xx. Currently there
> is only one thing not fitting into any other framework,
> and that is the swlock setting.
> 
> It's used for clock settings and restart.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/soc/Kconfig               |   1 +
>  drivers/soc/Makefile              |   1 +
>  drivers/soc/cirrus/Kconfig        |  12 ++
>  drivers/soc/cirrus/Makefile       |   2 +
>  drivers/soc/cirrus/soc-ep93xx.c   | 231 ++++++++++++++++++++++++++++++++++++++
>  include/linux/soc/cirrus/ep93xx.h |  18 ++-
>  6 files changed, 264 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index 4e176280113a..16327b63b773 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -8,6 +8,7 @@ source "drivers/soc/aspeed/Kconfig"
>  source "drivers/soc/atmel/Kconfig"
>  source "drivers/soc/bcm/Kconfig"
>  source "drivers/soc/canaan/Kconfig"
> +source "drivers/soc/cirrus/Kconfig"
>  source "drivers/soc/fsl/Kconfig"
>  source "drivers/soc/fujitsu/Kconfig"
>  source "drivers/soc/imx/Kconfig"
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 3b0f9fb3b5c8..b76a03fe808e 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -9,6 +9,7 @@ obj-y				+= aspeed/
>  obj-$(CONFIG_ARCH_AT91)		+= atmel/
>  obj-y				+= bcm/
>  obj-$(CONFIG_SOC_CANAAN)	+= canaan/
> +obj-$(CONFIG_EP93XX_SOC)        += cirrus/
>  obj-$(CONFIG_ARCH_DOVE)		+= dove/
>  obj-$(CONFIG_MACH_DOVE)		+= dove/
>  obj-y				+= fsl/
> diff --git a/drivers/soc/cirrus/Kconfig b/drivers/soc/cirrus/Kconfig
> new file mode 100644
> index 000000000000..408f3343a265
> --- /dev/null
> +++ b/drivers/soc/cirrus/Kconfig
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +if ARCH_EP93XX
> +
> +config EP93XX_SOC
> +	bool "Cirrus EP93xx chips SoC"
> +	select SOC_BUS
> +	default y if !EP93XX_SOC_COMMON
> +	help
> +	  Support SoC for Cirrus EP93xx chips.
> +
> +endif
> diff --git a/drivers/soc/cirrus/Makefile b/drivers/soc/cirrus/Makefile
> new file mode 100644
> index 000000000000..ed6752844c6f
> --- /dev/null
> +++ b/drivers/soc/cirrus/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-y	+= soc-ep93xx.o
> diff --git a/drivers/soc/cirrus/soc-ep93xx.c b/drivers/soc/cirrus/soc-ep93xx.c
> new file mode 100644
> index 000000000000..2fd48d900f24
> --- /dev/null
> +++ b/drivers/soc/cirrus/soc-ep93xx.c
> @@ -0,0 +1,231 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SoC driver for Cirrus EP93xx chips.
> + * Copyright (C) 2022 Nikita Shubin <nikita.shubin@maquefel.me>
> + *
> + * Based on a rewrite of arch/arm/mach-ep93xx/core.c
> + * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
> + * Copyright (C) 2007 Herbert Valerio Riedel <hvr@gnu.org>
> + *
> + * Thanks go to Michael Burian and Ray Lehtiniemi for their key
> + * role in the ep93xx Linux community
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/sys_soc.h>
> +#include <linux/soc/cirrus/ep93xx.h>
> +
> +#define EP93XX_EXT_CLK_RATE		14745600
> +
> +#define EP93XX_SYSCON_DEVCFG		0x80
> +
> +#define EP93XX_SWLOCK_MAGICK		0xaa
> +#define EP93XX_SYSCON_SWLOCK		0xc0
> +#define EP93XX_SYSCON_SYSCFG		0x9c
> +#define EP93XX_SYSCON_SYSCFG_REV_MASK	0xf0000000
> +#define EP93XX_SYSCON_SYSCFG_REV_SHIFT	28
> +
> +#define EP93XX_SYSCON_CLKSET1		0x20
> +#define EP93XX_SYSCON_CLKSET1_NBYP1	BIT(23)
> +#define EP93XX_SYSCON_CLKSET2		0x24
> +#define EP93XX_SYSCON_CLKSET2_NBYP2	BIT(19)
> +#define EP93XX_SYSCON_CLKSET2_PLL2_EN	BIT(18)
> +
> +static DEFINE_SPINLOCK(ep93xx_swlock);
> +
> +/* EP93xx System Controller software locked register write */
> +void ep93xx_syscon_swlocked_write(struct regmap *map, unsigned int reg, unsigned int val)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ep93xx_swlock, flags);
> +
> +	regmap_write(map, EP93XX_SYSCON_SWLOCK, EP93XX_SWLOCK_MAGICK);
> +	regmap_write(map, reg, val);
> +
> +	spin_unlock_irqrestore(&ep93xx_swlock, flags);
> +}
> +EXPORT_SYMBOL_NS_GPL(ep93xx_syscon_swlocked_write, EP93XX_SOC);

I doubt that your code compiles. Didn't you add a user of this in some
earlier patch?

Anyway, no, drop it, don't export some weird calls from core initcall to
drivers. You violate layering and driver encapsulation. There is no
dependency/probe ordering.

There is no even need for this, because this code does not use it!

> +
> +void ep93xx_devcfg_set_clear(struct regmap *map, unsigned int set_bits, unsigned int clear_bits)
> +{
> +	unsigned long flags;
> +	unsigned int val;
> +
> +	spin_lock_irqsave(&ep93xx_swlock, flags);
> +
> +	regmap_read(map, EP93XX_SYSCON_DEVCFG, &val);
> +	val &= ~clear_bits;
> +	val |= set_bits;
> +	regmap_write(map, EP93XX_SYSCON_SWLOCK, EP93XX_SWLOCK_MAGICK);
> +	regmap_write(map, EP93XX_SYSCON_DEVCFG, val);
> +
> +	spin_unlock_irqrestore(&ep93xx_swlock, flags);
> +}
> +EXPORT_SYMBOL_NS_GPL(ep93xx_devcfg_set_clear, EP93XX_SOC);

No.

> +
> +void ep93xx_swlocked_update_bits(struct regmap *map, unsigned int reg,
> +				 unsigned int mask, unsigned int val)
> +{
> +	unsigned long flags;
> +	unsigned int tmp, orig;
> +
> +	spin_lock_irqsave(&ep93xx_swlock, flags);
> +
> +	regmap_read(map, EP93XX_SYSCON_DEVCFG, &orig);
> +	tmp = orig & ~mask;
> +	tmp |= val & mask;
> +	if (tmp != orig) {
> +		regmap_write(map, EP93XX_SYSCON_SWLOCK, EP93XX_SWLOCK_MAGICK);
> +		regmap_write(map, reg, tmp);
> +	}
> +
> +	spin_unlock_irqrestore(&ep93xx_swlock, flags);
> +}
> +EXPORT_SYMBOL_NS_GPL(ep93xx_swlocked_update_bits, EP93XX_SOC);

No.


> +
> +unsigned int __init ep93xx_chip_revision(struct regmap *map)

Why this is visible outside? This should be static.


> +{
> +	unsigned int val;
> +
> +	regmap_read(map, EP93XX_SYSCON_SYSCFG, &val);
> +	val &= EP93XX_SYSCON_SYSCFG_REV_MASK;
> +	val >>= EP93XX_SYSCON_SYSCFG_REV_SHIFT;
> +	return val;
> +}


> +
> +static const char __init *ep93xx_get_soc_rev(struct regmap *map)
> +{
> +	int rev = ep93xx_chip_revision(map);
> +
> +	switch (rev) {
> +	case EP93XX_CHIP_REV_D0:
> +		return "D0";
> +	case EP93XX_CHIP_REV_D1:
> +		return "D1";
> +	case EP93XX_CHIP_REV_E0:
> +		return "E0";
> +	case EP93XX_CHIP_REV_E1:
> +		return "E1";
> +	case EP93XX_CHIP_REV_E2:
> +		return "E2";
> +	default:
> +		return "unknown";
> +	}
> +}
> +
> +/*
> + * PLL rate = 14.7456 MHz * (X1FBD + 1) * (X2FBD + 1) / (X2IPD + 1) / 2^PS
> + */
> +static unsigned long __init calc_pll_rate(u64 rate, u32 config_word)
> +{
> +	rate *= ((config_word >> 11) & GENMASK(4, 0)) + 1;	/* X1FBD */
> +	rate *= ((config_word >> 5) & GENMASK(5, 0)) + 1;	/* X2FBD */
> +	do_div(rate, (config_word & GENMASK(4, 0)) + 1);	/* X2IPD */
> +	rate >>= ((config_word >> 16) & 3);			/* PS */
> +
> +	return rate;
> +}
> +
> +static int __init ep93xx_soc_init(void)
> +{
> +	struct soc_device_attribute *attrs;
> +	struct soc_device *soc_dev;
> +	struct device_node *np;
> +	struct regmap *map;
> +	struct clk_hw *hw;
> +	unsigned long clk_pll1_rate, clk_pll2_rate;
> +	unsigned int clk_f_div, clk_h_div, clk_p_div, clk_usb_div;
> +	const char fclk_divisors[] = { 1, 2, 4, 8, 16, 1, 1, 1 };
> +	const char hclk_divisors[] = { 1, 2, 4, 5, 6, 8, 16, 32 };
> +	const char pclk_divisors[] = { 1, 2, 4, 8 };
> +	const char *machine = NULL;
> +	u32 value;
> +
> +	/* Multiplatform guard, only proceed on ep93xx */
> +	if (!of_machine_is_compatible("cirrus,ep9301"))
> +		return 0;

This should already be a warning sign for you...

> +
> +	map = syscon_regmap_lookup_by_compatible("cirrus,ep9301-syscon");
> +	if (IS_ERR(map))
> +		return PTR_ERR(map);

No, not-reusable. Use devices and device nodes.

> +
> +	/* Determine the bootloader configured pll1 rate */
> +	regmap_read(map, EP93XX_SYSCON_CLKSET1, &value);
> +	if (!(value & EP93XX_SYSCON_CLKSET1_NBYP1))
> +		clk_pll1_rate = EP93XX_EXT_CLK_RATE;
> +	else
> +		clk_pll1_rate = calc_pll_rate(EP93XX_EXT_CLK_RATE, value);
> +
> +	hw = clk_hw_register_fixed_rate(NULL, "pll1", "xtali", 0, clk_pll1_rate);
> +	if (IS_ERR(hw))
> +		return PTR_ERR(hw);
> +
> +	/* Initialize the pll1 derived clocks */
> +	clk_f_div = fclk_divisors[(value >> 25) & 0x7];
> +	clk_h_div = hclk_divisors[(value >> 20) & 0x7];
> +	clk_p_div = pclk_divisors[(value >> 18) & 0x3];
> +
> +	hw = clk_hw_register_fixed_factor(NULL, "fclk", "pll1", 0, 1, clk_f_div);
> +	if (IS_ERR(hw))
> +		return PTR_ERR(hw);
> +
> +	hw = clk_hw_register_fixed_factor(NULL, "hclk", "pll1", 0, 1, clk_h_div);
> +	if (IS_ERR(hw))
> +		return PTR_ERR(hw);
> +
> +	hw = clk_hw_register_fixed_factor(NULL, "pclk", "hclk", 0, 1, clk_p_div);
> +	if (IS_ERR(hw))
> +		return PTR_ERR(hw);
> +
> +	/* Determine the bootloader configured pll2 rate */
> +	regmap_read(map, EP93XX_SYSCON_CLKSET2, &value);
> +	if (!(value & EP93XX_SYSCON_CLKSET2_NBYP2))
> +		clk_pll2_rate = EP93XX_EXT_CLK_RATE;
> +	else if (value & EP93XX_SYSCON_CLKSET2_PLL2_EN)
> +		clk_pll2_rate = calc_pll_rate(EP93XX_EXT_CLK_RATE, value);
> +	else
> +		clk_pll2_rate = 0;
> +
> +	hw = clk_hw_register_fixed_rate(NULL, "pll2", "xtali", 0, clk_pll2_rate);
> +	if (IS_ERR(hw))
> +		return PTR_ERR(hw);
> +
> +	regmap_read(map, EP93XX_SYSCON_CLKSET2, &value);
> +	clk_usb_div = (((value >> 28) & GENMASK(3, 0)) + 1);
> +	hw = clk_hw_register_fixed_factor(NULL, "usb_clk", "pll2", 0, 1, clk_usb_div);
> +	if (IS_ERR(hw))
> +		return PTR_ERR(hw);
> +
> +	attrs = kzalloc(sizeof(*attrs), GFP_KERNEL);
> +	if (!attrs)
> +		return -ENOMEM;
> +
> +	np = of_find_node_by_path("/");
> +	of_property_read_string(np, "model", &machine);
> +	if (machine)
> +		attrs->machine = kstrdup(machine, GFP_KERNEL);
> +	of_node_put(np);
> +
> +	attrs->family = "Cirrus Logic EP93xx";
> +	attrs->revision = ep93xx_get_soc_rev(map);
> +
> +	soc_dev = soc_device_register(attrs);
> +	if (IS_ERR(soc_dev)) {
> +		kfree(attrs->soc_id);
> +		kfree(attrs->serial_number);
> +		kfree(attrs);
> +		return PTR_ERR(soc_dev);
> +	}
> +
> +	pr_info("EP93xx SoC revision %s\n", attrs->revision);
> +
> +	return 0;
> +}
> +core_initcall(ep93xx_soc_init);

That's not the way to add soc driver. You need a proper driver for it

Best regards,
Krzysztof

