Return-Path: <dmaengine+bounces-7004-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BC8C0DCC6
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 14:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3611C3B74F1
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 12:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434922BE64A;
	Mon, 27 Oct 2025 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mqs824nK"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14519299948;
	Mon, 27 Oct 2025 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569822; cv=none; b=dIXWLzwdI6IjBFct+PQIOwXZFk9PqLUMQ4yzfY+474myOkJahamHgmK4dCwACrvEwcy8x8CIycIL+0yyqbFmGVVdhipP8f6Tfmwe2wN1fbcTEAOK8mJHqxGsq2D6udG2LGsaL4v6JwLP9q2VfGm7dq96RU/UVedc3uVZrt+JTHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569822; c=relaxed/simple;
	bh=f0SoP/zvRQAOERqGrbZ2nIh2yRiuv79vNh/YNhiYisw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IrY1LlEVXyPDHBMwOqqDWyIbX+niV9rynaAXthkH+jI/2nv0WNrgQuOIcGlwdQ2vMs7Dd2xQh/Do0UpxJdtE2q/zUlXBOnMdBV2of5BISwYMtUj5nASV5LS+dlZav1cuzSg4+avFK1m4Csoacf4SEFjcPs1dwmhnifzZtjxe3UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mqs824nK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8501BC113D0;
	Mon, 27 Oct 2025 12:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761569821;
	bh=f0SoP/zvRQAOERqGrbZ2nIh2yRiuv79vNh/YNhiYisw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mqs824nK/IIPtizqFpAnhI2rX4aRkfAg+jwVA5oVxmxbdQClrPE7CszShxsjr6iyq
	 mgxON4vZ4z+8asFVhBA1/vTHiHZVoQKfW4Gg6yIicdXWCRcUDfKfQrN5Y/7uT+jRRH
	 0d+3tk6ASvDZs/1+UjUZ9H6wZFQ6d7+0AkcuSDBOzciTavPewMZU/s8NZGjETwOvBe
	 vjPmZFvYXndf/vXJooLdmIjEx09dZtwknBp+gI06mVbEBlLcM+AejPQoXxcLnD0X0E
	 e7bCocBVhxFuAJpGCioLwPnYIXYeMsVZCSWENqXE4FH2uUdnWfYwfuHYfXICYHYDrM
	 dyupOIZ8E8PQg==
Received: by wens.tw (Postfix, from userid 1000)
	id 9AF925FF56; Mon, 27 Oct 2025 20:56:57 +0800 (CST)
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
Subject: [PATCH v2 06/10] arm64: dts: allwinner: a523: Add device node for SPDIF block
Date: Mon, 27 Oct 2025 20:56:47 +0800
Message-ID: <20251027125655.793277-7-wens@kernel.org>
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

The A523 has a SPDIF interface that is capable of both playback and
capture.

Add a node for it.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
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


