Return-Path: <dmaengine+bounces-7754-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF27CC8176
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 15:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5A60C30088C2
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 14:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EEC37C117;
	Wed, 17 Dec 2025 13:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="fP8YWCct"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA9933C190
	for <dmaengine@vger.kernel.org>; Wed, 17 Dec 2025 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979559; cv=none; b=VxB49DZ+o5Y6+HAtZ46onHbm/2Z/ZlNr75TISywTAZ8mDNGu+rmeyIvlXXaH6ecNJHZvW59oRk0QKelF3V+beUzqlc4fPQnk1Akhez+n4SyhW6XQXXtruZXAs7B7Z4C+GLsm52CmDBS0+mFWx6ZGo5PthXAzdnwMOTY0MhihcdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979559; c=relaxed/simple;
	bh=wdcFsKk64ZqLQoSy4lgRRP+OrwZbLshgOLdKPP5OhP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5ZYhT+S0hnJ29FlJ8cqeSLYrUn5xuJbzXwcvPM6USuutixMlezdI4KJgCyXc36SBj378A1BcuTDx0HJFr+PcAddwL/yXnIxFdeRKbz/eeLdebxMTbt3MPp4THBzlbF9ZOJ6zAZLT9VranAVvG8ljcx8sXgQio+xb9GizYkLVOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=fP8YWCct; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fb5810d39so2750827f8f.2
        for <dmaengine@vger.kernel.org>; Wed, 17 Dec 2025 05:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765979552; x=1766584352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRRlcALx6KJfRO0PXviH91cZdJRUcSAZjbrCKicxs7Q=;
        b=fP8YWCctS3AIm5PV10EeBYI20bTvBEv5YD+UTt3fTh/3tpmClexPPRPlYmso8tThaw
         cOeHvCojtOIiOu5E9dHvLkoK6FBbT90hnmVUk4NohcmJ0oIluwO9mReVZ3x4ol/9ahel
         oSU9wgl2c/bpM+QlUB64WhniVMqpA1T9rHiIFyHnq3b1UBLhTz70sLINcONSILOgob3z
         4DW7gHgjgoP6xBN1S+kyy8iXTC7mTka8bRItWlmgXXRwS4MBXRcFOxy6xk+/zVslExlB
         L6BGh2W3RKPUXyMSWShB+jv/eCqgL048vtbhPQX86AMzkTPl/Z7Bfr6akwUC9eosPeNL
         UuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765979552; x=1766584352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DRRlcALx6KJfRO0PXviH91cZdJRUcSAZjbrCKicxs7Q=;
        b=tcyFAx58NU+ElB53MOpfx9ZruGiuiqg5TxCSWHnUy5Ngi5aJVgF2iu9k2IAxNBXD5y
         eW2QFaubYMW0lbvA+47sLIC55lziAaj89aNOSXpfdC4rglg81jDk5mgxxiQB+rMiCFQ2
         aQJ/sydpfkmEbv4RjMT6XaELJ+5AK3okmDCmaTFOeD+ycBXlxe1e7mgj7XIHnbEg5B41
         /gV7RyZKB4ibr4CpwPMQSPZCp8Ua/BFv0jFXxOEW1ws5yWHfXVSJJQ13sG6MC8DEpFSH
         1KC0DnBN09Kl+KeY+zY79tg9aqVIDlyvbdgCoihMMcF1sD0dB1tM5akbRrmzQq0cTya9
         OGXw==
X-Forwarded-Encrypted: i=1; AJvYcCUaraKhgZ9a3ma7po/um37KBMMezK1ZFT2x0IIXRF4oKiE1hZE2lz6YCS6r++T9ju03zyGn5PunFcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOAETQoU6UzVaThOKC6YzUOdPcX4uERlXwL0Pbwyu12v5FHIZ1
	xYCAcfJd1Yo+Ui3ZDmL1gD9FSnsQjrnPcFgXxbqWGUdZPfK6ogcPp18N91R6+GgoTMs=
X-Gm-Gg: AY/fxX5k/6f5upY3Bh53Dt0ixgqYSM8GgfFru9LSJ5OazhoF+GkhQL0WgCouYWI+k5M
	IaG73AKYKx9SDm4oopzW9NR9IBHPmKCOvSwkhVFwyXECpcmJQzb7L3k/cZZWVupuH2J6fQQAw5Y
	4QMS2ej+cO2QIeAMgjHcENgwRH/cieKg5QMsDtFTjZOIFz6lCBn5bDFvr2io0iigjdlowFK8MOi
	sY2vRd6Cw0fZJNhTWdpUrU747GfMmCBEN0s4OhY7ZqW8A6dfVy0XnKAgYVKHF2vDOcRdntxZJcv
	kjE5x9Jke6ZmMhEADS6yYItJ/wboxxPd3TJ9n1ImUHMH59ZKmgdPTKB517OFb9MngR1GxGzFEEj
	75s3ItVbIPiJrE5Pwq+wzKoe7MaC9EToMZCpTfXjY6R9XhndViWbx1Znr9ut1w9H4oIo24W/50s
	pocoTaLGTAlJC5aRvMHtfDe5Dwl//nmWBp/t+GruQi
X-Google-Smtp-Source: AGHT+IHdujWlg8jdn+rKZhpuf2sBPdcm1xcJ2ZQ4xT/FfMCcNymrhpduRFzaqB97VLiWsatlboVbUA==
X-Received: by 2002:adf:fe87:0:b0:42f:bc61:d1e5 with SMTP id ffacd0b85a97d-42fbc61d428mr15779119f8f.15.1765979552183;
        Wed, 17 Dec 2025 05:52:32 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310adf701csm4508000f8f.42.2025.12.17.05.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 05:52:31 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	fabrizio.castro.jz@renesas.com,
	biju.das.jz@bp.renesas.com,
	geert+renesas@glider.be,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v5 5/6] dmaengine: sh: rz-dmac: Add device_tx_status() callback
Date: Wed, 17 Dec 2025 15:52:12 +0200
Message-ID: <20251217135213.400280-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217135213.400280-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251217135213.400280-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index bb5677f5a318..c3035b94ef2c 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -119,10 +119,12 @@ struct rz_dmac {
  * Registers
  */
 
+#define CRTB				0x0020
 #define CHSTAT				0x0024
 #define CHCTRL				0x0028
 #define CHCFG				0x002c
 #define NXLA				0x0038
+#define CRLA				0x003c
 
 #define DCTRL				0x0000
 
@@ -685,6 +687,146 @@ static void rz_dmac_device_synchronize(struct dma_chan *chan)
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
+	 * Calculate number of byte transferred in processing virtual descriptor.
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
@@ -1015,7 +1157,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 
 	engine->device_alloc_chan_resources = rz_dmac_alloc_chan_resources;
 	engine->device_free_chan_resources = rz_dmac_free_chan_resources;
-	engine->device_tx_status = dma_cookie_status;
+	engine->device_tx_status = rz_dmac_tx_status;
 	engine->device_prep_slave_sg = rz_dmac_prep_slave_sg;
 	engine->device_prep_dma_memcpy = rz_dmac_prep_dma_memcpy;
 	engine->device_config = rz_dmac_config;
-- 
2.43.0


