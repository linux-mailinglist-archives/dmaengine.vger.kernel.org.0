Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732527A652D
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjISNcu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjISNck (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:40 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD43C134
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:32 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapx-00058Q-7N; Tue, 19 Sep 2023 15:32:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapv-007T5A-Ka; Tue, 19 Sep 2023 15:32:19 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapv-0030g4-B2; Tue, 19 Sep 2023 15:32:19 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Pavel Machek <pavel@denx.de>,
        Hien Huynh <hien.huynh.px@renesas.com>,
        dmaengine@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 40/59] dma: sh: rz-dmac: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:48 +0200
Message-Id: <20230919133207.1400430-41-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1829; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=tnDkyZi5NmaUHcTC0eDvISGVXJeLAI2z22myyberCMI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHdUrdpeiFaBrv61kkg+jMsQAcMPovs/55KD ojfkUyou2SJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmh3QAKCRCPgPtYfRL+ TvB7B/9eE8iIF5QTVny1r3W+zrVvBFWvhfBBnXN8By+Glt3p0TfDzz2QLNd4mrLGTg3140hKPPY 0WDZt2K2x9pMXQjdRYI/xWKBC1BaRM1FQpqxNybY/DyjG8GrSzQij0rdVsJRj7fDX0ojqSYNraV M9au0CgnbXK7SA9opvYdPdFsNjIcSzXETxPWRBGcvejkLf1bwfeDsh4yJyenMURbvmIFqvhw0b7 x7/pvohAHj9bq8xMGDIXjsZLxgTtjOsXKtISo64y1sHp8Nl6VQ0kKcpDzjIe+L0l5SDt0s64AuP 8HFEfduB6VimJsC8DXp+VknIEWqZSGbh5pqcuwdp3eqDS4md
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
 drivers/dma/sh/rz-dmac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index f777addda8ba..fea5bda34bc2 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -969,7 +969,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int rz_dmac_remove(struct platform_device *pdev)
+static void rz_dmac_remove(struct platform_device *pdev)
 {
 	struct rz_dmac *dmac = platform_get_drvdata(pdev);
 	unsigned int i;
@@ -987,8 +987,6 @@ static int rz_dmac_remove(struct platform_device *pdev)
 	reset_control_assert(dmac->rstc);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 static const struct of_device_id of_rz_dmac_match[] = {
@@ -1003,7 +1001,7 @@ static struct platform_driver rz_dmac_driver = {
 		.of_match_table = of_rz_dmac_match,
 	},
 	.probe		= rz_dmac_probe,
-	.remove		= rz_dmac_remove,
+	.remove_new	= rz_dmac_remove,
 };
 
 module_platform_driver(rz_dmac_driver);
-- 
2.40.1

