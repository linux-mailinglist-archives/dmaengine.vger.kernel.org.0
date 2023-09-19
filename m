Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA4A7A651C
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjISNcm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbjISNcf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:35 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCB4FB
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapx-00059Q-8J; Tue, 19 Sep 2023 15:32:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapv-007T5D-QF; Tue, 19 Sep 2023 15:32:19 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapv-0030g8-Gz; Tue, 19 Sep 2023 15:32:19 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, Rob Herring <robh@kernel.org>,
        dmaengine@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 41/59] dma: sh: shdmac: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:49 +0200
Message-Id: <20230919133207.1400430-42-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1804; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=rYNJ/hyDPKAyxl8y9sj/oFox4EIyWt191HYFVPvevUo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHe9KOGQPfiseO563h2MdG9z6ZCAA2u69jlM cigCNDjs2WJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmh3gAKCRCPgPtYfRL+ TuyQCAC78KvEpsXczqdfmSjF/eUFE7WN8b/U4QTcCLoWqIWSUC/6suYtJlow2CylcGpEwJ9DF7S RSyEtP65ecUHjRfo3vg1e4QCCjrQ+KQouHVzMaY1c6c46Un1GNMFGSYoGNKonM9cLb9Mh/9fCYC PDXBvfwb8i/MmBcwwDKXBvwVYZurEEty035XDAGmHLad65LDk1eVwWUDRxjuJ/scaejc1tjPgk1 44ONwQC8gCBM/rz+PG1wWoGOfziGM5O1gMsF0D+oXa6uykbcgXPgIVTaOJ4GLlBXnesmhi+M0Y7 SpY+ubbt9dYXjeMYjOOH7m9YvK5q9W6LvY7gGKYRVZ3+GsdS
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
 drivers/dma/sh/shdmac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index 00067b29e232..7cc9eb2217e8 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -882,7 +882,7 @@ static int sh_dmae_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int sh_dmae_remove(struct platform_device *pdev)
+static void sh_dmae_remove(struct platform_device *pdev)
 {
 	struct sh_dmae_device *shdev = platform_get_drvdata(pdev);
 	struct dma_device *dma_dev = &shdev->shdma_dev.dma_dev;
@@ -899,8 +899,6 @@ static int sh_dmae_remove(struct platform_device *pdev)
 	shdma_cleanup(&shdev->shdma_dev);
 
 	synchronize_rcu();
-
-	return 0;
 }
 
 static struct platform_driver sh_dmae_driver = {
@@ -908,7 +906,7 @@ static struct platform_driver sh_dmae_driver = {
 		.pm	= &sh_dmae_pm,
 		.name	= SH_DMAE_DRV_NAME,
 	},
-	.remove		= sh_dmae_remove,
+	.remove_new	= sh_dmae_remove,
 };
 
 static int __init sh_dmae_init(void)
-- 
2.40.1

