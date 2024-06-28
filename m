Return-Path: <dmaengine+bounces-2592-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3C591C274
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2024 17:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 314C6B225A9
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2024 15:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CE01BE846;
	Fri, 28 Jun 2024 15:17:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D7C1DDD1;
	Fri, 28 Jun 2024 15:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587864; cv=none; b=Ve3Pjq8XQLjmWmD09Jiw5Ot9vr41ymI3G9WZBUNyF6d+mN1ruxIOwB79k19tR+jH5jDKvHi/ZaOCjG+7wT72JqMaMfCxoXlmBaVNPK7y+aqAETUKw2p0Ki0xlhpRU562bR4ClYaNAQ/BjHvP1tbcOVlzKwONJWFfd9EyIAUmMsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587864; c=relaxed/simple;
	bh=ltQYSMDVECX+wgu+HQ20UUu9svqH3/sfKqO503XEsWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cfQf2vSTEQmtcCZlnunSqAsA/isuZ8svARqkFeJXl1Ys+qAYm0YZTjT+/y7H3x6krWaFVlx+p3FwZd5QOK9qbFJO8w9SGylQfDmS6LLwJBtofBaUzKVNtBqHU+sC7wZRwmuwj2kwJ839tt9OaJvyCCz52/vSqf4YpjNjctiJeno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.09,169,1716217200"; 
   d="scan'208";a="213593811"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 29 Jun 2024 00:17:34 +0900
Received: from localhost.localdomain (unknown [10.226.93.121])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 833AD4006A9A;
	Sat, 29 Jun 2024 00:17:31 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Hien Huynh <hien.huynh.px@renesas.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	dmaengine@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH] dmaengine: sh: rz-dmac: Add support for SCIF DMA
Date: Fri, 28 Jun 2024 16:17:26 +0100
Message-ID: <20240628151728.84470-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sh_sci driver supports dma with pio mode as fallback. When the DMA Rx
time out happens, it switches to pio mode and the timer function has the
below dma callbacks

rx_timer_fn() of the sh-sci.c:
	dmaengine_pause();		/* [1] */
	...
	dmaengine_tx_status();		/* [2] */
	...
	dmaengine_terminate_all();	/* [3] */

Update [1] to re-enable the interrupt by clearing the DMARS. RZ/G2L SoC
use the same signal for both interrupt and DMA transfer requests. The
signal works as a DMA transfer request signal by setting DMARS, and
subsequent interrupt requests to the interrupt controller are
masked.

Update [2] to calculate residue, so that sh_sci driver can work on
leftover data from DMA operation during pio mode.

Update [3] to invalidate hw descriptors for reuse.

