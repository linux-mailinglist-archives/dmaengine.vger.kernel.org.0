Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FC74F1614
	for <lists+dmaengine@lfdr.de>; Mon,  4 Apr 2022 15:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355307AbiDDNlL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 Apr 2022 09:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237341AbiDDNlI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 4 Apr 2022 09:41:08 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA8A5F74;
        Mon,  4 Apr 2022 06:39:10 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7699DE0005;
        Mon,  4 Apr 2022 13:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649079549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=V3uxcw18GlL8h7lmt6qfUVlnCBzKjm/iZBFphEMUgVc=;
        b=XLhsBR/xzFPY4/FIfZ2YXhbKf174OAPuJAYfQmLKHE8rHbZJh2uY75k5XkRsIWCfk5Jtp6
        k0y3TPQ/jmlFcEnG0a/xfUuwcr6fREDfhXbaAzudOqjcSepuTed4ZK5SbyjWrmc+AChmxU
        E3KmD4vXn6vi/4Rzuy3Yo3IfO0cEFXDlfuEwf0nEQVVIyPl9vQL0OL2eqqRNnIEz0wr26i
        WB7HK33aYde2LPl83NN0dJNofFYtsxE8cnlzEWTfsh5PyMbiT2/TAbyyWS+X3iqR8sVgGX
        0tvFlT6u/QX/r2vQJQwJzLPj22MRaweKszSn4tVCztSz38CbAWveAesJUpDD3Q==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Milan Stevanovic <milan.stevanovic@se.com>,
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
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v6 0/8] RZN1 DMA support
Date:   Mon,  4 Apr 2022 15:38:56 +0200
Message-Id: <20220404133904.1296258-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

Here is a first series bringing DMA support to RZN1 platforms. Soon a
second series will come with changes made to the UART controller
driver, in order to interact with the RZN1 DMA controller.

Stephen acked the sysctrl patch (in the clk driver) but somehow I feel
like it would be good to have this patch applied on both sides
(dmaengine and clk) because more changes will depend on the addition of
this helper, that are not related to DMA at all. I'll let you folks
figure out what is best.

Cheers,
Miquèl

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

Miquel Raynal (8):
  dt-bindings: dmaengine: Introduce RZN1 dmamux bindings
  dt-bindings: clock: r9a06g032-sysctrl: Reference the DMAMUX subnode
  dt-bindings: dmaengine: Introduce RZN1 DMA compatible
  soc: renesas: rzn1-sysc: Export function to set dmamux
  dmaengine: dw: dmamux: Introduce RZN1 DMA router support
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
 drivers/dma/dw/rzn1-dmamux.c                  | 157 ++++++++++++++++++
 include/linux/soc/renesas/r9a06g032-sysctrl.h |  11 ++
 11 files changed, 325 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml
 create mode 100644 drivers/dma/dw/rzn1-dmamux.c
 create mode 100644 include/linux/soc/renesas/r9a06g032-sysctrl.h

-- 
2.27.0

