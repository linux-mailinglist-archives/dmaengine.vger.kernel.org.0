Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FEA743F8E
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jun 2023 18:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjF3QRs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 30 Jun 2023 12:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbjF3QR2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 30 Jun 2023 12:17:28 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDBA63C05;
        Fri, 30 Jun 2023 09:17:25 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,171,1684767600"; 
   d="scan'208";a="169868091"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Jul 2023 01:17:24 +0900
Received: from localhost.localdomain (unknown [10.226.93.15])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 000FF4015EE4;
        Sat,  1 Jul 2023 01:17:21 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hien Huynh <hien.huynh.px@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Pavel Machek <pavel@denx.de>
Subject: [PATCH v2 1/2] dmaengine: sh: rz-dmac: Improve cleanup order in probe()/remove()
Date:   Fri, 30 Jun 2023 17:17:15 +0100
Message-Id: <20230630161716.586552-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630161716.586552-1-biju.das.jz@bp.renesas.com>
References: <20230630161716.586552-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

We usually do cleanup in reverse order of init. Currently, in the
case of error, this is not followed in rz_dmac_probe(), and similar
case for remove().

This patch improves error handling in probe() and cleanup in
reverse order of init in the remove().

Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Fixed typo in patch header
 * Updated patch description.
---
 drivers/dma/sh/rz-dmac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 9479f29692d3..229f642fde6b 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -947,7 +947,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
 dma_register_err:
 	of_dma_controller_free(pdev->dev.of_node);
 err:
-	reset_control_assert(dmac->rstc);
 	channel_num = i ? i - 1 : 0;
 	for (i = 0; i < channel_num; i++) {
 		struct rz_dmac_chan *channel = &dmac->channels[i];
@@ -958,6 +957,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 				  channel->lmdesc.base_dma);
 	}
 
+	reset_control_assert(dmac->rstc);
 err_pm_runtime_put:
 	pm_runtime_put(&pdev->dev);
 err_pm_disable:
@@ -971,6 +971,8 @@ static int rz_dmac_remove(struct platform_device *pdev)
 	struct rz_dmac *dmac = platform_get_drvdata(pdev);
 	unsigned int i;
 
+	dma_async_device_unregister(&dmac->engine);
+	of_dma_controller_free(pdev->dev.of_node);
 	for (i = 0; i < dmac->n_channels; i++) {
 		struct rz_dmac_chan *channel = &dmac->channels[i];
 
@@ -979,8 +981,6 @@ static int rz_dmac_remove(struct platform_device *pdev)
 				  channel->lmdesc.base,
 				  channel->lmdesc.base_dma);
 	}
-	of_dma_controller_free(pdev->dev.of_node);
-	dma_async_device_unregister(&dmac->engine);
 	reset_control_assert(dmac->rstc);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.25.1

