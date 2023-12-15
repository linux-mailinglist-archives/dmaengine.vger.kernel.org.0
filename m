Return-Path: <dmaengine+bounces-538-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 840AC8148D1
	for <lists+dmaengine@lfdr.de>; Fri, 15 Dec 2023 14:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 005BEB20FDB
	for <lists+dmaengine@lfdr.de>; Fri, 15 Dec 2023 13:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DC02DB6A;
	Fri, 15 Dec 2023 13:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="n73GF01n"
X-Original-To: dmaengine@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43082DB78;
	Fri, 15 Dec 2023 13:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1702646030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dX1OOI1l+mZGv2ZWGYC1ua/+SRhxUb4vYorhXQG2m0s=;
	b=n73GF01nlvHq339iRA74SaYN1veT8I1ymfb0jyl4RXfsslvWnxW8Sigt6UGYAq0KKmDwt/
	l0mmWMMHKRX4jyKHL6DdB9ueF2czOEgP0AbgpUzqhX4I8+vBvKmer9DU0oUwCM/txc2hdU
	TmL1k3pWMFkaKPOw9u2qHVQN4x3utqk=
From: Paul Cercueil <paul@crapouillou.net>
To: Vinod Koul <vkoul@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 2/5] dmaengine: axi-dmac: Allocate hardware descriptors
Date: Fri, 15 Dec 2023 14:13:10 +0100
Message-ID: <20231215131313.23840-3-paul@crapouillou.net>
In-Reply-To: <20231215131313.23840-1-paul@crapouillou.net>
References: <20231215131313.23840-1-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes

Change where and how the DMA transfers meta-data is stored, to prepare
for the upcoming introduction of scatter-gather support.

Allocate hardware descriptors in the format that the HDL core will be
expecting them when the scatter-gather feature is enabled, and use these
fields to store the data that was previously stored in the axi_dmac_sg
structure.

Note that the 'x_len' and 'y_len' fields now contain the transfer length
minus one, since that's what the hardware will expect in these fields.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/dma/dma-axi-dmac.c | 134 ++++++++++++++++++++++++-------------
 1 file changed, 88 insertions(+), 46 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 760940b21eab..185230a769b9 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -97,20 +97,31 @@
 /* The maximum ID allocated by the hardware is 31 */
 #define AXI_DMAC_SG_UNUSED 32U
 
