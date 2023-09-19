Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7317A64F7
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjISNc0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjISNcX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:23 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C5EF3
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapq-0004hc-Pc; Tue, 19 Sep 2023 15:32:14 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapq-007T3g-3J; Tue, 19 Sep 2023 15:32:14 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapp-0030eV-Qe; Tue, 19 Sep 2023 15:32:13 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 16/59] dma: idma64: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:24 +0200
Message-Id: <20230919133207.1400430-17-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1747; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=sFh7t+ASWODCri2NYm+N/G20spRWcYqtBybqkG+lhgs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHAWCzwX98yP44bDPLuBi7IfBy/Z55KDeBI+ 0PUMeC1q9eJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmhwAAKCRCPgPtYfRL+ Ts49B/98k+5hxMFzrMKMLPIdCKbKPORpJhHaN7PGndqzOuBxGBQvSzaK94jayJ2QoCVCkYmr/bI S29uqhpSh3xxmsiZQnKdwfunQGsiB3vuJRAJoN/aWyPrBtqEQNtEGtExoC86Rx71UZXXzOoEZbJ tAaL0fW46aG++AsZgE3dREUcy5XdRGde8n2RtL8l7EPR/O33+iHSLOHyJBx5Z5NrEJtRK0KpLSe gGU+CqB9RiNaPbRsKOKP71F1LeotThHVV6MibCDcTo/qXmsZfXGTF1tv5xCewxtSX7QovKnpgRS YUlGdKfvwGjzWAjQ8cX3bsrkah14h0g7edAoF74+G5H9hDdi
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
 drivers/dma/idma64.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index 0ac634a51c5e..78a938969d7d 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -660,13 +660,11 @@ static int idma64_platform_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int idma64_platform_remove(struct platform_device *pdev)
+static void idma64_platform_remove(struct platform_device *pdev)
 {
 	struct idma64_chip *chip = platform_get_drvdata(pdev);
 
 	idma64_remove(chip);
-
-	return 0;
 }
 
 static int __maybe_unused idma64_pm_suspend(struct device *dev)
@@ -691,7 +689,7 @@ static const struct dev_pm_ops idma64_dev_pm_ops = {
 
 static struct platform_driver idma64_platform_driver = {
 	.probe		= idma64_platform_probe,
-	.remove		= idma64_platform_remove,
+	.remove_new	= idma64_platform_remove,
 	.driver = {
 		.name	= LPSS_IDMA64_DRIVER_NAME,
 		.pm	= &idma64_dev_pm_ops,
-- 
2.40.1

