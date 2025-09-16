Return-Path: <dmaengine+bounces-6581-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DCDB5A2FD
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 22:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98332328192
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 20:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCA23324FB;
	Tue, 16 Sep 2025 20:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PN8jXzDi"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A723B34AAEA;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054326; cv=none; b=t4IEB2jwEPStCz9DA9iY5NE4xyAH4uw/KDZ+8i6t41mb306FXV/jJ9iA6SMlSMpRNsgtYHjG/14VLeuBTvD22Vh/UhYZqvzJ9HkwLzEhRqhAIRam+whT4i2ISpBLczqh2DU2d8r1EABPsm+AtdPDWVOQ/7wLmJBbU4TYak2WpDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054326; c=relaxed/simple;
	bh=egTQGUBp0zFp2qNCGSUCro/O1z1FHKCYNAt7sLfWf4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r1Dt8btQG13DijgjcMMmo21zj9V+nfGeW5EEyQMn2pChCDri2GJPSUT4hETwJqanfV3oK1tMvIYQlnQEXGgApQkD4KgxS3B/KEtFqc1kffkLCrbjWHotIp/z7Coo85l80cXkHbW5mSSHVlNS4vrZd08YWnBPMsciMak9eVzgVYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PN8jXzDi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71FE2C4AF4D;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758054326;
	bh=egTQGUBp0zFp2qNCGSUCro/O1z1FHKCYNAt7sLfWf4g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PN8jXzDiDi9RozSEc6nSjwEzFHkYUrxdOnlOCyBKdZRd3FeqaHOj7f9TSeGhDbDPQ
	 Bh+pruy+oFlyn8G66wx9fSMwzO3BB+TsMB1T/9ciN9wjtWYhURBu5oJ/ncynx4l4up
	 GTXS36TSR0vmOTjHOo+AMpbGkL42nXNg5hK1n9q9mIc5qwtlQlHbpqUWPLThUsix5w
	 MF5bqD6KbunnstwbY91QvngVbXPdwSBbTjFMBCf64FdwFNunRQMBm5M9If9iZmMPmr
	 FBoeEHUqRWxzic7nngnRXOFUyf3NKkh5Y+HraPxrIF/9jR5Kre2Rs7pbkdgfhpDA5n
	 5aZBo5+WDL+9w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D2BCAC5A0;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
From: Dang Huynh via B4 Relay <devnull+dang.huynh.mainlining.org@kernel.org>
Date: Wed, 17 Sep 2025 03:25:21 +0700
Subject: [PATCH 24/25] dts: unisoc: orangepi-2g: Enable SD Card
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-rda8810pl-drivers-v1-24-9ca9184ca977@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758054322; l=1448;
 i=dang.huynh@mainlining.org; s=20250917; h=from:subject:message-id;
 bh=iqvLAp/eBqg4tchfSTl6yDHm7EVu5zj7yTK/oizm9Es=;
 b=QXCXdxinmO64Z8OEcHD6iLAWXpR3hIxrGFI6QsUVZCxUpj/VSQLgKvdaeJIkNysS7nwTiLnj9
 xsF1lHezVDzAWUeqcnf8tySkrThcdRIcADq/RFZ6wAUb/o0O+FlLD6O
X-Developer-Key: i=dang.huynh@mainlining.org; a=ed25519;
 pk=RyzH4CL4YU/ItXYUurA51EVBidfx4lIy8/E4EKRJCUk=
X-Endpoint-Received: by B4 Relay for dang.huynh@mainlining.org/20250917
 with auth_id=526
X-Original-From: Dang Huynh <dang.huynh@mainlining.org>
Reply-To: dang.huynh@mainlining.org

From: Dang Huynh <dang.huynh@mainlining.org>

Since we have a SDMMC controller, we can use the SD card slot on the
Orange Pi 2G-IOT.

Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
 .../boot/dts/unisoc/rda8810pl-orangepi-2g-iot.dts    | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/unisoc/rda8810pl-orangepi-2g-iot.dts b/arch/arm/boot/dts/unisoc/rda8810pl-orangepi-2g-iot.dts
index 46ccb9ad510c0df142b845d6fc5633b69c2298dd..f6b1a1485645f5714cdf14447cbee50e28e3c076 100644
--- a/arch/arm/boot/dts/unisoc/rda8810pl-orangepi-2g-iot.dts
+++ b/arch/arm/boot/dts/unisoc/rda8810pl-orangepi-2g-iot.dts
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



