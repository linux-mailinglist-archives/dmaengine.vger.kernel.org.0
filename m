Return-Path: <dmaengine+bounces-10909-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCrKBMReFWp7UgcAu9opvQ
	(envelope-from <dmaengine+bounces-10909-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 10:50:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E6D5D2ADB
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 10:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8BCEB300A65A
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 08:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B893CEB8E;
	Tue, 26 May 2026 08:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amX/NiJn"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D3E3CEBA6;
	Tue, 26 May 2026 08:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779785303; cv=none; b=eJTIxnTdDK5XCqYZe5o0ZmkYG/Cns9gW0jkZUuYD2tXUFXl/NizVz/geyZJQxxFXMUdpziJfKGdv5WzcjJQsHbcTUuAw93SStcCaYIvH5KkyNtfuXN2p66nv+/dYeBuI747twHHe9J+ev+eFO+fdhAIg0OgouAYHEmVQK3dQ/Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779785303; c=relaxed/simple;
	bh=BAh79Zx9Pq4A2NQ1OT4BXJQVmEv+rOv76cr8T6eeDo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EwZJvT9W6c7U3ZR19oCNMdYMQes/GgqIMiOUs2yt0Xk+mIKTep568EDi96sLUs4mVJ3VuOr0xqHFZW1FEcsEctWwlcLCY7P9OBSePF6cL5H4dyjUOpXzuhk9gwNEkE6FYNOypl2ooMaHkd3QP5DPCrq/C/zhO1YEzorhS+vBJEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amX/NiJn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D82E1F00A3A;
	Tue, 26 May 2026 08:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779785301;
	bh=lzHqMZktDs87AOFrn/5S21ZY/oV/x9CjWC/cBwDYMSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=amX/NiJn/+4pp2GeGjAGTCL5xLNa895RzbIawfuOiqZ2WfIP2rx3R/ETrM4Q8xTD4
	 Cyi/ArKmBU/i6QcONKAnIfGdJ2awRmTtyfduTVklvAHaU+8IEVXotlH5MftJfrrd9L
	 Tha6qWI2fx7oWhYJ6wJnTbrkfTkWc/LgsV0k9ZgkXq08Tn1W6Xya1zzT2oTrNy9B8u
	 /X7xy71vecStHlWo0IwRz6znnIedO8SixwGdbqL3M5mfB9ejOH3uPZDtXCTRHr8dLS
	 qRg/rRbBGPJIiFNd/p4n+swR7oQgzVmZCzOzpRDFYFMrl4dByw03mQTZrfxK79YwZ/
	 BOYXt5SowhqiA==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
To: vkoul@kernel.org,
	Frank.Li@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	kuninori.morimoto.gx@renesas.com,
	long.luu.ur@renesas.com
Cc: claudiu.beznea@kernel.org,
	claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH v6 12/18] dmaengine: sh: rz-dmac: Add cyclic DMA support
Date: Tue, 26 May 2026 11:47:04 +0300
Message-ID: <20260526084710.3491480-13-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526084710.3491480-1-claudiu.beznea@kernel.org>
References: <20260526084710.3491480-1-claudiu.beznea@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10909-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 13E6D5D2ADB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add cyclic DMA support to the RZ DMAC driver. A per-channel status bit is
introduced to mark cyclic channels and is set during the DMA prepare
callback. The IRQ handler checks this status bit and calls
vchan_cyclic_callback() accordingly.

Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v6:
- collected tags

Changes in v5:
- none

Changes in v4:
- drop the nxla update logic in rz_dmac_lmdesc_recycle() as this is
  not needed for any kind of transfers
- drop the update of channel->status = 0 from rz_dmac_free_chan_resources()
  and rz_dmac_terminate_all() as this was moved in patch 09/17

Changes in v3:
- updated rz_dmac_lmdesc_recycle() to restore the lmdesc->nxla
- in rz_dmac_prepare_descs_for_cyclic() update directly the
  desc->start_lmdesc with the descriptor pointer insted of the
  descriptor address
- used rz_dmac_lmdesc_addr() to compute the descritor address
- set channel->status = 0 in rz_dmac_free_chan_resources()
- in rz_dmac_prep_dma_cyclic() check for invalid periods or buffer len
  and limit the critical area protected by spinlock
