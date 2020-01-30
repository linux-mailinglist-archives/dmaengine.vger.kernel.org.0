Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B46CF14D5B4
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 05:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgA3El0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jan 2020 23:41:26 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36568 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbgA3ElZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jan 2020 23:41:25 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so2591172wma.1;
        Wed, 29 Jan 2020 20:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EA2aX2gMwFfc16iv548oZvQgKjYnmWGj0LmTyLTJTmM=;
        b=hYGAj2Mov70sEbpDjxriRD5UGD6rvZRJztNpMbOgYVK9KTRqj8Xw7JUPAC7evbmIM8
         I0kjWlwOGH/5AC2mQQEn7a5fJ9rGxbqyWhBZz0+jVB4qyxb2WVDnjD5pqKrgCxtBuruY
         +FUUMpWB9zfaQelaXP56ocFoVacouvg3hWvePUL46NTys+kDRDWAl97m6W/LZSdghUjE
         lWWQQ8PWMqOC0seb5rqzqnSTjbStX81KBaA0I47ZSC0K856QuaSu0Cdppn9Bkqtqv2Rm
         WoPrWieTB/H6VP0JYhYsU4++UCfpRbnK62tJ3np/SIgVzbMfWPeaHRHVzrQOWva9YuKe
         9eZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EA2aX2gMwFfc16iv548oZvQgKjYnmWGj0LmTyLTJTmM=;
        b=pJLIDwBekAWl7zn0UY61mFdVD+9d3kAUOU/vjLrZi1VtVAobPi9FO6SFTE3Vsd/8IF
         DZI8S2lnjs7lXSRxXHbksFWtLgt3pNTmGRPjvYyJgt4Nl3ShAmfCgG6ogWVv+z3BgxqB
         mMZKMIY8mNU8t9kNVCOJEVPOjg0vMk/0gzzUehA4zXvV3I6xaTgnjA+dJrSQmfymHQPH
         ab2wHjELP1FfDqQqjosNZpbIL53ltaO1hdP9hAhwHg5xrvQdV13e8EMwcgK074LMqz+v
         e6rBK4XjZJo6jvlqJ9iCw9CpYMcUgVm8dkOfpXvjdj1s3EAqtUwGQVuc92ExlLpEWMT8
         hVag==
X-Gm-Message-State: APjAAAW4ePZVVYpXa32wHNuO1YHFOpEmyY4KsIMQ/Yx/EatbOlTb2jNQ
        /SWp+NFY0dFbe4V7mMbycTQ=
X-Google-Smtp-Source: APXvYqxER3UHF47mSHAJF45z34xxx/xNR6vEhkeFDwOuofrD0Wf+cNtIBgH1q/OQr/+CJh5+LusNMw==
X-Received: by 2002:a7b:c932:: with SMTP id h18mr2853155wml.171.1580359283162;
        Wed, 29 Jan 2020 20:41:23 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g128sm4494672wme.47.2020.01.29.20.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 20:41:22 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 10/16] dmaengine: tegra-apb: Remove assumptions about unavailable runtime PM
Date:   Thu, 30 Jan 2020 07:37:58 +0300
Message-Id: <20200130043804.32243-11-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200130043804.32243-1-digetx@gmail.com>
References: <20200130043804.32243-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The runtime PM is always available on all Tegra SoCs since the commit
40b2bb1b132a ("ARM: tegra: enforce PM requirement"), so there is no
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

