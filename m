Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1135B69470C
	for <lists+dmaengine@lfdr.de>; Mon, 13 Feb 2023 14:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjBMNbq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Feb 2023 08:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjBMNbp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Feb 2023 08:31:45 -0500
X-Greylist: delayed 415 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Feb 2023 05:31:34 PST
Received: from out-24.mta0.migadu.com (out-24.mta0.migadu.com [91.218.175.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE4D1ABD6
        for <dmaengine@vger.kernel.org>; Mon, 13 Feb 2023 05:31:33 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676294676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3EqMwrGOz+jm0mszPNZB0XW9wyavpaseOxhiaj+8Q8o=;
        b=sjfngHBjx9M7sAOivsHCGGpNUGP/PcSlzQK5OaZEaLbsdz9bJNmBJr0a0GTuIQKeUSM5pj
        STJZEotmcJngssNGqJElukgSvbneuvPtHjVe2NCxEUNcgyKhZ2kR7AQeoqexWL10RwM+Ba
        RflxtUK+ZZHeb92d+E/N7itISHXPxT4=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     Sergey.Semin@baikalelectronics.ru
Cc:     Cai huoqing <cai.huoqing@linux.dev>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v3 2/4] dmaengine: dw-edma: Create a new dw_edma_core_ops structure to abstract controller operation
Date:   Mon, 13 Feb 2023 21:24:07 +0800
Message-Id: <20230213132411.65524-3-cai.huoqing@linux.dev>
In-Reply-To: <20230213132411.65524-1-cai.huoqing@linux.dev>
References: <20230213132411.65524-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Cai huoqing <cai.huoqing@linux.dev>

The structure dw_edma_core_ops has a set of the pointers
abstracting out the DW eDMA vX and DW HDMA Native controllers.
And use dw_edma_v0_core_register to set up operation.

Signed-off-by: Cai huoqing <cai.huoqing@linux.dev>
---
 drivers/dma/dw-edma/dw-edma-core.c    | 63 ++++++------------
 drivers/dma/dw-edma/dw-edma-core.h    | 92 +++++++++++++++++++++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c | 88 +++++++++++++++++++++----
 drivers/dma/dw-edma/dw-edma-v0-core.h | 14 +---
 4 files changed, 188 insertions(+), 69 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 1906a836f0aa..c171809beba1 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -183,6 +183,7 @@ static void vchan_free_desc(struct virt_dma_desc *vdesc)
 
 static void dw_edma_start_transfer(struct dw_edma_chan *chan)
 {
+	struct dw_edma *dw = chan->dw;
 	struct dw_edma_chunk *child;
 	struct dw_edma_desc *desc;
 	struct virt_dma_desc *vd;
@@ -200,7 +201,7 @@ static void dw_edma_start_transfer(struct dw_edma_chan *chan)
 	if (!child)
 		return;
 
-	dw_edma_v0_core_start(child, !desc->xfer_sz);
+	dw_edma_core_start(dw, child, !desc->xfer_sz);
 	desc->xfer_sz += child->ll_region.sz;
 	dw_edma_free_burst(child);
 	list_del(&child->list);
@@ -285,7 +286,7 @@ static int dw_edma_device_terminate_all(struct dma_chan *dchan)
 		chan->configured = false;
 	} else if (chan->status == EDMA_ST_IDLE) {
 		chan->configured = false;
-	} else if (dw_edma_v0_core_ch_status(chan) == DMA_COMPLETE) {
+	} else if (dw_edma_core_ch_status(chan) == DMA_COMPLETE) {
 		/*
 		 * The channel is in a false BUSY state, probably didn't
 		 * receive or lost an interrupt
@@ -588,13 +589,13 @@ dw_edma_device_prep_interleaved_dma(struct dma_chan *dchan,
 	return dw_edma_device_transfer(&xfer);
 }
 
-static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
+void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 {
 	struct dw_edma_desc *desc;
 	struct virt_dma_desc *vd;
 	unsigned long flags;
 
-	dw_edma_v0_core_clear_done_int(chan);
+	dw_edma_core_clear_done_int(chan);
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
 	vd = vchan_next_desc(&chan->vc);
@@ -631,12 +632,12 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 }
 
-static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
+void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
 {
 	struct virt_dma_desc *vd;
 	unsigned long flags;
 
-	dw_edma_v0_core_clear_abort_int(chan);
+	dw_edma_core_clear_abort_int(chan);
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
 	vd = vchan_next_desc(&chan->vc);
@@ -651,41 +652,11 @@ static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
 
 static irqreturn_t dw_edma_interrupt(int irq, void *data, bool write)
 {
+	enum dw_edma_dir dir = write ? EDMA_DIR_WRITE : EDMA_DIR_READ;
 	struct dw_edma_irq *dw_irq = data;
-	struct dw_edma *dw = dw_irq->dw;
-	unsigned long total, pos, val;
-	unsigned long off;
-	u32 mask;
-
-	if (write) {
-		total = dw->wr_ch_cnt;
-		off = 0;
-		mask = dw_irq->wr_mask;
-	} else {
-		total = dw->rd_ch_cnt;
-		off = dw->wr_ch_cnt;
-		mask = dw_irq->rd_mask;
-	}
-
-	val = dw_edma_v0_core_status_done_int(dw, write ?
-							  EDMA_DIR_WRITE :
-							  EDMA_DIR_READ);
-	val &= mask;
-	for_each_set_bit(pos, &val, total) {
-		struct dw_edma_chan *chan = &dw->chan[pos + off];
-
-		dw_edma_done_interrupt(chan);
-	}
-
-	val = dw_edma_v0_core_status_abort_int(dw, write ?
-							   EDMA_DIR_WRITE :
-							   EDMA_DIR_READ);
-	val &= mask;
-	for_each_set_bit(pos, &val, total) {
-		struct dw_edma_chan *chan = &dw->chan[pos + off];
 
-		dw_edma_abort_interrupt(chan);
-	}
+	dw_edma_core_done_handle(dw_irq, dir);
+	dw_edma_core_abort_handle(dw_irq, dir);
 
 	return IRQ_HANDLED;
 }
@@ -806,7 +777,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 
 		vchan_init(&chan->vc, dma);
 
-		dw_edma_v0_core_device_config(chan);
+		dw_edma_core_ch_config(chan);
 	}
 
 	/* Set DMA channel capabilities */
@@ -951,14 +922,16 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 
 	dw->chip = chip;
 
+	dw_edma_v0_core_register(dw);
+
 	raw_spin_lock_init(&dw->lock);
 
 	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt,
-			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_WRITE));
+			      dw_edma_core_ch_count(dw, EDMA_DIR_WRITE));
 	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
 
 	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt,
