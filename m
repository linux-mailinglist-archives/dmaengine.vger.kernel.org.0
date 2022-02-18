Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A561A4BBF14
	for <lists+dmaengine@lfdr.de>; Fri, 18 Feb 2022 19:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbiBRSMv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Feb 2022 13:12:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbiBRSMu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Feb 2022 13:12:50 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92ECB35DFC;
        Fri, 18 Feb 2022 10:12:32 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8D4FD20005;
        Fri, 18 Feb 2022 18:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645207948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=deSZu+qBukwpiSRa2N8bS3T5wydQePa0aCzjNVX3Mw8=;
        b=Pk8v0BgZwgu65ScCZtPLdmSu9VKd46Fmv9RjfKs1KZNe6+5PXJe4M13835t+vjLhmAIF4m
        Flioj+nb7zFgTUvdmlsVTY0zLSUhEYJsALxvR+nIxGVtLJvrDqwvZmlC3fHX3+A536xtdB
        iRgVrJ4t+SnJQ+UzoNEjDT3SM9WI4SfrxD7OGtxb8JdVt/YJzFPe+FxfGOdU1KVd0RZL0e
        lucOGa0dbYS4pNykS5Tg10x2NMYfXCUAMZheeCfAft5PghrM+a0DoBnV7gWFpzhkdwVjaI
        KdjDRsBOpyiR33f+0hXS8aiPFhrcHmlQW0o1fLskuviB1sClQknQn4Kn9yd1dA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Laetitia MARIOTTINI <laetitia.mariottini@se.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 0/8] RZN1 DMA support
Date:   Fri, 18 Feb 2022 19:12:18 +0100
Message-Id: <20220218181226.431098-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/clk/renesas/r9a06g032-clocks.c        |  27 +++
 drivers/dma/dw/Makefile                       |   2 +-
 drivers/dma/dw/core.c                         |   3 +
 drivers/dma/dw/dmamux.c                       | 175 ++++++++++++++++++
 drivers/dma/dw/platform.c                     |   1 +
 include/dt-bindings/clock/r9a06g032-sysctrl.h |   2 +
 include/linux/soc/renesas/r9a06g032-syscon.h  |  11 ++
 11 files changed, 307 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml
 create mode 100644 drivers/dma/dw/dmamux.c
 create mode 100644 include/linux/soc/renesas/r9a06g032-syscon.h

-- 
2.27.0

