Return-Path: <dmaengine+bounces-6470-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB201B53E70
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 00:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B87D16465D
	for <lists+dmaengine@lfdr.de>; Thu, 11 Sep 2025 22:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BEB352FE9;
	Thu, 11 Sep 2025 22:00:54 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA5B33A030
	for <dmaengine@vger.kernel.org>; Thu, 11 Sep 2025 22:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757628053; cv=none; b=haFBFyBu796gymwpuBbJuzGaoOimOBSi2+f3q4t/HaHYKybiE+lCgK1W74OaxnPC8fl8fX5Ldj9Q21RD8VXMKOY84oDNBDvO6pRkCgHedcK+D6ivqZJBu28h4hX8Qrh4nHc/MxVzNb0AkfIwszeiXzzT/5K1lURv1oq3Z5K9nTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757628053; c=relaxed/simple;
	bh=BNKjLiMwo7xVG7m5N0r9qNaKtaldo4UnpNJT9EOqrg0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W1ToZo82c7j4YxqoNDSzABfJqWuWRMe+Lj5YOAAeg40rLyfzjirHjXWJbE4CXfVsndk0VWmM+d2AcDzfV4RBAqI3TDoUOYTRBTtwCvLkf3J5lxD4NsjRIc7BWHCreh2M2GC29ej+BBsHqBj8d+uMKSdESHyuSW6tt2Dzd1/qQaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1uwpLU-0005sG-Me; Fri, 12 Sep 2025 00:00:48 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Fri, 12 Sep 2025 00:00:42 +0200
Subject: [PATCH 2/2] dmaengine: imx-sdma: fix supplier/consumer dependency
 handling
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-v6-16-topic-dma-devlink-v1-2-4debc2fbf901@pengutronix.de>
References: <20250912-v6-16-topic-dma-devlink-v1-0-4debc2fbf901@pengutronix.de>
In-Reply-To: <20250912-v6-16-topic-dma-devlink-v1-0-4debc2fbf901@pengutronix.de>
To: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jiada Wang <jiada_wang@mentor.com>, 
 Frank Li <Frank.Li@nxp.com>
Cc: dmaengine@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Marco Felsch <m.felsch@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org

The whole driver was converted to the devm APIs except for this last
for-loop. This loop is buggy due to three reasons:
 1) It removes the channels without removing the users first. This can
    lead to very bad situations.
 2) The loop starts at 0 and which is channel0 which is a special
    control channel not registered via vchan_init(). Therefore the
    remove() always Oops because of NULL pointer exception.
 3) sdma_free_chan_resources() disable the clks unconditional without
    checking if the clks are enabled. This is done for all
    MAX_DMA_CHANNELS which hang the system if there is at least one unused
    channel.

The first issue is fixed by making use of the dmaengine devlink support.

The second issue is fixed by not doing anything on channel0.

The last issue is also fixed by the devlink support because during the
consumer teardown phase each requested channel is dropped accordingly so
the dmaengine driver doesn't need to this.

To sum-up, all issues are fixed by dropping the .remove() callback and
let the frameworks do their job.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/dma/imx-sdma.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index d4430e6e56deda7de3538e42af7987a456957b43..a11317c8827297d1d6b8ddc0254ecf549e486001 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2393,6 +2393,7 @@ static int sdma_probe(struct platform_device *pdev)
 	sdma->dma_device.device_prep_dma_memcpy = sdma_prep_memcpy;
 	sdma->dma_device.device_issue_pending = sdma_issue_pending;
 	sdma->dma_device.copy_align = 2;
+	sdma->dma_device.create_devlink = true;
 	dma_set_max_seg_size(sdma->dma_device.dev, SDMA_BD_MAX_CNT);
 
 	platform_set_drvdata(pdev, sdma);
@@ -2432,25 +2433,11 @@ static int sdma_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void sdma_remove(struct platform_device *pdev)
-{
-	struct sdma_engine *sdma = platform_get_drvdata(pdev);
-	int i;
-
-	/* Kill the tasklet */
-	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
-		struct sdma_channel *sdmac = &sdma->channel[i];
-
-		sdma_free_chan_resources(&sdmac->vc.chan);
-	}
-}
-
 static struct platform_driver sdma_driver = {
 	.driver		= {
 		.name	= "imx-sdma",
 		.of_match_table = sdma_dt_ids,
 	},
-	.remove		= sdma_remove,
 	.probe		= sdma_probe,
 };
 

-- 
2.47.3


