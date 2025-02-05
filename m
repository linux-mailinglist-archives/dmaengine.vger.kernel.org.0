Return-Path: <dmaengine+bounces-4312-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1618EA297E2
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 18:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7985218873E4
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 17:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F84208989;
	Wed,  5 Feb 2025 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="kIEwVyTn"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74901FBEBF;
	Wed,  5 Feb 2025 17:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738777559; cv=none; b=PMlk4sbVHuNhPhz9njxsO+K844Ca9uLzsXURJLZquzSZDQ5jwWcMJ/paMDuwjJEUVNewaL/WFF6Pl0WIlQHc25RsmERNyl//hg/plC4zn3ECwRFBtN/fLVzSTzu0l4n4pRufL5mtnQrt203SlQyldber5wUlrPBPiEAHg3mam/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738777559; c=relaxed/simple;
	bh=z96CKr6jknS+Hxu/D84R57aD24diCTrCk7EtoEtNpsU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rNFTKxxuwui6irajbRBpHj2Bw8QDfIJ7pO4ViSGcEiXmxPXrxoT93pARylKNeDBeTkq8ZaMKYs/n5zp5fYabsCZbnSfVBzbrRul8Q6pMXKGk4PYApZLQR2vRTIlikumKzrz94epjzMukPGStiqFneiwDCO89+zHl7CFQugOpUDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=kIEwVyTn; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 2CBB9A0748;
	Wed,  5 Feb 2025 18:36:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=Rn6yddGTL+4r9BPnRCa7YNZbMZP/n2LoEprLl201Fhg=; b=
	kIEwVyTn98fyHeB3ZPrtD11ZqobExsQeb9IkBVpo6AJPfeKxBLtFl5YPqyKDk196
	K1ZRHGJtpBMIoJr2r3l4eRHbfVCjWkdMexBglv4viBCke4Xf7t/I47oYW8p7yo2p
	/S4GOZvNuQWjp+KZAL9BPXrw6WiXlfaFbiT1yN+oDAtbUnHe3uSJFafrfVuDIfl3
	F/8iHKneQUtkaWbIqN1zF9viyteAJAIuBHH1QuMcn8KF9bSvKDC2E4YVTU+6h/AB
	K0Vwkwqk5JIa6xblQJ0eI1oreStRhF8+Mczx2qbjm3HTNl8a8g71dzSY6sZZh6zU
	ibodccHUCc82AtIn60S2Zj/sHcMfCC76+O9ZStQmqiKzuYDSw6yGUZisJTXYow1l
	oXvbGA5e8E7UsBD2Pt7AL3t9hnhKUO7JTeI8YFnP3UVF4l9vH+txvGLiBVwvHA5W
	n949X020wpvNpjPuIseVRHy2hiBgsKeH7/QQIJV4NR1/9Doep76tkAxlb8kGxJB5
	Wcepx7y4q9ATiL6ddDTFm8wUr9GdoLD+v8hI2rdRH20flJbLt5nwYGUVMVeR4qTZ
	EwkcEV8S44DPThV0Drmr8tqP3JT4ez6CbT6kTY996uwQMPVILLDcA00vLwO2k/lL
	ph6yWXu1yGfb4NhFRM33RzN/bATuqt2bFZ2fvWjnURc=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, "Chen-Yu
 Tsai" <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Vinod
 Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Samuel Holland
	<samuel@sholland.org>
Subject: [PATCH v3] dma-engine: sun4i: Use devm functions in probe()
Date: Wed, 5 Feb 2025 18:36:30 +0100
Message-ID: <20250205173630.112020-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1738777013;VERSION=7984;MC=1924755684;ID=266573;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852667D60

Clean up error handling by using devm functions
and dev_err_probe(). This should make it easier
to add new code, as we can eliminate the "goto
ladder" in probe().

Suggested-by: Chen-Yu Tsai <wens@kernel.org>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---

Notes:
    Changes in v2:
    * rebase on current next
    Changes in v3:
    * rebase on current next
    * collect Jernej's tag

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

base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
-- 
2.48.1



