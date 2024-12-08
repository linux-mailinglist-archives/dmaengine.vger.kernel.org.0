Return-Path: <dmaengine+bounces-3923-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7162B9E850D
	for <lists+dmaengine@lfdr.de>; Sun,  8 Dec 2024 13:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D525281566
	for <lists+dmaengine@lfdr.de>; Sun,  8 Dec 2024 12:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC58A147C91;
	Sun,  8 Dec 2024 12:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="XmV1O4Sf"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4087A148FF5;
	Sun,  8 Dec 2024 12:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733661813; cv=none; b=ZRlYnHw3ZUzBtBs5dSF5QAwzfG+N+8kgPEdLIsnFBqkqGIqfwHj9zMBeqw7UAlgC1DX1g2epZ2hH1nD+uThAkw6p70VwmHjRsDwGdmeTHwsu9n3JOv4dX34++uii4kk06XKT01j0j0ZPc6hlsIRqOp7T7GCtcZn/jWc1ZpysrGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733661813; c=relaxed/simple;
	bh=lk5PCBXILsORnwats/dVp90MjS9CyLpDw6Nievrao44=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bbfybWB3mH4PSw28+7QPbUR8oQYzCtOX3WQfw56ZwEMSjIGKXhLwYeGgj2QLV3YDMj0UdBIFfKOPZQhlRns9sf8tNvLB3ThUsAzzRpPMoZt90lNZCKj3s3oc0vbRKIIXcRHv+YB8fuTXmsczmZFjk5bs97wER+iBTq5OabU0R+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=XmV1O4Sf; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 5AD85A00A5;
	Sun,  8 Dec 2024 13:43:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=i05HWD7K+WuvMLkFj25EzNitUBPDdxgibXgH/rNxbxU=; b=
	XmV1O4SfUox3W6oPoc03JCuTPlBy0yzLF23OUJdXuPH9o3z/QNBGqtjmI36AC0kY
	xTCLxa8WfR7D05I9/EJ1m+6Ai68po3vVgEGYANgP8qy9cIzbOqdTydgppaV8k18v
	bXx5BX3bFv3t2l/hmU0YSqQR8DpiQPdxDJlyej6OSkclJbA18/Rt5UOO3zydl6+J
	vKAfQ/rSs0i/o+SdwjJIOqvXZL/wI8M+X2H5Ii2RQktXv4Ou7cgPF2EKrj0ZnXgT
	bcOGh4+KdsFCGflUFLvY/gjePNqJ5z2oe7X1FDydhHRMh1RaAqaCwgbh2jG535V1
	JRKFZtp7r//iHDHEMHyfVG1n2TMBV1D6mNBPSRS179abhP+wLh3YgSXxAMbdz6bQ
	zcVsVT9Iba7/4i6LxMoQ9Q5COi1nC6Qe+a0apx4qDDCnc9Mb3G6aVMFHg4okkGq/
	8iY7vLsific30uT3ne3OHz2t9jjeNmN+j2rMo079gNQPIOJU4Zn3RKQWilQqQlff
	ztjIMWoRPDLUMBo9PX3cLfxxCKLhS27VdOL0fNizsbjUIO1MqLke4hLhF5DOGQFc
	KHDY9F0hADNFUrINLuUPCPYkJI4brW6+vOFaWiUfNQfBoCu9kbWxTiDm4JyLVXUf
	V29+PaA8o8SpsdbF/eCKtJloy1FPGit2ODts7PuLk30=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, "Chen-Yu
 Tsai" <wens@kernel.org>, Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai
	<wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
	<samuel@sholland.org>
Subject: [PATCH] dma-engine: sun4i: Use devm functions in probe()
Date: Sun, 8 Dec 2024 13:36:19 +0100
Message-ID: <20241208123619.1007413-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733661800;VERSION=7982;MC=3252012965;ID=300616;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D9485562766B

Clean up error handling by using devm functions
and dev_err_probe(). This should make it easier
to add new code, as we can eliminate the "goto
ladder" in probe().

Suggested-by: Chen-Yu Tsai <wens@kernel.org>
Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
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
2.34.1



