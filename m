Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4A95601E2
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jun 2022 16:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbiF2OGh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jun 2022 10:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbiF2OGb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jun 2022 10:06:31 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2502AC56
        for <dmaengine@vger.kernel.org>; Wed, 29 Jun 2022 07:06:22 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id c13so22347410eds.10
        for <dmaengine@vger.kernel.org>; Wed, 29 Jun 2022 07:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8gQtQDtF9rQyU7X0tNXzxPfN8SpiY1745/Rsl4X+28U=;
        b=HPU/V4L85ukA/kUj9eblBzBqXaCHtN56ga2ZN/juC2Mn4FMoY2AmQRWlymboSh6KhC
         e0FOl2ip7AcigNt6bACVzqRS/0chmRDWXSmPJSz2QVyJZeyJq9Vg4lGSkCliRp8SqbV8
         gaZp31BGBj5ktqifxA/KljmyCXWWEwSm1cu07yo9Hhtwm7t338++0t2H+67mMvItNkH3
         DudLJhsIfq4gzM4egnC5HIRnQBrjsx1MTATnFqzP2qh0ZgglAgybYWPj2uHDYp01u62y
         EkrKQpGwlcUCQj2gkBOcprPOptKVwGr7Y+cuMX1Qzl0vwESLKwR5wHDV5l6dCEvuc8Ub
         +GRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8gQtQDtF9rQyU7X0tNXzxPfN8SpiY1745/Rsl4X+28U=;
        b=eYSlhFsVhYU2dHcQU48PshvgfIS2jYbpL63/tzFvIkPOXXHnMiMFQsppawmr07AqYJ
         WXWt+NvBjLSWxSrVfuk+4I5yOMUcOHPMLACrPMjldnhh2xB2rHHYZsRdNSivCyD4ybrL
         YvhUkD/ES2sMnWdem9jYbYD3IuKGTwQgb7zkQRWpqHbgfJQIiIPtXc6XdXg3c21Ewdeu
         D1AD+k+xt5IPeXqmsrFb7N6mmbCgXCABJQwbMEwdI+JIrEmzwcgkRN1QZMI4DrJ6nYbY
         Id1CSIPHMb9xmlOTB0/8aFhUChAcJ0rM/jSLZf0onG7Mn7DHj+E6OuzPDb2OI1/CoDvc
         16tQ==
X-Gm-Message-State: AJIora+LI4PoOBpyyZR+ndfrVO9Jiq2HGnpW1TlN+F/DYL6G1g1+5tf1
        0XhS5s6sBFl8HiBuIa3Xv99eAw==
X-Google-Smtp-Source: AGRyM1thK2elgrL51IMTUq/OOq4qxDO1WFANzNE8ltsuFrL8hQvjYOLDM/DN4c+hhQRudbAm+Bqy6A==
X-Received: by 2002:aa7:d685:0:b0:435:7910:f110 with SMTP id d5-20020aa7d685000000b004357910f110mr4412132edr.247.1656511580882;
        Wed, 29 Jun 2022 07:06:20 -0700 (PDT)
Received: from localhost.localdomain (88-107-17-60.dynamic.dsl.as9105.com. [88.107.17.60])
        by smtp.gmail.com with ESMTPSA id p19-20020aa7cc93000000b0042bdb6a3602sm11238951edt.69.2022.06.29.07.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 07:06:19 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Caleb Connolly <caleb.connolly@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [RESEND PATCH v2] dmaengine: qcom: bam_dma: fix runtime PM underflow
Date:   Wed, 29 Jun 2022 15:06:00 +0100
Message-Id: <20220629140559.118537-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Commit dbad41e7bb5f ("dmaengine: qcom: bam_dma: check if the runtime pm enabled")
caused unbalanced pm_runtime_get/put() calls when the bam is
controlled remotely. This commit reverts it and just enables pm_runtime
in all cases, the clk_* functions already just nop when the clock is NULL.

Also clean up a bit by removing unnecessary bamclk null checks.

