Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328647692DB
	for <lists+dmaengine@lfdr.de>; Mon, 31 Jul 2023 12:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjGaKO4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Jul 2023 06:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjGaKOz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Jul 2023 06:14:55 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D628E3
        for <dmaengine@vger.kernel.org>; Mon, 31 Jul 2023 03:14:53 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id AEA141BF20B;
        Mon, 31 Jul 2023 10:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690798492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wyIVp2VgL/tBradJgpUuBL6aJbFDiTgjJIfXbvfYapI=;
        b=ba8WpySRb50TInnYrR/2wOhOh1Z3cN4N2ZBcH5+IlD/mgTJS0+3Fy4YCDw350OCpJxOMv6
        ofFVNVwO9shYJOQlxDzP7SjTh+TfKO3RAGeDNWd6/PHGaoBFcpgI0BkQwho8Ys1zfq4ge+
        niXmoGQZSU4wgKXGlTcdBhrxzzMjlEcRMR7KGDf2SVvAJyob5Q/CtI0czXPTD6TdPMwCal
        NqPKoylpafR8EWiA3PoWuIzJI8IL4KYA/bkSDSasWzG+/+M57WqOKLk/iOYQCZuZfwxmCu
        lR8AFbfPADEWyj4APAFTTyODz83Pp9CgTAu04LOA15+EXN6qaWQzbkdfA1ljEw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>,
        Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Michal Simek <michal.simek@amd.com>, Max Zhen <max.zhen@amd.com>,
        Sonal Santan <sonal.santan@amd.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 4/4] dmaengine: xilinx: xdma: Support cyclic transfers
Date:   Mon, 31 Jul 2023 12:14:42 +0200
Message-Id: <20230731101442.792514-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731101442.792514-1-miquel.raynal@bootlin.com>
References: <20230731101442.792514-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In order to use this dmaengine with sound devices, let's add cyclic
transfers support. Most of the code is reused from the existing
scatter-gather implementation, only the final linking between
descriptors, the control fields (to trigger interrupts more often) and
the interrupt handling are really different.

This controller supports up to 32 adjacent descriptors, we assume this
is way more than enough for the purpose of cyclic transfers and limit to
32 the number of cycled descriptors. This way, we simplify a lot the
overall handling of the descriptors.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/dma/xilinx/xdma-regs.h |   2 +
 drivers/dma/xilinx/xdma.c      | 173 +++++++++++++++++++++++++++++++--
 2 files changed, 169 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/xilinx/xdma-regs.h b/drivers/dma/xilinx/xdma-regs.h
index dd98b4526b90..e641a5083e14 100644
--- a/drivers/dma/xilinx/xdma-regs.h
+++ b/drivers/dma/xilinx/xdma-regs.h
@@ -44,6 +44,8 @@
 	 FIELD_PREP(XDMA_DESC_FLAGS_BITS, (flag)))
 #define XDMA_DESC_CONTROL_LAST						\
 	XDMA_DESC_CONTROL(1, XDMA_DESC_STOPPED | XDMA_DESC_COMPLETED)
+#define XDMA_DESC_CONTROL_CYCLIC					\
+	XDMA_DESC_CONTROL(1, XDMA_DESC_COMPLETED)
 
 /*
  * Descriptor for a single contiguous memory block transfer.
diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 40983d9355c4..be3a212be30c 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -83,6 +83,9 @@ struct xdma_chan {
  * @dblk_num: Number of hardware descriptor blocks
  * @desc_num: Number of hardware descriptors
  * @completed_desc_num: Completed hardware descriptors
+ * @cyclic: Cyclic transfer vs. scatter-gather
+ * @periods: Number of periods in the cyclic transfer
+ * @period_size: Size of a period in bytes in cyclic transfers
  */
 struct xdma_desc {
 	struct virt_dma_desc		vdesc;
@@ -93,6 +96,9 @@ struct xdma_desc {
 	u32				dblk_num;
 	u32				desc_num;
 	u32				completed_desc_num;
+	bool				cyclic;
+	u32				periods;
+	u32				period_size;
 };
 
 #define XDMA_DEV_STATUS_REG_DMA		BIT(0)
@@ -174,6 +180,25 @@ static void xdma_link_sg_desc_blocks(struct xdma_desc *sw_desc)
 	desc->control = cpu_to_le32(XDMA_DESC_CONTROL_LAST);
 }
 
