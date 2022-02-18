Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401A54BBF31
	for <lists+dmaengine@lfdr.de>; Fri, 18 Feb 2022 19:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239030AbiBRSNE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Feb 2022 13:13:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239031AbiBRSND (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Feb 2022 13:13:03 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D67535DFC;
        Fri, 18 Feb 2022 10:12:45 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EBF6D2000A;
        Fri, 18 Feb 2022 18:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645207964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WeWTdPDyu4NpqtMlrcHJAByNbSFMRLqvNKamFBzDCiw=;
        b=hwrEYOrT3Q09uGn1ADsiKkh5rl59PBuo98xng1ZK2gQjJKtGQV1+cKK4PReH9k1dBG9AWI
        oQro+pnRxWSIjgAq9AnGFMWJLZ/TCPntTK7mO3JSYx2gHWrOCKhLdbHcWsJ7xXKcoft4Dc
        FtCZ2pJZ0flVYNIjqnnnc7JzQskq1o4Uo+pgXZEr+2XzKbDh/sMKEGQ8H43xUULojTxD8k
        8hFjBAa/sENIBCm87/o19Q+A22YXGLU+fxRt8mrlRbsEPlWp2ddCY/D5Wyb4rjR6KJVx4L
        bnDh2yZxALfW6dCNrYv6opvxhjgiu4IFq0ZiIHT7P9IzySBwK4lwhpcG7JokBA==
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
Subject: [PATCH 7/8] ARM: dts: r9a06g032: Add the two DMA nodes
Date:   Fri, 18 Feb 2022 19:12:25 +0100
Message-Id: <20220218181226.431098-8-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220218181226.431098-1-miquel.raynal@bootlin.com>
References: <20220218181226.431098-1-miquel.raynal@bootlin.com>
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
---
 arch/arm/boot/dts/r9a06g032.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
index db657224688a..640c3eb4bbcd 100644
--- a/arch/arm/boot/dts/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/r9a06g032.dtsi
@@ -184,6 +184,36 @@ nand_controller: nand-controller@40102000 {
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

