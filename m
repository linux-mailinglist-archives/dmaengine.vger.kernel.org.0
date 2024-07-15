Return-Path: <dmaengine+bounces-2699-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EDE9313C1
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jul 2024 14:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C91F1C213A4
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jul 2024 12:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C302318C19A;
	Mon, 15 Jul 2024 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXEEW3ex"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C86E18C18E;
	Mon, 15 Jul 2024 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721045569; cv=none; b=AR4tkEBYhCQ0iaN33TuDO8eDB4G2aY6oRknTsMt7HheCm17+WxQg72lRTm5tp5SWLaFJaEjmSQ/3mi9Mn1YeaRx6H43LRhWv/NjXw6Z7NxhY+xrI6Q95ODD4j5ETwCa7wEsQCgMjXXuQVYG3J8wIHG+oK6l+PNQNWPbHAc9q0AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721045569; c=relaxed/simple;
	bh=WYjF6U6nibfk7u3cHUo6gwUQDC1Ss/Tcj2bYgTGZ2l4=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=q+/zZycaoWkiyHZx92i+/AeI1PSfVmL3p3A5LISF6Duc2gmmRQSOmuiDyM97gZcvxVbLMufEvAU3uxGMGf4S+fIYB8E47Qisfc4ruqUhTSOGdc+rsLj2OqTVx+0EdcUqjvAZdf357MrC3ZrPrE+Q393WFdl89sgLA4C9NJPjPAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXEEW3ex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B084BC32782;
	Mon, 15 Jul 2024 12:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721045568;
	bh=WYjF6U6nibfk7u3cHUo6gwUQDC1Ss/Tcj2bYgTGZ2l4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=gXEEW3exOJjCXclpGKoQYGG9opyBMzVA24PMJsQnTeml1rcJ1fVsWZ8UkBXdRlIJi
	 0oFnQ4q3FICDYfiT/nBv8KshYO7W/1A7oU5/h4m9VNp4v60U3oEtBs9eOnYF00PkNx
	 4x1ENkvnC0mwVZ2f856zAC92FDY3hMLyzuUsnTgylGgIuKfKpi6p2D2T2Xa62QeH6g
	 8y2YFBrdFGcvw+Wv6Q/Ta+uadx7cg+sVyZrWpHao8EkC8qCtt7g1O1QvlkLOMq0xoa
	 D3ACsA6zkhrPBcRV0jE/6uwu6t8F4t5gq08lkReU0UzMdkCttZ9MMMkU4L+IItHtdO
	 XzO/VsLMCTRlQ==
Date: Mon, 15 Jul 2024 06:12:47 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: linux-gpio@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Paolo Abeni <pabeni@redhat.com>, Andy Shevchenko <andy@kernel.org>, 
 linux-mtd@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>, 
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, netdev@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Vinod Koul <vkoul@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Olof Johansson <olof@lixom.net>, Niklas Cassel <cassel@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>, dmaengine@vger.kernel.org, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Russell King <linux@armlinux.org.uk>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Rob Herring <robh+dt@kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 "Wu, Aaron" <Aaron.Wu@analog.com>, Lee Jones <lee@kernel.org>, 
 linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Damien Le Moal <dlemoal@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, linux-pwm@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Ralf Baechle <ralf@linux-mips.org>, Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-ide@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-spi@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Mark Brown <broonie@kernel.org>, 
 Hartley Sweeten <hsweeten@visionengravers.com>, 
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, 
 Andrew Lunn <andrew@lunn.ch>, Richard Weinberger <richard@nod.at>, 
 Eric Dumazet <edumazet@google.com>, linux-sound@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, linux-input@vger.kernel.org, 
 Jaroslav Kysela <perex@perex.cz>, Sergey Shtylyov <s.shtylyov@omp.ru>, 
 Lukasz Majewski <lukma@denx.de>
In-Reply-To: <20240715-ep93xx-v11-0-4e924efda795@maquefel.me>
References: <20240715-ep93xx-v11-0-4e924efda795@maquefel.me>
Message-Id: <172104541245.3725513.13547524352291855487.robh@kernel.org>
Subject: Re: [PATCH v11 00/38] ep93xx device tree conversion


