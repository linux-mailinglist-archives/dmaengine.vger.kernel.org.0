Return-Path: <dmaengine+bounces-9564-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2E0XO+cvvWmI7QIAu9opvQ
	(envelope-from <dmaengine+bounces-9564-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 12:30:47 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AC86D2D997A
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 12:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C30FE305D4A7
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 11:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B993AA1B3;
	Fri, 20 Mar 2026 11:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="bURoJ+pK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F6E3A9D9C
	for <dmaengine@vger.kernel.org>; Fri, 20 Mar 2026 11:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774006133; cv=none; b=pCkEidwZfnXhFV5Ta60EUkbd0fvJ4fwdQWMfFWdQEpSNlvzwSOrBRCIIO5LBBB7Ay4Z6cKvHydZNa5BbBEP/wypzsY679PSxOF2H05D83IJvajinbZejjNjFsxekxkPiErlji4sDUWg2Jq6HWt5p6aO7mWJwhm/2vajxD49UvjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774006133; c=relaxed/simple;
	bh=h9pis3uIgjZhaRaP43lEEeFj11msn/IipYbHvWci9FA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFiKxO1LgoarQvLZnkA+oZqQfusRgzL/SyDcoRfCbEaJNVLA72JOZIzytUl4rH57P9C3+xS+Pik83tUF/No32jPlUIivQJe5ILlBwVY7aUNgPPb1MuW3Cd0b8PM2sCUKP5JKamTZ32TK/RLkkvCReBOWLNSdVzGEl12TlfLHyD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=bURoJ+pK; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48628ce9ab5so5867695e9.2
        for <dmaengine@vger.kernel.org>; Fri, 20 Mar 2026 04:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1774006129; x=1774610929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZMErGYEzh9D7FYJyp2n9bFibDdiom/kkDB/CVaUYJE=;
        b=bURoJ+pKketoBIokqlwRR5hQUPg0ubQM1wqQj7AG29KxSkBuWkvaKAXOCToFWmok1g
         JH7sxqpuWMi5X1QslDGEmVolGkv5RT9J6WwcMf2WJMF9qemHN2VoRafI71FgABdoVINw
         7E8BlYaKsce0ic12kDLbr5IAaubxUqXuMH8F6kvDvv+MyJ8lFAGck6DOirUj6UAxjNvC
         0crt7smAFW4rnXyU/3Nu/EVyOJtWR02T/di2F5DvNIwLNAQU2WFEB9FgPhen+DLuJLq1
         Ry9IfMOOSmX70tSPGhiMfwJJ6xuM0ZQyy8UG4hhhd8wLeq+0iJovh9tc2sMTmCLr0wxl
         cOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774006129; x=1774610929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/ZMErGYEzh9D7FYJyp2n9bFibDdiom/kkDB/CVaUYJE=;
        b=SMslYPthrIFkRuwQTtbMh4/ZI+tzGhYLlIDjTCCwFmeYBKkX+kKwNmSG5nsiBeVYxa
         uFxKGAxgQdkDCrNgxnVTmBti29POiP4BE/aCLjihICtTVsIxx94J0735v1BFohR2Zft6
         aromLEjwr7B9K9FXJOD7h6tm6sPJcQOqmXhK9dAqz04o3lpqaHzakTJETq5idHIfQrvG
         52Uic6G63n/SjQ8C4vKaFB9W054uBMPLvsLYQs9lVJFjqgjHIUbmBp62XqCrKoN5nZiP
         NILVlv71j2vPmoYVIv1IvwVrIxRd41DJuTHRyp/DHDeMCGI8zun6BJN9G0EGRYYgtZ5l
         YXhw==
X-Forwarded-Encrypted: i=1; AJvYcCWPjT7NT9hLlzXqbAL1sQRWObbUTBlzpzED/E7i1poqcdROcwWdX97O74roFNob9kvvdKQxXajoLXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw/h2JQYkZDqj3BF77h8ik1sSVktRr9Uzehn+Ryd+KFeDzD9hN
	gfusPD05DRnawi2KqFCAufL40Tt9plFMKPuvtC5tpp61pJC7bYs+pjpeznrnXeWvwPR+l6Id5CA
	GR/gZ
X-Gm-Gg: ATEYQzzhxUYq9H9/5Yr1F+83XWty3/O/diEOqdJ1oVrPmILtpamAdJDfHPHzs3DSFST
	WpYeZzu7BhkoE0X654UrhVQQng/6anT+X52dmzRljJ8XZFIvPZaSzUkkgup2USrEFC/euOlX/s6
	xYFCrP7bBWzWqV2QjkvJgFKfJpQYOHUIZ8EWWKm9yNNCV/lqKFPZToCyXq5XfrRje5+NCK4lq19
	yE7VKH3w8HupXBeGne4uSVF7W0zFYWxoK6Bf9PEAJ8FnNuXkmqYxPQ0hY+vH9OcKDxIxb3lD841
	frJR5MJOT5/dQ9bGHJMnh2CksZ26hyQrgxpqcBlhVoMYxyXH3R7z6hxQ4+Xw9CJMsXCvLJh7sQx
	x9oFAVnIhZbfX3k/nzifImFylfEE0J15bvy72X7PnSaKhrmjWAkvioDIW8RFA600dVBzpd52Urn
	Pisnl7RSu+afS+1tLRFLAg7x+Xco9hXAavIiVatrVOh7Gb2nj7YD2A
X-Received: by 2002:a05:600c:548e:b0:485:3fa9:358c with SMTP id 5b1f17b1804b1-486ff027c33mr41401235e9.17.1774006129463;
        Fri, 20 Mar 2026 04:28:49 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe836784sm49869935e9.13.2026.03.20.04.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 04:28:48 -0700 (PDT)
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
	john.madieu.xa@bp.renesas.com,
	kuninori.morimoto.gx@renesas.com,
	tommaso.merciai.xr@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 4/7] dmaengine: sh: rz-dmac: Add cyclic DMA support
