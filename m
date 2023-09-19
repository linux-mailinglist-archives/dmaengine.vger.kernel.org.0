Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0A87A64F9
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjISNc0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbjISNcY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:24 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1DB100
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapr-0004ic-2O; Tue, 19 Sep 2023 15:32:15 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapq-007T3j-9j; Tue, 19 Sep 2023 15:32:14 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapq-0030eZ-0l; Tue, 19 Sep 2023 15:32:14 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 17/59] dma: img-mdc-dma: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:25 +0200
Message-Id: <20230919133207.1400430-18-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1854; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=cTzWD784bno/dGHDEoHhhnkeX/LMdfIgHp/VjsyUXHw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHBQSmAoQRS/RFOYaqoUGY8cC6vhXCOhhHLH efBxXonjHqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmhwQAKCRCPgPtYfRL+ TgTSB/90BZ+VHh3qshqev3qyVZBu3eKmfV+LpY+i1mgseroOPx3srl+rY3irno9T5P7RBUhT5rN 8el1ipKDZjkeYy/zFphcSYCey9SJiNaV8vfd2C4VYFo7c5ntmfvVB9sBRP6AK5xEOU2q2yJDOIp xn2kqjFRi6hEG5cjvH2KlG+4tO/6ee9sl172jFqVtW3r4piU1I9ZVXsT5F2Ur+5Th0V1uUFKVi4 pRLR5y0xMq/d4l+XUhrFGzMXWl8Uz8rIxiD4p/iJC9VRUvSzG3UlOgAfyIMcAtbCJtSAD+hMuCn CwNl+rR+bIzzSzTZJq8rIl63WIVCrvKXY2/mYwBL7HiXqYHr
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
 drivers/dma/img-mdc-dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/img-mdc-dma.c b/drivers/dma/img-mdc-dma.c
index 9be0d3226e19..0532dd2640dc 100644
--- a/drivers/dma/img-mdc-dma.c
+++ b/drivers/dma/img-mdc-dma.c
@@ -1017,7 +1017,7 @@ static int mdc_dma_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mdc_dma_remove(struct platform_device *pdev)
+static void mdc_dma_remove(struct platform_device *pdev)
 {
 	struct mdc_dma *mdma = platform_get_drvdata(pdev);
 	struct mdc_chan *mchan, *next;
@@ -1037,8 +1037,6 @@ static int mdc_dma_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		img_mdc_runtime_suspend(&pdev->dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1078,7 +1076,7 @@ static struct platform_driver mdc_dma_driver = {
 		.of_match_table = of_match_ptr(mdc_dma_of_match),
 	},
 	.probe = mdc_dma_probe,
-	.remove = mdc_dma_remove,
+	.remove_new = mdc_dma_remove,
 };
 module_platform_driver(mdc_dma_driver);
 
-- 
2.40.1

