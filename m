Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110087A652A
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjISNcs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbjISNcj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:39 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FACA12C
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:32 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapz-0005H3-TO; Tue, 19 Sep 2023 15:32:23 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapx-007T5g-Nj; Tue, 19 Sep 2023 15:32:21 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapx-0030ga-BN; Tue, 19 Sep 2023 15:32:21 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 48/59] dma: tegra20-apb-dma: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:56 +0200
Message-Id: <20230919133207.1400430-49-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1895; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=p0YNfNQ6rouQIshDwy8m+PHxQVDwpmwbI3Nov3/BeKg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHmPBHdEjzWGISv2of5x1I1zzP3z3ZxeIr9d VobHEa/ZveJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmh5gAKCRCPgPtYfRL+ TiexB/wN8AWTLCtkpJhI4/E5XP7DAQZay6Uj2FoPcfiY4HPZXfooQ8tf2bOEj28C55B1Q5rf8R+ NKqhZ+8eWlaLzIPo52WhuJg2g0P7r1tvUNwQV2zIi66mV6Ix6KdW/yRjvn6vFHVb7leg/H2vc35 7PPBXJk0LtP3dMGMxPhL1pND0zO+dv0m6cDVGPXoJG61ygMFSwltlX7xBejuT+35dgdCbtHbi5J iDJmpqKKf0pcPkChfOA+eEMYTB1cUcdl1xbxbUqWU/smyI27EL3l4cWGVarMTiT7mETGMuC95y8 IoRDYtYblRChC5+uR1Rfxtfu1OM1l1GdYG8haATzrBjKhI7+
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
 drivers/dma/tegra20-apb-dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 063022f9df76..ac69778827f2 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1581,7 +1581,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int tegra_dma_remove(struct platform_device *pdev)
+static void tegra_dma_remove(struct platform_device *pdev)
 {
 	struct tegra_dma *tdma = platform_get_drvdata(pdev);
 
@@ -1589,8 +1589,6 @@ static int tegra_dma_remove(struct platform_device *pdev)
 	dma_async_device_unregister(&tdma->dma_dev);
 	pm_runtime_disable(&pdev->dev);
 	clk_unprepare(tdma->dma_clk);
-
-	return 0;
 }
 
 static int __maybe_unused tegra_dma_runtime_suspend(struct device *dev)
@@ -1677,7 +1675,7 @@ static struct platform_driver tegra_dmac_driver = {
 		.of_match_table = tegra_dma_of_match,
 	},
 	.probe		= tegra_dma_probe,
-	.remove		= tegra_dma_remove,
+	.remove_new	= tegra_dma_remove,
 };
 
 module_platform_driver(tegra_dmac_driver);
-- 
2.40.1

