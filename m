Return-Path: <dmaengine+bounces-9436-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAQJKrUHuGkWYQEAu9opvQ
	(envelope-from <dmaengine+bounces-9436-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 14:37:57 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A44FD29A933
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 14:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 09ADA30342F6
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 13:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC0339C01F;
	Mon, 16 Mar 2026 13:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="pzpl/P09"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48E639B946
	for <dmaengine@vger.kernel.org>; Mon, 16 Mar 2026 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773667997; cv=none; b=d1dT0/MlnFKJNw/kLsTjOGEzzbg71CwZCbY6spT1H2BhzVE04xv28CtkChCeOl60K8sq6hvYzuxJMXHZQuzaLR92Bl1ZRefPuyNHRT01YQFmqSzY6E5UV7duy0z+6jiOGvDOjD35hFtnQltZVYCOmj//0caFxvxwfGAXFCO8ZPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773667997; c=relaxed/simple;
	bh=ecqtaf7Do4ElxtKTnuGKZQz9EFVZ1CRcpGzEUQrCfZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOnWQCsYx2pCY3AWqNxiJf3BYZonB1/ZOZDPcf+59+oksKMk51AHZgvm/dvo2QxQXjHcNa5MKJziI7t/yoLZ+jap9M1CTig0fGKr+h+/t3eArHnVYFhgAAinR6Yw7iRLVPpPl0oYNCm3jOiC/EW7e5CSTmnKeSgscDfTnxPUX9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=pzpl/P09; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48534237460so50796855e9.3
        for <dmaengine@vger.kernel.org>; Mon, 16 Mar 2026 06:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773667994; x=1774272794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/BkmUQ2l+8tVuUtRTiufCnFCzRaYeuhvEfWVLz7aiM=;
        b=pzpl/P09blF59a4kBhmtiNt0RBr+IqtBQHqXHCQw9hLJVAuHPVM78FfPmOq+5sR1mN
         yMkkvIOVF3Hn2XafwcRvwzkNFmKhYdNXVOGA1WFwy7PPb0bQvCqTpK7/ljIvVs2GPI14
         d64X/tsYse1zE9LdGOQsIs8uTW1s6N46Np6Tfc63mcB05zUjypSgRcdiqfjiHCvK9vt1
         nU3LEanF6qnfhVe2NNvN6Rx4/IiHJ9uJgySi1GyGNQkTjIvHDP2t3BH4QL8znvLHBd7u
         Cm65ajYvEhmJlNMqcWp7de4k2oyJc2nCrnUMcAiYYVraSDwZaqa6ZRFvd08bpGiy9qdX
         cn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773667994; x=1774272794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6/BkmUQ2l+8tVuUtRTiufCnFCzRaYeuhvEfWVLz7aiM=;
        b=bEHb6Ghb+qxNx286DvKvNRhrtJIlMtq7hJ0hqjafvrPk45j9sbZGQdwPGfA6jMpGor
         gRePPsW8fl54cyjIlqZedT0Tr7SR3Od3BQFvZLbLmUeaHQjwaXT0waq6Zdoz3cHQsj5H
         KqqRVt8/o1CKAeZdShwj5bawxp9qL3GNzJacR7eJ+d80FohQDUyFMt2UAdU/LW/qpMG/
         y/aQ6vv7pnZI1E6AbmOtK+Y6ivw+qfeQc21jOgGgaLY4Zg43pWGhKj4w/hNAo2GR7ONg
         0ggKcNgMiYun7ULx/GscVN1r4nhjX4jBIjbYJprkc1ZLs6dg44WSOkbqLHw7G5Gv7nhM
         cGzg==
X-Forwarded-Encrypted: i=1; AJvYcCUGigakyyD5aQHmb6K5w5A7YOu9oQMYXniHmuINsrwPKjPl5R2m49VmK3LZDOTLKWZry4+CB8qvdYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0qCHBV1ZyGkFexBraYKU+XXG6ANYf7/bzbEymNAAr/n/wvICa
	Bbi3FBAnuoj/2VO7B3MkgBZLTUIK9fpFEVoGnbxMbLpcemuGyBZ4xbKTVknRm0ZaMyG7UKBJPwT
	5LcrU
X-Gm-Gg: ATEYQzxCHDpCsVTaREDynLifnuAn0q3JmFVqubAYph8+nD7MIXX/kFIjPg85p7XApRY
	42f1RyjaEaUeOzJLRB0h+9nqDS3ztIGq8GImvqyWx7+b2S+gkq/V67/OF/CGU+6GUa0ov8xtN31
	wu2Lh/0FyiaMzBRYoypE/0mxwlEkB2R68jiDGFRuIlwIAdKJOIFN/3M9qHs2XZzyVhZ/pTbOTOn
	7nhKLnW9LnknSbarjZaIitZZIXTBSOhtAEtebetqyMFE0z+Yko+dJHI2WZLcCFMvQ6mNKiwKIZW
	PFc76JWsWNzpalbkogZavN0VzhKlFYZkDIN3bqderga4406oC6l4dW+t1Da9B2kF6SbqnsbWGba
	J3aOhz7/PpHCN2vHoeZZ1BtWv3QfnrwwMw+szOniv9Pchz9i20ckvefy26NpQesB8uvV/Q5s0ah
	mdcGQtnAPcM7f1RRYTQS8NETwhwSVCI0+3T5pn2cxmAZ/UVGBsMYcbKhYPS83SsliOtd4Yk1Jh+
	LWkFPI=
X-Received: by 2002:a05:600c:c049:b0:483:7903:c3b1 with SMTP id 5b1f17b1804b1-485566f7a35mr176544055e9.20.1773667994206;
        Mon, 16 Mar 2026 06:33:14 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6208:0:c5e3:3624:ad1c:6b4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b419270efsm11629888f8f.16.2026.03.16.06.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 06:33:13 -0700 (PDT)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	Frank.Li@kernel.org,
	geert+renesas@glider.be,
	biju.das.jz@bp.renesas.com,
	john.madieu.xa@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Long Luu <long.luu.ur@renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v10 7/8] dmaengine: sh: rz-dmac: Add device_tx_status() callback
