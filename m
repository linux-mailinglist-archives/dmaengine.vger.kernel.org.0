Return-Path: <dmaengine+bounces-8403-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMnXJhmkb2n0DgAAu9opvQ
	(envelope-from <dmaengine+bounces-8403-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 16:49:45 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 299F346B7B
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 16:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 773098C0A47
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 13:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F05843CECE;
	Tue, 20 Jan 2026 13:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="LRkkn/5S"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C4F43C056
	for <dmaengine@vger.kernel.org>; Tue, 20 Jan 2026 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768916034; cv=none; b=QWhU8YVrRvxc/X4FRD2iSUKmo9uJlciZ8I8frPcYy2zDYGS1Jl4CHjGutjpkdXLBd/LT0ut3CsxJl84qIp2BGx5sz8rGwORfqLg6YE28heSGBYjXd+1hZQb8gE88RtTPgRTR1fzGmBI3vLIc7z6Lvko6egQx11fWcX8ut6sI+ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768916034; c=relaxed/simple;
	bh=o4M2IWsmqIIAFJgMEBDJzmV4HRAbRJRDwcspKwKckv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udYpOFwIv3BLbUT8fAtjR4RNRsorS/jgIglveMmOy7p+B53YLgMdtdPHcQBDPAePuvdyeqBM4k1ViQHy0ZINS9n7FVkCGU8F/qN/YXPs0Q0UwhWqUVgCok/7xGcXPs1UUHYgPT45D1pDY7b+5ID8wutfpvFlnDBtsUk+bSR+MAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=LRkkn/5S; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4801d21c411so18886725e9.3
        for <dmaengine@vger.kernel.org>; Tue, 20 Jan 2026 05:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768916029; x=1769520829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qf5FXhcean7d3UoIj1n4atOkrjx5heNNBTiKucMvKis=;
        b=LRkkn/5SUHp9VcMiHYOxOlbhMdOQ3ogbp6qkc/PM2vdW6Efehmg6xyP2T7MNPQwOGa
         KcBJllZV1tUVfHkJhA+vRt03TjWRu3UlVKUNj1BdVy8g2zFx7ddwHbt9+yRUVoty4uuH
         pDbIP7QIW2+wZJjS/nyB54I+P+BzEmD5bTEf9jm8y81jvvrC5fPFkiO8OUjNUNi+HJ1j
         fQ0uBIgyYbMhleCjFh8xvXzUv9Ohqvy7xEPRzBrpLMiotiVDDq6ZBBWlS7EHm7xYf1AO
         1ieBw1mQQrvOesyzMrWZJrZxzmMaSpUpGcYzO6JWvWZzkfY+ud4WJ/gRCcBFMiCMdAY/
         T6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768916029; x=1769520829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qf5FXhcean7d3UoIj1n4atOkrjx5heNNBTiKucMvKis=;
        b=rWD9b4KJ/QhVIRQzrYSOEIz9mCVc5GzWOGF8yhGsxTPrMqxHzr0nHz5F91yDmS8Ioc
         eImTdwu1snpA2Wacga/cnYEYoPyDZ7qH+kU8kLJ6O9m6DuQJK1k2eQGIoNVJxHMr8sq8
         jtNEj0qSJO7Y0JGoCaAdU2LOtz0NmkFfu+cNWB6Bst+v51GrjUe71c4n9PzMdZw3mU+7
         29TEBt9kFQ86FftVY29BDfH+MzD/LlfRSTntLQfAfp+doHiDmRgJT28LE4nEX9wCBeY+
         q/FGI8wa+m16wUUib+aeIz4tKTFwrhyzJIyXnMiFsZQ8GzVxLYwNowiMA/U71itvB9c8
         FNqw==
X-Forwarded-Encrypted: i=1; AJvYcCUkh9yyySx6fnGY10aBVI2A7LqNIWSoE81XoCuZz5RHJV02jDCfP6XwIhYf5XxKJW5hNS2Pe9BId8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpnCTNXeCQFYPM0gujG7Nw/MeGlKML7HDrF+H5gLXAKqjZ+VKp
	SvrYHWj6Oe3O0XzDtMe8Vp/rUJVNg7H6mYfVCK/LJx7LYkD1GeJhM2gzE3A1wRmX2aE=
X-Gm-Gg: AY/fxX4Bab2Gp8njuLNaUqBta9LLWt5Ie4W1JgM7Is3cyybGgTgBKYQ2nnT2cdWaPmR
	eT3ALp6+7iZPJMiL+ZuHNpcqOYMJRMapzWA2BJpUI6dqZbQwZj1PFIgjWc6yFmlkFPFLZvAgeWa
	X3Sy+ilmu+DpwjPqsHU86k6Uxfhumj+puRTTx6KjYRvShbraGQVvOMzFU5ULr5XxS/rcRWOKJm8
	2ypGtpeDIHeYVsfeBLMOPWRcTv+KiQjMRrVF6tZ8MEB3mDlHMi5ILFFVCem8fSErRn4yFquaMO0
	sc3gHubKyNviYvWjcdAPdymUNljD0kWaom9+fhTZG+2Uf26204eFhrkNnmfeUe7Ox++yFCBnKbZ
	bvmpV092mvMZbUhWuUKxUdzSdQlAdIj7B/E5nETGCtUtdOFN3jSQkIaYYBjilL94DGSsJNJ6hlq
	mLzcaPqgmgmByO4M4cCxt19E1LwlvXCrAR0kNisCc=
X-Received: by 2002:a05:600c:35d2:b0:47e:f481:24b7 with SMTP id 5b1f17b1804b1-4801e33a871mr246126415e9.17.1768916029549;
        Tue, 20 Jan 2026 05:33:49 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996dad0sm29331439f8f.27.2026.01.20.05.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 05:33:49 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	geert+renesas@glider.be,
	biju.das.jz@bp.renesas.com,
	fabrizio.castro.jz@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v8 7/8] dmaengine: sh: rz-dmac: Add device_tx_status() callback
