Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B327D6AF6
	for <lists+dmaengine@lfdr.de>; Wed, 25 Oct 2023 14:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbjJYMOZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Oct 2023 08:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjJYMOZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 Oct 2023 08:14:25 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8FF182;
        Wed, 25 Oct 2023 05:14:21 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 39PCDvLd007254;
        Wed, 25 Oct 2023 20:13:57 +0800 (+08)
        (envelope-from Kaiwei.Liu@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx07.spreadtrum.com [10.0.1.12])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4SFnmB49j2z2L033G;
        Wed, 25 Oct 2023 20:09:30 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx07.spreadtrum.com
 (10.0.1.12) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Wed, 25 Oct
 2023 20:13:56 +0800
From:   Kaiwei Liu <kaiwei.liu@unisoc.com>
To:     Vinod Koul <vkoul@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        kaiwei liu <liukaiwei086@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
Subject: [PATCH 3/3] dmaengine: sprd: optimize two stage transfer function
Date:   Wed, 25 Oct 2023 20:13:48 +0800
Message-ID: <20231025121348.9147-1-kaiwei.liu@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx07.spreadtrum.com (10.0.1.12)
X-MAIL: SHSQR01.spreadtrum.com 39PCDvLd007254
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: "kaiwei.liu" <kaiwei.liu@unisoc.com>

For SPRD DMA, it provides a function that one channel can start
the second channel after completing the transmission, which we
call two stage transfer mode. You can choose which channel can
generate interrupt when finished. It can support up to two sets
of such patterns.
When configuring registers for two stage transfer mode, we need
to set the mask bit to ensure that the setting are accurate. And
we should clear the two stage transfer configuration when release
DMA channel.
The two stage transfer function is mainly used by SPRD audio, and
now audio also requires that the data need to be accessed on the
device side. So here use the src_port_window_size and dst_port_win-
dow_size in the struct of dma_slave_config.

Signed-off-by: kaiwei.liu <kaiwei.liu@unisoc.com>
---
 drivers/dma/sprd-dma.c | 116 ++++++++++++++++++++++++-----------------
 1 file changed, 69 insertions(+), 47 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index f8ed2f3f764b..50916296cd08 100644
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
@@ -431,53 +439,57 @@ static enum sprd_dma_req_mode sprd_dma_get_req_type(struct sprd_dma_chn *schan)
 	return (frag_reg >> SPRD_DMA_REQ_MODE_OFFSET) & SPRD_DMA_REQ_MODE_MASK;
 }
 
