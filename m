Return-Path: <dmaengine+bounces-52-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA41A7E12D4
	for <lists+dmaengine@lfdr.de>; Sun,  5 Nov 2023 10:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C9D1C208EA
	for <lists+dmaengine@lfdr.de>; Sun,  5 Nov 2023 09:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA398F5F;
	Sun,  5 Nov 2023 09:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F678F4B
	for <dmaengine@vger.kernel.org>; Sun,  5 Nov 2023 09:34:45 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89D8EE
	for <dmaengine@vger.kernel.org>; Sun,  5 Nov 2023 01:34:43 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qzZWd-0000Pg-T9; Sun, 05 Nov 2023 10:34:35 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qzZWc-006l7R-Hl; Sun, 05 Nov 2023 10:34:34 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qzZWc-00D8nr-8c; Sun, 05 Nov 2023 10:34:34 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Vinod Koul <vkoul@kernel.org>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH 4/4] dmaengine: uniphier-xdmac: Convert to platform remove callback returning void
Date: Sun,  5 Nov 2023 10:34:20 +0100
Message-ID: <20231105093415.3704633-10-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2604; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Wsv/SCBHHBOzEUfGKUTR96iDjLgTDVwgqqZx8UGatP8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlR2Gc9/4L+wKj/bFGGeUlDQohLCMOow4pA/CO+ 7vLAdGsk1uJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZUdhnAAKCRCPgPtYfRL+ TmXXCACx8B/yk11rm8+3h9qfsjq5+yW6EpK/1olvOKBg0lRSjNXwixyw8zlSPXzQQgGS8rUyNKl xkckt8x8XsfPi0qgDxJxxVrdIC/6y+chfwaerRjzvO+u3LIJaDtb9SuD9DlVO9hDGZZQJtro/R9 LHQ6AocPWjDbi8FWiLhvnURNNVqGQibcOXmPlY8glS+IM+/lr2HNrBR+g/mUD0gAyYe1jr/tw96 HIESy72063wNt8fqrmWgk+3g4kFFVgEAY0iL/CEiMNJStXw5ZpjkbqqYaOq5ysAWi+xMxfEPkqZ qm9bROZ3Lt//0qpfE0QQ70zIbOkFOI1/Yo/MzA+z3ZKwpHqS
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
 drivers/dma/uniphier-xdmac.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/uniphier-xdmac.c b/drivers/dma/uniphier-xdmac.c
index 3a8ee2b173b5..3ce2dc2ad9de 100644
--- a/drivers/dma/uniphier-xdmac.c
+++ b/drivers/dma/uniphier-xdmac.c
@@ -563,7 +563,7 @@ static int uniphier_xdmac_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int uniphier_xdmac_remove(struct platform_device *pdev)
+static void uniphier_xdmac_remove(struct platform_device *pdev)
 {
 	struct uniphier_xdmac_device *xdev = platform_get_drvdata(pdev);
 	struct dma_device *ddev = &xdev->ddev;
@@ -579,15 +579,20 @@ static int uniphier_xdmac_remove(struct platform_device *pdev)
 	 */
 	list_for_each_entry(chan, &ddev->channels, device_node) {
 		ret = dmaengine_terminate_sync(chan);
-		if (ret)
-			return ret;
+		if (ret) {
+			/*
+			 * This results in resource leakage and maybe also
+			 * use-after-free errors as e.g. *xdev is kfreed.
+			 */
+			dev_alert(&pdev->dev, "Failed to terminate channel %d (%pe)\n",
+				  chan->chan_id, ERR_PTR(ret));
+			return;
+		}
 		uniphier_xdmac_free_chan_resources(chan);
 	}
 
 	of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(ddev);
-
-	return 0;
 }
 
 static const struct of_device_id uniphier_xdmac_match[] = {
@@ -598,7 +603,7 @@ MODULE_DEVICE_TABLE(of, uniphier_xdmac_match);
 
 static struct platform_driver uniphier_xdmac_driver = {
 	.probe = uniphier_xdmac_probe,
-	.remove = uniphier_xdmac_remove,
+	.remove_new = uniphier_xdmac_remove,
 	.driver = {
 		.name = "uniphier-xdmac",
 		.of_match_table = uniphier_xdmac_match,
-- 
2.42.0


