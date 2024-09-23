Return-Path: <dmaengine+bounces-3210-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B4497F14B
	for <lists+dmaengine@lfdr.de>; Mon, 23 Sep 2024 21:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8276C1C217BF
	for <lists+dmaengine@lfdr.de>; Mon, 23 Sep 2024 19:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D9519F413;
	Mon, 23 Sep 2024 19:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b="kSWnXuKf"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.rosa.ru (mail.rosa.ru [176.109.80.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB73319FA8C;
	Mon, 23 Sep 2024 19:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.109.80.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727120376; cv=none; b=iKcueNmc0qUxtw7mjl+CheywimKP2JI5z9ndR/BLNezyvT9nnEjAzFm+/bVVoLOpKXNjwARLfQWqtjphkSft7szkdcpbSCEEaNZj6+DG04Q/aIvV72SU4qN0a6Ic9Lk46bHAr0xMFZOiirqdUmq11qTq7bYEvqUvonGuaqpOeCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727120376; c=relaxed/simple;
	bh=tzm/q3aWH4wPB6/rBkgg14lkdoRUR4sjEwuuMwDzRm8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aFHVU6PBpjPFymRpAEifOnjqzK3B7dA80pKbX7Z2G1At94gMGTCSYvGrnBVPT+Jez3RN47EdwNFJgxUsCvkuB2c/6FzAKMTdrVA9iaUZryDzeYdMLMGjtwoDxRePyveR7Xi0Bj23hRuP0AqycK0ZFxiM9mnBjACQLM37Bvu46VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rosa.ru; spf=pass smtp.mailfrom=rosa.ru; dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b=kSWnXuKf; arc=none smtp.client-ip=176.109.80.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rosa.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosa.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=rosa.ru; s=mail;
	bh=tzm/q3aWH4wPB6/rBkgg14lkdoRUR4sjEwuuMwDzRm8=;
	h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
	b=kSWnXuKfl54EsINi+Og56HIPy4zfBpiMqUagpVewetvL6PdRYYNjTh8J7sHroq7CcjCTSyvOR9u
	Y+RvIoP+KdQR8f7b+S853UQ3Hy7Q6lpbImv1EMLODjCJXOf/ZkCJ0IDP2IUK/GmIuAfDadXg/Lgd/
	Cq385XTe3s5GPjPB3Pk=
Received: from [194.9.26.89] (account m.arhipov@rosa.ru HELO localhost.localdomain)
  by mail.rosa.ru (CommuniGate Pro SMTP 6.4.1j)
  with ESMTPSA id 135295; Mon, 23 Sep 2024 22:39:19 +0300
From: Mikhail Arkhipov <m.arhipov@rosa.ru>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc: Mikhail Arkhipov <m.arhipov@rosa.ru>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] dmaengine: ti: edma: Check return value of of_dma_controller_register
Date: Mon, 23 Sep 2024 22:37:03 +0300
Message-Id: <20240923193703.36645-1-m.arhipov@rosa.ru>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If of_dma_controller_register() fails within the edma_probe() function,
the driver does not check the return value or log the failure. This
oversight can cause other drivers that rely on this DMA controller to fail
during their probe phase. Specifically, when other drivers call
of_dma_request_slave_channel(), they may receive an error code
-EPROBE_DEFER, causing their initialization to be delayed or fail without
clear logging of the root cause.

Add a check for the return value of of_dma_controller_register() in the
edma_probe() function. If the function returns an error, log an appropriate
error message and handle the failure by cleaning up resources and returning
the error code. This ensures that the failure is properly reported, which
aids in debugging and maintains system stability.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: dc9b60552f6a ("ARM/dmaengine: edma: Move of_dma_controller_register to the dmaengine driver")
Signed-off-by: Mikhail Arkhipov <m.arhipov@rosa.ru>
---
 drivers/dma/ti/edma.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 5f8d2e93ff3f..9fcbd97d346f 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2529,18 +2529,27 @@ static int edma_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(dev, "memcpy ddev registration failed (%d)\n",
 				ret);
-			dma_async_device_unregister(&ecc->dma_slave);
-			goto err_reg1;
+			goto err_unregister_dma_slave;
 		}
 	}
 
-	if (node)
-		of_dma_controller_register(node, of_edma_xlate, ecc);
+	if (node) {
+		ret = of_dma_controller_register(node, of_edma_xlate, ecc);
+		if (ret) {
+			dev_err(dev, "Failed to register DMA controller (%d)\n", ret);
+			goto err_unregister_dma_memcpy;
+		}
+	}

 	dev_info(dev, "TI EDMA DMA engine driver\n");
 
 	return 0;
 
+err_unregister_dma_memcpy:
+	if (ecc->dma_memcpy)
+		dma_async_device_unregister(ecc->dma_memcpy);
+err_unregister_dma_slave:
+	dma_async_device_unregister(&ecc->dma_slave);
 err_reg1:
 	edma_free_slot(ecc, ecc->dummy_slot);
 err_disable_pm:
-- 
2.39.3 (Apple Git-146)


