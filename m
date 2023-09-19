Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F407A6527
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjISNcr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjISNci (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:38 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8420BFB
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiaq0-0005Je-La; Tue, 19 Sep 2023 15:32:24 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapy-007T5p-9G; Tue, 19 Sep 2023 15:32:22 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapx-0030gi-VF; Tue, 19 Sep 2023 15:32:21 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dmaengine@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 50/59] dma: ti: cppi41: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:58 +0200
Message-Id: <20230919133207.1400430-51-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1895; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=pdZs2mpxrwwB99tDUJ7sIFNa8QSLEn1C5iWYhRjxrt0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHpKt0CrbwXMUQwVwTilGTwdMR/21IDTUNIk HkDtZYQEgGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmh6QAKCRCPgPtYfRL+ TkFLB/970Fiz4twQUtX2WWerpZIMpeB7+uhYXv4+7NOW5h4guR2zbc9MHClox5XWLnOqhQP6db7 hXKqFiWhy1bNc87tZGrR9y/0oryCKzyvWL30Ziz1R1z3CAzrj4AvhSWIWeGkAfJCoi/QnFYjySA xUOjg5UcJDta+WLNf7cqqwHWmysKfqjMPdpAvZzAMsP/zopySQY/7wdOV5eAh3eE3TX8fDyAQJf tzmWM2Oxflbuuk50zgm3DP0PetL0vsLjV4J+FU4B6H3cMIjT+pE/5AjhtmQQ4q5OW8X5nUF0fMS kcTWQloPR0nxziWBQ9naQYWKS+dsqZvSZPcsVpP4awEJ4kam
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
 drivers/dma/ti/cppi41.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ti/cppi41.c b/drivers/dma/ti/cppi41.c
index c3555cfb0681..7e0b06b5dff0 100644
--- a/drivers/dma/ti/cppi41.c
+++ b/drivers/dma/ti/cppi41.c
@@ -1156,7 +1156,7 @@ static int cppi41_dma_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int cppi41_dma_remove(struct platform_device *pdev)
+static void cppi41_dma_remove(struct platform_device *pdev)
 {
 	struct cppi41_dd *cdd = platform_get_drvdata(pdev);
 	int error;
@@ -1173,7 +1173,6 @@ static int cppi41_dma_remove(struct platform_device *pdev)
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	return 0;
 }
 
 static int __maybe_unused cppi41_suspend(struct device *dev)
@@ -1244,7 +1243,7 @@ static const struct dev_pm_ops cppi41_pm_ops = {
 
 static struct platform_driver cpp41_dma_driver = {
 	.probe  = cppi41_dma_probe,
-	.remove = cppi41_dma_remove,
+	.remove_new = cppi41_dma_remove,
 	.driver = {
 		.name = "cppi41-dma-engine",
 		.pm = &cppi41_pm_ops,
-- 
2.40.1

