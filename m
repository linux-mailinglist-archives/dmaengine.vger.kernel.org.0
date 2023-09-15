Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152C77A1812
	for <lists+dmaengine@lfdr.de>; Fri, 15 Sep 2023 10:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbjIOIMP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 Sep 2023 04:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjIOIMO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 15 Sep 2023 04:12:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CED52710;
        Fri, 15 Sep 2023 01:12:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED4DEC433C9;
        Fri, 15 Sep 2023 08:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694765528;
        bh=agloKg28g9/YDRsW6JpbMHgCzMLCcZvfA0DO3+uFT6U=;
        h=From:Subject:Date:To:Cc:Reply-To:From;
        b=biImRSYA1Gz9ex5hNnBvsCHN9Ke70AUTaJ/1oXos0Jp7PNytynhYDldZqmwGGwqIG
         wBDKtPE0OTqUI1L63BvWt/+LCgVBbLdZCfr41q3wmoGf4wSW/aJrIfFwombizAcdZg
         qvSoZF/En9YlofX7qoeahgKwyA5XkjPRaozJcx0YgybsjABHPXaJjBTEuBtzK8LPQW
         jobWx6+oa9+BDtivYaoAnYXnxx8o2rsLE386o7+u+Um3TgcOPHoXDeCO9Jw/08P+7h
         vQQ0+r6aW6E3rdL67GLQm+1B22ApzP0EDxkQv5g6EBJoCtur/p98vje3l/BQ6kXwd+
         Ok5Q7hby1Jxgw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id C23FEEE6436;
        Fri, 15 Sep 2023 08:12:07 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Subject: [PATCH v4 00/42] ep93xx device tree conversion
Date:   Fri, 15 Sep 2023 11:10:42 +0300
Message-Id: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIMRBGUC/2WOzQ6CMBCEX8X07JJ2lx/15HsYDwUWu1GKtkgwh
 ncXuBjj8ctMvpm3ihyEozps3irwIFE6P0O63ajKWX9hkHpmhRpJ5zoDvu9pHEGbqsjJFIw1qrl
 c2shQBusrt9RbG3sOS3AP3Mi4LpzOMzeha6F3ge3Xm2JqkDLExOxIIxjwcpXeJtE9S/HH1j6e3
 PAtaXlROol9F17r54EW8d+9gUAD1TnZrDFGE/84ztM0fQBYHN69+gAAAA==
To:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Lukasz Majewski <lukma@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Sebastian Reichel <sre@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
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
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
        netdev@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-input@vger.kernel.org, alsa-devel@alsa-project.org,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694765525; l=10008;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=agloKg28g9/YDRsW6JpbMHgCzMLCcZvfA0DO3+uFT6U=; =?utf-8?q?b=3DlFhzja5WXyxz?=
 =?utf-8?q?/PLTphurB/M7+sirpyh84veoDhmItUYEygTnM2rKc8vgA4hyFJjn2QEJembynYrr?=
 my3ZXC3QCmFL6iSycW9kRWpVdxebuBU00lnoSjSyA95RpVxeZd1i
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This series aims to convert ep93xx from platform to full device tree support.

The main goal is to receive ACK's to take it via Arnd's arm-soc branch.

Major changes:
- drop newline at the end from each YAML files
- rename dma and clk bindings headers to match first compatible
- shrink SoC exported functions number to only 2
- dropped some ep93xx_pata fixes from these series
- dropped m48t86 stuff from these series

Bit thanks to Andy Shevchenko for thorough review.

Some parts are were sent in advance, so these series depends on the
following:

Link: https://lore.kernel.org/all/20230823-m48t86_device_tree-v2-0-21ff275f949d@maquefel.me/
Link: https://lore.kernel.org/all/20230823-ep93xx_pata_fixes-v1-0-d7e7229be148@maquefel.me/

---
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
Alexander Sverdlin (2):
      ARM: dts: ep93xx: Add EDB9302 DT
      ASoC: cirrus: edb93xx: Delete driver

