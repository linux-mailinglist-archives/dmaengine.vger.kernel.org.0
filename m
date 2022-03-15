Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7114DA31D
	for <lists+dmaengine@lfdr.de>; Tue, 15 Mar 2022 20:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351261AbiCOTOc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Mar 2022 15:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351268AbiCOTOa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Mar 2022 15:14:30 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741E7FF3;
        Tue, 15 Mar 2022 12:13:16 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 20883C0004;
        Tue, 15 Mar 2022 19:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647371595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nb1Fpg+5tL7svJUmDu7ANYF/3248Po4JwTI/DfjWflc=;
        b=M2VewpYmdhnw32WBjd6G7pAZZiwgZDk4lyDpydhfs+LVNbMZ0dH34NjPQIv7YxSuNlXIce
        duxOvo3iWQd/gtWKBwNa0YmaBj+d304/CNWenjDEBdRaA+bszGNDRPrEfT+AFyVlQgmrFh
        PT3PYfsj/Q4Qop4LG7KYzbHyiJe2u22t8vB6SSgwVrLwT9edz9b5Pmnh7HiDyIt0IgmpM0
        g2SbSMzaOsUIAWvuA2SRuRYaRvDyxkr8ay0b6Erkw3y4j5bPmWHxBB/gvncYv219PUVr5K
        p9cH01cd5aY8AXqMNMiS2GmBiWcMYvxKtEV/wS3aBgPP38Ze7XJ5/btsiuiZrg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org
Cc:     Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v5 7/8] ARM: dts: r9a06g032: Add the two DMA nodes
Date:   Tue, 15 Mar 2022 20:12:54 +0100
Message-Id: <20220315191255.221473-8-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220315191255.221473-1-miquel.raynal@bootlin.com>
References: <20220315191255.221473-1-miquel.raynal@bootlin.com>
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

Describe the two DMA controllers available on this SoC.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
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

