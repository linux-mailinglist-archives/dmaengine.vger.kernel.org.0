Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC60147478
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2020 00:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbgAWXLV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Jan 2020 18:11:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35466 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729863AbgAWXK5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Jan 2020 18:10:57 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so4391872wmb.0;
        Thu, 23 Jan 2020 15:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1GEDu+yELGWrST9c5+TdRrJzCmMwdpupliHRsMCyGqE=;
        b=dQUU1GoLchg3yIGX5YtyVCZgpZ2ShXaLaryD6EqR/9309QFgrbSu/REt3nbVnaBltT
         GX3h3lrQxstZZZMehJXYrNWoJj+XACuMSd1iBlFp6CVEVgBefomsFpS8DSdU3O1xrxk1
         BMIb5G1NRNbmuj+k7uO6J+YABNba4wBAVS00g6/5wqNErsnB+rGi+68FiHq1a4PjXCkB
         NyStFzReo0W1/6rarQb74XfkC+d16DDi26K1GmILe4iGADgSIcaoCISpDmZG2TNTWqnL
         AZMy+hmuErA3gNEq2fkB/haR+2EWXUlWdjopUqdXmbrOi9Nvx4ySCjBzkvWShegi1BRL
         Hkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1GEDu+yELGWrST9c5+TdRrJzCmMwdpupliHRsMCyGqE=;
        b=WMAj0J0XfLF5ttpAR147DChiWLYuk/92DaqoCGR9n62IQ0yWUwpOnfcd6/oHrcaeGY
         Ta3Ng2CQJ7eIfCqGBjM2NPq1fN4YXzVxQsUPEVAZ+QberNyD+h+0ImKS/t2R0AiU2XYr
         wJlyZaMPpNxeWuVM3RrupVulkEW8gBjK/k8mvlrhQ8ydeu9++m/Jb2EI0IEvBlFi9dYm
         FGC/f/yKCrGDq0QIT3zH3LFLT33ngIU+VObAO4QGF4aqlLGbMsENczSINctCbdfAvQJ+
         bdK6goQA4PnDa3FLYymQQcnmra/5EIs+6eDlvcDZ+4J5tNYNeOyS/YDOf8AAZ8RHZ7lp
         Z1AA==
X-Gm-Message-State: APjAAAWJd6j9spY2CKIG0HjqgWItQijspY3r99wdxdPLTUqVO2eP28aG
        bm2V6puBwuhKLi444eAOANWF+rDt
X-Google-Smtp-Source: APXvYqzJfDwln758RU7sb3yLvJqr1ioKkeQIP32Dp0VVfmGd2tIzQs06QaVt4sN2/XwvXUIoNkOUCg==
X-Received: by 2002:a05:600c:2551:: with SMTP id e17mr281031wma.26.1579821055044;
        Thu, 23 Jan 2020 15:10:55 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id z6sm5105552wrw.36.2020.01.23.15.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 15:10:54 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 09/14] dmaengine: tegra-apb: Remove assumptions about unavailable runtime PM
Date:   Fri, 24 Jan 2020 02:03:20 +0300
Message-Id: <20200123230325.3037-10-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200123230325.3037-1-digetx@gmail.com>
References: <20200123230325.3037-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The runtime PM is always available on all Tegra SoCs since the commit
40b2bb1b132a ("ARM: tegra: enforce PM requirement"), thus there is no
need to handle the case of unavailable RPM in the code anymore.

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

