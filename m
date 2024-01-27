Return-Path: <dmaengine+bounces-835-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C4183EEB0
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jan 2024 17:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E8A28344D
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jan 2024 16:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911DB2E64B;
	Sat, 27 Jan 2024 16:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNrGbLX7"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631FC2E62F;
	Sat, 27 Jan 2024 16:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706373177; cv=none; b=ROPxVFU7/+ZSBAdJXmG2Zmbxb31HSbXnroP8/CsWLXFgpgkcJdErxMJCPGRTi54BOX1adzZQhWjbMA/oM18a31JzsKgYB/buvcAog8sglNWXDTlWRFQ9MD0X+A5XBhay54uFCx2vOQNUy6hRHPY/TVGtIkU3Uq2Ll7S1Pzu63kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706373177; c=relaxed/simple;
	bh=zQfoZw8TAHIXjSz0P9ay/fYjypHtOoMzHr8C8vMyAuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YVJxBA+7Hj81kdrBp0l6K1Y54KnkopxOdi7xpQ9POZyH9CNSRAS3WbcGhHTis3qBwKKpy2JltUcXaO92U3oQacArsy7VSinNlIuyAQh/rV4ni8QgnVVlzSoI3GP0bAHn3SAd75k4QSFPCbJoH6kh1F7LaBkez+hjYhAq+/+V1ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNrGbLX7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6EA4C4166D;
	Sat, 27 Jan 2024 16:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706373177;
	bh=zQfoZw8TAHIXjSz0P9ay/fYjypHtOoMzHr8C8vMyAuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DNrGbLX7VsycQLHZKhmkPyj+vrvcC0UogDZv0KRWqDXAWmjK7oRdOwxiZAZT7oVUk
	 0D6r/bDML/Qz2U1pevBmozEb34cueyQtPa2AhS+mtfFq/803/9jqIALT3qHYuNArd6
	 aJJerssO39mcF9i1uBRGPhxqXydfQ3Y7Tu0+tLU9lqWIMvYOgw41lcsEfYkcqzHrDe
	 JaEGxxlS+Ux1m1spm3v78yIL+WAUnCcRj7DbbYS5VGctynuvhYMYaueWKU6kZyJQVa
	 YwGYFOcX1bInx7ss6wnt8Yrbci22rvQONZ8jXClQx4Kp/9gzWbfHOn4mVoDtzqsv3r
	 Re/ogS+EAvXnw==
Received: by wens.tw (Postfix, from userid 1000)
	id 85B4F5FF9C; Sun, 28 Jan 2024 00:32:52 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-sound@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] arm64: dts: allwinner: h616: Add DMA controller and DMA channels
Date: Sun, 28 Jan 2024 00:32:46 +0800
Message-Id: <20240127163247.384439-7-wens@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240127163247.384439-1-wens@kernel.org>
References: <20240127163247.384439-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

The DMA controllers found on the H616 and H618 are the same as the one
found on the A100. The only difference is the DMA endpoint (DRQ) layout.

Add a device node for it, and add DMA channels for existing peripherals.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Changes since v1:
- Fall back to A100 instead of H6
- Add DMA channels for r_i2c

 .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
index d549d277d972..885809137b9d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
@@ -133,6 +133,19 @@ ccu: clock@3001000 {
 			#reset-cells = <1>;
 		};
 
