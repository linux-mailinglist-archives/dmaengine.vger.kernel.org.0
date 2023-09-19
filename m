Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2F47A6532
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbjISNcw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjISNcl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:41 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD98FB
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:34 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapw-00051x-6x; Tue, 19 Sep 2023 15:32:20 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapu-007T4t-K8; Tue, 19 Sep 2023 15:32:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapu-0030fk-At; Tue, 19 Sep 2023 15:32:18 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Sinan Kaya <okaya@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 35/59] dma: qcom: hidma: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:43 +0200
Message-Id: <20230919133207.1400430-36-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1806; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=P6otLyS2DqtXyKK4usj/EupHT4UWFzluyg14384Vi8o=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHXmH7Kwduc3bm/Jp1m9aLSYirQ7vkttOswU UmbQjFnjV+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmh1wAKCRCPgPtYfRL+ ThRTCAC2bEELW3W8JE2Sl8xkyJA6QVT82KJemptgx68auQLPL4i7xoC0oriOAkyajZfJVxQozw3 dFmPlhDkoQSkZi5iglrEU5cMrWerWgAljq65mHapAaR/AJDYD8Q/d9b1lCGGwuOSaM0CaIO2Rh7 +F3l3oCI0815jwqiZk7PbUcKZkjPbRqaljDh1XeIb10LdAK7IDeBKG6vFWdGvEmq8lf0lCMXEN+ O3d0l6Oi3Wo2Qdm94sLrF2jmCfApS41l0BC0pPcov56X57gKQhG3WDSCKI2ag6Zp8KHfrJrfH5F BSP6xbpodDTjaYFAIUmRnYPTcpFYkjeFKy5Vd3zE6NnyTveN
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
 drivers/dma/qcom/hidma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index 834ae519c15d..f4659553945b 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -915,7 +915,7 @@ static void hidma_shutdown(struct platform_device *pdev)
 
 }
 
-static int hidma_remove(struct platform_device *pdev)
+static void hidma_remove(struct platform_device *pdev)
 {
 	struct hidma_dev *dmadev = platform_get_drvdata(pdev);
 
@@ -935,8 +935,6 @@ static int hidma_remove(struct platform_device *pdev)
 	dev_info(&pdev->dev, "HI-DMA engine removed\n");
 	pm_runtime_put_sync_suspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 #if IS_ENABLED(CONFIG_ACPI)
@@ -960,7 +958,7 @@ MODULE_DEVICE_TABLE(of, hidma_match);
 
 static struct platform_driver hidma_driver = {
 	.probe = hidma_probe,
-	.remove = hidma_remove,
+	.remove_new = hidma_remove,
 	.shutdown = hidma_shutdown,
 	.driver = {
 		   .name = "hidma",
-- 
2.40.1

