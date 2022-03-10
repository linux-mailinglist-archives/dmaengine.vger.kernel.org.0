Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB984D4DCC
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 16:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239330AbiCJP7K (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 10:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239293AbiCJP7J (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 10:59:09 -0500
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C637C4C42B;
        Thu, 10 Mar 2022 07:58:06 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 54E6620000D;
        Thu, 10 Mar 2022 15:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646927879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9W+sFtR6uDeTiBUoASekZcg3xrvt0vVSp2kEUxiXddA=;
        b=XvxRl+x/AwIecTzjlKuRsK0PS6XxesRtpWu29qO9VmAvDZRW41nxHdEzBh6P2U8iffNTno
        SRfz+ALKHY71uRkZ72sxc5APvWyL3SNLWY6gmeMXcOZ+OPFJZEemNKMfonSQjZ5V7pj8It
        oBWMP75k8LDTtGElWh0JlKVGNsUBuPMB+mURPel5FWC12zSfN3bNXu4u96p0ILsbOuGw2P
        MoI/ynIaBFnMh/SXZreHS9iJkwcRnDeURsCXQsaknN+HLgcN04Bdl/diyYFNjfoC5ssegL
        bcEEEKq6AosRbeRt4qCk8eg0PrRFO9zjsq9tpJ9G/yfCn2iZrQcdokgYgQ9ciw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v4 0/9] RZN1 DMA support
Date:   Thu, 10 Mar 2022 16:57:46 +0100
Message-Id: <20220310155755.287294-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

Here is a first series bringing DMA support to RZN1 platforms. Soon a
second series will come with changes made to the UART controller
driver, in order to interact with the RZN1 DMA controller.

Cheers,
Miquèl

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
  dt-bindings: dma: Introduce RZN1 dmamux bindings
  dt-bindings: clock: r9a06g032-sysctrl: Reference the DMAMUX subnode
  dt-bindings: dma: Introduce RZN1 DMA compatible
  soc: renesas: rzn1-sysc: Export function to set dmamux
  dma: dw: dmamux: Introduce RZN1 DMA router support
  dma: dw: Add RZN1 compatible
  dma: dw: Avoid partial transfers
  ARM: dts: r9a06g032: Add the two DMA nodes
  ARM: dts: r9a06g032: Describe the DMA router

 .../clock/renesas,r9a06g032-sysctrl.yaml      |  11 ++
 .../bindings/dma/renesas,rzn1-dmamux.yaml     |  51 ++++++
 .../bindings/dma/snps,dma-spear1340.yaml      |   8 +-
 MAINTAINERS                                   |   1 +
 arch/arm/boot/dts/r9a06g032.dtsi              |  40 +++++
 drivers/clk/renesas/r9a06g032-clocks.c        |  36 ++++-
 drivers/dma/dw/Kconfig                        |   9 ++
 drivers/dma/dw/Makefile                       |   2 +
 drivers/dma/dw/core.c                         |   4 +
 drivers/dma/dw/platform.c                     |   1 +
 drivers/dma/dw/rzn1-dmamux.c                  | 152 ++++++++++++++++++
 include/linux/soc/renesas/r9a06g032-sysctrl.h |  11 ++
 12 files changed, 324 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml
 create mode 100644 drivers/dma/dw/rzn1-dmamux.c
 create mode 100644 include/linux/soc/renesas/r9a06g032-sysctrl.h

-- 
2.27.0

