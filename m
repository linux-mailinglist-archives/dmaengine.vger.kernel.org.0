Return-Path: <dmaengine+bounces-6651-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BD8B868E3
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 20:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02671C84B14
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 18:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B942F5A2F;
	Thu, 18 Sep 2025 18:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXTa/7ZT"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A136B2D8776;
	Thu, 18 Sep 2025 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221398; cv=none; b=CMIDvglwvWCL9r9W0sjovIXbOx+Xh0EPBxR2ypkCvI9FalTbjWkSQDSfNBQFqWsbmTUR322kF6dSNUW+0b/iXO+zwkmWYZfEErk8/XIUsD32Mhd2JFWA2raovv0zxiA/8Y0v6VEdhZJflOmXyQ2VkZNGCyCitMBZSDKeh1VSxts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221398; c=relaxed/simple;
	bh=0toEdpgdrAHwzWBocpkLTIinw0pb9FWHXvtuM2MoRow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fyvbR/6h6P2gX/pu7AVL4kPsqzSLe64U+iDGqJ+KyMoKkkPyVPlLI0TsyuVRDPAnmcXpf/ogbGDNpR5vSX09In8wzKX6YgmvBWkeNqxgTlsitCn/9WMHdu87Kw1lc2BwwpBqfQ3uqZJYALLD5mD3WvixaJcdzxs4hrVsevE9DfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXTa/7ZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B556C116B1;
	Thu, 18 Sep 2025 18:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758221398;
	bh=0toEdpgdrAHwzWBocpkLTIinw0pb9FWHXvtuM2MoRow=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mXTa/7ZTSyoRUPq0LQumllP2bsy6xtHw59fnlRGrCpAMMrQy4Uls6SEbrDebF3128
	 YpCJ1745BR8ndtD5NrHPFLqZD56yFrg463l+6bPD7F3ty+ZC8Q9ei3PjQkEVxD8KEd
	 yZ7nhF7sgZ3vLyKHqeXo0DuVFBEh+NUdy4XZ4BxklfDLOhcSlJz3e4twocACzX0PCN
	 wcim4j1KWKTIqVnbKUuUz65L7FokbPceYxlodBk66B0/LiHvtNCdsfluXDHoXXUJGl
	 +DkO1/0KzhaBKatU7mmbBoW21zDgo3tPmXfjRsR2y6xhXodHQji0MdbqW01qnlIV7Y
	 NMAB2bTu2PQQQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1E0CAC5A7;
	Thu, 18 Sep 2025 18:49:58 +0000 (UTC)
From: Dang Huynh via B4 Relay <devnull+dang.huynh.mainlining.org@kernel.org>
Date: Fri, 19 Sep 2025 01:48:46 +0700
Subject: [PATCH 06/10] gpio: rda: Make direction register unreadable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-rda8810pl-mmc-v1-6-d4f08a05ba4d@mainlining.org>
References: <20250919-rda8810pl-mmc-v1-0-d4f08a05ba4d@mainlining.org>
In-Reply-To: <20250919-rda8810pl-mmc-v1-0-d4f08a05ba4d@mainlining.org>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-mmc@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Dang Huynh <dang.huynh@mainlining.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758221395; l=985;
 i=dang.huynh@mainlining.org; s=20250917; h=from:subject:message-id;
 bh=VMMKg4HONUFRzO6+25FovvsxOlucUttBjgwEeb3Ns7Q=;
 b=iAakQHayFHGXZ7IKRgsLgfpt3RDZjxa0+TASp4ZeKYUKatPRehTsYyn/QN0h83ue75flIlEEa
 Z292tJSmrBCA/7rCRSbbK0qIuX2/EJRrE+U7wNAYUXGkbpIODs8+5p8
X-Developer-Key: i=dang.huynh@mainlining.org; a=ed25519;
 pk=RyzH4CL4YU/ItXYUurA51EVBidfx4lIy8/E4EKRJCUk=
X-Endpoint-Received: by B4 Relay for dang.huynh@mainlining.org/20250917
 with auth_id=526
X-Original-From: Dang Huynh <dang.huynh@mainlining.org>
Reply-To: dang.huynh@mainlining.org

From: Dang Huynh <dang.huynh@mainlining.org>

The register doesn't like to be read and would cause all the input
to be switched to output.

This causes the SD Card Detect GPIO to misbehaves in the OS and/or
may cause hardware to malfunction.

Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
 drivers/gpio/gpio-rda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-rda.c b/drivers/gpio/gpio-rda.c
index 7d20dbbb6ec41149a1dbf4d9ef9ac86449773c35..ae2efa22755986b5445fdb8d4f004d595c189590 100644
--- a/drivers/gpio/gpio-rda.c
+++ b/drivers/gpio/gpio-rda.c
@@ -245,7 +245,7 @@ static int rda_gpio_probe(struct platform_device *pdev)
 		.clr = rda_gpio->base + RDA_GPIO_CLR,
 		.dirout = rda_gpio->base + RDA_GPIO_OEN_SET_OUT,
 		.dirin = rda_gpio->base + RDA_GPIO_OEN_SET_IN,
-		.flags = BGPIOF_READ_OUTPUT_REG_SET,
+		.flags = BGPIOF_READ_OUTPUT_REG_SET | BGPIOF_UNREADABLE_REG_DIR,
 	};
 
 	ret = gpio_generic_chip_init(&rda_gpio->chip, &config);

-- 
2.51.0



