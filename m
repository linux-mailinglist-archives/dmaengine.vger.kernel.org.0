Return-Path: <dmaengine+bounces-5332-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F31AD2F73
	for <lists+dmaengine@lfdr.de>; Tue, 10 Jun 2025 10:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31883172925
	for <lists+dmaengine@lfdr.de>; Tue, 10 Jun 2025 08:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87A42820A1;
	Tue, 10 Jun 2025 08:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="BwVtu7KJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F732281372;
	Tue, 10 Jun 2025 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749542597; cv=none; b=MGANyDb2PSa9OyDnGxTWQJN0WYZRN46nsoeEkGsCy0cyj9rtwbGgiYIpiYwPStEclIECas6OkveiUHx09aFggu73UrMs9hLD9jjKLnbb4yKVrkpieTd+DPVDJ4PyJejNw3d1p2a0zrMVRe0M/yHzo55eQXlID4AM9X0qXNK7xZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749542597; c=relaxed/simple;
	bh=6hPSXxbiNB/r5d4vGayoujrUtSU2sknxGGmKP7Jc10I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u0ybaVZib5IPpqm5uRAyMHp6x2RxuRQt5qMo6TtKP5Ur8NL85HcqJODAmYjWFk5hbOa1qpqwen2sjeB30CxJNTl8uCGiRNCqz6ufuJX2HXfH2Imc4LJjs3CY9dk3o2/bTKJfvVEen/wt2jejqt14kDe/abkMbaFoJpnZPrMlGpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=BwVtu7KJ; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id ABC41A0403;
	Tue, 10 Jun 2025 09:53:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=BrLuKpt34k4eRF8K2JaYhxjYQp6/DXYAraKWQecDxkU=; b=
	BwVtu7KJvkZLq3NFQtQpoHxTkl0s5vlHRzOuRUJvlmEyDDto2+D0IumMAJcl1PwY
	TBr/wQ1jakwI/FEkc37ggAlTnU5H1oqs5b/vdfgKalVi+ThJh6yM7nPC6QxwLuQe
	IpoaCODCOE1+y/YEyyBmMClXcRGzNblntf6QXOg+dao2U0IxOvN4O5NR6ic4j+WF
	Ck66dJh4IM1E6KItnYmYNNZeSV6OutEt2skJsLBxX49kllotGoXci1shVB3tW2ew
	QyHozECvTTLQPLnTniqMTiMHEAw0+7okZEY0ybYhBd0bBIKrtkVeMTJBcHpyJg9/
	3mY3vsuWZorLHGKOUqBffVLhQvELI1uoVTdIOmNXTahN/ROsErpzVK/g/XqhD/cu
	FbT1B6FeZI3TFXEu+6g55dpHKzqF6/idU4pQHtXZmBR2iPGt+zcfMTdGNGZmIWAv
	a9/jY4Ik1lI4ucBxI4qN5Bu/9H4bP9whPByO4UoXK61rY10JzKONqTP+KA4trd0g
	ctdM9m4QBizNmAVX4DSQyMKRnXQxyKT1n5AuWjC5f5IP2VaOWVwqEO5Z3eFJi9RG
	Qs10rHWwR11vbcy5OR5LRQ0BfO7et4clg/Ix9dEn2xbqQkjp0b24762/zwmVCfZB
	f+ScuKwAybOmjRWvOiSrY0K6t1HXQGmEy1egCfkKw8E=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, "Chen-Yu
 Tsai" <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, "Chen-Yu
 Tsai" <wens@csie.org>, Julian Calaby <julian.calaby@gmail.com>, Vinod Koul
	<vkoul@kernel.org>, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v10] dma-engine: sun4i: Simplify error handling in probe()
Date: Tue, 10 Jun 2025 09:53:13 +0200
Message-ID: <20250610075315.397810-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1749541997;VERSION=7993;MC=1286228445;ID=452015;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155D62776A

Clean up error handling by using devm functions and dev_err_probe(). This
should make it easier to add new code, as we can eliminate the "goto
ladder" in sun4i_dma_probe().

Suggested-by: Chen-Yu Tsai <wens@kernel.org>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Reviewed-by: Julian Calaby <julian.calaby@gmail.com>
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
    Changes in v6:
    * remove redundant braces
    * break lines to stay under 85 cols
    * reword subject and message
    Changes in v7:
    * rebase onto current next
    * collect Julian's tag
    Changes in v8:
    * rebase onto current next
    Changes in v9:
    * rebase onto current next
    Changes in v10:
    * rebase onto current next

 drivers/dma/sun4i-dma.c | 46 ++++++++++++-----------------------------
 1 file changed, 13 insertions(+), 33 deletions(-)

diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index 24796aaaddfa..00d2fd38d17f 100644
--- a/drivers/dma/sun4i-dma.c
+++ b/drivers/dma/sun4i-dma.c
@@ -1249,11 +1249,10 @@ static int sun4i_dma_probe(struct platform_device *pdev)
 	if (priv->irq < 0)
 		return priv->irq;
 
-	priv->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(priv->clk)) {
-		dev_err(&pdev->dev, "No clock specified\n");
-		return PTR_ERR(priv->clk);
-	}
+	priv->clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(priv->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk),
+				     "Couldn't start the clock\n");
 
 	if (priv->cfg->has_reset) {
 		priv->rst = devm_reset_control_get_exclusive_deasserted(&pdev->dev, NULL);
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
@@ -1343,33 +1336,23 @@ static int sun4i_dma_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(&pdev->dev, priv->irq, sun4i_dma_interrupt,
 			       0, dev_name(&pdev->dev), priv);
-	if (ret) {
-		dev_err(&pdev->dev, "Cannot request IRQ\n");
-		goto err_clk_disable;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Cannot request IRQ\n");
 
-	ret = dma_async_device_register(&priv->slave);
-	if (ret) {
-		dev_warn(&pdev->dev, "Failed to register DMA engine device\n");
-		goto err_clk_disable;
-	}
+	ret = dmaenginem_async_device_register(&priv->slave);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to register DMA engine device\n");
 
 	ret = of_dma_controller_register(pdev->dev.of_node, sun4i_dma_of_xlate,
 					 priv);
-	if (ret) {
-		dev_err(&pdev->dev, "of_dma_controller_register failed\n");
-		goto err_dma_unregister;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to register translation function\n");
 
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
@@ -1380,9 +1363,6 @@ static void sun4i_dma_remove(struct platform_device *pdev)
 	disable_irq(priv->irq);
 
 	of_dma_controller_free(pdev->dev.of_node);
-	dma_async_device_unregister(&priv->slave);
-
-	clk_disable_unprepare(priv->clk);
 }
 
 static struct sun4i_dma_config sun4i_a10_dma_cfg = {

base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.43.0



