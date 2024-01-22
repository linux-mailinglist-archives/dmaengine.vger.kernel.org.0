Return-Path: <dmaengine+bounces-795-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811AE836E16
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 18:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64E01C2743F
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 17:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B94E5D729;
	Mon, 22 Jan 2024 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vP9acJoB"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7505C91D;
	Mon, 22 Jan 2024 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705943135; cv=none; b=XxEac0MWRzhKpPpXoV9lLm7x/ebi+EVHHPauF6W2gFqbAetsBmH1LV1yxz4yYiHjQQ3zoiHDCp9YLaVbot31T6aVXRFJ6wI0zsBf50FZJHCxtrm1a1q7mwHvtTbBoQZ7LyqeUQkjiPPfUWU1Q2VRedF1/YoQ+hAfmtMjlS1LCjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705943135; c=relaxed/simple;
	bh=sdP1r/VhAMaKVNqjhK+hZstufK/WpJeVtEdRqv6k0hU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a4hh6k4JdlrHGn+uvnuA8D01yE10oIxiT9+Kinsa8FyK48jLuPd85vZzLA6lQmviat6VD+/DGIepLLJpdLo+cs95rGtysgeJLVeXoguDlaHe4eJzzGS4MyvnWX9gl66zOGDVpFvaOnWiyuYfIs5pLld5U1x6UldPQn2LKxL/dpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vP9acJoB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53CDC43394;
	Mon, 22 Jan 2024 17:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705943134;
	bh=sdP1r/VhAMaKVNqjhK+hZstufK/WpJeVtEdRqv6k0hU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vP9acJoBknBHA3wKShNSxY5CetLpAoQM27SJUaeoHdIOzn8f1z+FdPdh3L6XsQQ3d
	 7yIrIs8QngJkdEH/0mlNLEvA1OHj0GvzC7j3z1a/7q9UPsIpyF/5/UllFwiFf2h3b6
	 BGb0RyFDiuDTl/A01CqkKCtCZSVSTThfEOpwegvtrSlWGK4yyjyQh7t7UrubuQczAx
	 eX0GF7KOYgj6kogV/8iYKY+rANrwG+rTe27Wwp1U1qu0nllvqTBskm4X0QabpKWPn7
	 J6dX3UNrpo028k7I0IUj8WoveB9423thrJYWxp6+l16DKWzPdgQzQMf3ImI5NxUSpl
	 3FnbmcglNJgVg==
Received: by wens.tw (Postfix, from userid 1000)
	id 1382D6002A; Tue, 23 Jan 2024 01:05:30 +0800 (CST)
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
Subject: [PATCH 5/7] arm64: dts: allwinner: h6: Add RX DMA channel for SPDIF
Date: Tue, 23 Jan 2024 01:05:16 +0800
Message-Id: <20240122170518.3090814-6-wens@kernel.org>
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

The SPDIF hardware found on the H6 supports both transmit and receive
functions. However it is missing the RX DMA channel.

Add the SPDIF hardware block's RX DMA channel. Also remove the
by-default pinmux, since the end device can choose to implement
either or both functionalities.

Fixes: f95b598df419 ("arm64: dts: allwinner: Add SPDIF node for Allwinner H6")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 2 ++
 arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi      | 2 ++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi            | 7 +++----
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 9ec49ac2f6fd..381d58cea092 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -291,6 +291,8 @@ sw {
 };
 
 &spdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spdif_tx_pin>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi
index 4903d6358112..855b7d43bc50 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi
@@ -166,6 +166,8 @@ &r_ir {
 };
 
 &spdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spdif_tx_pin>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index ca1d287a0a01..d11e5041bae9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -406,6 +406,7 @@ spi1_cs_pin: spi1-cs-pin {
 				function = "spi1";
 			};
 
+			/omit-if-no-ref/
 			spdif_tx_pin: spdif-tx-pin {
 				pins = "PH7";
 				function = "spdif";
@@ -655,10 +656,8 @@ spdif: spdif@5093000 {
 			clocks = <&ccu CLK_BUS_SPDIF>, <&ccu CLK_SPDIF>;
 			clock-names = "apb", "spdif";
 			resets = <&ccu RST_BUS_SPDIF>;
-			dmas = <&dma 2>;
-			dma-names = "tx";
-			pinctrl-names = "default";
-			pinctrl-0 = <&spdif_tx_pin>;
+			dmas = <&dma 2>, <&dma 2>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
-- 
2.39.2


