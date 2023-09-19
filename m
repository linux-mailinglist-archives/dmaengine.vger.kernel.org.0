Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622957A650B
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjISNcg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjISNc3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:29 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A769B102
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:22 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapp-0004ak-Gn; Tue, 19 Sep 2023 15:32:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapn-007T2t-E0; Tue, 19 Sep 2023 15:32:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapn-0030dj-2p; Tue, 19 Sep 2023 15:32:11 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 04/59] dma: at_xdmac: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:12 +0200
Message-Id: <20230919133207.1400430-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1900; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=WMzT7MswzvnTnNQOYTkT6sMXTETtgMo9PRS2WDhQTdU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaGyMEkEmehbVVOkcMXJyDWd+VI8gADH6biST 8p5vxRaaj6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmhsgAKCRCPgPtYfRL+ TrQQCAChmZSScdH6iX6VRwkgK0dXNKREkxTTC96G72lMFyYM5KOQ4EGH6JDVGVl5ddjcz07d+A/ sjN8oN7oXWOKlW3mwOKo3vf6Cx9O9R3oIUNIscae2QndUnWaeSM4w+CjQwFLHde9l7Y1ZzEYQFG qRoPJC7vo7ys4M1JgV1f6PV6xkac88ecO0l9ONZVTnlbLnYlOcZ7P6GISuqgAtv2Mpy7BBo65XA KfoPPvV8b/AiCJ98qK2G+UvVgFT3xxYv06QvWWQdwdfqj+bsrYAAFtbAZcEC7i4NyIW8tS7iunA uGoJxMYGprmFQxOj5XqnWJebDNO3jaZvuoHGHZU1qM+BQULb
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
 drivers/dma/at_xdmac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index c3b37168b21f..299396121e6d 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -2431,7 +2431,7 @@ static int at_xdmac_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int at_xdmac_remove(struct platform_device *pdev)
+static void at_xdmac_remove(struct platform_device *pdev)
 {
 	struct at_xdmac	*atxdmac = (struct at_xdmac *)platform_get_drvdata(pdev);
 	int		i;
@@ -2452,8 +2452,6 @@ static int at_xdmac_remove(struct platform_device *pdev)
 		tasklet_kill(&atchan->tasklet);
 		at_xdmac_free_chan_resources(&atchan->chan);
 	}
-
-	return 0;
 }
 
 static const struct dev_pm_ops __maybe_unused atmel_xdmac_dev_pm_ops = {
@@ -2478,7 +2476,7 @@ MODULE_DEVICE_TABLE(of, atmel_xdmac_dt_ids);
 
 static struct platform_driver at_xdmac_driver = {
 	.probe		= at_xdmac_probe,
-	.remove		= at_xdmac_remove,
+	.remove_new	= at_xdmac_remove,
 	.driver = {
 		.name		= "at_xdmac",
 		.of_match_table	= of_match_ptr(atmel_xdmac_dt_ids),
-- 
2.40.1

