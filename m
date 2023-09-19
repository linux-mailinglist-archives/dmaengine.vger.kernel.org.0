Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988B87A6503
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbjISNcc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbjISNcZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:25 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16F912F
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiaps-0004pd-VI; Tue, 19 Sep 2023 15:32:17 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiaps-007T4O-Ik; Tue, 19 Sep 2023 15:32:16 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiaps-0030fE-95; Tue, 19 Sep 2023 15:32:16 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 27/59] dma: moxart-dma: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:35 +0200
Message-Id: <20230919133207.1400430-28-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1816; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=bqYSeygDthAQ/q4ws7NUTrBbEaJKVSKEzcasn4q5cN0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHNyXgjTX+3W35L7FIR+OQGIQD/RFbLeMqpG Q5gUC3QIUiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmhzQAKCRCPgPtYfRL+ Th8BCACky83aEPs+bK/P6Vd328FE+YpB+k6sL7JR8CraBA6h4zkwCvHgQLIIEv/kWqLuKwYl6eM 9PTc7Um3GDeD2ahRS1uhVdI0th5o0Z8OqxzqDepI1s7+sdd6UPVdPyTQOi5BvE8CdJWaL4fycyR MpAicr7h0NFaF9WlqLQ6DWKFQnxULP8L4AN7aTmgOr2pw8Qyuv4zPAPZ/NQWt8TPeyne+HT+VmB 2fLKlzUeeOYXz+How95biTPs7GMlEJbaf4VTcd21a0ZS1v3Hi5NNMtNyossTz8CSacwIFjE4qH+ ZAfD0g6foy8uSE7gLBgTjVrXFOifTjzGnvfEu4PEYIuwqUco
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
 drivers/dma/moxart-dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/moxart-dma.c b/drivers/dma/moxart-dma.c
index 7565ad98ba66..a03953b3016b 100644
--- a/drivers/dma/moxart-dma.c
+++ b/drivers/dma/moxart-dma.c
@@ -630,7 +630,7 @@ static int moxart_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int moxart_remove(struct platform_device *pdev)
+static void moxart_remove(struct platform_device *pdev)
 {
 	struct moxart_dmadev *m = platform_get_drvdata(pdev);
 
@@ -640,8 +640,6 @@ static int moxart_remove(struct platform_device *pdev)
 
 	if (pdev->dev.of_node)
 		of_dma_controller_free(pdev->dev.of_node);
-
-	return 0;
 }
 
 static const struct of_device_id moxart_dma_match[] = {
@@ -652,7 +650,7 @@ MODULE_DEVICE_TABLE(of, moxart_dma_match);
 
 static struct platform_driver moxart_driver = {
 	.probe	= moxart_probe,
-	.remove	= moxart_remove,
+	.remove_new = moxart_remove,
 	.driver = {
 		.name		= "moxart-dma-engine",
 		.of_match_table	= moxart_dma_match,
-- 
2.40.1

