Return-Path: <dmaengine+bounces-8113-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 69622D03200
	for <lists+dmaengine@lfdr.de>; Thu, 08 Jan 2026 14:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B11A303ACFB
	for <lists+dmaengine@lfdr.de>; Thu,  8 Jan 2026 13:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A893A1D1A;
	Thu,  8 Jan 2026 10:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="SWci4cOi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F7E4BB0B9
	for <dmaengine@vger.kernel.org>; Thu,  8 Jan 2026 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868608; cv=none; b=SYymNIFc99+aFF7cLuBfbFSer7IhrAYkdWGybvqN8W9CIo2Abv6FZlun/6p8IxiRlx8WEdEVYoE6S/bdBSd5JbXXEKW2POxrvKe3hO2CIByaMuhi/HBJnXPCSyG7lnUM7K5+AdKKmZUaM/GV1FwWBJf+EPueJg0c9vMwdZh4eOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868608; c=relaxed/simple;
	bh=2TdQW69drVLrL0CqMqSFeSzO65TAAV4hLZB/cfhdy3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKfE3w0SGRk3p8vt3p/T6etz23mKpE1mAVHeTsqD9F/U82tZeA1Asiw1RFUKkEVTKkPExLqcmSYBEFea6MXJZBK6TS7MlAiX6VN1FLMn8gdNG1QbJv++PbULyUUsOvTM9wn5DjAuL4tt+/E4Cv9u4WSJBL+NFBLUTOFzgE433SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=SWci4cOi; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso24869055e9.3
        for <dmaengine@vger.kernel.org>; Thu, 08 Jan 2026 02:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1767868591; x=1768473391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+7+V1b0T7BwengozlA1kapkoKFaMZj4KFqvQVGlzjg=;
        b=SWci4cOiYHoJO2jO5q6QuX6PIjgVg//G4yFigOnsVJT/gGEnYjUFYvG97bwPo+ityH
         JHrR048bYcfq4KBFpDMsQQjkYBougSIdVlt+MQWmzWyKNhwxkiM2ktBKEMjJrghLEQtA
         R6fE1cx+mQjCuyA6pPSyFhMvRqAEWccJbTVKEkBSNdfQf4otGcpWhl22WRu0yz7McIRy
         Bw31Rh6tfb1Zy1YPjrjnO9THd/Ut9U3dED+SrXOInCwlfAneDvwWUaUn+M7cPAhNE8gm
         nQ3cfvV0mT+cmhESxcj0rnuteXBsEVN0B5RdHaHzksob6EvFg9M4RSDlJ2qWBlydtmCJ
         7+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767868591; x=1768473391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x+7+V1b0T7BwengozlA1kapkoKFaMZj4KFqvQVGlzjg=;
        b=OQE6Pb52x2+k9HJjkRg2lWNpe4UdJMhgywLKWzxnf8Nadm2zLECc0gRHTv6NZmREMt
         n4l5JUWKGGhv089rdjNPM8zwepD/QYF39SVSzQiOMSQOl6Pww/0t7PoFDVwVG5ziS3Fb
         aqfWM+op3dv89GClvqUQvwS+uOWJDUMLyNJsSRoDWIgtvCp01K8XLZisDH2Vkoy3u8AM
         8QthraEFAXaUR2nf4SRbVG1XDq9nb2FBFw7eQFFOOidRSJcOxL8LTRpBWzdnTxuQlBEZ
         8KQljEEI4eGI4rZuqhy/FU2/7MDCsNDUjcnkSowe0komhGWlA3cOVRi+BNoRq/B/4MH6
         Gxog==
X-Forwarded-Encrypted: i=1; AJvYcCXATWmpyHuohW10yAmJ1bwoWJiRJQKRVNXInfakTApIGvdHJM66BDeu9wFNl+HsRZ+UN0g1nxEf1y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH+2irutdW29rPCdkeNfbQF/F9iqkw2i8lx0g3vj7JoCOoUdQG
	02FXOhs+dGkJqShe5kd77fOwh+fzvXHzfVQkeXBSfvICm7J0wdCUYNoaXKA1wN2bSu8=
X-Gm-Gg: AY/fxX6JFCHMOPUhLq6+JW80oDnh9notFNn4z+iYIVS8/YF/kPygFuOn3ewYUS7vngb
	tAGBeoVhmMMz/2vFJy7iG3fy9BASiINoUItc+OHiTrr21PSMfi8WFvHll2W6czNs8Q8KzE+aaZB
	R0Job5fYSdbgWfVt36cV5qnSNvhORPpMgzCXlDYRWK4VPOL2Kez21uuVUS8NKNvgw9iwwRQ23Uw
	9ghrfPyCQnjsd9g5PRPEWLZrPhi3EKV9L4GFSTLq9HfVh9JCnldhPxmTfnW0oe9UEm3lLitnLUE
	5xnYm6I83ATYplA8Tvc1zvc2IClsGp7eFCThxwmFS9bOhsupb1QxbvvM9Z5KZ90m40GfTJA7f++
	Y1UWkj7f+pZDc8wKfT3FHw7SqG5ZyNqfIVdZbxDBHC6p2yze+eBRbth+W/q26IHmSvtkiWk9vIK
	KMiRaNeQT5F3uhBipTADBOFdZMvO8ymhLsUQlxsr8=
X-Google-Smtp-Source: AGHT+IHUxrKyZpvD7fy2nd1gEgyZ6D9esMG93wZrRE99dQhqCp+RdJFq45V1O1M4oDg6d3sN+VDJyg==
X-Received: by 2002:a05:600c:5490:b0:471:1717:411 with SMTP id 5b1f17b1804b1-47d84b33bc0mr77838785e9.24.1767868591419;
        Thu, 08 Jan 2026 02:36:31 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee243sm15399033f8f.31.2026.01.08.02.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 02:36:30 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	fabrizio.castro.jz@renesas.com,
	geert+renesas@glider.be,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	biju.das.jz@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 7/8] dmaengine: sh: rz-dmac: Add device_tx_status() callback
Date: Thu,  8 Jan 2026 12:36:19 +0200
Message-ID: <20260108103620.3482147-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108103620.3482147-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260108103620.3482147-1-claudiu.beznea.uj@bp.renesas.com>
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


