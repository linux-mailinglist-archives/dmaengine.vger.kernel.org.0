Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E808B7A64FD
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjISNc3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjISNcY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:24 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B0B123
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapo-0004cu-T4; Tue, 19 Sep 2023 15:32:12 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapo-007T37-Gf; Tue, 19 Sep 2023 15:32:12 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapo-0030e0-7P; Tue, 19 Sep 2023 15:32:12 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, dmaengine@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 08/59] dma: dma-axi-dmac: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:16 +0200
Message-Id: <20230919133207.1400430-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1872; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=99OwXr0hmWPlmyfASShSvAN68AkTRB2aVRt5rXN0+fg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaG3UlpuujX2zZzYR1gJYk92ofqyh81zQQera j9AnqR6dnOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmhtwAKCRCPgPtYfRL+ ToucB/9uFvEtSRuXG/VVj6eStL37PvhkdMaxof8cR7vKNevjpnRHF862poWQwN8bSbfgRPi8VaZ gKAbC/VGotYMw52kPGRqBPPAXiLBzuZyaHgAVUV1lAvhsyBW4T5ukAZTP6R0bJK04lRmF7T+UqP Zj+z76g+bMt8D+UbofyVr1/gbZt2kJKzRPyxjixJBGDKjuyZyMTJlW1Tea0nJLZKra5O1rxsaNI s8wFRq/bPxbjE/6JDCozo1YH9hzo0XlmWYY6+EFwhs4gJpzxiXdkL7iX9b9BWxiyY3I4jx6w40q IG3eC3vcbvc0Vk20LPvevZADO8O6HmnTolNIWb3CiPCeMxH4
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
 drivers/dma/dma-axi-dmac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index fc7cdad37161..a6d235bc8444 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -1029,7 +1029,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int axi_dmac_remove(struct platform_device *pdev)
+static void axi_dmac_remove(struct platform_device *pdev)
 {
 	struct axi_dmac *dmac = platform_get_drvdata(pdev);
 
@@ -1038,8 +1038,6 @@ static int axi_dmac_remove(struct platform_device *pdev)
 	tasklet_kill(&dmac->chan.vchan.task);
 	dma_async_device_unregister(&dmac->dma_dev);
 	clk_disable_unprepare(dmac->clk);
-
-	return 0;
 }
 
 static const struct of_device_id axi_dmac_of_match_table[] = {
@@ -1054,7 +1052,7 @@ static struct platform_driver axi_dmac_driver = {
 		.of_match_table = axi_dmac_of_match_table,
 	},
 	.probe = axi_dmac_probe,
-	.remove = axi_dmac_remove,
+	.remove_new = axi_dmac_remove,
 };
 module_platform_driver(axi_dmac_driver);
 
-- 
2.40.1

