Return-Path: <dmaengine+bounces-9992-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFNTJrI12ml9zAgAu9opvQ
	(envelope-from <dmaengine+bounces-9992-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 13:51:14 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 580513DF9E4
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 13:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF3DC30B781E
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 11:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D781A35CB6A;
	Sat, 11 Apr 2026 11:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="cLBNfpcS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C571735A3A6
	for <dmaengine@vger.kernel.org>; Sat, 11 Apr 2026 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775907814; cv=none; b=WCzAdOzutJ/o0CBUCpGy5Z2R4aB/xnCeCb1Hzxo0M3WdrjlR6zdlkSO/otHqVmWDKr4rrVNzkZAPgQNIfYSghHhFkBOzXyBoGWtqtod2UNVU2hJk1SIZunOicduedGsQdVOgf0J3c8rtWGAeMioI80zdxjG1HDwianDKn021ikU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775907814; c=relaxed/simple;
	bh=G5ZrxdDz6SrJRh5gILn+jY8SjkPfRoyYynwfeT8cu7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sIJV8/Fjx0fFRS/nefmnFe1Tr+7lcG8Oeo598UtDklw2HlvH3C4GtK7YVfjYGLFMJTo69VgjJ9EqW3SgQNiEPdj9/4nHuSNZvDrgT6NdwpcIicCUOyuoMclwj5b5SWh64HiPlxgGysoAu0xLm7BQadZomozbINEQ2qmAnZNVl64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=cLBNfpcS; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43cf7683a28so1876796f8f.2
        for <dmaengine@vger.kernel.org>; Sat, 11 Apr 2026 04:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775907810; x=1776512610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1vnLRbFLHGljDC8DA+DpcpC7Ymwdn6jDCXLtiDCAnA=;
        b=cLBNfpcSVK9HGMiaoknKHEkySooReh/4Vx2xP0KasiXixX9OufkHjPijEn9SXuIg5J
         8pwOo7X+NG7A72hsPq6bRvfWBf4LM/zjVDUn58a8HOwdkf/8hlwz1pwt4J8Ws3GtvVWK
         k6hO8Oq18uWuZIsUTP+2Ukxjegb1JnLAcAL3pxB14iQeraKf6YjgIsM1/hx9ZIQ0z0/E
         DR4EQep5AaDtWs9ho8l8NuCcIJiEY8Vfwwyx+qxjQ21HD0zRLWQo9F2+9k7qXs6bfuRC
         Iq8l4kaIroDFK4fUMuYb/zRW8tP6xeO7E8CJGczN7UXLZLrLYZuUWZAjJdrOvMkdWdrG
         WjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775907810; x=1776512610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e1vnLRbFLHGljDC8DA+DpcpC7Ymwdn6jDCXLtiDCAnA=;
        b=YP0lNSHiTp01hUvsGsE8qPecUUdifo/op2csiZHjPOe1oURqiQuYvjREwBLiDOZiEX
         Q9Vg54DmU6EIKzuNDEsUywSV35G7o2k46Gzh2cBBoeGsdBkA8uYpJZHf8q3yBWlovbzJ
         miiDm8pEmCkeZGTDJwoADaEVRge4mwhlOvFfS/qTuXT0xED1ByEvVIOIbJQaF9ZEZC0y
         wEuYrARS60ys4nEW/CF84JKtJyLsD1Xdpgo3QIk0F5BpuTP/VH2DptBZ6PVTb9yQj+48
         YpdwzLnWmc7ilh7CO+2SXUYZvowZMgrdc5qUsKNuPRwSDDxIPDLqGfX5pPG3kMQjYSK4
         2Clg==
X-Forwarded-Encrypted: i=1; AJvYcCVWC3vn2FM4S5sbIiYHFS1BJk4iZQhwcvsP6mFilSYXmw284HiDbm1b2A8KGhuejJUlPPjZ44pqXcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI5sW2N8Sk9DXs6E6vdpkC8BnHyX1q24EFPwBOE2B0+OkmV4Er
	rUWLfAcsv6PLjDtzPv9LqAuHEquX6/HhdSMxClW3yDmpk2WhnV06zfJKAademZJSDnw=
X-Gm-Gg: AeBDietuhXW7WbhnIPmLMhtskTycfPh+DcpAFu4WtGANovi66HzXUEixQiizFGB0ng7
	4NY8gyr13G3oVELW+vjXsTupmxB+B9L1br+rTuDY1mKZ4e+vBSngR8dxkAaE3c26aZwjenJwYch
	Zf7q1CoHOn2+8XBWrNudv4+Gz0wfEgrdL1L8ROL88klDMaQYPEDdFh54OFHRRAM87tSAgoar6ml
	DJ/VvCTLz5n8gX2nSdSXhXaQUJyilR0dv+VmxIo8bPJzqdWKgURqm6zEHf/UvkjEEeALYXQEhgy
	ASTscRIwRPWiXOfwg5EWGd4mRH7vk0y+/iku09Kohb9HlMN8qhlT7Wx6BNdTbBOV//va0GkvZIU
	o/liCp00036VJcUfIeTNHNC185DyCi6KQXVF00qa3ZayhL04+amB3IWuPVB62hYZ/3XJmDlpKN8
	ff1XciPaUZ+316jzEFXar0DqhQizchVKP/ZvK5qZsMrYmDhf3B2mWy
X-Received: by 2002:a5d:5847:0:b0:43d:4fca:a973 with SMTP id ffacd0b85a97d-43d642c1a9dmr9196491f8f.40.1775907810115;
        Sat, 11 Apr 2026 04:43:30 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c981sm15776447f8f.33.2026.04.11.04.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 04:43:29 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
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
	fabrizio.castro.jz@renesas.com,
	long.luu.ur@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 13/17] dmaengine: sh: rz-dmac: Add cyclic DMA support
Date: Sat, 11 Apr 2026 14:42:59 +0300
Message-ID: <20260411114303.2814115-14-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260411114303.2814115-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260411114303.2814115-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9992-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,bp.renesas.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tuxon.dev:dkim]
X-Rspamd-Queue-Id: 580513DF9E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add cyclic DMA support to the RZ DMAC driver. A per-channel status bit is
introduced to mark cyclic channels and is set during the DMA prepare
callback. The IRQ handler checks this status bit and calls
vchan_cyclic_callback() accordingly.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

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
index 958ee45abc70..9a10430109e5 100644
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
@@ -924,10 +1041,14 @@ static irqreturn_t rz_dmac_irq_handler_thread(int irq, void *dev_id)
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
@@ -1179,6 +1300,8 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	engine = &dmac->engine;
 	dma_cap_set(DMA_SLAVE, engine->cap_mask);
 	dma_cap_set(DMA_MEMCPY, engine->cap_mask);
+	dma_cap_set(DMA_CYCLIC, engine->cap_mask);
+	engine->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	engine->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_0_7_COMMON_BASE + DCTRL);
 	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_8_15_COMMON_BASE + DCTRL);
@@ -1190,6 +1313,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	engine->device_tx_status = rz_dmac_tx_status;
 	engine->device_prep_slave_sg = rz_dmac_prep_slave_sg;
 	engine->device_prep_dma_memcpy = rz_dmac_prep_dma_memcpy;
+	engine->device_prep_dma_cyclic = rz_dmac_prep_dma_cyclic;
 	engine->device_config = rz_dmac_config;
 	engine->device_terminate_all = rz_dmac_terminate_all;
 	engine->device_issue_pending = rz_dmac_issue_pending;
-- 
2.43.0


