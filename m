Return-Path: <dmaengine+bounces-7007-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D9BC0DC9F
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 14:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4A719C1EC5
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 13:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920692D876C;
	Mon, 27 Oct 2025 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qg0MZF86"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDB22C375E;
	Mon, 27 Oct 2025 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569822; cv=none; b=uCvZ2cVffR1dHr3xTGrQo7XFHV9dssYK6bDc3ou8nQHj0WG0i3DyohZx4yiV4JLBsKUXuGYJA67xZZDkjbzZcw8y18oElJytlmIQIMWWGKJXxtLtLiZp0mC3xT70TzSDqH51mzAz1Q/k258PyYlkdV3BUL1uSrEi0oh9xjV3E7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569822; c=relaxed/simple;
	bh=ojezu/Uo+J/jAdJIMpppL/LYPdk+yEgDql0KTa8tpLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcoPBIm/908P2SI5lA+AYcAhmEdfvf9LxoTaJPeEH9FgFnb9o+SBAHCNx3LJnosSE96sbLGDt5f4P9Nr3cDU30Bd+4GRfOFBe2hZOqrq5CUYUOwZ6UTdDCcopn5jAMew3vh7X9+jn3TSUlGS66oY3Djxy6bglM67FjDCBofM+Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qg0MZF86; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE238C2BCAF;
	Mon, 27 Oct 2025 12:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761569822;
	bh=ojezu/Uo+J/jAdJIMpppL/LYPdk+yEgDql0KTa8tpLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qg0MZF86i4vHoRckQjlkDFV5bPrs3QDJSL2A9/3OY1IGg5jIiM9/gdlkeXeNcL3Rl
	 mQOl8sNE44ENaSnQYXf7Z2OLHb21+6XH7Y3Gnb73lPdKC5Ls18135AKkstxdUh2wjZ
	 FBX9vwtDrO5bCWnFOqhoekD4k2PIgQjENgtiSpFlnUQHqJ78L8sOeoZwryi2jiAbLX
	 iwCaLAPPKT7jTzkv/Xa0cygTc3lAQ8FHPMCcwD4R3k0NXJxw7igG9OVoJ3MS3Pqs0h
	 fk6EBlAhndWAy0Ug3f11LupepS9nQFX9S0tsq9PrObIKXrjVq8idNusltjb4xnwrUN
	 xtgNDCwMI/FKw==
Received: by wens.tw (Postfix, from userid 1000)
	id BBDE85FFCF; Mon, 27 Oct 2025 20:56:57 +0800 (CST)
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
Subject: [PATCH v2 09/10] arm64: dts: allwinner: a523: Add SPDIF TX pin on PB and PI pins
Date: Mon, 27 Oct 2025 20:56:50 +0800
Message-ID: <20251027125655.793277-10-wens@kernel.org>
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

The SPDIF TX (called OWA OUT in the datasheet) is available on three
pins. Of those, the PH pin is unlikely to be used since it conflicts
with the first Ethernet controller.

The Radxa Cubie A5E exposes SPDIF TX through the PI pin group on the
40-pin GPIO header.

The Orange Pi 4A exposes SPDIF TX through both the PB and PI pin
groups on the 40-pin GPIO header. The PB pin alternatively would be
used for I2S0 though.

Add pinmux settings for both options so potential users can directly
reference either one.

Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
---
Changes since v1:
- New patch; missing from v1 causing dts to not compile
---
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index cebd8e16e845..42dab01e3f56 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
@@ -200,6 +200,20 @@ rgmii1_pins: rgmii1-pins {
 				bias-disable;
 			};
 
+			/omit-if-no-ref/
+			spdif_out_pb_pin: spdif-pb-pin {
+				pins = "PB8";
+				function = "spdif";
+				allwinner,pinmux = <2>;
+			};
+
+			/omit-if-no-ref/
+			spdif_out_pi_pin: spdif-pi-pin {
+				pins = "PI10";
+				function = "spdif";
+				allwinner,pinmux = <2>;
+			};
+
 			uart0_pb_pins: uart0-pb-pins {
 				pins = "PB9", "PB10";
 				allwinner,pinmux = <2>;
-- 
2.47.3


