Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F194D5112AE
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 09:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353952AbiD0HmB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 03:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349001AbiD0HmB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 03:42:01 -0400
X-Greylist: delayed 478 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 27 Apr 2022 00:38:50 PDT
Received: from mail-m121145.qiye.163.com (mail-m121145.qiye.163.com [115.236.121.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B949C8486;
        Wed, 27 Apr 2022 00:38:50 -0700 (PDT)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 3D9EF80074E;
        Wed, 27 Apr 2022 15:30:45 +0800 (CST)
From:   Sugar Zhang <sugar.zhang@rock-chips.com>
To:     vkoul@kernel.org
Cc:     Sugar Zhang <sugar.zhang@rock-chips.com>,
        Huibin Hong <huibin.hong@rock-chips.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: pl330: Improve dma cyclic transfers efficiency
Date:   Wed, 27 Apr 2022 15:30:23 +0800
Message-Id: <1651044623-594-1-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUlKS0tKN1dZLVlBSVdZDwkaFQgSH1lBWRpIGRhWTB5NHUpMHx
        1JTUNCVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktITkJVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OC46KSo5DT0*SR06DhUONQMj
        CB0wCy1VSlVKTU5KS09PTU9OQ0hPVTMWGhIXVQgOHBoJVQETGhUcOwkUGBBWGBMSCwhVGBQWRVlX
        WRILWUFZTkNVSUlVTFVKSk9ZV1kIAVlBSk5NS043Bg++
X-HM-Tid: 0a8069edfa08b03akuuu3d9ef80074e
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Currently, the driver implements cyclic transfers by desc list.
Each desc describes one period and started by CPU after last
one done(tasklet), which maybe delayed due to schedule or
heavy system load, which will cause device FIFO xrun.

Now, We introduced infinitely cyclic without CPU intervention
to fix this case: each period buffer elapsed, just throwing one
irq to CPU, and keep going transfer without CPU.

e.g. aplay with period-size: 1024, buffer-size: 4096

/# aplay -D hw:0,0 --period-size=1024 --buffer-size=4096 -r 48000
-c 2 -f s16_le /dev/zero

Dump MCGEN:

+ #define PL330_DEBUG_MCGEN

Before:

 916000:  DMAMOV CCR 0x9d0275
 916006:  DMAMOV SAR 0xa34000
 91600c:  DMAMOV DAR 0xffae8030
 916012:  DMALP_1 127
 916014:  DMAFLUSHP 22
 916016:  DMAWFPB 22
 916018:  DMALDB
 916019:  DMASTPB 22
 91601b:  DMALPENDA_1 bjmpto_7
 91601d:  DMASEV 0
 91601f:  DMAEND

 916100:  DMAMOV CCR 0x9d0275
 916106:  DMAMOV SAR 0xa35000
 91610c:  DMAMOV DAR 0xffae8030
 916112:  DMALP_1 127
 916114:  DMAFLUSHP 22
 916116:  DMAWFPB 22
 916118:  DMALDB
 916119:  DMASTPB 22
 91611b:  DMALPENDA_1 bjmpto_7
 91611d:  DMASEV 0
 91611f:  DMAEND

 916000:  DMAMOV CCR 0x9d0275
 916006:  DMAMOV SAR 0xa36000
 91600c:  DMAMOV DAR 0xffae8030
 916012:  DMALP_1 127
 916014:  DMAFLUSHP 22
 916016:  DMAWFPB 22
 916018:  DMALDB
 916019:  DMASTPB 22
 91601b:  DMALPENDA_1 bjmpto_7
 91601d:  DMASEV 0
 91601f:  DMAEND

 916100:  DMAMOV CCR 0x9d0275
 916106:  DMAMOV SAR 0xa37000
 91610c:  DMAMOV DAR 0xffae8030
 916112:  DMALP_1 127
 916114:  DMAFLUSHP 22
 916116:  DMAWFPB 22
 916118:  DMALDB
 916119:  DMASTPB 22
 91611b:  DMALPENDA_1 bjmpto_7
 91611d:  DMASEV 0
 91611f:  DMAEND

 916000:  DMAMOV CCR 0x9d0275
 916006:  DMAMOV SAR 0xa34000
 91600c:  DMAMOV DAR 0xffae8030
 916012:  DMALP_1 127
 916014:  DMAFLUSHP 22
 916016:  DMAWFPB 22
 916018:  DMALDB
 916019:  DMASTPB 22
 91601b:  DMALPENDA_1 bjmpto_7
 91601d:  DMASEV 0
 91601f:  DMAEND

 ...

After:

 916000:  DMAMOV CCR 0x9d0275
 916006:  DMAMOV SAR 0xa34000
 91600c:  DMAMOV DAR 0xffae8030
 916012:  DMALP_0 3
 916014:  DMALP_1 127
 916016:  DMAFLUSHP 22
 916018:  DMAWFPB 22
 91601a:  DMALDB
 91601b:  DMASTPB 22
 91601d:  DMALPENDA_1 bjmpto_7
 91601f:  DMASEV 0
 916021:  DMALPENDA_0 bjmpto_d
 916023:  DMALPFEA_1 bjmpto_1d

Signed-off-by: Huibin Hong <huibin.hong@rock-chips.com>
Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 drivers/dma/pl330.c | 300 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 197 insertions(+), 103 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index ccd430e..884b3f6 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -239,6 +239,7 @@ enum pl330_byteswap {
 
 #define BYTE_TO_BURST(b, ccr)	((b) / BRST_SIZE(ccr) / BRST_LEN(ccr))
 #define BURST_TO_BYTE(c, ccr)	((c) * BRST_SIZE(ccr) * BRST_LEN(ccr))
+#define BYTE_MOD_BURST_LEN(b, ccr)	(((b) / BRST_SIZE(ccr)) % BRST_LEN(ccr))
 
 /*
  * With 256 bytes, we can do more than 2.5MB and 5MB xfers per req
@@ -449,9 +450,6 @@ struct dma_pl330_chan {
 	enum dma_data_direction dir;
 	struct dma_slave_config slave_config;
 
-	/* for cyclic capability */
-	bool cyclic;
-
 	/* for runtime pm tracking */
 	bool active;
 };
@@ -539,6 +537,10 @@ struct dma_pl330_desc {
 	unsigned peri:5;
 	/* Hook to attach to DMAC's list of reqs with due callback */
 	struct list_head rqd;
+
+	/* For cyclic capability */
+	bool cyclic;
+	size_t num_periods;
 };
 
 struct _xfer_spec {
@@ -1362,6 +1364,108 @@ static inline int _loop(struct pl330_dmac *pl330, unsigned dry_run, u8 buf[],
 	return off;
 }
 
+static int _period(struct pl330_dmac *pl330, unsigned int dry_run, u8 buf[],
+		   unsigned long bursts, const struct _xfer_spec *pxs, int ev)
+{
+	unsigned int lcnt1, ljmp1;
+	int cyc, off = 0, num_dregs = 0;
+	struct _arg_LPEND lpend;
+	struct pl330_xfer *x = &pxs->desc->px;
+
+	if (bursts > 256) {
+		lcnt1 = 256;
+		cyc = bursts / 256;
+	} else {
+		lcnt1 = bursts;
+		cyc = 1;
+	}
+
+	/* loop1 */
+	off += _emit_LP(dry_run, &buf[off], 1, lcnt1);
+	ljmp1 = off;
+	off += _bursts(pl330, dry_run, &buf[off], pxs, cyc);
+	lpend.cond = ALWAYS;
+	lpend.forever = false;
+	lpend.loop = 1;
+	lpend.bjump = off - ljmp1;
+	off += _emit_LPEND(dry_run, &buf[off], &lpend);
+
+	/* remainder */
+	lcnt1 = bursts - (lcnt1 * cyc);
+
+	if (lcnt1) {
+		off += _emit_LP(dry_run, &buf[off], 1, lcnt1);
+		ljmp1 = off;
+		off += _bursts(pl330, dry_run, &buf[off], pxs, 1);
+		lpend.cond = ALWAYS;
+		lpend.forever = false;
+		lpend.loop = 1;
+		lpend.bjump = off - ljmp1;
+		off += _emit_LPEND(dry_run, &buf[off], &lpend);
+	}
+
+	num_dregs = BYTE_MOD_BURST_LEN(x->bytes, pxs->ccr);
+
+	if (num_dregs) {
+		off += _dregs(pl330, dry_run, &buf[off], pxs, num_dregs);
+		off += _emit_MOV(dry_run, &buf[off], CCR, pxs->ccr);
+	}
+
+	off += _emit_SEV(dry_run, &buf[off], ev);
+
+	return off;
+}
+
+static inline int _loop_cyclic(struct pl330_dmac *pl330, unsigned int dry_run,
+			       u8 buf[], unsigned long bursts,
+			       const struct _xfer_spec *pxs, int ev)
+{
+	int off, periods, residue, i;
+	unsigned int lcnt0, ljmp0, ljmpfe;
+	struct _arg_LPEND lpend;
+	struct pl330_xfer *x = &pxs->desc->px;
+
+	off = 0;
+	ljmpfe = off;
+	lcnt0 = pxs->desc->num_periods;
+	periods = 1;
+
+	while (lcnt0 > 256) {
+		periods++;
+		lcnt0 = pxs->desc->num_periods / periods;
+	}
+
+	residue = pxs->desc->num_periods % periods;
+
+	/* forever loop */
+	off += _emit_MOV(dry_run, &buf[off], SAR, x->src_addr);
+	off += _emit_MOV(dry_run, &buf[off], DAR, x->dst_addr);
+
+	/* loop0 */
+	off += _emit_LP(dry_run, &buf[off], 0,  lcnt0);
+	ljmp0 = off;
+
+	for (i = 0; i < periods; i++)
+		off += _period(pl330, dry_run, &buf[off], bursts, pxs, ev);
+
+	lpend.cond = ALWAYS;
+	lpend.forever = false;
+	lpend.loop = 0;
+	lpend.bjump = off - ljmp0;
+	off += _emit_LPEND(dry_run, &buf[off], &lpend);
+
+	for (i = 0; i < residue; i++)
+		off += _period(pl330, dry_run, &buf[off], bursts, pxs, ev);
+
+	lpend.cond = ALWAYS;
+	lpend.forever = true;
+	lpend.loop = 1;
+	lpend.bjump = off - ljmpfe;
+	off +=  _emit_LPEND(dry_run, &buf[off], &lpend);
+
+	return off;
+}
+
 static inline int _setup_loops(struct pl330_dmac *pl330,
 			       unsigned dry_run, u8 buf[],
 			       const struct _xfer_spec *pxs)
@@ -1401,6 +1505,21 @@ static inline int _setup_xfer(struct pl330_dmac *pl330,
 	return off;
 }
 
+static inline int _setup_xfer_cyclic(struct pl330_dmac *pl330,
+				     unsigned int dry_run, u8 buf[],
+				     const struct _xfer_spec *pxs, int ev)
+{
+	struct pl330_xfer *x = &pxs->desc->px;
+	u32 ccr = pxs->ccr;
+	unsigned long bursts = BYTE_TO_BURST(x->bytes, ccr);
+	int off = 0;
+
+	/* Setup Loop(s) */
+	off += _loop_cyclic(pl330, dry_run, &buf[off], bursts, pxs, ev);
+
+	return off;
+}
+
 /*
  * A req is a sequence of one or more xfer units.
  * Returns the number of bytes taken to setup the MC for the req.
@@ -1418,12 +1537,17 @@ static int _setup_req(struct pl330_dmac *pl330, unsigned dry_run,
 	/* DMAMOV CCR, ccr */
 	off += _emit_MOV(dry_run, &buf[off], CCR, pxs->ccr);
 
-	off += _setup_xfer(pl330, dry_run, &buf[off], pxs);
+	if (!pxs->desc->cyclic) {
+		off += _setup_xfer(pl330, dry_run, &buf[off], pxs);
 
-	/* DMASEV peripheral/event */
-	off += _emit_SEV(dry_run, &buf[off], thrd->ev);
-	/* DMAEND */
-	off += _emit_END(dry_run, &buf[off]);
+		/* DMASEV peripheral/event */
+		off += _emit_SEV(dry_run, &buf[off], thrd->ev);
+		/* DMAEND */
+		off += _emit_END(dry_run, &buf[off]);
+	} else {
+		off += _setup_xfer_cyclic(pl330, dry_run, &buf[off],
+					  pxs, thrd->ev);
+	}
 
 	return off;
 }
@@ -1697,15 +1821,17 @@ static int pl330_update(struct pl330_dmac *pl330)
 
 			/* Detach the req */
 			descdone = thrd->req[active].desc;
-			thrd->req[active].desc = NULL;
-
-			thrd->req_running = -1;
-
-			/* Get going again ASAP */
-			_start(thrd);
-
-			/* For now, just make a list of callbacks to be done */
-			list_add_tail(&descdone->rqd, &pl330->req_done);
+			if (descdone) {
+				if (!descdone->cyclic) {
+					thrd->req[active].desc = NULL;
+					thrd->req_running = -1;
+					/* Get going again ASAP */
+					_start(thrd);
+				}
+
+				/* For now, just make a list of callbacks to be done */
+				list_add_tail(&descdone->rqd, &pl330->req_done);
+			}
 		}
 	}
 
