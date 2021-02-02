Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BED30BE9C
	for <lists+dmaengine@lfdr.de>; Tue,  2 Feb 2021 13:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbhBBMqh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Feb 2021 07:46:37 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:56116 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231526AbhBBMlx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 Feb 2021 07:41:53 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E43AFC00B7;
        Tue,  2 Feb 2021 12:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612269653; bh=ZwuAEc7PYGYf65aM+oFkF22mTyotdTO38xdBbdz9Hvs=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=ZgO2v9iWpUn+HP5A49hUm5xWTpLkghEzs1vdvWA2c/iGQgyQeoQBkac9aEWOwpSTk
         ay4uIitmSW5TY9gp/dmPgjf0nAvOIGDUhAFDhGxJDty6AQ+TzW1WTTmuvXyjfQdf85
         oEAWBYSuKnSVTxBqkoCDICeFj5G8Dfl4flogNn8GIAHAP/u+BHIham5e9OP5I9sN/1
         B+lG6oENENKh0LS3J5ehjpsAdCfaRdpfEH9SrZzxoTZtdP3pS4LGR07Okm2JMUOwAe
         bG9O2VPXA7LzVdEuoAdYiXOs86niZ8Il9seNTwxvdBx1hTtZVSTv4g3qU4OzEEL2b2
         rr39Bu9zbLfiQ==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id A9373A0249;
        Tue,  2 Feb 2021 12:40:51 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v2 06/15] dmaengine: dw-edma: Add device_prep_interleave_dma() support
Date:   Tue,  2 Feb 2021 13:40:20 +0100
Message-Id: <2aa13a61a8fbe3bbcc31c3b43784df61f1aecd58.1612269537.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1612269536.git.gustavo.pimentel@synopsys.com>
References: <cover.1612269536.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1612269536.git.gustavo.pimentel@synopsys.com>
References: <cover.1612269536.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add device_prep_interleave_dma() support to Synopsys DMA driver.

This feature implements a similar data transfer mechanism to the
scatter-gather implementation.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 85 ++++++++++++++++++++++++++++++--------
 drivers/dma/dw-edma/dw-edma-core.h | 13 ++++--
 2 files changed, 78 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index b65c32e1..0fe3835 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -329,7 +329,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 	struct dw_edma_chunk *chunk;
 	struct dw_edma_burst *burst;
 	struct dw_edma_desc *desc;
-	u32 cnt;
+	u32 cnt = 0;
 	int i;
 
 	if (!chan->configured)
@@ -352,12 +352,19 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 		return NULL;
 	}
 
