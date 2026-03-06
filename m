Return-Path: <dmaengine+bounces-9303-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDojNA3OqmlRXQEAu9opvQ
	(envelope-from <dmaengine+bounces-9303-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 13:52:29 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB9E2210A7
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 13:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0844031B46B6
	for <lists+dmaengine@lfdr.de>; Fri,  6 Mar 2026 12:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F02328C854;
	Fri,  6 Mar 2026 12:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Io//6dw2"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60177386C1B
	for <dmaengine@vger.kernel.org>; Fri,  6 Mar 2026 12:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772800909; cv=none; b=ZxzaTWcDP1cMn+jus7kiNklS2LRS/F0aonxXOfIpgyUFhMamNidhaJQhXeCK2Dajs/stgBMW6I1qCO+zonzkbsUfmYWOCijHsXuR0ezhw3fEzgCnO68nvR88P2UgAvDdrv2gwFSJNbdR5nj6Kai8UFR8YdTKX+sQ5o/Im3T5VNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772800909; c=relaxed/simple;
	bh=nSiQtEYZ1Ezr70vkp2ZeOST+tOl2pH5840ALPWqFaCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJGqqHtf7mDP5+sxgstT4l7bnbPgHVWGyNW8H5Aemi+Qva/KBKpCqVeQB2h3pP5oY8XoV4MV4XDP+w2L4YyVQz+zPCF/vRAjkB3nX4RCT15hjpHHy02bb7Lg1zk214p97Xfd+rpyTiQbqw6mr03ryVe1MWWaKhpnX0k+gndDAZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Io//6dw2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-482f454be5bso94140925e9.0
        for <dmaengine@vger.kernel.org>; Fri, 06 Mar 2026 04:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1772800906; x=1773405706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsmFxT5OqHzHHM4Ncsz2v6IqxYstw+p2fVPLaiDV9OE=;
        b=Io//6dw2I+r1O+/GEIDV2ZWTSREF0mtXEaQOJsRkt5N58Usx0Fsnh/57GqlJVh9sjF
         gMLIGxE0K0vw8thDKc/5LkFAxANLuLgPIAC41edFP5bzg9aTpqNtjFPuB+znllG6ERUF
         lcA1mCfq9gKp3bYtEL1z40qr5FUNWxbyDyEhOlaLechH6GCyaJoVUoBqmLPOAMr4WH3W
         YnmlNE21kAwf7NXh/qyuhGDzoGthOvdrq7Prbj3ib/cR0uICJX5X2XK5by+TS5ZI3xFj
         dpBrPQrEoIwWgG4qQiNyHzfd+thMqyukjtWsJUNR0dsxJ3z4+B+LF40uH5HuNrsoUKqj
         k5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772800906; x=1773405706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nsmFxT5OqHzHHM4Ncsz2v6IqxYstw+p2fVPLaiDV9OE=;
        b=lEIW2TZ2JtCEO2FJvvtZJWW/YhKUMBczyUvi3PEuyFszOT4Fi7y+XL7Sl1wpM/cCy1
         WVpYq2zHV/RY4Cn7f+HAB8pGPK2uOopHhmfTruT3zP3Tubp30rIfvs/LGnACfntftSRG
         p9zlGBzZHqn/2+Ht6wbgZtB+KTQ0MamQ8/rOO1dq49u3Yjy3qWMfX0XKtpiLVCGb0B/Z
         6keUIMkiri+cYVMxzmOhp0sgmXJjiCZc6cfgOfJ/Au3r6LRiAirzCYWlbE7shqOFDXkQ
         F2743vahBAKkENYrnZeuwfoi7mvuXIuGCkhoHvVYhCmk+q7sRghjuax0kugERALloaTF
         g+sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNb8phO2gyuNdtcZgm+mK8YqfV6stZv6dhakdZQCEdBbZDadJLNYIUhFPk/zfefJYmoJ/dqLJiSt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWBY3Mrd9LYGDfGLkSvjx6sh3HKbfOBeG/UChw0O9so3ONuQAv
	Oa6dWOm+wA/ky1dWN3wj64L1E7q2vAAcsLSq2b1xQsYlju/UszW8gnPDkRdyeY2MxzQ=
X-Gm-Gg: ATEYQzwnbEP8WFaCh7kfXLUn7mLdARMB2rSmt0uuik7omfFfjg3+4BPQIKx0jJabUuX
	TNNyR7uhFkvhMAwHz63/IPsnCPWpmh2Zai38mdYh0wcRX2Yna+dz4HGBvO/OncIs+s2zTpIG92M
	rYyn6Hzmsx9dqZ65k/ziwu0bNJHbaJqkA8LD2AlnzpGtgTWRmJh3BS2Pk9Y3CO5NFBy3J/T2FoN
	AgsM3WjeiQG3EcibVDSaON0g8sroujghd8F31Po6A6gePYYFJy9EWQsqAl1y5eWIGl5bzWbmy8z
	+n72MiPQaDJnBD4Qj76tmNcR0We5ahVadRJHDaorZRmiK39IITkr5qkMuM/j8Ayocf5HJ9oY4fz
	oGmw8UOHwnoxR3l4yz1KLSnyvNH2ZnOqWJaFQ66yZxbsRfCD8zuwYfa8NZkIb3k9imC3wl/pOXl
	6COeHztfQfM9tGkfQhm0LTqMCC328bJraKdu6r2rlHYS3HLq5lhwpb
X-Received: by 2002:a05:600c:4e88:b0:483:7ea3:3de3 with SMTP id 5b1f17b1804b1-48526715266mr28560065e9.2.1772800905597;
        Fri, 06 Mar 2026 04:41:45 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485276b0c38sm38150505e9.9.2026.03.06.04.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:41:45 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	Frank.Li@kernel.org,
	biju.das.jz@bp.renesas.com,
	geert+renesas@glider.be,
	fabrizio.castro.jz@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Long Luu <long.luu.ur@renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v9 7/8] dmaengine: sh: rz-dmac: Add device_tx_status() callback
