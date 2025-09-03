Return-Path: <dmaengine+bounces-6357-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BF6B42075
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 15:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE46E6870C9
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 13:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BB83019CE;
	Wed,  3 Sep 2025 13:06:24 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29553043A9
	for <dmaengine@vger.kernel.org>; Wed,  3 Sep 2025 13:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904784; cv=none; b=GFqp+/eFl168wlFu/7VEpGiQ/NOEokmcTHXZtNHBMRfEcdnfubfMQocf1iENBRJJs2evJFYv2i7RaGRBYx8YWH4Zq2FpLggI9Ju9P4bKB43SJ+J14daNemEwNuSw5hYv6XjkFpRWf2nGCipKqmMHQZY8WtE6BcIwKvOqslPAl/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904784; c=relaxed/simple;
	bh=37VV1I2Hqg8hD248V3Pbbjkx0VlRNKUxdxIH5c9R6jI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uSkbkYzqYK4owY99zBKDkionwhC960fpVw/nDbQn2CwemX+IFFg8Or7/7UUHUDFZMUlJoaaNlmFHQ52cR5SP76olizbE6DZpmkLdnnIUpeNLEMvvzpnctFFL5aY/LWaAxpC3pHqzVHnF/HCGhd1yGsTWbHcU+thbnASHjTo2G4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1utnBl-00006Z-SZ; Wed, 03 Sep 2025 15:06:13 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Wed, 03 Sep 2025 15:06:15 +0200
Subject: [PATCH 07/11] dmaengine: imx-sdma: make use of dev_err_probe()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-v6-16-topic-sdma-v1-7-ac7bab629e8b@pengutronix.de>
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

Convert the probe function to dev_err_probe() which helps users to
identify issues better.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/dma/imx-sdma.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index f6bb2f88a62781c0431336c365fa30c46f1401ad..e30dd46cf6522ee2aa4d3aca9868a01afbd29615 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2255,7 +2255,7 @@ static int sdma_probe(struct platform_device *pdev)
 
 	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "Failed to set DMA mask\n");
 
 	sdma = devm_kzalloc(dev, sizeof(*sdma), GFP_KERNEL);
 	if (!sdma)
@@ -2272,24 +2272,24 @@ static int sdma_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-		return irq;
+		return dev_err_probe(dev, irq, "Failed to get IRQ\n");
 
 	sdma->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sdma->regs))
-		return PTR_ERR(sdma->regs);
+		return dev_err_probe(dev, PTR_ERR(sdma->regs), "ioremap failed\n");
 
 	sdma->clk_ipg = devm_clk_get_prepared(dev, "ipg");
 	if (IS_ERR(sdma->clk_ipg))
-		return PTR_ERR(sdma->clk_ipg);
+		return dev_err_probe(dev, PTR_ERR(sdma->clk_ipg), "IPG clk_get_prepared failed\n");
 
 	sdma->clk_ahb = devm_clk_get_prepared(dev, "ahb");
 	if (IS_ERR(sdma->clk_ahb))
-		return PTR_ERR(sdma->clk_ahb);
+		return dev_err_probe(dev, PTR_ERR(sdma->clk_ahb), "AHB clk_get_prepared failed\n");
 
 	ret = devm_request_irq(dev, irq, sdma_int_handler, 0,
 			       dev_name(dev), sdma);
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "Failed to request IRQ\n");
 
 	sdma->irq = irq;
 
@@ -2330,11 +2330,11 @@ static int sdma_probe(struct platform_device *pdev)
 
 	ret = sdma_init(sdma);
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "sdma_init failed\n");
 
 	ret = sdma_event_remap(sdma);
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "sdma_event_remap failed\n");
 
 	if (sdma->drvdata->script_addrs)
 		sdma_add_scripts(sdma, sdma->drvdata->script_addrs);
@@ -2361,18 +2361,14 @@ static int sdma_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, sdma);
 
 	ret = dma_async_device_register(&sdma->dma_device);
-	if (ret) {
-		dev_err(dev, "unable to register\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "unable to register\n");
 
 	devm_add_action_or_reset(dev, sdma_dma_device_unregister_action, sdma);
 
 	ret = of_dma_controller_register(np, sdma_xlate, sdma);
-	if (ret) {
-		dev_err(dev, "failed to register controller\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register controller\n");
 
 	spba_bus = of_find_compatible_node(NULL, NULL, "fsl,spba-bus");
 	ret = of_address_to_resource(spba_bus, 0, &spba_res);

-- 
2.47.2


