Return-Path: <dmaengine+bounces-4164-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8E5A16DCB
	for <lists+dmaengine@lfdr.de>; Mon, 20 Jan 2025 14:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A55371888F5D
	for <lists+dmaengine@lfdr.de>; Mon, 20 Jan 2025 13:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC671E25E5;
	Mon, 20 Jan 2025 13:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="E1IJHDTv"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1EB1E22FC;
	Mon, 20 Jan 2025 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737381095; cv=none; b=JnCm0k1bW9CxezFfRegAVZLswGMBj2syMuHp8/RJuFYUFPiXAae2nJgXYm4F4GY3tL0DBK7bPU6iRM+qgLvesEOPsP40PeOQpBkt3wjPRurIbGl+fSPjd5ht6+pvhOsiteCzEf59JGW9unDwVMQuZ88fD3Qz71bJQ5gE7hljhiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737381095; c=relaxed/simple;
	bh=7YGT9tUI3LWn0O0I8oAOKgITzrbbgZqghLIdS12F2hU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z73FoB/b6VLk5p7D2yKZnUVK6R3IewJclovl/8N+9HxvTwKVY6iIrBz2ouv6N80aBwOkn4W4K6rCiIaaDwbXPNzfGo+muTze90vvH8sKWA18SKvYnAb/ZLvSPXSBq1enYvxXEGWtsvjIN//rFUe8Ki9cdq3je4g+2ui9kWZbMB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=E1IJHDTv; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from ldvnode.intra.ispras.ru (unknown [10.10.2.153])
	by mail.ispras.ru (Postfix) with ESMTPSA id 3AD74518E774;
	Mon, 20 Jan 2025 13:51:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 3AD74518E774
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1737381083;
	bh=4fySs5N2hrgu1v7dESWSAZhLMeG95wbe2hEzl7vKhpQ=;
	h=From:To:Cc:Subject:Date:From;
	b=E1IJHDTvqBHJm7dbbahgUlwSa4+5XcwV8y+7MbJUK7H9FBUNAAzSih34ogh7V84te
	 4/uFef46+gGG0HcU4JUlO9VNs1XkhrAjRoQ5MRTpHji2nXAbILIFVRbNC10tvF46Mo
	 9epbmpVXtnmVLWrsAHvHeqxWFmYNvbluk5Utp8a0=
From: Vitalii Mordan <mordan@ispras.ru>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Vitalii Mordan <mordan@ispras.ru>,
	Vinod Koul <vkoul@kernel.org>,
	Alex Smith <alex.smith@imgtec.com>,
	Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
	linux-mips@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Vadim Mutilin <mutilin@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH] dma: jz4780: fix call balance of jzdma->clk handling routines
Date: Mon, 20 Jan 2025 16:50:59 +0300
Message-Id: <20250120135059.302273-1-mordan@ispras.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the clock jzdma->clk was not enabled in jz4780_dma_probe(), it should
not be disabled in any path.

Conversely, if it was enabled in jz4780_dma_probe(), it must be disabled
in all error paths to ensure proper cleanup.

Use the devm_clk_get_enabled() helper function to ensure proper call
balance for jzdma->clk.

Found by Linux Verification Center (linuxtesting.org) with Klever.

Fixes: d894fc6046fe ("dmaengine: jz4780: add driver for the Ingenic JZ4780 DMA controller")
Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
---
 drivers/dma/dma-jz4780.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 100057603fd4..ff9c387fd8c1 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -896,15 +896,13 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	jzdma->clk = devm_clk_get(dev, NULL);
+	jzdma->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(jzdma->clk)) {
-		dev_err(dev, "failed to get clock\n");
+		dev_err(dev, "failed to get and enable clock\n");
 		ret = PTR_ERR(jzdma->clk);
 		return ret;
 	}
 
-	clk_prepare_enable(jzdma->clk);
-
 	/* Property is optional, if it doesn't exist the value will remain 0. */
 	of_property_read_u32_index(dev->of_node, "ingenic,reserved-channels",
 				   0, &jzdma->chan_reserved);
@@ -972,7 +970,7 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
-		goto err_disable_clk;
+		return ret;
 
 	jzdma->irq = ret;
 
@@ -980,7 +978,7 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 			  jzdma);
 	if (ret) {
 		dev_err(dev, "failed to request IRQ %u!\n", jzdma->irq);
-		goto err_disable_clk;
+		return ret;
 	}
 
 	ret = dmaenginem_async_device_register(dd);
@@ -1002,9 +1000,6 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 
 err_free_irq:
 	free_irq(jzdma->irq, jzdma);
-
-err_disable_clk:
-	clk_disable_unprepare(jzdma->clk);
 	return ret;
 }
 
@@ -1015,7 +1010,6 @@ static void jz4780_dma_remove(struct platform_device *pdev)
 
 	of_dma_controller_free(pdev->dev.of_node);
 
-	clk_disable_unprepare(jzdma->clk);
 	free_irq(jzdma->irq, jzdma);
 
 	for (i = 0; i < jzdma->soc_data->nb_channels; i++)
-- 
2.25.1


