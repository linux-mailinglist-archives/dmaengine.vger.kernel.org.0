Return-Path: <dmaengine+bounces-796-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2500836E19
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 18:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A71D28BC54
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 17:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1345D8E9;
	Mon, 22 Jan 2024 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTjpP12a"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3FF5D8E1;
	Mon, 22 Jan 2024 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705943136; cv=none; b=O3O4RDiMbBNHdcLZMb28WxymhZ+zjcJPOntJ5OO8OdH7wxoGwfpAKz2+Mu66MjqHZdpT4kwdPCYfrv9yapWnTS49GGkm2KOEelNGQsvLl4/sGe1g3dExSvimxAuoQYTv7Ip1GrIukk5a6F9dlMG4ntyR7sOpDH9574/7x5ZXbaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705943136; c=relaxed/simple;
	bh=plCrDOFxd9CSFR2G/TaoQ8OuyVplm0yUrVWBFc9beG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S+Wm8JtsC7Lwiaylx39EaqLxQblhyJiYL7HlFTpXQum5SRONN9oUfE0mKLj3ZSTLERn6ESWP/8KnDRrRWEnDLSIF2IJOSVNKv59xlyqS1wHxqPI29svX2nLBsl4Q2/o/V9mRUqd7gD6+fe7KZ9/5L7F4WoVDEbcstYk2fACQucI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTjpP12a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65EEC43141;
	Mon, 22 Jan 2024 17:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705943136;
	bh=plCrDOFxd9CSFR2G/TaoQ8OuyVplm0yUrVWBFc9beG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eTjpP12aEqbpC9EDTaf7939XgV6o2gVZwL8479UFJS++dJR+QRuJOuFVsDUDiMrXm
	 kKg9rpEb/hkE2EGvRmNITTp21cA0j773Ordlv+twyUbNtPw02tlEMlT+kLqEotK3Ju
	 vWdaDowAOlZ8hUJWnEhVRKJZRFbp8QPFubGuiS6Ebbc36NR7uEfTTaEZrgaoIJH5vf
	 dPIbPww8ez+hibciUxiXaklYhdZnZhDM/39NmSSPNupPqxV4Gzfclp7fYOUECtHFcn
	 qFN7sVEmR6yjcH3vTvrWsL1e9nwto7Elo7K16BywguX097llP5TRrLyeou8fjzFNX9
	 PT4QACDWJPSOQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 2E367600FD; Tue, 23 Jan 2024 01:05:30 +0800 (CST)
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
Subject: [PATCH 7/7] arm64: dts: allwinner: h616: Add SPDIF device node
Date: Tue, 23 Jan 2024 01:05:18 +0800
Message-Id: <20240122170518.3090814-8-wens@kernel.org>
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

The H616 SoC has an SPDIF transmitter hardware block, which has the same
layout as the one in the H6, minus the receiver side.

Add a device node for it, and a default pinmux.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
index a0268439f3be..fd4c080b8e62 100644
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


