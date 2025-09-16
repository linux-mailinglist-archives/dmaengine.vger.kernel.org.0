Return-Path: <dmaengine+bounces-6577-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 837CBB5A2E0
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 22:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92781327BFF
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 20:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C18833087A;
	Tue, 16 Sep 2025 20:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ma/CpcuB"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FF5329517;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054326; cv=none; b=rT86lOI6LpYAFLunUy/1d1GKTcwGRfFa2GINpbyyt1w5H2fZCmW45ZQD8EDZ2O47jEyrpUUpONsJofax6P0rVA2tC9VNEa0odr2zxXaBr0PuYFSju1PZcaem8G+BY5NuNTchhxZV3S1o6Yaw3soFsyRXDkDAkPbs4nmIEyTL5EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054326; c=relaxed/simple;
	bh=4w6w5DvzwFyRo2J5VW1szw6dNb6N2JHLDo922TOLKcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u1hwfgYEklAeFrJpd7p3n3LG0m006FMmPVOC9oz/lqqP2l6d6JGg1rs+DqQlKwOfiMwdJcXSWcZATwbWyKKjIx1w59PvREE/WcBbZFOcqKhKQd/SkSbxObSx66EVfInyVNhenJfKw8GoGE0WbqtIxpBvOhlYUEsBq+0lD2pCh6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ma/CpcuB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06C12C4CEFF;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758054326;
	bh=4w6w5DvzwFyRo2J5VW1szw6dNb6N2JHLDo922TOLKcY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ma/CpcuBYVrPPjn8B5wDIMdK5MXsxC8Lgs9ueMxl7S9NVceWGjbSNc7QoFAQv10rw
	 ur8thkyVEuWGBCwwlKeyC5KZgjl9wxNhj3R6IwTEvmVNsQZyNMyoU8MQZmRpPCksfw
	 u05SWxcjEx103cFljCepFq6Kvns6i73kSrEQ3jWll+9HbQOi99pXQOCatoK5wv1uI2
	 O9m/FAv5Fbzdw36thgv1deL2EunYU468a9Aoqyj3a+vDSTZOqGF7BayMtXkucCkP4o
	 fKED/ROmSfgdNe/+KuXzbSxjjUCmBMUByFUbEtRoX8gYqQxoH06n2UWVySlp2i9PnT
	 OvlQZq5LjZY2Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FA4CAC5A0;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
From: Dang Huynh via B4 Relay <devnull+dang.huynh.mainlining.org@kernel.org>
Date: Wed, 17 Sep 2025 03:25:14 +0700
Subject: [PATCH 17/25] drivers: gpio: rda: Make direction register
 unreadable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-rda8810pl-drivers-v1-17-9ca9184ca977@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758054322; l=890;
 i=dang.huynh@mainlining.org; s=20250917; h=from:subject:message-id;
 bh=Ej4sfxzJ/Gsg0f6d9t0Id5MGonhTVkngeFDG/IpOGqc=;
 b=7/dQ+zSEH7UofRPjo+bKlBs6ViTT+WuJvSx4Gecx+bo6BYwM3Re5lMQKArpXET7WxhoCPOvfe
 Rk52QJ6IW9cA55W805ijHTkhu0687ofj0g1SAA1xQxJl5AhXuzcWLTL
X-Developer-Key: i=dang.huynh@mainlining.org; a=ed25519;
 pk=RyzH4CL4YU/ItXYUurA51EVBidfx4lIy8/E4EKRJCUk=
X-Endpoint-Received: by B4 Relay for dang.huynh@mainlining.org/20250917
 with auth_id=526
X-Original-From: Dang Huynh <dang.huynh@mainlining.org>
Reply-To: dang.huynh@mainlining.org

From: Dang Huynh <dang.huynh@mainlining.org>

The register doesn't like to be read, this causes the SD Card
Card Detect GPIO to misbehaves in the OS.

Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
 drivers/gpio/gpio-rda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-rda.c b/drivers/gpio/gpio-rda.c
index b4db8553a2371ae407fdb7e681d0f82c4d9f74b7..56aaa9f33d29469dfb1bf86ed7b63c54b413c89c 100644
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



