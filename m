Return-Path: <dmaengine+bounces-9916-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHcANVsL1WlQzwcAu9opvQ
	(envelope-from <dmaengine+bounces-9916-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 15:49:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 387DC3AF761
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 15:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9755312F106
	for <lists+dmaengine@lfdr.de>; Tue,  7 Apr 2026 13:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650393BE17B;
	Tue,  7 Apr 2026 13:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="lJMuwqbN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4A43BC663
	for <dmaengine@vger.kernel.org>; Tue,  7 Apr 2026 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568954; cv=none; b=DoqR8lclq/Kw9s0Z9vRXAfexIYnUX95A68Gj1Owf5C9PxrGtXYNYaI/TDv6XnFRrKq3R+53E5IRHiKRbgAvtaATcaaMY1Fnkh4zQ/ij1t4JWQ1+lfa/xnYOp9r8VVR2I0xpTB2XKF0uMnHMf5a90HuF4fcRP7ODoha5vu221Pl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568954; c=relaxed/simple;
	bh=JzpCpiIpDCkiPooEXEEnD/8RQ4Ho5eR0SCr38HjQ8OM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KaI8t00GQtofUs0Uml91WnEd6mHwexAjUHhip2eyD4Aztb+OvEyg0zhEXEUDnq8ncDsrvT1wKyye7qWxtRSG5VUW7J7dzPaxZjLfcVxscpwNQHmlvdt1S47OGmeno5F5pRLnSJTMKQ+2EYEa10Bj8NmVtYWrXQJ+emei+kxKW/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=lJMuwqbN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4887f49ec5aso68702395e9.1
        for <dmaengine@vger.kernel.org>; Tue, 07 Apr 2026 06:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775568947; x=1776173747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mO/6bh4yvYuIGd4mKKKAd8QslWoV4RvamexLhfR0UE=;
        b=lJMuwqbNOT/wUPTGEtSibmWSiyr+cLuHUcXvJ7WNhbgf6DcdKDqExzpM8hE6KWbu84
         99A6ZO8jMJkH/3J6q7DHNfyE1pb1uwpNtA6JCIpMGt96HAGGVPxQfbx4LndsaFUPMLnx
         7ZFbBmmJ1LIqrYzUiz1Y+9K99Sheoc0K/CeArI/mJ9jxBi2fLAakl1RZkEr18Ys2hjzj
         jzW+ckqi7Ns3Z0rsA7RXtFAZNmo1FiNAHvKBz5Tmeiq3oN3eXqxHJnJxOVTkpTayZWJR
         Kf3NZsIqYrE+YgDwOqvm5+iEoWW+tpqZzO8U5A7pc186a+teMXo6Zv4U6XZZQzeNGQpJ
         U8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775568947; x=1776173747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5mO/6bh4yvYuIGd4mKKKAd8QslWoV4RvamexLhfR0UE=;
        b=UjzUkCGxkstUic3E72HG1Pi0CpWn3Oz9TskOvzXVxBEp7/CHB3YlDTO1MpUsUx2Nd9
         uSbbzTPkat9qA9OEq3rEPSrihgWspxbFbGXPBKU9sN7mpbsfXIp6TEjB2Bp/FVkfnA6i
         bCZ1tk3L5Ez9EurRBN4iUlnOh02x76zCNJZR+0zDb1I5CUGMRQrcb0bCxc32GNGXFSY7
         Y6SlOxnyaMyIgmaAJuxi7csrJUOx1agtr/M3F1CQf/KxisJxrq1n2BCPuaGSvzOnT1VN
         vp8EeGDVtJW6a0ga51BOfQTPgWKKLx40MgYuyhTsUWGs3RZ3qnHDne5j5pOMVcPKJ+O/
         3hbA==
X-Forwarded-Encrypted: i=1; AJvYcCWKW7qYhpB/Gaa4sgn0nsrdVWdAfxOy9eiqh00kVP2mQWxwduJhqXeO7B8yLSppmMge/Z5dqD3NujM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtANQvGEg2ixsOUtcJnrlX8lQjpBWhO2UUAPvH3+0hyfIY2Rk7
	ZE8YMv39ZI5QKTTwBXyOqmE/HiQ+mV32uhQ98sbx8aMggw40IrVplf+h9oolBVVsuew=
X-Gm-Gg: AeBDietotPLyosNU9JUGlPveugN//FTKFvXXBAfUkUzxrT0vV4Qoneza5sotjTkNc6G
	CkPs+XIREM7jkZzjnlWRcGoxl+hPrTHM++SpKmTJXuNghxBopbSCq6SlWmOH9R434951Uhz8/8q
	won5jRdoJFSCP9o+0YwixU0aV+ATmCUKyaiF3Aq0F6WpeRJh78dHc4ZpV0ihsagtPASZ17UFYI3
	BggbgKD508/Io4bHdPllRCam+sxdITrcBppB4f219XQO0CuKSw3SJiHJB27sGNFr7Ao7mvlBabL
	3gR6vIfML8mz4i4PVRCZgeG+aBW97ayF64SGZsuS5+KAUiBMwWl8iFqRPw36TTrK7zDPtZdNOim
	HhqAUPeDPzokmGiDIX4BBU2d1L4tWxNhjLnoQiXRPCc6eBkGrE+5ZcOMcFPzlrIw9Yk023W3xn4
	qexbFZEzMpDJuQQrvh2RS8j1mk6Cxrv1Ul/6pCRgwzJFWJQbaIFDwu
X-Received: by 2002:a05:600c:1d86:b0:485:4388:3492 with SMTP id 5b1f17b1804b1-4889970d844mr254556415e9.11.1775568947006;
        Tue, 07 Apr 2026 06:35:47 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a91686f9sm285777675e9.10.2026.04.07.06.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 06:35:46 -0700 (PDT)
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
	fabrizio.castro.jz@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 11/15] dmaengine: sh: rz-dmac: Add cyclic DMA support
