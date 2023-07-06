Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D1B749A86
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jul 2023 13:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjGFLWA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Jul 2023 07:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjGFLV7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Jul 2023 07:21:59 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96E2A1727;
        Thu,  6 Jul 2023 04:21:58 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,185,1684767600"; 
   d="scan'208";a="167207538"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 06 Jul 2023 20:21:58 +0900
Received: from localhost.localdomain (unknown [10.226.93.34])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9B8A54007546;
        Thu,  6 Jul 2023 20:21:55 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hien Huynh <hien.huynh.px@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Pavel Machek <pavel@denx.de>
Subject: [PATCH v3 1/2] dmaengine: sh: rz-dmac: Improve cleanup order in probe()/remove()
Date:   Thu,  6 Jul 2023 12:21:49 +0100
Message-Id: <20230706112150.198941-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230706112150.198941-1-biju.das.jz@bp.renesas.com>
References: <20230706112150.198941-1-biju.das.jz@bp.renesas.com>
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
v2->v3:
 No change.
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

