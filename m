Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561B87A64F8
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbjISNc0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjISNcY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:24 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D12FB
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapp-0004dB-9P; Tue, 19 Sep 2023 15:32:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapo-007T3E-Sw; Tue, 19 Sep 2023 15:32:12 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapo-0030e7-Jl; Tue, 19 Sep 2023 15:32:12 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        dmaengine@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 10/59] dma: dw-axi-dmac: dw-axi-dmac-platform: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:18 +0200
Message-Id: <20230919133207.1400430-11-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1940; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=s+4I0CINDG+YzTzb0V5LWp1CEqKdvqZLk5TrxYwFYCA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaG5W9Gd+fS9FdSY+DXQgCA0oQrYlwLVSuzq+ v9/Xp25t1KJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmhuQAKCRCPgPtYfRL+ TlfQB/9QLZmCt9ZIxv9qnEknVf91DVqzqF6zwUsyyF5Bl4Vgoj9dRsTaj+5MY4Q4NwC+cQaviZ4 VV1ujnQd4FKsubSwSzsif0L2J3THwQXyDhpptJX4McEz1X+pmM3pFcKYIEidnEyi+FXmI1fM0D3 EaAwnoIvAy07DOx5j+Es8IhUjylgmtnMshmZQo6aIf6o9Mf6nSAbRGReLM0IeADJ8nx/EtNuNxd zveMnlG3JhFY6JLDpmTQzg8lkSW68Q89LUOBqTNSODGm+FYFKmQHWEi3S2Bg5V0WWIQ0rqKg6Tb 2C6mmQW7d8BXh1l491eBkGBGLOlmZGwVdjEXV4CKODiOB+jw
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
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index dd02f84e404d..974da2fda2e4 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1535,7 +1535,7 @@ static int dw_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int dw_remove(struct platform_device *pdev)
+static void dw_remove(struct platform_device *pdev)
 {
 	struct axi_dma_chip *chip = platform_get_drvdata(pdev);
 	struct dw_axi_dma *dw = chip->dw;
@@ -1564,8 +1564,6 @@ static int dw_remove(struct platform_device *pdev)
 		list_del(&chan->vc.chan.device_node);
 		tasklet_kill(&chan->vc.task);
 	}
-
-	return 0;
 }
 
 static const struct dev_pm_ops dw_axi_dma_pm_ops = {
@@ -1588,7 +1586,7 @@ MODULE_DEVICE_TABLE(of, dw_dma_of_id_table);
 
 static struct platform_driver dw_driver = {
 	.probe		= dw_probe,
-	.remove		= dw_remove,
+	.remove_new	= dw_remove,
 	.driver = {
 		.name	= KBUILD_MODNAME,
 		.of_match_table = dw_dma_of_id_table,
-- 
2.40.1

