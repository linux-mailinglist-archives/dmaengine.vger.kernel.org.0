Return-Path: <dmaengine+bounces-7006-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A96FFC0DD32
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 14:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BFA5B4FFE39
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 12:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC952C325A;
	Mon, 27 Oct 2025 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYW1H6mW"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145E029A9CD;
	Mon, 27 Oct 2025 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569822; cv=none; b=hWqIvryLqMaXcqKuI3KYeizJ0HhbLTOskGdNPpZ9w6XN4bKGO6+r83/gD/mJEYpx9JRqsTWcbjBXc7Vhh8dXF+oOZp4xaPPhl5Asx0GORTl7W7lJXa+qpl9i77VlkEtP8t/GUlyOgh+ZkNdnue57qF9vEO22sAqYht4Uwh1/J2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569822; c=relaxed/simple;
	bh=cH78ltGLFEwaRc+5sKH7tOpj/oTnWSF/SJD99Q8jJBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qRLsQFKCH1P5uKb1wLrTQ4q3eZbEj7t3FO/TwBzjgstlMYVUek/x5+yIM0f0kq5rPUkqJuzuQQFEsf6D+c6xRl+2xtZ4/14oyic5JwT5aH6Kyl979ylYoBbLyGE3ESekicXaWhnjJ0IhmzX2Zvih5APFxmaeqJKW/ncQFZbwlYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYW1H6mW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882A6C116C6;
	Mon, 27 Oct 2025 12:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761569821;
	bh=cH78ltGLFEwaRc+5sKH7tOpj/oTnWSF/SJD99Q8jJBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HYW1H6mW7jSbquUJYM2sqUZm38jlpvEbmqNe+my2P3ZAWIGYTjTFCpgEHS9+DemLl
	 eiO701QwLGQZgcMjyENFmnzaX2DuPiLvU5f5S/jqK5yBncWj4TKpenGg8zLXyON90Y
	 j6WeTmxg2pTIY5KKnWtWeu1rAR4H55dta7wG/l5kE40i6Xb04Dh+GKUL4az1eKLoKh
	 iSEB1tkqrY/0I68cXpJeU3s2Gjcu7+Es7P8ZDN8ZffBEzYAw5bxNuFlyXZeevVrDfm
	 DTUW0B2pCZjZ+0njaESUw78t9iIW5e9nfbHIiMJdYb2oZqLnQNfBzU91eQYD1YFgfC
	 wVoUJoR+eJlIg==
Received: by wens.tw (Postfix, from userid 1000)
	id A9CF25FF8E; Mon, 27 Oct 2025 20:56:57 +0800 (CST)
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
Subject: [PATCH v2 08/10] arm64: dts: allwinner: a523: Add I2S2 pins on PI pin group
Date: Mon, 27 Oct 2025 20:56:49 +0800
Message-ID: <20251027125655.793277-9-wens@kernel.org>
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

The Radxa Cubie A5E exposes I2S2 through the PI pin group on the 40-pin
GPIO header.

Add a pinmux setting for it so potential users can directly reference
it.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
---
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index eea9ce83783c..cebd8e16e845 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
@@ -145,6 +145,14 @@ pio: pinctrl@2000000 {
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
+			/omit-if-no-ref/
+			i2s2_pi_pins: i2s2-pi-pins {
+				pins = "PI2", "PI3", "PI4", "PI5";
+				allwinner,pinmux = <5>;
+				function = "i2s2";
+				bias-disable;
+			};
+
 			mmc0_pins: mmc0-pins {
 				pins = "PF0" ,"PF1", "PF2", "PF3", "PF4", "PF5";
 				allwinner,pinmux = <2>;
-- 
2.47.3