@@ -2070,12 +2196,25 @@ static void pl330_tasklet(struct tasklet_struct *t)
 	spin_lock_irqsave(&pch->lock, flags);
 
 	/* Pick up ripe tomatoes */
-	list_for_each_entry_safe(desc, _dt, &pch->work_list, node)
+	list_for_each_entry_safe(desc, _dt, &pch->work_list, node) {
 		if (desc->status == DONE) {
-			if (!pch->cyclic)
+			if (!desc->cyclic) {
 				dma_cookie_complete(&desc->txd);
-			list_move_tail(&desc->node, &pch->completed_list);
+				list_move_tail(&desc->node, &pch->completed_list);
+			} else {
+				struct dmaengine_desc_callback cb;
+
+				desc->status = BUSY;
+				dmaengine_desc_get_callback(&desc->txd, &cb);
+
+				if (dmaengine_desc_callback_valid(&cb)) {
+					spin_unlock_irqrestore(&pch->lock, flags);
+					dmaengine_desc_callback_invoke(&cb, NULL);
+					spin_lock_irqsave(&pch->lock, flags);
+				}
+			}
 		}
+	}
 
 	/* Try to submit a req imm. next to the last completed cookie */
 	fill_queue(pch);
@@ -2101,20 +2240,8 @@ static void pl330_tasklet(struct tasklet_struct *t)
 
 		dmaengine_desc_get_callback(&desc->txd, &cb);
 