+/**
+ * xdma_link_cyclic_desc_blocks - Link cyclic descriptor blocks for DMA transfer
+ * @sw_desc: Tx descriptor pointer
+ */
+static void xdma_link_cyclic_desc_blocks(struct xdma_desc *sw_desc)
+{
+	struct xdma_desc_block *block;
+	struct xdma_hw_desc *desc;
+	int i;
+
+	block = sw_desc->desc_blocks;
+	for (i = 0; i < sw_desc->desc_num - 1; i++) {
+		desc = block->virt_addr + i * XDMA_DESC_SIZE;
+		desc->next_desc = cpu_to_le64(block->dma_addr + ((i + 1) * XDMA_DESC_SIZE));
+	}
+	desc = block->virt_addr + i * XDMA_DESC_SIZE;
+	desc->next_desc = cpu_to_le64(block->dma_addr);
+}
+
 static inline struct xdma_chan *to_xdma_chan(struct dma_chan *chan)
 {
 	return container_of(chan, struct xdma_chan, vchan.chan);
@@ -233,7 +258,7 @@ static void xdma_free_desc(struct virt_dma_desc *vdesc)
  * @desc_num: Number of hardware descriptors
  */
 static struct xdma_desc *
-xdma_alloc_desc(struct xdma_chan *chan, u32 desc_num)
+xdma_alloc_desc(struct xdma_chan *chan, u32 desc_num, bool cyclic)
 {
 	struct xdma_desc *sw_desc;
 	struct xdma_hw_desc *desc;
@@ -249,13 +274,17 @@ xdma_alloc_desc(struct xdma_chan *chan, u32 desc_num)
 
 	sw_desc->chan = chan;
 	sw_desc->desc_num = desc_num;
+	sw_desc->cyclic = cyclic;
 	dblk_num = DIV_ROUND_UP(desc_num, XDMA_DESC_ADJACENT);
 	sw_desc->desc_blocks = kcalloc(dblk_num, sizeof(*sw_desc->desc_blocks),
 				       GFP_NOWAIT);
 	if (!sw_desc->desc_blocks)
 		goto failed;
 
-	control = XDMA_DESC_CONTROL(1, 0);
+	if (cyclic)
+		control = XDMA_DESC_CONTROL_CYCLIC;
+	else
+		control = XDMA_DESC_CONTROL(1, 0);
 
 	sw_desc->dblk_num = dblk_num;
 	for (i = 0; i < sw_desc->dblk_num; i++) {
@@ -269,7 +298,10 @@ xdma_alloc_desc(struct xdma_chan *chan, u32 desc_num)
 			desc[j].control = cpu_to_le32(control);
 	}
 
-	xdma_link_sg_desc_blocks(sw_desc);
+	if (cyclic)
+		xdma_link_cyclic_desc_blocks(sw_desc);
+	else
+		xdma_link_sg_desc_blocks(sw_desc);
 
 	return sw_desc;
 
@@ -469,7 +501,7 @@ xdma_prep_device_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	for_each_sg(sgl, sg, sg_len, i)
 		desc_num += DIV_ROUND_UP(sg_dma_len(sg), XDMA_DESC_BLEN_MAX);
 
-	sw_desc = xdma_alloc_desc(xdma_chan, desc_num);
+	sw_desc = xdma_alloc_desc(xdma_chan, desc_num, false);
 	if (!sw_desc)
 		return NULL;
 	sw_desc->dir = dir;
@@ -524,6 +556,89 @@ xdma_prep_device_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	return NULL;
 }
 
+/**
+ * xdma_prep_dma_cyclic - prepare for cyclic DMA transactions
+ * @chan: DMA channel pointer
+ * @address: Device DMA address to access
+ * @size: Total length to transfer
+ * @period_size: Period size to use for each transfer
+ * @dir: Transfer direction
+ * @flags: Transfer ack flags
+ */
+static struct dma_async_tx_descriptor *
+xdma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t address,
+		     size_t size, size_t period_size,
+		     enum dma_transfer_direction dir,
+		     unsigned long flags)
+{
+	struct xdma_chan *xdma_chan = to_xdma_chan(chan);
+	struct xdma_device *xdev = xdma_chan->xdev_hdl;
+	unsigned int periods = size / period_size;
+	struct dma_async_tx_descriptor *tx_desc;
+	u64 addr, dev_addr, *src, *dst;
+	struct xdma_desc_block *dblk;
+	struct xdma_hw_desc *desc;
+	struct xdma_desc *sw_desc;
+	unsigned int i;
+
+	/*
+	 * Simplify the whole logic by preventing an abnormally high number of
+	 * periods and periods size.
+	 */
+	if (period_size > XDMA_DESC_BLEN_MAX) {
+		xdma_err(xdev, "period size limited to %lu bytes\n", XDMA_DESC_BLEN_MAX);
+		return NULL;
+	}
+
+	if (periods > XDMA_DESC_ADJACENT) {
+		xdma_err(xdev, "number of periods limited to %u\n", XDMA_DESC_ADJACENT);
+		return NULL;
+	}
+
+	sw_desc = xdma_alloc_desc(xdma_chan, periods, true);
+	if (!sw_desc)
+		return NULL;
+
+	sw_desc->periods = periods;
+	sw_desc->period_size = period_size;
+	sw_desc->dir = dir;
+
+	if (dir == DMA_MEM_TO_DEV) {
+		dev_addr = xdma_chan->cfg.dst_addr;
+		src = &addr;
+		dst = &dev_addr;
+	} else {
+		dev_addr = xdma_chan->cfg.src_addr;
+		src = &dev_addr;
+		dst = &addr;
+	}
+
+	dblk = sw_desc->desc_blocks;
+	desc = dblk->virt_addr;
+	for (i = 0; i < periods; i++) {
+		addr = address;
+
+		/* fill hardware descriptor */
+		desc->bytes = cpu_to_le32(period_size);
+		desc->src_addr = cpu_to_le64(*src);
+		desc->dst_addr = cpu_to_le64(*dst);
+
+		desc++;
+		address += period_size;
+	}
+
+	tx_desc = vchan_tx_prep(&xdma_chan->vchan, &sw_desc->vdesc, flags);
+	if (!tx_desc)
+		goto failed;
+
+	return tx_desc;
+
+failed:
+	xdma_free_desc(&sw_desc->vdesc);
+
+	return NULL;
+}
+
 /**
  * xdma_device_config - Configure the DMA channel
  * @chan: DMA channel
@@ -583,7 +698,36 @@ static int xdma_alloc_chan_resources(struct dma_chan *chan)
 static enum dma_status xdma_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 				      struct dma_tx_state *state)
 {
-	return dma_cookie_status(chan, cookie, state);
+	struct xdma_chan *xdma_chan = to_xdma_chan(chan);
+	struct virt_dma_desc *vd;
+	struct xdma_desc *desc;
+	enum dma_status ret;
+	unsigned long flags;
+	unsigned int period_idx;
+	u32 residue = 0;
+
+	ret = dma_cookie_status(chan, cookie, state);
+	if (ret == DMA_COMPLETE || !state)
+		return ret;
+
+	spin_lock_irqsave(&xdma_chan->vchan.lock, flags);
+
+	vd = vchan_find_desc(&xdma_chan->vchan, cookie);
+	if (vd)
+		desc = to_xdma_desc(vd);
+	if (!desc || !desc->cyclic) {
+		spin_unlock_irqrestore(&xdma_chan->vchan.lock, flags);
+		return ret;
+	}
+
+	period_idx = desc->completed_desc_num % desc->periods;
+	residue = (desc->periods - period_idx) * desc->period_size;
+
+	spin_unlock_irqrestore(&xdma_chan->vchan.lock, flags);
+
+	dma_set_residue(state, residue);
+
+	return ret;
 }
 
 /**
@@ -599,6 +743,7 @@ static irqreturn_t xdma_channel_isr(int irq, void *dev_id)
 	struct virt_dma_desc *vd;
 	struct xdma_desc *desc;
 	int ret;
+	u32 st;
 
 	spin_lock(&xchan->vchan.lock);
 
@@ -617,6 +762,19 @@ static irqreturn_t xdma_channel_isr(int irq, void *dev_id)
 		goto out;
 
 	desc->completed_desc_num += complete_desc_num;
+
+	if (desc->cyclic) {
+		ret = regmap_read(xdev->rmap, xchan->base + XDMA_CHAN_STATUS,
+				  &st);
+		if (ret)
+			goto out;
+
+		regmap_write(xdev->rmap, xchan->base + XDMA_CHAN_STATUS, st);
+
+		vchan_cyclic_callback(vd);
+		goto out;
+	}
+
 	/*
 	 * if all data blocks are transferred, remove and complete the request
 	 */
