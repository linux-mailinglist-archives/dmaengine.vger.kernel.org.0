Return-Path: <dmaengine+bounces-6896-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B74BF2A5A
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 19:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CAB1189F885
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 17:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569F3333451;
	Mon, 20 Oct 2025 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhSYF2x1"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1814033342D;
	Mon, 20 Oct 2025 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760980283; cv=none; b=DIdPmD10y+L32kMT1lFSlzmH9FYYmpFmcZbxr73QpqO6xUb9l5e03qxMzXPbEa/3/jiih4pWB2T0Ka0dqKdFcPdu5WJAD0/Ak4ECwZQKf46vwmPCSX48i5obGr627e/TZWjyEt4RbbmauDNgN9YLKgqRYD4hrmdwGAJVnBCTG9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760980283; c=relaxed/simple;
	bh=JAXFSTXHoi2lWkQbmUxgDURhf5LRyBjzq6/sRld0KGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wtb84kPl9jCOhDokoYyxoHAU6LxrCi2BNKOWY4bkochz3RHtH70hq105xsla7ru0h3I9edEPxFHY1WEZfrQh7hxfOvKOcaPsmHlPV241x6F36VryL1XL51XiSsINaLnMknT9FkR+Mq2pte41HyibxRv9ilXCy98sxC90xWhNBcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhSYF2x1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF48C2BCB1;
	Mon, 20 Oct 2025 17:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760980282;
	bh=JAXFSTXHoi2lWkQbmUxgDURhf5LRyBjzq6/sRld0KGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qhSYF2x18gezxn8W9SgUF6hy6rUHBaXOg6ph2VjiEAx29wvX5U5Oa05T2lw7reI/n
	 kn1ZTDIbFT7UvV0xitDjxSv1SiFcBxxt2I6sNK6SG1hil/wKHdXC5b8ZYPeeV6Wost
	 cNvEU/VSA9UkcIsVT9MXgnSHiEhV6/+q3iExPXSj/YcNmzsO8CyXwxC+LJiJj+CnYh
	 24H2ACtsEv10HLPnZDIBB17J91hBsKeZwhaMdg5FwDgPXkvKZiIrSiu2RxVlLoMo2T
	 dTamHu9JEDL6WzK7OshtVzyzAdA4KY/Gwa7pD7e8XbD3TC3vy/PqcSSFsGu6JBL9h5
	 6V+cb5GCVcHOQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 770105FEC6; Tue, 21 Oct 2025 01:11:18 +0800 (CST)
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
Subject: [PATCH 10/11] arm64: dts: allwinner: a523: Add I2S2 pins on PI pin group
Date: Tue, 21 Oct 2025 01:10:56 +0800
Message-ID: <20251020171059.2786070-11-wens@kernel.org>
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

The Radxa Cubie A5E exposes I2S2 through the PI pin group on the 40-pin
GPIO header.

Add a pinmux setting for it so potential users can directly reference
it.

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