Date: Fri,  6 Mar 2026 14:41:32 +0200
Message-ID: <20260306124133.2304687-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306124133.2304687-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260306124133.2304687-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3CB9E2210A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	TAGGED_FROM(0.00)[bounces-9303-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bp.renesas.com:mid,renesas.com:email,tuxon.dev:dkim]
X-Rspamd-Action: no action

From: Biju Das <biju.das.jz@bp.renesas.com>

The RZ/G2L SCIFA driver uses dmaengine_prep_slave_sg() to enqueue DMA
transfers and implements a timeout mechanism on RX to handle cases where
a DMA transfer does not complete. The timeout is implemented using an
hrtimer.

In the hrtimer callback, dmaengine_tx_status() is called (along with
dmaengine_pause()) to retrieve the transfer residue and handle incomplete
DMA transfers.

Add support for the device_tx_status() callback.

Co-developed-by: Long Luu <long.luu.ur@renesas.com>
Signed-off-by: Long Luu <long.luu.ur@renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Co-developed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v9:
- adjusted the patch description
- dropped contribution list for Claudiu Beznea
- used Co-developed-by + SoB tags and included Long Luu in the
  contribution list as well
- dropped the read of CRLA in rz_dmac_calculate_residue_bytes_in_vd()
  and use the copy from the calling function (rz_dmac_chan_get_residue())

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

 drivers/dma/sh/rz-dmac.c | 144 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 143 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 274c9cd40713..3b318fe06f28 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -118,10 +118,12 @@ struct rz_dmac {
  * Registers
  */
 
+#define CRTB				0x0020
 #define CHSTAT				0x0024
 #define CHCTRL				0x0028
 #define CHCFG				0x002c
 #define NXLA				0x0038
+#define CRLA				0x003c
 
 #define DCTRL				0x0000
 
@@ -684,6 +686,145 @@ static void rz_dmac_device_synchronize(struct dma_chan *chan)
 	}
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
+static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *channel, u32 crla)
+{
+	struct rz_lmdesc *lmdesc = channel->lmdesc.head;
+	struct dma_chan *chan = &channel->vc.chan;
+	struct rz_dmac *dmac = to_rz_dmac(chan->device);
+	u32 residue = 0, i = 0;
+
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
+	return crtb + rz_dmac_calculate_residue_bytes_in_vd(channel, crla);
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
@@ -1006,6 +1147,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	engine = &dmac->engine;
 	dma_cap_set(DMA_SLAVE, engine->cap_mask);
 	dma_cap_set(DMA_MEMCPY, engine->cap_mask);
+	engine->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_0_7_COMMON_BASE + DCTRL);
 	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_8_15_COMMON_BASE + DCTRL);
 
@@ -1013,7 +1155,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 
 	engine->device_alloc_chan_resources = rz_dmac_alloc_chan_resources;
 	engine->device_free_chan_resources = rz_dmac_free_chan_resources;
-	engine->device_tx_status = dma_cookie_status;
+	engine->device_tx_status = rz_dmac_tx_status;
 	engine->device_prep_slave_sg = rz_dmac_prep_slave_sg;
 	engine->device_prep_dma_memcpy = rz_dmac_prep_dma_memcpy;
 	engine->device_config = rz_dmac_config;
-- 
2.43.0


