Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC907A64FC
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbjISNc2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjISNcY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:24 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E208C122
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapp-0004cj-Gq; Tue, 19 Sep 2023 15:32:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapn-007T2z-RG; Tue, 19 Sep 2023 15:32:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapn-0030dr-HE; Tue, 19 Sep 2023 15:32:11 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        dmaengine@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 06/59] dma: bcm2835-dma: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:14 +0200
Message-Id: <20230919133207.1400430-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1665; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=4k20QsNbWrgBeaCXZrLrt7KARFXxwozszE9LgnxhIaQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaG0hdzcw3DIm2QlhWlA1IzMMfFAr9NM9T9aB Yz/OExIiA+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmhtAAKCRCPgPtYfRL+ ToWYB/9HmrM6dlw0qAvWMCblKNhkYH5qMME6/xAXVQopaV7LJbwobtK9kWJkKpq2qIgPWJGmZSM W6YpTkPYN6eST3GodfEX/KnNbqYHG/P+GdSEE2SeQHEuoGZmbCfVQ6FfNcypUkv7kAPLzPg7Ali JAStmfjX8J333Ig62Be8IquQIQnTTLMIF6QrZU/f8GxMlr46nR8J7GTl9m7aVfVKGIvauQDnrpN C3qr9Xjcx6qpaGMz/uYcTLHYdzbpxH+xlRslCQz6q9FtBy3T266j2sQH+SIO3tmzRGN9mwrnCfr aFdz8GRm2s2NdXuGiBWRUkrG4WRh/O5+75KIjLAPgpIBetg2
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
 drivers/dma/bcm2835-dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 0807fb9eb262..9d74fe97452e 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -1019,19 +1019,17 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 	return rc;
 }
 
-static int bcm2835_dma_remove(struct platform_device *pdev)
+static void bcm2835_dma_remove(struct platform_device *pdev)
 {
 	struct bcm2835_dmadev *od = platform_get_drvdata(pdev);
 
 	dma_async_device_unregister(&od->ddev);
 	bcm2835_dma_free(od);
-
-	return 0;
 }
 
 static struct platform_driver bcm2835_dma_driver = {
 	.probe	= bcm2835_dma_probe,
-	.remove	= bcm2835_dma_remove,
+	.remove_new = bcm2835_dma_remove,
 	.driver = {
 		.name = "bcm2835-dma",
 		.of_match_table = of_match_ptr(bcm2835_dma_of_match),
-- 
2.40.1