-	if (xfer->cyclic) {
+	if (xfer->type == EDMA_XFER_CYCLIC) {
 		if (!xfer->xfer.cyclic.len || !xfer->xfer.cyclic.cnt)
 			return NULL;
-	} else {
+	} else if (xfer->type == EDMA_XFER_SCATTER_GATHER) {
 		if (xfer->xfer.sg.len < 1)
 			return NULL;
+	} else if (xfer->type == EDMA_XFER_INTERLEAVED) {
+		if (!xfer->xfer.il->numf)
+			return NULL;
+		if (xfer->xfer.il->numf > 0 && xfer->xfer.il->frame_size > 0)
+			return NULL;
+	} else {
+		return NULL;
 	}
 
 	desc = dw_edma_alloc_desc(chan);
@@ -368,18 +375,28 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 	if (unlikely(!chunk))
 		goto err_alloc;
 
-	src_addr = chan->config.src_addr;
-	dst_addr = chan->config.dst_addr;
+	if (xfer->type == EDMA_XFER_INTERLEAVED) {
+		src_addr = xfer->xfer.il->src_start;
+		dst_addr = xfer->xfer.il->dst_start;
+	} else {
+		src_addr = chan->config.src_addr;
+		dst_addr = chan->config.dst_addr;
+	}
 
-	if (xfer->cyclic) {
+	if (xfer->type == EDMA_XFER_CYCLIC) {
 		cnt = xfer->xfer.cyclic.cnt;
-	} else {
+	} else if (xfer->type == EDMA_XFER_SCATTER_GATHER) {
 		cnt = xfer->xfer.sg.len;
 		sg = xfer->xfer.sg.sgl;
+	} else if (xfer->type == EDMA_XFER_INTERLEAVED) {
+		if (xfer->xfer.il->numf > 0)
+			cnt = xfer->xfer.il->numf;
+		else
+			cnt = xfer->xfer.il->frame_size;
 	}
 
 	for (i = 0; i < cnt; i++) {
-		if (!xfer->cyclic && !sg)
+		if (xfer->type == EDMA_XFER_SCATTER_GATHER && !sg)
 			break;
 
 		if (chunk->bursts_alloc == chan->ll_max) {
@@ -392,19 +409,21 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 		if (unlikely(!burst))
 			goto err_alloc;
 
-		if (xfer->cyclic)
+		if (xfer->type == EDMA_XFER_CYCLIC)
 			burst->sz = xfer->xfer.cyclic.len;
-		else
+		else if (xfer->type == EDMA_XFER_SCATTER_GATHER)
 			burst->sz = sg_dma_len(sg);
+		else if (xfer->type == EDMA_XFER_INTERLEAVED)
+			burst->sz = xfer->xfer.il->sgl[i].size;
 
 		chunk->ll_region.sz += burst->sz;
 		desc->alloc_sz += burst->sz;
 
 		if (chan->dir == EDMA_DIR_WRITE) {
 			burst->sar = src_addr;
-			if (xfer->cyclic) {
+			if (xfer->type == EDMA_XFER_CYCLIC) {
 				burst->dar = xfer->xfer.cyclic.paddr;
-			} else {
+			} else if (xfer->type == EDMA_XFER_SCATTER_GATHER) {
 				burst->dar = dst_addr;
 				/* Unlike the typical assumption by other
 				 * drivers/IPs the peripheral memory isn't
@@ -416,9 +435,9 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 			}
 		} else {
 			burst->dar = dst_addr;
-			if (xfer->cyclic) {
+			if (xfer->type == EDMA_XFER_CYCLIC) {
 				burst->sar = xfer->xfer.cyclic.paddr;
-			} else {
+			} else if (xfer->type == EDMA_XFER_SCATTER_GATHER) {
 				burst->sar = src_addr;
 				/* Unlike the typical assumption by other
 				 * drivers/IPs the peripheral memory isn't
@@ -430,10 +449,24 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 			}
 		}
 
-		if (!xfer->cyclic) {
+		if (xfer->type == EDMA_XFER_SCATTER_GATHER) {
 			src_addr += sg_dma_len(sg);
 			dst_addr += sg_dma_len(sg);
 			sg = sg_next(sg);
+		} else if (xfer->type == EDMA_XFER_INTERLEAVED &&
+			   xfer->xfer.il->frame_size > 0) {
+			struct dma_interleaved_template *il = xfer->xfer.il;
+			struct data_chunk *dc = &il->sgl[i];
+
+			if (il->src_sgl) {
+				src_addr += burst->sz;
+				src_addr += dmaengine_get_src_icg(il, dc);
+			}
+
+			if (il->dst_sgl) {
+				dst_addr += burst->sz;
+				dst_addr += dmaengine_get_dst_icg(il, dc);
+			}
 		}
 	}
 
@@ -459,7 +492,7 @@ dw_edma_device_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 	xfer.xfer.sg.sgl = sgl;
 	xfer.xfer.sg.len = len;
 	xfer.flags = flags;
-	xfer.cyclic = false;
+	xfer.type = EDMA_XFER_SCATTER_GATHER;
 
 	return dw_edma_device_transfer(&xfer);
 }
@@ -478,7 +511,23 @@ dw_edma_device_prep_dma_cyclic(struct dma_chan *dchan, dma_addr_t paddr,
 	xfer.xfer.cyclic.len = len;
 	xfer.xfer.cyclic.cnt = count;
 	xfer.flags = flags;
-	xfer.cyclic = true;
+	xfer.type = EDMA_XFER_CYCLIC;
+
+	return dw_edma_device_transfer(&xfer);
+}
+
+static struct dma_async_tx_descriptor *
+dw_edma_device_prep_interleaved_dma(struct dma_chan *dchan,
+				    struct dma_interleaved_template *ilt,
+				    unsigned long flags)
+{
+	struct dw_edma_transfer xfer;
+
+	xfer.dchan = dchan;
+	xfer.direction = ilt->dir;
+	xfer.xfer.il = ilt;
+	xfer.flags = flags;
+	xfer.type = EDMA_XFER_INTERLEAVED;
 
 	return dw_edma_device_transfer(&xfer);
 }
@@ -738,6 +787,7 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
 	dma_cap_set(DMA_SLAVE, dma->cap_mask);
 	dma_cap_set(DMA_CYCLIC, dma->cap_mask);
 	dma_cap_set(DMA_PRIVATE, dma->cap_mask);
+	dma_cap_set(DMA_INTERLEAVE, dma->cap_mask);
 	dma->directions = BIT(write ? DMA_DEV_TO_MEM : DMA_MEM_TO_DEV);
 	dma->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
 	dma->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
@@ -756,6 +806,7 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
 	dma->device_tx_status = dw_edma_device_tx_status;
 	dma->device_prep_slave_sg = dw_edma_device_prep_slave_sg;
 	dma->device_prep_dma_cyclic = dw_edma_device_prep_dma_cyclic;
+	dma->device_prep_interleaved_dma = dw_edma_device_prep_interleaved_dma;
 
 	dma_set_max_seg_size(dma->dev, U32_MAX);
 
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 3f9593e..f72ebaa 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -39,6 +39,12 @@ enum dw_edma_status {
 	EDMA_ST_BUSY
 };
 
+enum dw_edma_xfer_type {
+	EDMA_XFER_SCATTER_GATHER = 0,
+	EDMA_XFER_CYCLIC,
+	EDMA_XFER_INTERLEAVED
+};
+
 struct dw_edma_chan;
 struct dw_edma_chunk;
 
@@ -146,12 +152,13 @@ struct dw_edma_cyclic {
 struct dw_edma_transfer {
 	struct dma_chan			*dchan;
 	union dw_edma_xfer {
-		struct dw_edma_sg	sg;
-		struct dw_edma_cyclic	cyclic;
+		struct dw_edma_sg		sg;
+		struct dw_edma_cyclic		cyclic;
+		struct dma_interleaved_template *il;
 	} xfer;
 	enum dma_transfer_direction	direction;
 	unsigned long			flags;
-	bool				cyclic;
+	enum dw_edma_xfer_type		type;
 };
 
 static inline
-- 
2.7.4

