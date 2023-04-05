Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669C86D7EBC
	for <lists+dmaengine@lfdr.de>; Wed,  5 Apr 2023 16:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238451AbjDEOLB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Apr 2023 10:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238488AbjDEOKm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 Apr 2023 10:10:42 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 685A06A68;
        Wed,  5 Apr 2023 07:10:15 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.98,319,1673881200"; 
   d="scan'208";a="158393613"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Apr 2023 23:09:04 +0900
Received: from localhost.localdomain (unknown [10.226.93.81])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6EB3642D7816;
        Wed,  5 Apr 2023 23:09:02 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 4/5] dmaengine: sh: rz-dmac: Trivial code clean-ups
Date:   Wed,  5 Apr 2023 15:08:41 +0100
Message-Id: <20230405140842.201883-5-biju.das.jz@bp.renesas.com>
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

Some trivial code clean-ups for rz_dmac_lmdesc_recycle() and
rz_dmac_prep_slave_sg().

Drop unnecessary lmdesc invalidation in rz_dmac_lmdesc_recycle()
as the lmdesc is already invalidated.

Drop redundant assignment of i to "0" and change the variable
type of "i" to unsigned int to match with the variable type of sg_len
in rz_dmac_prep_slave_sg(). While at it, Remove the braces around
for_each_sg loop as it has a single statement.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
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

