Return-Path: <dmaengine+bounces-50-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D367E12D3
	for <lists+dmaengine@lfdr.de>; Sun,  5 Nov 2023 10:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7D3281440
	for <lists+dmaengine@lfdr.de>; Sun,  5 Nov 2023 09:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5548F55;
	Sun,  5 Nov 2023 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22E88C16
	for <dmaengine@vger.kernel.org>; Sun,  5 Nov 2023 09:34:44 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CF8C0
	for <dmaengine@vger.kernel.org>; Sun,  5 Nov 2023 01:34:43 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qzZWd-0000Pd-T4; Sun, 05 Nov 2023 10:34:35 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qzZWb-006l7I-Te; Sun, 05 Nov 2023 10:34:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qzZWb-00D8nf-KR; Sun, 05 Nov 2023 10:34:33 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Vinod Koul <vkoul@kernel.org>
Cc: Taichi Sugaya <sugaya.taichi@socionext.com>,
	Takao Orito <orito.takao@socionext.com>,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH 1/4] dmaengine: milbeaut-hdmac: Convert to platform remove callback returning void
Date: Sun,  5 Nov 2023 10:34:17 +0100
Message-ID: <20231105093415.3704633-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231105093415.3704633-6-u.kleine-koenig@pengutronix.de>
References: <20231105093415.3704633-6-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2642; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=iFA5SppBIUUrRTjlHh/H9b168YL1tbBN6Q5z7xRSG+A=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlR2GYE0b9wUxglKY+saD0HA5khqRUyH857dbZ5 Bg24LiORTKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZUdhmAAKCRCPgPtYfRL+ Tt96CACPBr/T5fmGsFg4nVxjGCv2TxQEa7qFpSvVlYTvnfx7FIGt6PIdltD6B3LEJDxvjq27B68 dnpAJsbhXY0ZcmaWX3TGcJrFpazAb1/ogMK6MEsglattVL7+RcLtzbr79qBADdwDaR3RkUUIZAh e8jXRrnxCtXBTL7xqv2rpdkIC2Lv5S8Wseu/SIynz3CdpTxcjzuL8SVVog/BDy+qeHz5mHLoPif jQeWAQiccAHnbnlY+FnerBcCnE65bKjT8iHTABdnb7h4C1jqW7WzT7FX5OObi7sdjqMyjUw/5Bg kizbOnbQZuha5RdvWCCcJeB8c1Teb5DKlG4DjATRUMokhgCp
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

There is an error path that has the above mentioned problem. This patch
only adds a more drastic error message. To properly fix it,
dmaengine_terminate_sync() must be known to have succeeded (or that it's
safe to not call it as other drivers seem to assume).

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/dma/milbeaut-hdmac.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/milbeaut-hdmac.c b/drivers/dma/milbeaut-hdmac.c
index 1b0a95892627..7b41c670970a 100644
--- a/drivers/dma/milbeaut-hdmac.c
+++ b/drivers/dma/milbeaut-hdmac.c
@@ -531,7 +531,7 @@ static int milbeaut_hdmac_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int milbeaut_hdmac_remove(struct platform_device *pdev)
+static void milbeaut_hdmac_remove(struct platform_device *pdev)
 {
 	struct milbeaut_hdmac_device *mdev = platform_get_drvdata(pdev);
 	struct dma_chan *chan;
@@ -546,16 +546,21 @@ static int milbeaut_hdmac_remove(struct platform_device *pdev)
 	 */
 	list_for_each_entry(chan, &mdev->ddev.channels, device_node) {
 		ret = dmaengine_terminate_sync(chan);
-		if (ret)
-			return ret;
+		if (ret) {
+			/*
+			 * This results in resource leakage and maybe also
+			 * use-after-free errors as e.g. *mdev is kfreed.
+			 */
+			dev_alert(&pdev->dev, "Failed to terminate channel %d (%pe)\n",
+				  chan->chan_id, ERR_PTR(ret));
+			return;
+		}
 		milbeaut_hdmac_free_chan_resources(chan);
 	}
 
 	of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&mdev->ddev);
 	clk_disable_unprepare(mdev->clk);
-
-	return 0;
 }
 
 static const struct of_device_id milbeaut_hdmac_match[] = {
@@ -566,7 +571,7 @@ MODULE_DEVICE_TABLE(of, milbeaut_hdmac_match);
 
 static struct platform_driver milbeaut_hdmac_driver = {
 	.probe = milbeaut_hdmac_probe,
-	.remove = milbeaut_hdmac_remove,
+	.remove_new = milbeaut_hdmac_remove,
 	.driver = {
 		.name = "milbeaut-m10v-hdmac",
 		.of_match_table = milbeaut_hdmac_match,
-- 
2.42.0


