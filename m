Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C657A6529
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjISNcs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbjISNci (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:38 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140E1128
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:32 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapw-00053f-Ij; Tue, 19 Sep 2023 15:32:20 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapu-007T4w-Qa; Tue, 19 Sep 2023 15:32:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapu-0030fo-HE; Tue, 19 Sep 2023 15:32:18 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 36/59] dma: qcom: qcom_adm: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:44 +0200
Message-Id: <20230919133207.1400430-37-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1861; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=MTHxMVOKj0c5e8s0Wrd0Yn3TaQHw/1jODqrJpVqwjPA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHYImy6GB6sJinxFG9tw1qyO9ufCht1F+ARl Dc7gOpD0rqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmh2AAKCRCPgPtYfRL+ TrsaB/wIsrOJnCPHFsjVpLmU1/zLdUIKIG1cCmwf+CcZDJqkbghT0BwChEtyUDkcu4XMRS6wX7L zAlu3qeJJp7brZmHlPzSwgalSaY+XT9uv8+sozfHbpToTDPTN2EUWh4ZeLvRppDRsJyimItsrSq QsSnKgke661Ipaa6cU2euWzoC/u99jaXwt/GRkjUkMv42a/GKYpaKnBOULEWDreO9rFPpbDFVc3 c2KO5gafaTxIXy3Rnbn2hY9Y+dphbiXWKhhyL+YP7F+KuQRcqs/SkaFJ6jLA1SPfRf6ec/fPjS7 a3SIh+idPa+DOQiszsAaHsshgLWKqFzVUa51oY2MNVh4X4bl
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
 drivers/dma/qcom/qcom_adm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/qcom/qcom_adm.c b/drivers/dma/qcom/qcom_adm.c
index d56caf1681ff..53f4273b657c 100644
--- a/drivers/dma/qcom/qcom_adm.c
+++ b/drivers/dma/qcom/qcom_adm.c
@@ -904,7 +904,7 @@ static int adm_dma_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int adm_dma_remove(struct platform_device *pdev)
+static void adm_dma_remove(struct platform_device *pdev)
 {
 	struct adm_device *adev = platform_get_drvdata(pdev);
 	struct adm_chan *achan;
@@ -927,8 +927,6 @@ static int adm_dma_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(adev->core_clk);
 	clk_disable_unprepare(adev->iface_clk);
-
-	return 0;
 }
 
 static const struct of_device_id adm_of_match[] = {
@@ -939,7 +937,7 @@ MODULE_DEVICE_TABLE(of, adm_of_match);
 
 static struct platform_driver adm_dma_driver = {
 	.probe = adm_dma_probe,
-	.remove = adm_dma_remove,
+	.remove_new = adm_dma_remove,
 	.driver = {
 		.name = "adm-dma-engine",
 		.of_match_table = adm_of_match,
-- 
2.40.1

