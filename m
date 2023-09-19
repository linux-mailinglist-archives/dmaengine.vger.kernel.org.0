Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F372A7A6536
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjISNcy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjISNcp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:45 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50846F9
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:37 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiaq1-0005Sq-ST; Tue, 19 Sep 2023 15:32:26 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiaq0-007T6M-FQ; Tue, 19 Sep 2023 15:32:24 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiaq0-0030hI-4f; Tue, 19 Sep 2023 15:32:24 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Michal Simek <michal.simek@amd.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Harini Katakam <harini.katakam@amd.com>,
        Swati Agarwal <swati.agarwal@amd.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 59/59] dma: xilinx: zynqmp_dma: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:32:07 +0200
Message-Id: <20230919133207.1400430-60-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1910; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Nkd1uX8OdauqmU7BWC20E9W8adt9LLIa97MLrpM+RXs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHz2kgctu0Ux21FU0Jysj13QozCbofBgY3u3 CWtRm/P+ZCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmh8wAKCRCPgPtYfRL+ Ton6B/9unXoW2Qv/126YYkvRu91nSPoX30s5BNwh50cM8TCrmO2EjgFiOcG5gzUVM1a/X4l+ofl wy6cEUxBK7sBey+2nfpig+ds1NuMM36P2qrEAtHd/dmCqK47SkO77296oxJBBzycGhJrmwywV/i riMj6ORpNF1e7KsiJzFPZn5eqJNzDcy7hAtTuCwdkcZknAgGLNI+IvNyqKfouEqlaSX9QaQUDfv 5EsIdYobF2Nd/xWx7RZYii4qZn+sbbbPyLvWQ5XktfCw5MoYHtLYB+v0ygEs4EGmamR0Ic/zJbh HaZlBzXntmHR2RKVlVhHfbtoHloBkBTgDDKmgLZru9YP6NQB
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
 drivers/dma/xilinx/zynqmp_dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index bd8c3cc2eaab..f31631bef961 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -1147,7 +1147,7 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
  *
  * Return: Always '0'
  */
-static int zynqmp_dma_remove(struct platform_device *pdev)
+static void zynqmp_dma_remove(struct platform_device *pdev)
 {
 	struct zynqmp_dma_device *zdev = platform_get_drvdata(pdev);
 
@@ -1158,8 +1158,6 @@ static int zynqmp_dma_remove(struct platform_device *pdev)
 	pm_runtime_disable(zdev->dev);
 	if (!pm_runtime_enabled(zdev->dev))
 		zynqmp_dma_runtime_suspend(zdev->dev);
-
-	return 0;
 }
 
 static const struct of_device_id zynqmp_dma_of_match[] = {
@@ -1175,7 +1173,7 @@ static struct platform_driver zynqmp_dma_driver = {
 		.pm = &zynqmp_dma_dev_pm_ops,
 	},
 	.probe = zynqmp_dma_probe,
-	.remove = zynqmp_dma_remove,
+	.remove_new = zynqmp_dma_remove,
 };
 
 module_platform_driver(zynqmp_dma_driver);
-- 
2.40.1