Date: Tue, 20 Jan 2026 15:33:29 +0200
Message-ID: <20260120133330.3738850-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120133330.3738850-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260120133330.3738850-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8403-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tuxon.dev:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,renesas.com:email]
X-Rspamd-Queue-Id: 299F346B7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Biju Das <biju.das.jz@bp.renesas.com>

Add support for device_tx_status() callback as it is needed for
RZ/G2L SCIFA driver.

Based on a patch in the BSP similar to rcar-dmac by
Long Luu <long.luu.ur@renesas.com>.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
[claudiu.beznea:
 - post-increment lmdesc in rz_dmac_get_next_lmdesc() to allow the next
   pointer to advance
 - use 'lmdesc->nxla != crla' comparison instead of
   '!(lmdesc->nxla == crla)' in rz_dmac_calculate_residue_bytes_in_vd()
 - in rz_dmac_calculate_residue_bytes_in_vd() use '++i >= DMAC_NR_LMDESC'
   to verify if the full lmdesc list was checked
 - drop rz_dmac_calculate_total_bytes_in_vd() and use desc->len instead
 - re-arranged comments so they span fewer lines and are wrapped to ~80
   characters
 - use u32 for the residue value and the functions returning it
 - use u32 for the variables storing register values
 - fixed typos]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v8:
- populated engine->residue_granularity

Changes in v7:
- none

Changes in v6:
- s/byte/bytes in comment from rz_dmac_chan_get_residue()

Changes in v5:
- post-increment lmdesc in rz_dmac_get_next_lmdesc() to allow the next
  pointer to advance
- use 'lmdesc->nxla != crla' comparison instead of
  '!(lmdesc->nxla == crla)' in rz_dmac_calculate_residue_bytes_in_vd()
- in rz_dmac_calculate_residue_bytes_in_vd() use '++i >= DMAC_NR_LMDESC'
  to verify if the full lmdesc list was checked
- drop rz_dmac_calculate_total_bytes_in_vd() and use desc->len instead
- re-arranged comments so they span fewer lines and are wrapped to ~80
  characters
- use u32 for the residue value and the functions returning it
- use u32 for the variables storing register values
- fixed typos

 drivers/dma/sh/rz-dmac.c | 145 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 144 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 4602f8b7408a..27c963083e29 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -125,10 +125,12 @@ struct rz_dmac {
  * Registers
  */
 
+#define CRTB				0x0020
 #define CHSTAT				0x0024
 #define CHCTRL				0x0028
 #define CHCFG				0x002c
 #define NXLA				0x0038
+#define CRLA				0x003c
 
 #define DCTRL				0x0000
 
@@ -684,6 +686,146 @@ static void rz_dmac_device_synchronize(struct dma_chan *chan)
 	rz_dmac_set_dma_req_no(dmac, channel->index, dmac->info->default_dma_req_no);
 }
 
