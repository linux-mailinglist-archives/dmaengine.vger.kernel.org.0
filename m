Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB053F84BD
	for <lists+dmaengine@lfdr.de>; Thu, 26 Aug 2021 11:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbhHZJse (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Aug 2021 05:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbhHZJsc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 26 Aug 2021 05:48:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80E5C061757
        for <dmaengine@vger.kernel.org>; Thu, 26 Aug 2021 02:47:45 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1mJBz5-0003c3-6u; Thu, 26 Aug 2021 11:47:43 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1mJBz4-0006kr-8d; Thu, 26 Aug 2021 11:47:42 +0200
Received: from mtr by dude03.red.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1mJBz4-005Siw-7j; Thu, 26 Aug 2021 11:47:42 +0200
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     vkoul@kernel.org, dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, appana.durga.rao@xilinx.com,
        michal.simek@xilinx.com, m.tretter@pengutronix.de,
        kernel@pengutronix.de
Subject: [PATCH 1/7] dmaengine: zynqmp_dma: simplify with dev_err_probe
Date:   Thu, 26 Aug 2021 11:47:36 +0200
Message-Id: <20210826094742.1302009-2-m.tretter@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210826094742.1302009-1-m.tretter@pengutronix.de>
References: <20210826094742.1302009-1-m.tretter@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The clocks are provided by the ZynqMP firmware driver and are deferred
until the firmware driver has probed. This leads to misleading error
messages during probe of the zynqmp_dma driver.

Use dev_err_probe for printing errors during probe to avoid error
messages for -EPROBE_DEFER.

Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
---
 drivers/dma/xilinx/zynqmp_dma.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index 5fecf5aa6e85..8423fbfc20c7 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -1062,16 +1062,14 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
 	p->dev = &pdev->dev;
 
 	zdev->clk_main = devm_clk_get(&pdev->dev, "clk_main");
-	if (IS_ERR(zdev->clk_main)) {
-		dev_err(&pdev->dev, "main clock not found.\n");
-		return PTR_ERR(zdev->clk_main);
-	}
+	if (IS_ERR(zdev->clk_main))
+		return dev_err_probe(&pdev->dev, PTR_ERR(zdev->clk_main),
+				     "main clock not found.\n");
 
 	zdev->clk_apb = devm_clk_get(&pdev->dev, "clk_apb");
-	if (IS_ERR(zdev->clk_apb)) {
-		dev_err(&pdev->dev, "apb clock not found.\n");
-		return PTR_ERR(zdev->clk_apb);
-	}
+	if (IS_ERR(zdev->clk_apb))
+		return dev_err_probe(&pdev->dev, PTR_ERR(zdev->clk_apb),
+				     "apb clock not found.\n");
 
 	platform_set_drvdata(pdev, zdev);
 	pm_runtime_set_autosuspend_delay(zdev->dev, ZDMA_PM_TIMEOUT);
@@ -1086,7 +1084,7 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
 
 	ret = zynqmp_dma_chan_probe(zdev, pdev);
 	if (ret) {
-		dev_err(&pdev->dev, "Probing channel failed\n");
+		dev_err_probe(&pdev->dev, ret, "Probing channel failed\n");
 		goto err_disable_pm;
 	}
 
@@ -1098,7 +1096,7 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
 	ret = of_dma_controller_register(pdev->dev.of_node,
 					 of_zynqmp_dma_xlate, zdev);
 	if (ret) {
-		dev_err(&pdev->dev, "Unable to register DMA to DT\n");
+		dev_err_probe(&pdev->dev, ret, "Unable to register DMA to DT\n");
 		dma_async_device_unregister(&zdev->common);
 		goto free_chan_resources;
 	}
-- 
2.30.2