-static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
+static void sprd_dma_2stage_write(struct sprd_dma_chn *schan,
+				  u32 config_type, u32 grp_offset)
 {
 	struct sprd_dma_dev *sdev = to_sprd_dma_dev(&schan->vc.chan);
-	u32 val, chn = schan->chn_num + 1;
-
-	switch (schan->chn_mode) {
-	case SPRD_DMA_SRC_CHN0:
-		val = chn & SPRD_DMA_GLB_SRC_CHN_MASK;
-		val |= BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFFSET;
-		val |= SPRD_DMA_GLB_2STAGE_EN;
-		if (schan->int_type != SPRD_DMA_NO_INT)
-			val |= SPRD_DMA_GLB_SRC_INT;
-
-		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1, val, val);
-		break;
-
-	case SPRD_DMA_SRC_CHN1:
-		val = chn & SPRD_DMA_GLB_SRC_CHN_MASK;
-		val |= BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFFSET;
-		val |= SPRD_DMA_GLB_2STAGE_EN;
-		if (schan->int_type != SPRD_DMA_NO_INT)
-			val |= SPRD_DMA_GLB_SRC_INT;
-
-		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2, val, val);
-		break;
-
-	case SPRD_DMA_DST_CHN0:
-		val = (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
-			SPRD_DMA_GLB_DEST_CHN_MASK;
-		val |= SPRD_DMA_GLB_2STAGE_EN;
-		if (schan->int_type != SPRD_DMA_NO_INT)
-			val |= SPRD_DMA_GLB_DEST_INT;
-
-		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1, val, val);
-		break;
-
-	case SPRD_DMA_DST_CHN1:
-		val = (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
-			SPRD_DMA_GLB_DEST_CHN_MASK;
-		val |= SPRD_DMA_GLB_2STAGE_EN;
-		if (schan->int_type != SPRD_DMA_NO_INT)
-			val |= SPRD_DMA_GLB_DEST_INT;
-
-		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2, val, val);
-		break;
+	u32 mask_val;
+	u32 chn = schan->chn_num + 1;
+	u32 val = 0;
+
+	if (config_type == SPRD_DMA_2STAGE_SET) {
+		if (schan->chn_mode == SPRD_DMA_SRC_CHN0 ||
+		    schan->chn_mode == SPRD_DMA_SRC_CHN1) {
+			val = chn & SPRD_DMA_GLB_SRC_CHN_MASK;
+			val |= BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFFSET;
+			val |= SPRD_DMA_GLB_2STAGE_EN;
+			if (schan->int_type & SPRD_DMA_SRC_CHN0_INT ||
+			    schan->int_type & SPRD_DMA_SRC_CHN1_INT)
+				val |= SPRD_DMA_GLB_SRC_INT;
+			mask_val = SPRD_DMA_GLB_SRC_INT | SPRD_DMA_GLB_TRG_MASK |
+				   SPRD_DMA_GLB_SRC_CHN_MASK;
+		} else {
+			val = (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
+			       SPRD_DMA_GLB_DEST_CHN_MASK;
+			val |= SPRD_DMA_GLB_2STAGE_EN;
+			if (schan->int_type & SPRD_DMA_DST_CHN0_INT ||
+			    schan->int_type & SPRD_DMA_DST_CHN1_INT)
+				val |= SPRD_DMA_GLB_DEST_INT;
+			mask_val = SPRD_DMA_GLB_DEST_INT | SPRD_DMA_GLB_DEST_CHN_MASK;
+		}
+	} else {
+		if (schan->chn_mode == SPRD_DMA_SRC_CHN0 ||
+		    schan->chn_mode == SPRD_DMA_SRC_CHN1)
+			mask_val = SPRD_DMA_GLB_SRC_INT | SPRD_DMA_GLB_TRG_MASK |
+				   SPRD_DMA_GLB_2STAGE_EN | SPRD_DMA_GLB_SRC_CHN_MASK;
+		else
+			mask_val = SPRD_DMA_GLB_DEST_INT | SPRD_DMA_GLB_2STAGE_EN |
+				   SPRD_DMA_GLB_DEST_CHN_MASK;
+	}
+	sprd_dma_glb_update(sdev, grp_offset, mask_val, val);
+}
 
-	default:
+static int sprd_dma_2stage_config(struct sprd_dma_chn *schan, u32 config_type)
+{
+	struct sprd_dma_dev *sdev = to_sprd_dma_dev(&schan->vc.chan);
+
+	if (schan->chn_mode == SPRD_DMA_SRC_CHN0 ||
+	    schan->chn_mode == SPRD_DMA_DST_CHN0)
+		sprd_dma_2stage_write(schan, config_type, SPRD_DMA_GLB_2STAGE_GRP1);
+	else if (schan->chn_mode == SPRD_DMA_SRC_CHN1 ||
+		 schan->chn_mode == SPRD_DMA_DST_CHN1)
+		sprd_dma_2stage_write(schan, config_type, SPRD_DMA_GLB_2STAGE_GRP2);
+	else {
 		dev_err(sdev->dma_dev.dev, "invalid channel mode setting %d\n",
 			schan->chn_mode);
 		return -EINVAL;
@@ -545,7 +557,7 @@ static void sprd_dma_start(struct sprd_dma_chn *schan)
 	 * Set 2-stage configuration if the channel starts one 2-stage
 	 * transfer.
 	 */
-	if (schan->chn_mode && sprd_dma_set_2stage_config(schan))
+	if (schan->chn_mode && sprd_dma_2stage_config(schan, SPRD_DMA_2STAGE_SET))
 		return;
 
 	/*
@@ -569,6 +581,12 @@ static void sprd_dma_stop(struct sprd_dma_chn *schan)
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
 
@@ -757,7 +775,9 @@ static int sprd_dma_fill_desc(struct dma_chan *chan,
 	phys_addr_t llist_ptr;
 
 	if (dir == DMA_MEM_TO_DEV) {
-		src_step = sprd_dma_get_step(slave_cfg->src_addr_width);
+		src_step = slave_cfg->src_port_window_size ?
+			   slave_cfg->src_port_window_size :
+			   sprd_dma_get_step(slave_cfg->src_addr_width);
 		if (src_step < 0) {
 			dev_err(sdev->dma_dev.dev, "invalid source step\n");
 			return src_step;
@@ -773,7 +793,9 @@ static int sprd_dma_fill_desc(struct dma_chan *chan,
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

