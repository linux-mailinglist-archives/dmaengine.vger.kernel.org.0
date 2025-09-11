Return-Path: <dmaengine+bounces-6460-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D815B53E46
	for <lists+dmaengine@lfdr.de>; Thu, 11 Sep 2025 23:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF7595C034E
	for <lists+dmaengine@lfdr.de>; Thu, 11 Sep 2025 21:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7692D2E62C5;
	Thu, 11 Sep 2025 21:57:04 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85E32E5B0C
	for <dmaengine@vger.kernel.org>; Thu, 11 Sep 2025 21:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757627824; cv=none; b=Bq0M35wpDbMTvEQ1LOVx373bfoWQYrO3+V76yt3D0HuAv/qCOBuxh8mQyvsz/WFv1OoztMVyhutMHtsVrb7FE8I6LEs8+CD4atVbPld7N+rKKZUonPASkP/x/NfiDfxYJV821eGm5039RmpuF6MdNZ6gE26Xz9D4w9Z4XLk2lY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757627824; c=relaxed/simple;
	bh=cL1unuE3WF08z+2/1hEr0+OZ0Bd6FXIqUHhnJzPyAA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ErBnpHWwV39bA2FnJxZQzxMTuXFmykiARYZlh1XmENwZrjM38R6H1TmpTaSJYEl/eYy8xaK4tc7EDqh2wH4/dPuoUHoWzlEeeAfYRtfu5ecW1xlh+aI9cyk/I0X/gtUh5QM7sIZjEkPVpWcnEshzS25MoZQeBd6TBjIKVjy41HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1uwpHe-0004g5-ES; Thu, 11 Sep 2025 23:56:50 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Thu, 11 Sep 2025 23:56:50 +0200
Subject: [PATCH v2 09/10] dmaengine: imx-sdma: make use of
 devm_add_action_or_reset to unregiser the dma-controller
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-v6-16-topic-sdma-v2-9-d315f56343b5@pengutronix.de>
References: <20250911-v6-16-topic-sdma-v2-0-d315f56343b5@pengutronix.de>
In-Reply-To: <20250911-v6-16-topic-sdma-v2-0-d315f56343b5@pengutronix.de>
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

Use the devres capabilities to cleanup the driver remove() callback.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/dma/imx-sdma.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index d6d0d4300f540268a3ab4a6b14af685f7b93275a..a7e6554ca223e2e980caf2e2dea832db9ad60ed6 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2264,6 +2264,13 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
 				     ofdma->of_node);
 }
 
+static void sdma_dma_of_dma_controller_unregister_action(void *data)
+{
+	struct sdma_engine *sdma = data;
+
+	of_dma_controller_free(sdma->dev->of_node);
+}
+
 static void sdma_dma_device_unregister_action(void *data)
 {
 	struct sdma_engine *sdma = data;
@@ -2408,6 +2415,12 @@ static int sdma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = devm_add_action_or_reset(dev, sdma_dma_of_dma_controller_unregister_action, sdma);
+	if (ret) {
+		dev_err(dev, "failed to register of-dma-controller unregister hook\n");
+		return ret;
+	}
+
 	/*
 	 * Because that device tree does not encode ROM script address,
 	 * the RAM script in firmware is mandatory for device tree
@@ -2431,7 +2444,6 @@ static void sdma_remove(struct platform_device *pdev)
 	struct sdma_engine *sdma = platform_get_drvdata(pdev);
 	int i;
 
-	of_dma_controller_free(sdma->dev->of_node);
 	/* Kill the tasklet */
 	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
 		struct sdma_channel *sdmac = &sdma->channel[i];

-- 
2.47.3


