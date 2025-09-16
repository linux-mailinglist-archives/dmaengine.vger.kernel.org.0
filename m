Return-Path: <dmaengine+bounces-6559-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 162F8B5A267
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 22:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27BC584E18
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 20:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056D5320A02;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlVltMwP"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B40B2E0927;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054325; cv=none; b=bHKc77ZXcM5daU90cE2kowdHCOk7xNHSpgmOJL9L1X82TnwIlJbe9Quk5a0WCK0bhIipiGI8j3Ib3dzvzu0LQukPGGqJrGtzGs/n8du4v94S38rG5pi2pGqCj7vcDDloWt4qN4FP83jyvZbgWdw+zu6x0n5aBQ46/PlXBRaJ9yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054325; c=relaxed/simple;
	bh=X893mXdG5jDAoakU25w6AZ+PiFmR96PaE7s6Wnh4JEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=elPDETkKqyHLOJX343IQkt2ZX/hEpCTDI8ol+IjV3ExbRqrKlaQMlAA5FpqBPY9+1hnilRrOrIqHQVCRlnFGJxua1Q0kaMgyx5KdkvEeD3kavaip0b0+7sd4G6MeH2w2WpNxQ6eKXsw2N3WN5+OPPeDZo7tq2ury/Q2c7h+Z2xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlVltMwP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 125A4C4CEF0;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758054325;
	bh=X893mXdG5jDAoakU25w6AZ+PiFmR96PaE7s6Wnh4JEE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XlVltMwPC7nNczwGoEIxDvOnbVd/T0P9HRB68TaGLfkQvRojcP444NbvGrx+Mmvc6
	 nut9J3OGDCfFVNbyFfSsZ5nbOlpjbdU8QlP4Tr1Uvljn6ija86f6oWLHr1lEGY9NJS
	 3gdGtPcKjCipIcxglJPeaLYXA36bDP8ICq1GQWxioMhUypE4ubq6DnlSzgSm5RpyJ7
	 YvbQkhArhH2IGsJ+jCGM4Bm34kk9lFkDWd+biHQQ8a9QeMp03jyGZn5WW+jg6ph2eM
	 oO+WD4aev9S2dRQxXSWq95nkmkeoyeGlNtuwjRm3ztPBEKWRL/7cmlDvWBLM1QBLkl
	 /FHvZPlMbaysQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017D1CAC59D;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
From: Dang Huynh via B4 Relay <devnull+dang.huynh.mainlining.org@kernel.org>
Date: Wed, 17 Sep 2025 03:24:59 +0700
Subject: [PATCH 02/25] drivers: gpio: rda: Make IRQ optional
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-rda8810pl-drivers-v1-2-9ca9184ca977@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758054322; l=961;
 i=dang.huynh@mainlining.org; s=20250917; h=from:subject:message-id;
 bh=Fax4H41w25n5u6GELyum7Uq2SVrab6rxKUOtQRQV09k=;
 b=8NPdXoYR6QMjpq7tWNquTNmGzt1Zr4mpACDx1zfor3wYw4pn/Zqu2jUfRZ99rq5r4TeUYxPub
 D4syMEvbMWWAYGlhGdETHjrWpszpet/JuedVRzqk5g7xv9O7nsvn0Hz
X-Developer-Key: i=dang.huynh@mainlining.org; a=ed25519;
 pk=RyzH4CL4YU/ItXYUurA51EVBidfx4lIy8/E4EKRJCUk=
X-Endpoint-Received: by B4 Relay for dang.huynh@mainlining.org/20250917
 with auth_id=526
X-Original-From: Dang Huynh <dang.huynh@mainlining.org>
Reply-To: dang.huynh@mainlining.org

From: Dang Huynh <dang.huynh@mainlining.org>

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



