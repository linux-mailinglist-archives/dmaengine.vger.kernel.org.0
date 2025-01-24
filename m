Return-Path: <dmaengine+bounces-4190-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B679BA1B45C
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2025 12:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368001889DB0
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2025 11:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E941CDA19;
	Fri, 24 Jan 2025 11:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="audw0Ohg"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F30D21A952;
	Fri, 24 Jan 2025 11:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737716571; cv=none; b=GAL6gX0XCMWHd4X1UEPnaDVU1i3yLi/T8dcVUc3hkjf5HoVI0k9dHfQbgvflmdLOwUtHjUj017JZanR3mIXTYJ4k1DhlqnscRQloKob8Saza30sMm50UPZSgOr1q+2OddW5am15DgcEFqq3OIqOmsw/7mYA3POInC4iB9zyUFEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737716571; c=relaxed/simple;
	bh=9XJ9C70z8Ww3U+ShAnD9VE5rOt6CcpHr4+Z3npdj4Ik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pg+Hg2ojECIqTiBsKyzRcCbmD36Ba1MXwgandYWcEkJHMd+LKgzP1SaBYJlOE0BfL62e7Swo1+lfQwmKZ0DJm+qodiDIyOOiK5FdqRvAQJ/ikq3G0BGY/zS1jqutcBO8Bf0HLrN7xUwgLWM+y+5MVkcTC7cH3RhWtruFpWRCSc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=audw0Ohg; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from ldvnode.intra.ispras.ru (unknown [10.10.2.153])
	by mail.ispras.ru (Postfix) with ESMTPSA id 0BC1640755EB;
	Fri, 24 Jan 2025 11:02:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 0BC1640755EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1737716567;
	bh=xS8sfpyKxEecLfJgThWHKU3Ix8NabgEGiuP5uDP/ji4=;
	h=From:To:Cc:Subject:Date:From;
	b=audw0OhgKV189hBmIGwdsFiT6XnENZxvdWhS8yD+r0GxiqxQ8Gz0uH7D/uGRH/QRg
	 wwlUwtw4XIZrWLSNm1acFni0WyisihC2bUvZqCb8Efj59Lvn+qb65yg/kaF+b3Alj+
	 6Ef+S+FmRjiBS15zhgKYkH9CbAP+fXTPhHJ2cIeY=
From: Vitalii Mordan <mordan@ispras.ru>
To: Vinod Koul <vkoul@kernel.org>
Cc: Vitalii Mordan <mordan@ispras.ru>,
	Taichi Sugaya <sugaya.taichi@socionext.com>,
	Takao Orito <orito.takao@socionext.com>,
	Jassi Brar <jaswinder.singh@linaro.org>,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Vadim Mutilin <mutilin@ispras.ru>
Subject: [PATCH] dma: milbeaut-hdmac: fix call balance of mdev->clk handling routines
Date: Fri, 24 Jan 2025 14:02:40 +0300
Message-Id: <20250124110240.1285500-1-mordan@ispras.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the clock mdev->clk was enabled in milbeaut_hdmac_probe(), it should be
disabled in any path. If dmaengine_terminate_sync() returns an error in
milbeaut_hdmac_remove(), the clock mdev->clk will not be disabled.

Use the devm_clk_get_enabled() helper function to ensure proper call
balance for mdev->clk.

Found by Linux Verification Center (linuxtesting.org) with Klever.

Fixes: 6c3214e698e4 ("dmaengine: milbeaut-hdmac: Add HDMAC driver for Milbeaut platforms")
Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
---
 drivers/dma/milbeaut-hdmac.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/milbeaut-hdmac.c b/drivers/dma/milbeaut-hdmac.c
index 9a5ec247ed6d..cc70928602af 100644
--- a/drivers/dma/milbeaut-hdmac.c
+++ b/drivers/dma/milbeaut-hdmac.c
@@ -476,16 +476,12 @@ static int milbeaut_hdmac_probe(struct platform_device *pdev)
 	if (IS_ERR(mdev->reg_base))
 		return PTR_ERR(mdev->reg_base);
 
-	mdev->clk = devm_clk_get(dev, NULL);
+	mdev->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(mdev->clk)) {
-		dev_err(dev, "failed to get clock\n");
+		dev_err(dev, "failed to get and enable clock\n");
 		return PTR_ERR(mdev->clk);
 	}
 
-	ret = clk_prepare_enable(mdev->clk);
-	if (ret)
-		return ret;
-
 	ddev = &mdev->ddev;
 	ddev->dev = dev;
 	dma_cap_set(DMA_SLAVE, ddev->cap_mask);
@@ -507,12 +503,12 @@ static int milbeaut_hdmac_probe(struct platform_device *pdev)
 	for (i = 0; i < nr_chans; i++) {
 		ret = milbeaut_hdmac_chan_init(pdev, mdev, i);
 		if (ret)
-			goto disable_clk;
+			return ret;
 	}
 
 	ret = dma_async_device_register(ddev);
 	if (ret)
-		goto disable_clk;
+		return ret;
 
 	ret = of_dma_controller_register(dev->of_node,
 					 milbeaut_hdmac_xlate, mdev);
@@ -525,8 +521,6 @@ static int milbeaut_hdmac_probe(struct platform_device *pdev)
 
 unregister_dmac:
 	dma_async_device_unregister(ddev);
-disable_clk:
-	clk_disable_unprepare(mdev->clk);
 
 	return ret;
 }
@@ -560,7 +554,6 @@ static void milbeaut_hdmac_remove(struct platform_device *pdev)
 
 	of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&mdev->ddev);
-	clk_disable_unprepare(mdev->clk);
 }
 
 static const struct of_device_id milbeaut_hdmac_match[] = {
-- 
2.25.1


