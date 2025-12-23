Return-Path: <dmaengine+bounces-7897-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B508CD97ED
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 14:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 352D7302C649
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 13:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381DD2D7DC8;
	Tue, 23 Dec 2025 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="I540loXS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD632741B6
	for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 13:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766497852; cv=none; b=Cm8tO4hoq3+27eqS3P1DLqjw1OBQJ5XYFNti+plzkr45KDL2OceXiZgEsZcVcpDBN/sH6syWI93LSo/mbIgpztGygnmZ/Aj74hs98vyLMAf3dATVRILrVHmrbvOlKOF/Yww7s2pxFHzzkgtAlpPZ+YTBKSdLsg8U8GG0jo2sTp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766497852; c=relaxed/simple;
	bh=/aqSn+Vb8r0d6N9C+LFafAX/mCxT084ZgLbgcXEVgTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uXpjnqCc512oHiaeMcgvEJI7HSk0cjkbGuQT3nt912KY8OOyxvh9YBqacNP3nWnnGP4HqDMzfDxT3OPU4rTfbG8wvTXkWQAY+TzXtsNdp7NkEt2VgLINpRv++/MCpQNGeAY5COCOvdRC/8iK5j6WeYN2g6ykKnILdMFe4wZTdzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=I540loXS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47796a837c7so34486195e9.0
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 05:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1766497848; x=1767102648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKcT1GmUyDCROsSAK1ZbDjoO1xH25TSzA+fFNjS21cI=;
        b=I540loXS2C5Qk0ZsH0dnjtWRZXYuj/daMYqC+UKqGAf/j0uBCZYfm8WsU+86CcSLS8
         9N2mcf7SvYo1jQrwzXnlLwq9pgX3AlrUNZONXORHeFl42BaGIEQGUrqK9f5GuXiH8Qje
         AtHnRWZDcQb18rixgALQJGEYqT/gI/Uv0ZbkcMu1llI3zDEGgUI5PmsRfVra4qNe4N7U
         +gEMf+rVZ7oFlbFUNSAJ+Z4Dqx1K6vTwtpK44vrO8qk5niPgcs1T5nTWG0jRN1wYgku0
         jo3eXL/NEBp4OtjCfFlb9xQeCryh6n5uxtFMdbUO+n71bJzlvmVW2yf93j1b57zcEO/f
         blXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766497848; x=1767102648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eKcT1GmUyDCROsSAK1ZbDjoO1xH25TSzA+fFNjS21cI=;
        b=lPmz0N/wdmS1zpEwl4LGuCtXu8Lt9EQ6KmYlB03cGyt4Zvgva27MuAIPzno+1Tutex
         JUzL0mTi2Ed1B9f/iK+AbT870GCS0BNIYi9IWO1OX1/NXzRFTo1cwbPsoo9uxGUOuAgR
         rfkt3Wzyre6HtzU3qM6HkRTB9DQ/B+ludI3HasfOMcvZAQ+qObvWuYcC+rmgApvMIbhq
         1nfFPiE9I/G2C667BpgQpKnrDgIgg7CUVyzHKaob1lwnnwRV0DoGCj/vE+H7i5CDUSOA
         acwyPpUHQmQM4DJH3JOWMwnoEJElJ2cfu67lUzOVb6tvdInJHvq6Ip2PV+APYoNUSnX5
         MChQ==
X-Forwarded-Encrypted: i=1; AJvYcCXP3KTq32gMGQNf2ObuLs1VMqPG9DzKCq1dpNs5+NETuqdwEH7dJ8gyPu0W4XJxG2CniYD7LDwAirY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMA/YQhxn8um01OYZCq+giZzHXaJxmvba2BfkGjPygVYBTFKbJ
	he2MeE18Cd1E3PkEz2dc8Mu3gxnE9vWe4us7ud1bWkruNWr3eOvy0w82Q4FkMt1MzKo=
