Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F99F7A6533
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjISNcw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbjISNcl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:41 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E541C137
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapz-0005Eq-Lw; Tue, 19 Sep 2023 15:32:23 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapx-007T5W-5j; Tue, 19 Sep 2023 15:32:21 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapw-0030gS-OX; Tue, 19 Sep 2023 15:32:20 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, kernel@pengutronix.de
Subject: [PATCH 46/59] dma: sun6i-dma: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:54 +0200
Message-Id: <20230919133207.1400430-47-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1700; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=/KDvS+CXYRRVq7p2n6w+Wx6Yq0sSMi2c+ORHwPV0uNo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHkPUHsHPWjEpNduMX1j8W4MLRiqFHpyO4io mhewaVT8YaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmh5AAKCRCPgPtYfRL+ TjsBCAC31HbQIkIhMyiAC2OJeHT6/KhgWA8G1/NQgesVSFxefAySIjH+4v9pxg+WStET7ATkjNf OHhkyTr1EHsTm6src/w4P9BWcK//gCwYbN4ifO17FqlZZsTcisJyRIWVmSLIqmDRUcgQ25MrIiu 1k/v27GSElDPzZSfoq0VeF0gcQZj1knIvz5ivIge3wPTf+OHwZWOmFUANqbbPmsomh/+GGm03YM B60BMHofQlo2izXqjMN0VyCMHJ+FFBC05/ZJyxwQM9K5DC+XMy+sudiD6e4AzvU2ZbdAxmu5ZFq phUxi8OvAbegwG8QC+Hr2u73zfMEH26sKgK+X/jKS214+iLA
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
 drivers/dma/sun6i-dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 2469efddf540..583bf49031cf 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -1470,7 +1470,7 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sun6i_dma_remove(struct platform_device *pdev)
+static void sun6i_dma_remove(struct platform_device *pdev)
 {
 	struct sun6i_dma_dev *sdc = platform_get_drvdata(pdev);
 
@@ -1484,13 +1484,11 @@ static int sun6i_dma_remove(struct platform_device *pdev)
 	reset_control_assert(sdc->rstc);
 
 	sun6i_dma_free(sdc);
-
-	return 0;
 }
 
 static struct platform_driver sun6i_dma_driver = {
 	.probe		= sun6i_dma_probe,
-	.remove		= sun6i_dma_remove,
+	.remove_new	= sun6i_dma_remove,
 	.driver = {
 		.name		= "sun6i-dma",
 		.of_match_table	= sun6i_dma_match,
-- 
2.40.1

