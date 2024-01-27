Return-Path: <dmaengine+bounces-836-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F5683EEB1
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jan 2024 17:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3971F2273C
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jan 2024 16:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFBE2E83F;
	Sat, 27 Jan 2024 16:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfxcEB/P"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7C22E635;
	Sat, 27 Jan 2024 16:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706373177; cv=none; b=ff30xOuK3T7GUzFFgQYaNEDqA991V/0tW+83nNDV/+kWrmz6rvHZE0sDiEdMt3FVjBr4gDTl/m2AT9tNFUIvtysti22HdMKhQNxjoQK6iK1g5TuRAsSRsMkDt76zDZV4zcHKX5dGDqLIERrxvMAtqcSa194joOWb4OkkK759rsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706373177; c=relaxed/simple;
	bh=eAd7srBbetTNuoTznQNyc5Zq6J7HU6wdNysZdYd3kxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=izvwT0QqnBRlWUkDSAi7PJsXCJ3EcnkJlpIkppSQsyjXqGI2EtjOGE/2n39fS9DiIVBJO4FEmkjofvmMEV4ZNP9KS/y4UD9HwFiVJ2/6+wXy14MXEMVkTlmKdpX9otYPgIotqK5Eiy16YlsdDnAM9OfdxMIaPzf/D43hLqRJjq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfxcEB/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300EBC32782;
	Sat, 27 Jan 2024 16:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706373177;
	bh=eAd7srBbetTNuoTznQNyc5Zq6J7HU6wdNysZdYd3kxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZfxcEB/PjxKgjc/wwsQqMoHdUsXoHcutXwR54Zz40tbIJXiovoDWfeN2uMIdDB59T
	 hM6+YDMoFZqvX6il/E5dr7lY6HkkXWdBiCpifCLQEUR5NwmlSdCKnzXY2qaJo/10sE
	 NtZu6vr8Lxl5EBkdeY3/XyYXBJX+3XDG0lR/cH1WhoneVu0SMDVZZh6qLSf9oq+6w3
	 GKjLZNe0SXeazRSN53MmOCtRbwLlr/q0iqSECdPaDJWIiqHFXX+cAPde9PawemAPgt
	 Bec634DL1z171RBlA2cLg4ECC8TEDIl+4khHl52kIHZ/Bgf+9Zzj4UDFcU8P/i06cO
	 HeusOAzAQND/g==
Received: by wens.tw (Postfix, from userid 1000)
	id 925475FEC6; Sun, 28 Jan 2024 00:32:52 +0800 (CST)
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
	linux-kernel@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v2 7/7] arm64: dts: allwinner: h616: Add SPDIF device node
Date: Sun, 28 Jan 2024 00:32:47 +0800
Message-Id: <20240127163247.384439-8-wens@kernel.org>
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

The H616 SoC has an SPDIF transmitter hardware block, which has the same
layout as the one in the H6, minus the receiver side.

Add a device node for it, and a default pinmux.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
index 885809137b9d..b1bf4fb5fc58 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
@@ -253,6 +253,11 @@ spi1_cs0_pin: spi1-cs0-pin {
 				function = "spi1";
 			};
 
+			spdif_tx_pin: spdif-tx-pin {
+				pins = "PH4";
+				function = "spdif";
+			};
+
 			uart0_ph_pins: uart0-ph-pins {
 				pins = "PH0", "PH1";
 				function = "uart0";
@@ -550,6 +555,21 @@ mdio0: mdio {
 			};
 		};
 
+		spdif: spdif@5093000 {
+			compatible = "allwinner,sun50i-h616-spdif";
+			reg = <0x05093000 0x400>;
+			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPDIF>, <&ccu CLK_SPDIF>;
+			clock-names = "apb", "spdif";
+			resets = <&ccu RST_BUS_SPDIF>;
+			dmas = <&dma 2>;
+			dma-names = "tx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&spdif_tx_pin>;
+			#sound-dai-cells = <0>;
+			status = "disabled";
+		};
+
 		usbotg: usb@5100000 {
 			compatible = "allwinner,sun50i-h616-musb",
 				     "allwinner,sun8i-h3-musb";
-- 
2.39.2


