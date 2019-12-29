Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F152712C2F7
	for <lists+dmaengine@lfdr.de>; Sun, 29 Dec 2019 15:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfL2O5O (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 29 Dec 2019 09:57:14 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33316 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfL2O4y (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 29 Dec 2019 09:56:54 -0500
Received: by mail-lj1-f193.google.com with SMTP id y6so23082734lji.0;
        Sun, 29 Dec 2019 06:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qda0WNYpRV+5EirA6AoP9JWL8S1KmaXxHr54oi+EycE=;
        b=YCzlAa0juZDUea22GSVQONvEXkJqZcte5A8F6fZdpVFhOVijl5uZU+N0ES/BV5mSw5
         BfDwzlitmvZlzKOOJw7JHRmxaS50KkIrZjork8ixBBaJuO/gwGD3P71Mo7nsakwYnTJp
         NjEBc1ufLjMWITjUnoH0YKUjvCJwEQOaYKNyMEGOFNkLLIZ2CnyRTbdxPj0F6VHA8ToT
         5ws/ZO7GbeAgVx8Ig2fW65EQ9av3d3A7e07ZVa7rcd+qw56lVMNnYxLaeHt3Lz4RbwkK
         mGIXJzzzVcxpjC2mDyLeU17mxa5ZnEz33JcgBJU8x/KUuuBiSVg2fOyfCQn8YyvjnDfA
         Qzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qda0WNYpRV+5EirA6AoP9JWL8S1KmaXxHr54oi+EycE=;
        b=gbiTE1e7H0x176lNSd398mJ1hJqpHd/Jb77JutnjMfD9qvOeRD4MY5r4dDvWna4SJ4
         n/QfP78HSwXVVRFES383DqKSVKBtL/Ps5lM/nrOJdmiG0sI01qMmoYoAB4aaj6U4iH3H
         p2m2FdioJsK+vELVB7Q3VOkc+3SmxqY5YLl6YGr7Y8kEp73eMNVevaNa9O2WzfZyYQoZ
         Rhqrt4GqWT3UFI35CJdwBj8Nf+LTw7AWIjmecoKxO1xVuDqitfng3ILTo+1pBmZJ6drT
         3u9C24rQWfGLX5z2B04zRkEa4CB1mqDrYx+/UXQMasneLqpb2npQ9fSlA51Wtdlctm/h
         XUGg==
X-Gm-Message-State: APjAAAWmPTjJOPTPuJozKtaJEBf/HG/uN3jwtIAGyTRsoNkMS6moMt7x
        w6Q73Wt1/nTg2O04yx9Y1+o=
X-Google-Smtp-Source: APXvYqx9fiVJVx+scfsNqUnzM1dJX/Zx/rnBfiFZOjt38HHAmjiYEMdD2X2W+0uYLNqyLOd+gOSX6w==
X-Received: by 2002:a2e:978d:: with SMTP id y13mr35271939lji.103.1577631411621;
        Sun, 29 Dec 2019 06:56:51 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g15sm11563944ljl.10.2019.12.29.06.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 06:56:51 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/12] dmaengine: tegra-apb: Remove runtime PM usage
Date:   Sun, 29 Dec 2019 17:55:21 +0300
Message-Id: <20191229145525.533-9-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191229145525.533-1-digetx@gmail.com>
References: <20191229145525.533-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There is no benefit from runtime PM usage for the APB DMA driver because
it enables clock at the time of channel's allocation and thus clock stays
enabled all the time in practice, secondly there is benefit from manually
disabled clock because hardware auto-gates it during idle by itself.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 76 +++++++++++------------------------
 1 file changed, 24 insertions(+), 52 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 48fc48d32064..f52feca05f09 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -21,7 +21,6 @@
 #include <linux/of_dma.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
-#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
 
@@ -266,8 +265,6 @@ static inline struct device *tdc2dev(struct tegra_dma_channel *tdc)
 }
 
 static dma_cookie_t tegra_dma_tx_submit(struct dma_async_tx_descriptor *tx);
-static int tegra_dma_runtime_suspend(struct device *dev);
-static int tegra_dma_runtime_resume(struct device *dev);
 
 /* Get DMA desc from free list, if not there then allocate it.  */
 static struct tegra_dma_desc *tegra_dma_desc_get(struct tegra_dma_channel *tdc)
@@ -1280,22 +1277,15 @@ tegra_dma_prep_dma_cyclic(struct dma_chan *dc, dma_addr_t buf_addr,
 static int tegra_dma_alloc_chan_resources(struct dma_chan *dc)
 {
 	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
-	struct tegra_dma *tdma = tdc->tdma;
-	int ret;
 
 	dma_cookie_init(&tdc->dma_chan);
 
-	ret = pm_runtime_get_sync(tdma->dev);
-	if (ret < 0)
-		return ret;
-
 	return 0;
 }
 
 static void tegra_dma_free_chan_resources(struct dma_chan *dc)
 {
 	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
-	struct tegra_dma *tdma = tdc->tdma;
 	struct tegra_dma_desc *dma_desc;
 	struct tegra_dma_sg_req *sg_req;
 	struct list_head dma_desc_list;
@@ -1331,7 +1321,6 @@ static void tegra_dma_free_chan_resources(struct dma_chan *dc)
 		list_del(&sg_req->node);
 		kfree(sg_req);
 	}
-	pm_runtime_put(tdma->dev);
 
 	tdc->slave_id = TEGRA_APBDMA_SLAVE_ID_INVALID;
 }
