Return-Path: <dmaengine+bounces-639-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC0381C911
	for <lists+dmaengine@lfdr.de>; Fri, 22 Dec 2023 12:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD5E31C22064
	for <lists+dmaengine@lfdr.de>; Fri, 22 Dec 2023 11:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD10D1773E;
	Fri, 22 Dec 2023 11:28:08 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9996C17730;
	Fri, 22 Dec 2023 11:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 3BMBRbqR014972;
	Fri, 22 Dec 2023 19:27:37 +0800 (+08)
	(envelope-from Kaiwei.Liu@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx07.spreadtrum.com [10.0.1.12])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4SxPxn6z72z2QTSsR;
	Fri, 22 Dec 2023 19:21:17 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx07.spreadtrum.com
 (10.0.1.12) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Fri, 22 Dec
 2023 19:27:35 +0800
From: Kaiwei Liu <kaiwei.liu@unisoc.com>
To: Vinod Koul <vkoul@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin
 Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        kaiwei liu
	<liukaiwei086@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
Subject: [PATCH V2 1/2] dmaengine: sprd: delete enable operation in probe
Date: Fri, 22 Dec 2023 19:27:14 +0800
Message-ID: <20231222112714.9660-1-kaiwei.liu@unisoc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx07.spreadtrum.com (10.0.1.12)
X-MAIL:SHSQR01.spreadtrum.com 3BMBRbqR014972

From: "kaiwei.liu" <kaiwei.liu@unisoc.com>

In the probe of dma, it will allocate device memory and do some
initalization settings. All operations are only at the software
level. Furthermore, The current dma driver is applicable to two
DMA devices in different power domain. For some scenes, one of
the domain is power off and when you probe, enable the dma with
the domain power off may cause crash.

For example, one case is for audio co-processor and DMA serves for
it, dma's power domain is off during initialization since audio is
not used at that time, so we can not read/write DMA's register for
this kind of cases.

Signed-off-by: kaiwei.liu <kaiwei.liu@unisoc.com>
---
Change in V2:
-Fix typo in subject line
-Fix patches disjoint error
-modify commit message
-move pm_runtime_enable function before dma_async_device_register
---
 drivers/dma/sprd-dma.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 3f54ff37c5e0..cb48731d70b2 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -1203,16 +1203,9 @@ static int sprd_dma_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, sdev);
-	ret = sprd_dma_enable(sdev);
-	if (ret)
-		return ret;
 
-	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
-
-	ret = pm_runtime_get_sync(&pdev->dev);
-	if (ret < 0)
-		goto err_rpm;
+	pm_runtime_get_noresume(&pdev->dev);
 
 	ret = dma_async_device_register(&sdev->dma_dev);
 	if (ret < 0) {
@@ -1226,7 +1219,7 @@ static int sprd_dma_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_of_register;
 
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
 	return 0;
 
 err_of_register:
@@ -1234,8 +1227,6 @@ static int sprd_dma_probe(struct platform_device *pdev)
 err_register:
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-err_rpm:
-	sprd_dma_disable(sdev);
 	return ret;
 }
 
-- 
2.17.1


