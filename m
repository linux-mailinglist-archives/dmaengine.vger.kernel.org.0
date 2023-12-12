Return-Path: <dmaengine+bounces-477-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C20B880E5BE
	for <lists+dmaengine@lfdr.de>; Tue, 12 Dec 2023 09:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A591F21888
	for <lists+dmaengine@lfdr.de>; Tue, 12 Dec 2023 08:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81412199B3;
	Tue, 12 Dec 2023 08:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fblb9imS"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CCB182BF;
	Tue, 12 Dec 2023 08:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 991DDC433C7;
	Tue, 12 Dec 2023 08:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702369324;
	bh=S88d1ebtqGg4xz5WnYtvxaH0uGbhNBOGhgdRNivQD0c=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Fblb9imSxCN01/ZExaIf6hSCDT0vAbnMA8VJg5a/VtFygHUag1wqW59TnAmH19VaP
	 jmIn/3bD78ID9ljmbvm2BazcsTJFhbLVXbbDs82BUZd1BktupI3MMtg0Pn3XjK/qkI
	 IiMYolua8jBtesy9o6znrAdPeJBTbVmwsMYvYM17cPtPXH2EfG3ZtGAAA+QSKPk4M1
	 2tmp2Tb6QySAOd0YHsCGNJZz4MZFEwnjjnrlPUNZpgPL4wU7g8hdqGBfrFsWT0S+B4
	 NpX3oDdz3MJZfJDeqAAv8tU0O2jpPvyV8NDwxQ/+czjVWwQTXDQFbsDEr2qepxbpYZ
	 bjL2JDgXAxxsg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CF4C4332F;
	Tue, 12 Dec 2023 08:22:04 +0000 (UTC)
From:
 Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Subject: [PATCH v6 00/40] ep93xx device tree conversion
Date: Tue, 12 Dec 2023 11:20:17 +0300
Message-Id: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMEXeGUC/2WOQW6DMBBFrxJ5XSPPDLZLV71H1YXBQ7FaTGoTR
 BVx95osgqIsv+a/N/8qMqfAWbydriLxEnKYYgnm5SS6wcUvlsGXLFAhKaO05HND6yoVdNYQWEa
 PopRbl1m2ycVu2OujyzOn/XBO3If19uHjs+Q+TaOch8Tu8NZYA5JGrOCVFEqQMXyH2VV5uLQhv
 o/u98I9/1Qj78oh5HlKf7fNC+3ip3kLSSXJG3K6B1DED459x1IfYAMHWBfQgbe28R13oJ5BfQc
 BEO+gLqDXjbPGa99j8whu2/YPK2/242wBAAA=
To: Hartley Sweeten <hsweeten@visionengravers.com>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Lukasz Majewski <lukma@denx.de>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nikita Shubin <nikita.shubin@maquefel.me>, Vinod Koul <vkoul@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Mark Brown <broonie@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Damien Le Moal <dlemoal@kernel.org>, Sergey Shtylyov <s.shtylyov@omp.ru>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org, 
 netdev@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-ide@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-sound@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Andrew Lunn <andrew@lunn.ch>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702369322; l=14444;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=S88d1ebtqGg4xz5WnYtvxaH0uGbhNBOGhgdRNivQD0c=; =?utf-8?q?b=3D+xp65JGOWQTf?=
 =?utf-8?q?Fz1ftk6zScJiUl0daUmI7W6bV36hejIPsX8O1zuAcDFKF2/bFdVDWEYKVY4phEoF?=
 7Hw2RcrxBQwiiCCiLLCHiB+u0Y6Oxml3ttezMDv3QRSfizy57WRK
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received:
 by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>

No major changes since last version all changes are cometic.

Following patches require attention from Stephen Boyd, as they were converted to aux_dev as suggested:

- ARM: ep93xx: add regmap aux_dev
- clk: ep93xx: add DT support for Cirrus EP93xx

DMA related patches still require Acked or Reviewed tags.

got approval LGTM from Miquel:
- mtd: rawnand: add support for ts72xx
Link: https://lore.kernel.org/lkml/20231004103911.2aa65354@xps-13/

