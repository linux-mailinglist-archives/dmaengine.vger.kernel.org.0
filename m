Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91FF7A6505
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjISNce (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjISNc1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:27 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4D7FB
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:22 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapp-0004dP-H1; Tue, 19 Sep 2023 15:32:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapp-007T3I-2o; Tue, 19 Sep 2023 15:32:13 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapo-0030eC-Q6; Tue, 19 Sep 2023 15:32:12 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dmaengine@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 11/59] dma: dw: platform: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:19 +0200
Message-Id: <20230919133207.1400430-12-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1822; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=XW6ycHooaIyjqT+sBWy6UWgpr/TYRPc0oGs88HNsnfY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaG6ZyFg+H99NLEGOVH4ho2mSnR79CV1LXSH6 MkCOmHO1PKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmhugAKCRCPgPtYfRL+ Tv2IB/wJOrv2/eAJX0MUyhI9hFKKABLDBOPdWBesGwHdNWKJM5J7ZaEVYTOaM7sDSTeNelF9Fv/ 4PtNRY6VtoXqwWy24pmQblToXsoqTDVRMr45C2nDWW+DrzqcXqjnFdC6ptiPW60nxXO7UeNgJyA Oi+K4CT/eAbuFKrMAm1nCK0i74QsVdOMn+H729tZvxhBWznx608PyIB5LVfgzmeW5VYwi0MiIFz L73hqAuBCrXeVhlQebGTdvyKBKbJwyCyXuX5fQIQoFHsfyOoxlLSxVPYzcyw25GptywwU2BMGPa PZcjgploufXpxL2uJvJcnFfDCziuC2Aqc3PnTYZS0fNpXoEP
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
 drivers/dma/dw/platform.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw/platform.c b/drivers/dma/dw/platform.c
index 47f2292dba98..7d9d4c951724 100644
--- a/drivers/dma/dw/platform.c
+++ b/drivers/dma/dw/platform.c
@@ -93,7 +93,7 @@ static int dw_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int dw_remove(struct platform_device *pdev)
+static void dw_remove(struct platform_device *pdev)
 {
 	struct dw_dma_chip_pdata *data = platform_get_drvdata(pdev);
 	struct dw_dma_chip *chip = data->chip;
@@ -109,8 +109,6 @@ static int dw_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(chip->clk);
-
-	return 0;
 }
 
 static void dw_shutdown(struct platform_device *pdev)
@@ -193,7 +191,7 @@ static const struct dev_pm_ops dw_dev_pm_ops = {
 
 static struct platform_driver dw_driver = {
 	.probe		= dw_probe,
-	.remove		= dw_remove,
+	.remove_new	= dw_remove,
 	.shutdown       = dw_shutdown,
 	.driver = {
 		.name	= DRV_NAME,
-- 
2.40.1

