Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA3F57D4EE
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jul 2022 22:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbiGUUln (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Jul 2022 16:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbiGUUlh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Jul 2022 16:41:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B728F523
        for <dmaengine@vger.kernel.org>; Thu, 21 Jul 2022 13:41:34 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oEczC-0007IS-4I; Thu, 21 Jul 2022 22:41:30 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oEczB-002Nlr-2n; Thu, 21 Jul 2022 22:41:29 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oEczA-006et5-Cg; Thu, 21 Jul 2022 22:41:28 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     dmaengine@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] dmaengine: sprd: Cleanup in .remove() after pm_runtime_get_sync() failed
Date:   Thu, 21 Jul 2022 22:40:54 +0200
Message-Id: <20220721204054.323602-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1164; h=from:subject; bh=8OOSRHptsgr+PxYpeULT7zbnXLuwE7vq2iVr7EWS09A=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi2bnRt8Sk72T3JrO6m/rMNAKFB4d7IDkDH27ysLFj QdHy6CmJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYtm50QAKCRDB/BR4rcrsCSf7B/ sFYAlfjSf6pKh/AwYq7++BMQvdHhm0yhgDOi4FDf/idjHebQoOzucqhHwZRSob+Zxf8c0k3vahVa1y AkxwSD8VpudyUBrP6CvcMMvIV92Dd/FztFtsZe83dsfoBVoRmmYTJHG9UtdpFqb698LQXERraEkeQ9 NzTAbifbq6U7gjSHhy71lHnTgNHoAFvNE6s6T129fwhsrgIQbz7NspxAV+n+0LZtMfnBcx4Pj6dfPA Tjy9i2DaaLuyRqHszX3kDDN+SuR/Nb/scXYUjusUN2Cr8qw49qu0wajBQDOffK+ZuUiow08hC8IWoO m3ztIN2W5LJ7ea2x/rCXsFH8NtdIxJ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It's not allowed to quit remove early without cleaning up completely.
Otherwise this results in resource leaks that probably yield graver
problems later. Here for example some tasklets might survive the lifetime
of the sprd-dma device and access sdev which is freed after .remove()
returns.

As none of the device freeing requires an active device, just ignore the
return value of pm_runtime_get_sync().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/dma/sprd-dma.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 2138b80435ab..474d3ba8ec9f 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -1237,11 +1237,8 @@ static int sprd_dma_remove(struct platform_device *pdev)
 {
 	struct sprd_dma_dev *sdev = platform_get_drvdata(pdev);
 	struct sprd_dma_chn *c, *cn;
-	int ret;
 
-	ret = pm_runtime_get_sync(&pdev->dev);
-	if (ret < 0)
-		return ret;
+	pm_runtime_get_sync(&pdev->dev);
 
 	/* explicitly free the irq */
 	if (sdev->irq > 0)

base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.36.1

