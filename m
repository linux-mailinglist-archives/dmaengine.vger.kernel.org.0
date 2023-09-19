Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C73F7A6534
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjISNcx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbjISNcn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:43 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55EC119
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:35 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiaq1-0005Rt-Pr; Tue, 19 Sep 2023 15:32:25 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapz-007T6D-US; Tue, 19 Sep 2023 15:32:23 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapz-0030hA-J8; Tue, 19 Sep 2023 15:32:23 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Michal Simek <michal.simek@amd.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh@kernel.org>,
        Peter Korsgaard <peter@korsgaard.com>,
        Liu Shixin <liushixin2@huawei.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 57/59] dma: xilinx: xilinx_dma: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:32:05 +0200
Message-Id: <20230919133207.1400430-58-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1882; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=+IqQuGKfVTT93P0XcefOle75AuguAFhVRpoxwH+tLuY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHxVzfReXnnvh7loBbNqpVj6ktFIXWifBFCD G2/VQlf++aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmh8QAKCRCPgPtYfRL+ ThlAB/9730LxScHBJwwcOaR1jnm0uFBe6jxULaX7ZbEgOyn/u9++XUE3Kq/3dvGXEbegv7B704l UJzLJijb25mmBJzw8sz4w7vOI0PxMMj1aObKN6qRytSxxbg1iRI+RneL4DizlfEwttwd5V6mGLt gcCzAFisvlIvUBwuDMKnQAFikWn/Q84BIYwfOux51WOmGrTCDvvt1D55UM7+yMJb04CzkdNBZRP dbbAVXKgwKIKJk2nIBrlJkNlHzauIjQgDz+oEhzqonCap4KTAo+PyHrKr45NRbIVY3O2djbDrqZ 2lN0XzR3JCwtl5W5pXzoc/1GTSIf1QU732PNOVBFlKOtaUuF
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
 drivers/dma/xilinx/xilinx_dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 0a3b2e22f23d..0c363a1ed853 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -3245,7 +3245,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
  *
  * Return: Always '0'
  */
-static int xilinx_dma_remove(struct platform_device *pdev)
+static void xilinx_dma_remove(struct platform_device *pdev)
 {
 	struct xilinx_dma_device *xdev = platform_get_drvdata(pdev);
 	int i;
@@ -3259,8 +3259,6 @@ static int xilinx_dma_remove(struct platform_device *pdev)
 			xilinx_dma_chan_remove(xdev->chan[i]);
 
 	xdma_disable_allclks(xdev);
-
-	return 0;
 }
 
 static struct platform_driver xilinx_vdma_driver = {
@@ -3269,7 +3267,7 @@ static struct platform_driver xilinx_vdma_driver = {
 		.of_match_table = xilinx_dma_of_ids,
 	},
 	.probe = xilinx_dma_probe,
-	.remove = xilinx_dma_remove,
+	.remove_new = xilinx_dma_remove,
 };
 
 module_platform_driver(xilinx_vdma_driver);
-- 
2.40.1

