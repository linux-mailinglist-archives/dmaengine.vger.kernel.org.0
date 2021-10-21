Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4534358CA
	for <lists+dmaengine@lfdr.de>; Thu, 21 Oct 2021 05:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhJUDIH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Oct 2021 23:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhJUDIH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Oct 2021 23:08:07 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BD1C06161C;
        Wed, 20 Oct 2021 20:05:52 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id v20so17499423plo.7;
        Wed, 20 Oct 2021 20:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=77PLCsBG69VADmqLf54LQVmoEL+WpNpUv4oaIXYbQ6c=;
        b=CdsMYfqWAigFK4bOxHnjsuV4Tyb59vn0FO/5v9hYO8xXI1+twQMwF+3tdLmINEZvD8
         apJeFERMfXusaiGxKIylXMmhDCIYG0i1GF+Sktz92rEdLOMpTQE+945bLB0lVC772WW/
         y0K3tTzDwUYtzykgA1siwLgZWgAt/kjPzP9U/v6T4hNrCEJxBqxEhWBkXGELvE78SgHd
         3hFafz6cJ1zkHdP6EF9GWCsQ5EojXse2ee7uXuEH4LkmrDltw7WlAzfZIgXpnnVa3wQ5
         B3bqQvu3w5a2HzgyZOgu+y7eXcwjlOjayvTjTY4rAcTaSWnmYImmMr5qtUPnrbX6jBKd
         x4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=77PLCsBG69VADmqLf54LQVmoEL+WpNpUv4oaIXYbQ6c=;
        b=x7O7h5bh6b3rrCra46eaXmlO0RFep9mrmSK115kz3bkvKA4GM3SESqTlj0qHqAiK0N
         vbqP7szJpkFwYekL5HgawPPs8BDbQ3ljb3wC/bO6PKRqKA0EVxZswmTbCSSHGK6UY99r
         EJgtsYVbY3qMmHbP6CE9eJ/psaGKUi0IJuOG8Vv4eMYq14/PelL24589fA+zigVVkPN3
         35ks3NZs6Rb0JOylMjHKXMjR91dWME/G+E0T5EkhSXsXnlc72MTm+qcclMkRVhNh3Vt8
         3oEdLDoxfxTV4K9dwS3IFONOlsxPIoEJ2N0LzQiFZYVK0TAyZPMLKAL8s7+yqHcRUaqQ
         Z0rg==
X-Gm-Message-State: AOAM531XIpsnvFS8Ff7WRHkhHJMqu6QYh7bWTGl7v5TdybOe46iRR3I5
        GQGXHdzmgsl7m9UdQpKi1y/qWOLcWvcKk/Ryu3M=
X-Google-Smtp-Source: ABdhPJw5tbFa4AA42NrCt6ypTK8ftp/9GURHUnOFG8P8MSW8jdY19c87EJ9Ln30zdzCRGyGjg9pR6A==
X-Received: by 2002:a17:90b:4b03:: with SMTP id lx3mr3271466pjb.162.1634785551798;
        Wed, 20 Oct 2021 20:05:51 -0700 (PDT)
Received: from localhost.localdomain ([94.177.118.132])
        by smtp.gmail.com with ESMTPSA id s21sm4274412pfg.70.2021.10.20.20.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 20:05:51 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Zhang Qilong <zhangqilong3@huawei.com>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: tegra210-adma: fix pm runtime unbalance
Date:   Thu, 21 Oct 2021 11:05:38 +0800
Message-Id: <20211021030538.3465287-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The previous commit 059e969c2a7d ("dmaengine: tegra210-adma: Using
pm_runtime_resume_and_get to replace open coding") forgets to replace
the pm_runtime_get_sync in the tegra_adma_probe, but removes the
pm_runtime_put_noidle.

Fix this by continuing to replace pm_runtime_get_sync with
pm_runtime_resume_and_get in tegra_adma_probe.

Fixes: 059e969c2a7d ("dmaengine: tegra210-adma: Using pm_runtime_resume_and_get to replace open coding")
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/dma/tegra210-adma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index b1115a6d1935..d1dff3a29db5 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -867,7 +867,7 @@ static int tegra_adma_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(&pdev->dev);
 
-	ret = pm_runtime_get_sync(&pdev->dev);
+	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0)
 		goto rpm_disable;
 
-- 
2.25.1

