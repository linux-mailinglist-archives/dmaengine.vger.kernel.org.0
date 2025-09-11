Return-Path: <dmaengine+bounces-6458-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B68B53E40
	for <lists+dmaengine@lfdr.de>; Thu, 11 Sep 2025 23:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588161B28F1F
	for <lists+dmaengine@lfdr.de>; Thu, 11 Sep 2025 21:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074B32E6CB1;
	Thu, 11 Sep 2025 21:57:04 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEA22E5B13
	for <dmaengine@vger.kernel.org>; Thu, 11 Sep 2025 21:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757627823; cv=none; b=euREzQirIfS88+mTHKRu5FqI/m3Lu53dloRCWjaz6kbHsqrALPXuIHpnAdH+BMavV8jzwLCFoAOSBzK/PlM6ry2GojEbVwhaPkFSMKkIyhd047dGr1l06iAeKvmZ4YezU1YR4H3bXz7ynl1+NiqfMG9iMqH8ghJjFFLlVsD6/gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757627823; c=relaxed/simple;
	bh=9zF4mej1ibTbrnImtNt9POEB2AmOALM3WqplmmIKV4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IeIOhFDAR7MlWjGD/c+pPm7ALv1jBCs0ctnYvKo9xcDcYm2GIOVwH6zpWBNAuPj7lM5MijdbfNshRKAFen3emZkaPk8mGGLykAwSHkpkEbz3fz02Zya/9XTCmgPpYYfyEsBLADQxrZVRAEyld5fkvA9byIXPQ7tflBBCVZ4cgt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1uwpHe-0004g5-0q; Thu, 11 Sep 2025 23:56:50 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Thu, 11 Sep 2025 23:56:42 +0200
Subject: [PATCH v2 01/10] dmaengine: imx-sdma: fix missing
 of_dma_controller_free()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-v6-16-topic-sdma-v2-1-d315f56343b5@pengutronix.de>
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

Add the missing of_dma_controller_free() to free the resources allocated
via of_dma_controller_register() during probe(). The missing free was
introduced long time ago  by commit 23e118113782 ("dma: imx-sdma: use
module_platform_driver for SDMA driver") while adding a proper .remove()
implementation.

Use the driver remove() callback to make it possible to backport this
commit.

Fixes: 23e118113782 ("dma: imx-sdma: use module_platform_driver for SDMA driver")
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/dma/imx-sdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 02a85d6f1bea2df7d355858094c0c0b0bd07148e..3ecb917214b1268b148a29df697b780bc462afa4 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2418,6 +2418,7 @@ static void sdma_remove(struct platform_device *pdev)
 	struct sdma_engine *sdma = platform_get_drvdata(pdev);
 	int i;
 
+	of_dma_controller_free(sdma->dev->of_node);
 	devm_free_irq(&pdev->dev, sdma->irq, sdma);
 	dma_async_device_unregister(&sdma->dma_device);
 	kfree(sdma->script_addrs);

-- 
2.47.3


