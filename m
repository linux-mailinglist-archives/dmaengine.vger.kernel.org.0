Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5B17A651D
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjISNcm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbjISNcf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:35 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92F0125
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiaq1-0005Pi-AX; Tue, 19 Sep 2023 15:32:25 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapz-007T66-Eh; Tue, 19 Sep 2023 15:32:23 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapz-0030h2-4K; Tue, 19 Sep 2023 15:32:23 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 55/59] dma: xgene-dma: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:32:03 +0200
Message-Id: <20230919133207.1400430-56-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1830; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=USoMClqln1iL9Q1cbh+gC3Zp0/ti44srvL+C7Pc7GZg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHuACSxsvu1jo4+mW25/aFpZ7bGLJhHMfG7B aNCay7CNIiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmh7gAKCRCPgPtYfRL+ Thl2B/wNFhRo/yoRES/4YstoQBlA7p3bx2Wz3F1PfflC+puZJ3xJyMkwlABjQMF/05+KSphgWP7 z/ob7gIyTo+YFL7l59qn57vBMphTxhy7JNRpiONva9CesKafhwtm8vsz8cdMD9YctjNccWJTKIt KAb75pQ3UPwV/m/kPVoFATkTfYAraTfewafKg1PaqU2XJco4qLXCcT7YIYTayGKAVS/qfOH8Vj0 nEzNHwadbA3S4FXYtB8CFGNDFX+eGY0fvDS2K4f0fm0LrIqXEZM52f7wOupGTTOAl9HtV2v1DZ9 QQVRhxunSYioz6lzKry1WWCgMXQ0IP0LXUZTzlDVZ5dWALq2
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
 drivers/dma/xgene-dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xgene-dma.c b/drivers/dma/xgene-dma.c
index bb4ff8c86733..fd4397adeb79 100644
--- a/drivers/dma/xgene-dma.c
+++ b/drivers/dma/xgene-dma.c
@@ -1776,7 +1776,7 @@ static int xgene_dma_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int xgene_dma_remove(struct platform_device *pdev)
+static void xgene_dma_remove(struct platform_device *pdev)
 {
 	struct xgene_dma *pdma = platform_get_drvdata(pdev);
 	struct xgene_dma_chan *chan;
@@ -1797,8 +1797,6 @@ static int xgene_dma_remove(struct platform_device *pdev)
 
 	if (!IS_ERR(pdma->clk))
 		clk_disable_unprepare(pdma->clk);
-
-	return 0;
 }
 
 #ifdef CONFIG_ACPI
@@ -1817,7 +1815,7 @@ MODULE_DEVICE_TABLE(of, xgene_dma_of_match_ptr);
 
 static struct platform_driver xgene_dma_driver = {
 	.probe = xgene_dma_probe,
-	.remove = xgene_dma_remove,
+	.remove_new = xgene_dma_remove,
 	.driver = {
 		.name = "X-Gene-DMA",
 		.of_match_table = xgene_dma_of_match_ptr,
-- 
2.40.1

