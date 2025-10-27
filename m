Return-Path: <dmaengine+bounces-7008-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3DDC0DE22
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 14:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C56D4FC1E8
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 12:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934A22D8777;
	Mon, 27 Oct 2025 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEiCOsgU"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD482C326A;
	Mon, 27 Oct 2025 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569822; cv=none; b=ii8qNEDhHdR1mEZqWgVncTPcjr29o5IeyvCdOOuek9hDVYYlMtNoEHlPxOmJnY+ZscdyVbTjQ5wiiovgZDjYJC4O8gIFkCZ85KITcQCjDfFLUgfK5RO6Efr1fxjb6AtKXAkukV/QndRt7EA/eKiMStRt+2Zf8tJRyXgDlXABJwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569822; c=relaxed/simple;
	bh=gr1lBgtAFiXlQWjgkAnVsdgPcHRamw/CNfsD0rtnh5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNmIFEWovjfQFVu3iMyfdtrlfNPezF8ZuGPfvoT6DdYMm/P5TeMVnrQGMR5S3mnnzaUtPLVKaRYoZ5Fct2SGMtJ+S39KneBAmAFkULLz6Sz2jpzPeLnswEkoB6ehB4mEvEKPH6oQWBgx5HwbI1FwUXFUhwuw3leq8DTfsoaqPMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEiCOsgU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF72CC116B1;
	Mon, 27 Oct 2025 12:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761569821;
	bh=gr1lBgtAFiXlQWjgkAnVsdgPcHRamw/CNfsD0rtnh5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FEiCOsgUv6Y+W2ZHZvg2uRCOCghvJLo7bsCubi8TrN7K/i8O7GiaxTwHnKXF2ZFwL
	 9KsRERyjTwn2iB2n9F73IVNzvVLSmuKM41PM/ej/mrYyzwnx0FmVNQCqhJ4HoZQr4L
	 pgp1Sm27R7H4cqk6/AZx1lL7JdlwiRSVOwYsXejHua/f3JIuUN5UXHcX81LKy10ReH
	 Wx2qdMP7d0ybfH25AkiV57SVcuzt/YHuzMdnc1mHDvpBkecvc2ld0gf4ykSVsCO4sK
	 ZASilZoS8x7z9Ta6RhTQp4WxEsi5dCt8rFuOWbaUxBgWsxb6dwp/J0Y3idVUndU+WG
	 Up3tiKzh00n+A==
Received: by wens.tw (Postfix, from userid 1000)
	id A234B5FF76; Mon, 27 Oct 2025 20:56:57 +0800 (CST)
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
Subject: [PATCH v2 07/10] arm64: dts: allwinner: a523: Add device nodes for I2S controllers
Date: Mon, 27 Oct 2025 20:56:48 +0800
Message-ID: <20251027125655.793277-8-wens@kernel.org>
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

The A523 family of SoCs have four I2S controllers capable of both
playback and capture. The user manual also implies that I2S2 also
outputs to the eDP interface controller.

Add device nodes for all of them.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
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


