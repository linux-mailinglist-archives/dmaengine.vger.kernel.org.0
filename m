Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE407A64F5
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjISNcZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjISNcV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:21 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C9BEC
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:15 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapq-0004ev-5l; Tue, 19 Sep 2023 15:32:14 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapp-007T3Y-Ob; Tue, 19 Sep 2023 15:32:13 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapp-0030eO-FP; Tue, 19 Sep 2023 15:32:13 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 14/59] dma: fsl_raid: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:22 +0200
Message-Id: <20230919133207.1400430-15-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1788; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=v3VRHkdVrKlET1Zuc/3I4iwdDbftxLnfNR5rPQCW040=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaG+3ZxPj+vPvQmZnHE5bvOh0DYl4QknuIFvh LTGepyWNFGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmhvgAKCRCPgPtYfRL+ TppCB/9od4skhY7Oi1naJNJyo/XBk1gTT5C3tTzA0zNgxPa4C68qquHlWYnWsRHQ1bO9iNhm8NQ Yh5cx7uIFlEARtnA7aN45aubpxNsZdOLwKf5Cbfvn4sqm25sQBIRcOJ0y5ce7pXqvqciev8McbE FYpyj4peJc/jE/pr67iw83u/n+QIllYQwP48NJ8THHyLJ0fZ0RYhlz7iW+lDFo+pKt004IlhAxM mYoJ0/qiVuXRO5eiTIFtNCBnaTTZQKWRUuq87DFZTUb4CYwVPBEnOe+NcvseEhFEAyrqJUgxEDq IodvCRnTSDbOeqVupIqUARh2BTvN5jY96TP2pqBifbIoonin
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
 drivers/dma/fsl_raid.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/fsl_raid.c b/drivers/dma/fsl_raid.c
index 0b9ca93ce3dc..014ff523d5ec 100644
--- a/drivers/dma/fsl_raid.c
+++ b/drivers/dma/fsl_raid.c
@@ -857,7 +857,7 @@ static void fsl_re_remove_chan(struct fsl_re_chan *chan)
 		      chan->oub_phys_addr);
 }
 
-static int fsl_re_remove(struct platform_device *ofdev)
+static void fsl_re_remove(struct platform_device *ofdev)
 {
 	struct fsl_re_drv_private *re_priv;
 	struct device *dev;
@@ -872,8 +872,6 @@ static int fsl_re_remove(struct platform_device *ofdev)
 
 	/* Unregister the driver */
 	dma_async_device_unregister(&re_priv->dma_dev);
-
-	return 0;
 }
 
 static const struct of_device_id fsl_re_ids[] = {
@@ -888,7 +886,7 @@ static struct platform_driver fsl_re_driver = {
 		.of_match_table = fsl_re_ids,
 	},
 	.probe = fsl_re_probe,
-	.remove = fsl_re_remove,
+	.remove_new = fsl_re_remove,
 };
 
 module_platform_driver(fsl_re_driver);
-- 
2.40.1

