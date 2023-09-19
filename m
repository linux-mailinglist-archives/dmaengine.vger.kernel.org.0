Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895F17A64F2
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjISNcY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbjISNcU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:20 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34121F7
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:15 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapp-0004dW-ME; Tue, 19 Sep 2023 15:32:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapp-007T3M-9U; Tue, 19 Sep 2023 15:32:13 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapp-0030eG-0Q; Tue, 19 Sep 2023 15:32:13 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 12/59] dma: fsl-edma-main: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:20 +0200
Message-Id: <20230919133207.1400430-13-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1924; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=NFWX8bCcjXb/ARf9UEfUoGFyz+gjJU6M2gobqXPAMbs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaG7b3sWZ1o+WV2dpm8pOJQOCNgn7DlUAT8pC IBqgXZ8N/eJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmhuwAKCRCPgPtYfRL+ TsP2CACsyK3ago6Jn9cD8jumV35Zl0PEQWDhXEJ/5BZfhz3GgEMmsfXHLVeICWI582uJRgmUQpp Fd1MgkfjUGGbzEjXmjjj8dT5vpjpoJhGw0DWkVd38D50AYN4OpSZdfsOapx2uTVVSEA/1s0v7SX cePIbHv0eANBDOgerR/S1ec8dtc2V1miok/dyYEN9eaZ4xVHoT6TwOB0SSwfs+ndrAamei6VA3F RzgiP3m2r+N0725D6HRpgnrXmksoLTroAx/7dpVQCK2D6LtI3DRrG+LUpDisvOyqxpPrt/m5bGt Ec70WXNZ2R9uRj+oglgfJ1O5tPUIKco6SMMXW2QVVc8tHmyj
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
 drivers/dma/fsl-edma-main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 63d48d046f04..11da143955b3 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -615,7 +615,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int fsl_edma_remove(struct platform_device *pdev)
+static void fsl_edma_remove(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct fsl_edma_engine *fsl_edma = platform_get_drvdata(pdev);
@@ -625,8 +625,6 @@ static int fsl_edma_remove(struct platform_device *pdev)
 	of_dma_controller_free(np);
 	dma_async_device_unregister(&fsl_edma->dma_dev);
 	fsl_disable_clocks(fsl_edma, fsl_edma->drvdata->dmamuxs);
-
-	return 0;
 }
 
 static int fsl_edma_suspend_late(struct device *dev)
@@ -690,7 +688,7 @@ static struct platform_driver fsl_edma_driver = {
 		.pm     = &fsl_edma_pm_ops,
 	},
 	.probe          = fsl_edma_probe,
-	.remove		= fsl_edma_remove,
+	.remove_new	= fsl_edma_remove,
 };
 
 static int __init fsl_edma_init(void)
-- 
2.40.1

