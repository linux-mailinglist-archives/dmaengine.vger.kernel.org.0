Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7544C749A88
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jul 2023 13:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjGFLWE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Jul 2023 07:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbjGFLWE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Jul 2023 07:22:04 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 767A51992;
        Thu,  6 Jul 2023 04:22:02 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,185,1684767600"; 
   d="scan'208";a="170841178"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 06 Jul 2023 20:22:01 +0900
Received: from localhost.localdomain (unknown [10.226.93.34])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id E98774007546;
        Thu,  6 Jul 2023 20:21:58 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Hien Huynh <hien.huynh.px@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        stable@kernel.org
Subject: [PATCH v3 2/2] dmaengine: sh: rz-dmac: Fix destination and source data size setting
Date:   Thu,  6 Jul 2023 12:21:50 +0100
Message-Id: <20230706112150.198941-3-biju.das.jz@bp.renesas.com>
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

From: Hien Huynh <hien.huynh.px@renesas.com>

Before setting DDS and SDS values, we need to clear its value first
otherwise, we get incorrect results when we change/update the DMA bus
width several times due to the 'OR' expression.

Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
Cc: stable@kernel.org
Signed-off-by: Hien Huynh <hien.huynh.px@renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * Added bitfield.h header file and replaced CHCFG_FILL_{SDS,DDS}
   macros with FIELD_PREP.
 * Updated commit header 'dma: rz-dmac'->'dmaengine: sh: rz-dmac'.
v1->v2:
 * Updated patch header.
---
 drivers/dma/sh/rz-dmac.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 229f642fde6b..f777addda8ba 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -9,6 +9,7 @@
  * Copyright 2012 Javier Martin, Vista Silicon <javier.martin@vista-silicon.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/interrupt.h>
@@ -145,8 +146,8 @@ struct rz_dmac {
 #define CHCFG_REQD			BIT(3)
 #define CHCFG_SEL(bits)			((bits) & 0x07)
 #define CHCFG_MEM_COPY			(0x80400008)
-#define CHCFG_FILL_DDS(a)		(((a) << 16) & GENMASK(19, 16))
-#define CHCFG_FILL_SDS(a)		(((a) << 12) & GENMASK(15, 12))
+#define CHCFG_FILL_DDS_MASK		GENMASK(19, 16)
+#define CHCFG_FILL_SDS_MASK		GENMASK(15, 12)
 #define CHCFG_FILL_TM(a)		(((a) & BIT(5)) << 22)
 #define CHCFG_FILL_AM(a)		(((a) & GENMASK(4, 2)) << 6)
 #define CHCFG_FILL_LVL(a)		(((a) & BIT(1)) << 5)
@@ -607,13 +608,15 @@ static int rz_dmac_config(struct dma_chan *chan,
 	if (val == CHCFG_DS_INVALID)
 		return -EINVAL;
 
-	channel->chcfg |= CHCFG_FILL_DDS(val);
+	channel->chcfg &= ~CHCFG_FILL_DDS_MASK;
+	channel->chcfg |= FIELD_PREP(CHCFG_FILL_DDS_MASK, val);
 
 	val = rz_dmac_ds_to_val_mapping(config->src_addr_width);
 	if (val == CHCFG_DS_INVALID)
 		return -EINVAL;
 
-	channel->chcfg |= CHCFG_FILL_SDS(val);
+	channel->chcfg &= ~CHCFG_FILL_SDS_MASK;
+	channel->chcfg |= FIELD_PREP(CHCFG_FILL_SDS_MASK, val);
 
 	return 0;
 }
-- 
2.25.1

