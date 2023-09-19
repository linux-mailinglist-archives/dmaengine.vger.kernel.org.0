Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425357A652F
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjISNcv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbjISNck (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:40 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAAC114
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiaq0-0005IQ-2W; Tue, 19 Sep 2023 15:32:24 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapy-007T5j-2b; Tue, 19 Sep 2023 15:32:22 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapx-0030ge-KP; Tue, 19 Sep 2023 15:32:21 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 49/59] dma: tegra210-adma: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:57 +0200
Message-Id: <20230919133207.1400430-50-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1852; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=5+mecjlFKmd8TVrFW4MYCmacqxPAp/lAxa8imCO+1Hw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHn/+7xPNMV2n5nb3por5jxSDs8U3DxWFGf5 cEtaDrmksaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmh5wAKCRCPgPtYfRL+ Tj7vB/sHCmK3Fhdtbl+g31xhTzCDBfHmUcq76KFXy5+rTG7NrzwlipfOr7hriY3Y/iiVnT8UVzL MHQ0rMLAQ+xrRL/RFAEygrNmxDjm+ze9KCvIfMjqYjUKalru9/G/i+QakerD4TszEoEWjpQ2VoV K4kcL7DNnfrhTehEmlfGD6IxK3nhHeybg9GQdDBkVrk45lJS5au+Ot5G3r9b5p4oS1A+Oqxo69O EBaDrPA2x4ROMkdyg/7XjtcUPa2xC1ER/ek1TEQqtZ20QBudCJNAyyCZE23UIJNxNsLQ9LJWncK 3RUjyA4cxUvBkNUGMosrqXbUzKyf0UxPyp+FRXFIVSrkQ6Eu
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
 drivers/dma/tegra210-adma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index e557bada1510..60111d40325e 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -949,7 +949,7 @@ static int tegra_adma_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int tegra_adma_remove(struct platform_device *pdev)
+static void tegra_adma_remove(struct platform_device *pdev)
 {
 	struct tegra_adma *tdma = platform_get_drvdata(pdev);
 	int i;
@@ -961,8 +961,6 @@ static int tegra_adma_remove(struct platform_device *pdev)
 		irq_dispose_mapping(tdma->channels[i].irq);
 
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 static const struct dev_pm_ops tegra_adma_dev_pm_ops = {
@@ -979,7 +977,7 @@ static struct platform_driver tegra_admac_driver = {
 		.of_match_table = tegra_adma_of_match,
 	},
 	.probe		= tegra_adma_probe,
-	.remove		= tegra_adma_remove,
+	.remove_new	= tegra_adma_remove,
 };
 
 module_platform_driver(tegra_admac_driver);
-- 
2.40.1

