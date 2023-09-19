Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A941D7A6530
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbjISNcv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbjISNcl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:41 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E956118
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:35 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiaq1-0005R1-ET; Tue, 19 Sep 2023 15:32:25 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapz-007T69-Mk; Tue, 19 Sep 2023 15:32:23 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapz-0030h5-Bg; Tue, 19 Sep 2023 15:32:23 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>,
        Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
        Michal Simek <michal.simek@amd.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 56/59] dma: xilinx: xdma: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:32:04 +0200
Message-Id: <20230919133207.1400430-57-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1788; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=sC1e8XJTChK1hqfmNfjLBa8n8F4EYU6xG4pax8b38go=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHwutEfREUe+TsY3JOTt/GOI6T83oxZ7vSZH Pq4RcG7cyCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmh8AAKCRCPgPtYfRL+ TvAhB/9X9uyZRMV7OGmuYpdyBbRooeXKE8CmA9szakE9VnNPpZQWkm4g8yBlydZxxXExzFZKA+p jbNHOKB70fkr3qu8rXIKWMOqf5TA2JnOMOoZVfeuc6mmqWOfDAF4gguzmq+StFCMqb/vQ7wTy99 +jTswJaOol+nlRNum9RVXqVbg9e27FZzgJJgzwdLmCdpL9ASIHdHIokTuYpW0VTcy/zpvenbiQW tNdOlisK5Sa1XAyXs4utVX9zxBAqgHfWrmstNkS9mdDZdR7Jno1M/r1PXmWTvssrp3qcM4akhZV YxVARj6SD7EO+rPqgka4dECLa5ae/4+US8aaeToOEuTAWFgT
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
 drivers/dma/xilinx/xdma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index e0bfd129d563..459e7b9838ed 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -841,7 +841,7 @@ EXPORT_SYMBOL(xdma_get_user_irq);
  * xdma_remove - Driver remove function
  * @pdev: Pointer to the platform_device structure
  */
-static int xdma_remove(struct platform_device *pdev)
+static void xdma_remove(struct platform_device *pdev)
 {
 	struct xdma_device *xdev = platform_get_drvdata(pdev);
 
@@ -850,8 +850,6 @@ static int xdma_remove(struct platform_device *pdev)
 
 	if (xdev->status & XDMA_DEV_STATUS_REG_DMA)
 		dma_async_device_unregister(&xdev->dma_dev);
-
-	return 0;
 }
 
 /**
@@ -966,7 +964,7 @@ static struct platform_driver xdma_driver = {
 	},
 	.id_table	= xdma_id_table,
 	.probe		= xdma_probe,
-	.remove		= xdma_remove,
+	.remove_new	= xdma_remove,
 };
 
 module_platform_driver(xdma_driver);
-- 
2.40.1