On Mon, 15 Jul 2024 11:38:04 +0300, Nikita Shubin wrote:
> The goal is to recieve ACKs for all patches in series to merge it via Arnd branch.
> 
> It was decided from the very beginning of these series, mostly because
> it's a full conversion of platform code to DT and it seemed not
> convenient to maintain compatibility with both platform and DT.
> 
> Following patches require attention from Stephen Boyd or clk subsystem:
> 
> - clk: ep93xx: add DT support for Cirrus EP93xx
> 
> It is purely possible to add something like devm_clk_hw_register_fixed_rate_parent_data()
> for devm managed version clk_hw_register_fixed_rate_parent_data(), still i would like to
> leave for the time after this series if it's all possible.
> 
> Couse may be it's better to add something like
> devm_clk_hw_register_fixed_rate_index() like it's done for
> devm_clk_hw_register_fixed_factor_index().
> 
> Changelog for this patch:
> - added devm_ep93xx_clk_hw_register_fixed_rate_parent_data() for
>   devm_ version of clk_hw_register_fixed_rate_parent_data()
> - s/devm_clk_hw_register_fixed_rate()/devm_ep93xx_clk_hw_register_fixed_rate_parent_data()/
> - replaced all devm_clk_hw_register_fixed_factor() to
>   devm_clk_hw_register_fixed_factor_parent_hw() or
>   devm_clk_hw_register_fixed_factor_index()
> - s/devm_clk_hw_register_gate()/devm_clk_hw_register_gate_parent_data()
> 
> Stephen - it think that's you was aiming for - to get rid of all
> functions that are using const char* parent_name directly instead of
> clk_hw or clk_parent_data.
> 
> Patches should be formated with '--histogram'
> 
> ---
> Changes in v11:
> - clk: ep93xx: add DT support for Cirrus EP93xx
>   - added devm_ep93xx_clk_hw_register_fixed_rate_parent_data() for
>     devm_ version of clk_hw_register_fixed_rate_parent_data()
>   - s/devm_clk_hw_register_fixed_rate()/devm_ep93xx_clk_hw_register_fixed_rate_parent_data()/
>   - replaced all devm_clk_hw_register_fixed_factor() to
>     devm_clk_hw_register_fixed_factor_parent_hw() or
>     devm_clk_hw_register_fixed_factor_index()
>   - s/devm_clk_hw_register_gate()/devm_clk_hw_register_gate_parent_data()
> 
> - Link to v10: https://lore.kernel.org/r/20240617-ep93xx-v10-0-662e640ed811@maquefel.me
> 
> Changes in v10:
> 
> Reordered SoB tags to make sure they appear before Rb and Acked tags.
> 
> dmaengine: cirrus: Convert to DT for Cirrus EP93xx
>     - s/dma/dmaengine/ title
> 
> dmaengine: cirrus: remove platform code
>     - s/dma/dmaengine/ title
> 
> soc: Add SoC driver for Cirrus ep93xx:
>     - added __init for ep93xx_adev_alloc(), ep93xx_controller_register()
>     - added static, __initconst for pinctrl_names[]
>     - clk revision for SPI is now resolved here through differently named
>       clk device
>     - more verbose Kconfig description
> 
> clk: ep93xx: add DT support for Cirrus EP93xx:
>     - dropped includes
>     - dropped ep93xx_soc_table[]
>     - add different named clk and dropped involved includes
>     - moved pll's and fclk, hclk, pclk init to separate function
>     - fixed ep93xx_clk_ids[] explicit lines
> 
> - Link to v9: https://lore.kernel.org/r/20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me
> - Link to v2 clk: https://lore.kernel.org/r/20240408-ep93xx-clk-v2-1-adcd68c13753@maquefel.me
> 
> Changes in v9:
> 
> ARM: dts: add Cirrus EP93XX SoC .dtsi
>     - added #interrupt-cells to gpio nodes with interrupts-controller
>     - fixed EOF
> 
> ARM: dts: ep93xx: Add EDB9302 DT
>     - Alexander Sverdlin: fixed bug in Device Tree resulting in CS4271 not working
> 
> input: keypad: ep93xx: add DT support for Cirrus EP93xx
>     - fixed identation and type
> 
> - Link to v8: https://lore.kernel.org/r/20240226-ep93xx-v8-0-3136dca7238f@maquefel.me/
> 
> Changes in v8:
> 
> soc: Add SoC driver for Cirrus ep93xx
>     - fixed freeing adev instead of rdev
>     - use __free() and no_free_ptr() for rdev allocation
>     - s/of_device_get_match_data()/device_get_match_data()/
> 
> ata: pata_ep93xx: add device tree support
>     - more appropriate usage of dev_err_probe()
> 
> pinctrl: add a Cirrus ep93xx SoC pin controller
>     - 8 per row in ide_9312_pins
> 
> mtd: rawnand: add support for ts72xx
>     - fwnode_handle_put() for fwnode in ts72xx_nand_remove()
> 
> - Link to v7: https://lore.kernel.org/r/20240118-ep93xx-v7-0-d953846ae771@maquefel.me
> 
> Changes in v7:
> 
> mtd: rawnand: add support for ts72xx
>     - fixed KConfig description
> 
> ARM: ep93xx: Add terminator to gpiod_lookup_table
>     - + Reported-by, Fixes
> 
> ARM: ep93xx: add regmap aux_dev
>     - + trailing comma
>     - - #include <linux/spinlock.h>
> 
> clk: ep93xx: add DT support for Cirrus EP93xx
>     - dropped unused defines
>     - return from default in ep93xx_mux_get_parent()
>     - use guard() in ep93xx_mux_set_parent_lock()
>     - <math.h> header for abs_diff()
>     - fixed comments
> 
> pinctrl: add a Cirrus ep93xx SoC pin controller
>     - dropped comments for DEVCFG defines
>     - <linux/array_size.h> for ARRAY_SIZE()
>     - + default in ep93xx_get_group_name()
>     - correct cast for id->driver_data
>     - s/device_set_of_node_from_dev()/device_set_node()/
> 
> power: reset: Add a driver for the ep93xx reset
>     - Add <linux/container_of.h>, <linux/errno.h>, <linux/slab.h>
>     - Add <linux/module.h>, <linux/mod_devicetable.h>
>     - Remove <platform_device.h>
> 
> spi: ep93xx: add DT support for Cirrus EP93xx
>     - Replace with ret = dev_err_probe(...);
> 
> ata: pata_ep93xx: add device tree support
>     - fixed wrong rebase with some partes leaked in "ata: pata_ep93xx: remove legacy pinctrl use"
>     - fix dma_request_chan() error processing
> 
> dma: cirrus: Convert to DT for Cirrus EP93xx
>     - fixed commit message (dropped explicit "only")
>     - fixed clk_get() processing to defer probe and log spamming
>     - refactor ep93xx_m2p_dma_filter()
>     - dropped blank line in ep93xx_m2p_dma_of_xlate()
>     - refactor ep93xx_m2m_dma_of_xlate()
> 
> dma: cirrus: remove platform code
>     - s/dma/DMA/ in commit message
> 
> soc: Add SoC driver for Cirrus ep93xx
>     - add period
>     - use cleanup and guard() for spinlocking
>     - correct cast for device_get_match_data()
>     - dropped dev_info() with SoC revision - i can't find it anywhere since 2.6 :/,
>       don't know why i was so sured that ep93xx always printed that
> 
> ata: pata_ep93xx: remove legacy pinctrl use
>     - made error handling in DMA as Uwe suggested
> 
> - Link to v6: https://lore.kernel.org/r/20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me
> 
> Changes in v6:
> 
> - clk: ep93xx: add DT support for Cirrus EP93xx
>   - s/spin_lock_irqsave()/guard()/
>   - refactor index check in ep93xx_mux_set_parent_lock() to something more readable
>   - use in_range in ep93xx_mux_set_parent_lock()/ep93xx_ddiv_set_rate()
>   - use GENMASK() in ep93xx_ddiv_recalc_rate()
>   - comment reserved bit in ep93xx_ddiv_set_rate()
>   - move out from loop ClkDiv value assigment
>   - some style fixes
> 
> Andy, i was i asked to set index of XTALI explicitly, i am not setting ddiv_pdata
> there becouse only XTALI is jnown in advance, and i think setting them in one place is more convenient.
> 
> - pinctrl: add a Cirrus ep93xx SoC pin controller
>   - drop OF from Kconfig
>   - droped linux/of.h include
>   - add space to */ where it is applicable
>   - add coma in multiline assigment
>   - "return NULL" as default case in ep93xx_get_group_name()
>   - fixed casting id->driver_data
>   - use device_set_of_node_from_dev()
>   - use dev_err_probe()
> 
> - power: reset: Add a driver for the ep93xx reset
>   - drop linux/of.h include
> 
> - soc: Add SoC driver for Cirrus ep93xx
>   - s/GPL-2.0/GPL-2.0-only/
>   - drop linux/kernel.h include
>   - + blank line before linux/soc/cirrus/ep93xx.h
>   - + blank line after ep93xx_get_soc_rev()
>   - + coma for pinctrl_names
>   - valid casting to int for of_device_get_match_data() return value
> 
> - mtd: rawnand: add support for ts72xx
>   - return as part of switch case
>   - s/iowrite8/iowrite8_rep/
> 
> - net: cirrus: add DT support for Cirrus EP93xx
>   - fix header sorting
> 
> - dma: cirrus: Convert to DT for Cirrus EP93xx
>   - use devm_clk_get
>   - use is_slave_direction
> 
> Changes in v5:
> 
> - gpio: ep93xx: split device in multiple
>   - ordered headers
>   - use irqd_to_hwirq()
>   - s/platform_get_irq()/platform_get_irq_optional()/
> 
> - [PATCH v4 02/42] ARM: ep93xx: add swlocked prototypes
>   - replaced with ARM: ep93xx: add regmap aux_dev
> 
> - [PATCH v4 03/42] dt-bindings: clock: Add Cirrus EP93xx
>   - fixed identation
>   - removed EP93XX_CLK_END
>   - and dropped it
>   - clock bindings moved to syscon with renaming to cirrus,ep9301-syscon.h
> 
> - clk: ep93xx: add DT support for Cirrus EP93xx
>   - convert to auxiliary and use parent device tree node
>   - moved all clocks except XTALI here
>   - used devm version everywhere and *_parent_hw() instead of passing name where it's possible
>   - unfortunately devm_clk_hw_register_fixed_rate doesn't have a parent index version
> 
> - [PATCH v4 05/42] dt-bindings: pinctrl: Add Cirrus EP93xx
>   - "unevaluatedProperties: false" for pins
>   - returned "additionalProperties: false" where it was
>   - and dropped it
> 
> - pinctrl: add a Cirrus ep93xx SoC pin controller
>   - sorted includes
>   - convert to auxiliary and use parent device tree node
> 
> - power: reset: Add a driver for the ep93xx reset
>   - convert to auxiliary device
> 
> - dt-bindings: soc: Add Cirrus EP93xx
>   - dropped all ref to reboot, clk, pinctrl subnodes
>   - added pins, as it's now used for pinctrl
>   - added #clock-cells, as it's now used for clk
> 
> - dt-bindings: pwm: Add Cirrus EP93xx
>   - $ref to pwm.yaml
>   - fixed 'pwm-cells'
>   - s/additionalProperties/unevaluatedProperties/
> 
> - soc: Add SoC driver for Cirrus ep93xx
>   - removed clocks, they are moved to clk auxiliary driver, as we dropped the clk dt node
>   - removed all swlocked exported functions
>   - dropped static spinlock
>   - added instantiating auxiliary reboot, clk, pinctrl
> 
> - dt-bindings: spi: Add Cirrus EP93xx
>   - Document DMA support
> 
> - spi: ep93xx: add DT support for Cirrus EP93xx
>   - dropped CONFIG_OF and SPI/DMA platform data entirely
>   - s/master/host/
>   - reworked DMA setup so we can use probe defer
> 
> - dt-bindings: dma: Add Cirrus EP93xx
>   - dropped bindings header (moved ports description to YAML)
>   - changed '#dma-cells' to 2, we use port, direction in cells so we can drop platform code completely
> 
> - dma: cirrus: add DT support for Cirrus EP93xx
>   - dropped platform probing completely
>   - dropped struct ep93xx_dma_data replaced with internal struct ep93xx_dma_chan_cfg with port/direction
>   - added xlate functions for m2m/m2p
>   - we require filters to set dma_cfg before hw_setup
> 
> - dt-bindings: ata: Add Cirrus EP93xx
>   - Document DMA support
> 
> - ata: pata_ep93xx: add device tree support
>   - drop DMA platform header with data
>   - use DMA OF so we can defer probing until DMA is up
> 
> - ARM: dts: add Cirrus EP93XX SoC .dtsi
> - ARM: dts: ep93xx: add ts7250 board
> - ARM: dts: ep93xx: Add EDB9302 DT
>   - replaced "eclk: clock-controller" to syscon reference
>   - replaced "pinctrl: pinctrl" to syscon reference
>   - gpios are now "enabled" by default
>   - reworked i2s node
>   - change all dma nodes and refs
> 
> - new additions to I2S
>   - Document DMA
>   - Document Audio Port usage
>   - drop legacy DMA support
> 
> - Link to v4: https://lore.kernel.org/r/20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me
> 
> Changes in v4:
> 
> - gpio: ep93xx: split device in multiple
>   - s/generic_handle_irq/generic_handle_domain_irq/
>   - s/int offset/irq_hw_number_t offset/ though now it looks a bit odd to me
>   - drop i = 0
>   - drop 'error'
>   - use dev_err_probe withour printing devname once again
> 
> dt-bindings: clock: Add Cirrus EP93xx
>   - renamed cirrus,ep93xx-clock.h -> cirrus,ep9301-clk.h
> 
> clk: ep93xx: add DT support for Cirrus EP93xx
>   - drop unused includes
>   - use .name only for xtali, pll1, pll2 parents
>   - convert // to /*
>   - pass clk_parent_data instead of char* clock name
> 
> dt-bindings: pinctrl: Add Cirrus EP93xx
>   - s/additionalProperties/unevaluatedProperties/
> 
> dt-bindings: soc: Add Cirrus EP93xx
>   - move syscon to soc directory
>   - add vendor prefix
>   - make reboot same style as pinctrl, clk
>   - use absolute path for ref
>   - expand example
> 
> soc: Add SoC driver for Cirrus ep93xx
>   - s/0xf0000000/GENMASK(31, 28)/
>   - s/ret/ep93xx_chip_revision(map)/
>   - drop symbol exports
>   - convert to platform driver
> 
> dt-bindings: rtc: Add Cirrus EP93xx
>   - allOf: with $ref to rtc.yaml
>   - s/additionalProperties/unevaluatedProperties/
> 
> dt-bindings: watchdog: Add Cirrus EP93x
>   - drop description
>   - reword
> 
> power: reset: Add a driver for the ep93xx reset
>   - lets use 'GPL-2.0+' instead of '(GPL-2.0)'
>   - s/of_device/of/
>   - drop mdelay with warning
>   - return 0 at the end
> 
> net: cirrus: add DT support for Cirrus EP93xx
>   - fix leaking np
> 
> mtd: nand: add support for ts72xx
>   - +bits.h
>   - drop comment
>   - ok to fwnode_get_next_child_node
>   - use goto to put handle and nand and report error
> 
> ARM: dts: add Cirrus EP93XX SoC .dtsi
>   - add simple-bus for ebi, as we don't require to setup anything
>   - add arm,pl011 compatible to uart nodes
>   - drop i2c-gpio, as it's isn't used anywhere
> 
> ARM: dts: ep93xx: add ts7250 board
>   - generic node name for temperature-sensor
>   - drop i2c
>   - move nand, rtc, watchdog to ebi node
> 
> - Link to v3: https://lore.kernel.org/r/20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me
> 
> ---
> Alexander Sverdlin (3):
>       ASoC: ep93xx: Drop legacy DMA support
>       ARM: dts: ep93xx: Add EDB9302 DT
>       ASoC: cirrus: edb93xx: Delete driver
> 
> Nikita Shubin (35):
>       gpio: ep93xx: split device in multiple
>       ARM: ep93xx: add regmap aux_dev
>       clk: ep93xx: add DT support for Cirrus EP93xx
>       pinctrl: add a Cirrus ep93xx SoC pin controller
>       power: reset: Add a driver for the ep93xx reset
>       dt-bindings: soc: Add Cirrus EP93xx
>       soc: Add SoC driver for Cirrus ep93xx
>       dt-bindings: dma: Add Cirrus EP93xx
>       dmaengine: cirrus: Convert to DT for Cirrus EP93xx
>       dt-bindings: watchdog: Add Cirrus EP93x
>       watchdog: ep93xx: add DT support for Cirrus EP93xx
>       dt-bindings: pwm: Add Cirrus EP93xx
>       pwm: ep93xx: add DT support for Cirrus EP93xx
>       dt-bindings: spi: Add Cirrus EP93xx
>       spi: ep93xx: add DT support for Cirrus EP93xx
>       dt-bindings: net: Add Cirrus EP93xx
>       net: cirrus: add DT support for Cirrus EP93xx
>       dt-bindings: mtd: Add ts7200 nand-controller
>       mtd: rawnand: add support for ts72xx
>       dt-bindings: ata: Add Cirrus EP93xx
>       ata: pata_ep93xx: add device tree support
>       dt-bindings: input: Add Cirrus EP93xx keypad
>       input: keypad: ep93xx: add DT support for Cirrus EP93xx
>       wdt: ts72xx: add DT support for ts72xx
>       gpio: ep93xx: add DT support for gpio-ep93xx
>       ASoC: dt-bindings: ep93xx: Document DMA support
>       ASoC: dt-bindings: ep93xx: Document Audio Port support
>       ARM: dts: add Cirrus EP93XX SoC .dtsi
>       ARM: dts: ep93xx: add ts7250 board
>       ARM: ep93xx: DT for the Cirrus ep93xx SoC platforms
>       pwm: ep93xx: drop legacy pinctrl
>       ata: pata_ep93xx: remove legacy pinctrl use
>       ARM: ep93xx: delete all boardfiles
>       ARM: ep93xx: soc: drop defines
>       dmaengine: cirrus: remove platform code
> 
>  .../bindings/arm/cirrus/cirrus,ep9301.yaml         |   38 +
>  .../bindings/ata/cirrus,ep9312-pata.yaml           |   42 +
>  .../bindings/dma/cirrus,ep9301-dma-m2m.yaml        |   84 ++
>  .../bindings/dma/cirrus,ep9301-dma-m2p.yaml        |  144 ++
>  .../bindings/input/cirrus,ep9307-keypad.yaml       |   87 ++
>  .../devicetree/bindings/mtd/technologic,nand.yaml  |   45 +
>  .../devicetree/bindings/net/cirrus,ep9301-eth.yaml |   59 +
>  .../devicetree/bindings/pwm/cirrus,ep9301-pwm.yaml |   53 +
>  .../bindings/soc/cirrus/cirrus,ep9301-syscon.yaml  |   94 ++
>  .../bindings/sound/cirrus,ep9301-i2s.yaml          |   16 +
>  .../devicetree/bindings/spi/cirrus,ep9301-spi.yaml |   70 +
>  .../bindings/watchdog/cirrus,ep9301-wdt.yaml       |   42 +
>  arch/arm/Makefile                                  |    1 -
>  arch/arm/boot/dts/cirrus/Makefile                  |    4 +
>  arch/arm/boot/dts/cirrus/ep93xx-bk3.dts            |  125 ++
>  arch/arm/boot/dts/cirrus/ep93xx-edb9302.dts        |  181 +++
>  arch/arm/boot/dts/cirrus/ep93xx-ts7250.dts         |  145 ++
>  arch/arm/boot/dts/cirrus/ep93xx.dtsi               |  444 ++++++
>  arch/arm/mach-ep93xx/Kconfig                       |   20 +-
>  arch/arm/mach-ep93xx/Makefile                      |   11 -
>  arch/arm/mach-ep93xx/clock.c                       |  733 ----------
>  arch/arm/mach-ep93xx/core.c                        | 1018 --------------
>  arch/arm/mach-ep93xx/dma.c                         |  114 --
>  arch/arm/mach-ep93xx/edb93xx.c                     |  368 -----
>  arch/arm/mach-ep93xx/ep93xx-regs.h                 |   38 -
>  arch/arm/mach-ep93xx/gpio-ep93xx.h                 |  111 --
>  arch/arm/mach-ep93xx/hardware.h                    |   25 -
>  arch/arm/mach-ep93xx/irqs.h                        |   76 --
>  arch/arm/mach-ep93xx/platform.h                    |   42 -
>  arch/arm/mach-ep93xx/soc.h                         |  212 ---
>  arch/arm/mach-ep93xx/timer-ep93xx.c                |  143 --
>  arch/arm/mach-ep93xx/ts72xx.c                      |  422 ------
>  arch/arm/mach-ep93xx/ts72xx.h                      |   94 --
>  arch/arm/mach-ep93xx/vision_ep9307.c               |  321 -----
>  drivers/ata/pata_ep93xx.c                          |  107 +-
>  drivers/clk/Kconfig                                |    8 +
>  drivers/clk/Makefile                               |    1 +
>  drivers/clk/clk-ep93xx.c                           |  846 ++++++++++++
>  drivers/dma/ep93xx_dma.c                           |  287 +++-
>  drivers/gpio/gpio-ep93xx.c                         |  345 ++---
>  drivers/input/keyboard/ep93xx_keypad.c             |   74 +-
>  drivers/mtd/nand/raw/Kconfig                       |    6 +
>  drivers/mtd/nand/raw/Makefile                      |    1 +
>  drivers/mtd/nand/raw/technologic-nand-controller.c |  222 +++
>  drivers/net/ethernet/cirrus/ep93xx_eth.c           |   63 +-
>  drivers/pinctrl/Kconfig                            |    7 +
>  drivers/pinctrl/Makefile                           |    1 +
>  drivers/pinctrl/pinctrl-ep93xx.c                   | 1434 ++++++++++++++++++++
>  drivers/power/reset/Kconfig                        |   10 +
>  drivers/power/reset/Makefile                       |    1 +
>  drivers/power/reset/ep93xx-restart.c               |   84 ++
>  drivers/pwm/pwm-ep93xx.c                           |   26 +-
>  drivers/soc/Kconfig                                |    1 +
>  drivers/soc/Makefile                               |    1 +
>  drivers/soc/cirrus/Kconfig                         |   17 +
>  drivers/soc/cirrus/Makefile                        |    2 +
>  drivers/soc/cirrus/soc-ep93xx.c                    |  252 ++++
>  drivers/spi/spi-ep93xx.c                           |   66 +-
>  drivers/watchdog/ep93xx_wdt.c                      |    8 +
>  drivers/watchdog/ts72xx_wdt.c                      |    8 +
>  include/dt-bindings/clock/cirrus,ep9301-syscon.h   |   46 +
>  include/linux/platform_data/dma-ep93xx.h           |   94 --
>  include/linux/platform_data/eth-ep93xx.h           |   10 -
>  include/linux/platform_data/keypad-ep93xx.h        |   32 -
>  include/linux/platform_data/spi-ep93xx.h           |   15 -
>  include/linux/soc/cirrus/ep93xx.h                  |   47 +-
>  sound/soc/cirrus/Kconfig                           |    9 -
>  sound/soc/cirrus/Makefile                          |    4 -
>  sound/soc/cirrus/edb93xx.c                         |  116 --
>  sound/soc/cirrus/ep93xx-i2s.c                      |   19 -
>  sound/soc/cirrus/ep93xx-pcm.c                      |   19 +-
>  71 files changed, 5161 insertions(+), 4550 deletions(-)
> ---
> base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
> change-id: 20230605-ep93xx-01c76317e2d2
> 
> Best regards,
> --
> Nikita Shubin <nikita.shubin@maquefel.me>
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y cirrus/ep93xx-bk3.dtb cirrus/ep93xx-edb9302.dtb cirrus/ep93xx-ts7250.dtb' for 20240715-ep93xx-v11-0-4e924efda795@maquefel.me:

arch/arm/boot/dts/cirrus/ep93xx-edb9302.dtb: /soc/spi@808a0000/codec@0: failed to match any schema with compatible: ['cirrus,cs4271']






