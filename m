Return-Path: <dmaengine+bounces-6570-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A136BB5A29C
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 22:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6031327ED4
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 20:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA68F37C106;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxzdsYVH"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB62323F50;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054326; cv=none; b=bhM5otBzaWRfYLUFTHFHVnXuvlrd3ys/DC92mQM2ghdo0et6HDrDHVsAx6ROul2djZAhinaXU+2fId8ioP4WMmaZdtA9P2M81B/gwIS0ruaN8YG84EPO0F7cgdU02NyOnlPF6VXd9z8Zi9xX94zvS1kr2OhJhLipjoJas+r+JZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054326; c=relaxed/simple;
	bh=RDpCXuNwW3F3KJj6jQvBGASBrt12FmdgYBI4SvuFthg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FU8dUSPqMjOw9Z+yOYM+sFMjO6bfznfRgE16yTB5/5jCa6GOBBVxpqi/YpG1U6AzD9E9sicnWu7hptoXcHs8EC8STnsWfpInflWYV/y46yE6jFJs3M+ZRoYG6fmeN29lSOW/PNuTMd4GZPMFOuHTx9pVlatU6RMwfPsDlVlCt9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxzdsYVH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4A68C2BC86;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758054325;
	bh=RDpCXuNwW3F3KJj6jQvBGASBrt12FmdgYBI4SvuFthg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VxzdsYVHyAvZMHPfARysp6GnpbZGKIKAOSLH+/pcWfrhLRvw8CZeX4KnHfb/K1tX9
	 LE82efrF2Fjxu3Fm/sD4iY5MI7Wqc7UEtrvz1mLbEtH/XNk6rIq7pFvjGXbqCjK//L
	 nmMILf+OnZr6N/2F8f6DxmpoB68iWmkv2PZeNTuLKlyOA8JUcjAl4E2iaZzzzIqc7h
	 l1GZGUn9BySXjQjcz92UWO1Eqp/7V4O1olgW1jJEdBu/c9dIAKtxd2gMrfmsuAqkjf
	 L+kNV8bLWAu5gdX1uA3wymb1CkPqnBtu5MtUbnGeXEaJ5vRKoZEMk+wVUeCAVyqxsl
	 t9yao+8SSno0w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE81CAC5A0;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
From: Dang Huynh via B4 Relay <devnull+dang.huynh.mainlining.org@kernel.org>
Date: Wed, 17 Sep 2025 03:25:09 +0700
Subject: [PATCH 12/25] dts: unisoc: rda8810pl: Add OPP for CPU and define
 L2 cache
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-rda8810pl-drivers-v1-12-9ca9184ca977@mainlining.org>
References: <20250917-rda8810pl-drivers-v1-0-9ca9184ca977@mainlining.org>
In-Reply-To: <20250917-rda8810pl-drivers-v1-0-9ca9184ca977@mainlining.org>
To: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Sebastian Reichel <sre@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Dang Huynh <dang.huynh@mainlining.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758054322; l=1899;
 i=dang.huynh@mainlining.org; s=20250917; h=from:subject:message-id;
 bh=GGuxO6sraElHWuAQ/FHMGYb5YyRNyQdi3IohZFnJO8o=;
 b=45yf1gKixsaK1bkMYGoKRUqzU4uJvxee7LDvXHPDAXh0W7cXAZpeAuF2mOgWJyZNK24hfZKsM
 GIqqJqEHIYuDn891fKiP8cE0LCeJJW/uSiFgTzEbed0Tkmppo8BGIdV
X-Developer-Key: i=dang.huynh@mainlining.org; a=ed25519;
 pk=RyzH4CL4YU/ItXYUurA51EVBidfx4lIy8/E4EKRJCUk=
X-Endpoint-Received: by B4 Relay for dang.huynh@mainlining.org/20250917
 with auth_id=526
X-Original-From: Dang Huynh <dang.huynh@mainlining.org>
Reply-To: dang.huynh@mainlining.org

From: Dang Huynh <dang.huynh@mainlining.org>

Add available frequency table came from downstream kernel, this
ensures that the CPU clock can be dynamically tuned.

Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
 arch/arm/boot/dts/unisoc/rda8810pl.dtsi | 52 +++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/unisoc/rda8810pl.dtsi b/arch/arm/boot/dts/unisoc/rda8810pl.dtsi
index 1f7a6908d68367441e5dc865216cc7a5c39feb35..299b29e4df6e0a04c5769a568eba73ed1684a9e5 100644
--- a/arch/arm/boot/dts/unisoc/rda8810pl.dtsi
+++ b/arch/arm/boot/dts/unisoc/rda8810pl.dtsi
@@ -16,6 +16,54 @@ / {
 	#address-cells = <1>;
 	#size-cells = <1>;
 
+	/*
+	 * There are two frequency table for CPU.
+	 *
+	 * "High" table is used when operating in normal mode
+	 * "Low" table is used when operating in power saving mode
+	 */
+	cpu_high_opp_table: opp-table-0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-329333333 {
+			opp-hz = /bits/ 64 <329333333>;
+		};
+
+		opp-395200000 {
+			opp-hz = /bits/ 64 <395200000>;
+		};
+
+		opp-494000000 {
+			opp-hz = /bits/ 64 <494000000>;
+		};
+
+		opp-988000000 {
+			opp-hz = /bits/ 64 <988000000>;
+		};
+	};
+
+	cpu_low_opp_table: opp-table-1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-266666666 {
+			opp-hz = /bits/ 64 <266666666>;
+		};
+
+		opp-320000000 {
+			opp-hz = /bits/ 64 <320000000>;
+		};
+
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+		};
+
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -24,6 +72,10 @@ cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a5";
 			reg = <0x0>;
+			next-level-cache = <&l2>;
+
+			clocks = <&ap_syscon CLK_CPU>;
+			operating-points-v2 = <&cpu_high_opp_table>;
 		};
 	};
 

-- 
2.51.0



