Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA7E6DF9E0
	for <lists+dmaengine@lfdr.de>; Wed, 12 Apr 2023 17:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjDLPZC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Apr 2023 11:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjDLPZA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Apr 2023 11:25:00 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C99411A;
        Wed, 12 Apr 2023 08:24:59 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.98,339,1673881200"; 
   d="scan'208";a="159192076"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 13 Apr 2023 00:24:59 +0900
Received: from localhost.localdomain (unknown [10.226.93.18])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 43C654006C9B;
        Thu, 13 Apr 2023 00:24:57 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 4/5] dmaengine: sh: rz-dmac: Trivial code clean-ups
Date:   Wed, 12 Apr 2023 16:24:44 +0100
Message-Id: <20230412152445.117439-5-biju.das.jz@bp.renesas.com>
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

Drop unnecessary lmdesc invalidation in rz_dmac_lmdesc_recycle()
as the lmdesc is already invalidated.

Drop redundant assignment of i to "0" and change the variable
type of "i" to unsigned int to match with the variable type of sg_len
in rz_dmac_prep_slave_sg(). While at it, Remove the braces around
for_each_sg loop as it contains only a single statement.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * Updated commit description.
v2:
 * New patch.
---
 drivers/dma/sh/rz-dmac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 3ef516aee4fc..153893045932 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -253,7 +253,6 @@ static void rz_dmac_lmdesc_recycle(struct rz_dmac_chan *channel)
 	struct rz_lmdesc *lmdesc = channel->lmdesc.head;
 
 	while (!(lmdesc->header & HEADER_LV)) {
-		lmdesc->header = 0;
 		lmdesc++;
 		if (lmdesc >= (channel->lmdesc.base + DMAC_NR_LMDESC))
 			lmdesc = channel->lmdesc.base;
@@ -510,16 +509,15 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	struct rz_dmac_desc *desc;
 	struct scatterlist *sg;
 	int dma_length = 0;
-	int i = 0;
+	unsigned int i;
 
 	if (list_empty(&channel->ld_free))
 		return NULL;
 
 	desc = list_first_entry(&channel->ld_free, struct rz_dmac_desc, node);
 
-	for_each_sg(sgl, sg, sg_len, i) {
+	for_each_sg(sgl, sg, sg_len, i)
 		dma_length += sg_dma_len(sg);
-	}
 
 	desc->type = RZ_DMAC_DESC_SLAVE_SG;
 	desc->sg = sgl;
-- 
2.25.1