Date: Tue,  7 Apr 2026 16:35:03 +0300
Message-ID: <20260407133507.887404-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407133507.887404-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260407133507.887404-1-claudiu.beznea.uj@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9916-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bp.renesas.com:mid,tuxon.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,renesas.com:email]
X-Rspamd-Queue-Id: 387DC3AF761
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add cyclic DMA support to the RZ DMAC driver. A per-channel status bit is
introduced to mark cyclic channels and is set during the DMA prepare
callback. The IRQ handler checks this status bit and calls
vchan_cyclic_callback() accordingly.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

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

 drivers/dma/sh/rz-dmac.c | 144 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 138 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 8fbccabc94e4..f7133ac6af60 100644
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
@@ -272,9 +276,12 @@ static void rz_lmdesc_setup(struct rz_dmac_chan *channel,
 static void rz_dmac_lmdesc_recycle(struct rz_dmac_chan *channel)
 {
 	struct rz_lmdesc *lmdesc = channel->lmdesc.head;
+	u32 nxla = channel->lmdesc.base_dma;
 
 	while (!(lmdesc->header & HEADER_LV)) {
 		lmdesc->header = 0;
+		nxla += sizeof(*lmdesc);
+		lmdesc->nxla = nxla;
 		lmdesc++;
 		if (lmdesc >= (channel->lmdesc.base + DMAC_NR_LMDESC))
 			lmdesc = channel->lmdesc.base;
@@ -429,6 +436,57 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
 	rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);
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
@@ -450,6 +508,10 @@ static void rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
 	case RZ_DMAC_DESC_SLAVE_SG:
 		rz_dmac_prepare_descs_for_slave_sg(chan);
 		break;
+
+	case RZ_DMAC_DESC_CYCLIC:
+		rz_dmac_prepare_descs_for_cyclic(chan);
+		break;
 	}
 
 	rz_dmac_enable_hw(chan);
@@ -500,6 +562,8 @@ static void rz_dmac_free_chan_resources(struct dma_chan *chan)
 		channel->mid_rid = -EINVAL;
 	}
 
+	channel->status = 0;
+
 	spin_unlock_irqrestore(&channel->vc.lock, flags);
 
 	vchan_free_chan_resources(&channel->vc);
@@ -582,6 +646,55 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
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
@@ -598,6 +711,9 @@ static int rz_dmac_terminate_all(struct dma_chan *chan)
 	}
 
 	vchan_get_all_descriptors(&channel->vc, &head);
+
+	channel->status = 0;
+
 	spin_unlock_irqrestore(&channel->vc.lock, flags);
 	vchan_dma_desc_free_list(&channel->vc, &head);
 
@@ -726,9 +842,18 @@ static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *channel,
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
@@ -914,10 +1039,14 @@ static irqreturn_t rz_dmac_irq_handler_thread(int irq, void *dev_id)
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
@@ -1172,6 +1301,8 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	engine = &dmac->engine;
 	dma_cap_set(DMA_SLAVE, engine->cap_mask);
 	dma_cap_set(DMA_MEMCPY, engine->cap_mask);
+	dma_cap_set(DMA_CYCLIC, engine->cap_mask);
+	engine->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	engine->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_0_7_COMMON_BASE + DCTRL);
 	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_8_15_COMMON_BASE + DCTRL);
@@ -1183,6 +1314,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	engine->device_tx_status = rz_dmac_tx_status;
 	engine->device_prep_slave_sg = rz_dmac_prep_slave_sg;
 	engine->device_prep_dma_memcpy = rz_dmac_prep_dma_memcpy;
+	engine->device_prep_dma_cyclic = rz_dmac_prep_dma_cyclic;
 	engine->device_config = rz_dmac_config;
 	engine->device_terminate_all = rz_dmac_terminate_all;
 	engine->device_issue_pending = rz_dmac_issue_pending;
-- 
2.43.0


