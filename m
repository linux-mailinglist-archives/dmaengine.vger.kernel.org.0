Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67C8743F22
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jun 2023 17:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjF3PpB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 30 Jun 2023 11:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbjF3Pov (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 30 Jun 2023 11:44:51 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E27CF35B0;
        Fri, 30 Jun 2023 08:44:50 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,171,1684767600"; 
   d="scan'208";a="166243613"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Jul 2023 00:44:50 +0900
Received: from localhost.localdomain (unknown [10.226.93.15])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id F2343400AFB5;
        Sat,  1 Jul 2023 00:44:47 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Hien Huynh <hien.huynh.px@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH 2/2] dma: rz-dmac: Fix Destination and Source Data Size setting
Date:   Fri, 30 Jun 2023 16:44:38 +0100
Message-Id: <20230630154438.584066-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630154438.584066-1-biju.das.jz@bp.renesas.com>
References: <20230630154438.584066-1-biju.das.jz@bp.renesas.com>
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
Signed-off-by: Hien Huynh <hien.huynh.px@renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 229f642fde6b..331ea80f21b0 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -145,8 +145,10 @@ struct rz_dmac {
 #define CHCFG_REQD			BIT(3)
 #define CHCFG_SEL(bits)			((bits) & 0x07)
 #define CHCFG_MEM_COPY			(0x80400008)
-#define CHCFG_FILL_DDS(a)		(((a) << 16) & GENMASK(19, 16))
-#define CHCFG_FILL_SDS(a)		(((a) << 12) & GENMASK(15, 12))
+#define CHCFG_FILL_DDS_MASK		GENMASK(19, 16)
+#define CHCFG_FILL_DDS(a)		(((a) << 16) & CHCFG_FILL_DDS_MASK)
+#define CHCFG_FILL_SDS_MASK		GENMASK(15, 12)
+#define CHCFG_FILL_SDS(a)		(((a) << 12) & CHCFG_FILL_SDS_MASK)
 #define CHCFG_FILL_TM(a)		(((a) & BIT(5)) << 22)
 #define CHCFG_FILL_AM(a)		(((a) & GENMASK(4, 2)) << 6)
 #define CHCFG_FILL_LVL(a)		(((a) & BIT(1)) << 5)
@@ -607,12 +609,14 @@ static int rz_dmac_config(struct dma_chan *chan,
 	if (val == CHCFG_DS_INVALID)
 		return -EINVAL;
 
+	channel->chcfg &= ~CHCFG_FILL_DDS_MASK;
 	channel->chcfg |= CHCFG_FILL_DDS(val);
 
 	val = rz_dmac_ds_to_val_mapping(config->src_addr_width);
 	if (val == CHCFG_DS_INVALID)
 		return -EINVAL;
 
+	channel->chcfg &= ~CHCFG_FILL_SDS_MASK;
 	channel->chcfg |= CHCFG_FILL_SDS(val);
 
 	return 0;
-- 
2.25.1

