Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6A63138774
	for <lists+dmaengine@lfdr.de>; Sun, 12 Jan 2020 18:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733173AbgALRbi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 12 Jan 2020 12:31:38 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36124 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733159AbgALRbh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 12 Jan 2020 12:31:37 -0500
Received: by mail-lf1-f68.google.com with SMTP id n12so5153682lfe.3;
        Sun, 12 Jan 2020 09:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pxocVjmZG/Uueu6zkGsV3Kg82ZUCb0WJfl2eGCqi6Qo=;
        b=NlqpxYRJzE9Q/JBrHE3GypkKY7e7ne5n2WrmAPaWBodQAymTD+YeRXrMvgGWOgzNNp
         FPsEYBVau78AcuVHzgoTvaBHw78I8I0IGoc/O7/87Aq75kO1QnjRS8ugx5BDo7CYVffS
         UAXQnJ1nrLPNZ5tKFXgcAlUO6mZk2Bhy/k0/MgoXhwdBHum2qLcODm6vgCith9pO092z
         mk/BISKs5dKOKKTIOZA+rJdB9yuMQew9HOTqX2QKqGVl/mQDAe1xP5UnxJQVrjVmQR1X
         RSlV9uNM3+iJx8ilUjTd2aEeIAiwR0GzPUwX6C6YuYqwmUa7BC1LkHC0gZ+mwtApzx6J
         1V2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pxocVjmZG/Uueu6zkGsV3Kg82ZUCb0WJfl2eGCqi6Qo=;
        b=ec4MG+SDpLQ212tZT9z6Jl6hwCs/dYpBPPiFSbpJ6/9JOKZplliJ2PaUJHozuURdF2
         9ZCtfi4aknNmO4Ej2ngr9zOCeW2UyqVTv+b+Bv5cW55N2xi7xENGfsGp9ef3HQj4FUDk
         //dHfP9m4lbhzlSHHPMubtyICq95E2P8yznq1iis0UR2XhoQvgoNvSIi28QjOcDd6IaL
         3OeAvL1oITrU2PQkze3CM52U54blfzJMNxCoYrIUsCwofA113NUe6o5YErc/dvw/3R8z
         TAQoGe9Jbq1Tw2JcyEbF4W9FeiHhg16K05g+JeEtpAXzRr61AjaIRyqXI5QG9u3i5Np/
         MuyQ==
X-Gm-Message-State: APjAAAUD5VrTlWULyrCCpOA8uM2ShII/SQbuMa8uR3pfCLM52apx/Ar0
        zPrHe05cKccdAI0Az4lZAkg=
X-Google-Smtp-Source: APXvYqwdVZ/xBI3GWVdWTq708g9TT101L2vxnFoXUfn46hhYDF89+mdleVnanZNsRTQIKPYvlFBEaA==
X-Received: by 2002:a19:f619:: with SMTP id x25mr7511282lfe.146.1578850295208;
        Sun, 12 Jan 2020 09:31:35 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id 140sm4458888lfk.78.2020.01.12.09.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 09:31:34 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/14] dmaengine: tegra-apb: Use devm_request_irq
Date:   Sun, 12 Jan 2020 20:29:59 +0300
Message-Id: <20200112173006.29863-8-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200112173006.29863-1-digetx@gmail.com>
References: <20200112173006.29863-1-digetx@gmail.com>
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

