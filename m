Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A984FA9C0
	for <lists+dmaengine@lfdr.de>; Sat,  9 Apr 2022 18:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242773AbiDIQ4C (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 9 Apr 2022 12:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiDIQ4C (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 9 Apr 2022 12:56:02 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DCC526AE06;
        Sat,  9 Apr 2022 09:53:54 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.90,248,1643641200"; 
   d="scan'208";a="117255905"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 10 Apr 2022 01:53:52 +0900
Received: from localhost.localdomain (unknown [10.226.92.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id A1E554005E27;
        Sun, 10 Apr 2022 01:53:50 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Colin Ian King <colin.king@intel.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        dmaengine@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2] dmaengine: sh: rz-dmac: Set DMA transfer parameters based on the direction
Date:   Sat,  9 Apr 2022 17:53:48 +0100
Message-Id: <20220409165348.46080-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Client drivers configure DMA transfer parameters based on the DMA
transfer direction.

This patch sets corresponding parameters in rz_dmac_config() based
on the DMA transfer direction.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
 * Updated commit description
---
 drivers/dma/sh/rz-dmac.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index ee2872e7d64c..de57ae006879 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -597,24 +597,24 @@ static int rz_dmac_config(struct dma_chan *chan,
 			  struct dma_slave_config *config)
 {
 	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
-	u32 val;
+	u32 val, data_sz;
 
-	channel->src_per_address = config->src_addr;
-	channel->src_word_size = config->src_addr_width;
-	channel->dst_per_address = config->dst_addr;
-	channel->dst_word_size = config->dst_addr_width;
-
-	val = rz_dmac_ds_to_val_mapping(config->dst_addr_width);
-	if (val == CHCFG_DS_INVALID)
-		return -EINVAL;
-
-	channel->chcfg |= CHCFG_FILL_DDS(val);
+	if (config->direction == DMA_DEV_TO_MEM) {
+		channel->src_per_address = config->src_addr;
+		channel->src_word_size = config->src_addr_width;
+		val = rz_dmac_ds_to_val_mapping(config->src_addr_width);
+		data_sz = CHCFG_FILL_SDS(val);
+	} else {
+		channel->dst_per_address = config->dst_addr;
+		channel->dst_word_size = config->dst_addr_width;
+		val = rz_dmac_ds_to_val_mapping(config->dst_addr_width);
+		data_sz = CHCFG_FILL_DDS(val);
+	}
 
-	val = rz_dmac_ds_to_val_mapping(config->src_addr_width);
 	if (val == CHCFG_DS_INVALID)
 		return -EINVAL;
 
-	channel->chcfg |= CHCFG_FILL_SDS(val);
+	channel->chcfg |= data_sz;
 
 	return 0;
 }
-- 
2.25.1

