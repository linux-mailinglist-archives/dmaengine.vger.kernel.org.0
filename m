Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B14257CE15
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jul 2022 16:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiGUOrR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Jul 2022 10:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiGUOrQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Jul 2022 10:47:16 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E10185D56;
        Thu, 21 Jul 2022 07:47:15 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,289,1654527600"; 
   d="scan'208";a="126919801"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Jul 2022 23:47:14 +0900
Received: from localhost.localdomain (unknown [10.226.92.81])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 747B143E4319;
        Thu, 21 Jul 2022 23:47:11 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Colin Ian King <colin.king@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        dmaengine@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3] dmaengine: sh: rz-dmac: Add device_synchronize callback
Date:   Thu, 21 Jul 2022 15:47:08 +0100
Message-Id: <20220721144708.880293-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Some on-chip peripheral modules(for eg:- rspi) on RZ/G2L SoC
use the same signal for both interrupt and DMA transfer requests.
The signal works as a DMA transfer request signal by setting
DMARS, and subsequent interrupt requests to the interrupt controller
are masked.

We can re-enable the interrupt by clearing the DMARS.

This patch adds device_synchronize callback for clearing
DMARS and thereby allowing DMA consumers to switch to
interrupt mode.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * Fixed commit description
 * Added check if the DMA operation has been completed or terminated,
   and wait (sleep) if needed.
v1->v2:
 * No change
---
 drivers/dma/sh/rz-dmac.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index ee2872e7d64c..799a6e670d60 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -12,6 +12,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/interrupt.h>
+#include <linux/iopoll.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -630,6 +631,21 @@ static void rz_dmac_virt_desc_free(struct virt_dma_desc *vd)
 	 */
 }
 
+static void rz_dmac_device_synchronize(struct dma_chan *chan)
+{
+	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
+	struct rz_dmac *dmac = to_rz_dmac(chan->device);
+	u32 chstat;
+	int ret;
+
+	ret = read_poll_timeout(rz_dmac_ch_readl, chstat, !(chstat & CHSTAT_EN),
+				10, 1000, false, channel, CHSTAT, 1);
+	if (ret < 0)
+		dev_warn(dmac->dev, "DMA Timeout");
+
+	rz_dmac_set_dmars_register(dmac, channel->index, 0);
+}
+
 /*
  * -----------------------------------------------------------------------------
  * IRQ handling
@@ -909,6 +925,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	engine->device_config = rz_dmac_config;
 	engine->device_terminate_all = rz_dmac_terminate_all;
 	engine->device_issue_pending = rz_dmac_issue_pending;
+	engine->device_synchronize = rz_dmac_device_synchronize;
 
 	engine->copy_align = DMAENGINE_ALIGN_1_BYTE;
 	dma_set_max_seg_size(engine->dev, U32_MAX);
-- 
2.25.1