-			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_READ));
+			      dw_edma_core_ch_count(dw, EDMA_DIR_READ));
 	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
 
 	if (!dw->wr_ch_cnt && !dw->rd_ch_cnt)
@@ -977,7 +950,7 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 		 dev_name(chip->dev));
 
 	/* Disable eDMA, only to establish the ideal initial conditions */
-	dw_edma_v0_core_off(dw);
+	dw_edma_core_off(dw);
 
 	/* Request IRQs */
 	err = dw_edma_irq_request(dw, &wr_alloc, &rd_alloc);
@@ -990,7 +963,7 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 		goto err_irq_free;
 
 	/* Turn debugfs on */
-	dw_edma_v0_core_debugfs_on(dw);
+	dw_edma_core_debugfs_on(dw);
 
 	chip->dw = dw;
 
@@ -1016,7 +989,7 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 		return -ENODEV;
 
 	/* Disable eDMA */
-	dw_edma_v0_core_off(dw);
+	dw_edma_core_off(dw);
 
 	/* Free irqs */
 	for (i = (dw->nr_irqs - 1); i >= 0; i--)
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 0ab2b6dba880..2555ae0e1b8b 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -111,6 +111,23 @@ struct dw_edma {
 	raw_spinlock_t			lock;		/* Only for legacy */
 
 	struct dw_edma_chip             *chip;
+
+	const struct dw_edma_core_ops	*core;
+};
+
+struct dw_edma_core_ops {
+	void (*off)(struct dw_edma *dw);
+	u16 (*ch_count)(struct dw_edma *dw, enum dw_edma_dir dir);
+	enum dma_status (*ch_status)(struct dw_edma_chan *chan);
+	void (*clear_done_int)(struct dw_edma_chan *chan);
+	void (*clear_abort_int)(struct dw_edma_chan *chan);
+	void (*done_handle)(struct dw_edma_irq *dw_irq,
+			    enum dw_edma_dir dir);
+	void (*abort_handle)(struct dw_edma_irq *dw_irq,
+			     enum dw_edma_dir dir);
+	void (*start)(struct dw_edma_chunk *chunk, bool first);
+	void (*ch_config)(struct dw_edma_chan *chan);
+	void (*debugfs_on)(struct dw_edma *dw);
 };
 
 struct dw_edma_sg {
@@ -136,6 +153,9 @@ struct dw_edma_transfer {
 	enum dw_edma_xfer_type		type;
 };
 
+void dw_edma_done_interrupt(struct dw_edma_chan *chan);
+void dw_edma_abort_interrupt(struct dw_edma_chan *chan);
+
 static inline
 struct dw_edma_chan *vc2dw_edma_chan(struct virt_dma_chan *vc)
 {
@@ -148,4 +168,76 @@ struct dw_edma_chan *dchan2dw_edma_chan(struct dma_chan *dchan)
 	return vc2dw_edma_chan(to_virt_chan(dchan));
 }
 
+static inline
+void dw_edma_core_off(struct dw_edma *dw)
+{
+	dw->core->off(dw);
+}
+
+static inline
+u16 dw_edma_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
+{
+	return dw->core->ch_count(dw, dir);
+}
+
+static inline
+enum dma_status dw_edma_core_ch_status(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+
+	return dw->core->ch_status(chan);
+}
+
+static inline
+void dw_edma_core_clear_done_int(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+
+	dw->core->clear_done_int(chan);
+}
+
+static inline
+void dw_edma_core_clear_abort_int(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+
+	dw->core->clear_abort_int(chan);
+}
+
+static inline
+void dw_edma_core_done_handle(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir)
+{
+	struct dw_edma *dw = dw_irq->dw;
+
+	dw->core->done_handle(dw_irq, dir);
+}
+
+static inline
+void dw_edma_core_abort_handle(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir)
+{
+	struct dw_edma *dw = dw_irq->dw;
+
+	dw->core->abort_handle(dw_irq, dir);
+}
+
+static inline
+void dw_edma_core_start(struct dw_edma *dw, struct dw_edma_chunk *chunk, bool first)
+{
+	dw->core->start(chunk, first);
+}
+
+static inline
+void dw_edma_core_ch_config(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+
+	dw->core->ch_config(chan);
+}
+
+static inline
+void dw_edma_core_debugfs_on(struct dw_edma *dw)
+{
+	dw->core->debugfs_on(dw);
+}
+
 #endif /* _DW_EDMA_CORE_H */
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 72e79a0c0a4e..73dcf72ba3a9 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -216,7 +216,7 @@ static inline u64 readq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 	readq_ch(dw, dir, ch, &(__dw_ch_regs(dw, dir, ch)->name))
 
 /* eDMA management callbacks */
-void dw_edma_v0_core_off(struct dw_edma *dw)
+static void dw_edma_v0_core_off(struct dw_edma *dw)
 {
 	SET_BOTH_32(dw, int_mask,
 		    EDMA_V0_DONE_INT_MASK | EDMA_V0_ABORT_INT_MASK);
@@ -225,7 +225,7 @@ void dw_edma_v0_core_off(struct dw_edma *dw)
 	SET_BOTH_32(dw, engine_en, 0);
 }
 
-u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
+static u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
 {
 	u32 num_ch;
 
@@ -242,7 +242,7 @@ u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
 	return (u16)num_ch;
 }
 
-enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
+static enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
 	u32 tmp;
@@ -258,7 +258,7 @@ enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
 		return DMA_ERROR;
 }
 
