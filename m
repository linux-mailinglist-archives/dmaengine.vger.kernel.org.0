Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AF44BF5F4
	for <lists+dmaengine@lfdr.de>; Tue, 22 Feb 2022 11:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiBVKfQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Feb 2022 05:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiBVKfQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 22 Feb 2022 05:35:16 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5794A159E9C;
        Tue, 22 Feb 2022 02:34:49 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 883EBFF803;
        Tue, 22 Feb 2022 10:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645526087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ANMNWvUZfIde6jvdiaNgWqYa5EGxthYlnq/u9TekD4o=;
        b=AA6ON+TMG69/MK06aYh93vn19X0U3Eki4jIxJMKI2oG2ZieFiR36/CgwUznO29I4Q1bRGO
        hSvn/IW5Ujp2yvnXcfXFc6avEiVuf9w8KVPiWkAAMq4RfkzGt44MQWpkIByHnK3Ixd0a7X
        PLcKqxXOVt/UiJOH2j+uHYQEdaVt17FFJtidb4aJhsqIbpEFM6q2eaW7ACnEN54m0SuvBp
        3rplic5UZMPa2xQZK6+iUsBnpDSikGDb2vbw8RsHKqaoJY6D7lTv0bjLk5rQRILDlkpMyb
        rPynAH7Y+UsbbNFHVnEK6BtgCK78RoGxbWjekuefVcCjdxdC2nWBOOtYaWWjaQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 0/8] RZN1 DMA support
Date:   Tue, 22 Feb 2022 11:34:29 +0100
Message-Id: <20220222103437.194779-1-miquel.raynal@bootlin.com>
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

Here is a first series bringing DMA support to RZN1 platforms. I'm not a
DMA expert at all so criticism is welcome.

Soon a second series will come with changes made to the UART controller
driver, in order to interact with the RZN1 DMA controller.

Cheers,
Miquèl

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

Miquel Raynal (7):
  dt-bindings: dma: Introduce RZN1 dmamux bindings
  dt-bindings: dma: Introduce RZN1 DMA compatible
  soc: renesas: rzn1-sysc: Export function to set dmamux
  dma: dmamux: Introduce RZN1 DMA router support
  dma: dw: Add RZN1 compatible
  ARM: dts: r9a06g032: Add the two DMA nodes
  ARM: dts: r9a06g032: Describe the DMA router

Phil Edworthy (1):
  dma: dw: Avoid partial transfers

 .../bindings/dma/renesas,rzn1-dmamux.yaml     |  42 +++++
 .../bindings/dma/snps,dma-spear1340.yaml      |   8 +-
 MAINTAINERS                                   |   1 +
 arch/arm/boot/dts/r9a06g032.dtsi              |  37 ++++
 drivers/clk/renesas/r9a06g032-clocks.c        |  31 ++++
 drivers/dma/dw/Kconfig                        |   8 +
 drivers/dma/dw/Makefile                       |   2 +
 drivers/dma/dw/core.c                         |   3 +
 drivers/dma/dw/dmamux.c                       | 167 ++++++++++++++++++
 drivers/dma/dw/platform.c                     |   1 +
 include/linux/soc/renesas/r9a06g032-sysctrl.h |  11 ++
 11 files changed, 310 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml
 create mode 100644 drivers/dma/dw/dmamux.c
 create mode 100644 include/linux/soc/renesas/r9a06g032-sysctrl.h

-- 
2.27.0

