Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30227A6504
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjISNcd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjISNcZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:25 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547FA134
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapt-0004s7-IN; Tue, 19 Sep 2023 15:32:17 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapt-007T4W-3T; Tue, 19 Sep 2023 15:32:17 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiaps-0030fM-Mm; Tue, 19 Sep 2023 15:32:16 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 29/59] dma: mv_xor_v2: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:37 +0200
Message-Id: <20230919133207.1400430-30-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1845; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Lir/2pWM6pJT+COkVu4De9PMrWTrkno4TIttFZrPsXc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHQ09/PAXDnFt1i0Ucup2gZnzsSx1jn3apFv CFV80uk3CeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmh0AAKCRCPgPtYfRL+ TiH/B/9GoTZ2m3UFK2B4iWL+3ij5CID2pa3WutdiKrF+NrPYBHVl8hjUSxjW2SlH50xRwX3Bn12 ACj/rgCGAFKHBouJ+W8DAM8J6BnGuN5RlA1U62Hfqnm0mfdiWAfYsYZEFbFXQJ3m5z2cq+TdMDi YDBA6f415lZ7Zmr++uo5qmX3fiXw2GfUHziOnRrT049I5+eWzOVke6h8sUPVtLIz9iucPlbFz/X 8LAYKmIBUgrqznCdovfEtt3t7pu24A9rPm3Ml2qLwPfmypJV3+LhLM9OFsUH80HEEf9X3kP0JKJ QDwnk2BcRneYXOhCnEsa2idmDIoOR0O1ekO8Wt/lwD6lhuXY
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
 drivers/dma/mv_xor_v2.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index 0e1e9ca1c005..1ebfbe88e733 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -855,7 +855,7 @@ static int mv_xor_v2_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mv_xor_v2_remove(struct platform_device *pdev)
+static void mv_xor_v2_remove(struct platform_device *pdev)
 {
 	struct mv_xor_v2_device *xor_dev = platform_get_drvdata(pdev);
 
@@ -870,8 +870,6 @@ static int mv_xor_v2_remove(struct platform_device *pdev)
 	platform_msi_domain_free_irqs(&pdev->dev);
 
 	tasklet_kill(&xor_dev->irq_tasklet);
-
-	return 0;
 }
 
 #ifdef CONFIG_OF
@@ -886,7 +884,7 @@ static struct platform_driver mv_xor_v2_driver = {
 	.probe		= mv_xor_v2_probe,
 	.suspend	= mv_xor_v2_suspend,
 	.resume		= mv_xor_v2_resume,
-	.remove		= mv_xor_v2_remove,
+	.remove_new	= mv_xor_v2_remove,
 	.driver		= {
 		.name	= "mv_xor_v2",
 		.of_match_table = of_match_ptr(mv_xor_v2_dt_ids),
-- 
2.40.1

