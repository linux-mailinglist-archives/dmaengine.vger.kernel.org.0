Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C1D2ACF8B
	for <lists+dmaengine@lfdr.de>; Tue, 10 Nov 2020 07:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgKJGUo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Nov 2020 01:20:44 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:50138 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726006AbgKJGUn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Nov 2020 01:20:43 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1692928|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0582695-0.00106321-0.940667;FP=7849204115990839735|1|1|17|0|-1|-1|-1;HT=ay29a033018047211;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=28;RT=28;SR=0;TI=SMTPD_---.IunZWw3_1604989219;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.IunZWw3_1604989219)
          by smtp.aliyun-inc.com(10.147.42.135);
          Tue, 10 Nov 2020 14:20:35 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     tiny.windzz@gmail.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Frank Lee <frank@allwinnertech.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Marek Vasut <marex@denx.de>,
        Douglas Anderson <dianders@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Ondrej Jirman <megous@megous.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RESEND PATCH 00/19] Second step support for A100
Date:   Tue, 10 Nov 2020 14:20:04 +0800
Message-Id: <cover.1604988979.git.frank@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Let's add watchdog, arm-pmu, dma, usb, mmc..... support for allwinner
a100 soc.

Yangtao Li (19):
  pinctrl: sunxi: fix irq bank map for the Allwinner A100 pin controller
  pinctrl: sunxi: Mark the irq bank not found in
    sunxi_pinctrl_irq_handler() with WARN_ON
  pinctrl: sunxi: Always call chained_irq_{enter, exit} in
    sunxi_pinctrl_irq_handler
  dt-bindings: dma: allwinner,sun50i-a64-dma: Add A100 compatible
  dmaengine: sun6i: Add support for A100 DMA
  arm64: allwinner: a100: Add device node for DMA controller
  arm64: dts: allwinner: A100: Add PMU mode
  phy: sun4i-usb: remove enable_pmu_unk1 from sun50i_h6_cfg
  phy: allwinner: Convert to devm_platform_ioremap_* API
  dt-bindings: watchdog: sun4i: Add A100 compatible
  arm64: dts: allwinner: a100: add watchdog node
  dt-bindings: Add bindings for USB phy on Allwinner A100
  phy: sun4i-usb: add support for A100 USB PHY
  arm64: dts: allwinner: a100: add usb related nodes
  arm64: allwinner: A100: enable EHCI, OHCI and USB PHY nodes in Perf1
  dt-bindings: mmc: sunxi: Add A100 compatibles
  mmc: sunxi: add support for A100 mmc controller
  arm64: allwinner: a100: Add MMC related nodes
  arm64: dts: allwinner: a100: perf1: Add eMMC and MMC node

 .../dma/allwinner,sun50i-a64-dma.yaml         |   5 +-
 .../bindings/mmc/allwinner,sun4i-a10-mmc.yaml |   2 +
 .../phy/allwinner,sun50i-a100-usb-phy.yaml    | 105 ++++++++++
 .../watchdog/allwinner,sun4i-a10-wdt.yaml     |   3 +
 .../allwinner/sun50i-a100-allwinner-perf1.dts |  54 +++++
 .../arm64/boot/dts/allwinner/sun50i-a100.dtsi | 197 +++++++++++++++++-
 drivers/dma/sun6i-dma.c                       |  25 +++
 drivers/mmc/host/sunxi-mmc.c                  |  28 ++-
 drivers/phy/allwinner/phy-sun4i-usb.c         |  29 ++-
 drivers/phy/allwinner/phy-sun50i-usb3.c       |   4 +-
 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c   |   4 +-
 drivers/phy/allwinner/phy-sun9i-usb.c         |   4 +-
 drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c   |   2 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.c         |   9 +-
 14 files changed, 443 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/allwinner,sun50i-a100-usb-phy.yaml

-- 
2.28.0