Date: Fri, 20 Mar 2026 13:28:35 +0200
Message-ID: <20260320112838.2200198-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320112838.2200198-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260320112838.2200198-1-claudiu.beznea.uj@bp.renesas.com>
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
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	TAGGED_FROM(0.00)[bounces-9564-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	NEURAL_HAM(-0.00)[-0.982];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: AC86D2D997A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add cyclic DMA support to the RZ DMAC driver. A per-channel status bit is
introduced to mark cyclic channels and is set during the DMA prepare
callback. The IRQ handler checks this status bit and calls
vchan_cyclic_callback() accordingly.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

 drivers/dma/sh/rz-dmac.c | 137 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 133 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 58446726afb5..ca8c0aa8ae59 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -35,6 +35,7 @@
 enum  rz_dmac_prep_type {
 	RZ_DMAC_DESC_MEMCPY,
 	RZ_DMAC_DESC_SLAVE_SG,
+	RZ_DMAC_DESC_CYCLIC,
 };
 
 struct rz_lmdesc {
@@ -59,6 +60,7 @@ struct rz_dmac_desc {
 	/* For slave sg */
 	struct scatterlist *sg;
 	unsigned int sgcount;
+	u32 start_lmdesc;
 };
 
 #define to_rz_dmac_desc(d)	container_of(d, struct rz_dmac_desc, vd)
@@ -67,10 +69,12 @@ struct rz_dmac_desc {
  * enum rz_dmac_chan_status: RZ DMAC channel status
  * @RZ_DMAC_CHAN_STATUS_ENABLED: Channel is enabled
  * @RZ_DMAC_CHAN_STATUS_PAUSED: Channel is paused though DMA engine callbacks
+ * @RZ_DMAC_CHAN_STATUS_CYCLIC: Channel is cyclic
  */
 enum rz_dmac_chan_status {
 	RZ_DMAC_CHAN_STATUS_ENABLED,
 	RZ_DMAC_CHAN_STATUS_PAUSED,
+	RZ_DMAC_CHAN_STATUS_CYCLIC,
 };
 
 struct rz_dmac_chan {
@@ -194,6 +198,7 @@ struct rz_dmac {
 
 /* LINK MODE DESCRIPTOR */
 #define HEADER_LV			BIT(0)
+#define HEADER_WBD			BIT(2)
 
 #define RZ_DMAC_MAX_CHAN_DESCRIPTORS	16
 #define RZ_DMAC_MAX_CHANNELS		16
@@ -419,6 +424,60 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
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
+	u32 start_lmdesc;
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
+	start_lmdesc = channel->lmdesc.base_dma +
+		       (sizeof(struct rz_lmdesc) * (lmdesc - channel->lmdesc.base));
+	d->start_lmdesc = start_lmdesc;
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
+			lmdesc->nxla = start_lmdesc;
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
 static int rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
 {
 	struct rz_dmac_desc *d = chan->desc;
@@ -439,6 +498,10 @@ static int rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
 		rz_dmac_prepare_descs_for_slave_sg(chan);
 		break;
 
+	case RZ_DMAC_DESC_CYCLIC:
+		rz_dmac_prepare_descs_for_cyclic(chan);
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -573,6 +636,52 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	return vchan_tx_prep(&channel->vc, &desc->vd, flags);
 }
 
+static struct dma_async_tx_descriptor *
+rz_dmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
+			size_t buf_len, size_t period_len,
+			enum dma_transfer_direction direction,
+			unsigned long flags)
+{
+	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
+	size_t periods = buf_len / period_len;
+	struct rz_dmac_desc *desc;
+
+	if (!is_slave_direction(direction))
+		return NULL;
+
+	if (periods > DMAC_NR_LMDESC)
+		return NULL;
+
+	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
+		if (list_empty(&channel->ld_free))
+			return NULL;
+
+		if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC))
+			return NULL;
+
+		channel->status |= BIT(RZ_DMAC_CHAN_STATUS_CYCLIC);
+
+		desc = list_first_entry(&channel->ld_free, struct rz_dmac_desc, node);
+
+		desc->type = RZ_DMAC_DESC_CYCLIC;
+		desc->sgcount = period_len;
+		desc->len = buf_len;
+		desc->direction = direction;
+
+		if (direction == DMA_DEV_TO_MEM) {
+			desc->src = channel->src_per_address;
+			desc->dest = buf_addr;
+		} else {
+			desc->src = buf_addr;
+			desc->dest = channel->dst_per_address;
+		}
+
+		list_move_tail(channel->ld_free.next, &channel->ld_queue);
+	}
+
+	return vchan_tx_prep(&channel->vc, &desc->vd, flags);
+}
+
 static int rz_dmac_terminate_all(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
@@ -723,9 +832,18 @@ static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *channel, u
 	}
 
 	/* Calculate residue from next lmdesc to end of virtual desc */
-	while (lmdesc->chcfg & CHCFG_DEM) {
-		residue += lmdesc->tb;
-		lmdesc = rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
+	if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)) {
+		struct rz_dmac_desc *desc = channel->desc;
+
+		while (lmdesc->nxla != desc->start_lmdesc) {
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
@@ -964,7 +1082,15 @@ static irqreturn_t rz_dmac_irq_handler_thread(int irq, void *dev_id)
 	}
 
 	desc = list_first_entry(&channel->ld_active, struct rz_dmac_desc, node);
-	vchan_cookie_complete(&desc->vd);
+
+	if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)) {
+		desc = channel->desc;
+		vchan_cyclic_callback(&desc->vd);
+		goto out;
+	} else {
+		vchan_cookie_complete(&desc->vd);
+	}
+
 	list_move_tail(channel->ld_active.next, &channel->ld_free);
 	if (!list_empty(&channel->ld_queue)) {
 		desc = list_first_entry(&channel->ld_queue, struct rz_dmac_desc,
@@ -1231,6 +1357,8 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	engine = &dmac->engine;
 	dma_cap_set(DMA_SLAVE, engine->cap_mask);
 	dma_cap_set(DMA_MEMCPY, engine->cap_mask);
+	dma_cap_set(DMA_CYCLIC, engine->cap_mask);
+	engine->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	engine->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_0_7_COMMON_BASE + DCTRL);
 	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_8_15_COMMON_BASE + DCTRL);
@@ -1242,6 +1370,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	engine->device_tx_status = rz_dmac_tx_status;
 	engine->device_prep_slave_sg = rz_dmac_prep_slave_sg;
 	engine->device_prep_dma_memcpy = rz_dmac_prep_dma_memcpy;
+	engine->device_prep_dma_cyclic = rz_dmac_prep_dma_cyclic;
 	engine->device_config = rz_dmac_config;
 	engine->device_terminate_all = rz_dmac_terminate_all;
 	engine->device_issue_pending = rz_dmac_issue_pending;
-- 
2.43.0


