Return-Path: <dmaengine+bounces-6575-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90F6B5A2D1
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 22:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1837116F255
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 20:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98ED532F473;
	Tue, 16 Sep 2025 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdmlZ+qG"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96933343202;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054326; cv=none; b=CYcg4Ro9ETHP9BgFtcziy32+sSXUrJRKLIH6p7mdY/cbJsglJtjLI/vHOPvRXZTXXGilgGR1eXG0msHDam9P1QMz8rCWTi8wRo4mPIPcm7Z5heXzeO0qCGuYNdN473NAhImcsIwMkGWHQsBX7mSy4+R5bGUlmlnqsla6vssOBGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054326; c=relaxed/simple;
	bh=cYZYP/uaZ0Z/omX0vz2UqaLnE+xmaYEf63AvynoutoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PI8dT5X3Rjhn4/khQaZ81JCn5/02kDgLkKFnIAId0nPbnT6jdBlQOSv9u7tx4NTYYlwJQDYISsWZoGv27kZy7CrXtF95XGiCvhVKoA6gk82cHIQpnYT4FXHV1WXjU80xMfWM4dn/TFOJ6inWvs2RVOmAEgskO/p29K5b2n0nDj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdmlZ+qG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65186C4CEF0;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758054326;
	bh=cYZYP/uaZ0Z/omX0vz2UqaLnE+xmaYEf63AvynoutoE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CdmlZ+qGcOngd+lvNpEen5lhbh/dTmK2Q3Ty/eYlIEcqgFL6xAzwa4W/LfX34Hfx5
	 3fBeqj5wi/oTkxuB+XEOsf+wr5Z5C3kDvwmAg/yySoVTPp1/wQFCi27WQye50Usgkv
	 +iImavWZdMfORAQ2UjB1I4wc38wiikTwi59q2bVpn4+YW9pUHGUE/AAwM62rVqn94E
	 WqlqiRZmqNjpFhUv/vr9EGKPedIsrCvfR5vRZB66wpqYcUT/+CzRRVuqprKSQpRlQZ
	 7DYFjspfjwwxdE/TMkSzgMHv1n6y+KiF/8uT6fRAqtQaJ6IVtB73DOR4NjrTzrNzC/
	 xw3Vv5VYA1S0A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5229ACAC59F;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
From: Dang Huynh via B4 Relay <devnull+dang.huynh.mainlining.org@kernel.org>
Date: Wed, 17 Sep 2025 03:25:20 +0700
Subject: [PATCH 23/25] dts: unisoc: rda8810pl: Add SDMMC controllers
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-rda8810pl-drivers-v1-23-9ca9184ca977@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758054322; l=1669;
 i=dang.huynh@mainlining.org; s=20250917; h=from:subject:message-id;
 bh=+rjfqyC6diLcCcMZpXzmNwIY3Xd0ao4URhi7mY7MeOo=;
 b=g36+c8BMuiizyAkQU5g2SVhGELtdZOZL7VmLGm9NJ65TH2ylz89Z6tGkVFMsW4PUF6yXDm1fJ
 gSr5M9xIH80CvABquDEQg1EdtLnBDMt1j/TqnDGY86xGtT9UTnG1g4P
X-Developer-Key: i=dang.huynh@mainlining.org; a=ed25519;
 pk=RyzH4CL4YU/ItXYUurA51EVBidfx4lIy8/E4EKRJCUk=
X-Endpoint-Received: by B4 Relay for dang.huynh@mainlining.org/20250917
 with auth_id=526
X-Original-From: Dang Huynh <dang.huynh@mainlining.org>
Reply-To: dang.huynh@mainlining.org

From: Dang Huynh <dang.huynh@mainlining.org>

Add SDMMC1 and 2 controllers for the RDA8810PL platform.

Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
 arch/arm/boot/dts/unisoc/rda8810pl.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/unisoc/rda8810pl.dtsi b/arch/arm/boot/dts/unisoc/rda8810pl.dtsi
index 4b3ae19e9da41ee9ffa76dd4fff01824c07ce045..e68f8330ce2c4750b6944612bee03b42694137e4 100644
--- a/arch/arm/boot/dts/unisoc/rda8810pl.dtsi
+++ b/arch/arm/boot/dts/unisoc/rda8810pl.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/clock/rda,8810pl-apclk.h>
+#include <dt-bindings/dma/rda-ifc.h>
 
 / {
 	compatible = "rda,8810pl";
@@ -199,6 +200,30 @@ uart1: serial@0 {
 			status = "disabled";
 		};
 
+		mmc1: mmc@50000 {
+			compatible = "rda,8810pl-mmc";
+			reg = <0x50000 0x1000>;
+			interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ap_syscon CLK_APB2>;
+			clock-names = "apb";
+			resets = <&ap_syscon RST_APB2_SDMMC1>;
+			dmas = <&ifc IFC_SDMMC1_TX>, <&ifc IFC_SDMMC1_RX>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		mmc2: mmc@60000 {
+			compatible = "rda,8810pl-mmc";
+			reg = <0x60000 0x1000>;
+			interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ap_syscon CLK_APB2>;
+			clock-names = "apb";
+			resets = <&ap_syscon RST_APB2_SDMMC2>;
+			dmas = <&ifc IFC_SDMMC2_TX>, <&ifc IFC_SDMMC2_RX>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
 		uart2: serial@10000 {
 			compatible = "rda,8810pl-uart";
 			reg = <0x10000 0x1000>;

-- 
2.51.0



