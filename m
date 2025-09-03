Return-Path: <dmaengine+bounces-6352-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CBBB4206B
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 15:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7839C1BC0056
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 13:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41443019D0;
	Wed,  3 Sep 2025 13:06:23 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BEB301482
	for <dmaengine@vger.kernel.org>; Wed,  3 Sep 2025 13:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904783; cv=none; b=qFfm4edzEglO5MQWd3atGqZPTwLi/j68YTXughQDc9Kf6pRGFcHVQRcspeT5wz9D47XXaGq4u35/HX92I9p1Gb4qCw50N9CmNt5N9cxTZN0S1Xr906tj2o/lZU8OwJK1+TgaImfUVXGqsORLE/WIO/CDzAg+Z9uUnxYZEl6DB6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904783; c=relaxed/simple;
	bh=ZSYgiNmAKV3p8BUF1bCLjSthybct+I4PA/kpVGiQY/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=boiZ9D+wNhsd81DB3ajbsAi4y/ugMzqIHNWO+wQUCbngIO6UrMOm2ZniAW3z7RyjIQlXs0ztMco1h7X2m9CBG/YCPTBnIvGzaOLt69ZbTD3pYqZzyeqFWY8cJOHPP1aaetuFlSvxnmt0cLS0UzNYAberRHe98H1f4ql+B1MDNas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1utnBl-00006Z-R7; Wed, 03 Sep 2025 15:06:13 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Wed, 03 Sep 2025 15:06:14 +0200
Subject: [PATCH 06/11] dmaengine: imx-sdma: make use of
 devm_add_action_or_reset to unregiser the dma_device
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-v6-16-topic-sdma-v1-6-ac7bab629e8b@pengutronix.de>
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

Make use of the devm_add_action_or_reset() to register a custom devm_
release hook. This is required since we want to turn of the IRQs before
doing the dma_async_device_unregister().

This removes the last goto error handling within the probe function and
further trims the remove() function. Instead of freeing the irq, we can
disable it and let the devm-irq do the job to free the irq, since the
only purpose was to have the irqs disabled before calling
dma_async_device_unregister().

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/dma/imx-sdma.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 5a571d3f33158813e0c56484600a49b19a6a72e2..f6bb2f88a62781c0431336c365fa30c46f1401ad 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2232,6 +2232,14 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
 				     ofdma->of_node);
 }
 
+static void sdma_dma_device_unregister_action(void *data)
+{
+	struct sdma_engine *sdma = data;
+
+	disable_irq(sdma->irq);
+	dma_async_device_unregister(&sdma->dma_device);
+}
+
 static int sdma_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -2358,10 +2366,12 @@ static int sdma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	devm_add_action_or_reset(dev, sdma_dma_device_unregister_action, sdma);
+
 	ret = of_dma_controller_register(np, sdma_xlate, sdma);
 	if (ret) {
 		dev_err(dev, "failed to register controller\n");
-		goto err_register;
+		return ret;
 	}
 
 	spba_bus = of_find_compatible_node(NULL, NULL, "fsl,spba-bus");
@@ -2388,11 +2398,6 @@ static int sdma_probe(struct platform_device *pdev)
 	}
 
 	return 0;
-
-err_register:
-	dma_async_device_unregister(&sdma->dma_device);
-
-	return ret;
 }
 
 static void sdma_remove(struct platform_device *pdev)
@@ -2400,8 +2405,6 @@ static void sdma_remove(struct platform_device *pdev)
 	struct sdma_engine *sdma = platform_get_drvdata(pdev);
 	int i;
 
-	devm_free_irq(&pdev->dev, sdma->irq, sdma);
-	dma_async_device_unregister(&sdma->dma_device);
 	/* Kill the tasklet */
 	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
 		struct sdma_channel *sdmac = &sdma->channel[i];

-- 
2.47.2