@@ -630,7 +788,7 @@ static irqreturn_t xdma_channel_isr(int irq, void *dev_id)
 	    complete_desc_num != XDMA_DESC_BLOCK_NUM * XDMA_DESC_ADJACENT)
 		goto out;
 
-	/* transfer the rest of data */
+	/* transfer the rest of data (SG only) */
 	xdma_xfer_start(xchan);
 
 out:
@@ -930,8 +1088,10 @@ static int xdma_probe(struct platform_device *pdev)
 
 	dma_cap_set(DMA_SLAVE, xdev->dma_dev.cap_mask);
 	dma_cap_set(DMA_PRIVATE, xdev->dma_dev.cap_mask);
+	dma_cap_set(DMA_CYCLIC, xdev->dma_dev.cap_mask);
 
 	xdev->dma_dev.dev = &pdev->dev;
+	xdev->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
 	xdev->dma_dev.device_free_chan_resources = xdma_free_chan_resources;
 	xdev->dma_dev.device_alloc_chan_resources = xdma_alloc_chan_resources;
 	xdev->dma_dev.device_tx_status = xdma_tx_status;
@@ -941,6 +1101,7 @@ static int xdma_probe(struct platform_device *pdev)
 	xdev->dma_dev.filter.map = pdata->device_map;
 	xdev->dma_dev.filter.mapcnt = pdata->device_map_cnt;
 	xdev->dma_dev.filter.fn = xdma_filter_fn;
+	xdev->dma_dev.device_prep_dma_cyclic = xdma_prep_dma_cyclic;
 
 	ret = dma_async_device_register(&xdev->dma_dev);
 	if (ret) {
-- 
2.34.1