Nikita Shubin (40):
      gpio: ep93xx: split device in multiple
      ARM: ep93xx: add swlocked prototypes
      dt-bindings: clock: Add Cirrus EP93xx
      clk: ep93xx: add DT support for Cirrus EP93xx
      dt-bindings: pinctrl: Add Cirrus EP93xx
      pinctrl: add a Cirrus ep93xx SoC pin controller
      dt-bindings: power: reset: Add ep93xx reset
      power: reset: Add a driver for the ep93xx reset
      dt-bindings: soc: Add Cirrus EP93xx
      soc: Add SoC driver for Cirrus ep93xx
      dt-bindings: timers: Add Cirrus EP93xx
      clocksource: ep93xx: Add driver for Cirrus Logic EP93xx
      dt-bindings: rtc: Add Cirrus EP93xx
      rtc: ep93xx: add DT support for Cirrus EP93xx
      dt-bindings: watchdog: Add Cirrus EP93x
      watchdog: ep93xx: add DT support for Cirrus EP93xx
      dt-bindings: pwm: Add Cirrus EP93xx
      pwm: ep93xx: add DT support for Cirrus EP93xx
      dt-bindings: spi: Add Cirrus EP93xx
      spi: ep93xx: add DT support for Cirrus EP93xx
      dt-bindings: net: Add Cirrus EP93xx
      net: cirrus: add DT support for Cirrus EP93xx
      dt-bindings: dma: Add Cirrus EP93xx
      dma: cirrus: add DT support for Cirrus EP93xx
      dt-bindings: mtd: Add ts7200 nand-controller
      mtd: nand: add support for ts72xx
      dt-bindings: ata: Add Cirrus EP93xx
      ata: pata_ep93xx: add device tree support
      dt-bindings: input: Add Cirrus EP93xx keypad
      input: keypad: ep93xx: add DT support for Cirrus EP93xx
      dt-bindings: wdt: Add ts72xx
      wdt: ts72xx: add DT support for ts72xx
      gpio: ep93xx: add DT support for gpio-ep93xx
      ARM: dts: add Cirrus EP93XX SoC .dtsi
      ARM: dts: ep93xx: add ts7250 board
      ARM: ep93xx: DT for the Cirrus ep93xx SoC platforms
      pwm: ep93xx: drop legacy pinctrl
      ata: pata_ep93xx: remove legacy pinctrl use
      ARM: ep93xx: delete all boardfiles
      ARM: ep93xx: soc: drop defines

 .../bindings/arm/cirrus/cirrus,ep9301.yaml         |   38 +
 .../bindings/ata/cirrus,ep9312-pata.yaml           |   42 +
 .../bindings/clock/cirrus,ep9301-clk.yaml          |   46 +
 .../bindings/dma/cirrus,ep9301-dma-m2m.yaml        |   69 +
 .../bindings/dma/cirrus,ep9301-dma-m2p.yaml        |  121 ++
 .../bindings/input/cirrus,ep9307-keypad.yaml       |   87 ++
 .../devicetree/bindings/mtd/technologic,nand.yaml  |   45 +
 .../devicetree/bindings/net/cirrus,ep9301-eth.yaml |   59 +
 .../bindings/pinctrl/cirrus,ep9301-pinctrl.yaml    |   57 +
 .../bindings/power/reset/cirrus,ep9301-reboot.yaml |   34 +
 .../devicetree/bindings/pwm/cirrus,ep9301-pwm.yaml |   46 +
 .../devicetree/bindings/rtc/cirrus,ep9301-rtc.yaml |   42 +
 .../bindings/soc/cirrus/cirrus,ep9301-syscon.yaml  |   71 +
 .../devicetree/bindings/spi/cirrus,ep9301-spi.yaml |   61 +
 .../bindings/timer/cirrus,ep9301-timer.yaml        |   49 +
 .../bindings/watchdog/cirrus,ep9301-wdt.yaml       |   42 +
 .../bindings/watchdog/technologic,ts7200-wdt.yaml  |   45 +
 arch/arm/Makefile                                  |    1 -
 arch/arm/boot/dts/cirrus/Makefile                  |    4 +
 arch/arm/boot/dts/cirrus/ep93xx-bk3.dts            |  124 ++
 arch/arm/boot/dts/cirrus/ep93xx-edb9302.dts        |  180 +++
 arch/arm/boot/dts/cirrus/ep93xx-ts7250.dts         |  143 ++
 arch/arm/boot/dts/cirrus/ep93xx.dtsi               |  454 +++++++
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
 arch/arm/mach-ep93xx/ts72xx.c                      |  422 ------
 arch/arm/mach-ep93xx/ts72xx.h                      |   94 --
 arch/arm/mach-ep93xx/vision_ep9307.c               |  311 -----
 drivers/ata/pata_ep93xx.c                          |   33 +-
 drivers/clk/Kconfig                                |    8 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-ep93xx.c                           |  753 +++++++++++
 drivers/clocksource/Kconfig                        |   11 +
 drivers/clocksource/Makefile                       |    1 +
 .../clocksource}/timer-ep93xx.c                    |  155 ++-
 drivers/dma/ep93xx_dma.c                           |  125 +-
 drivers/gpio/gpio-ep93xx.c                         |  331 ++---
 drivers/input/keyboard/ep93xx_keypad.c             |   74 +-
 drivers/mtd/nand/raw/Kconfig                       |    7 +
 drivers/mtd/nand/raw/Makefile                      |    1 +
 drivers/mtd/nand/raw/technologic-nand-controller.c |  166 +++
 drivers/net/ethernet/cirrus/ep93xx_eth.c           |   63 +-
 drivers/pinctrl/Kconfig                            |    7 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinctrl-ep93xx.c                   | 1429 ++++++++++++++++++++
 drivers/power/reset/Kconfig                        |   10 +
 drivers/power/reset/Makefile                       |    1 +
 drivers/power/reset/ep93xx-restart.c               |   85 ++
 drivers/pwm/pwm-ep93xx.c                           |   26 +-
 drivers/rtc/rtc-ep93xx.c                           |    8 +
 drivers/soc/Kconfig                                |    1 +
 drivers/soc/Makefile                               |    1 +
 drivers/soc/cirrus/Kconfig                         |   12 +
 drivers/soc/cirrus/Makefile                        |    2 +
 drivers/soc/cirrus/soc-ep93xx.c                    |  215 +++
 drivers/spi/spi-ep93xx.c                           |   28 +-
 drivers/watchdog/ep93xx_wdt.c                      |    8 +
 drivers/watchdog/ts72xx_wdt.c                      |    8 +
 include/dt-bindings/clock/cirrus,ep9301-clk.h      |   41 +
 include/dt-bindings/dma/cirrus,ep93xx-dma.h        |   26 +
 include/linux/platform_data/dma-ep93xx.h           |   25 +-
 include/linux/platform_data/eth-ep93xx.h           |   10 -
 include/linux/platform_data/keypad-ep93xx.h        |   32 -
 include/linux/soc/cirrus/ep93xx.h                  |   29 +-
 sound/soc/cirrus/Kconfig                           |    9 -
 sound/soc/cirrus/Makefile                          |    4 -
 sound/soc/cirrus/edb93xx.c                         |  117 --
 77 files changed, 5126 insertions(+), 4168 deletions(-)
---
base-commit: bdc09c8e8b16d494ccd1c56e903e78dd76455a35
change-id: 20230605-ep93xx-01c76317e2d2

Best regards,
-- 
Nikita Shubin <nikita.shubin@maquefel.me>