-void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
+static void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
 
@@ -266,7 +266,7 @@ void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
 		  FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id)));
 }
 
-void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
+static void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
 
@@ -274,18 +274,66 @@ void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
 		  FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id)));
 }
 
-u32 dw_edma_v0_core_status_done_int(struct dw_edma *dw, enum dw_edma_dir dir)
+static u32 dw_edma_v0_core_status_done_int(struct dw_edma *dw, enum dw_edma_dir dir)
 {
 	return FIELD_GET(EDMA_V0_DONE_INT_MASK,
 			 GET_RW_32(dw, dir, int_status));
 }
 
-u32 dw_edma_v0_core_status_abort_int(struct dw_edma *dw, enum dw_edma_dir dir)
+static u32 dw_edma_v0_core_status_abort_int(struct dw_edma *dw, enum dw_edma_dir dir)
 {
 	return FIELD_GET(EDMA_V0_ABORT_INT_MASK,
 			 GET_RW_32(dw, dir, int_status));
 }
 
+static
+void dw_edma_v0_core_done_handle(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir)
+{
+	struct dw_edma *dw = dw_irq->dw;
+	unsigned long total, pos, val;
+	unsigned long off;
+	u32 mask;
+
+	if (dir == EDMA_DIR_WRITE) {
+		total = dw->wr_ch_cnt;
+		off = 0;
+		mask = dw_irq->wr_mask;
+	} else {
+		total = dw->rd_ch_cnt;
+		off = dw->wr_ch_cnt;
+		mask = dw_irq->rd_mask;
+	}
+
+	val = dw_edma_v0_core_status_done_int(dw, dir);
+	val &= mask;
+	for_each_set_bit(pos, &val, total)
+		dw_edma_done_interrupt(&dw->chan[pos + off]);
+}
+
+static
+void dw_edma_v0_core_abort_handle(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir)
+{
+	struct dw_edma *dw = dw_irq->dw;
+	unsigned long total, pos, val;
+	unsigned long off;
+	u32 mask;
+
+	if (dir == EDMA_DIR_WRITE) {
+		total = dw->wr_ch_cnt;
+		off = 0;
+		mask = dw_irq->wr_mask;
+	} else {
+		total = dw->rd_ch_cnt;
+		off = dw->wr_ch_cnt;
+		mask = dw_irq->rd_mask;
+	}
+
+	val = dw_edma_v0_core_status_abort_int(dw, dir);
+	val &= mask;
+	for_each_set_bit(pos, &val, total)
+		dw_edma_abort_interrupt(&dw->chan[pos + off]);
+}
+
 static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 				     u32 control, u32 size, u64 sar, u64 dar)
 {
@@ -356,7 +404,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	dw_edma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
 }
 
