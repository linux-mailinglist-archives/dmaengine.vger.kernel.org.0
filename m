Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561387A650E
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjISNch (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjISNca (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:30 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1ECF3
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapr-0004jd-I4; Tue, 19 Sep 2023 15:32:15 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapq-007T3r-SY; Tue, 19 Sep 2023 15:32:14 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapq-0030ei-JD; Tue, 19 Sep 2023 15:32:14 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 19/59] dma: imx-sdma: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:27 +0200
Message-Id: <20230919133207.1400430-20-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1699; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=hneMaQhy4moY5StDkH7l6uC8+I3TNb891DRslxYBUjA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHEH6xKY8NvJQR0M7d5tMp1WDfiRw7/hGO4J kN02Tr08oeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmhxAAKCRCPgPtYfRL+ TrLdCAC5OfTTfvkvZxYmEgg5IqvV2FbSOuCsVYrE281z1s3lNwuWRAUzCSbqrmRpIxG1Z/uGE6y MolzVBZzfdfor2ibiMA01l0K2HML3UeFSgi5kYPUc0Dx6ZBGAHeL7SKUStDhEDvCYlwMthf3kQI 3QYUXcWGsUtHCx+9RS9IeG7ESn/+s2gVnHMTaj3kzsNCR+Go4BQJKN/gfGatTHn5zs6EX7t7Rci jBxP2GL9doIDHfLNb2dApU4M66d3R3AF2vQAQ4Jdg52T36RK7eJqNVsfGadWCnj8wNHd96+OwCi 1qiYQJVte5bD783lq+4Z0o+ssjO8sq8BoQXubNZaq8BiPtII
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
 drivers/dma/imx-sdma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 51012bd39900..f81ecf5863e8 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2358,7 +2358,7 @@ static int sdma_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sdma_remove(struct platform_device *pdev)
+static void sdma_remove(struct platform_device *pdev)
 {
 	struct sdma_engine *sdma = platform_get_drvdata(pdev);
 	int i;
@@ -2377,7 +2377,6 @@ static int sdma_remove(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, NULL);
-	return 0;
 }
 
 static struct platform_driver sdma_driver = {
@@ -2385,7 +2384,7 @@ static struct platform_driver sdma_driver = {
 		.name	= "imx-sdma",
 		.of_match_table = sdma_dt_ids,
 	},
-	.remove		= sdma_remove,
+	.remove_new	= sdma_remove,
 	.probe		= sdma_probe,
 };
 
-- 
2.40.1

