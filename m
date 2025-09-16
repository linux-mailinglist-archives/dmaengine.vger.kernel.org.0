Return-Path: <dmaengine+bounces-6571-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5F8B5A2A2
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 22:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603F21C02ACE
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 20:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15F2393DF3;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4KS5aRU"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6225932B48A;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054326; cv=none; b=I2TlkuR0Xq65RUQAk0gV94b2ZPuSmI+fpn8+4f95/+e1wFAM/n9S5QLe9QRNEiZYu/gSswX8PeWDbukzLcRxoez3NvD9Q2tKq9QKEJw+y/TbYMp5FtXTm+o2TLFjx0k4dzQBp5gpa3Ld0KBS/6rTThweHxtqqRGumVs7hFsmtng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054326; c=relaxed/simple;
	bh=OdDjeUrsbxYe5gyTTAMfg2jz6GQSgqKAHbK2zdue/s0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sF2vgUrV30vGKA9XxMnjLz8kCh95O0Ky2G/zwCEKlSyJ2BUyZK4ejXz1CY8PzEwJlcOd+p+RWN5zMSFQAC+/9QmbNU4F2N9582oNMVSEkQsICNU46tBJkYUEDtDgLjLiuGVntGBMfBoyYzaNLmhS/lpmvegZB+vdawJ68akaBvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4KS5aRU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 380DDC2BCC7;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758054326;
	bh=OdDjeUrsbxYe5gyTTAMfg2jz6GQSgqKAHbK2zdue/s0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=C4KS5aRUOYF5wocufmuf97G4mdCvA4nqIq9eLu19lXxVMcFNMoBpkUUMWb4pbTgBJ
	 ev7r8X+MwmWhTbKLeUKNLxnwEVqwIxJwNNhzOmI/YOA0siR6PT4BQLZwSZX0O5a1Jt
	 hijKOleuESsXTOoj1c/EyAeMFKHNgLc7Ub9UQxLhkjvBSKnb/YtGWjXFJNPWsq8jtA
	 5/dmiJMUYbNh+SiwUTO/UZne2p2opGbfb3/ohuFeWeZ7UapxJfYQGdkfYbWmnVjARk
	 gbqGeCj2FYlDkOvodxgSy2LIYFKHVOIYWr8kyx7GMYvz1u7jTSBwbmMlLGmuxJnX96
	 fDLNmC7KpIeMw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23638CAC59D;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
From: Dang Huynh via B4 Relay <devnull+dang.huynh.mainlining.org@kernel.org>
Date: Wed, 17 Sep 2025 03:25:17 +0700
Subject: [PATCH 20/25] dts: unisoc: rda8810pl: Enable IFC
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-rda8810pl-drivers-v1-20-9ca9184ca977@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758054322; l=799;
 i=dang.huynh@mainlining.org; s=20250917; h=from:subject:message-id;
 bh=ESVrh/e66fpCx8hkda0seGPWiRBFpNz918jLvjzC/2M=;
 b=xjdSUQMpB1QsdnW8tgHCeT8pweYzkXjix4jRKL4LWTM9cauqSrIz8lT0CyfI+75tbl+ectZHh
 CfYuGRCaLUQBLS7JKFKy7prh17FG7FrBkJ57XLn48PXdB9/L1RvywvP
X-Developer-Key: i=dang.huynh@mainlining.org; a=ed25519;
 pk=RyzH4CL4YU/ItXYUurA51EVBidfx4lIy8/E4EKRJCUk=
X-Endpoint-Received: by B4 Relay for dang.huynh@mainlining.org/20250917
 with auth_id=526
X-Original-From: Dang Huynh <dang.huynh@mainlining.org>
Reply-To: dang.huynh@mainlining.org

From: Dang Huynh <dang.huynh@mainlining.org>

Enable IFC so we can use it with I2C, SPI, SDMMC.

Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
 arch/arm/boot/dts/unisoc/rda8810pl.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/unisoc/rda8810pl.dtsi b/arch/arm/boot/dts/unisoc/rda8810pl.dtsi
index e90ae7845de7b79e55e9cd339a82313b423e0252..4b3ae19e9da41ee9ffa76dd4fff01824c07ce045 100644
--- a/arch/arm/boot/dts/unisoc/rda8810pl.dtsi
+++ b/arch/arm/boot/dts/unisoc/rda8810pl.dtsi
@@ -212,6 +212,12 @@ uart3: serial@90000 {
 			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
+
+		ifc: dma-controller@f0000 {
+			compatible = "rda,8810pl-ifc";
+			reg = <0xf0000 0x1000>;
+			#dma-cells = <1>;
+		};
 	};
 
 	l2: cache-controller@21100000 {

-- 
2.51.0



