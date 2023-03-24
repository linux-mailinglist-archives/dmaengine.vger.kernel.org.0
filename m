Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA8E6C7BEF
	for <lists+dmaengine@lfdr.de>; Fri, 24 Mar 2023 10:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjCXJuH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Mar 2023 05:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjCXJuG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 24 Mar 2023 05:50:06 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F2198E;
        Fri, 24 Mar 2023 02:50:05 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.98,287,1673881200"; 
   d="scan'208";a="153658932"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 24 Mar 2023 18:50:04 +0900
Received: from localhost.localdomain (unknown [10.226.93.228])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 01379401AEB5;
        Fri, 24 Mar 2023 18:50:02 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/3] dmaengine: sh: rz-dmac: Reinitialize lmdescriptor head
Date:   Fri, 24 Mar 2023 09:49:55 +0000
Message-Id: <20230324094957.115071-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230324094957.115071-1-biju.das.jz@bp.renesas.com>
References: <20230324094957.115071-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Reinitialize link mode descriptor head during terminate_all().
It fixes the incorrect serial messages during serial transfer when
DMA is enabled.

Based on a patch in the BSP by Long Luu
<long.luu.ur@renesas.com>

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 6b62e01ba658..a04a37ce03fd 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -534,11 +534,18 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 static int rz_dmac_terminate_all(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
+	struct rz_lmdesc *lmdesc = channel->lmdesc.base;
 	unsigned long flags;
+	unsigned int i;
+
 	LIST_HEAD(head);
 
 	rz_dmac_disable_hw(channel);
 	spin_lock_irqsave(&channel->vc.lock, flags);
+
+	for (i = 0; i < DMAC_NR_LMDESC; i++)
+		lmdesc[i].header = 0;
+
 	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
 	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
 	spin_unlock_irqrestore(&channel->vc.lock, flags);
-- 
2.25.1