-		if (pch->cyclic) {
-			desc->status = PREP;
-			list_move_tail(&desc->node, &pch->work_list);
-			if (power_down) {
-				pch->active = true;
-				spin_lock(&pch->thread->dmac->lock);
-				_start(pch->thread);
-				spin_unlock(&pch->thread->dmac->lock);
-				power_down = false;
-			}
-		} else {
-			desc->status = FREE;
-			list_move_tail(&desc->node, &pch->dmac->desc_pool);
-		}
+		desc->status = FREE;
+		list_move_tail(&desc->node, &pch->dmac->desc_pool);
 
 		dma_descriptor_unmap(&desc->txd);
 
@@ -2162,7 +2289,6 @@ static int pl330_alloc_chan_resources(struct dma_chan *chan)
 	spin_lock_irqsave(&pl330->lock, flags);
 
 	dma_cookie_init(chan);
-	pch->cyclic = false;
 
 	pch->thread = pl330_request_channel(pl330);
 	if (!pch->thread) {
@@ -2356,8 +2482,7 @@ static void pl330_free_chan_resources(struct dma_chan *chan)
 	pl330_release_channel(pch->thread);
 	pch->thread = NULL;
 
-	if (pch->cyclic)
-		list_splice_tail_init(&pch->work_list, &pch->dmac->desc_pool);
+	list_splice_tail_init(&pch->work_list, &pch->dmac->desc_pool);
 
 	spin_unlock_irqrestore(&pl330->lock, flags);
 	pm_runtime_mark_last_busy(pch->dmac->ddma.dev);
@@ -2420,7 +2545,7 @@ pl330_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 
 	/* Check in pending list */
 	list_for_each_entry(desc, &pch->work_list, node) {
-		if (desc->status == DONE)
+		if (desc->status == DONE && !desc->cyclic)
 			transferred = desc->bytes_requested;
 		else if (running && desc == running)
 			transferred =
@@ -2502,10 +2627,7 @@ static dma_cookie_t pl330_tx_submit(struct dma_async_tx_descriptor *tx)
 	/* Assign cookies to all nodes */
 	while (!list_empty(&last->node)) {
 		desc = list_entry(last->node.next, struct dma_pl330_desc, node);
-		if (pch->cyclic) {
-			desc->txd.callback = last->txd.callback;
-			desc->txd.callback_param = last->txd.callback_param;
-		}
+
 		desc->last = false;
 
 		dma_cookie_assign(&desc->txd);
@@ -2607,6 +2729,9 @@ static struct dma_pl330_desc *pl330_get_desc(struct dma_pl330_chan *pch)
 	desc->peri = peri_id ? pch->chan.chan_id : 0;
 	desc->rqcfg.pcfg = &pch->dmac->pcfg;
 
+	desc->cyclic = false;
+	desc->num_periods = 1;
+
 	dma_async_tx_descriptor_init(&desc->txd, &pch->chan);
 
 	return desc;
@@ -2670,12 +2795,10 @@ static struct dma_async_tx_descriptor *pl330_prep_dma_cyclic(
 		size_t period_len, enum dma_transfer_direction direction,
 		unsigned long flags)
 {
-	struct dma_pl330_desc *desc = NULL, *first = NULL;
+	struct dma_pl330_desc *desc = NULL;
 	struct dma_pl330_chan *pch = to_pchan(chan);
-	struct pl330_dmac *pl330 = pch->dmac;
-	unsigned int i;
-	dma_addr_t dst;
-	dma_addr_t src;
+	dma_addr_t dst = 0;
+	dma_addr_t src = 0;
 
 	if (len % period_len != 0)
 		return NULL;
@@ -2691,67 +2814,38 @@ static struct dma_async_tx_descriptor *pl330_prep_dma_cyclic(
 	if (!pl330_prep_slave_fifo(pch, direction))
 		return NULL;
 
-	for (i = 0; i < len / period_len; i++) {
-		desc = pl330_get_desc(pch);
-		if (!desc) {
-			unsigned long iflags;
-
-			dev_err(pch->dmac->ddma.dev, "%s:%d Unable to fetch desc\n",
-				__func__, __LINE__);
-
-			if (!first)
-				return NULL;
-
-			spin_lock_irqsave(&pl330->pool_lock, iflags);
-
-			while (!list_empty(&first->node)) {
-				desc = list_entry(first->node.next,
-						struct dma_pl330_desc, node);
-				list_move_tail(&desc->node, &pl330->desc_pool);
-			}
-
-			list_move_tail(&first->node, &pl330->desc_pool);
-
-			spin_unlock_irqrestore(&pl330->pool_lock, iflags);
-
-			return NULL;
-		}
+	desc = pl330_get_desc(pch);
+	if (!desc) {
+		dev_err(pch->dmac->ddma.dev, "%s:%d Unable to fetch desc\n",
+			__func__, __LINE__);
+		return NULL;
+	}
 
-		switch (direction) {
-		case DMA_MEM_TO_DEV:
-			desc->rqcfg.src_inc = 1;
-			desc->rqcfg.dst_inc = 0;
-			src = dma_addr;
-			dst = pch->fifo_dma;
-			break;
-		case DMA_DEV_TO_MEM:
-			desc->rqcfg.src_inc = 0;
-			desc->rqcfg.dst_inc = 1;
-			src = pch->fifo_dma;
+	switch (direction) {
+	case DMA_MEM_TO_DEV:
+		desc->rqcfg.src_inc = 1;
+		desc->rqcfg.dst_inc = 0;
+		src = dma_addr;
+		dst = pch->fifo_dma;
+		break;
+	case DMA_DEV_TO_MEM:
+		desc->rqcfg.src_inc = 0;
+		desc->rqcfg.dst_inc = 1;
+		src = pch->fifo_dma;
 			dst = dma_addr;
-			break;
-		default:
-			break;
-		}
-
-		desc->rqtype = direction;
-		desc->rqcfg.brst_size = pch->burst_sz;
-		desc->rqcfg.brst_len = pch->burst_len;
-		desc->bytes_requested = period_len;
-		fill_px(&desc->px, dst, src, period_len);
-
-		if (!first)
-			first = desc;
-		else
-			list_add_tail(&desc->node, &first->node);
-
-		dma_addr += period_len;
+		break;
+	default:
+		break;
 	}
 
-	if (!desc)
-		return NULL;
+	desc->rqtype = direction;
+	desc->rqcfg.brst_size = pch->burst_sz;
+	desc->rqcfg.brst_len = pch->burst_len;
+	desc->bytes_requested = len;
+	fill_px(&desc->px, dst, src, period_len);
 
-	pch->cyclic = true;
+	desc->cyclic = true;
+	desc->num_periods = len / period_len;
 	desc->txd.flags = flags;
 
 	return &desc->txd;
-- 
2.7.4

