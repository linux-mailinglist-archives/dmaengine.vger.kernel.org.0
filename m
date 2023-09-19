Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32427A6506
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbjISNcd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbjISNc0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:26 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E1B137
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapo-0004cn-Kt; Tue, 19 Sep 2023 15:32:12 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapo-007T34-8d; Tue, 19 Sep 2023 15:32:12 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapn-0030dv-OM; Tue, 19 Sep 2023 15:32:11 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, dmaengine@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 07/59] dma: bestcomm: bestcomm: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:15 +0200
Message-Id: <20230919133207.1400430-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1884; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=WCW3e2T4/VRTHCzrUC6e5JaWFtw8EPAjoMcDihaKymQ=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlTOhVvNDBT29Hr+zg5M4z9vveYSX47Dn8Qi7anH5fnOn PZbEvCtk9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJPHJi/1+0s/seQ/yFnpY+ pvTe5kJWv90mwgLLY6Zu+OK4X4aT+ZBjqFfvceYHO6cwaV3IV+1j1Tn2pMD9XFV2acUD7xNb9SZ rhKtF/3ivf5DvnZ6xmkAj77MGxp1uR9pkD+5vSmk6EDrjiHLFd7/65Le5d1ddk3FautUsMGsS/1 nvZ+q19hyb5z49bevG6p4R7KvOvi9xT/rmI18yPVZrPPd5rDIx54f5u+TKCcfvBu7aWrWKt3eq/ cQf5+uZyxo5dSRZ79vNjcvPrXQ/3VR29jNH9ttT5ivWCxw52m48u639wOlYzVsp2UVr7VIYfnKY Vd85VBFgLJUZZVy4c+4aTecgz5esGgy5O74sceFbM20NAA==
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
 drivers/dma/bestcomm/bestcomm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/bestcomm/bestcomm.c b/drivers/dma/bestcomm/bestcomm.c
index 80096f94032d..0bbaa7620bdd 100644
--- a/drivers/dma/bestcomm/bestcomm.c
+++ b/drivers/dma/bestcomm/bestcomm.c
@@ -455,7 +455,7 @@ static int mpc52xx_bcom_probe(struct platform_device *op)
 }
 
 
-static int mpc52xx_bcom_remove(struct platform_device *op)
+static void mpc52xx_bcom_remove(struct platform_device *op)
 {
 	/* Clean up the engine */
 	bcom_engine_cleanup();
@@ -473,8 +473,6 @@ static int mpc52xx_bcom_remove(struct platform_device *op)
 	/* Release memory */
 	kfree(bcom_eng);
 	bcom_eng = NULL;
-
-	return 0;
 }
 
 static const struct of_device_id mpc52xx_bcom_of_match[] = {
@@ -488,7 +486,7 @@ MODULE_DEVICE_TABLE(of, mpc52xx_bcom_of_match);
 
 static struct platform_driver mpc52xx_bcom_of_platform_driver = {
 	.probe		= mpc52xx_bcom_probe,
-	.remove		= mpc52xx_bcom_remove,
+	.remove_new	= mpc52xx_bcom_remove,
 	.driver = {
 		.name = DRIVER_NAME,
 		.of_match_table = mpc52xx_bcom_of_match,
-- 
2.40.1

