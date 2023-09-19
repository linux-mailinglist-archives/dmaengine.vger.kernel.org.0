Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BDB7A652E
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjISNcu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbjISNck (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:40 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9D912D
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiaq1-0005SL-RU; Tue, 19 Sep 2023 15:32:26 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiaq0-007T6I-6E; Tue, 19 Sep 2023 15:32:24 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapz-0030hD-Qw; Tue, 19 Sep 2023 15:32:23 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michal Simek <michal.simek@amd.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 58/59] dma: xilinx: xilinx_dpdma: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:32:06 +0200
Message-Id: <20230919133207.1400430-59-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1986; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=c4kegV9qxUF1PDqprDCRO/VbUQcrfl6M/Z8lCReUL7I=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHyVz8Rx9BG+CCgcvfyzqztCe61jHTikg9eh lbpljsPTUWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmh8gAKCRCPgPtYfRL+ TnafCACrI9YH6r/AuPON8rRnqVJZH8+XPR34NjvNNIAahWw7aQq0GSglVpNPKH8hlTrL9/gupFt XD/htbZ9aPqdKDE+8iQc07BLGkjA2M/1wbSSFRpfOdNU3rKoERlWa/9NH2YF9B3j7AGuGUk/qUF 4CWK5s1OtX6W+KdpWmVyD+3M5t6dznqg73tzJS70bDF0Tt7aBMukhEcQROL0yU0ppdDREYUwdpi 1z41v2a84E0eMiGt6m1EvkNTQachMQE9a2W4K7QHl1rpR7j96WFILtxBuBERGK3jt/qc5VSa7iN nbWHh4G3Pp8SktyK3XALmtoK8jGH2NpOYtrauYefXjdEz3wX
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
 drivers/dma/xilinx/xilinx_dpdma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index 84dc5240a807..69587d85a7cd 100644
--- a/drivers/dma/xilinx/xilinx_dpdma.c
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -1736,7 +1736,7 @@ static int xilinx_dpdma_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int xilinx_dpdma_remove(struct platform_device *pdev)
+static void xilinx_dpdma_remove(struct platform_device *pdev)
 {
 	struct xilinx_dpdma_device *xdev = platform_get_drvdata(pdev);
 	unsigned int i;
@@ -1751,8 +1751,6 @@ static int xilinx_dpdma_remove(struct platform_device *pdev)
 
 	for (i = 0; i < ARRAY_SIZE(xdev->chan); i++)
 		xilinx_dpdma_chan_remove(xdev->chan[i]);
-
-	return 0;
 }
 
 static const struct of_device_id xilinx_dpdma_of_match[] = {
@@ -1763,7 +1761,7 @@ MODULE_DEVICE_TABLE(of, xilinx_dpdma_of_match);
 
 static struct platform_driver xilinx_dpdma_driver = {
 	.probe			= xilinx_dpdma_probe,
-	.remove			= xilinx_dpdma_remove,
+	.remove_new		= xilinx_dpdma_remove,
 	.driver			= {
 		.name		= "xilinx-zynqmp-dpdma",
 		.of_match_table	= xilinx_dpdma_of_match,
-- 
2.40.1