-void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
+static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma *dw = chan->dw;
@@ -427,7 +475,7 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
 }
 
-int dw_edma_v0_core_device_config(struct dw_edma_chan *chan)
+static void dw_edma_v0_core_ch_config(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
 	u32 tmp = 0;
@@ -494,12 +542,28 @@ int dw_edma_v0_core_device_config(struct dw_edma_chan *chan)
 		SET_RW_32(dw, chan->dir, ch67_imwr_data, tmp);
 		break;
 	}
-
-	return 0;
 }
 
 /* eDMA debugfs callbacks */
-void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
+static void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
 {
 	dw_edma_v0_debugfs_on(dw);
 }
+
+static const struct dw_edma_core_ops edma_core = {
+	.off = dw_edma_v0_core_off,
+	.ch_count = dw_edma_v0_core_ch_count,
+	.ch_status = dw_edma_v0_core_ch_status,
+	.clear_done_int = dw_edma_v0_core_clear_done_int,
+	.clear_abort_int = dw_edma_v0_core_clear_abort_int,
+	.done_handle = dw_edma_v0_core_done_handle,
+	.abort_handle = dw_edma_v0_core_abort_handle,
+	.start = dw_edma_v0_core_start,
+	.ch_config = dw_edma_v0_core_ch_config,
+	.debugfs_on = dw_edma_v0_core_debugfs_on,
+};
+
+void dw_edma_v0_core_register(struct dw_edma *dw)
+{
+	dw->core = &edma_core;
+}
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.h b/drivers/dma/dw-edma/dw-edma-v0-core.h
index ab96a1f48080..04a882222f99 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.h
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.h
@@ -11,17 +11,7 @@
 
 #include <linux/dma/edma.h>
 
-/* eDMA management callbacks */
-void dw_edma_v0_core_off(struct dw_edma *chan);
-u16 dw_edma_v0_core_ch_count(struct dw_edma *chan, enum dw_edma_dir dir);
-enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan);
-void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan);
-void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan);
-u32 dw_edma_v0_core_status_done_int(struct dw_edma *chan, enum dw_edma_dir dir);
-u32 dw_edma_v0_core_status_abort_int(struct dw_edma *chan, enum dw_edma_dir dir);
-void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first);
-int dw_edma_v0_core_device_config(struct dw_edma_chan *chan);
-/* eDMA debug fs callbacks */
-void dw_edma_v0_core_debugfs_on(struct dw_edma *dw);
+/* eDMA core register */
+void dw_edma_v0_core_register(struct dw_edma *dw);
 
 #endif /* _DW_EDMA_V0_CORE_H */
-- 
2.34.1

