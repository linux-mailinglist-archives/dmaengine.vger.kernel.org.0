Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9212E7A64FF
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjISNca (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjISNcY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:24 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE6F129
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiaps-0004oz-PD; Tue, 19 Sep 2023 15:32:16 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiaps-007T4K-Cl; Tue, 19 Sep 2023 15:32:16 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiaps-0030fA-3e; Tue, 19 Sep 2023 15:32:16 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 26/59] dma: mmp_tdma: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:34 +0200
Message-Id: <20230919133207.1400430-27-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1664; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ExUgVQjU60Xy+Ix6S4j8D/SL67FKgT+QoqD6fJZAkwE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHMjNvWiAft8ma3jLXizifVX97cabSOLI6Oi PDTr+c+cimJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmhzAAKCRCPgPtYfRL+ TlX5CACZmaKXv316VWtuLa5/kLAjzkKBZG74v+IFi157XkYIkaIJit2QC6Raq9bSGnHMaFoF1sG 8SYzDmsytug4eTlmDNMQkOQvieClsZ0LQVKs8Q1cfvvwlWg5fSRQaOjZjkN6nVUVMJrJUPeIPeR GQZyepjRjRyn7KS3GcwYD4qNdT/pjTGhbHte+bhVXa2r5S7JYLRGgNhCQZpJGuCg+loI8CMSDq6 4sdAdNMbv3WDBlomHxzoSMdfvTKdHqKAdL6TNn8ySkvAalNxto0//FILMPIFq1OFwGNaYmtN6lI hNdYQ3kzaKnyHhThQY+VCZGFmVrrY3jwKKFgbVR/pbSxSoj1
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
 drivers/dma/mmp_tdma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index d49fa6bc6775..f039e07181f7 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -552,12 +552,10 @@ static void mmp_tdma_issue_pending(struct dma_chan *chan)
 	mmp_tdma_enable_chan(tdmac);
 }
 
-static int mmp_tdma_remove(struct platform_device *pdev)
+static void mmp_tdma_remove(struct platform_device *pdev)
 {
 	if (pdev->dev.of_node)
 		of_dma_controller_free(pdev->dev.of_node);
-
-	return 0;
 }
 
 static int mmp_tdma_chan_init(struct mmp_tdma_device *tdev,
@@ -753,7 +751,7 @@ static struct platform_driver mmp_tdma_driver = {
 	},
 	.id_table	= mmp_tdma_id_table,
 	.probe		= mmp_tdma_probe,
-	.remove		= mmp_tdma_remove,
+	.remove_new	= mmp_tdma_remove,
 };
 
 module_platform_driver(mmp_tdma_driver);
-- 
2.40.1

