Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2300D7A6524
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjISNcq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbjISNch (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:37 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C6612D
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiaq0-0005Mf-Ml; Tue, 19 Sep 2023 15:32:24 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapy-007T5w-Od; Tue, 19 Sep 2023 15:32:22 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapy-0030gq-F7; Tue, 19 Sep 2023 15:32:22 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        dmaengine@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 52/59] dma: ti: omap-dma: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:32:00 +0200
Message-Id: <20230919133207.1400430-53-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1829; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=q//S5SKUTn3bvdczkMRBhDuNEA33PewLguXEgYXTTZI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHr3F20+LnW5AGY1wjUknw6+DDYuwhhTr/BU 8W30QysxUiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmh6wAKCRCPgPtYfRL+ TvdzB/9zsVrw5hhKwLhhf13JWoU+mZsLTlVPjwv3UXhrCWSQ0CYxah5ZBButl1BZLoxAlez28tn Nwc6Fpt2VT4xMJSgUm8J5azzeErCop9l/6Ts4yoUTBqqgwKfskU82M7MzKxtSSh3JEtQzaRC8A3 rPukfrz3QQghrcI1GV/rsiP8IoYMtxEeuCY4GPNiwEvl6HMxDgcUBLlAQPIWLTIKDh+2yLdc+XN WBS6dAOcksbMtTEmejfDLrFzU36IdWw8LzlT2eHE7KVzXcPv24z8KP3fjUk23aErRF7/X7Q6RrE 6TMev4C5X8ft7XUUjf9dGX4L1OpH/ZsnO33YV3gJkfxwSkuN
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
 drivers/dma/ti/omap-dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index cf96cf915c0c..76db0fc19524 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1844,7 +1844,7 @@ static int omap_dma_probe(struct platform_device *pdev)
 	return rc;
 }
 
-static int omap_dma_remove(struct platform_device *pdev)
+static void omap_dma_remove(struct platform_device *pdev)
 {
 	struct omap_dmadev *od = platform_get_drvdata(pdev);
 	int irq;
@@ -1869,8 +1869,6 @@ static int omap_dma_remove(struct platform_device *pdev)
 		dma_pool_destroy(od->desc_pool);
 
 	omap_dma_free(od);
-
-	return 0;
 }
 
 static const struct omap_dma_config omap2420_data = {
@@ -1918,7 +1916,7 @@ MODULE_DEVICE_TABLE(of, omap_dma_match);
 
 static struct platform_driver omap_dma_driver = {
 	.probe	= omap_dma_probe,
-	.remove	= omap_dma_remove,
+	.remove_new = omap_dma_remove,
 	.driver = {
 		.name = "omap-dma-engine",
 		.of_match_table = omap_dma_match,
-- 
2.40.1

