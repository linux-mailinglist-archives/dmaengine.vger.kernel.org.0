Return-Path: <dmaengine+bounces-6894-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E587BF2A36
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 19:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5DED1890626
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 17:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145AC333425;
	Mon, 20 Oct 2025 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5laTG33"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43AB332EB6;
	Mon, 20 Oct 2025 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760980282; cv=none; b=ed2hLHKBdTjTgpid7K1vIUw7REvM8erMOWrmNW2rjuK0gaYWlD3syOU/MUl3rvgsZ/xIXF13ctLdI8V49Zqw2B0jX2EV+BDT/kNlgpodclG0OTybDkU8I9OPgzJ6ql1EQAiVqbQGmozpIrUNk+kDHKpGn2glocOigSmuNiMRtTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760980282; c=relaxed/simple;
	bh=8s4OP1AvakA/kxF+4prl0Tvj4XO9cRh189UcPgu3oxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ayU4uHWgiO8wrX3fgZo0nOc3ZjIXe3QW06Oc/ELzsd6e3JlSoFfBAKP6NU/p3ax0yTuhSAkJXudE0oPYrsdmwnm4WyWLdQ3ICLCxTyku4E9odVDpefg2IppzsfZ8F8puJbHQzePin1ZgtGZxxtEjMFXc489V9piLiSnfTLvFr/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5laTG33; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E77BC116B1;
	Mon, 20 Oct 2025 17:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760980282;
	bh=8s4OP1AvakA/kxF+4prl0Tvj4XO9cRh189UcPgu3oxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g5laTG33MZnByhR4wffZQdgbPopMZuAIWkmH3vTJCU50Z3zLZymlE5i/xT7sQedms
	 SAeCE+rhUkk1tPZJnC3UmI0qegJlSNc5OqfT7pImk46KudP4cNwiQFs8siFxeN5Grq
	 w8XolDDnh7LBAY0bykr9RN47eKSIGLDqiOKf5WH5KNNJNlY2nTVD5VyZj+ZxEe9/Db
	 Ve6EPnFzRXDkKGLVmFSpnaowpMV5/rJVYH1J2f2hOBDYmDyT7Z0KgXPVHwf1hG9ZSb
	 KK0/e+O3PsHXpIhJu62d0n/RfsaWBScszNceMWibrsBzhNT7NTe7NElK0Yh6QcjRSU
	 K/ssEO84Pdnlg==
Received: by wens.tw (Postfix, from userid 1000)
	id 5CB135FEB2; Tue, 21 Oct 2025 01:11:18 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Mark Brown <broonie@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>,
	linux-sunxi@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] arm64: dts: allwinner: a523: Add DMA controller device nodes
Date: Tue, 21 Oct 2025 01:10:53 +0800
Message-ID: <20251020171059.2786070-8-wens@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251020171059.2786070-1-wens@kernel.org>
References: <20251020171059.2786070-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

