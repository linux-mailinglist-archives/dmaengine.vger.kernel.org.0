Return-Path: <dmaengine+bounces-4770-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D58A6E0D1
	for <lists+dmaengine@lfdr.de>; Mon, 24 Mar 2025 18:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74A57167907
	for <lists+dmaengine@lfdr.de>; Mon, 24 Mar 2025 17:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB0B262815;
	Mon, 24 Mar 2025 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="N/We4BvY"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFD22641D1;
	Mon, 24 Mar 2025 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837426; cv=none; b=uEsvmst0Nn62BPHqpzpRKKxF3FDttdWFd6dA2QYnNW8LRgzp2C8bhYW+agPfImRcfsCd3LXB2cjshKlgLBvZK60oNTllnW000p6DO8DSuXP3vmBCiT5tBj0EA5YzM90yjih/f10qq1xyxVrX1BuKSZQs4afXbeBVVEPNC+efLQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837426; c=relaxed/simple;
	bh=a18JP2W8KQVW4PEFPdnixiYC42ZqHhBz7RYwa8V3mfM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kj2cF5TgkzbwEANBnzl7yR6UtnyjOnmWkILjqIXLpxFBzBmwlDUNsMTJGCmontEZBjjYDTKDiL05x2/w3M02ZytXjMjdAgAKWGAMiHl5+FK2JbSOizwezSeyIlM5zQBzu/uHhMGvyHgYF5/f3X2OfEp5F0AlfROIkURCG8ftbl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=N/We4BvY; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 4BB15A0611;
	Mon, 24 Mar 2025 18:21:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=sn+9WvrfHWY+2IqdbQcpXc2meRV7F6T0M7XWCp5U8+M=; b=
	N/We4BvY8xp9qmON0WwaSaZZNPVnV/yejxsPz9uP3dS7fmbOucHgc5Lwhkvurdtb
	hLt0ZsdhHzkY0N0kIJdUFqVqw022p4fNFukJe/qQ23crkUnfuwNqYR2IV94v5cXI
	1fu7/U8K4gNfEMMnPvMCS9Brc7JWkiD1vetg/jqfzrKWreKWM96mIWnbCQf2QuK4
	EhmWOHGz36PBv4NM107zb5+sdulhuKcucJTFK1sAZHW6W3yhexHWxxdcbtXU+Fc6
	ndC1ZBaExHo9xpPmvEyuryBisoKQE494Oou76iSRmyH6j//tBl3tGnXCzqnuTBTu
	0doMda47UZOfavOpy8ssII3vGdLqOZ/Ey+dCnu/kBvqeN31ZJH5aeeuBH/elocFh
	/v9hE8DH9Ohrc8FEqCtyxG06DBTHopfSX1LIELaREiEoGt2XNWh1FOg+qLwlnfMv
	A4oremgjR9wuiQyiyFBEp7w8xR8pW9ybQ7ytVyqIGysYU4EFLeiacQdM84//5E4N
	gbVtmHJBWAYLjI/nyeN8ZAnRPKMtzFnUmR3DGtOMI7DiClapOL+7drfkeg6LH37m
	bxXNZDlnmqtrnJP2pfFcu0dYepGU/isu4s2DyOQlSPkzvVZxt0HYQ//1zoZAiS9z
	5qBtvyusORs8TtLrW7jR1LmMmNWmDMvS76TRenHsctg=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, "Markus
 Elfring" <Markus.Elfring@web.de>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>, Chen-Yu Tsai <wens@kernel.org>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Vinod Koul
	<vkoul@kernel.org>, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v6] dma-engine: sun4i: Simplify error handling in probe()
Date: Mon, 24 Mar 2025 18:20:25 +0100
Message-ID: <20250324172026.370253-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1742836890;VERSION=7987;MC=2160210615;ID=85768;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D948526D7C62

Clean up error handling by using devm functions and dev_err_probe(). This
should make it easier to add new code, as we can eliminate the "goto
ladder" in sun4i_dma_probe().

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
    Changes in v6:
    * remove redundant braces
    * break lines to stay under 85 cols
    * reword subject and message

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
-- 
2.49.0



