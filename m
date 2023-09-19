Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0B87A6521
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjISNcp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 09:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbjISNcg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:32:36 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADE812B
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:32:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapu-0004x8-ON; Tue, 19 Sep 2023 15:32:18 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapt-007T4i-V0; Tue, 19 Sep 2023 15:32:17 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiapt-0030fY-LZ; Tue, 19 Sep 2023 15:32:17 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     ye xingchen <ye.xingchen@zte.com.cn>,
        Rob Herring <robh@kernel.org>, dmaengine@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 32/59] dma: ppc4xx: adma: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 15:31:40 +0200
Message-Id: <20230919133207.1400430-33-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1988; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=nsAdusj5aYvPL6Xrpokl/tz2ob6tdpRyWRuJFliBCS4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCaHT4uwi3P85zWuppooSvKRsZik2GRxgKpGYG JOKpn7S0/WJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQmh0wAKCRCPgPtYfRL+ TsMsB/9Hk5bEfuRf64VGwFE0HBcj5+8MEHjUbu83bihzx2ff4k00YvgU3fS8eumDrqV6lQD6vmB 6oZLyh1qJcIkqkHB3v+cmEQ883jz37ZNZiyJjAo5E1PW7936t7pJRlb+ioLeGkNYi+AnIUampW/ zxpeWDhYhYZwP4CfJ4wMPlumq89lZWo9UFfeIfDZnqh1H2FvrD3qrxkW0qEgJjyE+DXp9w84hRp eJdcxZk2Ae7gUiqfQJ6Fuz5+roDcVZl7tNlrpnUVt+NJekEA8Os5/KrbcYFJ2V0VJjfAPqFt9Bm uf+Bwu6aLOx/bagD2g75HybKFotYvCnHyUxi4UGiwxjJmQV/
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
 drivers/dma/ppc4xx/adma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
index f9b82dff3387..bbb60a970dab 100644
--- a/drivers/dma/ppc4xx/adma.c
+++ b/drivers/dma/ppc4xx/adma.c
@@ -4230,7 +4230,7 @@ static int ppc440spe_adma_probe(struct platform_device *ofdev)
 /**
  * ppc440spe_adma_remove - remove the asynch device
  */
-static int ppc440spe_adma_remove(struct platform_device *ofdev)
+static void ppc440spe_adma_remove(struct platform_device *ofdev)
 {
 	struct ppc440spe_adma_device *adev = platform_get_drvdata(ofdev);
 	struct device_node *np = ofdev->dev.of_node;
@@ -4278,7 +4278,6 @@ static int ppc440spe_adma_remove(struct platform_device *ofdev)
 	of_address_to_resource(np, 0, &res);
 	release_mem_region(res.start, resource_size(&res));
 	kfree(adev);
-	return 0;
 }
 
 /*
@@ -4550,7 +4549,7 @@ MODULE_DEVICE_TABLE(of, ppc440spe_adma_of_match);
 
 static struct platform_driver ppc440spe_adma_driver = {
 	.probe = ppc440spe_adma_probe,
-	.remove = ppc440spe_adma_remove,
+	.remove_new = ppc440spe_adma_remove,
 	.driver = {
 		.name = "PPC440SP(E)-ADMA",
 		.of_match_table = ppc440spe_adma_of_match,
-- 
2.40.1

