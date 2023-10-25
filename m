Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B97E7D6AEF
	for <lists+dmaengine@lfdr.de>; Wed, 25 Oct 2023 14:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbjJYMNR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Oct 2023 08:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbjJYMNQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 Oct 2023 08:13:16 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8D7129;
        Wed, 25 Oct 2023 05:13:13 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 39PCCt10005836;
        Wed, 25 Oct 2023 20:12:55 +0800 (+08)
        (envelope-from Kaiwei.Liu@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx07.spreadtrum.com [10.0.1.12])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4SFnl06JmRz2L033G;
        Wed, 25 Oct 2023 20:08:28 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx07.spreadtrum.com
 (10.0.1.12) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Wed, 25 Oct
 2023 20:12:54 +0800
From:   Kaiwei Liu <kaiwei.liu@unisoc.com>
To:     Vinod Koul <vkoul@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        kaiwei liu <liukaiwei086@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
Subject: [PATCH 2/3] dmaengine: sprd: delete enable opreation in probe
Date:   Wed, 25 Oct 2023 20:12:46 +0800
Message-ID: <20231025121246.9080-1-kaiwei.liu@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx07.spreadtrum.com (10.0.1.12)
X-MAIL: SHSQR01.spreadtrum.com 39PCCt10005836
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

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
index 0fa950dfa4f0..f8ed2f3f764b 100644
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

