Return-Path: <dmaengine+bounces-4109-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCC6A1039A
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jan 2025 11:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D38718892A4
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jan 2025 10:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CA41ADC94;
	Tue, 14 Jan 2025 10:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="FoDG2reu"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0932A1ADC67;
	Tue, 14 Jan 2025 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736849223; cv=none; b=G4h8HAA7qcpplMprFENfCJej+tpxzdej54vo6exXJ/iiq+2hIz0MsmJ8ZPkgUP6QtUYfKWPm6DHddVwXFSXbXNdG7rdduPUwkiw67snHWXJpSaZu223Fj3S1dSkW4ndkKGK2NxSdFA5DUgSO+OkUIzBj/RA4kMMhEeDtN3IfNRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736849223; c=relaxed/simple;
	bh=rut9CQJbIW6Hwwu90fhj9D15AM2r6nbMCF2jMU0iPc4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hZ6z3/MfaMI10Troa4EgZj2XkxiqmT7aO4llzDAg6iN9360PHl2tvW1ihbmzNr88eac1nDoXPIpLhJ8NzS0bk5mcyZMDoTRokwaXx71qbzlNf5noIJtN5H+HEv227lZtdmcjxdm7Ld+KIHZ4IqY4ZxYenT0fDkIIrfGUGz2cHlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=FoDG2reu; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 7245CA0D4B;
	Tue, 14 Jan 2025 11:06:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=Pm8MfIVlLVLaY2lTA2YqyxTx8zEL0e2MzoQv3DGG800=; b=
	FoDG2reu47xYbArOD2zGTMdYX8zVIpG+g4CIhqVxbEtMHsBFXYx9RcQfslUlKTk8
	5rPyU71T+bnu26Hd+4HTr6qoQ6YpmZQC8lR9qV6JEBEUu8Q39Q2Zy/K9LupAmp+b
	VBW8ik3ic5jinLhOIPoSR35bvq2zdaxvPP5njyJhaJPLPPmllipNA7umIQ91o3Tv
	UnC3/SigYL3AzvcIP2G/Yvlm17sHYCbiq5iAFuWI/ytAkRY0dAsHYjqAptFt10dg
	R9tGDlafO7PkwfFy3IxX0pX0Na2slC0DSgl0LE56u0A5GWP2sUp371rtw1c6yHuG
	dVfh12iifmjeDEGZyT9Z/h6XKZj96Ga0JMZqOluYn1l44LHGYBX6Mh6KCQgwBluU
	ds7O6l0oZFGsHS4EUypQX1wVJOuhqAZksOVcNcCOxg5OQmtzW/Eea0H6rIkKyNoz
	0BkvTFo4nsZ9A+H6iWF80liWGrXbPsDxKamNFv0IGMuQXRAaCIsomSW3qo/2dZ+G
	FcdBOzCUOw6q3eFutTeWRRgBrVzpcbyAmGM/9ZuKAPZL0GtQzDsx36TVg9Si7Y2u
	sppxjaLDpokkaWnBPThBcYLUbUx+kwpcZmeioMUg/hfKU3oubwRP13p40edNJwoM
	5vBd7Kcyy6NO/rJcghm7x2D99OKRpsmnShq6XIQC1RM=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, "Chen-Yu
 Tsai" <wens@kernel.org>, Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai
	<wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
	<samuel@sholland.org>
Subject: [PATCH v2] dma-engine: sun4i: Use devm functions in probe()
Date: Tue, 14 Jan 2025 11:05:05 +0100
Message-ID: <20250114100505.799288-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1736849218;VERSION=7983;MC=3794862646;ID=287078;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D9485264766B

Clean up error handling by using devm functions
and dev_err_probe(). This should make it easier
to add new code, as we can eliminate the "goto
ladder" in probe().

Suggested-by: Chen-Yu Tsai <wens@kernel.org>
Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---

Notes:
    Changes in v2:
    * rebase on current next

 drivers/dma/sun4i-dma.c | 31 ++++++-------------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index 24796aaaddfa..b10639720efd 100644
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
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk), "Couldn't start the clock");
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
+		return dev_err_probe(&pdev->dev, ret, "Cannot request IRQ");
 	}
 
-	ret = dma_async_device_register(&priv->slave);
+	ret = dmaenginem_async_device_register(&priv->slave);
 	if (ret) {
-		dev_warn(&pdev->dev, "Failed to register DMA engine device\n");
-		goto err_clk_disable;
+		return dev_err_probe(&pdev->dev, ret, "Failed to register DMA engine device");
 	}
 
 	ret = of_dma_controller_register(pdev->dev.of_node, sun4i_dma_of_xlate,
 					 priv);
 	if (ret) {
-		dev_err(&pdev->dev, "of_dma_controller_register failed\n");
-		goto err_dma_unregister;
+		return dev_err_probe(&pdev->dev, ret, "Failed to register translation function");
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
2.48.0



