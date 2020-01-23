Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 621C3147460
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2020 00:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbgAWXKz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Jan 2020 18:10:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42653 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729837AbgAWXKy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Jan 2020 18:10:54 -0500
Received: by mail-wr1-f68.google.com with SMTP id q6so5168318wro.9;
        Thu, 23 Jan 2020 15:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iIeXeqWybCn0khYUW1LlWp0vQo+B3g3sVK/buP+mLKA=;
        b=RFLKSghkKtdswaFGhkjA2H4LA8sgEW7Ckiev/iNbFObVyq7m9U73J6mO7ViFfwhnTq
         YyWNZuMw4Or29F2Z4b9SDYF4oBlbIj31hp4ECwE2tYqtflVWwwVDhYQ5cz/pYXQ7CupG
         BnA4yY2qrZsAd/qqIa8XPpvkQ5tL3tCdeNtoga/ohYXbkaYiDwf/HsRsIz63kKH1Gcrv
         Lo+PNT9BCcqeCVWOW0Xs55It3iRU7NMeFMM2y6loxq/ibAlbhVOqiLFH4J6VsQz1tXH0
         JCmVOmzMfK+5GJSEmIJ2nm//hG6XAdgQke4eoq7DSUX8jnd7plVRYQEP/EbAOzq9pvl+
         lkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iIeXeqWybCn0khYUW1LlWp0vQo+B3g3sVK/buP+mLKA=;
        b=PQ3an4jOteCZKFpqLHClU/VbRakFKYaqL7vo04jamS4bqsykN4FA+bH/VV9cLJnBdQ
         E1MTGOFzc5tuygV+9/xsjleGGuyaR5Fc3UVzc5pAUzkeEPWm8qjY2fEL7eLY0usYBami
         Mni1kLzsbDnF9UQ/KQ5uKOF4wOIRtiRFAbWtMdpT0Tl1WOxTNMfgzm4U2QtFJz/HX1Fv
         qOswYybANEjP0c3NyPTpc3JgxA90ZcfaQSlgjDBNV2PyuHaPXehHVQwHDRGmknWN4AHF
         YeNdzsg1QaXUyft/igthlZkF26ue2JZGl8mHlytRx6EOKwP2FDzRwXpIN6m/Qk626xbL
         hHMg==
X-Gm-Message-State: APjAAAXv1zecJi/Z5sONpb/NF/hKne/4p5DjDT19WuEl1VqrsDpH1hCM
        1ua2XMyb2gLocAtmT5UnFPYBeQ/S
X-Google-Smtp-Source: APXvYqzQM9BRYlIR8ZyGAuAhCaVc7Gc6aQQznEXhWRurnHxF9+87PSuC+6K+2D09AyYrrAsGEOhkRA==
X-Received: by 2002:a5d:558d:: with SMTP id i13mr452664wrv.364.1579821052375;
        Thu, 23 Jan 2020 15:10:52 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id z6sm5105552wrw.36.2020.01.23.15.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 15:10:52 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 07/14] dmaengine: tegra-apb: Use devm_request_irq
Date:   Fri, 24 Jan 2020 02:03:18 +0300
Message-Id: <20200123230325.3037-8-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200123230325.3037-1-digetx@gmail.com>
References: <20200123230325.3037-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use resource-managed variant of request_irq for brevity.

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 35 +++++++++++------------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index f44291207928..dff21e80ffa4 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -182,7 +182,6 @@ struct tegra_dma_channel {
 	char			name[12];
 	bool			config_init;
 	int			id;
-	int			irq;
 	void __iomem		*chan_addr;
 	spinlock_t		lock;
 	bool			busy;
@@ -1380,7 +1379,6 @@ static const struct tegra_dma_chip_data tegra148_dma_chip_data = {
 
 static int tegra_dma_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	struct tegra_dma *tdma;
 	int ret;
 	int i;
@@ -1446,25 +1444,27 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&tdma->dma_dev.channels);
 	for (i = 0; i < cdata->nr_channels; i++) {
 		struct tegra_dma_channel *tdc = &tdma->channels[i];
+		int irq;
 
 		tdc->chan_addr = tdma->base_addr +
 				 TEGRA_APBDMA_CHANNEL_BASE_ADD_OFFSET +
 				 (i * cdata->channel_reg_size);
 
-		res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
-		if (!res) {
-			ret = -EINVAL;
+		irq = platform_get_irq(pdev, i);
+		if (irq < 0) {
+			ret = irq;
 			dev_err(&pdev->dev, "No irq resource for chan %d\n", i);
-			goto err_irq;
+			goto err_pm_disable;
 		}
-		tdc->irq = res->start;
+
 		snprintf(tdc->name, sizeof(tdc->name), "apbdma.%d", i);
-		ret = request_irq(tdc->irq, tegra_dma_isr, 0, tdc->name, tdc);
+		ret = devm_request_irq(&pdev->dev, irq, tegra_dma_isr, 0,
+				       tdc->name, tdc);
 		if (ret) {
 			dev_err(&pdev->dev,
 				"request_irq failed with err %d channel %d\n",
 				ret, i);
-			goto err_irq;
+			goto err_pm_disable;
 		}
 
 		tdc->dma_chan.device = &tdma->dma_dev;
@@ -1517,7 +1517,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		dev_err(&pdev->dev,
 			"Tegra20 APB DMA driver registration failed %d\n", ret);
-		goto err_irq;
+		goto err_pm_disable;
 	}
 
 	ret = of_dma_controller_register(pdev->dev.of_node,
@@ -1534,13 +1534,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 
 err_unregister_dma_dev:
 	dma_async_device_unregister(&tdma->dma_dev);
-err_irq:
-	while (--i >= 0) {
-		struct tegra_dma_channel *tdc = &tdma->channels[i];
-
-		free_irq(tdc->irq, tdc);
-	}
-
+err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		tegra_dma_runtime_suspend(&pdev->dev);
@@ -1550,16 +1544,9 @@ static int tegra_dma_probe(struct platform_device *pdev)
 static int tegra_dma_remove(struct platform_device *pdev)
 {
 	struct tegra_dma *tdma = platform_get_drvdata(pdev);
-	int i;
-	struct tegra_dma_channel *tdc;
 
 	dma_async_device_unregister(&tdma->dma_dev);
 
-	for (i = 0; i < tdma->chip_data->nr_channels; ++i) {
-		tdc = &tdma->channels[i];
-		free_irq(tdc->irq, tdc);
-	}
-
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		tegra_dma_runtime_suspend(&pdev->dev);
-- 
2.24.0

