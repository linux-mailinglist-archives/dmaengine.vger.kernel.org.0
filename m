Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD937A6501
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjISNcb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjISNcZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:25 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B62D135
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapp-0004d6-3J; Tue, 19 Sep 2023 15:32:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapo-007T3A-NC; Tue, 19 Sep 2023 15:32:12 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapo-0030e4-Dr; Tue, 19 Sep 2023 15:32:12 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-mips@vger.kernel.org,
        dmaengine@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 09/59] dma: dma-jz4780: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:17 +0200
Message-Id: <20230919133207.1400430-10-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1903; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=FhsjLKXvVHLLB+zkXg/qHNDpBgdi8jSzi44XfTan6ls=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaG4SWKJOyMrNoDskwDjVRmbL0ID5DzKo6Xs9 764yF+j56mJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmhuAAKCRCPgPtYfRL+ TpOZCACFiaHhK8kdTVr7p7RiSCKcsur1lW4OiwJfh32kPSkZgU3amtNn7LH6EcS7kp6D1hrlfzc zqxtix9oNQEKnEtbOQoalACsGfRiHvf5A2FlPmg/g5DROt82jsmFu3xRBDmVYcH9ctU+rxQAvZg px8q4r1jfTfAhYj3dKgXpWwJxkuTPcE5rsdGk83YRmIFf4hSFKmY9kRvx7ORuuyvci2jSgVwnxT MTRN4CrfD5vm+O6nlt54gRXxwdIoqiJkthCw1Xw3nsiYdcekE2r8zDpDZ3VnmC24nALwnfuL+GC SU+pFS3mwFozwSmrWWBTGqtIfZYcgfN4oTbfu+3AZKgzKMJ4
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
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
 drivers/dma/dma-jz4780.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index adbd47bd6adf..c9cfa341db51 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -1008,7 +1008,7 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int jz4780_dma_remove(struct platform_device *pdev)
+static void jz4780_dma_remove(struct platform_device *pdev)
 {
 	struct jz4780_dma_dev *jzdma = platform_get_drvdata(pdev);
 	int i;
@@ -1020,8 +1020,6 @@ static int jz4780_dma_remove(struct platform_device *pdev)
 
 	for (i = 0; i < jzdma->soc_data->nb_channels; i++)
 		tasklet_kill(&jzdma->chan[i].vchan.task);
-
-	return 0;
 }
 
 static const struct jz4780_dma_soc_data jz4740_dma_soc_data = {
@@ -1124,7 +1122,7 @@ MODULE_DEVICE_TABLE(of, jz4780_dma_dt_match);
 
 static struct platform_driver jz4780_dma_driver = {
 	.probe		= jz4780_dma_probe,
-	.remove		= jz4780_dma_remove,
+	.remove_new	= jz4780_dma_remove,
 	.driver	= {
 		.name	= "jz4780-dma",
 		.of_match_table = jz4780_dma_dt_match,
-- 
2.40.1