new patches:

ARM: ep93xx:  Add terminator to gpiod_lookup_table
  - fixed terminator in gpiod_lockup_table

So mostly all patches got approval.

Patches should be now formated with '--histogram'

---
Changes in v6:

- clk: ep93xx: add DT support for Cirrus EP93xx
  - s/spin_lock_irqsave()/guard()/
  - refactor index check in ep93xx_mux_set_parent_lock() to something more readable
  - use in_range in ep93xx_mux_set_parent_lock()/ep93xx_ddiv_set_rate()
  - use GENMASK() in ep93xx_ddiv_recalc_rate()
  - comment reserved bit in ep93xx_ddiv_set_rate()
  - move out from loop ClkDiv value assigment
  - some style fixes

Andy, i was i asked to set index of XTALI explicitly, i am not setting ddiv_pdata 
there becouse only XTALI is jnown in advance, and i think setting them in one place is more convenient.

- pinctrl: add a Cirrus ep93xx SoC pin controller
  - drop OF from Kconfig
  - droped linux/of.h include
  - add space to */ where it is applicable
  - add coma in multiline assigment
  - "return NULL" as default case in ep93xx_get_group_name()
  - fixed casting id->driver_data
  - use device_set_of_node_from_dev()
  - use dev_err_probe()

- power: reset: Add a driver for the ep93xx reset
  - drop linux/of.h include

- soc: Add SoC driver for Cirrus ep93xx
  - s/GPL-2.0/GPL-2.0-only/
  - drop linux/kernel.h include
  - + blank line before linux/soc/cirrus/ep93xx.h
  - + blank line after ep93xx_get_soc_rev()
  - + coma for pinctrl_names
  - valid casting to int for of_device_get_match_data() return value

- mtd: rawnand: add support for ts72xx
  - return as part of switch case
  - s/iowrite8/iowrite8_rep/

- net: cirrus: add DT support for Cirrus EP93xx
  - fix header sorting

- dma: cirrus: Convert to DT for Cirrus EP93xx
  - use devm_clk_get
  - use is_slave_direction

Changes in v5:

- gpio: ep93xx: split device in multiple
  - ordered headers
  - use irqd_to_hwirq()
  - s/platform_get_irq()/platform_get_irq_optional()/
 
- [PATCH v4 02/42] ARM: ep93xx: add swlocked prototypes
  - replaced with ARM: ep93xx: add regmap aux_dev

- [PATCH v4 03/42] dt-bindings: clock: Add Cirrus EP93xx
  - fixed identation
  - removed EP93XX_CLK_END
  - and dropped it
  - clock bindings moved to syscon with renaming to cirrus,ep9301-syscon.h

- clk: ep93xx: add DT support for Cirrus EP93xx
  - convert to auxiliary and use parent device tree node
  - moved all clocks except XTALI here
  - used devm version everywhere and *_parent_hw() instead of passing name where it's possible
  - unfortunately devm_clk_hw_register_fixed_rate doesn't have a parent index version

- [PATCH v4 05/42] dt-bindings: pinctrl: Add Cirrus EP93xx
  - "unevaluatedProperties: false" for pins
  - returned "additionalProperties: false" where it was
  - and dropped it

- pinctrl: add a Cirrus ep93xx SoC pin controller
  - sorted includes
  - convert to auxiliary and use parent device tree node

- power: reset: Add a driver for the ep93xx reset
  - convert to auxiliary device

- dt-bindings: soc: Add Cirrus EP93xx
  - dropped all ref to reboot, clk, pinctrl subnodes
  - added pins, as it's now used for pinctrl
  - added #clock-cells, as it's now used for clk

- dt-bindings: pwm: Add Cirrus EP93xx
  - $ref to pwm.yaml
  - fixed 'pwm-cells'
  - s/additionalProperties/unevaluatedProperties/

- soc: Add SoC driver for Cirrus ep93xx
  - removed clocks, they are moved to clk auxiliary driver, as we dropped the clk dt node
  - removed all swlocked exported functions
  - dropped static spinlock
  - added instantiating auxiliary reboot, clk, pinctrl

