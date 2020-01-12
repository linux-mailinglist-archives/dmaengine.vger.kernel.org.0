Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E66AF13877F
	for <lists+dmaengine@lfdr.de>; Sun, 12 Jan 2020 18:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733290AbgALRcR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 12 Jan 2020 12:32:17 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36125 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733169AbgALRbj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 12 Jan 2020 12:31:39 -0500
Received: by mail-lf1-f68.google.com with SMTP id n12so5153745lfe.3;
        Sun, 12 Jan 2020 09:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Jmy3B5v2Ce2+BDHjWIjOOpZMBGG7iH2rg2LqI+jBWo=;
        b=NjupIj9S3KJjP65J1UyjdC2snd+hLsabb5ygpvHN7JVrE4+BqMHKG3h70eTnvl1LpS
         y5KifdPY0Aqn+K7owyyqrbBWX8pZZkK65FtW1kqI9SOWCkmszk9D5MwNgBmaAbPCwb6N
         ykgfrXK4Ovs1fJSl2NUPwb1QFhmpKN1at/H44p3YiB8bvLPRZVD+T+EeAlfX+rhzEAwA
         pQk1aX/6ZkbFK8c2sJSymXdsiAeypNenTHoV+bH4/PY3/8E4JITdkWOuRm8I/vxYuljb
         HL8ARML+qAg6YVCirrrhcPuH8FoqembqH8DFKn5XKuy4XQFV2Bp8783evpNWSQ2X9YoX
         yn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Jmy3B5v2Ce2+BDHjWIjOOpZMBGG7iH2rg2LqI+jBWo=;
        b=eGlM09QjtG8bMhBI4sbGpYpZokqMwA8jIRj7QH6dnLGCYclcohQiCWTlHb957niBBj
         feIrdXijICJWXfNqisZGYWiVbWFN8qPL28PoB3cSpy01wHUIltN0yx9+ndzqVpzCNBpb
         nMSpe1/7e175EfbAujr+DWBQ4BJN7uQym7YMq+REuLLbA+UZOYKSj+VHeWQIm7n85faT
         cFMgmWqnr1KeCfa30lYDXAETtYwfCuN92y3HniT4P9Kp9y4fU43mb4AJzBfr8sGSDUjf
         3emSQMZx+bfUD8nhc1VhmPCBL97ba7lpbrbcHl9wMU+aPqIypKCAraOFbtQm0qWhTGft
         RVnA==
X-Gm-Message-State: APjAAAU9zaR+6lJJImFyaGrK3kakwigCo3QKg7RqBhra5ZaA96gGnuHa
        fdr28eDgwibD+3NOmi4JY4g=
X-Google-Smtp-Source: APXvYqwo+ZGXn3KyQo7FHPS98R6YOVgHned9sG2IXs3oABYXuv/88YkzpzcuNx/MOHRLJq1dM2UcaQ==
X-Received: by 2002:ac2:4add:: with SMTP id m29mr7438524lfp.190.1578850297066;
        Sun, 12 Jan 2020 09:31:37 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id 140sm4458888lfk.78.2020.01.12.09.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 09:31:36 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/14] dmaengine: tegra-apb: Clean up runtime PM teardown
Date:   Sun, 12 Jan 2020 20:30:01 +0300
Message-Id: <20200112173006.29863-10-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200112173006.29863-1-digetx@gmail.com>
References: <20200112173006.29863-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It's cleaner to teardown RPM by revering the enable sequence, which makes
code much easier to follow.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 7158bd3145c4..cc4a9ca20780 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1429,13 +1429,15 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	spin_lock_init(&tdma->global_lock);
 
 	pm_runtime_enable(&pdev->dev);
-	if (!pm_runtime_enabled(&pdev->dev))
+	if (!pm_runtime_enabled(&pdev->dev)) {
 		ret = tegra_dma_runtime_resume(&pdev->dev);
-	else
+		if (ret)
+			return ret;
+	} else {
 		ret = pm_runtime_get_sync(&pdev->dev);
-
-	if (ret < 0)
-		goto err_pm_disable;
+		if (ret < 0)
+			goto err_pm_disable;
+	}
 
 	/* Reset DMA controller */
 	reset_control_assert(tdma->rst);
@@ -1545,9 +1547,10 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	dma_async_device_unregister(&tdma->dma_dev);
 
 err_pm_disable:
-	pm_runtime_disable(&pdev->dev);
-	if (!pm_runtime_status_suspended(&pdev->dev))
+	if (!pm_runtime_enabled(&pdev->dev))
 		tegra_dma_runtime_suspend(&pdev->dev);
+	else
+		pm_runtime_disable(&pdev->dev);
 
 	return ret;
 }
@@ -1558,9 +1561,10 @@ static int tegra_dma_remove(struct platform_device *pdev)
 
 	dma_async_device_unregister(&tdma->dma_dev);
 
-	pm_runtime_disable(&pdev->dev);
-	if (!pm_runtime_status_suspended(&pdev->dev))
+	if (!pm_runtime_enabled(&pdev->dev))
 		tegra_dma_runtime_suspend(&pdev->dev);
+	else
+		pm_runtime_disable(&pdev->dev);
 
 	return 0;
 }
-- 
2.24.0

