Return-Path: <dmaengine+bounces-4189-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A63FA1B459
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2025 12:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F9C2188955F
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2025 11:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CDA1CD1F6;
	Fri, 24 Jan 2025 11:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="eCx0mhch"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E871770815;
	Fri, 24 Jan 2025 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737716555; cv=none; b=bn3oVfskLLumkULMptyZSlsOH72NqdF922+P0AaTnFmgFKac49cZj7W3jV8h6x5+xM7wxsSEpJ2BQ2Hw6BueSWLs6VB9k8T3KbxKjg+/GsgzyneBM6eluncn+5xb9llQvSE62a/2CfXZNbiK8dKdKqtEK7fBvZQSiQ90HpnnN3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737716555; c=relaxed/simple;
	bh=FEE7451RcyEhJQ/0mTfNk00bCVbQpbyoiWHqx/Ns0cU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RRanA6QeYllCSYtMBCP27Md2nFi1CNBwpc3OplLbeZP/4/d7z6FAgwkylbijqy7hQ72tY00VCLqjkwvnJ4zZy/di7pk3bjbD4WhuuUi1YBUkYX4nZVP/B+Fl/JtJEyqqmfpoIjJXwOc8b6XyTgmQ5pX3KuDdV3AJPASG1vISE1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=eCx0mhch; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from ldvnode.intra.ispras.ru (unknown [10.10.2.153])
	by mail.ispras.ru (Postfix) with ESMTPSA id 50C3F40755EB;
	Fri, 24 Jan 2025 11:02:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 50C3F40755EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1737716543;
	bh=bgxcuYDowjlsEYydE8TlEeb5J1SSF1ngDNpFyOAjl9s=;
	h=From:To:Cc:Subject:Date:From;
	b=eCx0mhch/orcrt7weuS0cgz9iHIwTd+wFjNvaR1IaFWds1WlockM+x01+zOrMBO9z
	 ECaOfUnSQ+V842mOsd/rjfmAbNC3ltgAeobWzHOMNvBYki89rwSoR4rHLsFnOfIROT
	 XbWJeFn2n/yMLTvx6URoRUmRT1PM3HDqCi7dwtF4=
From: Vitalii Mordan <mordan@ispras.ru>
To: Vinod Koul <vkoul@kernel.org>
Cc: Vitalii Mordan <mordan@ispras.ru>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Vadim Mutilin <mutilin@ispras.ru>
Subject: [PATCH] dma: uniphier-mdmac: fix call balance of mdev->clk handling routines
Date: Fri, 24 Jan 2025 14:02:13 +0300
Message-Id: <20250124110213.1285417-1-mordan@ispras.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the clock mdev->clk was enabled in uniphier_mdmac_probe(), it should be
disabled in any path. If dmaengine_terminate_sync() returns an error in
uniphier_mdmac_remove(), the clock mdev->clk will not be disabled.

Use the devm_clk_get_enabled() helper function to ensure proper call
balance for mdev->clk.

Found by Linux Verification Center (linuxtesting.org) with Klever.

Fixes: 32e74aabebc8 ("dmaengine: uniphier-mdmac: add UniPhier MIO DMAC driver")
Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
---
 drivers/dma/uniphier-mdmac.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/uniphier-mdmac.c b/drivers/dma/uniphier-mdmac.c
index 7a99f86ecb5a..471dc2ef4781 100644
--- a/drivers/dma/uniphier-mdmac.c
+++ b/drivers/dma/uniphier-mdmac.c
@@ -401,16 +401,12 @@ static int uniphier_mdmac_probe(struct platform_device *pdev)
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
 	dma_cap_set(DMA_PRIVATE, ddev->cap_mask);
@@ -429,12 +425,12 @@ static int uniphier_mdmac_probe(struct platform_device *pdev)
 	for (i = 0; i < nr_chans; i++) {
 		ret = uniphier_mdmac_chan_init(pdev, mdev, i);
 		if (ret)
-			goto disable_clk;
+			return ret;
 	}
 
 	ret = dma_async_device_register(ddev);
 	if (ret)
-		goto disable_clk;
+		return ret;
 
 	ret = of_dma_controller_register(dev->of_node, of_dma_xlate_by_chan_id,
 					 ddev);
@@ -447,8 +443,6 @@ static int uniphier_mdmac_probe(struct platform_device *pdev)
 
 unregister_dmac:
 	dma_async_device_unregister(ddev);
-disable_clk:
-	clk_disable_unprepare(mdev->clk);
 
 	return ret;
 }
@@ -482,7 +476,6 @@ static void uniphier_mdmac_remove(struct platform_device *pdev)
 
 	of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&mdev->ddev);
-	clk_disable_unprepare(mdev->clk);
 }
 
 static const struct of_device_id uniphier_mdmac_match[] = {
-- 
2.25.1


