Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DD54F6817
	for <lists+dmaengine@lfdr.de>; Wed,  6 Apr 2022 19:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239546AbiDFR57 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Apr 2022 13:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240080AbiDFR5t (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Apr 2022 13:57:49 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B21C32E95A;
        Wed,  6 Apr 2022 09:19:20 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DAB6F20015;
        Wed,  6 Apr 2022 16:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649261958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ge58NimhaKWCxwe0+hrNu+VcWrBPIvnbMynidvFnOMc=;
        b=D/XiUk2x0wvubfdt/FTT77r1TdTCt5klWhxBnCEX+YbrK7lwMoAC9WeAJNN99PVgmzTdAW
        uwtOflNUAKXTDKibdKRBRQ0Hg/WIDFLLMUmPymo1qgsXLIsmEOESoM+8iFgNhNUcQn1icP
        Ubcsja3zqFWhKuBAER77Asz7XuXGffPZpcmasKp3u3LGFYbPNyOURVLiGXcDLwHAGccGpb
        4T6jprqTfrAzpZMWUvBCvWuDFhhAwQC9YxIRInfmBJ+oNWQ+7EHPHcKwsho981KqOYPS+4
        6vT35i5CJa5NH98uyH5Iqi8S3jFiN0+qaIq47JepuLBjZAUFzH70blTvFz8ypg==
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
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v8 8/9] ARM: dts: r9a06g032: Add the two DMA nodes
Date:   Wed,  6 Apr 2022 18:18:55 +0200
Message-Id: <20220406161856.1669069-9-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220406161856.1669069-1-miquel.raynal@bootlin.com>
References: <20220406161856.1669069-1-miquel.raynal@bootlin.com>
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

Describe the two DMA controllers available on this SoC.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r9a06g032.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
index 636a6ab31c58..839580ec21ee 100644
--- a/arch/arm/boot/dts/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/r9a06g032.dtsi
@@ -200,6 +200,36 @@ nand_controller: nand-controller@40102000 {
 			status = "disabled";
 		};
 
+		dma0: dma-controller@40104000 {
+			compatible = "renesas,r9a06g032-dma", "renesas,rzn1-dma";
+			reg = <0x40104000 0x1000>;
+			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "hclk";
+			clocks = <&sysctrl R9A06G032_HCLK_DMA0>;
+			dma-channels = <8>;
+			dma-requests = <16>;
+			dma-masters = <1>;
+			#dma-cells = <3>;
+			block_size = <0xfff>;
+			data_width = <3>;
+			status = "disabled";
+		};
+
+		dma1: dma-controller@40105000 {
+			compatible = "renesas,r9a06g032-dma", "renesas,rzn1-dma";
+			reg = <0x40105000 0x1000>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "hclk";
+			clocks = <&sysctrl R9A06G032_HCLK_DMA1>;
+			dma-channels = <8>;
+			dma-requests = <16>;
+			dma-masters = <1>;
+			#dma-cells = <3>;
+			block_size = <0xfff>;
+			data_width = <3>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller@44101000 {
 			compatible = "arm,gic-400", "arm,cortex-a7-gic";
 			interrupt-controller;
-- 
2.27.0

