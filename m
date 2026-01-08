Return-Path: <dmaengine+bounces-8112-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C91D02A1A
	for <lists+dmaengine@lfdr.de>; Thu, 08 Jan 2026 13:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B1B3A3019E22
	for <lists+dmaengine@lfdr.de>; Thu,  8 Jan 2026 12:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA56D38A2A6;
	Thu,  8 Jan 2026 10:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="i/YXFDgK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91624BB0AE
	for <dmaengine@vger.kernel.org>; Thu,  8 Jan 2026 10:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868603; cv=none; b=eOkVciw09NT75llbOYHcfhb1N584KZ+TUB6OdV9MU84Y1dWG42u7L5gTxhyjAApD2ghRxlrKt06njkKrPp3IPF3f93EzbXlHXCVqSDK4VXfFMwXMWlHHZRwrOiMjoEpcOMhCjqu1OqQtZ+cbEUX2PVO4PaGpgsXbhgZuyrEbj1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868603; c=relaxed/simple;
	bh=QS+utOwh+0j3irGBIh+JGLsDHpGY3hY1exq7PJszteM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3S1VGv6LtRjZ3/yPyLhwDJpP4dJblED/BlhUf9qpYfH+CVk2eBwt7e5y/qpsLE5FyYT/mVNp0BWeXYzlWKrSc7h+xl+UW5Z+Z757pBs3q7gXA4jSXSEIVv0dk+0zAwTFNMxsKxh+rMz6F4T2raDO2FIjYEtfoAVcCfqn2WZYPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=i/YXFDgK; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47d1d8a49f5so20219765e9.3
        for <dmaengine@vger.kernel.org>; Thu, 08 Jan 2026 02:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1767868590; x=1768473390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofcyHkZ1yfZGW50Mzzzs74lToTM5Llj7vVSz2eItujY=;
        b=i/YXFDgKj+6yIi4KwtQa/ShZFxLqRgg6CSJKAFSqYxG+GrdcopAuLsPY3aoXnFSt98
         HL86bo1RS7wZ3HQnwOzTpEKrHO59WoJsYc5RiTKS33d8gricDC2uLLY2qvY9VHzIuDx+
         3SRXVq5kU2WoV4HlKwyqvLOpNwTDOY+nAUkZ/b5baof2amgX7qqGxeDQGYPzK34H+hHt
         Pixm0IABlddDMiDtZjB+kPhJvrsivE2osprDdYLVukigxRt7DP+yASd3qGEkg0OCV+G+
         NnKk6V+uCv3T54DLLxSIv87wWWvSGwqvaxig4XHIhYjnn87y0V5mpGon7NkTEjOzQW9x
         DRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767868590; x=1768473390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ofcyHkZ1yfZGW50Mzzzs74lToTM5Llj7vVSz2eItujY=;
        b=RazCvUg6leRny4s5LxTYweHKfUxkbBNkcXjNZOGSwnhp6C3btVkAls0vMGCzGTMX9p
         82XKV0P+j60kWUDkoHChkEmZ+lkF9Ub9a6dwREk1zZlrnxnQ1rj0RnVP5cye8BYGtklo
         Rr4DEOilpG9IHfz1kmQXn4nzs7x6Wi6oAj7BGxe2WdwnbxGw//XEXZr4L4QvylOQVBuw
         A5FDR/zBVXn8BShiPxzBF+WKAcpXFfjYQwvhygmC4U1B0OCJHRWYNKcDya77Mnu/IXGS
         7tYklBY6a9ar/lTO4tTVBHKmacAaqWi5Wj4rzRVXChNcVaiVytyB/VvuAQDSuxKtNE6H
         mU/w==
X-Forwarded-Encrypted: i=1; AJvYcCV6VUYwhRn6WS6EEucLyg6F3sxgxAq0HFwTbfJiqKbITNHAK2crKeQg+bCSBFL5Ppx0Lz6ybFDniks=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgjvLLHlFcKpg4u4md94GeUGnFyr4JIn+Z4+q3oB+1mlLZsiDs
	Uz+iDDB7Ii1lXJg1Gjt2bJqfPh2mtL2Wbbw/0bafpsPzutQM4WSKMzs4ac2itBZsTbg=
X-Gm-Gg: AY/fxX5BsPRrfk+jPes9AfA5pFl9GazbUk8XFaEVtXGA9GyqxhE+f2kF8WqOQ9tyzxB
	JAv2NFIONY/Ts1LwD81SWGGX1+P0KoAUcQ9hUrT0J1pO4+BmyyluPmQteFtYAS/eqXR8HApNCZs
	WKI+3vFf57LRGKhZZKEUu87vPDdbSodcTsjxYDzxI6e3iQvVUkp+mIuyhfCP6iB32Xk9PO0jEw5
	oh9BRoSfdQ6ZlG4xpdxJ7aeuBicwuM3M1VhzVILJILnGnTEP+3iz+7cCF4TnbzbBDi0/DXoUwNv
	xxff4hAIbtUdXyuswzSfvxp18GI1gotLqAg+PVjPxt80wELanGSM20AkeoCp6e+8W6zJRAzMfjn
	nnlRgtDyGr1p9ctT9lVIjiyD+wS3iaqQ46rZsgtZ3tP6dgJVVpfp9Xdw9wsj0y4jd/nrSOuqOQa
	M0He8XdjL5drPGMhjbjfHQvlB6COYNS/YuVQe5whA=
X-Google-Smtp-Source: AGHT+IG2SJAd0v0AcYc9v7TjJkOxRE15Dp8J8Nuxbu/xPEYPE9IbPkifz+mDxd43qWjdlTLmBxDKDw==
X-Received: by 2002:a05:600c:1f8c:b0:477:7d94:5d0e with SMTP id 5b1f17b1804b1-47d84b40955mr66133135e9.27.1767868590027;
        Thu, 08 Jan 2026 02:36:30 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee243sm15399033f8f.31.2026.01.08.02.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 02:36:29 -0800 (PST)
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
Subject: [PATCH v7 6/8] dmaengine: sh: rz-dmac: Add rz_dmac_invalidate_lmdesc()
Date: Thu,  8 Jan 2026 12:36:18 +0200
Message-ID: <20260108103620.3482147-7-claudiu.beznea.uj@bp.renesas.com>
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

Add rz_dmac_invalidate_lmdesc() so that the same code can be shared
between rz_dmac_terminate_all() and rz_dmac_free_chan_resources().

Based on a patch in the BSP by Long Luu <long.luu.ur@renesas.com>.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
[claudiu.beznea: adjusted the commit description; defined the lmdesc
 inside the for block to have more compact code]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v7:
- none

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


