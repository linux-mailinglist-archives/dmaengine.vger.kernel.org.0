Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCD87A64FE
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjISNca (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjISNcY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:24 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248E9125
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiaps-0004nD-Hu; Tue, 19 Sep 2023 15:32:16 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiaps-007T4F-48; Tue, 19 Sep 2023 15:32:16 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapr-0030f6-RL; Tue, 19 Sep 2023 15:32:15 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 25/59] dma: mmp_pdma: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:33 +0200
Message-Id: <20230919133207.1400430-26-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1789; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=SSPLBYKR5cuYX0AgQzE9mTTs9THe3pRG3xWwJV/oUfw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHLXG2NhgkDDb+3mmTEhDMq40mbmn6yCzbDK oz6b6lgZnyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmhywAKCRCPgPtYfRL+ TlNWCACuqjlFFSX//qi+TgUrnmzlOfCWRvlZkaiuVi0uxeDADxxMdj+d/PX74UwJpbD+81yDJC8 cy8IqutEd0R77eloXfxwPzITVgEA7U3tWz6AMlonl1TQRrXnt1TOhhN1KeDfx1LT1cimK8VyTU6 JFmLTD6fpXuD9UN0BjH4EzPs2y3yRyh/pxfkf/p1gQh8TiNHip+lC4fOsAawmGsIGP3UDEcf1UL tLl6fW9TVDhPCH2nifNnx2/JZe2n09oAi1yriCgS/DH3x8LYTWw+GTV0aaKb+MjlAGgJ5OrqGNe agkVKXaaEzHYL5JdRvFY0tP20ZL48EdUQpnAMTiKFONpejRP
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
 drivers/dma/mmp_pdma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index ebdfdcbb4f7a..492ec491a59b 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -932,7 +932,7 @@ static void dma_do_tasklet(struct tasklet_struct *t)
 	}
 }
 
-static int mmp_pdma_remove(struct platform_device *op)
+static void mmp_pdma_remove(struct platform_device *op)
 {
 	struct mmp_pdma_device *pdev = platform_get_drvdata(op);
 	struct mmp_pdma_phy *phy;
@@ -958,7 +958,6 @@ static int mmp_pdma_remove(struct platform_device *op)
 	}
 
 	dma_async_device_unregister(&pdev->device);
-	return 0;
 }
 
 static int mmp_pdma_chan_init(struct mmp_pdma_device *pdev, int idx, int irq)
@@ -1141,7 +1140,7 @@ static struct platform_driver mmp_pdma_driver = {
 	},
 	.id_table	= mmp_pdma_id_table,
 	.probe		= mmp_pdma_probe,
-	.remove		= mmp_pdma_remove,
+	.remove_new	= mmp_pdma_remove,
 };
 
 module_platform_driver(mmp_pdma_driver);
-- 
2.40.1

