Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690096DF9DD
	for <lists+dmaengine@lfdr.de>; Wed, 12 Apr 2023 17:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjDLPZC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Apr 2023 11:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbjDLPY6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Apr 2023 11:24:58 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2D05FA;
        Wed, 12 Apr 2023 08:24:56 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.98,339,1673881200"; 
   d="scan'208";a="155741524"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 13 Apr 2023 00:24:56 +0900
Received: from localhost.localdomain (unknown [10.226.93.18])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id C18FE4006C6E;
        Thu, 13 Apr 2023 00:24:54 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 3/5] dmaengine: sh: rz-dmac: Add device_{pause,resume}() callbacks
Date:   Wed, 12 Apr 2023 16:24:43 +0100
Message-Id: <20230412152445.117439-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230412152445.117439-1-biju.das.jz@bp.renesas.com>
References: <20230412152445.117439-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for device_{pause, resume}() callbacks as it is needed
for RZ/G2L SCIFA driver.

Based on a patch in the BSP by Long Luu
<long.luu.ur@renesas.com>

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * No change.
v1->v2:
 * Added resume callback()
 * Updated commit description.
---
 drivers/dma/sh/rz-dmac.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index aaaae1c090ad..3ef516aee4fc 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -817,6 +817,35 @@ static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
 	return status;
 }
 
+static int rz_dmac_device_pause(struct dma_chan *chan)
+{
+	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
+	struct rz_dmac *dmac = to_rz_dmac(chan->device);
+	unsigned int i;
+	u32 chstat;
+
+	for (i = 0; i < 1024; i++) {
+		chstat = rz_dmac_ch_readl(channel, CHSTAT, 1);
+		if (!(chstat & CHSTAT_EN))
+			break;
+		udelay(1);
+	}
+
+	rz_dmac_set_dmars_register(dmac, channel->index, 0);
+
+	return 0;
+}
+
+static int rz_dmac_device_resume(struct dma_chan *chan)
+{
+	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
+	struct rz_dmac *dmac = to_rz_dmac(chan->device);
+
+	rz_dmac_set_dmars_register(dmac, channel->index, channel->mid_rid);
+
+	return 0;
+}
+
 /*
  * -----------------------------------------------------------------------------
  * IRQ handling
@@ -1106,6 +1135,8 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	engine->device_terminate_all = rz_dmac_terminate_all;
 	engine->device_issue_pending = rz_dmac_issue_pending;
 	engine->device_synchronize = rz_dmac_device_synchronize;
+	engine->device_pause = rz_dmac_device_pause;
+	engine->device_resume = rz_dmac_device_resume;
 
 	engine->copy_align = DMAENGINE_ALIGN_1_BYTE;
 	dma_set_max_seg_size(engine->dev, U32_MAX);
-- 
2.25.1