+struct axi_dmac_hw_desc {
+	u32 flags;
+	u32 id;
+	u64 dest_addr;
+	u64 src_addr;
+	u64 __unused;
+	u32 y_len;
+	u32 x_len;
+	u32 src_stride;
+	u32 dst_stride;
+	u64 __pad[2];
+};
+
 struct axi_dmac_sg {
-	dma_addr_t src_addr;
-	dma_addr_t dest_addr;
-	unsigned int x_len;
-	unsigned int y_len;
-	unsigned int dest_stride;
-	unsigned int src_stride;
-	unsigned int id;
 	unsigned int partial_len;
 	bool schedule_when_free;
+
+	struct axi_dmac_hw_desc *hw;
+	dma_addr_t hw_phys;
 };
 
 struct axi_dmac_desc {
 	struct virt_dma_desc vdesc;
+	struct axi_dmac_chan *chan;
+
 	bool cyclic;
 	bool have_partial_xfer;
 
@@ -229,7 +240,7 @@ static void axi_dmac_start_transfer(struct axi_dmac_chan *chan)
 	sg = &desc->sg[desc->num_submitted];
 
 	/* Already queued in cyclic mode. Wait for it to finish */
-	if (sg->id != AXI_DMAC_SG_UNUSED) {
+	if (sg->hw->id != AXI_DMAC_SG_UNUSED) {
 		sg->schedule_when_free = true;
 		return;
 	}
@@ -246,16 +257,16 @@ static void axi_dmac_start_transfer(struct axi_dmac_chan *chan)
 		chan->next_desc = desc;
 	}
 
-	sg->id = axi_dmac_read(dmac, AXI_DMAC_REG_TRANSFER_ID);
+	sg->hw->id = axi_dmac_read(dmac, AXI_DMAC_REG_TRANSFER_ID);
 
 	if (axi_dmac_dest_is_mem(chan)) {
-		axi_dmac_write(dmac, AXI_DMAC_REG_DEST_ADDRESS, sg->dest_addr);
-		axi_dmac_write(dmac, AXI_DMAC_REG_DEST_STRIDE, sg->dest_stride);
+		axi_dmac_write(dmac, AXI_DMAC_REG_DEST_ADDRESS, sg->hw->dest_addr);
+		axi_dmac_write(dmac, AXI_DMAC_REG_DEST_STRIDE, sg->hw->dst_stride);
 	}
 
 	if (axi_dmac_src_is_mem(chan)) {
-		axi_dmac_write(dmac, AXI_DMAC_REG_SRC_ADDRESS, sg->src_addr);
-		axi_dmac_write(dmac, AXI_DMAC_REG_SRC_STRIDE, sg->src_stride);
+		axi_dmac_write(dmac, AXI_DMAC_REG_SRC_ADDRESS, sg->hw->src_addr);
+		axi_dmac_write(dmac, AXI_DMAC_REG_SRC_STRIDE, sg->hw->src_stride);
 	}
 
 	/*
@@ -270,8 +281,8 @@ static void axi_dmac_start_transfer(struct axi_dmac_chan *chan)
 	if (chan->hw_partial_xfer)
 		flags |= AXI_DMAC_FLAG_PARTIAL_REPORT;
 
-	axi_dmac_write(dmac, AXI_DMAC_REG_X_LENGTH, sg->x_len - 1);
-	axi_dmac_write(dmac, AXI_DMAC_REG_Y_LENGTH, sg->y_len - 1);
+	axi_dmac_write(dmac, AXI_DMAC_REG_X_LENGTH, sg->hw->x_len);
+	axi_dmac_write(dmac, AXI_DMAC_REG_Y_LENGTH, sg->hw->y_len);
 	axi_dmac_write(dmac, AXI_DMAC_REG_FLAGS, flags);
 	axi_dmac_write(dmac, AXI_DMAC_REG_START_TRANSFER, 1);
 }
@@ -286,9 +297,9 @@ static inline unsigned int axi_dmac_total_sg_bytes(struct axi_dmac_chan *chan,
 	struct axi_dmac_sg *sg)
 {
 	if (chan->hw_2d)
-		return sg->x_len * sg->y_len;
+		return (sg->hw->x_len + 1) * (sg->hw->y_len + 1);
 	else
-		return sg->x_len;
+		return (sg->hw->x_len + 1);
 }
 
 static void axi_dmac_dequeue_partial_xfers(struct axi_dmac_chan *chan)
@@ -307,9 +318,9 @@ static void axi_dmac_dequeue_partial_xfers(struct axi_dmac_chan *chan)
 		list_for_each_entry(desc, &chan->active_descs, vdesc.node) {
 			for (i = 0; i < desc->num_sgs; i++) {
 				sg = &desc->sg[i];
-				if (sg->id == AXI_DMAC_SG_UNUSED)
+				if (sg->hw->id == AXI_DMAC_SG_UNUSED)
 					continue;
-				if (sg->id == id) {
+				if (sg->hw->id == id) {
 					desc->have_partial_xfer = true;
 					sg->partial_len = len;
 					found_sg = true;
@@ -376,12 +387,12 @@ static bool axi_dmac_transfer_done(struct axi_dmac_chan *chan,
 
 	do {
 		sg = &active->sg[active->num_completed];
-		if (sg->id == AXI_DMAC_SG_UNUSED) /* Not yet submitted */
+		if (sg->hw->id == AXI_DMAC_SG_UNUSED) /* Not yet submitted */
 			break;
-		if (!(BIT(sg->id) & completed_transfers))
+		if (!(BIT(sg->hw->id) & completed_transfers))
 			break;
 		active->num_completed++;
-		sg->id = AXI_DMAC_SG_UNUSED;
+		sg->hw->id = AXI_DMAC_SG_UNUSED;
 		if (sg->schedule_when_free) {
 			sg->schedule_when_free = false;
 			start_next = true;
@@ -476,22 +487,52 @@ static void axi_dmac_issue_pending(struct dma_chan *c)
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
 }
 
-static struct axi_dmac_desc *axi_dmac_alloc_desc(unsigned int num_sgs)
+static struct axi_dmac_desc *
+axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
 {
+	struct axi_dmac *dmac = chan_to_axi_dmac(chan);
+	struct device *dev = dmac->dma_dev.dev;
+	struct axi_dmac_hw_desc *hws;
 	struct axi_dmac_desc *desc;
+	dma_addr_t hw_phys;
 	unsigned int i;
 
 	desc = kzalloc(struct_size(desc, sg, num_sgs), GFP_NOWAIT);
 	if (!desc)
 		return NULL;
 	desc->num_sgs = num_sgs;
+	desc->chan = chan;
 
-	for (i = 0; i < num_sgs; i++)
-		desc->sg[i].id = AXI_DMAC_SG_UNUSED;
+	hws = dma_alloc_coherent(dev, PAGE_ALIGN(num_sgs * sizeof(*hws)),
+				&hw_phys, GFP_ATOMIC);
+	if (!hws) {
+		kfree(desc);
+		return NULL;
+	}
+
+	for (i = 0; i < num_sgs; i++) {
+		desc->sg[i].hw = &hws[i];
+		desc->sg[i].hw_phys = hw_phys + i * sizeof(*hws);
+
+		hws[i].id = AXI_DMAC_SG_UNUSED;
+		hws[i].flags = 0;
+	}
 
 	return desc;
 }
 
+static void axi_dmac_free_desc(struct axi_dmac_desc *desc)
+{
+	struct axi_dmac *dmac = chan_to_axi_dmac(desc->chan);
+	struct device *dev = dmac->dma_dev.dev;
+	struct axi_dmac_hw_desc *hw = desc->sg[0].hw;
+	dma_addr_t hw_phys = desc->sg[0].hw_phys;
+
+	dma_free_coherent(dev, PAGE_ALIGN(desc->num_sgs * sizeof(*hw)),
+			  hw, hw_phys);
+	kfree(desc);
+}
+
 static struct axi_dmac_sg *axi_dmac_fill_linear_sg(struct axi_dmac_chan *chan,
 	enum dma_transfer_direction direction, dma_addr_t addr,
 	unsigned int num_periods, unsigned int period_len,
@@ -510,21 +551,22 @@ static struct axi_dmac_sg *axi_dmac_fill_linear_sg(struct axi_dmac_chan *chan,
 	for (i = 0; i < num_periods; i++) {
 		for (len = period_len; len > segment_size; sg++) {
 			if (direction == DMA_DEV_TO_MEM)
-				sg->dest_addr = addr;
+				sg->hw->dest_addr = addr;
 			else
-				sg->src_addr = addr;
-			sg->x_len = segment_size;
-			sg->y_len = 1;
+				sg->hw->src_addr = addr;
+			sg->hw->x_len = segment_size - 1;
+			sg->hw->y_len = 0;
+			sg->hw->flags = 0;
 			addr += segment_size;
 			len -= segment_size;
 		}
 
 		if (direction == DMA_DEV_TO_MEM)
-			sg->dest_addr = addr;
+			sg->hw->dest_addr = addr;
 		else
-			sg->src_addr = addr;
-		sg->x_len = len;
-		sg->y_len = 1;
+			sg->hw->src_addr = addr;
+		sg->hw->x_len = len - 1;
+		sg->hw->y_len = 0;
 		sg++;
 		addr += len;
 	}
@@ -551,7 +593,7 @@ static struct dma_async_tx_descriptor *axi_dmac_prep_slave_sg(
 	for_each_sg(sgl, sg, sg_len, i)
 		num_sgs += DIV_ROUND_UP(sg_dma_len(sg), chan->max_length);
 
-	desc = axi_dmac_alloc_desc(num_sgs);
+	desc = axi_dmac_alloc_desc(chan, num_sgs);
 	if (!desc)
 		return NULL;
 
@@ -560,7 +602,7 @@ static struct dma_async_tx_descriptor *axi_dmac_prep_slave_sg(
 	for_each_sg(sgl, sg, sg_len, i) {
 		if (!axi_dmac_check_addr(chan, sg_dma_address(sg)) ||
 		    !axi_dmac_check_len(chan, sg_dma_len(sg))) {
-			kfree(desc);
+			axi_dmac_free_desc(desc);
 			return NULL;
 		}
 
@@ -595,7 +637,7 @@ static struct dma_async_tx_descriptor *axi_dmac_prep_dma_cyclic(
 	num_periods = buf_len / period_len;
 	num_segments = DIV_ROUND_UP(period_len, chan->max_length);
 
-	desc = axi_dmac_alloc_desc(num_periods * num_segments);
+	desc = axi_dmac_alloc_desc(chan, num_periods * num_segments);
 	if (!desc)
 		return NULL;
 
@@ -650,26 +692,26 @@ static struct dma_async_tx_descriptor *axi_dmac_prep_interleaved(
 			return NULL;
 	}
 
-	desc = axi_dmac_alloc_desc(1);
+	desc = axi_dmac_alloc_desc(chan, 1);
 	if (!desc)
 		return NULL;
 
 	if (axi_dmac_src_is_mem(chan)) {
-		desc->sg[0].src_addr = xt->src_start;
-		desc->sg[0].src_stride = xt->sgl[0].size + src_icg;
+		desc->sg[0].hw->src_addr = xt->src_start;
+		desc->sg[0].hw->src_stride = xt->sgl[0].size + src_icg;
 	}
 
 	if (axi_dmac_dest_is_mem(chan)) {
-		desc->sg[0].dest_addr = xt->dst_start;
-		desc->sg[0].dest_stride = xt->sgl[0].size + dst_icg;
+		desc->sg[0].hw->dest_addr = xt->dst_start;
+		desc->sg[0].hw->dst_stride = xt->sgl[0].size + dst_icg;
 	}
 
 	if (chan->hw_2d) {
-		desc->sg[0].x_len = xt->sgl[0].size;
-		desc->sg[0].y_len = xt->numf;
+		desc->sg[0].hw->x_len = xt->sgl[0].size - 1;
+		desc->sg[0].hw->y_len = xt->numf - 1;
 	} else {
-		desc->sg[0].x_len = xt->sgl[0].size * xt->numf;
-		desc->sg[0].y_len = 1;
+		desc->sg[0].hw->x_len = xt->sgl[0].size * xt->numf - 1;
+		desc->sg[0].hw->y_len = 0;
 	}
 
 	if (flags & DMA_CYCLIC)
@@ -685,7 +727,7 @@ static void axi_dmac_free_chan_resources(struct dma_chan *c)
 
 static void axi_dmac_desc_free(struct virt_dma_desc *vdesc)
 {
-	kfree(container_of(vdesc, struct axi_dmac_desc, vdesc));
+	axi_dmac_free_desc(to_axi_dmac_desc(vdesc));
 }
 
 static bool axi_dmac_regmap_rdwr(struct device *dev, unsigned int reg)
-- 
2.42.0


