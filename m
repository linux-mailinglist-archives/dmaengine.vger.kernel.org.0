Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32A27A651E
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbjISNcn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjISNcg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:36 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C936B128
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiaq0-0005Nh-NL; Tue, 19 Sep 2023 15:32:24 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapy-007T60-V0; Tue, 19 Sep 2023 15:32:22 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapy-0030gt-L9; Tue, 19 Sep 2023 15:32:22 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 53/59] dma: timb_dma: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:32:01 +0200
Message-Id: <20230919133207.1400430-54-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1782; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=R7UQG3BNS22hG5Ey3S6ZDo6icHMCN8EqOM1kWJ7zMkw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHs4CiIuv9ZqZt8rYtEbRtxCvMXP5cwpv6Vd k/GobpTPw+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmh7AAKCRCPgPtYfRL+ TotECACnj3m1yRyQz5++1wbOzWklDFdA4AbUia5kf832I6w6oTJTtiOBU+xlJLzv43EwZcaFRU/ 7gpEyb628HQ+c/JHAmRLSEyb64RsnpsvUAgjpzY/b0mFE8hLTE6R86uVBJ2cE2iqEqnTFp5TPGQ pdmWP4u4ePKBcNgM4mPIOJQ4VVZ/jjmox7LRX454NLw4G5iihhyA+uOj8XB5hwDFCt0qLNOBKT9 nLP2Q4Si09Zo6P6Tnlbm8bHPUq7bUSBClsgqKizP92sqc0EPzShrSeLceoCrr16PZs1gkohs2cP CYa/KUxbMcMGr8AafClfjfFe8qpCjoitEoU2Fo363xIqUkYQ
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
 drivers/dma/timb_dma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/timb_dma.c b/drivers/dma/timb_dma.c
index 3f524be69efb..7410025605e0 100644
--- a/drivers/dma/timb_dma.c
+++ b/drivers/dma/timb_dma.c
@@ -740,7 +740,7 @@ static int td_probe(struct platform_device *pdev)
 
 }
 
-static int td_remove(struct platform_device *pdev)
+static void td_remove(struct platform_device *pdev)
 {
 	struct timb_dma *td = platform_get_drvdata(pdev);
 	struct resource *iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -754,7 +754,6 @@ static int td_remove(struct platform_device *pdev)
 	release_mem_region(iomem->start, resource_size(iomem));
 
 	dev_dbg(&pdev->dev, "Removed...\n");
-	return 0;
 }
 
 static struct platform_driver td_driver = {
@@ -762,7 +761,7 @@ static struct platform_driver td_driver = {
 		.name	= DRIVER_NAME,
 	},
 	.probe	= td_probe,
-	.remove	= td_remove,
+	.remove_new = td_remove,
 };
 
 module_platform_driver(td_driver);
-- 
2.40.1

