Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199B37A6523
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjISNcp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbjISNch (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:37 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3E212F
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiaq0-0005LP-Mk; Tue, 19 Sep 2023 15:32:24 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapy-007T5s-Ij; Tue, 19 Sep 2023 15:32:22 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapy-0030gm-7s; Tue, 19 Sep 2023 15:32:22 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        dmaengine@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 51/59] dma: ti: edma: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:59 +0200
Message-Id: <20230919133207.1400430-52-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1778; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=WoPPd5nbPfOkJMaisGu9C32+CD+ZpnjuG2i0AtsUo5k=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlTOha9O/FbenTlxT2VtBM8Lb34xzjb+9QkVrveCDd5/C 4wXN+vqZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAi/qXs/6Puro4oWHrjQaWi YS/HjF0S3O8d+fgl2xlXGbNlna7+rupTeIQlZk2V+bLSQr7sU2xZPqcV2/eWvfy9eYveOnnFJ4Y eV4zOy9mm3szkZN9lHsbIYJtvPcWsz3FN0+ejRz93RnQ9Dkyfm/pzXtOi33OOuF7+37IpIly6qP d7yqLi99lbLyzMdNv/0FCAv6D+xM4VtxIPLni69JJhXKUxu4Sjc7oQ68Pqpr8cE+fMmPnmDU/Pt XeBTI/+KFSeuLlltsiOiXKVadwT43sCchSspi99ueviPWc5yf9Pwqu/hf9RE/XT3sZQ6XRvxZen 17KbvhgIrAz+w5vkyOZ9J9kileWHeEyUm4rqesvJorFeAA==
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
 drivers/dma/ti/edma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index aa8e2e8ac260..3ed022918ec0 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2550,7 +2550,7 @@ static void edma_cleanupp_vchan(struct dma_device *dmadev)
 	}
 }
 
-static int edma_remove(struct platform_device *pdev)
+static void edma_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct edma_cc *ecc = dev_get_drvdata(dev);
@@ -2568,8 +2568,6 @@ static int edma_remove(struct platform_device *pdev)
 	edma_free_slot(ecc, ecc->dummy_slot);
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -2628,7 +2626,7 @@ static const struct dev_pm_ops edma_pm_ops = {
 
 static struct platform_driver edma_driver = {
 	.probe		= edma_probe,
-	.remove		= edma_remove,
+	.remove_new	= edma_remove,
 	.driver = {
 		.name	= "edma",
 		.pm	= &edma_pm_ops,
-- 
2.40.1

