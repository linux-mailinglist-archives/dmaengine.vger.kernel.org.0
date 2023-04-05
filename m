Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632A56D7EC1
	for <lists+dmaengine@lfdr.de>; Wed,  5 Apr 2023 16:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238509AbjDEOLL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Apr 2023 10:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238504AbjDEOKq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 Apr 2023 10:10:46 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CE8CC5;
        Wed,  5 Apr 2023 07:10:18 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.98,319,1673881200"; 
   d="scan'208";a="158393620"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Apr 2023 23:09:06 +0900
Received: from localhost.localdomain (unknown [10.226.93.81])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id EACF242D8EF2;
        Wed,  5 Apr 2023 23:09:04 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 5/5] dmaengine: sh: rz-dmac: rz_dmac_prepare_descs_for_slave_sg() improvements
Date:   Wed,  5 Apr 2023 15:08:42 +0100
Message-Id: <20230405140842.201883-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230405140842.201883-1-biju.das.jz@bp.renesas.com>
References: <20230405140842.201883-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Some code improvements for rz_dmac_prepare_descs_for_slave_sg().

Replace the loop for->for_each_sg and drop the variables sgl and sg_len.
Also improve the logic for assigning lmdesc->chcfg and lmdesc->header and
lastly, add lmdesc assignment along with the declaration.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2:
 * New patch.
---
 drivers/dma/sh/rz-dmac.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 153893045932..c6150d7ae8a7 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -342,12 +342,12 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan *channel)
 
 static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
 {
+	struct rz_lmdesc *lmdesc = channel->lmdesc.tail;
 	struct dma_chan *chan = &channel->vc.chan;
 	struct rz_dmac *dmac = to_rz_dmac(chan->device);
 	struct rz_dmac_desc *d = channel->desc;
-	struct scatterlist *sg, *sgl = d->sg;
-	struct rz_lmdesc *lmdesc;
-	unsigned int i, sg_len = d->sgcount;
+	struct scatterlist *sg;
+	unsigned int i;
 
 	channel->chcfg |= CHCFG_SEL(channel->index) | CHCFG_DEM | CHCFG_DMS;
 
@@ -358,9 +358,7 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
 		channel->chcfg |= CHCFG_DAD | CHCFG_REQD;
 	}
 
-	lmdesc = channel->lmdesc.tail;
-
-	for (i = 0, sg = sgl; i < sg_len; i++, sg = sg_next(sg)) {
+	for_each_sg(d->sg, sg, d->sgcount, i) {
 		if (d->direction == DMA_DEV_TO_MEM) {
 			lmdesc->sa = channel->src_per_address;
 			lmdesc->da = sg_dma_address(sg);
@@ -372,13 +370,11 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
 		lmdesc->tb = sg_dma_len(sg);
 		lmdesc->chitvl = 0;
 		lmdesc->chext = 0;
-		if (i == (sg_len - 1)) {
-			lmdesc->chcfg = (channel->chcfg & ~CHCFG_DEM);
-			lmdesc->header = HEADER_LV;
-		} else {
-			lmdesc->chcfg = channel->chcfg;
-			lmdesc->header = HEADER_LV;
-		}
+		lmdesc->chcfg = channel->chcfg;
+		lmdesc->header = HEADER_LV;
+		if (i == (d->sgcount - 1))
+			lmdesc->chcfg &= ~CHCFG_DEM;
+
 		if (++lmdesc >= (channel->lmdesc.base + DMAC_NR_LMDESC))
 			lmdesc = channel->lmdesc.base;
 	}
-- 
2.25.1

