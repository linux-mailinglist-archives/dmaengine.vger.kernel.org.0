Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A188F7A6518
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjISNcl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjISNce (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:34 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D285B119
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapx-0005AZ-Qf; Tue, 19 Sep 2023 15:32:22 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapw-007T5G-0n; Tue, 19 Sep 2023 15:32:20 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapv-0030gC-Na; Tue, 19 Sep 2023 15:32:19 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dmaengine@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 42/59] dma: sh: usb-dmac: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:50 +0200
Message-Id: <20230919133207.1400430-43-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1842; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=a0thsDxu14TpYtSb5s2ZnW0vRGKQHvIIJBxsuxeu4II=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHfmuPZ2M3K6tkJKOUqSy8cY8xz0lbU6XVRm RJhGTb0Cx6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmh3wAKCRCPgPtYfRL+ TkVwB/9sv9soRVOoJoK5CSfOQ8oEXLaOI0ZvAj7xxm5u5I0qL0sj9WjEJrFnWjYTFa1W1HJqkgL z1fWc35qFxAnNqtdGSzW2xtVGY9icTJzkYyp6abenhyhfLX/H+os3+q5K+RNx/rKMjlcbzPfvJQ zMBceE356kyaz19H9oO45GgC1jwDbS/uVlyEVp4AfWPajqsPCXlPKlNypyQ4Jm1z6UHhP6D088C LJyfdWYkKLMsfUkC4dP5CxRCenR3kJD8uNeypYQL57+2HRhZIjO1YncFjz8rYCAgddfjKT38eSv CjCLJZkHj/aMNlFRtrxtd5iiIVrrQjaq/Yqy0Dp8JRs+w+7c
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
 drivers/dma/sh/usb-dmac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
index b14cf350b669..d8c93faa424d 100644
--- a/drivers/dma/sh/usb-dmac.c
+++ b/drivers/dma/sh/usb-dmac.c
@@ -866,7 +866,7 @@ static void usb_dmac_chan_remove(struct usb_dmac *dmac,
 	devm_free_irq(dmac->dev, uchan->irq, uchan);
 }
 
-static int usb_dmac_remove(struct platform_device *pdev)
+static void usb_dmac_remove(struct platform_device *pdev)
 {
 	struct usb_dmac *dmac = platform_get_drvdata(pdev);
 	int i;
@@ -877,8 +877,6 @@ static int usb_dmac_remove(struct platform_device *pdev)
 	dma_async_device_unregister(&dmac->engine);
 
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 static void usb_dmac_shutdown(struct platform_device *pdev)
@@ -901,7 +899,7 @@ static struct platform_driver usb_dmac_driver = {
 		.of_match_table = usb_dmac_of_ids,
 	},
 	.probe		= usb_dmac_probe,
-	.remove		= usb_dmac_remove,
+	.remove_new	= usb_dmac_remove,
 	.shutdown	= usb_dmac_shutdown,
 };
 
-- 
2.40.1

