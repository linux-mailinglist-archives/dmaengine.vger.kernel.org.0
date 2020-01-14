Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D510E13B4AE
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jan 2020 22:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgANVso (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jan 2020 16:48:44 -0500
Received: from inva020.nxp.com ([92.121.34.13]:55702 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbgANVs0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 14 Jan 2020 16:48:26 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C9F671A0A2F;
        Tue, 14 Jan 2020 22:48:23 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A03EF1A01F1;
        Tue, 14 Jan 2020 22:48:17 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2CDFD402BB;
        Wed, 15 Jan 2020 05:48:10 +0800 (SGT)
From:   Han Xu <han.xu@nxp.com>
To:     vkoul@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        esben@geanix.com, boris.brezillon@collabora.com
Cc:     festevam@gmail.com, linux-imx@nxp.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, han.xu@nxp.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] dmaengine: mxs: add the power management functions
Date:   Wed, 15 Jan 2020 05:44:00 +0800
Message-Id: <1579038243-28550-4-git-send-email-han.xu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579038243-28550-1-git-send-email-han.xu@nxp.com>
References: <1579038243-28550-1-git-send-email-han.xu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

add the power management functions and leverage the runtime pm for
system suspend/resume

Signed-off-by: Han Xu <han.xu@nxp.com>
---
 drivers/dma/mxs-dma.c | 97 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 90 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index b458f06f9067..251492c5ea58 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -25,6 +25,7 @@
 #include <linux/of_dma.h>
 #include <linux/list.h>
 #include <linux/dma/mxs-dma.h>
+#include <linux/pm_runtime.h>
 
 #include <asm/irq.h>
 
@@ -39,6 +40,8 @@
 #define dma_is_apbh(mxs_dma)	((mxs_dma)->type == MXS_DMA_APBH)
 #define apbh_is_old(mxs_dma)	((mxs_dma)->dev_id == IMX23_DMA)
 
+#define MXS_DMA_RPM_TIMEOUT 50 /* ms */
+
 #define HW_APBHX_CTRL0				0x000
 #define BM_APBH_CTRL0_APB_BURST8_EN		(1 << 29)
 #define BM_APBH_CTRL0_APB_BURST_EN		(1 << 28)
@@ -416,6 +419,7 @@ static int mxs_dma_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(chan);
 	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
+	struct device *dev = &mxs_dma->pdev->dev;
 	int ret;
 
 	mxs_chan->ccw = dma_alloc_coherent(mxs_dma->dma_device.dev,
@@ -431,9 +435,11 @@ static int mxs_dma_alloc_chan_resources(struct dma_chan *chan)
 	if (ret)
 		goto err_irq;
 
-	ret = clk_prepare_enable(mxs_dma->clk);
-	if (ret)
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enable clock\n");
 		goto err_clk;
+	}
 
 	mxs_dma_reset_chan(chan);
 
@@ -458,6 +464,7 @@ static void mxs_dma_free_chan_resources(struct dma_chan *chan)
 {
 	struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(chan);
 	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
+	struct device *dev = &mxs_dma->pdev->dev;
 
 	mxs_dma_disable_chan(chan);
 
@@ -466,7 +473,9 @@ static void mxs_dma_free_chan_resources(struct dma_chan *chan)
 	dma_free_coherent(mxs_dma->dma_device.dev, CCW_BLOCK_SIZE,
 			mxs_chan->ccw, mxs_chan->ccw_phys);
 
-	clk_disable_unprepare(mxs_dma->clk);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
 }
 
 /*
@@ -689,14 +698,32 @@ static enum dma_status mxs_dma_tx_status(struct dma_chan *chan,
 	return mxs_chan->status;
 }
 
-static int __init mxs_dma_init(struct mxs_dma_engine *mxs_dma)
+static int mxs_dma_init_rpm(struct mxs_dma_engine *mxs_dma)
 {
+	struct device *dev = &mxs_dma->pdev->dev;
+
+	pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(dev, MXS_DMA_RPM_TIMEOUT);
+	pm_runtime_use_autosuspend(dev);
+
+	return 0;
+}
+
+static int mxs_dma_init(struct mxs_dma_engine *mxs_dma)
+{
+	struct device *dev = &mxs_dma->pdev->dev;
 	int ret;
 
-	ret = clk_prepare_enable(mxs_dma->clk);
+	ret = mxs_dma_init_rpm(mxs_dma);
 	if (ret)
 		return ret;
 
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enable clock\n");
+		return ret;
+	}
+
 	ret = stmp_reset_block(mxs_dma->base);
 	if (ret)
 		goto err_out;
@@ -714,7 +741,8 @@ static int __init mxs_dma_init(struct mxs_dma_engine *mxs_dma)
 		mxs_dma->base + HW_APBHX_CTRL1 + STMP_OFFSET_REG_SET);
 
 err_out:
-	clk_disable_unprepare(mxs_dma->clk);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 	return ret;
 }
 
@@ -821,11 +849,13 @@ static int mxs_dma_probe(struct platform_device *pdev)
 			&mxs_dma->dma_device.channels);
 	}
 
+	platform_set_drvdata(pdev, mxs_dma);
+	mxs_dma->pdev = pdev;
+
 	ret = mxs_dma_init(mxs_dma);
 	if (ret)
 		return ret;
 
-	mxs_dma->pdev = pdev;
 	mxs_dma->dma_device.dev = &pdev->dev;
 
 	/* mxs_dma gets 65535 bytes maximum sg size */
@@ -879,9 +909,62 @@ static int mxs_dma_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int mxs_dma_pm_suspend(struct device *dev)
+{
+	int ret;
+
+	ret = pm_runtime_force_suspend(dev);
+
+	return ret;
+}
+
+static int mxs_dma_pm_resume(struct device *dev)
+{
+	struct mxs_dma_engine *mxs_dma = dev_get_drvdata(dev);
+	int ret;
+
+	ret = mxs_dma_init(mxs_dma);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+#endif
+
+int mxs_dma_runtime_suspend(struct device *dev)
+{
+	struct mxs_dma_engine *mxs_dma = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(mxs_dma->clk);
+
+	return 0;
+}
+
+int mxs_dma_runtime_resume(struct device *dev)
+{
+	struct mxs_dma_engine *mxs_dma = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(mxs_dma->clk);
+	if (ret) {
+		dev_err(&mxs_dma->pdev->dev, "failed to enable the clock\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops mxs_dma_pm_ops = {
+	SET_RUNTIME_PM_OPS(mxs_dma_runtime_suspend,
+			   mxs_dma_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(mxs_dma_pm_suspend, mxs_dma_pm_resume)
+};
+
 static struct platform_driver mxs_dma_driver = {
 	.driver		= {
 		.name	= "mxs-dma",
+		.pm = &mxs_dma_pm_ops,
 		.of_match_table = mxs_dma_dt_ids,
 	},
 	.id_table	= mxs_dma_ids,
-- 
2.17.1

