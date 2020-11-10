Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C585B2ACE1D
	for <lists+dmaengine@lfdr.de>; Tue, 10 Nov 2020 05:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733224AbgKJEGP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Nov 2020 23:06:15 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:40664 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728403AbgKJEGM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Nov 2020 23:06:12 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1739784|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0582695-0.00106321-0.940667;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=28;RT=28;SR=0;TI=SMTPD_---.IulFdj5_1604981159;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.IulFdj5_1604981159)
          by smtp.aliyun-inc.com(10.147.42.135);
          Tue, 10 Nov 2020 12:06:04 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, mripard@kernel.org,
        wens@csie.org, ulf.hansson@linaro.org, kishon@ti.com,
        wim@linux-watchdog.org, linux@roeck-us.net,
        dan.j.williams@intel.com, linus.walleij@linaro.org,
        wsa+renesas@sang-engineering.com, dianders@chromium.org,
        marex@denx.de, colin.king@canonical.com, rdunlap@infradead.org,
        krzk@kernel.org, gregkh@linuxfoundation.org, megous@megous.com,
        rikard.falkeborn@gmail.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org,
        tiny.windzz@gmail.com
Cc:     Frank Lee <frank@allwinnertech.com>
Subject: [PATCH 00/19] Second step support for A100
Date:   Tue, 10 Nov 2020 12:05:34 +0800
Message-Id: <20201110040553.1381-1-frank@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

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

