Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55CF7A6514
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjISNcj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjISNcb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:31 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9A7100
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapw-000567-U0; Tue, 19 Sep 2023 15:32:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapv-007T54-6f; Tue, 19 Sep 2023 15:32:19 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapu-0030fw-U1; Tue, 19 Sep 2023 15:32:18 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Green Wan <green.wan@sifive.com>, dmaengine@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 38/59] dma: sf-pdma: sf-pdma: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:46 +0200
Message-Id: <20230919133207.1400430-39-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1837; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=X9L+fQGB2a2TQpTdPeTCssyhoZqjmVNipmC+ryvry+0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHaDpg6fzmNVZZQ+e+9V2C1r0CidRsamSAoh QpJNX/OCYeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmh2gAKCRCPgPtYfRL+ Tq36B/sFP97CeTpCDrBWqdh/WERADkXEyfHDdLlFQG428zoMLVx/GUhR0DiT0fBBm4+3fXymbzc VmuNQb1/MSwB1VleVAKgABG19VF7yF08NaJXPBEgT/GOS1q4m9Ifq2gCE87n6DLmujmKuOYNqDQ Pe/1MW5kyAiJDlNzUkjJt2N1n6G1Cv1WedF1M+BJRzZZmk6N3gpq5DcSjt4oG50jIRG+JDYzkJB G5hustO3o/QuMgP4f1X2k5M4V25Sj5MXQiGPZCHVRzIzbOfFVbzsWSGg8bcTSQD6kAvnQ3ejLu6 yyf5DFY8t2RRBZ5Bqo7vVW7oLjBOobcTB/jjaJCGpmz4493P
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
 drivers/dma/sf-pdma/sf-pdma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index d1c6956af452..3125a2f162b4 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -566,7 +566,7 @@ static int sf_pdma_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int sf_pdma_remove(struct platform_device *pdev)
+static void sf_pdma_remove(struct platform_device *pdev)
 {
 	struct sf_pdma *pdma = platform_get_drvdata(pdev);
 	struct sf_pdma_chan *ch;
@@ -584,8 +584,6 @@ static int sf_pdma_remove(struct platform_device *pdev)
 	}
 
 	dma_async_device_unregister(&pdma->dma_dev);
-
-	return 0;
 }
 
 static const struct of_device_id sf_pdma_dt_ids[] = {
@@ -597,7 +595,7 @@ MODULE_DEVICE_TABLE(of, sf_pdma_dt_ids);
 
 static struct platform_driver sf_pdma_driver = {
 	.probe		= sf_pdma_probe,
-	.remove		= sf_pdma_remove,
+	.remove_new	= sf_pdma_remove,
 	.driver		= {
 		.name	= "sf-pdma",
 		.of_match_table = sf_pdma_dt_ids,
-- 
2.40.1