Based on similar work done for rcar_dmac for supporting scif dma.
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 193 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 192 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 65a27c5a7bce..3ef4dda51c8e 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -109,10 +109,12 @@ struct rz_dmac {
  * Registers
  */
 
+#define CRTB				0x0020
 #define CHSTAT				0x0024
 #define CHCTRL				0x0028
 #define CHCFG				0x002c
 #define NXLA				0x0038
+#define CRLA				0x003c
 
 #define DCTRL				0x0000
 
@@ -533,11 +535,15 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 static int rz_dmac_terminate_all(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
+	struct rz_lmdesc *lmdesc = channel->lmdesc.base;
 	unsigned long flags;
 	LIST_HEAD(head);
 
 	rz_dmac_disable_hw(channel);
 	spin_lock_irqsave(&channel->vc.lock, flags);
+	for (; lmdesc < channel->lmdesc.base + DMAC_NR_LMDESC; lmdesc++)
+		lmdesc->header = 0;
+
 	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
 	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
 	vchan_get_all_descriptors(&channel->vc, &head);
@@ -647,6 +653,190 @@ static void rz_dmac_device_synchronize(struct dma_chan *chan)
 	rz_dmac_set_dmars_register(dmac, channel->index, 0);
 }
 
+static struct rz_lmdesc *
+rz_dmac_get_next_lmdesc(struct rz_lmdesc *base, struct rz_lmdesc *lmdesc)
+{
+	struct rz_lmdesc *next = lmdesc++;
+
+	if (next >= base + DMAC_NR_LMDESC)
+		next = base;
+
+	return next;
+}
+
+static unsigned int
+rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *channel)
+{
+	struct rz_lmdesc *lmdesc = channel->lmdesc.head;
+	struct dma_chan *chan = &channel->vc.chan;
+	struct rz_dmac *dmac = to_rz_dmac(chan->device);
+	unsigned int residue = 0, i = 0;
+	unsigned int crla;
+
+	crla = rz_dmac_ch_readl(channel, CRLA, 1);
+	while (!(lmdesc->nxla == crla)) {
+		lmdesc = rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
+		if (i++ > DMAC_NR_LMDESC)
+			return 0;
+	}
+
+	/* Get current processing lmdesc in hardware */
+	lmdesc = rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
+	/* Calculate residue from next lmdesc to end of virtual desc*/
+	while (lmdesc->chcfg & CHCFG_DEM) {
+		lmdesc = rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
+		residue += lmdesc->tb;
+	}
+
+	dev_dbg(dmac->dev, "%s: Getting residue is %d\n", __func__, residue);
+
+	return residue;
+}
+
+static unsigned int rz_dmac_calculate_total_bytes_in_vd(struct rz_dmac_desc *desc)
+{
+	unsigned int i, size = 0;
+	struct scatterlist *sg;
+
+	for_each_sg(desc->sg, sg, desc->sgcount, i)
+		size += sg_dma_len(sg);
+
+	return size;
+}
+
+static unsigned int rz_dmac_chan_get_residue(struct rz_dmac_chan *channel,
+					     dma_cookie_t cookie)
+{
+	struct rz_dmac_desc *current_desc, *desc;
+	enum dma_status status;
+	unsigned int residue;
+	unsigned int crla;
+	unsigned int crtb;
+	unsigned int i;
+
+	/* Get current processing virtual descriptor */
+	current_desc = list_first_entry(&channel->ld_active,
+					struct rz_dmac_desc, node);
+	if (!current_desc)
+		return 0;
+
+	/*
+	 * If the cookie corresponds to a descriptor that has been completed
+	 * there is no residue. The same check has already been performed by the
+	 * caller but without holding the channel lock, so the descriptor could
+	 * now be complete.
+	 */
+	status = dma_cookie_status(&channel->vc.chan, cookie, NULL);
+	if (status == DMA_COMPLETE)
+		return 0;
+
+	/*
+	 * If the cookie doesn't correspond to the currently processing virtual
+	 * descriptor then the descriptor hasn't been processed yet, and the
+	 * residue is equal to the full descriptor size.
+	 * Also, a client driver is possible to call this function before
+	 * rz_dmac_irq_handler_thread() runs. In this case, the running
+	 * descriptor will be the next descriptor, and the done list will
+	 * appear. So, if the argument cookie matches the done list's cookie,
+	 * we can assume the residue is zero.
+	 */
+	if (cookie != current_desc->vd.tx.cookie) {
+		list_for_each_entry(desc, &channel->ld_free, node) {
+			if (cookie == desc->vd.tx.cookie)
+				return 0;
+		}
+
+		list_for_each_entry(desc, &channel->ld_queue, node) {
+			if (cookie == desc->vd.tx.cookie)
+				return rz_dmac_calculate_total_bytes_in_vd(desc);
+		}
+
+		list_for_each_entry(desc, &channel->ld_active, node) {
+			if (cookie == desc->vd.tx.cookie)
+				return rz_dmac_calculate_total_bytes_in_vd(desc);
+		}
+
+		/*
+		 * No descriptor found for the cookie, there's thus no residue.
+		 * This shouldn't happen if the calling driver passes a correct
+		 * cookie value.
+		 */
+		WARN_ONCE(1, "No descriptor for cookie!");
+		return 0;
+	}
+
+	/*
+	 * We need to read two registers.
+	 * Make sure the hardware does not move to next lmdesc while reading
+	 * the current lmdesc.
+	 * Trying it 3 times should be enough: Initial read, retry, retry
+	 * for the paranoid.
+	 */
+	for (i = 0; i < 3; i++) {
+		crla = rz_dmac_ch_readl(channel, CRLA, 1);
+		crtb = rz_dmac_ch_readl(channel, CRTB, 1);
+		/* Still the same? */
+		if (crla == rz_dmac_ch_readl(channel, CRLA, 1))
+			break;
+	}
+
+	WARN_ONCE(i >= 3, "residue might be not continuous!");
+
+	/*
+	 * Calculate number of byte transferred in processing virtual descriptor
+	 * One virtual descriptor can have many lmdesc
+	 */
+	residue = crtb;
+	residue += rz_dmac_calculate_residue_bytes_in_vd(channel);
+
+	return residue;
+}
+
+static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
+					 dma_cookie_t cookie,
+					 struct dma_tx_state *txstate)
+{
+	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
+	enum dma_status status;
+	unsigned int residue;
+	unsigned long flags;
+
+	status = dma_cookie_status(chan, cookie, txstate);
+	if (status == DMA_COMPLETE || !txstate)
+		return status;
+
+	spin_lock_irqsave(&channel->vc.lock, flags);
+	residue = rz_dmac_chan_get_residue(channel, cookie);
+	spin_unlock_irqrestore(&channel->vc.lock, flags);
+
+	/* if there's no residue, the cookie is complete */
+	if (!residue)
+		return DMA_COMPLETE;
+
+	dma_set_residue(txstate, residue);
+
+	return status;
+}
+
+static int rz_dmac_device_pause(struct dma_chan *chan)
+{
+	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
+	struct rz_dmac *dmac = to_rz_dmac(chan->device);
+	unsigned int i;
+	u32 chstat;
+
+	for (i = 0; i < 1024; i++) {
+		chstat = rz_dmac_ch_readl(channel, CHSTAT, 1);
+		if (!(chstat & CHSTAT_EN))
+			break;
+		udelay(1);
+	}
+
+	rz_dmac_set_dmars_register(dmac, channel->index, 0);
+
+	return 0;
+}
+
 /*
  * -----------------------------------------------------------------------------
  * IRQ handling
@@ -929,13 +1119,14 @@ static int rz_dmac_probe(struct platform_device *pdev)
 
 	engine->device_alloc_chan_resources = rz_dmac_alloc_chan_resources;
 	engine->device_free_chan_resources = rz_dmac_free_chan_resources;
-	engine->device_tx_status = dma_cookie_status;
+	engine->device_tx_status = rz_dmac_tx_status;
 	engine->device_prep_slave_sg = rz_dmac_prep_slave_sg;
 	engine->device_prep_dma_memcpy = rz_dmac_prep_dma_memcpy;
 	engine->device_config = rz_dmac_config;
 	engine->device_terminate_all = rz_dmac_terminate_all;
 	engine->device_issue_pending = rz_dmac_issue_pending;
 	engine->device_synchronize = rz_dmac_device_synchronize;
+	engine->device_pause = rz_dmac_device_pause;
 
 	engine->copy_align = DMAENGINE_ALIGN_1_BYTE;
 	dma_set_max_seg_size(engine->dev, U32_MAX);
-- 
2.43.0


