Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4197F7A651A
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbjISNcl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbjISNcf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:35 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A76123
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapx-0005DK-Mg; Tue, 19 Sep 2023 15:32:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapw-007T5O-GB; Tue, 19 Sep 2023 15:32:20 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapw-0030gJ-3c; Tue, 19 Sep 2023 15:32:20 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 44/59] dma: st_fdma: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:52 +0200
Message-Id: <20230919133207.1400430-45-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1770; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=mLxlKUjXeKKBwDxG0klsa06EXs5EvAdx6DPXjRAOFo8=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlTOhQ+3XBPzVvMp9a/6r2U14bZXaPbxlIRfYU+v10RNr WJ/Wx3VyWjMwsDIxSArpshi37gm06pKLrJz7b/LMINYmUCmMHBxCsBELk7jYJgqk1IfuFynLUG4 htXt3gqV4OUv9ym8WjB3S/OT68JzI3ONP3y6nRqzw4Sd25Tv7Le9kS5vr5SqPItVKZ7Am9/8JDd r7t3oq5osktamxw6mPs25b69+aFnARO0fEuJs/4+pPAhx6/kTe6iuaIL9le06Vj55u/Xi56/37/ dJm7bg/P18yS0H3VQk1jXa/bMo9A1VWxpvoqlaNi2xon4m/97ixh3cNjOs7sU4l6V5vloU84Z9Y uTe2X4+E/gFPxlt/9vNobDurd+zGXcZVXXmnDQ3uN32cklWgmL96uo1zAxnJgjk3ZdVL5n1SCY1 OJFBszy18C772aLMuhY96XkLOK+/7LrKvThf0epG/cv/AA==
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
 drivers/dma/st_fdma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
index d95c421877fb..145bd0f2496e 100644
--- a/drivers/dma/st_fdma.c
+++ b/drivers/dma/st_fdma.c
@@ -849,15 +849,13 @@ static int st_fdma_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int st_fdma_remove(struct platform_device *pdev)
+static void st_fdma_remove(struct platform_device *pdev)
 {
 	struct st_fdma_dev *fdev = platform_get_drvdata(pdev);
 
 	devm_free_irq(&pdev->dev, fdev->irq, fdev);
 	st_slim_rproc_put(fdev->slim_rproc);
 	of_dma_controller_free(pdev->dev.of_node);
-
-	return 0;
 }
 
 static struct platform_driver st_fdma_platform_driver = {
@@ -866,7 +864,7 @@ static struct platform_driver st_fdma_platform_driver = {
 		.of_match_table = st_fdma_match,
 	},
 	.probe = st_fdma_probe,
-	.remove = st_fdma_remove,
+	.remove_new = st_fdma_remove,
 };
 module_platform_driver(st_fdma_platform_driver);
 
-- 
2.40.1

