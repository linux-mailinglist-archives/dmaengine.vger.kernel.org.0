Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036F54C4342
	for <lists+dmaengine@lfdr.de>; Fri, 25 Feb 2022 12:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240021AbiBYLYk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 25 Feb 2022 06:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237386AbiBYLYk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 25 Feb 2022 06:24:40 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC8921EBBF;
        Fri, 25 Feb 2022 03:24:07 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 92075FF80A;
        Fri, 25 Feb 2022 11:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645788245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BojsKi1ruriqiFypw1qe5SRshGJ6mnVKS+raZKmEv4g=;
        b=fpyF6FVw5omwB31iIRERcbtM2pRALzfiS8UDs1nEQWzOUOUqr/0qrrzJBWvtgB/r4Efn/A
        dUrg25JBQ415iE4uxNu1rsXZR6jmtFRrDekWtn/UiyW/Y7+iNa6G6Za6abS3OLiIl+OHrB
        pBPsZA1A31UjN3yUa2gJn4BBKlZLvd4h5ocgh0visIFcfQ6r2S0l5On5F4kzkbF75F+51D
        hgRDGhvtPHE/ROwD0OO6lYinqotSF7F4wcMTwM1VaelAeTRBippl8HtXFESsPdC/n0UKb8
        6GvPqDEf5p/31GYtJd7bXOb4OA2OrrtDY6IspNe6CC/Z3RaMYqdYT+NxnxgB7w==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 0/7] RZN1 DMA support
Date:   Fri, 25 Feb 2022 12:23:55 +0100
Message-Id: <20220225112403.505562-1-miquel.raynal@bootlin.com>
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

Miquel Raynal (7):
  dt-bindings: dma: Introduce RZN1 dmamux bindings
  dt-bindings: dma: Introduce RZN1 DMA compatible
  soc: renesas: rzn1-sysc: Export function to set dmamux
  dma: dmamux: Introduce RZN1 DMA router support
  dma: dw: Add RZN1 compatible
  ARM: dts: r9a06g032: Add the two DMA nodes
  ARM: dts: r9a06g032: Describe the DMA router

 .../bindings/dma/renesas,rzn1-dmamux.yaml     |  42 +++++
 .../bindings/dma/snps,dma-spear1340.yaml      |   8 +-
 MAINTAINERS                                   |   1 +
 arch/arm/boot/dts/r9a06g032.dtsi              |  37 +++++
 drivers/clk/renesas/r9a06g032-clocks.c        |  35 +++-
 drivers/dma/dw/Kconfig                        |   8 +
 drivers/dma/dw/Makefile                       |   2 +
 drivers/dma/dw/platform.c                     |   1 +
 drivers/dma/dw/rzn1-dmamux.c                  | 152 ++++++++++++++++++
 include/linux/soc/renesas/r9a06g032-sysctrl.h |  11 ++
 10 files changed, 295 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml
 create mode 100644 drivers/dma/dw/rzn1-dmamux.c
 create mode 100644 include/linux/soc/renesas/r9a06g032-sysctrl.h

-- 
2.27.0

