Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D5F7A6526
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbjISNcr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbjISNci (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:38 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2060130
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapy-0005ED-K6; Tue, 19 Sep 2023 15:32:22 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapw-007T5R-NT; Tue, 19 Sep 2023 15:32:20 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapw-0030gO-CT; Tue, 19 Sep 2023 15:32:20 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, kernel@pengutronix.de
Subject: [PATCH 45/59] dma: sun4i-dma: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:53 +0200
Message-Id: <20230919133207.1400430-46-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1845; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=tdSrGzB1P3A08YWfYfl02UYCIKs62cLV6Iz/r1JsvCM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHjPLjFYT4hC+C8a2gKPED1g0kPoR7jQSlDn C5y+NPpRrOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmh4wAKCRCPgPtYfRL+ TqZTCACwmoBJYTuOpE6rMjAY39Ol/EbQog2Gh/wBph6y0oQyt36ciOIOj0RPhqFlyo8j6T1mrYW zM0qHB1G9T1LmWvznb3w/OICbBw+mppPwSGUtt4AQ9YRkx2bGTMrrZJpaZYT4L0dI3Lv0powSBL E46buKhMdIcoglCp8wlzNZQ+hoq8vJLnUtiPtGiAv0bHHgYC2q1DbMSKGZUP6wxFoN411D0iKCc aXFXq/u2OCqdhDBZwFn/YpsgVA/47G7BvbIApMtaKsHJ+v2yDmBtHw/DdOYuZKFs1qar4A4IAIm oCIlR7MuVp1h4LEAwTI45p0iZI0PCsB1uB3YSBERALs4iLDc
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
 drivers/dma/sun4i-dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index e86c8829513a..2e7f9b07fdd2 100644
--- a/drivers/dma/sun4i-dma.c
+++ b/drivers/dma/sun4i-dma.c
@@ -1271,7 +1271,7 @@ static int sun4i_dma_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sun4i_dma_remove(struct platform_device *pdev)
+static void sun4i_dma_remove(struct platform_device *pdev)
 {
 	struct sun4i_dma_dev *priv = platform_get_drvdata(pdev);
 
@@ -1282,8 +1282,6 @@ static int sun4i_dma_remove(struct platform_device *pdev)
 	dma_async_device_unregister(&priv->slave);
 
 	clk_disable_unprepare(priv->clk);
-
-	return 0;
 }
 
 static const struct of_device_id sun4i_dma_match[] = {
@@ -1294,7 +1292,7 @@ MODULE_DEVICE_TABLE(of, sun4i_dma_match);
 
 static struct platform_driver sun4i_dma_driver = {
 	.probe	= sun4i_dma_probe,
-	.remove	= sun4i_dma_remove,
+	.remove_new = sun4i_dma_remove,
 	.driver	= {
 		.name		= "sun4i-dma",
 		.of_match_table	= sun4i_dma_match,
-- 
2.40.1

