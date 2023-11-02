Return-Path: <dmaengine+bounces-42-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F0B7DF228
	for <lists+dmaengine@lfdr.de>; Thu,  2 Nov 2023 13:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72959B20DE4
	for <lists+dmaengine@lfdr.de>; Thu,  2 Nov 2023 12:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DC0182AE;
	Thu,  2 Nov 2023 12:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952C0179BF
	for <dmaengine@vger.kernel.org>; Thu,  2 Nov 2023 12:17:48 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC3F193;
	Thu,  2 Nov 2023 05:17:46 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 3A2CHFCR024307;
	Thu, 2 Nov 2023 20:17:15 +0800 (+08)
	(envelope-from Kaiwei.Liu@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx07.spreadtrum.com [10.0.1.12])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4SLjS10k1Yz2M9fbK;
	Thu,  2 Nov 2023 20:12:33 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx07.spreadtrum.com
 (10.0.1.12) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 2 Nov 2023
 20:17:14 +0800
From: Kaiwei Liu <kaiwei.liu@unisoc.com>
To: Vinod Koul <vkoul@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin
 Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        kaiwei liu
	<liukaiwei086@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
Subject: [PATCH 2/2] dmaengine: sprd: optimize two stage transfer function
Date: Thu, 2 Nov 2023 20:17:08 +0800
Message-ID: <20231102121708.32279-1-kaiwei.liu@unisoc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx07.spreadtrum.com (10.0.1.12)
X-MAIL:SHSQR01.spreadtrum.com 3A2CHFCR024307

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
index 8ab5a9082fc5..f54f4ba1a8bd 100644
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


