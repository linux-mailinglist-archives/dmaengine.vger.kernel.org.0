Return-Path: <dmaengine+bounces-6548-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 629A2B5A1F3
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 22:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E02E0483A95
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 20:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6FC306B13;
	Tue, 16 Sep 2025 20:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="CzM2wqYQ";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="0u96kyB7"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA955304BCE;
	Tue, 16 Sep 2025 20:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053392; cv=none; b=Cxl9y9OUaZkPE+EkhXEyc8MjSk4aFE6f9I/OLZ0xC0Cgm2zlIvVQ2Vmow+Elu09UYFEeUmR3BG0oQIObYnckAIpcL3da2HZiFlQQeGh7kbiLhWjt3fcfP2DNi5qtNY4LVxbmWKczWI35zrs+CsiT1inSkRKGk23e15tfz46s774=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053392; c=relaxed/simple;
	bh=gehgcAARQ8SuL4G+2lQ4aVqQ18cLEbIKhDsg1ccbtlY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uQoOfsfAb5LWnZZRMoPkFFvfby/2tihHdKsuuKo345lfqL4u3AVxqioPDI4iqciY6WjZcKxnoMIbDKDsCQ2UfImKz+9AhjuC/NxlVsACD2WKv0xJUeRFJ8TT6coCjuiqCmTVYUHNRPttpEGxn7Yzc2YClZzDGIPJPYjKbCzniRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=CzM2wqYQ; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=0u96kyB7; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1758053282; bh=36QFNbwKpWQBiZ/Fe/Z9uxp
	+qsQjQ+OgtXnHKonsaEA=; b=CzM2wqYQ1WOJb/8Rjo+g2lPSmj/n9yIXv7DHCra2ylSTUZTetO
	rljZfJ2xBoXxhoE+ULS1fN2e/pIqbURiQQWZZZAmWPoWcv2KZBAr/9yK4PKZZ9pHpojPU3OEiWv
	lfDlhVhsyXWBsbzOXCpOQgsyAo880BRWWHs0Hs5xSvHloIASIcQL9eHLOKqNv8Hhrq4uE+qJUzP
	kOkyfRKrqnzfI+oNiAUiHMV+7u0PHOG5bNlMMQwXtUOE/xWFth2l/NrZZPSmj+j5hIemNWVcrVG
	TuFAAq9mYhmF8UcV3TuS2xGQevf3q4cBGZVAeduaGxDcf43/8hGOHpTkERpu/5GsKrg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1758053282; bh=36QFNbwKpWQBiZ/Fe/Z9uxp
	+qsQjQ+OgtXnHKonsaEA=; b=0u96kyB746Y0WhgRMmjOIkFjt9a6HosKTwmMRJtCouDDLKSdeB
	NSHiXR8/3PkwjeHIOxrDQbkSLZyhn5liqiDA==;
From: Dang Huynh <dang.huynh@mainlining.org>
Date: Wed, 17 Sep 2025 03:07:18 +0700
Subject: [PATCH 01/25] ARM: dts: unisoc: rda8810pl: Add label to GPIO nodes
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-rda8810pl-drivers-v1-1-74866def1fe3@mainlining.org>
References: <20250917-rda8810pl-drivers-v1-0-74866def1fe3@mainlining.org>
In-Reply-To: <20250917-rda8810pl-drivers-v1-0-74866def1fe3@mainlining.org>
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

So we can add devices to these GPIO nodes for each board.

Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
 arch/arm/boot/dts/unisoc/rda8810pl.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/unisoc/rda8810pl.dtsi b/arch/arm/boot/dts/unisoc/rda8810pl.dtsi
index f30d6ece49fb33d9c5c3ad9522c83bb8e4f8b488..6553fc102c6751696e75e4de614fc3428d182061 100644
--- a/arch/arm/boot/dts/unisoc/rda8810pl.dtsi
+++ b/arch/arm/boot/dts/unisoc/rda8810pl.dtsi
@@ -39,7 +39,7 @@ modem@10000000 {
 		#size-cells = <1>;
 		ranges = <0x0 0x10000000 0xfffffff>;
 
-		gpioc@1a08000 {
+		gpioc: gpioc@1a08000 {
 			compatible = "rda,8810pl-gpio";
 			reg = <0x1a08000 0x1000>;
 			gpio-controller;
@@ -76,7 +76,7 @@ timer@10000 {
 			interrupt-names = "hwtimer", "ostimer";
 		};
 
-		gpioa@30000 {
+		gpioa: gpioa@30000 {
 			compatible = "rda,8810pl-gpio";
 			reg = <0x30000 0x1000>;
 			gpio-controller;
@@ -87,7 +87,7 @@ gpioa@30000 {
 			interrupts = <12 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		gpiob@31000 {
+		gpiob: gpiob@31000 {
 			compatible = "rda,8810pl-gpio";
 			reg = <0x31000 0x1000>;
 			gpio-controller;
@@ -98,7 +98,7 @@ gpiob@31000 {
 			interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		gpiod@32000 {
+		gpiod: gpiod@32000 {
 			compatible = "rda,8810pl-gpio";
 			reg = <0x32000 0x1000>;
 			gpio-controller;

-- 
2.51.0