+		dma: dma-controller@3002000 {
+			compatible = "allwinner,sun50i-h616-dma",
+				     "allwinner,sun50i-a100-dma";
+			reg = <0x03002000 0x1000>;
+			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_DMA>, <&ccu CLK_MBUS_DMA>;
+			clock-names = "bus", "mbus";
+			dma-channels = <16>;
+			dma-requests = <49>;
+			resets = <&ccu RST_BUS_DMA>;
+			#dma-cells = <1>;
+		};
+
 		sid: efuse@3006000 {
 			compatible = "allwinner,sun50i-h616-sid", "allwinner,sun50i-a64-sid";
 			reg = <0x03006000 0x1000>;
@@ -339,6 +352,8 @@ uart0: serial@5000000 {
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&ccu CLK_BUS_UART0>;
+			dmas = <&dma 14>, <&dma 14>;
+			dma-names = "tx", "rx";
 			resets = <&ccu RST_BUS_UART0>;
 			status = "disabled";
 		};
@@ -350,6 +365,8 @@ uart1: serial@5000400 {
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&ccu CLK_BUS_UART1>;
+			dmas = <&dma 15>, <&dma 15>;
+			dma-names = "tx", "rx";
 			resets = <&ccu RST_BUS_UART1>;
 			status = "disabled";
 		};
@@ -361,6 +378,8 @@ uart2: serial@5000800 {
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&ccu CLK_BUS_UART2>;
+			dmas = <&dma 16>, <&dma 16>;
+			dma-names = "tx", "rx";
 			resets = <&ccu RST_BUS_UART2>;
 			status = "disabled";
 		};
@@ -372,6 +391,8 @@ uart3: serial@5000c00 {
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&ccu CLK_BUS_UART3>;
+			dmas = <&dma 17>, <&dma 17>;
+			dma-names = "tx", "rx";
 			resets = <&ccu RST_BUS_UART3>;
 			status = "disabled";
 		};
@@ -383,6 +404,8 @@ uart4: serial@5001000 {
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&ccu CLK_BUS_UART4>;
+			dmas = <&dma 18>, <&dma 18>;
+			dma-names = "tx", "rx";
 			resets = <&ccu RST_BUS_UART4>;
 			status = "disabled";
 		};
@@ -394,6 +417,8 @@ uart5: serial@5001400 {
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&ccu CLK_BUS_UART5>;
+			dmas = <&dma 19>, <&dma 19>;
+			dma-names = "tx", "rx";
 			resets = <&ccu RST_BUS_UART5>;
 			status = "disabled";
 		};
@@ -405,6 +430,8 @@ i2c0: i2c@5002000 {
 			reg = <0x05002000 0x400>;
 			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_I2C0>;
+			dmas = <&dma 43>, <&dma 43>;
+			dma-names = "rx", "tx";
 			resets = <&ccu RST_BUS_I2C0>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c0_pins>;
@@ -420,6 +447,8 @@ i2c1: i2c@5002400 {
 			reg = <0x05002400 0x400>;
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_I2C1>;
+			dmas = <&dma 44>, <&dma 44>;
+			dma-names = "rx", "tx";
 			resets = <&ccu RST_BUS_I2C1>;
 			status = "disabled";
 			#address-cells = <1>;
@@ -433,6 +462,8 @@ i2c2: i2c@5002800 {
 			reg = <0x05002800 0x400>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_I2C2>;
+			dmas = <&dma 45>, <&dma 45>;
+			dma-names = "rx", "tx";
 			resets = <&ccu RST_BUS_I2C2>;
 			status = "disabled";
 			#address-cells = <1>;
@@ -446,6 +477,8 @@ i2c3: i2c@5002c00 {
 			reg = <0x05002c00 0x400>;
 			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_I2C3>;
+			dmas = <&dma 46>, <&dma 46>;
+			dma-names = "rx", "tx";
 			resets = <&ccu RST_BUS_I2C3>;
 			status = "disabled";
 			#address-cells = <1>;
@@ -459,6 +492,8 @@ i2c4: i2c@5003000 {
 			reg = <0x05003000 0x400>;
 			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_I2C4>;
+			dmas = <&dma 47>, <&dma 47>;
+			dma-names = "rx", "tx";
 			resets = <&ccu RST_BUS_I2C4>;
 			status = "disabled";
 			#address-cells = <1>;
@@ -472,6 +507,8 @@ spi0: spi@5010000 {
 			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
 			clock-names = "ahb", "mod";
+			dmas = <&dma 22>, <&dma 22>;
+			dma-names = "rx", "tx";
 			resets = <&ccu RST_BUS_SPI0>;
 			status = "disabled";
 			#address-cells = <1>;
@@ -485,6 +522,8 @@ spi1: spi@5011000 {
 			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_SPI1>, <&ccu CLK_SPI1>;
 			clock-names = "ahb", "mod";
+			dmas = <&dma 23>, <&dma 23>;
+			dma-names = "rx", "tx";
 			resets = <&ccu RST_BUS_SPI1>;
 			status = "disabled";
 			#address-cells = <1>;
@@ -734,6 +773,8 @@ r_i2c: i2c@7081400 {
 			reg = <0x07081400 0x400>;
 			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&r_ccu CLK_R_APB2_I2C>;
+			dmas = <&dma 48>, <&dma 48>;
+			dma-names = "rx", "tx";
 			resets = <&r_ccu RST_R_APB2_I2C>;
 			status = "disabled";
 			#address-cells = <1>;
-- 
2.39.2


