Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A52771953
	for <lists+dmaengine@lfdr.de>; Mon,  7 Aug 2023 07:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjHGFU7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Aug 2023 01:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjHGFU6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Aug 2023 01:20:58 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2877E1980;
        Sun,  6 Aug 2023 22:20:52 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 3775KXHs020781;
        Mon, 7 Aug 2023 13:20:33 +0800 (+08)
        (envelope-from Kaiwei.Liu@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx07.spreadtrum.com [10.0.1.12])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RK4Nd2Gbjz2K1r9q;
        Mon,  7 Aug 2023 13:18:41 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx07.spreadtrum.com
 (10.0.1.12) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Mon, 7 Aug 2023
 13:20:31 +0800
From:   Kaiwei Liu <kaiwei.liu@unisoc.com>
To:     Vinod Koul <vkoul@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        kaiwei liu <liukaiwei086@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
Subject: [PATCH 3/5] dma: optimize two stage transfer function
Date:   Mon, 7 Aug 2023 13:20:28 +0800
Message-ID: <20230807052028.2854-1-kaiwei.liu@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx07.spreadtrum.com (10.0.1.12)
X-MAIL: SHSQR01.spreadtrum.com 3775KXHs020781
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The DMA hardware is updated to optimize two stages transmission
function, so modify relative register and logic. Two
stages transmission mode of dma allows one channel finished
transmission then start another channel transfer automatically.

Signed-off-by: Kaiwei Liu <kaiwei.liu@unisoc.com>
---
 drivers/dma/sprd-dma.c | 124 ++++++++++++++++++++++++++++++-----------
 1 file changed, 91 insertions(+), 33 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 0e146550dfbb..01053e106e8a 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -68,6 +68,7 @@
 #define SPRD_DMA_GLB_TRANS_DONE_TRG	BIT(18)
 #define SPRD_DMA_GLB_BLOCK_DONE_TRG	BIT(17)
 #define SPRD_DMA_GLB_FRAG_DONE_TRG	BIT(16)
+#define SPRD_DMA_GLB_TRG_MASK		GENMASK(19, 16)
 #define SPRD_DMA_GLB_TRG_OFFSET		16
 #define SPRD_DMA_GLB_DEST_CHN_MASK	GENMASK(13, 8)
 #define SPRD_DMA_GLB_DEST_CHN_OFFSET	8
@@ -155,6 +156,13 @@
 
 #define SPRD_DMA_SOFTWARE_UID		0
 
+#define SPRD_DMA_SRC_CHN0_INT		9
+#define SPRD_DMA_SRC_CHN1_INT		10
+#define SPRD_DMA_DST_CHN0_INT		11
+#define SPRD_DMA_DST_CHN1_INT		12
+#define SPRD_DMA_2STAGE_SET		1
+#define SPRD_DMA_2STAGE_CLEAR		0
+
 /* dma data width values */
 enum sprd_dma_datawidth {
 	SPRD_DMA_DATAWIDTH_1_BYTE,
@@ -212,7 +220,7 @@ struct sprd_dma_dev {
 	struct clk		*ashb_clk;
 	int			irq;
 	u32			total_chns;
-	struct sprd_dma_chn	channels[];
+	struct sprd_dma_chn	channels[0];
 };
 
 static void sprd_dma_free_desc(struct virt_dma_desc *vd);
@@ -431,50 +439,90 @@ static enum sprd_dma_req_mode sprd_dma_get_req_type(struct sprd_dma_chn *schan)
 	return (frag_reg >> SPRD_DMA_REQ_MODE_OFFSET) & SPRD_DMA_REQ_MODE_MASK;
 }
 
-static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
+static int sprd_dma_2stage_config(struct sprd_dma_chn *schan, u32 config_type)
 {
 	struct sprd_dma_dev *sdev = to_sprd_dma_dev(&schan->vc.chan);
 	u32 val, chn = schan->chn_num + 1;
 
 	switch (schan->chn_mode) {
 	case SPRD_DMA_SRC_CHN0:
-		val = chn & SPRD_DMA_GLB_SRC_CHN_MASK;
-		val |= BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFFSET;
-		val |= SPRD_DMA_GLB_2STAGE_EN;
-		if (schan->int_type != SPRD_DMA_NO_INT)
-			val |= SPRD_DMA_GLB_SRC_INT;
-
-		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1, val, val);
+		if (config_type == SPRD_DMA_2STAGE_SET) {
+			val = chn & SPRD_DMA_GLB_SRC_CHN_MASK;
+			val |= BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFFSET;
+			val |= SPRD_DMA_GLB_2STAGE_EN;
+			if (schan->int_type & SPRD_DMA_SRC_CHN0_INT)
+				val |= SPRD_DMA_GLB_SRC_INT;
+
+			sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1,
+					    SPRD_DMA_GLB_SRC_INT |
+					    SPRD_DMA_GLB_TRG_MASK |
+					    SPRD_DMA_GLB_SRC_CHN_MASK, val);
+		} else {
+			sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1,
+					    SPRD_DMA_GLB_SRC_INT |
+					    SPRD_DMA_GLB_TRG_MASK |
+					    SPRD_DMA_GLB_2STAGE_EN |
+					    SPRD_DMA_GLB_SRC_CHN_MASK, 0);
+		}
 		break;
 
 	case SPRD_DMA_SRC_CHN1:
-		val = chn & SPRD_DMA_GLB_SRC_CHN_MASK;
-		val |= BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFFSET;
-		val |= SPRD_DMA_GLB_2STAGE_EN;
-		if (schan->int_type != SPRD_DMA_NO_INT)
-			val |= SPRD_DMA_GLB_SRC_INT;
-
-		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2, val, val);
+		if (config_type == SPRD_DMA_2STAGE_SET) {
+			val = chn & SPRD_DMA_GLB_SRC_CHN_MASK;
+			val |= BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFFSET;
+			val |= SPRD_DMA_GLB_2STAGE_EN;
+			if (schan->int_type & SPRD_DMA_SRC_CHN1_INT)
+				val |= SPRD_DMA_GLB_SRC_INT;
+
+			sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2,
+					    SPRD_DMA_GLB_SRC_INT |
+					    SPRD_DMA_GLB_TRG_MASK |
+					    SPRD_DMA_GLB_SRC_CHN_MASK, val);
+		} else {
+			sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2,
+					    SPRD_DMA_GLB_SRC_INT |
+					    SPRD_DMA_GLB_TRG_MASK |
+					    SPRD_DMA_GLB_2STAGE_EN |
+					    SPRD_DMA_GLB_SRC_CHN_MASK, 0);
+		}
 		break;
 
 	case SPRD_DMA_DST_CHN0:
-		val = (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
-			SPRD_DMA_GLB_DEST_CHN_MASK;
-		val |= SPRD_DMA_GLB_2STAGE_EN;
-		if (schan->int_type != SPRD_DMA_NO_INT)
-			val |= SPRD_DMA_GLB_DEST_INT;
-
-		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1, val, val);
+		if (config_type == SPRD_DMA_2STAGE_SET) {
+			val = (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
+				SPRD_DMA_GLB_DEST_CHN_MASK;
+			val |= SPRD_DMA_GLB_2STAGE_EN;
+			if (schan->int_type & SPRD_DMA_DST_CHN0_INT)
+				val |= SPRD_DMA_GLB_DEST_INT;
+
+			sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1,
+					    SPRD_DMA_GLB_DEST_INT |
+					    SPRD_DMA_GLB_DEST_CHN_MASK, val);
+		} else {
+			sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1,
+					    SPRD_DMA_GLB_DEST_INT |
+					    SPRD_DMA_GLB_2STAGE_EN |
+					    SPRD_DMA_GLB_DEST_CHN_MASK, 0);
+		}
 		break;
 
 	case SPRD_DMA_DST_CHN1:
-		val = (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
-			SPRD_DMA_GLB_DEST_CHN_MASK;
-		val |= SPRD_DMA_GLB_2STAGE_EN;
-		if (schan->int_type != SPRD_DMA_NO_INT)
-			val |= SPRD_DMA_GLB_DEST_INT;
-
-		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2, val, val);
+		if (config_type == SPRD_DMA_2STAGE_SET) {
+			val = (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
+				SPRD_DMA_GLB_DEST_CHN_MASK;
+			val |= SPRD_DMA_GLB_2STAGE_EN;
+			if (schan->int_type & SPRD_DMA_DST_CHN1_INT)
+				val |= SPRD_DMA_GLB_DEST_INT;
+
+			sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2,
+					    SPRD_DMA_GLB_DEST_INT |
+					    SPRD_DMA_GLB_DEST_CHN_MASK, val);
+		} else {
+			sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2,
+					    SPRD_DMA_GLB_DEST_INT |
+					    SPRD_DMA_GLB_2STAGE_EN |
+					    SPRD_DMA_GLB_DEST_CHN_MASK, 0);
+		}
 		break;
 
 	default:
@@ -545,7 +593,7 @@ static void sprd_dma_start(struct sprd_dma_chn *schan)
 	 * Set 2-stage configuration if the channel starts one 2-stage
 	 * transfer.
 	 */
-	if (schan->chn_mode && sprd_dma_set_2stage_config(schan))
+	if (schan->chn_mode && sprd_dma_2stage_config(schan, SPRD_DMA_2STAGE_SET))
 		return;
 
 	/*
@@ -569,6 +617,12 @@ static void sprd_dma_stop(struct sprd_dma_chn *schan)
 	sprd_dma_set_pending(schan, false);
 	sprd_dma_unset_uid(schan);
 	sprd_dma_clear_int(schan);
+	/*
+	 * If 2-stage transfer is used, the configuration must be clear
+	 * when release DMA channel.
+	 */
+	if (schan->chn_mode)
+		sprd_dma_2stage_config(schan, SPRD_DMA_2STAGE_CLEAR);
 	schan->cur_desc = NULL;
 }
 
@@ -757,7 +811,9 @@ static int sprd_dma_fill_desc(struct dma_chan *chan,
 	phys_addr_t llist_ptr;
 
 	if (dir == DMA_MEM_TO_DEV) {
-		src_step = sprd_dma_get_step(slave_cfg->src_addr_width);
+		src_step = slave_cfg->src_port_window_size ?
+			   slave_cfg->src_port_window_size :
+			   sprd_dma_get_step(slave_cfg->src_addr_width);
 		if (src_step < 0) {
 			dev_err(sdev->dma_dev.dev, "invalid source step\n");
 			return src_step;
@@ -773,7 +829,9 @@ static int sprd_dma_fill_desc(struct dma_chan *chan,
 		else
 			dst_step = SPRD_DMA_NONE_STEP;
 	} else {
-		dst_step = sprd_dma_get_step(slave_cfg->dst_addr_width);
+		dst_step = slave_cfg->dst_port_window_size ?
+			   slave_cfg->dst_port_window_size :
+			   sprd_dma_get_step(slave_cfg->dst_addr_width);
 		if (dst_step < 0) {
 			dev_err(sdev->dma_dev.dev, "invalid destination step\n");
 			return dst_step;
-- 
2.17.1

