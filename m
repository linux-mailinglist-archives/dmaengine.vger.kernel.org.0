Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B45C7A6513
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjISNci (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjISNca (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:30 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D535FB
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapw-00054x-K8; Tue, 19 Sep 2023 15:32:20 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapv-007T50-02; Tue, 19 Sep 2023 15:32:19 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapu-0030fr-NA; Tue, 19 Sep 2023 15:32:18 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 37/59] dma: sa11x0-dma: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:45 +0200
Message-Id: <20230919133207.1400430-38-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1812; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=GAyk3hyimkSYenbksbwYOpwaMajyz0JdjA4JLJvF+qw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHZ7hGGTk7W0scPlbjFiOPGVWs+ttk57cZUV URzrHZ9VFCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmh2QAKCRCPgPtYfRL+ TiRpB/9Xe4pnwJciwn285zEEPeyfmb57woqf6DCcTXEnKVLhjheiLw9UOzGEVCy0R/qh9MatEoP 9xgLkD3B04fpS4DgkEd+/nZkx9rdKXUPmCsGXRvEpFqCN+72Nh7UX90spoUdVfYv2h/lVR/YxPI okciSxegTeNeAftC1y/Z+y0Xw2jscg0YS+uDSlpswb4DgEEi/fynuTfKAYXOT1RwgcOp7KEelnD UwoQhIhhWbFHrWHMjPAlPz8km2876fGhX3QmxshR7Il5mM5OMWXIrHBaf+cTjOXYOUpxXIkTdoc 0JgMIHU4uFMHGM197Z+0pSQJ2sWQrsGJ55WuTfZQKltewbvJ
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
 drivers/dma/sa11x0-dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sa11x0-dma.c b/drivers/dma/sa11x0-dma.c
index a29c13cae716..488408e6826a 100644
--- a/drivers/dma/sa11x0-dma.c
+++ b/drivers/dma/sa11x0-dma.c
@@ -984,7 +984,7 @@ static int sa11x0_dma_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sa11x0_dma_remove(struct platform_device *pdev)
+static void sa11x0_dma_remove(struct platform_device *pdev)
 {
 	struct sa11x0_dma_dev *d = platform_get_drvdata(pdev);
 	unsigned pch;
@@ -997,8 +997,6 @@ static int sa11x0_dma_remove(struct platform_device *pdev)
 	tasklet_kill(&d->task);
 	iounmap(d->base);
 	kfree(d);
-
-	return 0;
 }
 
 static __maybe_unused int sa11x0_dma_suspend(struct device *dev)
@@ -1081,7 +1079,7 @@ static struct platform_driver sa11x0_dma_driver = {
 		.pm	= &sa11x0_dma_pm_ops,
 	},
 	.probe		= sa11x0_dma_probe,
-	.remove		= sa11x0_dma_remove,
+	.remove_new	= sa11x0_dma_remove,
 };
 
 static int __init sa11x0_dma_init(void)
-- 
2.40.1