- set channel->status = 0 in rz_dmac_terminate_all()
- updated rz_dmac_calculate_residue_bytes_in_vd() to use 
  rz_dmac_lmdesc_addr()
- dropped goto in rz_dmac_irq_handler_thread() as it is not needed
  anymore; dropped also the local variable desc

Changes in v2:
- none

 drivers/dma/sh/rz-dmac.c | 136 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 130 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index c9c00650ddd5..8fd8a4bd9cc9 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -35,6 +35,7 @@
 enum  rz_dmac_prep_type {
 	RZ_DMAC_DESC_MEMCPY,
 	RZ_DMAC_DESC_SLAVE_SG,
+	RZ_DMAC_DESC_CYCLIC,
 };
 
 struct rz_lmdesc {
@@ -67,9 +68,11 @@ struct rz_dmac_desc {
 /**
  * enum rz_dmac_chan_status: RZ DMAC channel status
  * @RZ_DMAC_CHAN_STATUS_PAUSED: Channel is paused though DMA engine callbacks
+ * @RZ_DMAC_CHAN_STATUS_CYCLIC: Channel is cyclic
  */
 enum rz_dmac_chan_status {
 	RZ_DMAC_CHAN_STATUS_PAUSED,
+	RZ_DMAC_CHAN_STATUS_CYCLIC,
 };
 
 struct rz_dmac_chan {
@@ -191,6 +194,7 @@ struct rz_dmac {
 
 /* LINK MODE DESCRIPTOR */
 #define HEADER_LV			BIT(0)
+#define HEADER_WBD			BIT(2)
 
 #define RZ_DMAC_MAX_CHAN_DESCRIPTORS	16
 #define RZ_DMAC_MAX_CHANNELS		16
@@ -431,6 +435,57 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
 	channel->chctrl = 0;
 }
 
+static void rz_dmac_prepare_descs_for_cyclic(struct rz_dmac_chan *channel)
+{
+	struct dma_chan *chan = &channel->vc.chan;
+	struct rz_dmac *dmac = to_rz_dmac(chan->device);
+	struct rz_dmac_desc *d = channel->desc;
+	size_t period_len = d->sgcount;
+	struct rz_lmdesc *lmdesc;
+	size_t buf_len = d->len;
+	size_t periods = buf_len / period_len;
+
+	lockdep_assert_held(&channel->vc.lock);
+
+	channel->chcfg |= CHCFG_SEL(channel->index) | CHCFG_DMS;
+
+	if (d->direction == DMA_DEV_TO_MEM) {
+		channel->chcfg |= CHCFG_SAD;
+		channel->chcfg &= ~CHCFG_REQD;
+	} else {
+		channel->chcfg |= CHCFG_DAD | CHCFG_REQD;
+	}
+
+	lmdesc = channel->lmdesc.tail;
+	d->start_lmdesc = lmdesc;
+
+	for (size_t i = 0; i < periods; i++) {
+		if (d->direction == DMA_DEV_TO_MEM) {
+			lmdesc->sa = d->src;
+			lmdesc->da = d->dest + (i * period_len);
+		} else {
+			lmdesc->sa = d->src + (i * period_len);
+			lmdesc->da = d->dest;
+		}
+
+		lmdesc->tb = period_len;
+		lmdesc->chitvl = 0;
+		lmdesc->chext = 0;
+		lmdesc->chcfg = channel->chcfg;
+		lmdesc->header = HEADER_LV | HEADER_WBD;
+
+		if (i == periods - 1)
+			lmdesc->nxla = rz_dmac_lmdesc_addr(channel, d->start_lmdesc);
+
+		if (++lmdesc >= (channel->lmdesc.base + DMAC_NR_LMDESC))
+			lmdesc = channel->lmdesc.base;
+	}
+
+	channel->lmdesc.tail = lmdesc;
+
+	rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);
+}
+
 static void rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
 {
 	struct virt_dma_desc *vd;
@@ -452,6 +507,10 @@ static void rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
 	case RZ_DMAC_DESC_SLAVE_SG:
 		rz_dmac_prepare_descs_for_slave_sg(chan);
 		break;
+
+	case RZ_DMAC_DESC_CYCLIC:
+		rz_dmac_prepare_descs_for_cyclic(chan);
+		break;
 	}
 
 	rz_dmac_enable_hw(chan);
@@ -586,6 +645,55 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	return vchan_tx_prep(&channel->vc, &desc->vd, flags);
 }
 
+static struct dma_async_tx_descriptor *
+rz_dmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
+			size_t buf_len, size_t period_len,
+			enum dma_transfer_direction direction,
+			unsigned long flags)
+{
+	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
+	struct rz_dmac_desc *desc;
+	size_t periods;
+
+	if (!is_slave_direction(direction))
+		return NULL;
+
+	if (!period_len || !buf_len)
+		return NULL;
+
+	periods = buf_len / period_len;
+	if (!periods || periods > DMAC_NR_LMDESC)
+		return NULL;
+
+	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
+		if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC))
+			return NULL;
+
+		desc = list_first_entry_or_null(&channel->ld_free, struct rz_dmac_desc, node);
+		if (!desc)
+			return NULL;
+
+		list_del(&desc->node);
+
+		channel->status |= BIT(RZ_DMAC_CHAN_STATUS_CYCLIC);
+	}
+
+	desc->type = RZ_DMAC_DESC_CYCLIC;
+	desc->sgcount = period_len;
+	desc->len = buf_len;
+	desc->direction = direction;
+
+	if (direction == DMA_DEV_TO_MEM) {
+		desc->src = channel->src_per_address;
+		desc->dest = buf_addr;
+	} else {
+		desc->src = buf_addr;
+		desc->dest = channel->dst_per_address;
+	}
+
+	return vchan_tx_prep(&channel->vc, &desc->vd, flags);
+}
+
 static int rz_dmac_terminate_all(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
@@ -733,9 +841,18 @@ static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *channel,
 	}
 
 	/* Calculate residue from next lmdesc to end of virtual desc */
