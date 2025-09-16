Return-Path: <dmaengine+bounces-6582-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CAEB5A301
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 22:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 544E03282A3
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 20:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FAD33250C;
	Tue, 16 Sep 2025 20:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V20q9Xo0"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E613705BF;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054326; cv=none; b=MyCAsV6gUL+PIc3010s3xoDl8Qa+eRlZTVFjcxot1LrXKXH477LcfRycTJkh8A1ckg0N6O51wzJaKGC3ZXmFINWZPcj7aRoUpO4QA+wu/BGBIBHe8ZC3h65LtQxLaYjQBbkDBay6CIlvOQH4hDr3IPogNvPQaBIywCfHXOVQTxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054326; c=relaxed/simple;
	bh=D+uWf9FTrNZ5XT1lEEynxKDh80jQlO2m6fXZN2h5Ado=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MSyw3juPPeGYt/yYZNAXNWfCH2cNBmsD2xp8U/MMtwslsCpbgTls0+zt6MGz/hyjMY+PWB/idZuQ0Vf4OmdYzHzPL/mMQCmNMy4keT8qmBbTweOsjqyDO5PhlaY7Ls7l8Id9ZFYczIedsetBtA52iUOg+fED8UoLtmtuGx6Qr7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V20q9Xo0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83E3EC16AAE;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758054326;
	bh=D+uWf9FTrNZ5XT1lEEynxKDh80jQlO2m6fXZN2h5Ado=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=V20q9Xo0lEzJgC99QAWvPWoDp0uogcKMcJnek1L79qqlUGGQ261tuwpDhAOgLsEHm
	 +/tF95jnMFPm2QpOSoV67ZI5lFw8xviG0H5ygJTmY/jIc0ayFm4qy1Smb92PdWOs3o
	 ugJ9YsmRmOHAua+SedbO9iv1k+pAu9lHK1bAuIuFvLrPn0i8Ksix1FFXfUpJTH7ZPD
	 aMe21cQVNlTDpyTi9OT/pOOrdJ1zjAZ+7hhWfI/pJhnP8GcjDuS33zNyDIjA8tDN8N
	 wZGfAIbRYlpZ26df4gGH5HWGXsJ+uF3r8TxCMPNtqr8VEUk3KspQoASsUrTCH2Xs3J
	 c+Csr1N5RV1QA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FF1CAC598;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
From: Dang Huynh via B4 Relay <devnull+dang.huynh.mainlining.org@kernel.org>
Date: Wed, 17 Sep 2025 03:25:22 +0700
Subject: [PATCH 25/25] dts: unisoc: orangepi-i96: Enable SD Card
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-rda8810pl-drivers-v1-25-9ca9184ca977@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758054322; l=1432;
 i=dang.huynh@mainlining.org; s=20250917; h=from:subject:message-id;
 bh=qcvVxoXavmL/qbncOuYL4/AA9pp1j7YRntSv1snSw4A=;
 b=TmsiEoRuyNtRCinPmNRJPzsRLAOD+OfUVej7sM4TKuiv/lAlcCXOZO2yuj/YlaqpZKI2qoRoe
 gli9x6SUlcyCqeLBNQVNnFpfLrzGx9+fwjvYNgu+FokiMeRoJphyvZF
X-Developer-Key: i=dang.huynh@mainlining.org; a=ed25519;
 pk=RyzH4CL4YU/ItXYUurA51EVBidfx4lIy8/E4EKRJCUk=
X-Endpoint-Received: by B4 Relay for dang.huynh@mainlining.org/20250917
 with auth_id=526
X-Original-From: Dang Huynh <dang.huynh@mainlining.org>
Reply-To: dang.huynh@mainlining.org

From: Dang Huynh <dang.huynh@mainlining.org>

Since we have a SDMMC controller, we can use the SD card slot on the
Orange Pi i96.

Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
 arch/arm/boot/dts/unisoc/rda8810pl-orangepi-i96.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/unisoc/rda8810pl-orangepi-i96.dts b/arch/arm/boot/dts/unisoc/rda8810pl-orangepi-i96.dts
index a1d61ef138d12bb3ecb4b24513cc1a7dfbac3107..fbb7b5be62051627e80d940cb5e5ccff9047c13c 100644
--- a/arch/arm/boot/dts/unisoc/rda8810pl-orangepi-i96.dts
+++ b/arch/arm/boot/dts/unisoc/rda8810pl-orangepi-i96.dts
@@ -6,6 +6,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
 #include "rda8810pl.dtsi"
 
 / {
@@ -27,6 +28,13 @@ memory@80000000 {
 		reg = <0x80000000 0x10000000>;
 	};
 
+	vdd_sdmmc: regulator-fixed {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_sdmmc";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+	};
+
 	uart_clk: uart-clk {
 		compatible = "fixed-clock";
 		clock-frequency = <921600>;
@@ -34,6 +42,18 @@ uart_clk: uart-clk {
 	};
 };
 
+&mmc1 {
+	status = "okay";
+	no-sdio;
+	no-mmc;
+	bus-width = <4>;
+	max-frequency = <30000000>;
+	cd-gpios = <&gpiob 4 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&vdd_sdmmc>;
+	rda,mclk-adj = /bits/ 8 <1>;
+	rda,mclk-inv;
+};
+
 &uart3 {
 	status = "okay";
 	clocks = <&uart_clk>;

-- 
2.51.0



