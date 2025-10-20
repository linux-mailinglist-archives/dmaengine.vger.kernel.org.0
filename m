Return-Path: <dmaengine+bounces-6899-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E903FBF2A1E
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 19:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E81B84EDB32
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 17:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA1C33372B;
	Mon, 20 Oct 2025 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSEnPIoh"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34553333434;
	Mon, 20 Oct 2025 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760980283; cv=none; b=WsDRUfoHv/nO7ng7UiGTTIpqLo2KQOot0iGEcw66/2041+lmRDlEFbCQEauTqpYoUjR6tLMSB76m4xk0cgJqXxLt/POOGoNrpKp7oRC26LG5RlnXomWoBDS9UK6j6RwEBxxao7vpfOPi/vC162nyYDkz5I1Z3u9l9OHsh5zLh+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760980283; c=relaxed/simple;
	bh=DgO/6s23HKe1T0jTyCsYw+u/wOfS3lW2Y2hvszSMnJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lt4QU4v4tXglBZXdZusJlyyrZMbIYB16eiDLATfS7BzQhMRVWJAuaWLft90soCIro7yG93DT3c2f3tFwPSpilAklSW6NfwJoucEg7qs1b10xzp1b8mp2o3OhkBmEMWv/auMbRO/4tyek1FmLOLPB6KqvEwYQo8L2mhktqX6cRVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSEnPIoh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3C4C2BC86;
	Mon, 20 Oct 2025 17:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760980282;
	bh=DgO/6s23HKe1T0jTyCsYw+u/wOfS3lW2Y2hvszSMnJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QSEnPIohF37wfJmmGhUvzPGg+MuBGgtVAEMgt9nAUiAoBxrLCPMejbRItaDmliCiA
	 Q/7GkHNyA4K4CWwbFBBQYLDtY7jDfhUMI91zGcQTeDEMj0XA3B2L7+ul+lAcAVmw0i
	 jHgL8FolkHsEemQu+GNtvQGRtpgd0Vciwh4CAKFjoSwowjYpRbII7fxZgOTEry6WGd
	 ZX/qXI7nC/DUoU+oJjsHuCE1IRXAXZwQ+BlQF6W06Heny0x2fIqDuRojAOdlAXFNce
	 pJjf6FSzv6sRTA0uwKLeWbvPgh7AbqGYkEgQMDzncjxuo+meIf9DrNxFN5FOR9FZkb
	 6/Zc/BO4VKzbA==
Received: by wens.tw (Postfix, from userid 1000)
	id 7039A5FF03; Tue, 21 Oct 2025 01:11:18 +0800 (CST)
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
Subject: [PATCH 09/11] arm64: dts: allwinner: a523: Add device nodes for I2S controllers
Date: Tue, 21 Oct 2025 01:10:55 +0800
Message-ID: <20251020171059.2786070-10-wens@kernel.org>
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

The A523 family of SoCs have four I2S controllers capable of both
playback and capture. The user manual also implies that I2S2 also
outputs to the eDP interface controller.

Add device nodes for all of them.

Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
---
 .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index 33f991dbd00b..eea9ce83783c 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
@@ -818,6 +818,62 @@ mcu_ccu: clock-controller@7102000 {
 			#reset-cells = <1>;
 		};
 
+		i2s0: i2s@7112000 {
+			compatible = "allwinner,sun55i-a523-i2s",
+				     "allwinner,sun50i-r329-i2s";
+			reg = <0x07112000 0x1000>;
+			interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mcu_ccu CLK_BUS_MCU_I2S0>, <&mcu_ccu CLK_MCU_I2S0>;
+			clock-names = "apb", "mod";
+			resets = <&mcu_ccu RST_BUS_MCU_I2S0>;
+			dmas = <&mcu_dma 3>, <&mcu_dma 3>;
+			dma-names = "rx", "tx";
+			#sound-dai-cells = <0>;
+			status = "disabled";
+		};
+
+		i2s1: i2s@7113000 {
+			compatible = "allwinner,sun55i-a523-i2s",
+				     "allwinner,sun50i-r329-i2s";
+			reg = <0x07113000 0x1000>;
+			interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mcu_ccu CLK_BUS_MCU_I2S1>, <&mcu_ccu CLK_MCU_I2S1>;
+			clock-names = "apb", "mod";
+			resets = <&mcu_ccu RST_BUS_MCU_I2S1>;
+			dmas = <&mcu_dma 4>, <&mcu_dma 4>;
+			dma-names = "rx", "tx";
+			#sound-dai-cells = <0>;
+			status = "disabled";
+		};
+
+		i2s2: i2s@7114000 {
+			compatible = "allwinner,sun55i-a523-i2s",
+				     "allwinner,sun50i-r329-i2s";
+			reg = <0x07114000 0x1000>;
+			interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mcu_ccu CLK_BUS_MCU_I2S2>, <&mcu_ccu CLK_MCU_I2S2>;
+			clock-names = "apb", "mod";
+			resets = <&mcu_ccu RST_BUS_MCU_I2S2>;
+			dmas = <&mcu_dma 5>, <&mcu_dma 5>;
+			dma-names = "rx", "tx";
+			#sound-dai-cells = <0>;
+			status = "disabled";
+		};
+
+		i2s3: i2s@7115000 {
+			compatible = "allwinner,sun55i-a523-i2s",
+				     "allwinner,sun50i-r329-i2s";
+			reg = <0x07115000 0x1000>;
+			interrupts = <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mcu_ccu CLK_BUS_MCU_I2S3>, <&mcu_ccu CLK_MCU_I2S3>;
+			clock-names = "apb", "mod";
+			resets = <&mcu_ccu RST_BUS_MCU_I2S3>;
+			dmas = <&mcu_dma 6>, <&mcu_dma 6>;
+			dma-names = "rx", "tx";
+			#sound-dai-cells = <0>;
+			status = "disabled";
+		};
+
 		spdif: spdif@7116000 {
 			compatible = "allwinner,sun55i-a523-spdif";
 			reg = <0x07116000 0x400>;
-- 
2.47.3