@@ -1431,27 +1420,6 @@ static int tegra_dma_probe(struct platform_device *pdev)
 
 	spin_lock_init(&tdma->global_lock);
 
-	pm_runtime_enable(&pdev->dev);
-	if (!pm_runtime_enabled(&pdev->dev))
-		ret = tegra_dma_runtime_resume(&pdev->dev);
-	else
-		ret = pm_runtime_get_sync(&pdev->dev);
-
-	if (ret < 0)
-		goto err_pm_disable;
-
-	/* Reset DMA controller */
-	reset_control_assert(tdma->rst);
-	udelay(2);
-	reset_control_deassert(tdma->rst);
-
-	/* Enable global DMA registers */
-	tdma_write(tdma, TEGRA_APBDMA_GENERAL, TEGRA_APBDMA_GENERAL_ENABLE);
-	tdma_write(tdma, TEGRA_APBDMA_CONTROL, 0);
-	tdma_write(tdma, TEGRA_APBDMA_IRQ_MASK_SET, 0xFFFFFFFFul);
-
-	pm_runtime_put(&pdev->dev);
-
 	INIT_LIST_HEAD(&tdma->dma_dev.channels);
 	for (i = 0; i < cdata->nr_channels; i++) {
 		struct tegra_dma_channel *tdc = &tdma->channels[i];
@@ -1463,9 +1431,8 @@ static int tegra_dma_probe(struct platform_device *pdev)
 
 		irq = platform_get_irq(pdev, i);
 		if (irq < 0) {
-			ret = irq;
 			dev_err(&pdev->dev, "No irq resource for chan %d\n", i);
-			goto err_pm_disable;
+			return irq;
 		}
 
 		snprintf(tdc->name, sizeof(tdc->name), "apbdma.%d", i);
@@ -1475,7 +1442,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"request_irq failed with err %d channel %d\n",
 				ret, i);
-			goto err_pm_disable;
+			return ret;
 		}
 
 		tdc->dma_chan.device = &tdma->dma_dev;
@@ -1496,6 +1463,20 @@ static int tegra_dma_probe(struct platform_device *pdev)
 		INIT_LIST_HEAD(&tdc->cb_desc);
 	}
 
+	ret = clk_prepare_enable(tdma->dma_clk);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "clk_enable failed: %d\n", ret);
+		return ret;
+	}
+
+	/* Reset DMA controller */
+	reset_control_reset(tdma->rst);
+
+	/* Enable global DMA registers */
+	tdma_write(tdma, TEGRA_APBDMA_GENERAL, TEGRA_APBDMA_GENERAL_ENABLE);
+	tdma_write(tdma, TEGRA_APBDMA_CONTROL, 0);
+	tdma_write(tdma, TEGRA_APBDMA_IRQ_MASK_SET, 0xFFFFFFFFul);
+
 	dma_cap_set(DMA_SLAVE, tdma->dma_dev.cap_mask);
 	dma_cap_set(DMA_PRIVATE, tdma->dma_dev.cap_mask);
 	dma_cap_set(DMA_CYCLIC, tdma->dma_dev.cap_mask);
@@ -1528,7 +1509,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		dev_err(&pdev->dev,
 			"Tegra20 APB DMA driver registration failed %d\n", ret);
-		goto err_pm_disable;
+		goto err_clk_disable;
 	}
 
 	ret = of_dma_controller_register(pdev->dev.of_node,
@@ -1547,10 +1528,8 @@ static int tegra_dma_probe(struct platform_device *pdev)
 err_unregister_dma_dev:
 	dma_async_device_unregister(&tdma->dma_dev);
 
-err_pm_disable:
-	pm_runtime_disable(&pdev->dev);
-	if (!pm_runtime_status_suspended(&pdev->dev))
-		tegra_dma_runtime_suspend(&pdev->dev);
+err_clk_disable:
+	clk_disable_unprepare(tdma->dma_clk);
 
 	return ret;
 }
@@ -1560,15 +1539,12 @@ static int tegra_dma_remove(struct platform_device *pdev)
 	struct tegra_dma *tdma = platform_get_drvdata(pdev);
 
 	dma_async_device_unregister(&tdma->dma_dev);
-
-	pm_runtime_disable(&pdev->dev);
-	if (!pm_runtime_status_suspended(&pdev->dev))
-		tegra_dma_runtime_suspend(&pdev->dev);
+	clk_disable_unprepare(tdma->dma_clk);
 
 	return 0;
 }
 
-static int tegra_dma_runtime_suspend(struct device *dev)
+static int __maybe_unused tegra_dma_dev_suspend(struct device *dev)
 {
 	struct tegra_dma *tdma = dev_get_drvdata(dev);
 	unsigned int i;
@@ -1597,7 +1573,7 @@ static int tegra_dma_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int tegra_dma_runtime_resume(struct device *dev)
+static int __maybe_unused tegra_dma_dev_resume(struct device *dev)
 {
 	struct tegra_dma *tdma = dev_get_drvdata(dev);
 	unsigned int i;
@@ -1635,12 +1611,8 @@ static int tegra_dma_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops tegra_dma_dev_pm_ops = {
-	SET_RUNTIME_PM_OPS(tegra_dma_runtime_suspend, tegra_dma_runtime_resume,
-			   NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-};
+static SIMPLE_DEV_PM_OPS(tegra_dma_dev_pm_ops, tegra_dma_dev_suspend,
+			 tegra_dma_dev_resume);
 
 static const struct of_device_id tegra_dma_of_match[] = {
 	{
-- 
2.24.0

