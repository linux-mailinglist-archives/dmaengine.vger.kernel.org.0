Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951C324CB7C
	for <lists+dmaengine@lfdr.de>; Fri, 21 Aug 2020 05:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgHUDop (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Aug 2020 23:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgHUDop (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Aug 2020 23:44:45 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABEDC061385;
        Thu, 20 Aug 2020 20:44:45 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id v16so287530plo.1;
        Thu, 20 Aug 2020 20:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wyIVjmGqTstjchVJqOQwrnaOjDzoFs+oUprn8zSTmnY=;
        b=isZUrOqsG/63XB4tWP2IwaGUbFUurZ4oY18SSWClUtvGV1RD7DhBaPPGd/Ww2XLMAn
         ZgT+SRonsJCO8fqqnRx098Y7ADJforV8DZeJcMylQH/R0cTn4yB2ORxxz0vEC99R6j1F
         sExxtN/AFIrh947Q4vAjS5MJF4ZJAb42EqawgP1AJ+agcXB0Qjm5W2MGErw2KuZSr6Kl
         o9qRaZtYiyYmmfzrX1jggDAHXaP6YM6CZqNBYZFKHGUnFHCz38w3BYc9wE8RoJyJ8418
         VaNWPV0IYt0sR+zSBrzFzCmFczt0tVCUcc5c/u4LukCZQadKosm9JXT615rVih1iKokq
         6qbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wyIVjmGqTstjchVJqOQwrnaOjDzoFs+oUprn8zSTmnY=;
        b=ghUqZ6nsEbzjmVhOZ/3LyXn/Ln2e9TxQraRMnEHTeT+fsRZ3Uxm2DTO7rwE152PAbE
         jPBNCeFiRcj4lrbmoXiHEqyzGQYR5Tz4vUShGMEL7FDwrytD8gVbAuLWrhA0kPhN42OW
         zsELreozbN8ypjIeeMHVudI0eT7PC+/Lwwdkpgt+XBIycxwrI05bLljAIDgt9ABFrFtJ
         jVKipY3DddcRRyUkVkpfUi91qPaShPdvImenn6AL0wDMWrGC7PEBxoOL4JnRVFOPUBbJ
         5ohJDgaejptTLG73Enfv1pxykX17I7bb8MrGitoB7mTmhL1CWtaHszHAoIv01NRZLMDF
         eiTA==
X-Gm-Message-State: AOAM531UBIfdadJQHtwM2MzL+RcIXDdugCudh+KKZgBFkbi6t+6vqDA4
        Nz5mYQbgLtz2Hl70y47hHw==
X-Google-Smtp-Source: ABdhPJzvXgDyygUBAVsUvY687NV+FhoagdzjUUXE14qWdVGU3IGqA98UMadI38IkKipvJyvWBKAxbQ==
X-Received: by 2002:a17:90a:e64b:: with SMTP id ep11mr925111pjb.86.1597981484578;
        Thu, 20 Aug 2020 20:44:44 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:cfa:ca54:b051:6744:d734:a674])
        by smtp.gmail.com with ESMTPSA id q17sm607755pfh.32.2020.08.20.20.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:44:43 -0700 (PDT)
From:   madhuparnabhowmik10@gmail.com
To:     paul@crapouillou.net, vkoul@kernel.org, dan.j.williams@intel.com,
        lars@metafoo.de
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrianov@ispras.ru, ldv-project@linuxtesting.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH v2] drivers/dma/dma-jz4780: Fix race condition between probe and irq handler
Date:   Fri, 21 Aug 2020 09:14:23 +0530
Message-Id: <20200821034423.12713-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

In probe, IRQ is requested before zchan->id is initialized which can be
read in the irq handler. Hence, shift request irq after other initializations
complete.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

---
Changes since v1:
Keep enable clock before request IRQ.
---
 drivers/dma/dma-jz4780.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 448f663da89c..8beed91428bd 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -879,24 +879,11 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ret = platform_get_irq(pdev, 0);
-	if (ret < 0)
-		return ret;
-
-	jzdma->irq = ret;
-
-	ret = request_irq(jzdma->irq, jz4780_dma_irq_handler, 0, dev_name(dev),
-			  jzdma);
-	if (ret) {
-		dev_err(dev, "failed to request IRQ %u!\n", jzdma->irq);
-		return ret;
-	}
-
 	jzdma->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(jzdma->clk)) {
 		dev_err(dev, "failed to get clock\n");
 		ret = PTR_ERR(jzdma->clk);
-		goto err_free_irq;
+		return ret;
 	}
 
 	clk_prepare_enable(jzdma->clk);
@@ -949,10 +936,23 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 		jzchan->vchan.desc_free = jz4780_dma_desc_free;
 	}
 
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		goto err_disable_clk;
+
+	jzdma->irq = ret;
+
+	ret = request_irq(jzdma->irq, jz4780_dma_irq_handler, 0, dev_name(dev),
+			  jzdma);
+	if (ret) {
+		dev_err(dev, "failed to request IRQ %u!\n", jzdma->irq);
+		goto err_disable_clk;
+	}
+
 	ret = dmaenginem_async_device_register(dd);
 	if (ret) {
 		dev_err(dev, "failed to register device\n");
-		goto err_disable_clk;
+		goto err_free_irq;
 	}
 
 	/* Register with OF DMA helpers. */
@@ -960,17 +960,17 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 					 jzdma);
 	if (ret) {
 		dev_err(dev, "failed to register OF DMA controller\n");
-		goto err_disable_clk;
+		goto err_free_irq;
 	}
 
 	dev_info(dev, "JZ4780 DMA controller initialised\n");
 	return 0;
 
-err_disable_clk:
-	clk_disable_unprepare(jzdma->clk);
-
 err_free_irq:
 	free_irq(jzdma->irq, jzdma);
+
+err_disable_clk:
+	clk_disable_unprepare(jzdma->clk);
 	return ret;
 }
 
-- 
2.17.1

