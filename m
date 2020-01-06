Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7BDC130B62
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jan 2020 02:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbgAFBRa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 5 Jan 2020 20:17:30 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37406 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbgAFBRa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 5 Jan 2020 20:17:30 -0500
Received: by mail-lf1-f65.google.com with SMTP id b15so35336005lfc.4;
        Sun, 05 Jan 2020 17:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pxocVjmZG/Uueu6zkGsV3Kg82ZUCb0WJfl2eGCqi6Qo=;
        b=dXc6SZf2M91qRrX2+fLpoa570MlqQZI2yCqypJ1x8NpDrofeydKtERGM1hoWmr5V2k
         kECYcyZ7TDd+4KtqsoPRzt1UTA5GvyQP7zm3eaRGiFd0uOHm41SEkKe9EFL2DYxoLTXD
         qlS8uxeUa7p80rca31cMThCeJNR3UgHmsKH3qFWE6anX5HFbrjmsF+kBD91qSB4/MMqH
         6zUSSverM74yqC4UJ7ibjv14Nv9G0sRrhdxYJxYOfOuOWI13kHDkSmdaMuKGMv3ZWVYJ
         vMEcHs90ka2uw6736+y/cqrjFfgoNFnO8QqEyVGFmewZrEmvuXZsuJa84FuxrBUz2kK7
         +4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pxocVjmZG/Uueu6zkGsV3Kg82ZUCb0WJfl2eGCqi6Qo=;
        b=JpnCz2LEUTvM9mBjQBd3ip0/xwta/nH0wbLQJ0JyVISKM7ZUnaroCJyExIMzgDw/ZH
         yxB4Vj7CNdBmRruuwRpPZqPK0lbPm6204z9xXaE8OCRkWISHpxkShDObzdEs7mAQ1M3u
         qMCmQG0MiUBCmuB8PDh/Dt2kHrKVEF9Y1muMd+7phiwfaZy8kSo5q0+ijeGxXwSqcxDd
         KOFEW3RedpWtYDkWe6erwVM5n3wUOTnSVcbwxH7TreShyYdjsX/YV2Uz7z9GZtlPMJcA
         eZ8VstlYvhazhWKq5g7WoKNzkwdpKfd6w/858bS+gEg0hS+FVVYYVe13gtFhFmTVsRMs
         IqBg==
X-Gm-Message-State: APjAAAVTb+WMOKUlE6E+0UX4na9Et1eTdkFSC25XxQsqPoYMGcTvUjPq
        Uqnb/01Gy1jVSs4sffQ2kxH+utM6
X-Google-Smtp-Source: APXvYqxjjD9CLBn70XF78KnX3Si+y1oBx6yJNizu0RrGS0pKiikrU7KQB/Lrrdf46h6SDGtSeOERLw==
X-Received: by 2002:a19:7604:: with SMTP id c4mr56727060lff.101.1578273447620;
        Sun, 05 Jan 2020 17:17:27 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id y14sm28353271ljk.46.2020.01.05.17.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 17:17:27 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/13] dmaengine: tegra-apb: Use devm_request_irq
Date:   Mon,  6 Jan 2020 04:17:02 +0300
Message-Id: <20200106011708.7463-8-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200106011708.7463-1-digetx@gmail.com>
References: <20200106011708.7463-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use resource-managed variant of request_irq for brevity.

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

