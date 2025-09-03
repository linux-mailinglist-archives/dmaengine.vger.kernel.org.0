Return-Path: <dmaengine+bounces-6360-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC13BB4206F
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 15:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3B01BA817A
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 13:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5921530498D;
	Wed,  3 Sep 2025 13:06:26 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6943019D3
	for <dmaengine@vger.kernel.org>; Wed,  3 Sep 2025 13:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904786; cv=none; b=LPGkM/vB9/EIEKF3WlrZI1EIc/NHpyBPL3uR9ChKmSRlt/+nXWDOYyDNiD9p9LzsnZ+caoE5kKKSQBBk7XrThvluB8dJj0FgPFnjdK1FUsH/kkkTeOlfXZDsYKvhGWgpMiOAFb81bmRVnbYyXZyF6cLB0AOwkmNug/meEmXN0pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904786; c=relaxed/simple;
	bh=XDKPHV75wgIjXXUhw4V5YtDkPybmhaqtXj422XNlmpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H/psOxceE/wYgfKO5zANadMc4ddF091AALxquvS2xEVpwyfI2DtI3kgHSMDc1FyfUM+pW78CqwNEoOwV8AdXNCwuHhnAC9xqX+Xmiq6d2zxzg3yk1NKnxMNqWmpoObnbOSlOvKbaXpMLozK/4C7Hw0Zq42hvo/Xkvasg+2pfaEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1utnBm-00006Z-1K; Wed, 03 Sep 2025 15:06:14 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Wed, 03 Sep 2025 15:06:18 +0200
Subject: [PATCH 10/11] dmaengine: imx-sdma: drop remove callback
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-v6-16-topic-sdma-v1-10-ac7bab629e8b@pengutronix.de>
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

Since the dmaengine core supports devlinks we already addressed the
first issue.

The devlink support also addresses the third issue because during the
consumer teardown phase each requested channel is dropped accordingly so
the dmaengine driver doesn't need to this.

The second issue is fixed by not doing anything on channel0.

To sum-up, all issues are fixed by dropping the .remove() callback and
let the frameworks do their job.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/dma/imx-sdma.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 6c6d38b202dd2deffc36b1bd27bc7c60de3d7403..c31785977351163d6fddf4d8b2f90dfebb508400 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2405,25 +2405,11 @@ static int sdma_probe(struct platform_device *pdev)
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
2.47.2


