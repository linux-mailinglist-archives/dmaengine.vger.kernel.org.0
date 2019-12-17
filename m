Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAA88121F65
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2019 01:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfLQATo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Dec 2019 19:19:44 -0500
Received: from muru.com ([72.249.23.125]:48596 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbfLQATo (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 16 Dec 2019 19:19:44 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 2B888810D;
        Tue, 17 Dec 2019 00:20:22 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 00/14] Remove legacy sdma code for dt booting omaps
Date:   Mon, 16 Dec 2019 16:19:11 -0800
Message-Id: <20191217001925.44558-1-tony@atomide.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi all,

This series finally removes the legacy sdma code for omaps booting with
devicetree. The legacy sdma code is still left for omap1, but makes
further work a bit easier.

We do the removal of legacy sdma code with the following steps:

- Prepare for platform data removal by probing sdma with device tree
  data for the interconnect target module

- Drop unused code and legacy interrupt code for omap2 and later

- Update dmaengine driver to use device tree match data and add
  missing features

- Allocate logical channels directly in the dmaengine driver

- Drop legacy platform init and data

The patches are against v5.5-rc1, and need the following fixes:

2c81f0f6d3f5 ("bus: ti-sysc: Fix iterating over clocks")
e709ed70d122 ("bus: ti-sysc: Fix missing reset delay handling")
93c60483b5fe ("bus: ti-sysc: Fix missing force mstandby quirk handling")
90bdfa0b05e3 ("ARM: OMAP2+: Fix ti_sysc_find_one_clockdomain to check for to_clk_hw_omap")

To make testing easier, I've also pushed out a testing branch at [0][1].

Regards,

Tony


[0] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git omap-for-v5.6/sdma-testing
[1] https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/log/?h=omap-for-v5.6/sdma-testing


Tony Lindgren (14):
  ARM: dts: Add generic compatible for omap sdma instances
  ARM: dts: Configure interconnect target module for omap2 sdma
  ARM: dts: Configure interconnect target module for omap3 sdma
  ARM: OMAP2+: Drop unused sdma functions
  ARM: OMAP2+: Drop sdma interrupt handling for mach-omap2
  ARM: OMAP2+: Configure sdma capabilities directly
  ARM: OMAP2+: Configure dma_plat_info directly and drop dma_dev_attr
  dmaengine: ti: omap-dma: Add device tree match data and use it for
    cpu_pm
  dmaengine: ti: omap-dma: Configure global priority register directly
  dmaengine: ti: omap-dma: Pass sdma auxdata to driver and use it
  dmaengine: ti: omap-dma: Allocate channels directly
  dmaengine: ti: omap-dma: Use cpu notifier to block idle for omap2
  ARM: OMAP2+: Drop legacy init for sdma
  ARM: OMAP2+: Drop legacy platform data for sdma

 arch/arm/boot/dts/dra7-l4.dtsi                |   3 +-
 arch/arm/boot/dts/omap2.dtsi                  |  43 +-
 arch/arm/boot/dts/omap2430.dtsi               |   4 +
 arch/arm/boot/dts/omap3-n900.dts              |   5 +
 arch/arm/boot/dts/omap3.dtsi                  |  46 +-
 arch/arm/boot/dts/omap36xx.dtsi               |   4 +
 arch/arm/boot/dts/omap4-l4.dtsi               |   3 +-
 arch/arm/boot/dts/omap5-l4.dtsi               |   3 +-
 arch/arm/mach-omap2/common.h                  |   3 +
 arch/arm/mach-omap2/dma.c                     | 119 +----
 arch/arm/mach-omap2/omap_device.c             | 170 -------
 arch/arm/mach-omap2/omap_device.h             |   4 -
 arch/arm/mach-omap2/omap_hwmod_2420_data.c    |  34 --
 arch/arm/mach-omap2/omap_hwmod_2430_data.c    |  34 --
 .../mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  18 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |  61 ---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c    |  69 ---
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c    |  61 ---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c     |  61 ---
 arch/arm/mach-omap2/omap_hwmod_common_data.h  |   1 -
 arch/arm/mach-omap2/pdata-quirks.c            |   1 +
 arch/arm/mach-omap2/pm24xx.c                  |  22 +-
 arch/arm/mach-omap2/pm34xx.c                  |   5 -
 arch/arm/plat-omap/dma.c                      | 471 +-----------------
 drivers/dma/ti/omap-dma.c                     | 288 ++++++++++-
 include/linux/omap-dma.h                      |  18 -
 26 files changed, 391 insertions(+), 1160 deletions(-)

-- 
2.24.1
