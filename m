Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806DC1EEC22
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jun 2020 22:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgFDUjD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 4 Jun 2020 16:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbgFDUjD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 4 Jun 2020 16:39:03 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A4EC08C5C0;
        Thu,  4 Jun 2020 13:39:03 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id v11so7449430ilh.1;
        Thu, 04 Jun 2020 13:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Xy6WhYHrZaTBlBCQYphldIVHuAQk5+ZidfmsU27NTQc=;
        b=rsTC7PTQdxeCF9bdVVUKmgWUrBXkrL8mSJIFlZiAgKOs2S+4GGfRL22H2uVLsAWxeH
         YiKgG8Lsw/cFCfCAI2hbNM80EIg0ZfMt5gmILrNIEndmnL9uAo1oW1A0321onLpwL88D
         AQCckdtG7XEKrttga2RCL6zDWEw3IGLJqvir/MQb1dbe70HmfZSnIwvIcUL7kFqySuFy
         Q6bd+MolP8YfxNkWRxcnSUQPP4lOM6b5b/al3f6SZynvR+sM3CNATmcBpOnMMg3PiGaO
         lENLvHMCTS5VApDzXjsvFeaxkxL31XqiNcA/5O2a6W+6QHl+eqfC9S+56qLIUunh0X/D
         a+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Xy6WhYHrZaTBlBCQYphldIVHuAQk5+ZidfmsU27NTQc=;
        b=rBOWEuGbi7P+XPB6xvUPy/L6ne6DM4BpVG+EL5RuMyJLB0xudM4JyaWRut0hgZ46ac
         V5DK3QbLbBS5q8OTLAEMsRHT+U9gfJqhV9TJNg38ZE/HOBWlxFHXV9REk6BwA2/2gvht
         0LdxrFG5cun2XMzbFos66ux6DamAzMayGrcO0nhHUpWC71qNWW6PQaZTSnecTl0diaVR
         SNEI9po+kbUX+q265VnnmgC43ZXW02iBuxXmDLjvMee5M/bsri1nH3VZxXg7Pjg+jpa4
         u/EFgte6aKB081iF8n/y60aCLv5Gq28RTNNj3/WncwV1c8Y3iJOHQspSmpY9skENc8wD
         yGNg==
X-Gm-Message-State: AOAM532fZ6og6fOJaUUAsWATt9KIsw6S7IbF5iSC74DeDGeCDjCVrm9A
        qk8ruuszFyRdkmrH8xGA3Lw=
X-Google-Smtp-Source: ABdhPJx+wodiLLrkKDg3ha+a9NBtWbzHQmztrwc5GTaxABEAFKKibyP4WD7RjgCj+7p3tMqE7yZOUg==
X-Received: by 2002:a92:9fd1:: with SMTP id z78mr5279766ilk.221.1591303142416;
        Thu, 04 Jun 2020 13:39:02 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id y23sm321642ior.38.2020.06.04.13.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 13:39:01 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] dmaengine: sprd: handle the failure cases of pm_runtime_get_sync
Date:   Thu,  4 Jun 2020 15:38:54 -0500
Message-Id: <20200604203854.23106-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Calling pm_runtime_get_sync increments the counter even in case of
failure, causing incorrect ref count. Call pm_runtime_put if
pm_runtime_get_sync fails.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/dma/sprd-dma.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 0ef5ca81ba4d..0ba4fe1a1905 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -1204,8 +1204,10 @@ static int sprd_dma_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 
 	ret = pm_runtime_get_sync(&pdev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(&pdev->dev);
 		goto err_rpm;
+	}
 
 	ret = dma_async_device_register(&sdev->dma_dev);
 	if (ret < 0) {
@@ -1239,8 +1241,10 @@ static int sprd_dma_remove(struct platform_device *pdev)
 	int ret;
 
 	ret = pm_runtime_get_sync(&pdev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(&pdev->dev);
 		return ret;
+	}
 
 	/* explicitly free the irq */
 	if (sdev->irq > 0)
-- 
2.17.1

