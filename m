Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72D57A6520
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjISNco (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjISNcg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:36 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8C9129
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiaq1-0005Ol-B1; Tue, 19 Sep 2023 15:32:25 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapz-007T63-6u; Tue, 19 Sep 2023 15:32:23 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapy-0030gx-Rm; Tue, 19 Sep 2023 15:32:22 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 54/59] dma: txx9dmac: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:32:02 +0200
Message-Id: <20230919133207.1400430-55-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2595; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=R11KPobSn7r186XiXMFetAdcJGYGunyGcsscfFvQUfg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHt1lItaf/VF2sdW1fL8S7rQ8t9Ox6rkHMyo fAMygXG/6uJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmh7QAKCRCPgPtYfRL+ TvBYB/42ztlFQOxuJ6UtTQMv/91SZ8X/YWLmem3LLedxhD/7eqzspwG/wavZCoRQqt/8qaEjjMs jd841PftR9w1oTPO00UUYPXR6GF2cC0L1RgML3Wqct93IMLD3z7sY8mmxvc42/qDe89cxbs1nOs ZenY+TT7sAX8Mq1/LQV+f1V9NnvfuQ5LjH0awZW5hX3QjpW3AeXvoxLtUkwrVoPVgG/k6WqkJaT OfDy2GYz5pzVKif4os0MEfNqIBP/rXHTCRc9JVeLe/sJQ/kgQSx8+qxY1tFFC29Igi9W7e5N0oe mUKt5qfXibB9LE3OnneUxqWBVjgbDRO+gB6A1GiG/W5IBh/0
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.
To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new() which already returns void. Eventually after all drivers
are converted, .remove_new() is renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/dma/txx9dmac.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/txx9dmac.c b/drivers/dma/txx9dmac.c
index 5b6b375a257e..44ba377b4b5a 100644
--- a/drivers/dma/txx9dmac.c
+++ b/drivers/dma/txx9dmac.c
@@ -1151,7 +1151,7 @@ static int __init txx9dmac_chan_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int txx9dmac_chan_remove(struct platform_device *pdev)
+static void txx9dmac_chan_remove(struct platform_device *pdev)
 {
 	struct txx9dmac_chan *dc = platform_get_drvdata(pdev);
 
@@ -1162,7 +1162,6 @@ static int txx9dmac_chan_remove(struct platform_device *pdev)
 		tasklet_kill(&dc->tasklet);
 	}
 	dc->ddev->chan[pdev->id % TXX9_DMA_MAX_NR_CHANNELS] = NULL;
-	return 0;
 }
 
 static int __init txx9dmac_probe(struct platform_device *pdev)
@@ -1215,7 +1214,7 @@ static int __init txx9dmac_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int txx9dmac_remove(struct platform_device *pdev)
+static void txx9dmac_remove(struct platform_device *pdev)
 {
 	struct txx9dmac_dev *ddev = platform_get_drvdata(pdev);
 
@@ -1224,7 +1223,6 @@ static int txx9dmac_remove(struct platform_device *pdev)
 		devm_free_irq(&pdev->dev, ddev->irq, ddev);
 		tasklet_kill(&ddev->tasklet);
 	}
-	return 0;
 }
 
 static void txx9dmac_shutdown(struct platform_device *pdev)
@@ -1262,14 +1260,14 @@ static const struct dev_pm_ops txx9dmac_dev_pm_ops = {
 };
 
 static struct platform_driver txx9dmac_chan_driver = {
-	.remove		= txx9dmac_chan_remove,
+	.remove_new	= txx9dmac_chan_remove,
 	.driver = {
 		.name	= "txx9dmac-chan",
 	},
 };
 
 static struct platform_driver txx9dmac_driver = {
-	.remove		= txx9dmac_remove,
+	.remove_new	= txx9dmac_remove,
 	.shutdown	= txx9dmac_shutdown,
 	.driver = {
 		.name	= "txx9dmac",
-- 
2.40.1

