Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2676DF9D7
	for <lists+dmaengine@lfdr.de>; Wed, 12 Apr 2023 17:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjDLPZA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Apr 2023 11:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjDLPYy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Apr 2023 11:24:54 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B7C7E8;
        Wed, 12 Apr 2023 08:24:52 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.98,339,1673881200"; 
   d="scan'208";a="155741520"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 13 Apr 2023 00:24:51 +0900
Received: from localhost.localdomain (unknown [10.226.93.18])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id BF3144006C6E;
        Thu, 13 Apr 2023 00:24:49 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 1/5] dmaengine: sh: rz-dmac: Add rz_dmac_invalidate_lmdesc()
Date:   Wed, 12 Apr 2023 16:24:41 +0100
Message-Id: <20230412152445.117439-2-biju.das.jz@bp.renesas.com>
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

rz_dmac_terminate_all() must invalidate lmdescriptor in order to
reuse the hardware descriptors in rz_dmac_lmdesc_recycle().

Add rz_dmac_invalidate_lmdesc() so that the same code can be shared
between rz_dmac_terminate_all() and rz_dmac_free_chan_resources().

Based on a patch in the BSP by Long Luu
<long.luu.ur@renesas.com>

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * No change.
v1->v2:
 * Introduced rz_dmac_invalidate_lmdesc(), so that same code is shared
   between rz_dmac_free_chan_resources() and rz_dmac_terminate_all()
   for invalidating hardware descriptors.
 * updated commit description.
---
 drivers/dma/sh/rz-dmac.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 9479f29692d3..81e72529f7d3 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -236,6 +236,16 @@ static void rz_lmdesc_setup(struct rz_dmac_chan *channel,
  * Descriptors preparation
  */
 
+static void rz_dmac_invalidate_lmdesc(struct rz_dmac_chan *channel)
+{
+	struct rz_lmdesc *lmdesc = channel->lmdesc.base;
+
+	for (; lmdesc < channel->lmdesc.base + DMAC_NR_LMDESC; lmdesc++) {
+		if (lmdesc->header)
+			lmdesc->header = 0;
+	}
+}
+
 static void rz_dmac_lmdesc_recycle(struct rz_dmac_chan *channel)
 {
 	struct rz_lmdesc *lmdesc = channel->lmdesc.head;
@@ -437,16 +447,11 @@ static void rz_dmac_free_chan_resources(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
 	struct rz_dmac *dmac = to_rz_dmac(chan->device);
-	struct rz_lmdesc *lmdesc = channel->lmdesc.base;
 	struct rz_dmac_desc *desc, *_desc;
 	unsigned long flags;
-	unsigned int i;
 
 	spin_lock_irqsave(&channel->vc.lock, flags);
-
-	for (i = 0; i < DMAC_NR_LMDESC; i++)
-		lmdesc[i].header = 0;
-
+	rz_dmac_invalidate_lmdesc(channel);
 	rz_dmac_disable_hw(channel);
 	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
 	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
@@ -537,6 +542,7 @@ static int rz_dmac_terminate_all(struct dma_chan *chan)
 
 	rz_dmac_disable_hw(channel);
 	spin_lock_irqsave(&channel->vc.lock, flags);
+	rz_dmac_invalidate_lmdesc(channel);
 	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
 	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
 	spin_unlock_irqrestore(&channel->vc.lock, flags);
-- 
2.25.1

