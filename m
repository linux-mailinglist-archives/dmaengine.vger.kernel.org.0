Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD205FF212
	for <lists+dmaengine@lfdr.de>; Fri, 14 Oct 2022 18:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiJNQM7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Oct 2022 12:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJNQM7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 14 Oct 2022 12:12:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A2B183DB6
        for <dmaengine@vger.kernel.org>; Fri, 14 Oct 2022 09:12:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ojNIu-0002AR-RG; Fri, 14 Oct 2022 18:12:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ojNIu-001W1h-2l; Fri, 14 Oct 2022 18:12:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ojNIt-007w7k-5S; Fri, 14 Oct 2022 18:12:55 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] dmaengine: idma64: Make idma64_remove() return void
Date:   Fri, 14 Oct 2022 18:12:50 +0200
Message-Id: <20221014161250.468687-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1324; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=inMxWyyd4Dy1EjpqQ9nvP6ljb4yc1FEXokPgZEd9s34=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjSYp++KBa4CvrEZJrShlEbHssXkGrdxLKoLKIvsOy Ih88+dOJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY0mKfgAKCRDB/BR4rcrsCX10B/ 0Rb1Aqpix91RppsW+zekh/OiNT1rNCaIQe8+bQG+u8k2XovNYS6ADk94sX+Ha1zZbvV4zCXGIcDj+Q z7b7ZfJVbNZTy9+860wNeDJDwhXRUy62hoQS+2vwfgE1EaXtVKC/IIfbE9pWp8W0wevgLTrZijVmWx VZEub4l041KP6NYJUjVNN7H9/QQjEQVH88F1JrDWDa6nC57lVZSqQip4OU+C0/LZY9RlCihT3x9zFL YGlW6YROUoG6GZZBT6Mw8QS8wR6ysXUo/XMMQ5T7/+EPcGWli2haHOQACQWKElTu6tw/pbxOK0WWGw o/HgxitWZR2N4COvo5tTE0/s7Qi9GA
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The function idma64_remove() returns zero unconditionally. Make it
return void.

This is a preparation for making platform remove callbacks return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/dma/idma64.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index f4c07ad3be15..c33087c5cd02 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -600,7 +600,7 @@ static int idma64_probe(struct idma64_chip *chip)
 	return 0;
 }
 
-static int idma64_remove(struct idma64_chip *chip)
+static void idma64_remove(struct idma64_chip *chip)
 {
 	struct idma64 *idma64 = chip->idma64;
 	unsigned short i;
@@ -618,8 +618,6 @@ static int idma64_remove(struct idma64_chip *chip)
 
 		tasklet_kill(&idma64c->vchan.task);
 	}
-
-	return 0;
 }
 
 /* ---------------------------------------------------------------------- */
@@ -664,7 +662,9 @@ static int idma64_platform_remove(struct platform_device *pdev)
 {
 	struct idma64_chip *chip = platform_get_drvdata(pdev);
 
-	return idma64_remove(chip);
+	idma64_remove(chip);
+
+	return 0;
 }
 
 static int __maybe_unused idma64_pm_suspend(struct device *dev)

base-commit: 4fe89d07dcc2804c8b562f6c7896a45643d34b2f
-- 
2.37.2