- dt-bindings: spi: Add Cirrus EP93xx
  - Document DMA support

- spi: ep93xx: add DT support for Cirrus EP93xx
  - dropped CONFIG_OF and SPI/DMA platform data entirely
  - s/master/host/
  - reworked DMA setup so we can use probe defer

- dt-bindings: dma: Add Cirrus EP93xx
  - dropped bindings header (moved ports description to YAML)
  - changed '#dma-cells' to 2, we use port, direction in cells so we can drop platform code completely

- dma: cirrus: add DT support for Cirrus EP93xx
  - dropped platform probing completely
  - dropped struct ep93xx_dma_data replaced with internal struct ep93xx_dma_chan_cfg with port/direction
  - added xlate functions for m2m/m2p
  - we require filters to set dma_cfg before hw_setup

- dt-bindings: ata: Add Cirrus EP93xx
  - Document DMA support 

- ata: pata_ep93xx: add device tree support
  - drop DMA platform header with data
  - use DMA OF so we can defer probing until DMA is up

- ARM: dts: add Cirrus EP93XX SoC .dtsi
- ARM: dts: ep93xx: add ts7250 board
- ARM: dts: ep93xx: Add EDB9302 DT
  - replaced "eclk: clock-controller" to syscon reference
  - replaced "pinctrl: pinctrl" to syscon reference
  - gpios are now "enabled" by default
  - reworked i2s node
  - change all dma nodes and refs

- new additions to I2S
  - Document DMA
  - Document Audio Port usage
  - drop legacy DMA support

- Link to v4: https://lore.kernel.org/r/20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me

Changes in v4:

- gpio: ep93xx: split device in multiple
  - s/generic_handle_irq/generic_handle_domain_irq/
  - s/int offset/irq_hw_number_t offset/ though now it looks a bit odd to me
  - drop i = 0
  - drop 'error'
  - use dev_err_probe withour printing devname once again

dt-bindings: clock: Add Cirrus EP93xx
  - renamed cirrus,ep93xx-clock.h -> cirrus,ep9301-clk.h

clk: ep93xx: add DT support for Cirrus EP93xx
  - drop unused includes
  - use .name only for xtali, pll1, pll2 parents
  - convert // to /*
  - pass clk_parent_data instead of char* clock name

dt-bindings: pinctrl: Add Cirrus EP93xx
  - s/additionalProperties/unevaluatedProperties/

dt-bindings: soc: Add Cirrus EP93xx
  - move syscon to soc directory
  - add vendor prefix
  - make reboot same style as pinctrl, clk
  - use absolute path for ref
  - expand example

soc: Add SoC driver for Cirrus ep93xx
  - s/0xf0000000/GENMASK(31, 28)/
  - s/ret/ep93xx_chip_revision(map)/
  - drop symbol exports
  - convert to platform driver

dt-bindings: rtc: Add Cirrus EP93xx
  - allOf: with $ref to rtc.yaml
  - s/additionalProperties/unevaluatedProperties/

dt-bindings: watchdog: Add Cirrus EP93x
  - drop description
  - reword

power: reset: Add a driver for the ep93xx reset
  - lets use 'GPL-2.0+' instead of '(GPL-2.0)'
  - s/of_device/of/
  - drop mdelay with warning
  - return 0 at the end

net: cirrus: add DT support for Cirrus EP93xx
  - fix leaking np

mtd: nand: add support for ts72xx
  - +bits.h
  - drop comment
  - ok to fwnode_get_next_child_node
  - use goto to put handle and nand and report error

ARM: dts: add Cirrus EP93XX SoC .dtsi
  - add simple-bus for ebi, as we don't require to setup anything
  - add arm,pl011 compatible to uart nodes
  - drop i2c-gpio, as it's isn't used anywhere

ARM: dts: ep93xx: add ts7250 board
  - generic node name for temperature-sensor
  - drop i2c
  - move nand, rtc, watchdog to ebi node
 
- Link to v3: https://lore.kernel.org/r/20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me

