Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACBD7A6510
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjISNch (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjISNca (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:30 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DE1F5
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiaps-0004lU-2q; Tue, 19 Sep 2023 15:32:16 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapr-007T43-Hv; Tue, 19 Sep 2023 15:32:15 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapr-0030eu-8Q; Tue, 19 Sep 2023 15:32:15 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 22/59] dma: mediatek: mtk-cqdma: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:30 +0200
Message-Id: <20230919133207.1400430-23-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1816; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=YJbeovTY/lshOQ9H/y+Krl2XAltInqDgPcX2R8AjpCQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHH9ujjB5HmrSGUbvrIzAR4yuMWtHJ9HDkOm CQ78TXL1OiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmhxwAKCRCPgPtYfRL+ TvIlCACfKCVspXcqAoqSCz8HES+XLDWJAvS5U3mb49tYIQ7MAR8BjUH1ZFRM/+rRHno4UDtzU6i 6CW3aKThZ/2sQmsX78pxUaKLctRU+Dg0jKx0N7g3d42wFRdfUOogI3l4YxEz2h7Q5BGTuuQ3yIA HpLed1bOlCcQ3+HARE6KBlKTzNymiohy0CJ4wF+lrftR7MIz0VOF3Kxe12WyLI2GJcEwdpDlRuH skrWojmXT33Hp3aEvZ2jUgFP02BzU5WqwPpucgXkfTZ8Th653DBdaeRux6Zx+YTyG4GOJpQB8mt PRS0ATmaUxUQGhiahT/qCa3BDuu0k83Bs56uHQaaVF9ptEj4
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
 drivers/dma/mediatek/mtk-cqdma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-cqdma.c
index 324b7387b1b9..529100c5b9f5 100644
--- a/drivers/dma/mediatek/mtk-cqdma.c
+++ b/drivers/dma/mediatek/mtk-cqdma.c
@@ -885,7 +885,7 @@ static int mtk_cqdma_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int mtk_cqdma_remove(struct platform_device *pdev)
+static void mtk_cqdma_remove(struct platform_device *pdev)
 {
 	struct mtk_cqdma_device *cqdma = platform_get_drvdata(pdev);
 	struct mtk_cqdma_vchan *vc;
@@ -918,13 +918,11 @@ static int mtk_cqdma_remove(struct platform_device *pdev)
 
 	dma_async_device_unregister(&cqdma->ddev);
 	of_dma_controller_free(pdev->dev.of_node);
-
-	return 0;
 }
 
 static struct platform_driver mtk_cqdma_driver = {
 	.probe = mtk_cqdma_probe,
-	.remove = mtk_cqdma_remove,
+	.remove_new = mtk_cqdma_remove,
 	.driver = {
 		.name           = KBUILD_MODNAME,
 		.of_match_table = mtk_cqdma_match,
-- 
2.40.1

