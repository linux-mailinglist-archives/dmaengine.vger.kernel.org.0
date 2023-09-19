Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CA87A6509
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbjISNcf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjISNc3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:29 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DD3100
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:22 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiaps-0004ll-7p; Tue, 19 Sep 2023 15:32:16 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapr-007T47-Np; Tue, 19 Sep 2023 15:32:15 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapr-0030ey-Eh; Tue, 19 Sep 2023 15:32:15 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 23/59] dma: mediatek: mtk-hsdma: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:31 +0200
Message-Id: <20230919133207.1400430-24-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1813; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=IJ1lQBioULCY9DIp65+ezFk+Xj3QQq4U4gQ/TbmHhG0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHIFkHM3tFAVudlDyBAD/HTot2UmAFvMKJAZ W4j2F8u8ViJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmhyAAKCRCPgPtYfRL+ Tod4CACLWe7DruMnd2TxKN6OnitRd/oivVvOi0J6GYqGQDBRgLPjatYtSZhA9rP2PbB+JH5M9mz 32yGXAt6fzOZuVkGD0cRujbiIuJH6NcAIOE0GnqeQxCxFsbZQL6rSGZqFdiAUO4Nkt4gSwuOn5X VsthkIIy27ek0ymdwOmH20K8ZFjCAjZ2yX33AWfgdpr1NTiyWBVcXBoN4mr8odkOiJUKVlb9nb6 ah+2OzC/tnkMHKJkSOQIjORCZLHTpL6p5+UJGoOBDOnNQ3in/qSRZXSANXbVHQDhOouWyRzko1O 9HnbzdgKeV2EG462hSjwxWifT5PkbeUguDdoVeqSwYcEIE11
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
 drivers/dma/mediatek/mtk-hsdma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-hsdma.c b/drivers/dma/mediatek/mtk-hsdma.c
index 64120767d983..36ff11e909ea 100644
--- a/drivers/dma/mediatek/mtk-hsdma.c
+++ b/drivers/dma/mediatek/mtk-hsdma.c
@@ -1009,7 +1009,7 @@ static int mtk_hsdma_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int mtk_hsdma_remove(struct platform_device *pdev)
+static void mtk_hsdma_remove(struct platform_device *pdev)
 {
 	struct mtk_hsdma_device *hsdma = platform_get_drvdata(pdev);
 	struct mtk_hsdma_vchan *vc;
@@ -1034,13 +1034,11 @@ static int mtk_hsdma_remove(struct platform_device *pdev)
 
 	dma_async_device_unregister(&hsdma->ddev);
 	of_dma_controller_free(pdev->dev.of_node);
-
-	return 0;
 }
 
 static struct platform_driver mtk_hsdma_driver = {
 	.probe		= mtk_hsdma_probe,
-	.remove		= mtk_hsdma_remove,
+	.remove_new	= mtk_hsdma_remove,
 	.driver = {
 		.name		= KBUILD_MODNAME,
 		.of_match_table	= mtk_hsdma_match,
-- 
2.40.1

