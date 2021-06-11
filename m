Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38B43A400A
	for <lists+dmaengine@lfdr.de>; Fri, 11 Jun 2021 12:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhFKKUs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Jun 2021 06:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbhFKKUr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Jun 2021 06:20:47 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1459CC0613A4
        for <dmaengine@vger.kernel.org>; Fri, 11 Jun 2021 03:18:48 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:2411:a261:8fe2:b47f])
        by baptiste.telenet-ops.be with bizsmtp
        id FmJl2500e25eH3q01mJl6H; Fri, 11 Jun 2021 12:18:46 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lreFR-00Fd2C-81; Fri, 11 Jun 2021 12:18:45 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lreFQ-00CaZn-LO; Fri, 11 Jun 2021 12:18:44 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/3] ARM: dts: r8a73a4: Remove non-functional DMA support
Date:   Fri, 11 Jun 2021 12:18:41 +0200
Message-Id: <21d4e03c906f5a4a6d9bf5d88d0fc94c069e6325.1623406640.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1623406640.git.geert+renesas@glider.be>
References: <cover.1623406640.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The DMA multiplexer node and one DMA controller instance are present,
but DMA support was never fully enabled, cfr. commit a19788612f51b787
("dmaengine: sh: Remove R-Mobile APE6 support").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 44 ----------------------------------
 1 file changed, 44 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 0813e70d5b60f353..704b0e4acb4dedf6 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -162,50 +162,6 @@ dbsc2: memory-controller@e67a0000 {
 		power-domains = <&pd_a3bc>;
 	};
 
-	dmac: dma-multiplexer {
-		compatible = "renesas,shdma-mux";
-		#dma-cells = <1>;
-		dma-channels = <20>;
-		dma-requests = <256>;
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		dma0: dma-controller@e6700020 {
-			compatible = "renesas,shdma-r8a73a4";
-			reg = <0 0xe6700020 0 0x89e0>;
-			interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "error",
-					"ch0", "ch1", "ch2", "ch3",
-					"ch4", "ch5", "ch6", "ch7",
-					"ch8", "ch9", "ch10", "ch11",
-					"ch12", "ch13", "ch14", "ch15",
-					"ch16", "ch17", "ch18", "ch19";
-			clocks = <&mstp2_clks R8A73A4_CLK_DMAC>;
-			power-domains = <&pd_a3sp>;
-		};
-	};
-
 	i2c5: i2c@e60b0000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.25.1

