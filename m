Return-Path: <dmaengine+bounces-41-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFED7DF226
	for <lists+dmaengine@lfdr.de>; Thu,  2 Nov 2023 13:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 079AA1C20DEE
	for <lists+dmaengine@lfdr.de>; Thu,  2 Nov 2023 12:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6F7168AF;
	Thu,  2 Nov 2023 12:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5C86FC3
	for <dmaengine@vger.kernel.org>; Thu,  2 Nov 2023 12:17:33 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850A8198;
	Thu,  2 Nov 2023 05:17:30 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 3A2CGti8023341;
	Thu, 2 Nov 2023 20:16:55 +0800 (+08)
	(envelope-from Kaiwei.Liu@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx07.spreadtrum.com [10.0.1.12])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4SLjRc6Jzjz2M9fbK;
	Thu,  2 Nov 2023 20:12:12 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx07.spreadtrum.com
 (10.0.1.12) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 2 Nov 2023
 20:16:54 +0800
From: Kaiwei Liu <kaiwei.liu@unisoc.com>
To: Vinod Koul <vkoul@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin
 Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        kaiwei liu
	<liukaiwei086@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
Subject: [PATCH 1/2] dmaengine: sprd: delete enable opreation in probe
Date: Thu, 2 Nov 2023 20:16:23 +0800
Message-ID: <20231102121623.31924-1-kaiwei.liu@unisoc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx07.spreadtrum.com (10.0.1.12)
X-MAIL:SHSQR01.spreadtrum.com 3A2CGti8023341

From: "kaiwei.liu" <kaiwei.liu@unisoc.com>

In the probe of dma, it will allocate device memory and do some
initalization settings. All operations are only at the software
level and don't need the DMA hardware power on. It doesn't need
to resume the device and set the device active as well. here
delete unnecessary operation.

Signed-off-by: kaiwei.liu <kaiwei.liu@unisoc.com>
---
 drivers/dma/sprd-dma.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 08fcf1ec368c..8ab5a9082fc5 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -1203,21 +1203,11 @@ static int sprd_dma_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, sdev);
-	ret = sprd_dma_enable(sdev);
-	if (ret)
-		return ret;
-
-	pm_runtime_set_active(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
-
-	ret = pm_runtime_get_sync(&pdev->dev);
-	if (ret < 0)
-		goto err_rpm;
 
 	ret = dma_async_device_register(&sdev->dma_dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "register dma device failed:%d\n", ret);
-		goto err_register;
+		return ret;
 	}
 
 	sprd_dma_info.dma_cap = sdev->dma_dev.cap_mask;
@@ -1226,16 +1216,11 @@ static int sprd_dma_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_of_register;
 
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
 	return 0;
 
 err_of_register:
 	dma_async_device_unregister(&sdev->dma_dev);
-err_register:
-	pm_runtime_put_noidle(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
-err_rpm:
-	sprd_dma_disable(sdev);
 	return ret;
 }
 
-- 
2.17.1


