Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84617A652C
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjISNct (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbjISNci (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:38 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2602131
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapx-0005By-QP; Tue, 19 Sep 2023 15:32:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapw-007T5J-6t; Tue, 19 Sep 2023 15:32:20 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapv-0030gG-Ts; Tue, 19 Sep 2023 15:32:19 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        dmaengine@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 43/59] dma: sprd-dma: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:51 +0200
Message-Id: <20230919133207.1400430-44-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1851; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=VLMqnrQaM3pkJaqRiSQLo7cg0ca3HbzYkbAo4PQVlDQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHg3S+Rw27tH6Pj6Dc5pFdAooXxoZvV241Sp tAfoJK/zvSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmh4AAKCRCPgPtYfRL+ TnqGCACIJW+tQCF6Qi9DDVdY1dFZ2M37nEbodFDOK5/unVtJtM96xAaSUQIAHD4QGkGv853mhcA Rww87H5XtTcbRSWx2bVPV5kajS7JAYSaA6WfVW6AARbuBG61chXwnFA1r+u7tMYEyCOF2mRY0CJ XfnZX4+HZ5MEaUqF8Rx0ht4lbFnfrXVbH8jKVOKMR5BausYLnEBu3H7qjuXkJAgOzKkfZ4tGpXN 6zVlnux5d/CP47zFxhm2AGIRENXtN1njv26mNKWulB25DCgjt2isxg9bzEhkv7iAzsT3lhH08/o iaKewsWJ84ezGaVFxK1IcXTEyrrVUpl5ig/jL2QiIm/6TnRU
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
 drivers/dma/sprd-dma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 168aa0bd73a0..97e3dedb6c12 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -1232,7 +1232,7 @@ static int sprd_dma_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sprd_dma_remove(struct platform_device *pdev)
+static void sprd_dma_remove(struct platform_device *pdev)
 {
 	struct sprd_dma_dev *sdev = platform_get_drvdata(pdev);
 	struct sprd_dma_chn *c, *cn;
@@ -1255,7 +1255,6 @@ static int sprd_dma_remove(struct platform_device *pdev)
 
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	return 0;
 }
 
 static const struct of_device_id sprd_dma_match[] = {
@@ -1292,7 +1291,7 @@ static const struct dev_pm_ops sprd_dma_pm_ops = {
 
 static struct platform_driver sprd_dma_driver = {
 	.probe = sprd_dma_probe,
-	.remove = sprd_dma_remove,
+	.remove_new = sprd_dma_remove,
 	.driver = {
 		.name = "sprd-dma",
 		.of_match_table = sprd_dma_match,
-- 
2.40.1

