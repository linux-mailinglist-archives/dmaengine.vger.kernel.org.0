Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E7E7A650D
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjISNcg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbjISNca (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:30 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61221123
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapr-0004jD-95; Tue, 19 Sep 2023 15:32:15 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapq-007T3o-Jj; Tue, 19 Sep 2023 15:32:14 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapq-0030ee-AU; Tue, 19 Sep 2023 15:32:14 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 18/59] dma: imx-dma: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:26 +0200
Message-Id: <20230919133207.1400430-19-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1804; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=jFClRoZci1hZIqjL65iDQsFtOH3Eq+23KmERQ04Ia5c=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHCjERJqV3CFl+utVhnbbZEll1ydaFNVNPmM 23PlcthRDmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmhwgAKCRCPgPtYfRL+ TsVEB/sGXeKszBGDm+qUaIyIOhvSGu54UBTEg1/4ipdmzakd9J0LBla4+AgspBmdrch8qINZP/H hdfvPYIhjxytFSOZ5CvfhtZCSlRS3tz4kVwIsXMW2HgTpEQEI0NXcjwfWGaSNpJxhE+JbfsBZNQ M+hnkmBMab7TdplpXU/3ccNLLtdljxMoV8wgjvF3Xcuyog15cvqVCqMGIDqJl5GagTCad1205LY wrq78/nIX8z+VVlmvIpZQvJ6R0EU71ihRVaEY6UExLwYqTO4TERFr7Gjc4cD4H4kNFH9hTCfHCS svR0JjxzDNv550f2NnXIl7jAN2XPxZIkYgRQvvpByai5ZYzT
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
 drivers/dma/imx-dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index 114f254b9f50..ebf7c115d553 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -1216,7 +1216,7 @@ static void imxdma_free_irq(struct platform_device *pdev, struct imxdma_engine *
 	}
 }
 
-static int imxdma_remove(struct platform_device *pdev)
+static void imxdma_remove(struct platform_device *pdev)
 {
 	struct imxdma_engine *imxdma = platform_get_drvdata(pdev);
 
@@ -1229,8 +1229,6 @@ static int imxdma_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(imxdma->dma_ipg);
 	clk_disable_unprepare(imxdma->dma_ahb);
-
-        return 0;
 }
 
 static struct platform_driver imxdma_driver = {
@@ -1238,7 +1236,7 @@ static struct platform_driver imxdma_driver = {
 		.name	= "imx-dma",
 		.of_match_table = imx_dma_of_dev_id,
 	},
-	.remove		= imxdma_remove,
+	.remove_new	= imxdma_remove,
 };
 
 static int __init imxdma_module_init(void)
-- 
2.40.1