-	while (lmdesc->chcfg & CHCFG_DEM) {
-		residue += lmdesc->tb;
-		lmdesc = rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
+	if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)) {
+		u32 start_lmdesc_addr = rz_dmac_lmdesc_addr(channel, desc->start_lmdesc);
+
+		while (lmdesc->nxla != start_lmdesc_addr) {
+			residue += lmdesc->tb;
+			lmdesc = rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
+		}
+	} else {
+		while (lmdesc->chcfg & CHCFG_DEM) {
+			residue += lmdesc->tb;
+			lmdesc = rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
+		}
 	}
 
 	dev_dbg(dmac->dev, "%s: VD residue is %u\n", __func__, residue);
@@ -928,10 +1045,14 @@ static irqreturn_t rz_dmac_irq_handler_thread(int irq, void *dev_id)
 	if (!desc)
 		return IRQ_HANDLED;
 
-	vchan_cookie_complete(&desc->vd);
-	channel->desc = NULL;
+	if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)) {
+		vchan_cyclic_callback(&desc->vd);
+	} else {
+		vchan_cookie_complete(&desc->vd);
+		channel->desc = NULL;
 
-	rz_dmac_xfer_desc(channel);
+		rz_dmac_xfer_desc(channel);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -1183,6 +1304,8 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	engine = &dmac->engine;
 	dma_cap_set(DMA_SLAVE, engine->cap_mask);
 	dma_cap_set(DMA_MEMCPY, engine->cap_mask);
+	dma_cap_set(DMA_CYCLIC, engine->cap_mask);
+	engine->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	engine->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_0_7_COMMON_BASE + DCTRL);
 	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_8_15_COMMON_BASE + DCTRL);
@@ -1194,6 +1317,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	engine->device_tx_status = rz_dmac_tx_status;
 	engine->device_prep_slave_sg = rz_dmac_prep_slave_sg;
 	engine->device_prep_dma_memcpy = rz_dmac_prep_dma_memcpy;
+	engine->device_prep_dma_cyclic = rz_dmac_prep_dma_cyclic;
 	engine->device_config = rz_dmac_config;
 	engine->device_terminate_all = rz_dmac_terminate_all;
 	engine->device_issue_pending = rz_dmac_issue_pending;
-- 
2.43.0