---
Alexander Sverdlin (3):
      ASoC: ep93xx: Drop legacy DMA support
      ARM: dts: ep93xx: Add EDB9302 DT
      ASoC: cirrus: edb93xx: Delete driver

Nikita Shubin (37):
      ARM: ep93xx:  Add terminator to gpiod_lookup_table
      gpio: ep93xx: split device in multiple
      ARM: ep93xx: add regmap aux_dev
      clk: ep93xx: add DT support for Cirrus EP93xx
      pinctrl: add a Cirrus ep93xx SoC pin controller
      power: reset: Add a driver for the ep93xx reset
      dt-bindings: soc: Add Cirrus EP93xx
      soc: Add SoC driver for Cirrus ep93xx
      dt-bindings: dma: Add Cirrus EP93xx
      dma: cirrus: Convert to DT for Cirrus EP93xx
      dt-bindings: watchdog: Add Cirrus EP93x
      watchdog: ep93xx: add DT support for Cirrus EP93xx
      dt-bindings: pwm: Add Cirrus EP93xx
      pwm: ep93xx: add DT support for Cirrus EP93xx
      dt-bindings: spi: Add Cirrus EP93xx
      spi: ep93xx: add DT support for Cirrus EP93xx
      dt-bindings: net: Add Cirrus EP93xx
      net: cirrus: add DT support for Cirrus EP93xx
      dt-bindings: mtd: Add ts7200 nand-controller
      mtd: rawnand: add support for ts72xx
      dt-bindings: ata: Add Cirrus EP93xx
      ata: pata_ep93xx: add device tree support
      dt-bindings: input: Add Cirrus EP93xx keypad
      input: keypad: ep93xx: add DT support for Cirrus EP93xx
      dt-bindings: wdt: Add ts72xx
      wdt: ts72xx: add DT support for ts72xx
      gpio: ep93xx: add DT support for gpio-ep93xx
      ASoC: dt-bindings: ep93xx: Document DMA support
      ASoC: dt-bindings: ep93xx: Document Audio Port support
      ARM: dts: add Cirrus EP93XX SoC .dtsi
      ARM: dts: ep93xx: add ts7250 board
      ARM: ep93xx: DT for the Cirrus ep93xx SoC platforms
      pwm: ep93xx: drop legacy pinctrl
      ata: pata_ep93xx: remove legacy pinctrl use
      ARM: ep93xx: delete all boardfiles
      ARM: ep93xx: soc: drop defines
      dma: cirrus: remove platform code

 .../bindings/arm/cirrus/cirrus,ep9301.yaml         |   38 +
 .../bindings/ata/cirrus,ep9312-pata.yaml           |   42 +
 .../bindings/dma/cirrus,ep9301-dma-m2m.yaml        |   84 ++
 .../bindings/dma/cirrus,ep9301-dma-m2p.yaml        |  144 ++
 .../bindings/input/cirrus,ep9307-keypad.yaml       |   87 ++
 .../devicetree/bindings/mtd/technologic,nand.yaml  |   45 +
 .../devicetree/bindings/net/cirrus,ep9301-eth.yaml |   59 +
 .../devicetree/bindings/pwm/cirrus,ep9301-pwm.yaml |   53 +
 .../bindings/soc/cirrus/cirrus,ep9301-syscon.yaml  |   94 ++
 .../bindings/sound/cirrus,ep9301-i2s.yaml          |   16 +
 .../devicetree/bindings/spi/cirrus,ep9301-spi.yaml |   70 +
 .../bindings/watchdog/cirrus,ep9301-wdt.yaml       |   42 +
 .../bindings/watchdog/technologic,ts7200-wdt.yaml  |   45 +
 arch/arm/Makefile                                  |    1 -
 arch/arm/boot/dts/cirrus/Makefile                  |    4 +
 arch/arm/boot/dts/cirrus/ep93xx-bk3.dts            |  126 ++
 arch/arm/boot/dts/cirrus/ep93xx-edb9302.dts        |  182 +++
 arch/arm/boot/dts/cirrus/ep93xx-ts7250.dts         |  145 ++
 arch/arm/boot/dts/cirrus/ep93xx.dtsi               |  441 ++++++
 arch/arm/mach-ep93xx/Kconfig                       |   20 +-
 arch/arm/mach-ep93xx/Makefile                      |   11 -
 arch/arm/mach-ep93xx/clock.c                       |  733 ----------
 arch/arm/mach-ep93xx/core.c                        | 1017 --------------
 arch/arm/mach-ep93xx/dma.c                         |  114 --
 arch/arm/mach-ep93xx/edb93xx.c                     |  344 -----
 arch/arm/mach-ep93xx/ep93xx-regs.h                 |   38 -
 arch/arm/mach-ep93xx/gpio-ep93xx.h                 |  111 --
 arch/arm/mach-ep93xx/hardware.h                    |   25 -
 arch/arm/mach-ep93xx/irqs.h                        |   76 --
 arch/arm/mach-ep93xx/platform.h                    |   42 -
 arch/arm/mach-ep93xx/soc.h                         |  212 ---
 arch/arm/mach-ep93xx/timer-ep93xx.c                |  143 --
 arch/arm/mach-ep93xx/ts72xx.c                      |  422 ------
 arch/arm/mach-ep93xx/ts72xx.h                      |   94 --
 arch/arm/mach-ep93xx/vision_ep9307.c               |  311 -----
 drivers/ata/pata_ep93xx.c                          |  106 +-
 drivers/clk/Kconfig                                |    8 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-ep93xx.c                           |  849 ++++++++++++
 drivers/dma/ep93xx_dma.c                           |  286 +++-
 drivers/gpio/gpio-ep93xx.c                         |  345 ++---
 drivers/input/keyboard/ep93xx_keypad.c             |   74 +-
 drivers/mtd/nand/raw/Kconfig                       |    7 +
 drivers/mtd/nand/raw/Makefile                      |    1 +
 drivers/mtd/nand/raw/technologic-nand-controller.c |  220 +++
 drivers/net/ethernet/cirrus/ep93xx_eth.c           |   63 +-
 drivers/pinctrl/Kconfig                            |    7 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinctrl-ep93xx.c                   | 1430 ++++++++++++++++++++
 drivers/power/reset/Kconfig                        |   10 +
 drivers/power/reset/Makefile                       |    1 +
 drivers/power/reset/ep93xx-restart.c               |   80 ++
 drivers/pwm/pwm-ep93xx.c                           |   26 +-
 drivers/soc/Kconfig                                |    1 +
 drivers/soc/Makefile                               |    1 +
 drivers/soc/cirrus/Kconfig                         |   13 +
 drivers/soc/cirrus/Makefile                        |    2 +
 drivers/soc/cirrus/soc-ep93xx.c                    |  247 ++++
 drivers/spi/spi-ep93xx.c                           |   68 +-
 drivers/watchdog/ep93xx_wdt.c                      |    8 +
 drivers/watchdog/ts72xx_wdt.c                      |    8 +
 include/dt-bindings/clock/cirrus,ep9301-syscon.h   |   46 +
 include/linux/platform_data/dma-ep93xx.h           |   94 --
 include/linux/platform_data/eth-ep93xx.h           |   10 -
 include/linux/platform_data/keypad-ep93xx.h        |   32 -
 include/linux/platform_data/spi-ep93xx.h           |   15 -
 include/linux/soc/cirrus/ep93xx.h                  |   47 +-
 sound/soc/cirrus/Kconfig                           |    9 -
 sound/soc/cirrus/Makefile                          |    4 -
 sound/soc/cirrus/edb93xx.c                         |  117 --
 sound/soc/cirrus/ep93xx-i2s.c                      |   19 -
 sound/soc/cirrus/ep93xx-pcm.c                      |   19 +-
 72 files changed, 5192 insertions(+), 4514 deletions(-)
---
base-commit: 26aff849438cebcd05f1a647390c4aa700d5c0f1
change-id: 20230605-ep93xx-01c76317e2d2

Best regards,
-- 
Nikita Shubin <nikita.shubin@maquefel.me>


