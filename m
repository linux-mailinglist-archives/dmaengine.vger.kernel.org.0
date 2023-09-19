Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0607A64FB
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjISNc1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjISNcY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:24 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E99A114
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapr-0004l8-SX; Tue, 19 Sep 2023 15:32:15 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapr-007T3z-Bf; Tue, 19 Sep 2023 15:32:15 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapq-0030ep-Vu; Tue, 19 Sep 2023 15:32:15 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 21/59] dma: mcf-edma-main: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:29 +0200
Message-Id: <20230919133207.1400430-22-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1800; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=x7UfmXVGm7Okn+cBzQEEASwC552geO68PJM2twF1NLs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHGU+hiiIWkjwPhSqFwxR0TfULYwb2C2z5Ti PPJE+XUXkmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmhxgAKCRCPgPtYfRL+ Tq1ZB/9lbH50D/1zYLMVvEB2pXSo8UYaxZXene+0VcBLY18z4liHy53qosbQCJlHNwXyWss/iMB 3yn2eMrcHMZhhl9mzlleAxvi0UUUjgFkX3QGtO4Yt6W0MFFIFeBz8eMa7NxdXb8p3i0NHo/s5Lp b+mRRh7+7eK/kgwSehgdX+iw/494NlrJ1fS+fytWtyeTbC4wEXNBeg0JiP17P0DcpzWW6ebNj+s Lhz14ctgtKPBhvRs7J6POG4Y3uEmbX/smxryy3IrxCrfkvH2sOAEBzr9AhEpNNSuayYh1tVZsnS 1E0kOGigCV82+wakpI/B3Rm7SqHKlKy9+yrA+Ibx4NoHaDWV
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
 drivers/dma/mcf-edma-main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
index b359421ee9ea..ab21455d9c3a 100644
--- a/drivers/dma/mcf-edma-main.c
+++ b/drivers/dma/mcf-edma-main.c
@@ -255,15 +255,13 @@ static int mcf_edma_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int mcf_edma_remove(struct platform_device *pdev)
+static void mcf_edma_remove(struct platform_device *pdev)
 {
 	struct fsl_edma_engine *mcf_edma = platform_get_drvdata(pdev);
 
 	mcf_edma_irq_free(pdev, mcf_edma);
 	fsl_edma_cleanup_vchan(&mcf_edma->dma_dev);
 	dma_async_device_unregister(&mcf_edma->dma_dev);
-
-	return 0;
 }
 
 static struct platform_driver mcf_edma_driver = {
@@ -271,7 +269,7 @@ static struct platform_driver mcf_edma_driver = {
 		.name	= "mcf-edma",
 	},
 	.probe		= mcf_edma_probe,
-	.remove		= mcf_edma_remove,
+	.remove_new	= mcf_edma_remove,
 };
 
 bool mcf_edma_filter_fn(struct dma_chan *chan, void *param)
-- 
2.40.1