+static struct rz_lmdesc *
+rz_dmac_get_next_lmdesc(struct rz_lmdesc *base, struct rz_lmdesc *lmdesc)
+{
+	struct rz_lmdesc *next = ++lmdesc;
+
+	if (next >= base + DMAC_NR_LMDESC)
+		next = base;
+
+	return next;
+}
+
+static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *channel)
+{
+	struct rz_lmdesc *lmdesc = channel->lmdesc.head;
+	struct dma_chan *chan = &channel->vc.chan;
+	struct rz_dmac *dmac = to_rz_dmac(chan->device);
+	u32 residue = 0, crla, i = 0;
+
+	crla = rz_dmac_ch_readl(channel, CRLA, 1);
+	while (lmdesc->nxla != crla) {
+		lmdesc = rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
+		if (++i >= DMAC_NR_LMDESC)
+			return 0;
+	}
+
+	/* Calculate residue from next lmdesc to end of virtual desc */
+	while (lmdesc->chcfg & CHCFG_DEM) {
+		residue += lmdesc->tb;
+		lmdesc = rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
+	}
+
+	dev_dbg(dmac->dev, "%s: VD residue is %u\n", __func__, residue);
+
+	return residue;
+}
+
+static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan *channel,
+				    dma_cookie_t cookie)
+{
+	struct rz_dmac_desc *current_desc, *desc;
+	enum dma_status status;
+	u32 crla, crtb, i;
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
+	 * residue is equal to the full descriptor size. Also, a client driver
+	 * is possible to call this function before rz_dmac_irq_handler_thread()
+	 * runs. In this case, the running descriptor will be the next
+	 * descriptor, and will appear in the done list. So, if the argument
+	 * cookie matches the done list's cookie, we can assume the residue is
+	 * zero.
+	 */
+	if (cookie != current_desc->vd.tx.cookie) {
+		list_for_each_entry(desc, &channel->ld_free, node) {
+			if (cookie == desc->vd.tx.cookie)
+				return 0;
+		}
+
+		list_for_each_entry(desc, &channel->ld_queue, node) {
+			if (cookie == desc->vd.tx.cookie)
+				return desc->len;
+		}
+
+		list_for_each_entry(desc, &channel->ld_active, node) {
+			if (cookie == desc->vd.tx.cookie)
+				return desc->len;
+		}
+
+		/*
+		 * No descriptor found for the cookie, there's thus no residue.
+		 * This shouldn't happen if the calling driver passes a correct
+		 * cookie value.
+		 */
+		WARN(1, "No descriptor for cookie!");
+		return 0;
+	}
+
+	/*
+	 * We need to read two registers. Make sure the hardware does not move
+	 * to next lmdesc while reading the current lmdesc. Trying it 3 times
+	 * should be enough: initial read, retry, retry for the paranoid.
+	 */
+	for (i = 0; i < 3; i++) {
+		crla = rz_dmac_ch_readl(channel, CRLA, 1);
+		crtb = rz_dmac_ch_readl(channel, CRTB, 1);
+		/* Still the same? */
+		if (crla == rz_dmac_ch_readl(channel, CRLA, 1))
+			break;
+	}
+
+	WARN_ONCE(i >= 3, "residue might not be continuous!");
+
+	/*
+	 * Calculate number of bytes transferred in processing virtual descriptor.
+	 * One virtual descriptor can have many lmdesc.
+	 */
+	return crtb + rz_dmac_calculate_residue_bytes_in_vd(channel);
+}
+
+static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
+					 dma_cookie_t cookie,
+					 struct dma_tx_state *txstate)
+{
+	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
+	enum dma_status status;
+	u32 residue;
+
+	status = dma_cookie_status(chan, cookie, txstate);
+	if (status == DMA_COMPLETE || !txstate)
+		return status;
+
+	scoped_guard(spinlock_irqsave, &channel->vc.lock)
+		residue = rz_dmac_chan_get_residue(channel, cookie);
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
 /*
  * -----------------------------------------------------------------------------
  * IRQ handling
@@ -1007,6 +1149,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	engine = &dmac->engine;
 	dma_cap_set(DMA_SLAVE, engine->cap_mask);
 	dma_cap_set(DMA_MEMCPY, engine->cap_mask);
+	engine->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_0_7_COMMON_BASE + DCTRL);
 	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_8_15_COMMON_BASE + DCTRL);
 
@@ -1014,7 +1157,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 
 	engine->device_alloc_chan_resources = rz_dmac_alloc_chan_resources;
 	engine->device_free_chan_resources = rz_dmac_free_chan_resources;
-	engine->device_tx_status = dma_cookie_status;
+	engine->device_tx_status = rz_dmac_tx_status;
 	engine->device_prep_slave_sg = rz_dmac_prep_slave_sg;
 	engine->device_prep_dma_memcpy = rz_dmac_prep_dma_memcpy;
 	engine->device_config = rz_dmac_config;
-- 
2.43.0