Suggested-by: Stephan Gerhold <stephan@gerhold.net>
Fixes: dbad41e7bb5f ("dmaengine: qcom: bam_dma: check if the runtime pm enabled")
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---

Resend to fix wording

Boot tested on a OnePlus 6

v1 can be found here:
https://lore.kernel.org/linux-arm-msm/20220609195043.1544625-1-caleb.connolly@linaro.org/
drivers/dma/qcom/bam_dma.c | 39 +++++++++++---------------------------
 1 file changed, 11 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 87f6ca1541cf..2ff787df513e 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -558,14 +558,6 @@ static int bam_alloc_chan(struct dma_chan *chan)
 	return 0;
 }
 
-static int bam_pm_runtime_get_sync(struct device *dev)
-{
-	if (pm_runtime_enabled(dev))
-		return pm_runtime_get_sync(dev);
-
-	return 0;
-}
-
 /**
  * bam_free_chan - Frees dma resources associated with specific channel
  * @chan: specified channel
@@ -581,7 +573,7 @@ static void bam_free_chan(struct dma_chan *chan)
 	unsigned long flags;
 	int ret;
 
-	ret = bam_pm_runtime_get_sync(bdev->dev);
+	ret = pm_runtime_get_sync(bdev->dev);
 	if (ret < 0)
 		return;
 
@@ -784,7 +776,7 @@ static int bam_pause(struct dma_chan *chan)
 	unsigned long flag;
 	int ret;
 
-	ret = bam_pm_runtime_get_sync(bdev->dev);
+	ret = pm_runtime_get_sync(bdev->dev);
 	if (ret < 0)
 		return ret;
 
@@ -810,7 +802,7 @@ static int bam_resume(struct dma_chan *chan)
 	unsigned long flag;
 	int ret;
 
-	ret = bam_pm_runtime_get_sync(bdev->dev);
+	ret = pm_runtime_get_sync(bdev->dev);
 	if (ret < 0)
 		return ret;
 
@@ -919,7 +911,7 @@ static irqreturn_t bam_dma_irq(int irq, void *data)
 	if (srcs & P_IRQ)
 		tasklet_schedule(&bdev->task);
 
-	ret = bam_pm_runtime_get_sync(bdev->dev);
+	ret = pm_runtime_get_sync(bdev->dev);
 	if (ret < 0)
 		return IRQ_NONE;
 
@@ -1037,7 +1029,7 @@ static void bam_start_dma(struct bam_chan *bchan)
 	if (!vd)
 		return;
 
-	ret = bam_pm_runtime_get_sync(bdev->dev);
+	ret = pm_runtime_get_sync(bdev->dev);
 	if (ret < 0)
 		return;
 
@@ -1374,11 +1366,6 @@ static int bam_dma_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_unregister_dma;
 
-	if (!bdev->bamclk) {
-		pm_runtime_disable(&pdev->dev);
-		return 0;
-	}
-
 	pm_runtime_irq_safe(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, BAM_DMA_AUTOSUSPEND_DELAY);
 	pm_runtime_use_autosuspend(&pdev->dev);
@@ -1462,10 +1449,8 @@ static int __maybe_unused bam_dma_suspend(struct device *dev)
 {
 	struct bam_device *bdev = dev_get_drvdata(dev);
 
-	if (bdev->bamclk) {
-		pm_runtime_force_suspend(dev);
-		clk_unprepare(bdev->bamclk);
-	}
+	pm_runtime_force_suspend(dev);
+	clk_unprepare(bdev->bamclk);
 
 	return 0;
 }
@@ -1475,13 +1460,11 @@ static int __maybe_unused bam_dma_resume(struct device *dev)
 	struct bam_device *bdev = dev_get_drvdata(dev);
 	int ret;
 
-	if (bdev->bamclk) {
-		ret = clk_prepare(bdev->bamclk);
-		if (ret)
-			return ret;
+	ret = clk_prepare(bdev->bamclk);
+	if (ret)
+		return ret;
 
-		pm_runtime_force_resume(dev);
-	}
+	pm_runtime_force_resume(dev);
 
 	return 0;
 }
-- 
2.36.1

