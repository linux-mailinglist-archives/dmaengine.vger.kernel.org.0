Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9BE7A6515
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjISNck (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbjISNce (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:34 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BF6102
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapp-0004aj-Gn; Tue, 19 Sep 2023 15:32:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapn-007T2q-6B; Tue, 19 Sep 2023 15:32:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapm-0030de-RD; Tue, 19 Sep 2023 15:32:10 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 03/59] dma: at_hdmac: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:11 +0200
Message-Id: <20230919133207.1400430-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1817; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=3WTsCcLpwO2d5AMEGsOosfwWRyybvlbLM2EBy+s01/0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaGx5v9b0dAzbOD/XzxT4qgy4sj4CUitobcKr UBDEelxq0KJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmhsQAKCRCPgPtYfRL+ TgwBB/9zE7wuWvbMHiS4YXptR6rD548Z/PEUFU15aHODNkqH7lzLFB70nQpMjDtaZYk86hVkkSn dCM3jY+i+mODcGFMGR1pvk7KheqtAsBFpAJrkV8I5Q0JD6EtBDwggrVaW9czzGvYIOJcQ0Ybe/c DkbjjH+nVBT8DrJP8gRxV1lHlAJpUOj17WFQg/wNAnRjhmUeG6YkJZ2ClSmyBnLwtDEhn0htYk5 mdENlOWgccAxMwn0OOtc20naAv4+2FwalVFmQK3SaOsErUZ7Y6Cp1ImRw3KZNd+AizK3ZrlwrXg xsrq40pHJD+DgKThvE2GDP2VPpIAWGabWF/4xMgy02AL/wWx
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
 drivers/dma/at_hdmac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index b2876f67471f..417a9428a9b6 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -2100,7 +2100,7 @@ static int __init at_dma_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int at_dma_remove(struct platform_device *pdev)
+static void at_dma_remove(struct platform_device *pdev)
 {
 	struct at_dma		*atdma = platform_get_drvdata(pdev);
 	struct dma_chan		*chan, *_chan;
@@ -2122,8 +2122,6 @@ static int at_dma_remove(struct platform_device *pdev)
 	}
 
 	clk_disable_unprepare(atdma->clk);
-
-	return 0;
 }
 
 static void at_dma_shutdown(struct platform_device *pdev)
@@ -2242,7 +2240,7 @@ static const struct dev_pm_ops __maybe_unused at_dma_dev_pm_ops = {
 };
 
 static struct platform_driver at_dma_driver = {
-	.remove		= at_dma_remove,
+	.remove_new	= at_dma_remove,
 	.shutdown	= at_dma_shutdown,
 	.id_table	= atdma_devtypes,
 	.driver = {
-- 
2.40.1

