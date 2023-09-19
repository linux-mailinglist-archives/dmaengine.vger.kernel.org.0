Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5F57A6511
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjISNci (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjISNca (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:30 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C101F7
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapu-0004vU-EJ; Tue, 19 Sep 2023 15:32:18 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapt-007T4f-OT; Tue, 19 Sep 2023 15:32:17 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapt-0030fU-Aj; Tue, 19 Sep 2023 15:32:17 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 31/59] dma: owl-dma: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:39 +0200
Message-Id: <20230919133207.1400430-32-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1684; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=oOZXmk+cA7NyUUQsE5sqJFm+83NftNjhIquYm4zw3ns=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlTOhZdE/hwvv2pv2n7SS8ez9kyTdYDhgzn9bvJ55yV4s /qFQ7I6GY1ZGBi5GGTFFFnsG9dkWlXJRXau/XcZZhArE8gUBi5OAZhIdzL7f7eGGtEaj3xxXTMe V8E95/ZrZJZaH7zK4V9/2Klx5fq2PRG2p776FU6anqg3v1O2Q1aM7ZG3aLRAb6d9l8yzpyZ7Jxr NX1r6x8P+iMcl4wkyTuLcmXoPl60TOif0/YOzbcnkx/s/zfZxuZA9dX+aycH5z59O/3Qh+pmGTl dsRa512bxrDG1qQkwsvGGWz8sqfs+oyH5oEvNvlVsYL0fKy5UKzvrBLBInbm48XhBwxlRJgj8vk 0GdIVO/V+ruqvBuw+c3XpXl3Fohv/Mdl3xuT/b3nBmbI20Tk/s8Jm+vVnQ1ZMx/2RR2eHN10O8J XY79GSZ5nL/MtAubuy/ph5nu+LD5yIXUN3oNqmXTnwIA
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
 drivers/dma/owl-dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
index 384476757c5e..4e76c4ec2d39 100644
--- a/drivers/dma/owl-dma.c
+++ b/drivers/dma/owl-dma.c
@@ -1231,7 +1231,7 @@ static int owl_dma_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int owl_dma_remove(struct platform_device *pdev)
+static void owl_dma_remove(struct platform_device *pdev)
 {
 	struct owl_dma *od = platform_get_drvdata(pdev);
 
@@ -1248,13 +1248,11 @@ static int owl_dma_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(od->clk);
 	dma_pool_destroy(od->lli_pool);
-
-	return 0;
 }
 
 static struct platform_driver owl_dma_driver = {
 	.probe	= owl_dma_probe,
-	.remove	= owl_dma_remove,
+	.remove_new = owl_dma_remove,
 	.driver = {
 		.name = "dma-owl",
 		.of_match_table = of_match_ptr(owl_dma_match),
-- 
2.40.1

