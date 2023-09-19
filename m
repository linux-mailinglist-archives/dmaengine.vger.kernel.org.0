Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003327A64FA
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjISNc1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjISNcY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:24 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD28102
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapr-0004kV-LK; Tue, 19 Sep 2023 15:32:15 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapr-007T3v-2T; Tue, 19 Sep 2023 15:32:15 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapq-0030em-PV; Tue, 19 Sep 2023 15:32:14 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 20/59] dma: k3dma: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:28 +0200
Message-Id: <20230919133207.1400430-21-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1723; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=9+90O+VNf7DEV2uM3hmuqaM/WHvfJCH1YURre3KlQ0I=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHFL3FWDu2t1SRmcBfdqW150hbgM47jMZIIl aJeg7MvaZOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmhxQAKCRCPgPtYfRL+ ToguCACTDBlTO9RTnfd7T+KZy4VCHCst8U7TylgkwFsSoap5zQKsCPQb4jkt5cGmorbMtlEr4jH nblnQYM1ObnSaupx46vy5SwS1lPo88mZbGmaj1Fp/Qs2OfHS6i4bKz/zaMvLfT6nFGGm4trvYU1 4HA9yzm+LZ1R4bCwc9P6H4T+wnJ0JF7L9UQeYh0CbVi6K1TMRjogbDrFXXw+X5XbMhCi4qlZcZ/ h2jjxADElxpY46GklTiuruokp7RGCS7OmvyNftJ1zQVzoVS4SgdJYydrTn08RrcNfYX/ZEZ8jbc l/xeb+pNPiQ0LCnXq+mg4hgXgUeyS8iDukfQ+RexCwJD0PIX
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
 drivers/dma/k3dma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index ecdaada95120..22b37b525a48 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -974,7 +974,7 @@ static int k3_dma_probe(struct platform_device *op)
 	return ret;
 }
 
-static int k3_dma_remove(struct platform_device *op)
+static void k3_dma_remove(struct platform_device *op)
 {
 	struct k3_dma_chan *c, *cn;
 	struct k3_dma_dev *d = platform_get_drvdata(op);
@@ -990,7 +990,6 @@ static int k3_dma_remove(struct platform_device *op)
 	}
 	tasklet_kill(&d->task);
 	clk_disable_unprepare(d->clk);
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1034,7 +1033,7 @@ static struct platform_driver k3_pdma_driver = {
 		.of_match_table = k3_pdma_dt_ids,
 	},
 	.probe		= k3_dma_probe,
-	.remove		= k3_dma_remove,
+	.remove_new	= k3_dma_remove,
 };
 
 module_platform_driver(k3_pdma_driver);
-- 
2.40.1

