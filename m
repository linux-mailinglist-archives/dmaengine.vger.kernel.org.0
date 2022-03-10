Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EA34D4DD4
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 16:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239437AbiCJP7c (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 10:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239465AbiCJP7b (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 10:59:31 -0500
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2192815A224;
        Thu, 10 Mar 2022 07:58:28 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 298D4200003;
        Thu, 10 Mar 2022 15:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646927904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nb1Fpg+5tL7svJUmDu7ANYF/3248Po4JwTI/DfjWflc=;
        b=SSi20USfJn1QC0IIQRQBBW2eVyB+m8v8u5G03Mxuxt3Bm11QmhPLJsEB6JRe7//nEv/fxx
        tRqPfxMUL3+Ugw0s/tA9NtuqWFHBa2Y3uVWtsftjLQzCe0avg3rttIaCHwy2lnisvTopex
        jmP0m1FNm4WqaSd26T4G4adqJkOH1Blvv8rsCmzsYTiyRX7AAMUZGH0ThvFL/QXrl+k41e
        PZtBFTgPSBUqTWbqKMxL2RHQrHuAJ6MsZ2wVop5D75VAyYehXD8WGerz4X/feyHPFaJskh
        LIz+EhHGL0pAWnJWvQyBMyxORsh8ha52qzrdxLIzeMlJZLE1vr9zrNuFq0j2iw==
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
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 8/9] ARM: dts: r9a06g032: Add the two DMA nodes
Date:   Thu, 10 Mar 2022 16:57:54 +0100
Message-Id: <20220310155755.287294-9-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220310155755.287294-1-miquel.raynal@bootlin.com>
References: <20220310155755.287294-1-miquel.raynal@bootlin.com>
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

