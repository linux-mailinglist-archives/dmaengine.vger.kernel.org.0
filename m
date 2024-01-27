Return-Path: <dmaengine+bounces-834-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0084983EEAD
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jan 2024 17:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8F7D1F22794
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jan 2024 16:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904AA2E644;
	Sat, 27 Jan 2024 16:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6f72xPR"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631DD2E62E;
	Sat, 27 Jan 2024 16:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706373177; cv=none; b=P0itoltflBrf9/qtZm9oQ2pfQPtY0KuEetxq3d8E453ixUCTAO2BDaNgactZ9SJ+NO6TSh16Z5I4Yh8c1LzZ2fclSFc6tWCqTDQ5RlPlTlYWmLwYBrv5UodSnnv7c5Abu6FzvNF2H3PXUrHJ0YV8TI6RrrcdGLEZgQBPJqSTkP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706373177; c=relaxed/simple;
	bh=WOUqb67kFNowd66WvLyJkFViYo3BarKcvhbuq1ivPvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YHwl36dqNS7qqIgu3wsLIAVkPfhSk/MryH4qr6aCt7ObKwiz6sUOjKEH0eWw16/QQtfYfBn5JlDJvxCNK68RdJZ+Fqw7xmemn6IGaXaO/ev4FRlyxUQp5x4xtibxA9QqocHwBsNQlfv3PVGUElrFTz94i/zkt6497zH671OyWNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6f72xPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5B4C43330;
	Sat, 27 Jan 2024 16:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706373177;
	bh=WOUqb67kFNowd66WvLyJkFViYo3BarKcvhbuq1ivPvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H6f72xPRi0Dz/4aTk0M8NlzZl45rEQCYBvPGz7KEBrnFVNqcWpvST8O0iC1HrVCEg
	 /aFV1BPgXYX3ME/N2jN0HXFF9uL81kg3c6Fw0G70LmHOp8CEe7wWsf4v7c+IL0kZ4N
	 IuF23IrccqrDX5y8i385BX3IcelHacJdFHjiBsoP8IjctcQdEMp7WyyQ4hYCKIy/J1
	 9FYMdUldFxR21IMLv7QkfjRFgvzZAdXl5VRAruktMRFeB+B1myXfP6WKCVnVE8H9Kb
	 i+gVwx5DRmzuGPCMf/Ku66qUDbPRKdKZDTezgpmaMR2ELMdDoVXGHcYKzzsRHnoQO/
	 D7Ji4MjvGRyUw==
Received: by wens.tw (Postfix, from userid 1000)
	id 7AB825FE36; Sun, 28 Jan 2024 00:32:52 +0800 (CST)
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
Subject: [PATCH v2 5/7] arm64: dts: allwinner: h6: Add RX DMA channel for SPDIF
Date: Sun, 28 Jan 2024 00:32:45 +0800
Message-Id: <20240127163247.384439-6-wens@kernel.org>
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

The SPDIF hardware found on the H6 supports both transmit and receive
functions. However it is missing the RX DMA channel.

Add the SPDIF hardware block's RX DMA channel. Also remove the
by-default pinmux, since the end device can choose to implement
either or both functionalities.

Fixes: f95b598df419 ("arm64: dts: allwinner: Add SPDIF node for Allwinner H6")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
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


