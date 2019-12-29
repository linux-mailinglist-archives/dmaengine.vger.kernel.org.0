Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B40112C2F5
	for <lists+dmaengine@lfdr.de>; Sun, 29 Dec 2019 15:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfL2O4y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 29 Dec 2019 09:56:54 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41028 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfL2O4w (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 29 Dec 2019 09:56:52 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so31093756ljc.8;
        Sun, 29 Dec 2019 06:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jIEJVFrrx4gky/ZOSTsCbKeEbeTJKbAx8QcAIMAQtco=;
        b=LKurbgT8Kf4tjVl7uE5zwgmNgS76qKMevfT+eHtUk/sx0AXmAzmr7UubZslnKDo91h
         Ld9LjMZL6LupqHeUUQu75OBxWJXf9NFjz0zBTHsaOq9oL0vSKuYLb3o9JoOGYa/7xvEM
         5ywzqoD0QX6YvprT5c/rgBLGO53GP95riFFlm6YPKoFnFO/G3Id3czcfHNMdbyFkeyqH
         arZxBjdP6TADTvkR1ReqRzqtdhjlg20UFGvuIccuDEpbTDHxnWMYXCb22hoJfXLp8LGP
         1OAQRXhxnV9YnCnqdbZcBvX4xeciyl1VutLOX5dZlRdII9NuwAaT4Xo2O/CsVZSZ0vKO
         s2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jIEJVFrrx4gky/ZOSTsCbKeEbeTJKbAx8QcAIMAQtco=;
        b=YdP5dX9E2OwFY955pliLC/4qIwSmwsQFER4BTpk7uQk1xVcRinbSse/RLIWDa05iHf
         3SINmvn7O0hbAoQrZeyqRWiZ/vFGMEykGTz8b0r8ps6OneqcQa894yGdsHAtpl53Fvnu
         m+yIOtNK4pN8QVrLluk8J9vjE0a3T4nedH2233U/BIs0CNra9RNfQaCJVjeP+3HKo0iU
         xdTbvrHPVh/HVk9Kcj9LYVxAL82l/R5UwoNc1eLPjyP/82tMWTAmdMaVC4YBXq1IVwbz
         0SFBRSjC+RywwHhUBD9STx7IOvrKNZhmoI/+/QQRG+0hhkSjATpe9yPlTMbl5tJfMDGB
         uepQ==
X-Gm-Message-State: APjAAAXSwPYU30uKEPvnzcdanwz5Cikj9MnMEGy5089cIUatKoYChaXE
        AtmxmvcC9Tp9N83VXbwVo0qvsGcQ
X-Google-Smtp-Source: APXvYqzRGam7ZutAdp0X55wXkeZ/u7IEGRDMpq+nzGFdcLsCQcaClOl10Kx6p9mQRymjgRVOJWQa6A==
X-Received: by 2002:a2e:b60d:: with SMTP id r13mr34526694ljn.40.1577631409786;
        Sun, 29 Dec 2019 06:56:49 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g15sm11563944ljl.10.2019.12.29.06.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 06:56:49 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/12] dmaengine: tegra-apb: Use devm_request_irq
Date:   Sun, 29 Dec 2019 17:55:19 +0300
Message-Id: <20191229145525.533-7-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191229145525.533-1-digetx@gmail.com>
References: <20191229145525.533-1-digetx@gmail.com>
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
index d2353f23b201..194a7faf12ba 100644
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
@@ -1383,7 +1382,6 @@ static const struct tegra_dma_chip_data tegra148_dma_chip_data = {
 
 static int tegra_dma_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	struct tegra_dma *tdma;
 	int ret;
 	int i;
@@ -1449,25 +1447,27 @@ static int tegra_dma_probe(struct platform_device *pdev)
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
@@ -1520,7 +1520,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		dev_err(&pdev->dev,
 			"Tegra20 APB DMA driver registration failed %d\n", ret);
-		goto err_irq;
+		goto err_pm_disable;
 	}
 
 	ret = of_dma_controller_register(pdev->dev.of_node,
@@ -1537,13 +1537,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 
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
@@ -1553,16 +1547,9 @@ static int tegra_dma_probe(struct platform_device *pdev)
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

