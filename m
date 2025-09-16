Return-Path: <dmaengine+bounces-6569-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2067CB5A2CB
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 22:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534231C051DA
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 20:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C9A374287;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHT/sSOT"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB3E323F62;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054326; cv=none; b=laoctTQJ7siX5M+PSlDvYV12Sarc9dA6P2RGTTDIrfmCkvkt8MCc9qlScVJ8d2W3OwtfkrsWvwubvW7iKus+3hNuJmxrqT9IbeQD0TuB2w0Efu9Rviax9zyT9VRp4AI6I+9YHBaQHj8gpZ7JqFQqoCRFRKwAY7DJCXeG13Dxifo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054326; c=relaxed/simple;
	bh=9/G5ZTxTD+BBqSrE/vwGnDJrgre4QIYgA6oTXtY5stk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LYYF5L4yWTP3vOsZ2zjLl5ZZlAFVKOW/2gQf9u6Rhe7UOer/Z6SwmJu+bQ/9pO6SqCDI2kY2PffipfdmiN7dJqg6n4mxesPYP28d5lHd3W8qii68fl8uNPeMmT0DJeSSe5KwWFDE0p/hytADPti6stHeJKdmFjp1RjCs2LJ5G90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHT/sSOT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 976CEC2BCB0;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758054325;
	bh=9/G5ZTxTD+BBqSrE/vwGnDJrgre4QIYgA6oTXtY5stk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZHT/sSOTHa6bfD8o5gNbnFzThRXuOKzVKaCBbDd++aCO1eYwOQO3sx6i/8TQNdsRm
	 CnItc8YCH+Hc/lqSokDvLem0ywUkeptdh4TyA7yKAxpHwd5jvO55giobsAt8iIQia7
	 2j4AtVR/JuSKey5ESfUTcfeLy/3piMc78dssNL+4UnUSREhw77IiDGBzFN8AZj+H8W
	 DS87xqFh7+KVEYlFCNwgO76XwqhZnIeNWaNzhdtHmHnFl774FsaJkWksqdgJcSkElH
	 O7aHwpnMQ1DoBKVCeB10K/o9B/Uz9jSWUHW4Hc9UXo8BsOi3EtZxVn2xtQDqDVcqQG
	 UnPsSqCCoGlew==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF7FCAC59D;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
From: Dang Huynh via B4 Relay <devnull+dang.huynh.mainlining.org@kernel.org>
Date: Wed, 17 Sep 2025 03:25:08 +0700
Subject: [PATCH 11/25] dts: unisoc: rda8810pl: Enable clock/reset driver
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-rda8810pl-drivers-v1-11-9ca9184ca977@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758054322; l=1103;
 i=dang.huynh@mainlining.org; s=20250917; h=from:subject:message-id;
 bh=iisWV1yQIJV2H6A79OICiudNGMDM/d8wOSexhp4+9s4=;
 b=Uvbh1qdCuPgMg2Cya3wHJFP9B0zxFrsqfkRbRH3160/AsRSPEzMZMlwk9yvCgAuRqcoJQnphz
 LShcA3DOx1LBDlnxtXB3POz/cK5m8ZeoMMoHjCQKsqRFMuyqcxZ4qHk
X-Developer-Key: i=dang.huynh@mainlining.org; a=ed25519;
 pk=RyzH4CL4YU/ItXYUurA51EVBidfx4lIy8/E4EKRJCUk=
X-Endpoint-Received: by B4 Relay for dang.huynh@mainlining.org/20250917
 with auth_id=526
X-Original-From: Dang Huynh <dang.huynh@mainlining.org>
Reply-To: dang.huynh@mainlining.org

From: Dang Huynh <dang.huynh@mainlining.org>

Enable RDA8810PL Clock and Reset driver so we can use it for various
subsystems.

Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
 arch/arm/boot/dts/unisoc/rda8810pl.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/unisoc/rda8810pl.dtsi b/arch/arm/boot/dts/unisoc/rda8810pl.dtsi
index 45a2fd3e04cea5aac4fb6b40a6b332ce3eee4f2c..1f7a6908d68367441e5dc865216cc7a5c39feb35 100644
--- a/arch/arm/boot/dts/unisoc/rda8810pl.dtsi
+++ b/arch/arm/boot/dts/unisoc/rda8810pl.dtsi
@@ -8,6 +8,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/clock/rda,8810pl-apclk.h>
 
 / {
 	compatible = "rda,8810pl";
@@ -79,6 +80,13 @@ apb@20900000 {
 		#size-cells = <1>;
 		ranges = <0x0 0x20900000 0x100000>;
 
+		ap_syscon: syscon@0 {
+			compatible = "rda,8810pl-apsyscon", "syscon";
+			reg = <0x0 0x1000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
 		timer@10000 {
 			compatible = "rda,8810pl-timer";
 			reg = <0x10000 0x1000>;

-- 
2.51.0



