Return-Path: <dmaengine+bounces-1738-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DC48979C8
	for <lists+dmaengine@lfdr.de>; Wed,  3 Apr 2024 22:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74BD91C256F5
	for <lists+dmaengine@lfdr.de>; Wed,  3 Apr 2024 20:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4D5156227;
	Wed,  3 Apr 2024 20:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Twxq+8BP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-m6014.netease.com (mail-m6014.netease.com [210.79.60.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E59C1552FF;
	Wed,  3 Apr 2024 20:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.79.60.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176028; cv=none; b=shrPSNjZ0FTdg1ij9j3JIGJFOrLftBl5ARZ/JT1PMm0mWrypHJi5MXB8S5jpOMibTj386Euw/qEup0CR9qBlyf3BH30C5pxKwvbEmn6ME4Ol/ib/1Iol8W2ArgVUYGKRGH2YfYc3qA5mX7igaou4QkkVsOvU7d41v4Ac3tejIyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176028; c=relaxed/simple;
	bh=/fFUjDe76W88FMC5zvU+GYanZ0TGzOUQc4hmIjl9S2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=d27ywi60B982j3vJL3RzjeqXxD/F/ootLqgbI4e5q94e88tI36TxJI19dqn2C5shaJ+PSG67PI/NgfBJOdT8CIz0mroOJXAt0L2eRW8jwO6TYqsqgdClJmEtzDXhyVrZ6JQk/+CXVoDIYVy7O8VJf5alnlBsI1bY6yBtBwznrIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Twxq+8BP; arc=none smtp.client-ip=210.79.60.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=Twxq+8BPn6Ew6c5IN41J2dg9vFrin0dSix2y8CIvTY1GtleMVkxEpYB/TmfQxC0Z6wYGNC08+CUxJnbOfJu61UpUl/M4b3IwVS4YAeHuCcMh2Q2yeNt8WLYbEfmYZozaPuMiMdJuTi+redM69s7AY2sZytu+/N/UHq/zwYBmg0k=;
	c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=iQCUiAuXJ8P2qSP0ti96ZUK9aMT1CGaxFKIO+tNeXmE=;
	h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 321A47C034A;
	Wed,  3 Apr 2024 21:18:49 +0800 (CST)
From: Sugar Zhang <sugar.zhang@rock-chips.com>
To: heiko@sntech.de,
	vkoul@kernel.org
Cc: linux-rockchip@lists.infradead.org,
	Sugar Zhang <sugar.zhang@rock-chips.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dmaengine: pl330: Add support for audio interleaved transfer
Date: Wed,  3 Apr 2024 21:18:23 +0800
Message-Id: <20240403211810.v2.2.I27a3219694d4d2a43fcfb35e1b069340dc94a5f0@changeid>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1712150304-60832-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1712150304-60832-1-git-send-email-sugar.zhang@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGklPSVZPS0keQ09LT0tKTU9VEwETFh
	oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5DTUtIVUpLS1VKQl
	kG
X-HM-Tid: 0a8ea41cb89409d2kunm321a47c034a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mio6ECo6ITMKATVKTDc*HhUK
	CwpPFDBVSlVKTEpJSk5LSElCQkNJVTMWGhIXVQgOHBoJVQETGhUcOwkUGBBWGBMSCwhVGBQWRVlX
	WRILWUFZTkNVSUlVTFVKSk9ZV1kIAVlBSktOTkM3Bg++
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

This patch add support for interleaved transfer which used
for interleaved audio or 2d video data transfer.

for audio situation, we add 'nump' for number of period frames.

e.g. combine 2 stream into a union one by 2D dma.

DAI0: 16CH
+-------------------------------------------------------------+
| Frame-1 | Frame-2 | Frame-3 | Frame-4 | ...... Frame-'numf' |
+-------------------------------------------------------------+

DAI1: 16CH
+-------------------------------------------------------------+
| Frame-1 | Frame-2 | Frame-3 | Frame-4 | ...... Frame-'numf' |
+-------------------------------------------------------------+

DAI0 + DAI1: 32CH

+-------------------------------------------------------------+
| DAI0-F1 | DAI1-F1 | DAI0-F2 | DAI1-F2 | ......              |
+-------------------------------------------------------------+
|      Frame-1      |      Frame-2      | ...... Frame-'numf' |

For audio situation, we have buffer_size and period_size,
the 'numf' is the buffer_size. so, we need another one for
period_size, e.g. 'nump'.

| Frame-1 | ~ | Frame-'nump' | ~ | Frame-'nump+1' | ~ |  Frame-'numf' |
|

As the above shown:

each DAI0 transfer 1 Frame, should skip a gap size (DAI1-F1)
each DAI1 transfer 1 Frame, should skip a gap size (DAI0-F1)

So, the interleaved template describe as follows:

DAI0:

struct dma_interleaved_template *xt;

xt->sgl[0].size = DAI0-F1;
xt->sgl[0].icg =  DAI1-F1;
xt->nump = nump; //the period_size in frames
xt->numf = numf; //the buffer_size in frames

DAI1:

struct dma_interleaved_template *xt;

xt->sgl[0].size = DAI1-F1;
xt->sgl[0].icg =  DAI0-F1;
xt->nump = nump; //the period_size in frames
xt->numf = numf; //the buffer_size in frames

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

(no changes since v1)

 drivers/dma/pl330.c | 169 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 163 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 5f6d7f1..449ed6b 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -239,6 +239,7 @@ enum pl330_byteswap {
 
 #define BYTE_TO_BURST(b, ccr)	((b) / BRST_SIZE(ccr) / BRST_LEN(ccr))
 #define BURST_TO_BYTE(c, ccr)	((c) * BRST_SIZE(ccr) * BRST_LEN(ccr))
+#define BYTE_MOD_BURST_LEN(b, ccr)	(((b) / BRST_SIZE(ccr)) % BRST_LEN(ccr))
 
 /*
  * With 256 bytes, we can do more than 2.5MB and 5MB xfers per req
@@ -545,6 +546,8 @@ struct dma_pl330_desc {
 	unsigned peri:5;
 	/* Hook to attach to DMAC's list of reqs with due callback */
 	struct list_head rqd;
+	/* interleaved size */
+	struct data_chunk sgl;
 };
 
 struct _xfer_spec {
@@ -577,6 +580,22 @@ static inline u32 get_revision(u32 periph_id)
 	return (periph_id >> PERIPH_REV_SHIFT) & PERIPH_REV_MASK;
 }
 
+static inline u32 _emit_ADDH(unsigned dry_run, u8 buf[],
+		enum pl330_dst da, u16 val)
+{
+	if (dry_run)
+		return SZ_DMAADDH;
+
+	buf[0] = CMD_DMAADDH;
+	buf[0] |= (da << 1);
+	*((__le16 *)&buf[1]) = cpu_to_le16(val);
+
+	PL330_DBGCMD_DUMP(SZ_DMAADDH, "\tDMAADDH %s %u\n",
+		da == 1 ? "DA" : "SA", val);
+
+	return SZ_DMAADDH;
+}
+
 static inline u32 _emit_END(unsigned dry_run, u8 buf[])
 {
 	if (dry_run)
@@ -1190,7 +1209,7 @@ static inline int _ldst_peripheral(struct pl330_dmac *pl330,
 				 const struct _xfer_spec *pxs, int cyc,
 				 enum pl330_cond cond)
 {
-	int off = 0;
+	int off = 0, i = 0, burstn = 1;
 
 	/*
 	 * do FLUSHP at beginning to clear any stale dma requests before the
@@ -1198,12 +1217,36 @@ static inline int _ldst_peripheral(struct pl330_dmac *pl330,
 	 */
 	if (!(pl330->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP))
 		off += _emit_FLUSHP(dry_run, &buf[off], pxs->desc->peri);
+
+	if (pxs->desc->sgl.size) {
+		WARN_ON(BYTE_MOD_BURST_LEN(pxs->desc->sgl.size, pxs->ccr));
+		burstn = BYTE_TO_BURST(pxs->desc->sgl.size, pxs->ccr);
+	}
+
 	while (cyc--) {
-		off += _emit_WFP(dry_run, &buf[off], cond, pxs->desc->peri);
-		off += _emit_load(dry_run, &buf[off], cond, pxs->desc->rqtype,
-			pxs->desc->peri);
-		off += _emit_store(dry_run, &buf[off], cond, pxs->desc->rqtype,
-			pxs->desc->peri);
+		for (i = 0; i < burstn; i++) {
+			off += _emit_WFP(dry_run, &buf[off], cond, pxs->desc->peri);
+			off += _emit_load(dry_run, &buf[off], cond, pxs->desc->rqtype,
+				pxs->desc->peri);
+			off += _emit_store(dry_run, &buf[off], cond, pxs->desc->rqtype,
+				pxs->desc->peri);
+		}
+
+		switch (pxs->desc->rqtype) {
+		case DMA_DEV_TO_MEM:
+			if (pxs->desc->sgl.dst_icg)
+				off += _emit_ADDH(dry_run, &buf[off], DST,
+						  pxs->desc->sgl.dst_icg);
+			break;
+		case DMA_MEM_TO_DEV:
+			if (pxs->desc->sgl.src_icg)
+				off += _emit_ADDH(dry_run, &buf[off], SRC,
+						  pxs->desc->sgl.src_icg);
+			break;
+		default:
+			WARN_ON(1);
+			break;
+		}
 	}
 
 	return off;
@@ -1382,6 +1425,9 @@ static inline int _setup_loops(struct pl330_dmac *pl330,
 		BRST_SIZE(ccr);
 	int off = 0;
 
+	if (pxs->desc->sgl.size)
+		bursts = x->bytes / pxs->desc->sgl.size;
+
 	while (bursts) {
 		c = bursts;
 		off += _loop(pl330, dry_run, &buf[off], &c, pxs);
@@ -2624,6 +2670,9 @@ static struct dma_pl330_desc *pl330_get_desc(struct dma_pl330_chan *pch)
 
 	desc->peri = peri_id ? pch->chan.chan_id : 0;
 	desc->rqcfg.pcfg = &pch->dmac->pcfg;
+	desc->sgl.size = 0;
+	desc->sgl.src_icg = 0;
+	desc->sgl.dst_icg = 0;
 
 	dma_async_tx_descriptor_init(&desc->txd, &pch->chan);
 
@@ -2774,6 +2823,110 @@ static struct dma_async_tx_descriptor *pl330_prep_dma_cyclic(
 	return &desc->txd;
 }
 
+static struct dma_async_tx_descriptor *pl330_prep_interleaved_dma(
+	struct dma_chan *chan, struct dma_interleaved_template *xt,
+	unsigned long flags)
+{
+	struct dma_pl330_desc *desc = NULL, *first = NULL;
+	struct dma_pl330_chan *pch = to_pchan(chan);
+	struct pl330_dmac *pl330 = pch->dmac;
+	unsigned int i;
+	dma_addr_t dst;
+	dma_addr_t src;
+	size_t size, src_icg, dst_icg, period_bytes, buffer_bytes, full_period_bytes;
+	size_t nump = 0, numf = 0;
+
+	if (!xt->numf || !xt->sgl[0].size || xt->frame_size != 1)
+		return NULL;
+	nump = xt->nump;
+	numf = xt->numf;
+	size = xt->sgl[0].size;
+	period_bytes = size * nump;
+	buffer_bytes = size * numf;
+
+	if (flags & DMA_PREP_REPEAT && (!nump || (numf % nump)))
+		return NULL;
+
+	src_icg = dmaengine_get_src_icg(xt, &xt->sgl[0]);
+	dst_icg = dmaengine_get_dst_icg(xt, &xt->sgl[0]);
+
+	pl330_config_write(chan, &pch->slave_config, xt->dir);
+
+	if (!pl330_prep_slave_fifo(pch, xt->dir))
+		return NULL;
+
+	for (i = 0; i < numf / nump; i++) {
+		desc = pl330_get_desc(pch);
+		if (!desc) {
+			unsigned long iflags;
+
+			dev_err(pch->dmac->ddma.dev, "%s:%d Unable to fetch desc\n",
+				__func__, __LINE__);
+
+			if (!first)
+				return NULL;
+
+			spin_lock_irqsave(&pl330->pool_lock, iflags);
+
+			while (!list_empty(&first->node)) {
+				desc = list_entry(first->node.next,
+						struct dma_pl330_desc, node);
+				list_move_tail(&desc->node, &pl330->desc_pool);
+			}
+
+			list_move_tail(&first->node, &pl330->desc_pool);
+
+			spin_unlock_irqrestore(&pl330->pool_lock, iflags);
+
+			return NULL;
+		}
+
+		switch (xt->dir) {
+		case DMA_MEM_TO_DEV:
+			desc->rqcfg.src_inc = 1;
+			desc->rqcfg.dst_inc = 0;
+			src = xt->src_start + period_bytes * i;
+			dst = pch->fifo_dma;
+			full_period_bytes = (size + src_icg) * nump;
+			break;
+		case DMA_DEV_TO_MEM:
+			desc->rqcfg.src_inc = 0;
+			desc->rqcfg.dst_inc = 1;
+			src = pch->fifo_dma;
+			dst = xt->dst_start + period_bytes * i;
+			full_period_bytes = (size + dst_icg) * nump;
+			break;
+		default:
+			break;
+		}
+
+		desc->rqtype = xt->dir;
+		desc->rqcfg.brst_size = pch->burst_sz;
+		desc->rqcfg.brst_len = pch->burst_len;
+		desc->bytes_requested = full_period_bytes;
+		desc->sgl.size = size;
+		desc->sgl.src_icg = src_icg;
+		desc->sgl.dst_icg = dst_icg;
+		fill_px(&desc->px, dst, src, period_bytes);
+
+		if (!first)
+			first = desc;
+		else
+			list_add_tail(&desc->node, &first->node);
+	}
+
+	if (!desc)
+		return NULL;
+
+	if (flags & DMA_PREP_REPEAT)
+		pch->cyclic = true;
+
+	dev_dbg(chan->device->dev, "size: %zu, src_icg: %zu, dst_icg: %zu, nump: %zu, numf: %zu\n",
+		size, src_icg, dst_icg, nump, numf);
+
+	return &desc->txd;
+}
+
 static struct dma_async_tx_descriptor *
 pl330_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dst,
 		dma_addr_t src, size_t len, unsigned long flags)
@@ -3129,12 +3282,16 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 		dma_cap_set(DMA_SLAVE, pd->cap_mask);
 		dma_cap_set(DMA_CYCLIC, pd->cap_mask);
 		dma_cap_set(DMA_PRIVATE, pd->cap_mask);
+		dma_cap_set(DMA_INTERLEAVE, pd->cap_mask);
+		dma_cap_set(DMA_REPEAT, pd->cap_mask);
+		dma_cap_set(DMA_LOAD_EOT, pd->cap_mask);
 	}
 
 	pd->device_alloc_chan_resources = pl330_alloc_chan_resources;
 	pd->device_free_chan_resources = pl330_free_chan_resources;
 	pd->device_prep_dma_memcpy = pl330_prep_dma_memcpy;
 	pd->device_prep_dma_cyclic = pl330_prep_dma_cyclic;
+	pd->device_prep_interleaved_dma = pl330_prep_interleaved_dma;
 	pd->device_tx_status = pl330_tx_status;
 	pd->device_prep_slave_sg = pl330_prep_slave_sg;
 	pd->device_config = pl330_config;
-- 
2.7.4


