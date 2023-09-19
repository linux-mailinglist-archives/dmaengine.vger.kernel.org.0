Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021E97A6516
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbjISNck (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjISNcd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:33 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13311100
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapx-000575-2D; Tue, 19 Sep 2023 15:32:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapv-007T57-D6; Tue, 19 Sep 2023 15:32:19 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapv-0030g0-3v; Tue, 19 Sep 2023 15:32:19 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        dmaengine@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 39/59] dma: sh: rcar-dmac: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:47 +0200
Message-Id: <20230919133207.1400430-40-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1825; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=czlgMS1A0e/2ND5H4loot1SC9OAsE3RXu9tC94tqfjA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHbWY5QJDz9MGEdNcceIKTjoAFtvwOpLsCqL vENncm5svqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmh2wAKCRCPgPtYfRL+ TmIvB/4qniJw6K+tq2+/Fi2t1Pvq70yq5L37MMWvFsKKX0nMIUgF9zXFoEGxTShdciNwqhmjD/y NI+7mfEbMky/bJQkVUqyCzXRSLSTc1Ssc/vqzzY2+CFULYquKImQ0xlKCuBY1YR20B9lO+j+7+W rN3w2bCjnaYTcNmNX39mmE8P43/47HiZeMnpS6dGEfV2hV2JbuILR23SwR4gfyJLfqKhEGv+Cdl bryQkVj4lwKzBLo6KglzgJtIvBcCeLF0WUI5OKPd2+qKfubY2s61vnOSRSesFWBqBPzgFFtWBnh OG0MSJB25xmQqrd5RkM9TLVdP+4Cg5MJ6CDQv+nw6w9wLi4F
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
 drivers/dma/sh/rcar-dmac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 641d689d17ff..40482cb73d79 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1990,7 +1990,7 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int rcar_dmac_remove(struct platform_device *pdev)
+static void rcar_dmac_remove(struct platform_device *pdev)
 {
 	struct rcar_dmac *dmac = platform_get_drvdata(pdev);
 
@@ -1998,8 +1998,6 @@ static int rcar_dmac_remove(struct platform_device *pdev)
 	dma_async_device_unregister(&dmac->engine);
 
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 static void rcar_dmac_shutdown(struct platform_device *pdev)
@@ -2041,7 +2039,7 @@ static struct platform_driver rcar_dmac_driver = {
 		.of_match_table = rcar_dmac_of_ids,
 	},
 	.probe		= rcar_dmac_probe,
-	.remove		= rcar_dmac_remove,
+	.remove_new	= rcar_dmac_remove,
 	.shutdown	= rcar_dmac_shutdown,
 };
 
-- 
2.40.1

