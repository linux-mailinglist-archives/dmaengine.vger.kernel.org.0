Return-Path: <dmaengine+bounces-4766-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3C1A6CC02
	for <lists+dmaengine@lfdr.de>; Sat, 22 Mar 2025 20:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5365F164842
	for <lists+dmaengine@lfdr.de>; Sat, 22 Mar 2025 19:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81881F4E5F;
	Sat, 22 Mar 2025 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Ck3tfQ4j"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3C8376F1;
	Sat, 22 Mar 2025 19:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742672222; cv=none; b=g5FKjwk3CbUIAIQUDPgK7nxdCxYAly3NCW3VlANS2S7cXS9IatStnxA7YC/wuckG5BZ+eihAH/b0WfWgytslWe95ExpRgXt1zyHDjDuO1hvuHB4Zup4ENe30F0K2IGGSAXaFrCsyRBobk3X7ne/FGcrTh0+TWFAAo7A7aSHhNgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742672222; c=relaxed/simple;
	bh=6P/5M3cfeO70SoAkSbikp264g04xNxCwVXnkhgsl85I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z25lzN65m/qneTpdB8N85ODTgiCvPDNZ86OCwk0XOUcUQOrFb879sKPn2kh8oB5rUoV8IeMx/4umvtDwTwHzyVn5iMzunnAisyQmrDF7pl19H7ZvaWzYgiEKiFz5gLEUHK4OiWJu63u7S05Ija/Hcz3PAp3I7/ezO86t1bu8kk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Ck3tfQ4j; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 40A1FA02DE;
	Sat, 22 Mar 2025 20:36:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=3AynJL+dhUM+xX7FNGAWHa5xmA3IueurXqDLGr7/TpI=; b=
	Ck3tfQ4jZZJAybDWC18HN2SNgDmRFwISNwopn5TsMhMGNReE0xdJIWUyzOaVOy5Y
	hc/16gA3bWHtFqqkW2znbGRXq4NnuUjof3gk7ivQEgaCWSGGrEQ5TqrhszH7J4J2
	QSCmNDtTbBymVE06ufzqRO8g0rxoi4RqJK5OBCPuHCDZUc2aBgDMFP7ha4t16J1F
	vbU7aCdVauWKVqpeMwgrscOgE61u3XaMPpqot5JwxjaeKeOJgo9EphCLluMye18a
	EmUueOaRlWTU1NdbZjtQHhoCRSjJY+5KID6Yr//8iUyMHm7sNYpG01e+87l+ec+J
	Wqvg0QxTImQRA3msNkbBhYSQFvnDbz8SBhJtJf8NUWPJRmBuMX5xWl59tAHOiHJU
	LP0PORBhd1YxFroqBtqPX3WSHjaT08gttgVJ+9qkbOdKqsT5hRCSsYOy3JE6olPu
	t1L9+OofRkUoFSEpGnKlMI52bHkL7Al6HxZe4TrP1hj1kgP3FdYRgNnB6aV7UYxY
	7ORCBdgLmC5pJHE/vYqUKljpX6McFNxdjeEeQUZfDoryBHdA8cUSuyKYF/GR5pnq
	gfG+eL4X0TDBPPfqF4XEOseodiJFGxVgWUGdzHOtmNW+gjkO3FO05j6rDAJz+zZf
	PFlbRmyzEJfSSQad0YoeBbn5vSUWnA6QBx2wx2P1BpY=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, "Markus
 Elfring" <Markus.Elfring@web.de>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>, Chen-Yu Tsai <wens@kernel.org>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Vinod Koul
	<vkoul@kernel.org>, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v5] dma-engine: sun4i: Use devm functions in probe()
Date: Sat, 22 Mar 2025 20:36:40 +0100
Message-ID: <20250322193640.246382-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1742672217;VERSION=7987;MC=1970532306;ID=72972;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D948526D7266

Clean up error handling by using devm functions and dev_err_probe(). This
should make it easier to add new code, as we can eliminate the "goto
ladder" in probe().

Suggested-by: Chen-Yu Tsai <wens@kernel.org>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---

Notes:
    Changes in v2:
    * rebase on current next
    Changes in v3:
    * rebase on current next
    * collect Jernej's tag
    Changes in v4:
    * rebase on current next
    * collect Chen-Yu's tag
    Changes in v5:
    * reformat msg to 75 cols
    * keep `\n`s in error messages

 drivers/dma/sun4i-dma.c | 31 ++++++-------------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index 24796aaaddfa..59ecebfc8eed 100644
--- a/drivers/dma/sun4i-dma.c
+++ b/drivers/dma/sun4i-dma.c
@@ -1249,10 +1249,9 @@ static int sun4i_dma_probe(struct platform_device *pdev)
 	if (priv->irq < 0)
 		return priv->irq;
 
-	priv->clk = devm_clk_get(&pdev->dev, NULL);
+	priv->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(priv->clk)) {
-		dev_err(&pdev->dev, "No clock specified\n");
-		return PTR_ERR(priv->clk);
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk), "Couldn't start the clock\n");
 	}
 
 	if (priv->cfg->has_reset) {
@@ -1328,12 +1327,6 @@ static int sun4i_dma_probe(struct platform_device *pdev)
 		vchan_init(&vchan->vc, &priv->slave);
 	}
 
-	ret = clk_prepare_enable(priv->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "Couldn't enable the clock\n");
-		return ret;
-	}
-
 	/*
 	 * Make sure the IRQs are all disabled and accounted for. The bootloader
 	 * likes to leave these dirty
@@ -1344,32 +1337,23 @@ static int sun4i_dma_probe(struct platform_device *pdev)
 	ret = devm_request_irq(&pdev->dev, priv->irq, sun4i_dma_interrupt,
 			       0, dev_name(&pdev->dev), priv);
 	if (ret) {
-		dev_err(&pdev->dev, "Cannot request IRQ\n");
-		goto err_clk_disable;
+		return dev_err_probe(&pdev->dev, ret, "Cannot request IRQ\n");
 	}
 
-	ret = dma_async_device_register(&priv->slave);
+	ret = dmaenginem_async_device_register(&priv->slave);
 	if (ret) {
-		dev_warn(&pdev->dev, "Failed to register DMA engine device\n");
-		goto err_clk_disable;
+		return dev_err_probe(&pdev->dev, ret, "Failed to register DMA engine device\n");
 	}
 
 	ret = of_dma_controller_register(pdev->dev.of_node, sun4i_dma_of_xlate,
 					 priv);
 	if (ret) {
-		dev_err(&pdev->dev, "of_dma_controller_register failed\n");
-		goto err_dma_unregister;
+		return dev_err_probe(&pdev->dev, ret, "Failed to register translation function\n");
 	}
 
 	dev_dbg(&pdev->dev, "Successfully probed SUN4I_DMA\n");
 
 	return 0;
-
-err_dma_unregister:
-	dma_async_device_unregister(&priv->slave);
-err_clk_disable:
-	clk_disable_unprepare(priv->clk);
-	return ret;
 }
 
 static void sun4i_dma_remove(struct platform_device *pdev)
@@ -1380,9 +1364,6 @@ static void sun4i_dma_remove(struct platform_device *pdev)
 	disable_irq(priv->irq);
 
 	of_dma_controller_free(pdev->dev.of_node);
-	dma_async_device_unregister(&priv->slave);
-
-	clk_disable_unprepare(priv->clk);
 }
 
 static struct sun4i_dma_config sun4i_a10_dma_cfg = {
-- 
2.49.0



