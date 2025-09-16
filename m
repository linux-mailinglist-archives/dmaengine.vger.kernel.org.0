Return-Path: <dmaengine+bounces-6553-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7A0B5A224
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 22:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA98D3274B7
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 20:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99902F2609;
	Tue, 16 Sep 2025 20:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="VJhHzR1H";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="lrjMieh9"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E92827AC48;
	Tue, 16 Sep 2025 20:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053631; cv=none; b=VWeujzj2XlB6tBPQJTMaIpLgj2aIkyF0OSo84jMo+HTG6XylJ6fFmLtKXacBIQ/wm9/dfT7IFYOGnWzipUT5xy1Zn5xq4SycPw2XGUPrSrSNVVBsTc8aeEQoRlQZLQ2TFIk8JfeJdGLEM/XWhPVCeESLbGA/SfGvRsR3aHdXLsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053631; c=relaxed/simple;
	bh=Fax4H41w25n5u6GELyum7Uq2SVrab6rxKUOtQRQV09k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AlgDG+7BSCxasS8sDHCY7LNXxC06aWMvEAIgzUCySkFc8winWH4lNc9obP7wnHcar4TX7Q/8JMKgsPkdmj2jNHWRk3s1tpnpDxStRoM7ogFOVhnOIw9U0HRtugWr19dzMKgRcyF7Jfow7db9Q8Utw8ouW/6duDOGIar6t+atiFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=VJhHzR1H; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=lrjMieh9; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1758053288; bh=/MfrKbQAcxo1P+UMUl3T75e
	+IPr/PFabDA6Xht/wT2k=; b=VJhHzR1HV/j+Qma4wsjArLbf21+pHVb08dOcDiqw8LpAPh3DW7
	Aob2lXQ04vwOeHD9V5oMflVdOkNpaV1THNjwFADz0LSc79WBQwqQsmFN5hyd27ms9lHDL/2TtF7
	uOkGOXvYvSezBsX15BsztxtlYbXSwGju2lk2LE1/07mpsIN6FVry7UYGPtPZf7oPZDCBhJ9FdIg
	c4HBuFNwkfNSZlSJZ/0BGGIbinJV2HXNvEKKgQCi+8824Lxc0RLiaa/Ajw59+MzzlLQAWFlL4jT
	B/nIQ2+i3gMyag9SMjMw10NW/5FNfZ0xzMbOxte4/9NnER1yZS7471JRO3R4izUDu5A==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1758053288; bh=/MfrKbQAcxo1P+UMUl3T75e
	+IPr/PFabDA6Xht/wT2k=; b=lrjMieh9dKOkoNobhZqp7S+144r6DdCdWyAK9MOlkepG/rYvIZ
	q8YOhzqs8AP/NmjvkxP7ydLOAuIGOChsDdAA==;
From: Dang Huynh <dang.huynh@mainlining.org>
Date: Wed, 17 Sep 2025 03:07:19 +0700
Subject: [PATCH 02/25] drivers: gpio: rda: Make IRQ optional
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-rda8810pl-drivers-v1-2-74866def1fe3@mainlining.org>
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

Not all GPIO have IRQ. When we use this driver with
GPIOC (handled by modem) we get:

rda-gpio 11a08000.gpioc: error -ENXIO: IRQ index 0 not found

Let's mark IRQ as optional so this error doesn't show up.

Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
 drivers/gpio/gpio-rda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-rda.c b/drivers/gpio/gpio-rda.c
index bcd85a2237a532b875df9470d972ac88b95a91cc..b4db8553a2371ae407fdb7e681d0f82c4d9f74b7 100644
--- a/drivers/gpio/gpio-rda.c
+++ b/drivers/gpio/gpio-rda.c
@@ -229,7 +229,7 @@ static int rda_gpio_probe(struct platform_device *pdev)
 	 * RDA8810PL, GPIOC doesn't support interrupt. So we must handle
 	 * those also.
 	 */
-	rda_gpio->irq = platform_get_irq(pdev, 0);
+	rda_gpio->irq = platform_get_irq_optional(pdev, 0);
 
 	rda_gpio->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rda_gpio->base))

-- 
2.51.0


