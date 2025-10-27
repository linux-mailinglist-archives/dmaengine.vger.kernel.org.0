Return-Path: <dmaengine+bounces-7009-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3033BC0DD26
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 14:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6313A504345
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 12:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9202DCF43;
	Mon, 27 Oct 2025 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AytX+UM2"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9945F2D8792;
	Mon, 27 Oct 2025 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569822; cv=none; b=m1WqNcEgYFGubV3Jt5Enoq01mFVfEq2szRj1uFVCM7PfJhKTzTwfFmKkYWrEeJg5HO8MNfB78u44FwYMcsJYSLn5a4pURd5ckumazRDSafHHebiY1H2KZaQFHMeoNHiW8qkdMHgO7AJJlfb0tVoEzCpxolFXvU9MHgCeTAtcbi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569822; c=relaxed/simple;
	bh=7WylpHCfl5v2xSL09jxwrG9Ik/L6u+sN2kDjKM+sdbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sPplHthEXJKouMLRFkFj1H0ofXkGUpjNNC/Pzn9TRtlqic38iKEOPf+PzYDJUD9FYWOmQAR5mr0d2YvlWbaETMWNIrk+h6cZnhJncnw+9pWl3JkMTzV5fkFU8xKgNxSyKqgjLCRwHqAwEEg70h3YWa/3tApJlOKc7wygHb3wpcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AytX+UM2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1EFC2BC87;
	Mon, 27 Oct 2025 12:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761569822;
	bh=7WylpHCfl5v2xSL09jxwrG9Ik/L6u+sN2kDjKM+sdbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AytX+UM2VJpPevBJmVH1Guw+dpV6MPA9jbKvvQQHiS7kw9AfqGTx0FrICPKUZUkXe
	 6e4CkYRLhzVMvy9sfDOv4HX/uKFcb2Xhp8o3JgnjwFvQbtA0Cw+EzT64dtVckmdoFz
	 6asLarvlAUHXRrNNH4kghjBNEsz1CdIdiLz9bhFE8+cyEPA3z3C+C9omB/nvfR6C2R
	 GLLFeU4geEafPxvRycr9XsIIfF6i4j2bCzOclYbNvEb0XEmyTJ6R4py5QrsHBDFZeJ
	 btAiPlc5igKle+32Ffzt5Se1r0B2XjcnRSvWzPd+xuKic36v1TwvSYeduYk3jdLebl
	 2Q73IV9Kql5Fw==
Received: by wens.tw (Postfix, from userid 1000)
	id C5E7E5FFAB; Mon, 27 Oct 2025 20:56:57 +0800 (CST)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/10] [EXAMPLE] arm64: dts: allwinner: a527-cubie-a5e: Enable I2S and SPDIF output
Date: Mon, 27 Oct 2025 20:56:51 +0800
Message-ID: <20251027125655.793277-11-wens@kernel.org>
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

This is an example change.

The Radxa Cubie A5E exposes I2S2 and SPDIF on the 40-pin header. Enable
both.

In this example, I2S2 is connected to adafruit speaker bonnet, which
sports a pair of MAX98357A for speaker amplication. SPDIF is connected
to a SPDIF interface card for PCs, which has both coaxial and optical
outputs. The output was connected via optical cable to a dumb SPDIF to
analog audio converter.

Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
---
 .../dts/allwinner/sun55i-a527-cubie-a5e.dts   | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts b/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
index bfdf1728cd14..828d101d28e8 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
@@ -64,6 +64,46 @@ reg_usb_vbus: vbus {
 		gpio = <&r_pio 0 8 GPIO_ACTIVE_HIGH>;	/* PL8 */
 		enable-active-high;
 	};
+
+	codec: audio-codec {
+		compatible = "maxim,max98360a";
+		#sound-dai-cells = <0>;
+	};
+
+	sound-i2s {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "I2S";
+		simple-audio-card,format = "left_j";
+		simple-audio-card,bitclock-master = <&dailink_cpu>;
+		simple-audio-card,frame-master = <&dailink_cpu>;
+		simple-audio-card,mclk-fs = <128>;
+
+		dailink_cpu: simple-audio-card,cpu {
+			sound-dai = <&i2s2>;
+		};
+
+		dailink0_master: simple-audio-card,codec {
+			sound-dai = <&codec>;
+		};
+	};
+
+	sound-spdif {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "spdif-out";
+
+		simple-audio-card,cpu {
+			sound-dai = <&spdif>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&spdif_out>;
+		};
+	};
+
+	spdif_out: spdif-out {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+	};
 };
 
 &ehci0 {
@@ -101,6 +141,12 @@ &gpu {
 	status = "okay";
 };
 
+&i2s2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2s2_pi_pins>;
+	status = "okay";
+};
+
 &mdio0 {
 	ext_rgmii0_phy: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
@@ -344,6 +390,12 @@ &r_pio {
 	vcc-pm-supply = <&reg_aldo3>;
 };
 
+&spdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spdif_out_pi_pin>;
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
-- 
2.47.3


