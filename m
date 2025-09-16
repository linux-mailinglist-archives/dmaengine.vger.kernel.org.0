Return-Path: <dmaengine+bounces-6558-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 322B6B5A255
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 22:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3BA417049E
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 20:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D58306498;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngdC1s+8"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75187283FF0;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054325; cv=none; b=I5mVz83LsIqYuWNJZHWBqTTV7pteTDtApgMYOf37GBFv8dTIDtNJH5OdK4RdkNbhHYgyfX4agoTLbmgthRim85er4J+VIlk3va+9+AkndDu3RdBxybrUlRLz+xeJeVPqj98B14ayCnEpxu5yHR81aY4eAczsFKWbuLqgrUZwXG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054325; c=relaxed/simple;
	bh=g8WKS6OWWxn2i9b93Vms3rDWq8kUvZxINbkSWPCdUAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rIjRHlE0r6PYByjv7vg94R82zc93fxi5GwVFzlNh50qTzxqpiwMnVbjtC8aDNPwAVSdAmgBd6PooYVxsPzrUGuwF7epjh5MzdtXryxw+/9Qo4iicgt+QKIhamIDyN4XN7Y6qtB8it/ZP+wP/pj++1Pkxyp/3RpUyVQknK7uKyjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngdC1s+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00F17C4CEF9;
	Tue, 16 Sep 2025 20:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758054325;
	bh=g8WKS6OWWxn2i9b93Vms3rDWq8kUvZxINbkSWPCdUAg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ngdC1s+8aKoELBX4ttC402zvWkjkBhpUXSFAfc8yZIPOIJQESQSAmr92qwfyf4ISL
	 aV71PAQWX5zh/MDkk89hEAG6X1g5iO1KTkUznbCOZOFoQxfLcfOKLVFR93qLPdZoGU
	 TfF+S8w5u/Ru+Hf758byUnWrjqdV1Gpk3rMef10MINTa/RUFAPPu4YFuBLM7wHjCN9
	 4WSRAOnBUBR06RovRp6a8scMic+jYtIVJ0vTRod+T3bx9Aj/8iAsISJa8sdMSZtrGb
	 BsFvzyES5fd9H8Wv8hmQ31rxJSFA+Em+eeGxOhJzdEYDzVY5D8/Oljd2fOxCXO/06R
	 gITtXiOdLeB9w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7723CAC59B;
	Tue, 16 Sep 2025 20:25:24 +0000 (UTC)
From: Dang Huynh via B4 Relay <devnull+dang.huynh.mainlining.org@kernel.org>
Date: Wed, 17 Sep 2025 03:24:58 +0700
Subject: [PATCH 01/25] ARM: dts: unisoc: rda8810pl: Add label to GPIO nodes
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-rda8810pl-drivers-v1-1-9ca9184ca977@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758054322; l=1425;
 i=dang.huynh@mainlining.org; s=20250917; h=from:subject:message-id;
 bh=gehgcAARQ8SuL4G+2lQ4aVqQ18cLEbIKhDsg1ccbtlY=;
 b=vkVKhU4yFFQMGNx4j1vlk9SkqiDmkH60RhCQ7wo0S9uGQumeaKqLqNlS0OScNrteBhazOecZ8
 T9KNvTq6xRZAUqrRvG/mu3SAX3P636QQs8gFg7biuveiCHR5chOs6NK
X-Developer-Key: i=dang.huynh@mainlining.org; a=ed25519;
 pk=RyzH4CL4YU/ItXYUurA51EVBidfx4lIy8/E4EKRJCUk=
X-Endpoint-Received: by B4 Relay for dang.huynh@mainlining.org/20250917
 with auth_id=526
X-Original-From: Dang Huynh <dang.huynh@mainlining.org>
Reply-To: dang.huynh@mainlining.org

From: Dang Huynh <dang.huynh@mainlining.org>

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



