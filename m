Return-Path: <dmaengine+bounces-6353-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81ADCB4206C
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 15:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6AEF1BC006D
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 13:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C8F3019C1;
	Wed,  3 Sep 2025 13:06:23 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAA230147C
	for <dmaengine@vger.kernel.org>; Wed,  3 Sep 2025 13:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904783; cv=none; b=hWpT8MYW0OSqkq0UqVnHOct73YQqkIvTe3fVXNRvi0c9nWwLDF/zWoBLcUdf+sRTJFIgly+1ky6kSyHBQisTZXEDI7t2FPE1GHSPRiTMuo0dkXyWMkrwoWw3MypwIFl/+2dfv1O/8SVeCodfPZYNvqFBMwF1Zk0Pg27YJMpRM/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904783; c=relaxed/simple;
	bh=tQSJBiKibb4DJjgBw5ixcANjVU0K2CDPdBXgX70RmkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A1f1YkCYy339pZyGdb4S0PvSHlAcoRVp0arKhtcsXDHXOuXy+Tqlq4aI0V3galXEbuTP82BqGcddBm8s0lg4N9pZSLdL4rKSEL9CF0F2VL6qJV3r5xizIDTo45/O/NL8FA1jAXCMsYSR8byfMPiH6i1+HoLuv6f/+nlFmOmeCng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1utnBl-00006Z-MM; Wed, 03 Sep 2025 15:06:13 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Wed, 03 Sep 2025 15:06:11 +0200
Subject: [PATCH 03/11] dmaengine: imx-sdma: cosmetic cleanup
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-v6-16-topic-sdma-v1-3-ac7bab629e8b@pengutronix.de>
References: <20250903-v6-16-topic-sdma-v1-0-ac7bab629e8b@pengutronix.de>
In-Reply-To: <20250903-v6-16-topic-sdma-v1-0-ac7bab629e8b@pengutronix.de>
To: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jiada Wang <jiada_wang@mentor.com>
Cc: dmaengine@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Marco Felsch <m.felsch@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org

Make use of local struct device pointer to not dereference the
platform_device pointer everytime.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/dma/imx-sdma.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 422086632d3445b2ce3f2e5df9b2130174a311e8..a85739d279f51fdb517fce90b3dc67673cf2b56c 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2234,7 +2234,8 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
 
 static int sdma_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct device_node *spba_bus;
 	const char *fw_name;
 	int ret;
@@ -2244,18 +2245,18 @@ static int sdma_probe(struct platform_device *pdev)
 	struct sdma_engine *sdma;
 	s32 *saddr_arr;
 
-	ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
 	if (ret)
 		return ret;
 
-	sdma = devm_kzalloc(&pdev->dev, sizeof(*sdma), GFP_KERNEL);
+	sdma = devm_kzalloc(dev, sizeof(*sdma), GFP_KERNEL);
 	if (!sdma)
 		return -ENOMEM;
 
 	spin_lock_init(&sdma->channel_0_lock);
 
-	sdma->dev = &pdev->dev;
-	sdma->drvdata = of_device_get_match_data(sdma->dev);
+	sdma->dev = dev;
+	sdma->drvdata = of_device_get_match_data(dev);
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -2265,11 +2266,11 @@ static int sdma_probe(struct platform_device *pdev)
 	if (IS_ERR(sdma->regs))
 		return PTR_ERR(sdma->regs);
 
-	sdma->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
+	sdma->clk_ipg = devm_clk_get(dev, "ipg");
 	if (IS_ERR(sdma->clk_ipg))
 		return PTR_ERR(sdma->clk_ipg);
 
-	sdma->clk_ahb = devm_clk_get(&pdev->dev, "ahb");
+	sdma->clk_ahb = devm_clk_get(dev, "ahb");
 	if (IS_ERR(sdma->clk_ahb))
 		return PTR_ERR(sdma->clk_ahb);
 
@@ -2281,8 +2282,8 @@ static int sdma_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clk;
 
-	ret = devm_request_irq(&pdev->dev, irq, sdma_int_handler, 0,
-				dev_name(&pdev->dev), sdma);
+	ret = devm_request_irq(dev, irq, sdma_int_handler, 0,
+			       dev_name(dev), sdma);
 	if (ret)
 		goto err_irq;
 
@@ -2327,7 +2328,7 @@ static int sdma_probe(struct platform_device *pdev)
 
 	sdma->iram_pool = of_gen_pool_get(np, "iram", 0);
 	if (sdma->iram_pool)
-		dev_info(&pdev->dev, "alloc bd from iram.\n");
+		dev_info(dev, "alloc bd from iram.\n");
 
 	ret = sdma_init(sdma);
 	if (ret)
@@ -2340,7 +2341,7 @@ static int sdma_probe(struct platform_device *pdev)
 	if (sdma->drvdata->script_addrs)
 		sdma_add_scripts(sdma, sdma->drvdata->script_addrs);
 
-	sdma->dma_device.dev = &pdev->dev;
+	sdma->dma_device.dev = dev;
 
 	sdma->dma_device.device_alloc_chan_resources = sdma_alloc_chan_resources;
 	sdma->dma_device.device_free_chan_resources = sdma_free_chan_resources;
@@ -2363,13 +2364,13 @@ static int sdma_probe(struct platform_device *pdev)
 
 	ret = dma_async_device_register(&sdma->dma_device);
 	if (ret) {
-		dev_err(&pdev->dev, "unable to register\n");
+		dev_err(dev, "unable to register\n");
 		goto err_init;
 	}
 
 	ret = of_dma_controller_register(np, sdma_xlate, sdma);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to register controller\n");
+		dev_err(dev, "failed to register controller\n");
 		goto err_register;
 	}
 
@@ -2389,11 +2390,11 @@ static int sdma_probe(struct platform_device *pdev)
 	ret = of_property_read_string(np, "fsl,sdma-ram-script-name",
 				      &fw_name);
 	if (ret) {
-		dev_warn(&pdev->dev, "failed to get firmware name\n");
+		dev_warn(dev, "failed to get firmware name\n");
 	} else {
 		ret = sdma_get_firmware(sdma, fw_name);
 		if (ret)
-			dev_warn(&pdev->dev, "failed to get firmware from device tree\n");
+			dev_warn(dev, "failed to get firmware from device tree\n");
 	}
 
 	return 0;

-- 
2.47.2


