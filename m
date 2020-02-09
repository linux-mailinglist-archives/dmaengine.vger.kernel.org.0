Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E226E156B74
	for <lists+dmaengine@lfdr.de>; Sun,  9 Feb 2020 17:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgBIQl3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 Feb 2020 11:41:29 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43733 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgBIQl3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 9 Feb 2020 11:41:29 -0500
Received: by mail-lj1-f196.google.com with SMTP id a13so4379424ljm.10;
        Sun, 09 Feb 2020 08:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qFNj4iZcoBFNxp/P8AUPmYTrUs6aig313Dwl/F0NbpM=;
        b=sT2zGNcY8/pGm+fHfP0rK7L0iln84ZVEvhGOJ94COsbM+fIGHnNwCGW5+TdkYjc8Cp
         F5GXYfWAt4fAQHoio+zL05BputMpiOqQspfX2RKtwAmkCyMggOZeu25Ji9NCIVtTkXXs
         3V+3kl4aPEDHZ3XNVlZ+FCuEkbURsWdwCUNibc55KddL7pu5GlSNxet/q238rLFjvEJJ
         b7fUp1wxcbej09vYZDfm0WUmQeyzBGHlICmvyAdV5/GdEZ/TzCRq/nDjloj2JdBtQSSp
         B8Sa3tid/3N6X2lolS/0vbzLE2F9z9iyZ9iIq6/X4/NszpYIVPOG99B0JMNdEW8iR+Ah
         2QjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qFNj4iZcoBFNxp/P8AUPmYTrUs6aig313Dwl/F0NbpM=;
        b=mbspt+7sEEMCsP5PliC2LdVOFChsgPgCTr43nQ/EHHJBf5ct05+6cwkjmPptzNe6rL
         0VAYTV3VmsXdLsMdM+PXiOaXI5556ZkoBXYDE2wlSAOLwpeHGj2JiBZzrPkdlVBXtu+1
         lWtptML+6FtwpWMKrcZB1zL5EMN+gOHX9+Mda86ymWxl3xmeSgV4yntTnXPX2Fv9MISW
         8Cn5EFAL5AYwa2KCBmDSAFEoI1YnbN/lBGlvc88+6JUThIIP0Hk6jwoR/Z3Bxsk1qvtJ
         WD6JLiZxJSSjNgrqPDkwthgsUZxZyecvqIN7+mI3T50zB3EQBVzLknwoj3d+fqfWIFdP
         Elrw==
X-Gm-Message-State: APjAAAXF7NaBlzE7fnC74NpgtyqstOV9+yB9m5hrk/2r6wMBtBvIvviN
        n8S5GSURS22a5mm/fDk8G+ULdyG0
X-Google-Smtp-Source: APXvYqwgzoGtdwYyayg3TL15DyBcWXzwklk4r4iLwjHpEVL5HvhSVZ58OgcRpX8ymjtOy3P3WkDoug==
X-Received: by 2002:a2e:b5a5:: with SMTP id f5mr5482371ljn.162.1581266486262;
        Sun, 09 Feb 2020 08:41:26 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g21sm4941826ljj.53.2020.02.09.08.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 08:41:25 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 10/19] dmaengine: tegra-apb: Remove assumptions about unavailable runtime PM
Date:   Sun,  9 Feb 2020 19:33:47 +0300
Message-Id: <20200209163356.6439-11-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200209163356.6439-1-digetx@gmail.com>
References: <20200209163356.6439-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The runtime PM is always available on all Tegra SoCs since the commit
40b2bb1b132a ("ARM: tegra: enforce PM requirement"), so there is no
need to handle the case of unavailable RPM in the code anymore.

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 7158bd3145c4..22b88ccff05d 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1429,11 +1429,8 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	spin_lock_init(&tdma->global_lock);
 
 	pm_runtime_enable(&pdev->dev);
-	if (!pm_runtime_enabled(&pdev->dev))
-		ret = tegra_dma_runtime_resume(&pdev->dev);
-	else
-		ret = pm_runtime_get_sync(&pdev->dev);
 
+	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0)
 		goto err_pm_disable;
 
@@ -1546,8 +1543,6 @@ static int tegra_dma_probe(struct platform_device *pdev)
 
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
-	if (!pm_runtime_status_suspended(&pdev->dev))
-		tegra_dma_runtime_suspend(&pdev->dev);
 
 	return ret;
 }
@@ -1557,10 +1552,7 @@ static int tegra_dma_remove(struct platform_device *pdev)
 	struct tegra_dma *tdma = platform_get_drvdata(pdev);
 
 	dma_async_device_unregister(&tdma->dma_dev);
-
 	pm_runtime_disable(&pdev->dev);
-	if (!pm_runtime_status_suspended(&pdev->dev))
-		tegra_dma_runtime_suspend(&pdev->dev);
 
 	return 0;
 }
-- 
2.24.0

