Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B77238C6AA
	for <lists+dmaengine@lfdr.de>; Fri, 21 May 2021 14:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhEUMlC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 May 2021 08:41:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5722 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbhEUMlC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 May 2021 08:41:02 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FmmLC1LX3zqV2T;
        Fri, 21 May 2021 20:36:03 +0800 (CST)
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 20:39:35 +0800
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 dggemi762-chm.china.huawei.com (10.1.198.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 21 May 2021 20:39:34 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <vkoul@kernel.org>, <orsonzhai@gmail.com>,
        <baolin.wang7@gmail.com>, <zhang.lyra@gmail.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] dmaengine: fix PM reference leak
Date:   Fri, 21 May 2021 20:58:22 +0800
Message-ID: <1621601902-33697-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggemi762-chm.china.huawei.com (10.1.198.148)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

pm_runtime_get_sync will increment pm usage counter even it failed.
Forgetting to putting operation will result in reference leak here.
Fix it by replacing it with pm_runtime_resume_and_get to keep usage
counter balanced.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/dma/sh/rcar-dmac.c | 2 +-
 drivers/dma/sprd-dma.c     | 4 ++--
 drivers/dma/stm32-dma.c    | 4 ++--
 drivers/dma/stm32-dmamux.c | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index d530c1b..6885b3d 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1913,7 +1913,7 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 
 	/* Enable runtime PM and initialize the device. */
 	pm_runtime_enable(&pdev->dev);
-	ret = pm_runtime_get_sync(&pdev->dev);
+	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "runtime PM get sync failed (%d)\n", ret);
 		return ret;
diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 0ef5ca8..65dde39 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -1203,7 +1203,7 @@ static int sprd_dma_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	ret = pm_runtime_get_sync(&pdev->dev);
+	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0)
 		goto err_rpm;
 
@@ -1238,7 +1238,7 @@ static int sprd_dma_remove(struct platform_device *pdev)
 	struct sprd_dma_chn *c, *cn;
 	int ret;
 
-	ret = pm_runtime_get_sync(&pdev->dev);
+	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index f54ecb1..7dd1d3d 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -1200,7 +1200,7 @@ static int stm32_dma_alloc_chan_resources(struct dma_chan *c)
 
 	chan->config_init = false;
 
-	ret = pm_runtime_get_sync(dmadev->ddev.dev);
+	ret = pm_runtime_resume_and_get(dmadev->ddev.dev);
 	if (ret < 0)
 		return ret;
 
@@ -1470,7 +1470,7 @@ static int stm32_dma_suspend(struct device *dev)
 	struct stm32_dma_device *dmadev = dev_get_drvdata(dev);
 	int id, ret, scr;
 
-	ret = pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/dma/stm32-dmamux.c b/drivers/dma/stm32-dmamux.c
index ef0d055..a421643 100644
--- a/drivers/dma/stm32-dmamux.c
+++ b/drivers/dma/stm32-dmamux.c
@@ -137,7 +137,7 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 
 	/* Set dma request */
 	spin_lock_irqsave(&dmamux->lock, flags);
-	ret = pm_runtime_get_sync(&pdev->dev);
+	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0) {
 		spin_unlock_irqrestore(&dmamux->lock, flags);
 		goto error;
@@ -336,7 +336,7 @@ static int stm32_dmamux_suspend(struct device *dev)
 	struct stm32_dmamux_data *stm32_dmamux = platform_get_drvdata(pdev);
 	int i, ret;
 
-	ret = pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0)
 		return ret;
 
@@ -361,7 +361,7 @@ static int stm32_dmamux_resume(struct device *dev)
 	if (ret < 0)
 		return ret;
 
-	ret = pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0)
 		return ret;
 
-- 
2.6.2