The A523 has two DMA controllers. Add device nodes for both. Also hook
up DMA for existing devices.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index a9e051a8bea3..8edbd3873199 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
@@ -241,6 +241,8 @@ uart0: serial@2500000 {
 			reg-io-width = <4>;
 			clocks = <&ccu CLK_BUS_UART0>;
 			resets = <&ccu RST_BUS_UART0>;
+			dmas = <&dma 14>, <&dma 14>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
@@ -252,6 +254,8 @@ uart1: serial@2500400 {
 			reg-io-width = <4>;
 			clocks = <&ccu CLK_BUS_UART1>;
 			resets = <&ccu RST_BUS_UART1>;
+			dmas = <&dma 15>, <&dma 15>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
@@ -263,6 +267,8 @@ uart2: serial@2500800 {
 			reg-io-width = <4>;
 			clocks = <&ccu CLK_BUS_UART2>;
 			resets = <&ccu RST_BUS_UART2>;
+			dmas = <&dma 16>, <&dma 16>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
@@ -274,6 +280,8 @@ uart3: serial@2500c00 {
 			reg-io-width = <4>;
 			clocks = <&ccu CLK_BUS_UART3>;
 			resets = <&ccu RST_BUS_UART3>;
+			dmas = <&dma 17>, <&dma 17>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
@@ -285,6 +293,8 @@ uart4: serial@2501000 {
 			reg-io-width = <4>;
 			clocks = <&ccu CLK_BUS_UART4>;
 			resets = <&ccu RST_BUS_UART4>;
+			dmas = <&dma 18>, <&dma 18>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
@@ -296,6 +306,8 @@ uart5: serial@2501400 {
 			reg-io-width = <4>;
 			clocks = <&ccu CLK_BUS_UART5>;
 			resets = <&ccu RST_BUS_UART5>;
+			dmas = <&dma 19>, <&dma 19>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
@@ -307,6 +319,8 @@ uart6: serial@2501800 {
 			reg-io-width = <4>;
 			clocks = <&ccu CLK_BUS_UART6>;
 			resets = <&ccu RST_BUS_UART6>;
+			dmas = <&dma 20>, <&dma 20>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
@@ -318,6 +332,8 @@ uart7: serial@2501c00 {
 			reg-io-width = <4>;
 			clocks = <&ccu CLK_BUS_UART7>;
 			resets = <&ccu RST_BUS_UART7>;
+			dmas = <&dma 21>, <&dma 21>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
@@ -329,6 +345,8 @@ i2c0: i2c@2502000 {
 			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_I2C0>;
 			resets = <&ccu RST_BUS_I2C0>;
+			dmas = <&dma 43>, <&dma 43>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -342,6 +360,8 @@ i2c1: i2c@2502400 {
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_I2C1>;
 			resets = <&ccu RST_BUS_I2C1>;
+			dmas = <&dma 44>, <&dma 44>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -355,6 +375,8 @@ i2c2: i2c@2502800 {
 			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_I2C2>;
 			resets = <&ccu RST_BUS_I2C2>;
+			dmas = <&dma 45>, <&dma 45>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -368,6 +390,8 @@ i2c3: i2c@2502c00 {
 			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_I2C3>;
 			resets = <&ccu RST_BUS_I2C3>;
+			dmas = <&dma 46>, <&dma 46>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -381,6 +405,8 @@ i2c4: i2c@2503000 {
 			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_I2C4>;
 			resets = <&ccu RST_BUS_I2C4>;
+			dmas = <&dma 47>, <&dma 47>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -394,6 +420,8 @@ i2c5: i2c@2503400 {
 			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_I2C5>;
 			resets = <&ccu RST_BUS_I2C5>;
+			dmas = <&dma 48>, <&dma 48>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -408,6 +436,19 @@ syscon: syscon@3000000 {
 			ranges;
 		};
 
+		dma: dma-controller@3002000 {
+			compatible = "allwinner,sun55i-a523-dma",
+				     "allwinner,sun50i-a100-dma";
+			reg = <0x03002000 0x1000>;
+			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_DMA>, <&ccu CLK_MBUS_DMA>;
+			clock-names = "bus", "mbus";
+			dma-channels = <16>;
+			dma-requests = <54>;
+			resets = <&ccu RST_BUS_DMA>;
+			#dma-cells = <1>;
+		};
+
 		sid: efuse@3006000 {
 			compatible = "allwinner,sun55i-a523-sid",
 				     "allwinner,sun50i-a64-sid";
@@ -729,6 +770,8 @@ r_i2c0: i2c@7081400 {
 			reg = <0x07081400 0x400>;
 			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&r_ccu CLK_BUS_R_I2C0>;
+			dmas = <&dma 49>, <&dma 49>;
+			dma-names = "rx", "tx";
 			resets = <&r_ccu RST_BUS_R_I2C0>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&r_i2c_pins>;
@@ -775,6 +818,19 @@ mcu_ccu: clock-controller@7102000 {
 			#reset-cells = <1>;
 		};
 
+		mcu_dma: dma-controller@7121000 {
+			compatible = "allwinner,sun55i-a523-mcu-dma",
+				     "allwinner,sun50i-a100-dma";
+			reg = <0x07121000 0x1000>;
+			interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mcu_ccu CLK_BUS_MCU_DMA>, <&mcu_ccu CLK_MCU_MBUS_DMA>;
+			clock-names = "bus", "mbus";
+			dma-channels = <16>;
+			dma-requests = <15>;
+			resets = <&mcu_ccu RST_BUS_MCU_DMA>;
+			#dma-cells = <1>;
+		};
+
 		npu: npu@7122000 {
 			compatible = "vivante,gc";
 			reg = <0x07122000 0x1000>;
-- 
2.47.3


