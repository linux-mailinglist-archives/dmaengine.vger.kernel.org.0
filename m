Return-Path: <dmaengine+bounces-9561-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QL04FXMvvWmI7QIAu9opvQ
	(envelope-from <dmaengine+bounces-9561-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 12:28:51 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E82AA2D98D7
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 12:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3609D3008C12
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 11:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D943A545F;
	Fri, 20 Mar 2026 11:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="SNRAD1nE"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E34139B97C
	for <dmaengine@vger.kernel.org>; Fri, 20 Mar 2026 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774006126; cv=none; b=V8QB2nptO0P0HIwAhoA8mNC4soJSm1MUzbjTK7OMilodlAHpxoQ+pvJcUBW1X3hCzxYGhzJYzJY+wXjH+jMcdAifu8twvFPVcfztj6IFl2kAPOn+Yy2+mz298rWAkJwzaEWSi0G57+qd4Ktpuio2TlGLwiA5xL0uFA4GVIipvgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774006126; c=relaxed/simple;
	bh=wmr9euWcjMPiYL6aerS6JNLwSHajZ0RgtQYB1/Fq66c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zgc0oaHtypb1kxhKsGRZcv7mtzRgXNAMXddBQeXRPZ6MDMFwaRZr1+6qDs2wmMbP408cZbt8kPlGOuJCJ0StNaF4HqNQoe//DzeFLJV9f7eFBacYEbax94yj5putszQBHH5dFkPbYrVgiuCImTc64UumesyaeewIr9v5O7rOPLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=SNRAD1nE; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so4642315e9.2
        for <dmaengine@vger.kernel.org>; Fri, 20 Mar 2026 04:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1774006124; x=1774610924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veJgc6lsn6LoKy5z2ASTYaikRHENJLTUNe/jR8sCCz4=;
        b=SNRAD1nESNOnFbZTYx1zxjVbP6a4GEnhqWuftV77S/AIccGF1vGf/8g1b/LOQlhEqX
         lUuMU3+OMOWhhCVhMVtC/gC/0aKkg+5VHaQdQDRVYuiVNWi9MFlGHPvYyGVjZ5CpvIMC
         pdmDsEVzEXM8wXkbHe3XcoIfNPdDns0xBIG27NqEVKjdGP+wV1KM5oAr1yWGdHRKkO0h
         hKZQxGXb/TgWXBhnYTL66ZElWYoc6n0vkDXHRRDGo/WfHTtZ0x9S1pH6Kw7PY/yKE+Hc
         48NT8AKc50A86MpV0at0CN5q5ojZa4FnjeEEjd8gENPFFTyAWVhM/avrx7EOOvAT52UU
         au/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774006124; x=1774610924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=veJgc6lsn6LoKy5z2ASTYaikRHENJLTUNe/jR8sCCz4=;
        b=sCUBclUODQxZ5941IDFAbSckf7FEWeCTakVQItsYRHl0mWzXHxGrPOakngAOOIgJ90
         M58XgjevWoIKRAgOtdbjUyqNg+Eg2NCvTJlexoJzIdB9Ezz9E7ldogCa+S4sSJl14Oep
         DdoOB7KZa2InVUEQ7wlJtVazglwtfl1ZF8JF4UESid8Hoebemhaf2itsSY2FnTgLk2ZK
         oXNoDAeMtVfo+gJN4c/rO6eLMheIuXO+qpcihNKNxqpGyskSMxm5oKFKrA8ZFa5RkbDR
         G5FNRR7wtuhM9JAxUY4+HORrEu15RUNwYJ1RemqcMQRcjHMkd53IVgowfLuZ7pHZ4Cm4
         B/QA==
X-Forwarded-Encrypted: i=1; AJvYcCU3m1H4gmVey1Gwd4bAsDLvDPJScHMS8/2Eq9Fw5QeSpMFbq36FqpSILtaQTl4CdD8+0Z3K1raB5ss=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb2RTDGVmAioBOc+qdQoy3GthbeGM0EBI5L9Vbfp/nZ0YyP+Rs
	7JEeGYjlKZhYklKm9WbLcr5NztWHABg6lYwyHRfMQAqBBJZHUJcht1mfCYaYgiwrnlI=
X-Gm-Gg: ATEYQzw4ql33RntQ8lPygGf2QRiKplhkoMdAQEVHMSxROoVP7ixtporT57oIzitcA+s
	46GMY++9Jo8I3IJx9+LhSAa6/mTo9md1o7UewYPpXD77ApYrVTEDGlxqGp287zyVuWKJ/gBZwd6
	FFofG2W312f8YnfSEpyWVCvp+duPG4COUeSviGU7aJW1tycp6IE1xwrbC1t8Loilr1T9Ok7fp/v
	u16wqWt9z4+Onl6WJCw7F9tYysrYJFpQ9TDUg4gMxfenlX7hoD97aBDDGay0RMxzBDaJDWVSH7H
	/xynXO+J0Kpp4k/+cLN6T36uMBk1J3rHJW0uPFeizAkTa6WA0JUtv42OwXzZQHC2Abvsl8OZZv6
	CuGSe97N0KxWkMGyRsUc20d9plB1raKj8oIpj2I2+niPptwOPkWsueB2BEc4Y/geQzJfRmk2WgE
	qr68bvFozCNKmoErdbsqSp5TwYIToaUegQzo1FAbUeES++SSx8/rlfZiDbL/rfpqc=
X-Received: by 2002:a05:600c:4fc8:b0:486:fbf6:abd4 with SMTP id 5b1f17b1804b1-486fedbf2d4mr40608545e9.9.1774006123656;
        Fri, 20 Mar 2026 04:28:43 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe836784sm49869935e9.13.2026.03.20.04.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 04:28:43 -0700 (PDT)
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
Subject: [PATCH v2 1/7] dmaengine: sh: rz-dmac: Add enable status bit
Date: Fri, 20 Mar 2026 13:28:32 +0200
Message-ID: <20260320112838.2200198-2-claudiu.beznea.uj@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	TAGGED_FROM(0.00)[bounces-9561-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	NEURAL_HAM(-0.00)[-0.975];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E82AA2D98D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add a status bitmask to struct rz_dmac_chan. This currently stores only
the enable status of the DMA channel and it is a preparatory commit for
adding cyclic DMA support.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- fixed typo in patch description

 drivers/dma/sh/rz-dmac.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 625ff29024de..8148a1c78e12 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -62,6 +62,14 @@ struct rz_dmac_desc {
 
 #define to_rz_dmac_desc(d)	container_of(d, struct rz_dmac_desc, vd)
 
+/**
+ * enum rz_dmac_chan_status: RZ DMAC channel status
+ * @RZ_DMAC_CHAN_STATUS_ENABLED: Channel is enabled
+ */
+enum rz_dmac_chan_status {
+	RZ_DMAC_CHAN_STATUS_ENABLED,
+};
+
 struct rz_dmac_chan {
 	struct virt_dma_chan vc;
 	void __iomem *ch_base;
@@ -73,6 +81,8 @@ struct rz_dmac_chan {
 	dma_addr_t src_per_address;
 	dma_addr_t dst_per_address;
 
+	unsigned long status;
+
 	u32 chcfg;
 	u32 chctrl;
 	int mid_rid;
@@ -295,6 +305,8 @@ static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
 		rz_dmac_ch_writel(channel, channel->chcfg, CHCFG, 1);
 		rz_dmac_ch_writel(channel, CHCTRL_SWRST, CHCTRL, 1);
 		rz_dmac_ch_writel(channel, chctrl, CHCTRL, 1);
+
+		channel->status |= BIT(RZ_DMAC_CHAN_STATUS_ENABLED);
 	}
 }
 
@@ -306,6 +318,8 @@ static void rz_dmac_disable_hw(struct rz_dmac_chan *channel)
 	dev_dbg(dmac->dev, "%s channel %d\n", __func__, channel->index);
 
 	rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
+
+	channel->status &= ~BIT(RZ_DMAC_CHAN_STATUS_ENABLED);
 }
 
 static void rz_dmac_set_dmars_register(struct rz_dmac *dmac, int nr, u32 dmars)
@@ -571,6 +585,9 @@ static int rz_dmac_terminate_all(struct dma_chan *chan)
 	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
 	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
 	vchan_get_all_descriptors(&channel->vc, &head);
+
+	channel->status = 0;
+
 	spin_unlock_irqrestore(&channel->vc.lock, flags);
 	vchan_dma_desc_free_list(&channel->vc, &head);
 
@@ -833,8 +850,7 @@ static int rz_dmac_device_pause(struct dma_chan *chan)
 
 	guard(spinlock_irqsave)(&channel->vc.lock);
 
-	val = rz_dmac_ch_readl(channel, CHSTAT, 1);
-	if (!(val & CHSTAT_EN))
+	if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_ENABLED)))
 		return 0;
 
 	rz_dmac_ch_writel(channel, CHCTRL_SETSUS, CHCTRL, 1);
@@ -874,8 +890,10 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
 		dev_err(dmac->dev, "DMAC err CHSTAT_%d = %08X\n",
 			channel->index, chstat);
 
-		scoped_guard(spinlock_irqsave, &channel->vc.lock)
+		scoped_guard(spinlock_irqsave, &channel->vc.lock) {
 			rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
+			channel->status &= ~BIT(RZ_DMAC_CHAN_STATUS_ENABLED);
+		}
 		return;
 	}
 
-- 
2.43.0


