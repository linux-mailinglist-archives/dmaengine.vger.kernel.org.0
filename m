Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5C06C92EB
	for <lists+dmaengine@lfdr.de>; Sun, 26 Mar 2023 09:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjCZHGz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 26 Mar 2023 03:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjCZHGx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 26 Mar 2023 03:06:53 -0400
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59D2A5D2
        for <dmaengine@vger.kernel.org>; Sun, 26 Mar 2023 00:06:50 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id gKSipZ5u2E500gKSmpnFFA; Sun, 26 Mar 2023 09:06:49 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 26 Mar 2023 09:06:49 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        dmaengine@vger.kernel.org
Subject: [PATCH 2/2] dmaengine: mv_xor_v2: Use some clk_ helper functions to simplify code
Date:   Sun, 26 Mar 2023 09:06:38 +0200
Message-Id: <cc14e490f4e6002a17c9c7d283fe6a93179766c2.1679814350.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <201170dff832a3c496d125772e10070cd834ebf2.1679814350.git.christophe.jaillet@wanadoo.fr>
References: <201170dff832a3c496d125772e10070cd834ebf2.1679814350.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use devm_clk_get_[optional_]enabled() instead of hand writing it.
It saves some LoC.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Code could be simplified even further and xor_dev->reg_clk and xor_dev->clk
could be removed as well.
---
 drivers/dma/mv_xor_v2.c | 35 +++++++----------------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index 0991b8265829..cea8aa946f9c 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -739,32 +739,18 @@ static int mv_xor_v2_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	xor_dev->reg_clk = devm_clk_get(&pdev->dev, "reg");
-	if (PTR_ERR(xor_dev->reg_clk) != -ENOENT) {
-		if (!IS_ERR(xor_dev->reg_clk)) {
-			ret = clk_prepare_enable(xor_dev->reg_clk);
-			if (ret)
-				return ret;
-		} else {
-			return PTR_ERR(xor_dev->reg_clk);
-		}
-	}
+	xor_dev->reg_clk = devm_clk_get_optional_enabled(&pdev->dev, "reg");
+	if (IS_ERR(xor_dev->reg_clk))
+		return PTR_ERR(xor_dev->reg_clk);
 
-	xor_dev->clk = devm_clk_get(&pdev->dev, NULL);
-	if (PTR_ERR(xor_dev->clk) == -EPROBE_DEFER) {
-		ret = -EPROBE_DEFER;
-		goto disable_reg_clk;
-	}
-	if (!IS_ERR(xor_dev->clk)) {
-		ret = clk_prepare_enable(xor_dev->clk);
-		if (ret)
-			goto disable_reg_clk;
-	}
+	xor_dev->clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(xor_dev->clk))
+		return PTR_ERR(xor_dev->clk);
 
 	ret = platform_msi_domain_alloc_irqs(&pdev->dev, 1,
 					     mv_xor_v2_set_msi_msg);
 	if (ret)
-		goto disable_clk;
+		return ret;
 
 	xor_dev->irq = msi_get_virq(&pdev->dev, 0);
 
@@ -866,10 +852,6 @@ static int mv_xor_v2_probe(struct platform_device *pdev)
 			  xor_dev->hw_desq_virt, xor_dev->hw_desq);
 free_msi_irqs:
 	platform_msi_domain_free_irqs(&pdev->dev);
-disable_clk:
-	clk_disable_unprepare(xor_dev->clk);
-disable_reg_clk:
-	clk_disable_unprepare(xor_dev->reg_clk);
 	return ret;
 }
 
@@ -889,9 +871,6 @@ static int mv_xor_v2_remove(struct platform_device *pdev)
 
 	tasklet_kill(&xor_dev->irq_tasklet);
 
-	clk_disable_unprepare(xor_dev->clk);
-	clk_disable_unprepare(xor_dev->reg_clk);
-
 	return 0;
 }
 
-- 
2.34.1

