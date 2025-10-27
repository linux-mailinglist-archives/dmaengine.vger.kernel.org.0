Return-Path: <dmaengine+bounces-7005-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D678C0DCC3
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 14:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 614603A75A5
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 12:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444B32C158D;
	Mon, 27 Oct 2025 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8WqVO9e"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1466F29A9FA;
	Mon, 27 Oct 2025 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569822; cv=none; b=kOzW6YV6TfQUPijZzakd8PeJNjZOFqoHJX8ycPEvBOEUvRQQTTqW3/Jh+7doOQOqvV0ogxxvGXCzQulburSiGde1PfnKw2zEd/QWstYNs7Q2lo0RAHHwp9bDB+6DrAjIbGxUTqbI9kEO+IBPoFaVw/xg93QN/8evrXAiAM0XmsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569822; c=relaxed/simple;
	bh=6zf3HJ4SFn/da8903S5Ji6WZxaAKcw0a+EFVvyPIafQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=riQ0Sr4cq27yRKY5mKDvphJ7qF3WVOzraP+BHmA6uq3oWn5YEOLzqqIs4y49ardhyjrw71wuLNsqtS/ZqiC1o1EPOAq2/0bUgPAgU6u0JOAs49gz+GZpNEDcpXvpSI6OeRqGyDjjZ9vvVcBu6Rgv7stNCf8hUKogIELK7QqDxOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8WqVO9e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0CBC4CEFF;
	Mon, 27 Oct 2025 12:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761569821;
	bh=6zf3HJ4SFn/da8903S5Ji6WZxaAKcw0a+EFVvyPIafQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d8WqVO9ewM2f4dpadJXwH1G+wsCxcKw+wOJe7fbd8xZMraDijIwwWQJwC0V9Go5Lh
	 4vK02KElzkfrDwK1vZhMHZ5llNawWQZumn5YFXJ4quAz4mBIgNF5zG4aTM/TQz4cXs
	 GUXF84eXaQVjeoWxqOW509eQtGbWJAhI3t1ow1bkZvCduTMC/wZRyo6Vc3bcDa7qPC
	 YJzJOQW280WqEtSGg5mYR8Yb7+1TRtAmOqZKZHXKU2TQyck8DwKpZz3RtITkg+ZY5C
	 ACYpBno32losPmltjPYDo+5no/FlkpPBRAvi5BVTXg4O8XfISPeOABN9teHdWiZ04Q
	 XCJEEeDHWJL6g==
Received: by wens.tw (Postfix, from userid 1000)
	id 933FB5FF71; Mon, 27 Oct 2025 20:56:57 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Mark Brown <broonie@kernel.org>,
	Vinod Koul <vkoul@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-sunxi@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 05/10] arm64: dts: allwinner: a523: Add DMA controller device nodes
Date: Mon, 27 Oct 2025 20:56:46 +0800
Message-ID: <20251027125655.793277-6-wens@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027125655.793277-1-wens@kernel.org>
References: <20251027125655.793277-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The A523 has two DMA controllers. Add device nodes for both. Also hook
up DMA for existing devices.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
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


