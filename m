Return-Path: <dmaengine+bounces-7898-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 772BFCD981A
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 14:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A846307A86E
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 13:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B742C11D0;
	Tue, 23 Dec 2025 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="dj6l5f7A"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FD52D7DC0
	for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766497854; cv=none; b=W6k5Wn1DiXl04EH67GE1QxBXz6oMFLm/Ksi3/D+qke8V5yyaeSrhJ1uS1EanM5c/6P/lerIRUgBpiZhr6OV7nUNKPGcK6kfrrgv1HOiyQzktimSGIrj5FbHFzJt1Zx348HzRjuS7zq4FIULisJbjd8IdyuusZAar0XA0g0P5wRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766497854; c=relaxed/simple;
	bh=V2j30uJzU9iGi0tcofb7kdtfANNgwgeTb2rJjoOkv6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUkP7PDldP4SXUJeXD0SagqE2rdTnmX5TroIY7iQMj1GjIH34K1QgHitaqHaFFwDZl4zdWUcor6zlyDFrVFnm72OcIgyBZ/uj9HO3/rz7x+ORWUKVMfd3+PgO6feF2rcRIu140lJ6n0PwWTfYgLN2ETfWbGOplWJB68iJLAbiCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=dj6l5f7A; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47bdbc90dcaso33192185e9.1
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 05:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1766497850; x=1767102650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwIfRwPlxJ4dUOA9CK0cEGyokIF+zsSw+S+9qTH5zlc=;
        b=dj6l5f7AFsff3vv3MaGhjDVU6md76azkNckHP4p9o3i7gUhdOGnbu9i73AvFmfpAi4
         w1TcKiqAJ7V8AquS5GFH5aiRVfjQzYRgIfS9YR/he+2jVNzsfkYY7NgvOeCgKnVJz51X
         pXhN/Y9gyfApMGX3dlcnlW5bEk4fzie1bbu8QcGoTv2Y/MHAbNcgtvYStx6SzXWIXDTQ
         8/EmZzWT0FFl8Be9RXKISFaUySDiw3e9kmigiY+6epTfvbi+YoNMkD3XE/b1VCpKGnTR
         axt5Ikzy3S76Tqsiip2oOAQzFqR2ETBcas/9B+NBDALhej+tx046pMnyssnMMygpduDJ
         C2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766497850; x=1767102650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wwIfRwPlxJ4dUOA9CK0cEGyokIF+zsSw+S+9qTH5zlc=;
        b=AJLVYwknnsQrqRQlokFRpTaZkAu3RmkNPiA3BQVisW7is3Z2WtG1/lYH3jD7CwRO2Z
         jn2ITebjV4YHc1oiSd7ZOHKouMKH0a9CWh0AvDybst8gDh2Z9Gsvu+4apXMDbbkXQbJy
         2X0uI6X78sSs8H/ThjJKu8XFNohayylBYKGmsa+Lrje1YSB5BEKb8BmU56GM2vj9H6Js
         bhwOK1RZd9YxPGLnSetoltkGpy1z/LYRLJs+c3JEAy+fX4zaCwA+ExRhhefS6X3LUTEV
         c8KJ6DI8hCr0w40+0SrtCTPo5s5lK9iQNICvVHFUEIdurYrnd0KVn6vaQsLVu9JTGVoM
         S9iw==
X-Forwarded-Encrypted: i=1; AJvYcCWEFenS+xfQ71R6DPCbfbXnsuvDcSsbtuHDLC2eiOXYQ+M36TKB3emiIwKECpoC2EQhXI+MmXJ8WHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/AC4bD9ztImB+jYLC8S34/nLIaO3ribPXEdSaVw/OmGuCW5Rh
	sS+8ZNDuR9+cp4OijCe++EZknkYm37Pyi1pKeLpiBjq5K5j26CjsMFKusAwmgtrD4v2lY7Xgxe6
	NETiw
X-Gm-Gg: AY/fxX7vOWsEpJXHrm3rSSdUQep/l8gYMACb2ZBA+SLFYbJDyd/pz1EnX6ArIdtlezA
	cz5SoH+xc5j4Xz7t3qJbqNphk43fGwFGdMFAK8buP3qli6dKYGda8ZvLxX8NLbJqSkuNkgXjqgo
	AjYmz99w37vyeVKAoJldf7L1+xqN8opI4wTqziYaaR5fEecQ/002N5laStvbD8tko61A+RTPTzF
	8pxj41RXUju6xlVUobWPWMfvCurBEP6VN3SJXGIyb+UA7XlGs3ktuxXnnb5levQlJxQrkA8UFLY
	Mww2A5588DxbQKTYgDpofOMzA5c0WJsZ6sPvsAIAGXkTsQfcXZQiFqfp9NyJT9LukcKd8mDQW98
	z44JJ9tt4+9gb1reGuZPbJOR4q+jQI6APCw+gIrr/xgux0Tk1tx+DEF21yd0Kq/o+QXEDWsR4Xc
	A3qnOvhyGUFXeGruapDe6SP6vLAG7voS7TpJJvHVfVB/CBADP7RjnCp3mJlvXk8SstwrRjnllYj
	/cDA4TVbw==
X-Google-Smtp-Source: AGHT+IGpYksT8judEEY1zEyXam/PhoR55JNkEaNhLWS8xcqxEg/9LOK2xzEcnGWU/7o70HLlvIufAQ==
X-Received: by 2002:a05:600c:4595:b0:477:a1a2:d829 with SMTP id 5b1f17b1804b1-47d1953ead3mr144045255e9.13.1766497850257;
        Tue, 23 Dec 2025 05:50:50 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:620a:8300:4258:c40f:5faf:7af5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d192e88f5sm237921025e9.0.2025.12.23.05.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 05:50:49 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	biju.das.jz@bp.renesas.com,
	fabrizio.castro.jz@renesas.com,
	geert+renesas@glider.be,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v6 7/8] dmaengine: sh: rz-dmac: Add device_tx_status() callback
Date: Tue, 23 Dec 2025 15:49:51 +0200
Message-ID: <20251223134952.460284-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223134952.460284-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251223134952.460284-1-claudiu.beznea.uj@bp.renesas.com>
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
index 45c45053e9df..44f0f72cbcf1 100644
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
@@ -1016,7 +1158,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 
 	engine->device_alloc_chan_resources = rz_dmac_alloc_chan_resources;
 	engine->device_free_chan_resources = rz_dmac_free_chan_resources;
-	engine->device_tx_status = dma_cookie_status;
+	engine->device_tx_status = rz_dmac_tx_status;
 	engine->device_prep_slave_sg = rz_dmac_prep_slave_sg;
 	engine->device_prep_dma_memcpy = rz_dmac_prep_dma_memcpy;
 	engine->device_config = rz_dmac_config;
-- 
2.43.0


