Return-Path: <dmaengine+bounces-6465-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40519B53E48
	for <lists+dmaengine@lfdr.de>; Thu, 11 Sep 2025 23:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77E7F5A7FA0
	for <lists+dmaengine@lfdr.de>; Thu, 11 Sep 2025 21:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859012DF14C;
	Thu, 11 Sep 2025 21:57:08 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034C92E6CBB
	for <dmaengine@vger.kernel.org>; Thu, 11 Sep 2025 21:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757627828; cv=none; b=HTy47O5JUTbXrpZQPYyfZq7gf7c19d1kybiiM78B0QXOnC9hdkKpMMsAxGWqVube1JFMzujlcnFWikgf1fRocSQCNvKhIP9EaBTVjLfZ1oBezS3tRecXOt4IZ1YJjczPOLucOCJzw7IAGqM9z2bOzmX0UO4BY5M9CEteb+N04CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757627828; c=relaxed/simple;
	bh=CsgSMovVoDnzJjuEAN8azFQLgpLqXfWaErM5h/J1l1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kT90fxvK6uwPnyIvT1Iw0FYaK8/5JIgkOZtz3tLSHDx0p9Or03u0FN2nTiWDSU9ME7GYo17v9aCBIhVB4imB1J7uAgSCwWWpYt9ADGgLkbba+5DAUbPCDxqw0pylYYQStO0K/iieox9DjPPM+LpoM3+NJ3+fEQzTKMdaj8Y0ldk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1uwpHe-0004g5-3h; Thu, 11 Sep 2025 23:56:50 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Thu, 11 Sep 2025 23:56:44 +0200
Subject: [PATCH v2 03/10] dmaengine: imx-sdma: drop legacy device_node np
 check
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-v6-16-topic-sdma-v2-3-d315f56343b5@pengutronix.de>
References: <20250911-v6-16-topic-sdma-v2-0-d315f56343b5@pengutronix.de>
In-Reply-To: <20250911-v6-16-topic-sdma-v2-0-d315f56343b5@pengutronix.de>
To: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jiada Wang <jiada_wang@mentor.com>
Cc: dmaengine@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Marco Felsch <m.felsch@pengutronix.de>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org

The legacy 'if (np)' was required in past where we had pdata and dt.
Nowadays the driver binds only to dt platforms. So using a new kernel
but still use pdata is not possible, therefore we can drop the legacy
'if' code path.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/dma/imx-sdma.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 56daaeb7df03986850c9c74273d0816700581dc0..dab3589e1c8d9efe06e16925c53554f8e22ce679 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2355,11 +2355,9 @@ static int sdma_probe(struct platform_device *pdev)
 			vchan_init(&sdmac->vc, &sdma->dma_device);
 	}
 
-	if (np) {
-		sdma->iram_pool = of_gen_pool_get(np, "iram", 0);
-		if (sdma->iram_pool)
-			dev_info(&pdev->dev, "alloc bd from iram.\n");
-	}
+	sdma->iram_pool = of_gen_pool_get(np, "iram", 0);
+	if (sdma->iram_pool)
+		dev_info(&pdev->dev, "alloc bd from iram.\n");
 
 	ret = sdma_init(sdma);
 	if (ret)
@@ -2399,12 +2397,10 @@ static int sdma_probe(struct platform_device *pdev)
 		goto err_init;
 	}
 
-	if (np) {
-		ret = of_dma_controller_register(np, sdma_xlate, sdma);
-		if (ret) {
-			dev_err(&pdev->dev, "failed to register controller\n");
-			goto err_register;
-		}
+	ret = of_dma_controller_register(np, sdma_xlate, sdma);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register controller\n");
+		goto err_register;
 	}
 
 	/*

-- 
2.47.3


