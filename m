Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0E35BBD3D
	for <lists+dmaengine@lfdr.de>; Sun, 18 Sep 2022 11:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiIRJ7o (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 18 Sep 2022 05:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiIRJ7X (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 18 Sep 2022 05:59:23 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19229F4F;
        Sun, 18 Sep 2022 02:59:19 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1663495158; bh=LrJPTCNgJnKyYQZq+jzf17tmj1SfmkEssly/2yyWLXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VQt1bFhxVZIgI0lk3VKPibjdw92XIuzyJf5Jh1JYuWIUcFaOQY88E6ksD5tsdb/L2
         BmCIssV4FXl+DOq6rKXgZOoPSLQlYA7go+QjyqoDyACc6+9/ya1FQ5kc07+kKd88fW
         EcJCpUC3bu8jkmmPw005ZxDPT0SckNd2qaABSlHc=
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Subject: [PATCH 4/4] dmaengine: apple-admac: Trigger shared reset
Date:   Sun, 18 Sep 2022 11:58:45 +0200
Message-Id: <20220918095845.68860-5-povik+lin@cutebit.org>
In-Reply-To: <20220918095845.68860-1-povik+lin@cutebit.org>
References: <20220918095845.68860-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

If a reset domain is attached to the device, obtain a shared reference
to it and trigger it. Typically on a chip the ADMAC controller will
share a reset domain with the MCA peripheral.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 drivers/dma/apple-admac.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/apple-admac.c b/drivers/dma/apple-admac.c
index 7d1b76678032..317ca76ccafd 100644
--- a/drivers/dma/apple-admac.c
+++ b/drivers/dma/apple-admac.c
@@ -12,8 +12,9 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
-#include <linux/interrupt.h>
+#include <linux/reset.h>
 #include <linux/spinlock.h>
+#include <linux/interrupt.h>
 
 #include "dmaengine.h"
 
@@ -95,6 +96,7 @@ struct admac_data {
 	struct dma_device dma;
 	struct device *dev;
 	__iomem void *base;
+	struct reset_control *rstc;
 
 	int irq;
 	int irq_index;
@@ -732,6 +734,10 @@ static int admac_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(ad->base),
 				     "unable to obtain MMIO resource\n");
 
+	ad->rstc = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
+	if (IS_ERR(ad->rstc))
+		return PTR_ERR(ad->rstc);
+
 	dma = &ad->dma;
 
 	dma_cap_set(DMA_PRIVATE, dma->cap_mask);
@@ -770,10 +776,17 @@ static int admac_probe(struct platform_device *pdev)
 		tasklet_setup(&adchan->tasklet, admac_chan_tasklet);
 	}
 
-	err = request_irq(irq, admac_interrupt, 0, dev_name(&pdev->dev), ad);
+	err = reset_control_reset(ad->rstc);
 	if (err)
 		return dev_err_probe(&pdev->dev, err,
-				     "unable to register interrupt\n");
+				     "unable to trigger reset\n");
+
+	err = request_irq(irq, admac_interrupt, 0, dev_name(&pdev->dev), ad);
+	if (err) {
+		dev_err_probe(&pdev->dev, err,
+				"unable to register interrupt\n");
+		goto free_reset;
+	}
 
 	err = dma_async_device_register(&ad->dma);
 	if (err) {
@@ -792,6 +805,8 @@ static int admac_probe(struct platform_device *pdev)
 
 free_irq:
 	free_irq(ad->irq, ad);
+free_reset:
+	reset_control_rearm(ad->rstc);
 	return err;
 }
 
@@ -802,6 +817,7 @@ static int admac_remove(struct platform_device *pdev)
 	of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&ad->dma);
 	free_irq(ad->irq, ad);
+	reset_control_rearm(ad->rstc);
 
 	return 0;
 }
-- 
2.33.0