X-Gm-Gg: AY/fxX5qufo5eBxuvDUT29OT4KmY8wgfPCQH1qQAGle4jPw6EHaMJC3K1dKpfbZ+IR2
	SX4MWPUumYr866TiaJiPuN/7XG5G213aDfXUyKCaJaq6VuuUwhjhGZ/CN0k9DBggCUHu3qrXch8
	R35RqSycle22zZ68/RN1eBJdlx4nO+F7tGitRcX1/yXELsetszqF6N5V2ZO4+ZI6TWZL4JdGL5Z
	8aYKfBgDZ8LsDKLPJR+Czobit0TlYWOw67qHxj1J44AtimwT7rQoTmA2tgzEqD9VDtNiwKqwniU
	vVn2tDvPJYE0ApCObMw/SM+OrLKcB90p7MTtTWKR5xYDZ0HQnWxMpJneW8QrB0t6QKi/u31zb+5
	/7TU5tfziTcIVVwbv9iecE8XPPv+6wbECmG07IQ0V4QcVSfIPVwFIOheoBD3gtmBxQvIrYoX405
	RiochXM9wXDqOt6dqLczKsIWb/qQ6NB9/02EGs2FpNrzzlodF7ov8/2FQ941t6qpO8eBBlqzSx+
	zDRGvmDlw==
X-Google-Smtp-Source: AGHT+IFmeB9K3I/MQkOzb05XFK52brMWDg6nvkajGCk7Ev/65dM++m5feqWnaI+T5jfjg6XqmfjKig==
X-Received: by 2002:a05:600c:c0d2:20b0:477:89d5:fdb2 with SMTP id 5b1f17b1804b1-47d1c4d78b4mr98877005e9.14.1766497848094;
        Tue, 23 Dec 2025 05:50:48 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:620a:8300:4258:c40f:5faf:7af5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d192e88f5sm237921025e9.0.2025.12.23.05.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 05:50:47 -0800 (PST)
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
Subject: [PATCH v6 6/8] dmaengine: sh: rz-dmac: Add rz_dmac_invalidate_lmdesc()
Date: Tue, 23 Dec 2025 15:49:50 +0200
Message-ID: <20251223134952.460284-7-claudiu.beznea.uj@bp.renesas.com>
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

Add rz_dmac_invalidate_lmdesc() so that the same code can be shared
between rz_dmac_terminate_all() and rz_dmac_free_chan_resources().

Based on a patch in the BSP by Long Luu <long.luu.ur@renesas.com>.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
[claudiu.beznea: adjusted the commit description; defined the lmdesc
 inside the for block to have more compact code]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v6:
- none

Changes in v5:
- adjusted the commit description
- defined the lmdesc inside the for block

 drivers/dma/sh/rz-dmac.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 72ec42fedac6..45c45053e9df 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -250,6 +250,13 @@ static void rz_lmdesc_setup(struct rz_dmac_chan *channel,
  * Descriptors preparation
  */
 
+static void rz_dmac_invalidate_lmdesc(struct rz_dmac_chan *channel)
+{
+	for (struct rz_lmdesc *lmdesc = channel->lmdesc.base;
+	     lmdesc < channel->lmdesc.base + DMAC_NR_LMDESC; lmdesc++)
+		lmdesc->header = 0;
+}
+
 static void rz_dmac_lmdesc_recycle(struct rz_dmac_chan *channel)
 {
 	struct rz_lmdesc *lmdesc = channel->lmdesc.head;
@@ -456,15 +463,12 @@ static void rz_dmac_free_chan_resources(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
 	struct rz_dmac *dmac = to_rz_dmac(chan->device);
-	struct rz_lmdesc *lmdesc = channel->lmdesc.base;
 	struct rz_dmac_desc *desc, *_desc;
 	unsigned long flags;
-	unsigned int i;
 
 	spin_lock_irqsave(&channel->vc.lock, flags);
 
-	for (i = 0; i < DMAC_NR_LMDESC; i++)
-		lmdesc[i].header = 0;
+	rz_dmac_invalidate_lmdesc(channel);
 
 	rz_dmac_disable_hw(channel);
 	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
@@ -556,15 +560,12 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 static int rz_dmac_terminate_all(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
-	struct rz_lmdesc *lmdesc = channel->lmdesc.base;
 	unsigned long flags;
-	unsigned int i;
 	LIST_HEAD(head);
 
 	spin_lock_irqsave(&channel->vc.lock, flags);
 	rz_dmac_disable_hw(channel);
-	for (i = 0; i < DMAC_NR_LMDESC; i++)
-		lmdesc[i].header = 0;
+	rz_dmac_invalidate_lmdesc(channel);
 
 	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
 	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
-- 
2.43.0


