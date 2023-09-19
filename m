Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E40D7A6508
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbjISNcf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjISNc0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:26 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59F4F5
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapt-0004tB-TG; Tue, 19 Sep 2023 15:32:17 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapt-007T4a-De; Tue, 19 Sep 2023 15:32:17 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapt-0030fQ-0s; Tue, 19 Sep 2023 15:32:17 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 30/59] dma: nbpfaxi: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:38 +0200
Message-Id: <20230919133207.1400430-31-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1795; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=takWHPj10cZzZ9nJ9ty/1Gp5zQm1g+jwqPCdtIsZr/k=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHR8ifDkJbduFvOq/uwhTPeJ03l13NnHt2Bi 9xyN5D0ia2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmh0QAKCRCPgPtYfRL+ Tsw6B/0YG/Tgg0HC+oJRWqmJtw0f3rajgF/4dH+3/KBlfE1YervWIgk9JfD2Q0uRckdGjMCGhuP iiLaV2IzFZR6QjWIMTWfshFqvpynDg35+0hggSY2SNGw5+qJ1cV/ccY8m5sFp6WTxJdRJblJPrB nyRoF3xSF7mGAelwwh7EzyEAqGRV/wtiHczJBeXtkQrR11yPrDClOXSLgE5aFUIm4xd6o8GkjjH kXifXI48ZdvRpxdaUy0fZcmujik8tdNddRY1LP2ABV22Jl1qeHyQnjTWIBkhpcLGJ71ZFIVaGpo FyzIVdDwoiAcg2Ry55jGvtgiUhoJxzXoMUPifskoopWDHNMS
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
 drivers/dma/nbpfaxi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
index 0b2f96fd8bf0..c08916339aa7 100644
--- a/drivers/dma/nbpfaxi.c
+++ b/drivers/dma/nbpfaxi.c
@@ -1454,7 +1454,7 @@ static int nbpf_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int nbpf_remove(struct platform_device *pdev)
+static void nbpf_remove(struct platform_device *pdev)
 {
 	struct nbpf_device *nbpf = platform_get_drvdata(pdev);
 	int i;
@@ -1472,8 +1472,6 @@ static int nbpf_remove(struct platform_device *pdev)
 	of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&nbpf->dma_dev);
 	clk_disable_unprepare(nbpf->clk);
-
-	return 0;
 }
 
 static const struct platform_device_id nbpf_ids[] = {
@@ -1517,7 +1515,7 @@ static struct platform_driver nbpf_driver = {
 	},
 	.id_table = nbpf_ids,
 	.probe = nbpf_probe,
-	.remove = nbpf_remove,
+	.remove_new = nbpf_remove,
 };
 
 module_platform_driver(nbpf_driver);
-- 
2.40.1

