Return-Path: <dmaengine+bounces-6568-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5838B5A2DA
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 22:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3BF5327EC6
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 20:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0C6353354;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hf7kCTiO"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D89323F55;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054326; cv=none; b=nYwxg36+U1SMLUIO3Mrof3SdC0Mzdx6ZbebavWr8NRKC+563u1TUeHFi3XioSDbyuYTUN+WbSkqzcgQB5Y59UALW68u3i5LJw8T+2TnsM+yFJaEyapIyd8SwJhIdZrcjoiT/vOw1TdEmlUxJrwn0ycR8e9tAYw61OkstslP4NAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054326; c=relaxed/simple;
	bh=Czlyuawt5NCDFtRIIQsXB+M6g7mpoAg3GuJazRPrBeI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qSbqwDn4saIo0Cfi48RVcHJffkQNcYGlPwrj3sE4r8gclMzaMM96SSQmnPwbeFJZnhFhfDOluXYXTQ1GPOwMT489H69zJEyiYz/bSzv9XcuakcnROoUAyK9ecoD5Hq7EfPR8ZfOCOywy0thrI3Lr448HL8F/tQbDTxmGRG9X4CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hf7kCTiO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5992C4CEF7;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758054325;
	bh=Czlyuawt5NCDFtRIIQsXB+M6g7mpoAg3GuJazRPrBeI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Hf7kCTiORGTrm++NtElPg+BLvT/tPCYisK3L/uNUGqwouBOJH5KqTtG77kVaKuPlv
	 wZJ1tVfBM+oD739xcpDYDCm0BfU/eDAXJtAwN6cHwz9XToI3Pi4NvC01sA9V6vN6Sy
	 Hjav5hHyCHxfiBa5chtv4H0ACWzUGO9z9TWLBzYUW2h35Oh+c+1csTW9nEDhF8LQ5K
	 6o8xc0/nkiRGA5ZEIldbknzWtd5+v/Kx7snPjIgIPGEp8KcQEJeHds/KUDKRF1xvRd
	 UI8qqvf17+peTy8L8rjLkGAdBlmYwPHtCP01ycoS8dOCdVzmK/J4uB3WwIH8VY+3OL
	 3Byo5FzCSJn6Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA26DCAC592;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
From: Dang Huynh via B4 Relay <devnull+dang.huynh.mainlining.org@kernel.org>
Date: Wed, 17 Sep 2025 03:25:10 +0700
Subject: [PATCH 13/25] dts: unisoc: orangepi: Disable UART with no users
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-rda8810pl-drivers-v1-13-9ca9184ca977@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758054322; l=1477;
 i=dang.huynh@mainlining.org; s=20250917; h=from:subject:message-id;
 bh=XPO5kEJS5ocnBL76vZ0w5j7Lye5wuRkS9bNnKxmO9oo=;
 b=2zBM9XKo6rOYbZUNQpD9eFH0E5hNGPLBqV3M7IJCdwPx3vmKRrOd+pPLTcttmUftfCu1MJTme
 +esbSs3Nw5mA0QSS7+wm41hH4xrahHriqA1Ce8uMeTupFJtX3yQzKCr
X-Developer-Key: i=dang.huynh@mainlining.org; a=ed25519;
 pk=RyzH4CL4YU/ItXYUurA51EVBidfx4lIy8/E4EKRJCUk=
X-Endpoint-Received: by B4 Relay for dang.huynh@mainlining.org/20250917
 with auth_id=526
X-Original-From: Dang Huynh <dang.huynh@mainlining.org>
Reply-To: dang.huynh@mainlining.org

From: Dang Huynh <dang.huynh@mainlining.org>

By default, we should keep unused peripherals disabled.

Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
 arch/arm/boot/dts/unisoc/rda8810pl-orangepi-2g-iot.dts | 10 ----------
 arch/arm/boot/dts/unisoc/rda8810pl-orangepi-i96.dts    | 10 ----------
 2 files changed, 20 deletions(-)

diff --git a/arch/arm/boot/dts/unisoc/rda8810pl-orangepi-2g-iot.dts b/arch/arm/boot/dts/unisoc/rda8810pl-orangepi-2g-iot.dts
index 98e34248ae80b1fcd673ff01fe045db412d5bcc9..46ccb9ad510c0df142b845d6fc5633b69c2298dd 100644
--- a/arch/arm/boot/dts/unisoc/rda8810pl-orangepi-2g-iot.dts
+++ b/arch/arm/boot/dts/unisoc/rda8810pl-orangepi-2g-iot.dts
@@ -34,16 +34,6 @@ uart_clk: uart-clk {
 	};
 };
 
-&uart1 {
-	status = "okay";
-	clocks = <&uart_clk>;
-};
-
-&uart2 {
-	status = "okay";
-	clocks = <&uart_clk>;
-};
-
 &uart3 {
 	status = "okay";
 	clocks = <&uart_clk>;
diff --git a/arch/arm/boot/dts/unisoc/rda8810pl-orangepi-i96.dts b/arch/arm/boot/dts/unisoc/rda8810pl-orangepi-i96.dts
index 728f76931b995fdfc036b586f899b15a7f07528b..a1d61ef138d12bb3ecb4b24513cc1a7dfbac3107 100644
--- a/arch/arm/boot/dts/unisoc/rda8810pl-orangepi-i96.dts
+++ b/arch/arm/boot/dts/unisoc/rda8810pl-orangepi-i96.dts
@@ -34,16 +34,6 @@ uart_clk: uart-clk {
 	};
 };
 
-&uart1 {
-	status = "okay";
-	clocks = <&uart_clk>;
-};
-
-&uart2 {
-	status = "okay";
-	clocks = <&uart_clk>;
-};
-
 &uart3 {
 	status = "okay";
 	clocks = <&uart_clk>;

-- 
2.51.0



