Return-Path: <dmaengine+bounces-794-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD714836E15
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 18:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22021C274B1
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 17:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954025D727;
	Mon, 22 Jan 2024 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rB29qSMA"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D015C918;
	Mon, 22 Jan 2024 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705943135; cv=none; b=tapLr0xcazgzPyhY8dO8azHyXdJeq0LerZYnf5dzEYmVIGc25yQD/yG74JTm3OGBbB45U61RLAv7lfSzs8pUDLSQApZFAAnyxxss44lBudsrDq97iyqPrPerGPk65MdJIMto6lngrcN+Sy+hdrHSwCqH1m3+aJnrBBPq8sryYhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705943135; c=relaxed/simple;
	bh=aUTMYzjs78uYTiEQAgGmOm7LBsj4lDRYJ/Ilq8T3RhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qxKYmURhEZLnEpg/ZkAXz/n+yEZUNmtbT1scjwEMFhuPSPjZ2m1ODp7llZHYJQYhiHN4n900bTs2lmNErtoa4K2D23GNTj8hgAzgoQKTWvNtowToVJMBj8jF5QHQRkQnIY8HoHsRplBlrl4PnEIqMIvFn+ZboOmpUiLAamWTnwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rB29qSMA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F92C43601;
	Mon, 22 Jan 2024 17:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705943135;
	bh=aUTMYzjs78uYTiEQAgGmOm7LBsj4lDRYJ/Ilq8T3RhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rB29qSMAhfPSXzKG1+4qWSzciEb+EdBeCnD9CUDsyTaFZmnR6srgzEqZXVe58s/CY
	 eQw60vlZoD+EZt5SLzvsiZfkZ8svf6WH4CedqO448K2gJNwcxtYP0U01Ecqm3uC5nN
	 eItWsVbDULugmrunkBcbqsiAegL3laJg6Z5395omqJ3j2Nk4HFWehA7es/d8m93dn5
	 ztYIfgYYZ/DekH5rIgMHlMUXjvDASwiHy06I3HtY+QTpPHY33yC28mrJytg64uEdpE
	 oyPhSEDTzqKExBUlBJvn1QvbmH354riPLnwdO5vbGRYGJOCowNq6x4Clq8g5PpJDQI
	 1BmYN0KhW+CuQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 20624600A4; Tue, 23 Jan 2024 01:05:30 +0800 (CST)
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
Subject: [PATCH 6/7] arm64: dts: allwinner: h616: Add DMA controller and DMA channels
Date: Tue, 23 Jan 2024 01:05:17 +0800
Message-Id: <20240122170518.3090814-7-wens@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240122170518.3090814-1-wens@kernel.org>
References: <20240122170518.3090814-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

The DMA controllers found on the H616 and H618 are the same as the one
found on the H6. The only difference is the DMA endpoint (DRQ) layout.

Add a device node for it, and add DMA channels for existing peripherals.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
index d549d277d972..a0268439f3be 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
@@ -133,6 +133,19 @@ ccu: clock@3001000 {
 			#reset-cells = <1>;
 		};
 
+		dma: dma-controller@3002000 {
+			compatible = "allwinner,sun50i-h616-dma",
+				     "allwinner,sun50i-h6-dma";
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
-- 
2.39.2


