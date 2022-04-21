Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B38509B37
	for <lists+dmaengine@lfdr.de>; Thu, 21 Apr 2022 10:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386962AbiDUIyL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Apr 2022 04:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381575AbiDUIyJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Apr 2022 04:54:09 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8775913E9F;
        Thu, 21 Apr 2022 01:51:18 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4F8616000A;
        Thu, 21 Apr 2022 08:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650531076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HptSnXZn+eLxnS7R0lwjRkbdn7VnxhdvVp7LHSqiq8Y=;
        b=grLj/QtNwEsoQf8kH5POI8QIfTSTKPFT+mQxx7O5d1TeR7UP6JO0LhUfHhgKtAXQdmPLGe
        IRuwrQjmDNq82ddriv4mdKKAsBHimkQ7Cai0zNfx21c8ocwmHiE0oeVwxk4Oc0nrJhwHS8
        8weCpi8PiekFFDYle36iSNCpf8IsrUHw17OunUfCXd52O/z+eMybr5BK3dFP0n/X9F0aPy
        0hsmPvvt2UgW9j4szTXO+rA7K/XWIk04MTu2VywBRexta+bEy7wds76ZuY95IVgujV4mjJ
        60DRMTQXZ5jXoUAhu7OthWJWVAYBzkLad7mIls4U/ZIS5jJyJ0bujkeuFx9vwg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-renesas-soc@vger.kernel.org, dmaengine@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v11 0/9] RZN1 DMA support
Date:   Thu, 21 Apr 2022 10:51:03 +0200
Message-Id: <20220421085112.78858-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

This is the series bringing DMA support to RZN1 platforms.
Other series follow with eg. UART and RTC support as well.

There is no other conflicting dependency with the other series, so this
series can now entirely be merged in the dmaengine tree I believe.

Cheers,
Miquèl

Changes in v11:
* Renamed two defines.
* Changed the way the bitmap is declared.
* Updated the cover letter: this series can now go in through the
  dmaengine tree.

Changes in v10:
* Collected more tags.
* Dropped the mutex from the dmamux driver.
* Added missing includes in the dmamux driver.
* Replaced set_bit() by test_and_set_bit() in order to check if the chan
  is already used or not in the dmamux driver.
* Corrected the misuse of the set_bit() macro in the dmamux driver.

Changes in v9:
* Collected more tags.
* Changed a u32 into a regular bitmap and used the bitmap API.
* Reordered two function calls to save one extra line.
* Added a define to avoid a magic value.

Changes in v8:
* Collected more tags.
* Moved the Makefile line adding the dmamux driver to the bottom of the
  file.
* Reversed the logic in a ternary operation as suggested by Andy.
* Changed a bit the naming of a #define as suggested by Andy.

Changes in v7:
* This time, really added Stephen's Acks (sorry for the error).
* Moved an error check to get rid of one mutex_unlock/lock call as
  suggested by Ilpo.
* Split the patch adding the dmamux driver as advised by Vinod. One
  patch introduces the dmamux driver, the other populates the children
  of the system controller. As the original patch got acked by Stephen
  Boyd, I moved his tag to the patch touching the clock controller only.

Changes in v6:
* Added Stephen's acks.
* Fixed an extra newline added in the middle of nowhere.
* Rebased on top of v5.18-rc1.

Changes in v5:
* Used gotos in rzn1_dmamux_route_allocate().
* Changed the prefix to "dmaengine:".
* Dropped the partial transfers fix.
* Added Rob's acks.

Changes in v4:
* Freed "map" in the error path of the dmamux driver.
* Improved a bit the style as requested by Prabhakar.
* Dropped a __maybe_unused.
* Reorder the includes.
* Added a dependency on ARCH_RZN1.
* Added Rob's Ack.
* Added a reg property to the dmamux binding file.
* Referenced the dmamux binding from the system controller file.
* Called of_platform_populate from the end of the system controller
  (clock) driver probe in order to probe the dmamux if it was
  populated.
* Added DMA properties to all the relevant UARTs.

Changes in v3:
* Added Reviewed-by tags.
* Exported the set_dmamux* symbol properly.
* Dropped a useless check in the probe and moved the sysctrl_priv
  assignation to the end of the probe.
* Renamed the dmamux driver
* Added a couple of missing MODULE_ macros in the dmamux driver.
* Decided to use a regular platform init call instead of the
  arch_initcall() initially proposed.
* s/%d/%u/ in printk's when appropriate.
* Used a hardcoded value instead of dmamux->dmac_requests when
  appropriate.
* Changed the variable name "master" to "dmac_idx" to be more
  descriptive.
* Dropped most of the of_* calls in favor of #define's.
* Fixed a typo.
* Exported two symbols from 8250_dma.c.

Changes in v2:
* Clarified that the 'fix' regarding non aligned reads would only apply
  to the DEV_TO_MEM case.
* Fix the DMA controller compatible string (copy-paste error).
* s/syscon/sysctrl/ as advised by Geert.
* Disabled irqs when taking the spinlock from the clocks driver.
* Moved the DMAMUX offset inside the driver.
* Removed extra commas.
* Improved the style as suggested by Andy.
* Removed a dupplicated check against the device node presence.
* Reduced the number of lines of code by using dev_err_probe().
* Created a Kconfig symbol for DMAMUX to fix the two robot reports
  received and be sure there was no useless overhead with other
  platforms.
* Exported the serial8250_{tx,rx}_dma() symbols.

Miquel Raynal (9):
  dt-bindings: dmaengine: Introduce RZN1 dmamux bindings
  dt-bindings: clock: r9a06g032-sysctrl: Reference the DMAMUX subnode
  dt-bindings: dmaengine: Introduce RZN1 DMA compatible
  soc: renesas: rzn1-sysc: Export function to set dmamux
  dmaengine: dw: dmamux: Introduce RZN1 DMA router support
  clk: renesas: r9a06g032: Probe possible children
  dmaengine: dw: Add RZN1 compatible
  ARM: dts: r9a06g032: Add the two DMA nodes
  ARM: dts: r9a06g032: Describe the DMA router

 .../clock/renesas,r9a06g032-sysctrl.yaml      |  11 ++
 .../bindings/dma/renesas,rzn1-dmamux.yaml     |  51 ++++++
 .../bindings/dma/snps,dma-spear1340.yaml      |   8 +-
 MAINTAINERS                                   |   1 +
 arch/arm/boot/dts/r9a06g032.dtsi              |  40 +++++
 drivers/clk/renesas/r9a06g032-clocks.c        |  36 +++-
 drivers/dma/dw/Kconfig                        |   9 +
 drivers/dma/dw/Makefile                       |   2 +
 drivers/dma/dw/platform.c                     |   1 +
 drivers/dma/dw/rzn1-dmamux.c                  | 155 ++++++++++++++++++
 include/linux/soc/renesas/r9a06g032-sysctrl.h |  11 ++
 11 files changed, 323 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml
 create mode 100644 drivers/dma/dw/rzn1-dmamux.c
 create mode 100644 include/linux/soc/renesas/r9a06g032-sysctrl.h

-- 
2.27.0

