Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0107A651F
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjISNco (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjISNcg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:36 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6835122
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapw-00050U-3h; Tue, 19 Sep 2023 15:32:20 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapu-007T4p-Dl; Tue, 19 Sep 2023 15:32:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapu-0030fg-4L; Tue, 19 Sep 2023 15:32:18 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 34/59] dma: qcom: bam_dma: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:42 +0200
Message-Id: <20230919133207.1400430-35-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1850; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=0cAcvIAz+mB1p4VR0D7nAMhLTtA7jGJNOdsv/F0fQRE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHVzkM8GSSJ0ZA+qd+Jl1+D7+2iYGUCHOUss CcKSudxtT6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmh1QAKCRCPgPtYfRL+ ThfiB/wIDZTgqESs7NT+Jb2r4vv5CL8wulWPFEgFX5tHuoC3DK7bonuDMe08VwFFeat+pDK8xlW lNMr2JmIQIQwUkxHagaSkatls9dLasDjjD1a2oumP73h1Ypck4+2uoOfj6Mr4Y95nasyBG0wiGM TfuptJdqVaWJ7CjPNwZddqNFUE+9TjMZtJxUaLuBXDu36iNbnAAqWv5trd8Sn8S879JPWDZa8RR Cs7haiSNBKy08NzC25X5n4brTqMf6BhaU4Dxlyxg6g4XMA5IW627z7Ftwk1tAoEeqsN7MfSyGR7 qjR1K1zT2EuFOO20KXxflJLfNkz3bg4pHSu2MMlmiwNCwRMV
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
 drivers/dma/qcom/bam_dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 4c3eb972039d..c4f8d17d0c68 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1386,7 +1386,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int bam_dma_remove(struct platform_device *pdev)
+static void bam_dma_remove(struct platform_device *pdev)
 {
 	struct bam_device *bdev = platform_get_drvdata(pdev);
 	u32 i;
@@ -1416,8 +1416,6 @@ static int bam_dma_remove(struct platform_device *pdev)
 	tasklet_kill(&bdev->task);
 
 	clk_disable_unprepare(bdev->bamclk);
-
-	return 0;
 }
 
 static int __maybe_unused bam_dma_runtime_suspend(struct device *dev)
@@ -1475,7 +1473,7 @@ static const struct dev_pm_ops bam_dma_pm_ops = {
 
 static struct platform_driver bam_dma_driver = {
 	.probe = bam_dma_probe,
-	.remove = bam_dma_remove,
+	.remove_new = bam_dma_remove,
 	.driver = {
 		.name = "bam-dma-engine",
 		.pm = &bam_dma_pm_ops,
-- 
2.40.1

