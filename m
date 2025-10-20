Return-Path: <dmaengine+bounces-6897-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22619BF2A2D
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 19:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55FE7461698
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 17:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5532C33344F;
	Mon, 20 Oct 2025 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFgPhNMI"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1821A33342E;
	Mon, 20 Oct 2025 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760980283; cv=none; b=upCGKA/uBNe+Hkv/mSOJakNv6+k6mqqNsDg6xZNKWe1C8qAU3W5AQsSRTb19pCWaPOgGIoaMpZAf4HwzWVTNL3+KyCSp7L6fvpc4mNxe1uUfxGD8mOomo2M++hWdKzCVlgyII+XZgdRnH8wODyepzBarQXQeToO/4/CnB+PcuCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760980283; c=relaxed/simple;
	bh=0ChEAhtAFbnQFbVJGkrrhKo/Uoy5YpaI4s6lIy/TvXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nn3cHSfr+HtPN6pjM2R5W0Gp1h4gPkmL/ooKhpgNr6lbnd2JRSEC6VXy3iaZkxIi7IJh2/OPVryhaR2zIaj2YA7gVQy+Aj1eBcndmj/aQYYR2XjX70IJB/g4UfEpDhPwQRmSrAm6BB+eUU2j+n6R1wuXY9RYpEpvV0m30SmarB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFgPhNMI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93322C4AF0F;
	Mon, 20 Oct 2025 17:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760980282;
	bh=0ChEAhtAFbnQFbVJGkrrhKo/Uoy5YpaI4s6lIy/TvXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QFgPhNMI2Jj90qwqd7mDU/ZGMu+ZjcHs5w0mLa+IsNtEgj0sgkZnwc4paZhm33RCU
	 1LptkaLyQRXZkSYB9tWLderYNPCpMIqHX/Ca4CEdsm33tL5utK7qMOZA+7gX5vHM9j
	 02O9+o9Olcw2OfJJsLClQ1mmOXwIdW//v02t0gaiaWWOu36vhXhPZfoAImpEDw2iKC
	 k84LiAP8JBU9+ocen1vnga+nSR8ELeXrvBFsPLT30hR5/g+w/HhSSJyniNHy1rlEO9
	 F44qxeo4PQAcV9RGRUpNv9fG+TDjXiAZCaKNWMDQp6+Z5pcyUOa59afKNKQTTLsKY9
	 sRSdJjineEy7A==
Received: by wens.tw (Postfix, from userid 1000)
	id 667A65FEEE; Tue, 21 Oct 2025 01:11:18 +0800 (CST)
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
Cc: linux-sunxi@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] arm64: dts: allwinner: a523: Add device node for SPDIF block
Date: Tue, 21 Oct 2025 01:10:54 +0800
Message-ID: <20251020171059.2786070-9-wens@kernel.org>
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

The A523 has a SPDIF interface that is capable of both playback and
capture.

Add a node for it.

Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
---
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index 8edbd3873199..33f991dbd00b 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
@@ -818,6 +818,21 @@ mcu_ccu: clock-controller@7102000 {
 			#reset-cells = <1>;
 		};
 
+		spdif: spdif@7116000 {
+			compatible = "allwinner,sun55i-a523-spdif";
+			reg = <0x07116000 0x400>;
+			interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mcu_ccu CLK_BUS_MCU_SPDIF>,
+				 <&mcu_ccu CLK_MCU_SPDIF_TX>,
+				 <&mcu_ccu CLK_MCU_SPDIF_RX>;
+			clock-names = "apb", "tx", "rx";
+			resets = <&mcu_ccu RST_BUS_MCU_SPDIF>;
+			dmas = <&mcu_dma 2>, <&mcu_dma 2>;
+			dma-names = "rx", "tx";
+			#sound-dai-cells = <0>;
+			status = "disabled";
+		};
+
 		mcu_dma: dma-controller@7121000 {
 			compatible = "allwinner,sun55i-a523-mcu-dma",
 				     "allwinner,sun50i-a100-dma";
-- 
2.47.3


