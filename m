Return-Path: <dmaengine+bounces-5173-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CDDAB7150
	for <lists+dmaengine@lfdr.de>; Wed, 14 May 2025 18:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA3821883AAE
	for <lists+dmaengine@lfdr.de>; Wed, 14 May 2025 16:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5991270EC5;
	Wed, 14 May 2025 16:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="ry8VG5Oc"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CBD1F1931;
	Wed, 14 May 2025 16:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747239993; cv=none; b=OtyDdExraXxmLSfLh3vf5cef3o/5L6Fs/M4/SrXAkDtvxtQDPpCYbmRQ1ucRzDieoMV0yFED+XHMChu0qKdbmpDRaAJ9i6kG8N5l200/KJhK6iaCLpttmfd8xCHaj0hQ+WrOFX0UnPtt3geG0vUHqBd0+6j34Zj1R4nOv8K1SG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747239993; c=relaxed/simple;
	bh=TDtZLkoLaoUO/Jbe9u7OfS6V+mxNZUjGDh0ct8/VoGI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CPzLO/O/0Rdk+3XLaj7N50mjUcBOslz9dmMXYDqpt9J2O/tG9Yqy8ZGuY+/LX1xpnb3oAgr0fumpkiAfwgMU5u+kBYnsw8G5jF60SS4b8Y8FAVpQ2S3GSS/MIZ1zCCbC0LPIZJZI8emHh8qzFLYXqKfCOeGAN0sEh9o9EIE3mGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=ry8VG5Oc; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 4ED2AA033A;
	Wed, 14 May 2025 18:18:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=w4cPfXtu/36KJ7d3kTTSCLSd63SmospMQ3mRMjbyoKo=; b=
	ry8VG5OcuPJBHR+i//bwjxyo9xo1z/joraaXLlw2pHbcgVnYShecYYDaR99bR/Q5
	+2emwNuXuHFE2G8WPp2DJSF2wxnxxVgudIb52miKCt3Dc6JshapMQMG2v1TG/YOe
	JNzvcAM/HR+F8Ee2qXFD0SQc1GAIneR2sGdMaaAnQAWJu4E1fsJMUzr/1VGlWPSV
	com2HeicAcgc4aVmWARvdWmHmvo4IW+1s5yvTm4FS3rAhrlf3zO/8F/tMWwDYxxD
	wv4xJaR2jk6M5drE+D9uQS+AVTnDnoCw+RA4dd7Bf/XFKihEPmnexpfUZ8WL6dS4
	ybBi+gRO/RgkXH2xH0Ley7xFSLStfSOhySYfP+oOHHsYV8NDWatcoMjbFo8jwseC
	HUfppXWhOrJc9zjXzUXcUUzlTpXEa/xGDUq8OQsQMYsfsnUB0MjsC0SdEItWZ6cg
	wCVS6JUiPsMzABDHJDExj8nxu6l4UodOMZNs/VZPpU4LrNLI0tNBWBbMZo/vOWrE
	bwKUdu76EgKQUC2gHQOnBjnpN3ILm7eJtLlWhmUqhWmc4ehw8zOvFrRluxmctDoa
	ywOloa/8Qkv9gMNHaPzmkWouAha6YpnuPoklx/wwnDqeg0syjmqS6VxgIKzfh6ic
	omHC23bLXgGfKWF4I4WfAEEUMWzHnK33jHnx9agDFdo=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, "Chen-Yu
 Tsai" <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, "Chen-Yu
 Tsai" <wens@csie.org>, Julian Calaby <julian.calaby@gmail.com>, Vinod Koul
	<vkoul@kernel.org>, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v9] dma-engine: sun4i: Simplify error handling in probe()
Date: Wed, 14 May 2025 18:18:01 +0200
Message-ID: <20250514161803.229600-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1747239491;VERSION=7991;MC=2098525897;ID=2622337256;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155D617160

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

base-commit: 3c018bf5a0ee3abe8d579d6a0dda616c3858d7b2
-- 
2.43.0