Date: Mon, 16 Mar 2026 15:32:51 +0200
Message-ID: <20260316133252.240348-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316133252.240348-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260316133252.240348-1-claudiu.beznea.uj@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9436-lists,dmaengine=lfdr.de];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,tuxon.dev:dkim,renesas.com:email,bp.renesas.com:mid]
X-Rspamd-Queue-Id: A44FD29A933
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Changes in v10:
- none

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
index 6bfa77844e02..4f6f9f4bacca 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -124,10 +124,12 @@ struct rz_dmac {
  * Registers
  */
 
+#define CRTB				0x0020
 #define CHSTAT				0x0024
 #define CHCTRL				0x0028
 #define CHCFG				0x002c
 #define NXLA				0x0038
+#define CRLA				0x003c
 
 #define DCTRL				0x0000
 
@@ -676,6 +678,145 @@ static void rz_dmac_device_synchronize(struct dma_chan *chan)
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
@@ -997,6 +1138,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	engine = &dmac->engine;
 	dma_cap_set(DMA_SLAVE, engine->cap_mask);
 	dma_cap_set(DMA_MEMCPY, engine->cap_mask);
+	engine->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_0_7_COMMON_BASE + DCTRL);
 	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_8_15_COMMON_BASE + DCTRL);
 
@@ -1004,7 +1146,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 
 	engine->device_alloc_chan_resources = rz_dmac_alloc_chan_resources;
 	engine->device_free_chan_resources = rz_dmac_free_chan_resources;
-	engine->device_tx_status = dma_cookie_status;
+	engine->device_tx_status = rz_dmac_tx_status;
 	engine->device_prep_slave_sg = rz_dmac_prep_slave_sg;
 	engine->device_prep_dma_memcpy = rz_dmac_prep_dma_memcpy;
 	engine->device_config = rz_dmac_config;
-- 
2.43.0


