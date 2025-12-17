Return-Path: <dmaengine+bounces-7752-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E44C4CC8158
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 15:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86D1B3081D48
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 14:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CDE37C0E0;
	Wed, 17 Dec 2025 13:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="LPRMhSfO"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED1F346E4C
	for <dmaengine@vger.kernel.org>; Wed, 17 Dec 2025 13:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979556; cv=none; b=COURAuU2fNW69g9LgUvm2e8HpFSm0Uir0m+QQcjVo7rxM5CBeh24X0KXb6zL9QKFDvgAKA7qomOdv7DzVRivN8qBJrLpTE/hWJpqTUYfGgjOxK+xBe9Jv1wKnIUFze8DzLrKA8aO2cj/IrYXqDCaKcd99VO1AV9oKv5zxYJBGiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979556; c=relaxed/simple;
	bh=7JrTv0IRsL9KnStfX7nUQ6IVV3uIn2Bop0bK0zMenlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ViW+Q6tAdUfLWPYUqPHmR/ftL8h9M3CAsamszONKrzyF0G1JFIIUkiUhD0bqneHZhxlSSTWRBupSWJDC5EE37CHjgExu7Rsrb8KvoNmxWmVF0SdzUoYtyA2JH/05sW19qZ81dBDCnmZn+6qLE0XWlPmuYEaWCWVz0TtYhxc8kUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=LPRMhSfO; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4775895d69cso23376185e9.0
        for <dmaengine@vger.kernel.org>; Wed, 17 Dec 2025 05:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765979551; x=1766584351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RF8g82ixW6GvXALrrpEyK6fcK8V7YLOR+NrlqZkXU0=;
        b=LPRMhSfOb7UYec44CeVsJLNhS6pSE+AwqzV4S0n6ow4AKI6zpc5vHDTgUoS4erDCrn
         C24BeVWYAcoT8mroZd9B1JSzSZP2DImOej+T/m4NqKq+ymJcbpv1MW8rfHh1GyWgIYbn
         fMMNlqgjruUD1TdbRkKczn/J+IqywhlVw0zKtm06U3o60LQRVWDVVocVxSd1+qV9A1dD
         3DXjDjNpbjz7IFAXA8XycsiXzlohc54rsXyN77h73YGUc8pMARP417aQ8D/wuOhVrQFd
         BP+VvAg1/aGg+hByuJLBRQfT7lYxRcQBNU1aaJHTGp/vsttuvaShd3JuOf9xGNMlD0hc
         IcPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765979551; x=1766584351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+RF8g82ixW6GvXALrrpEyK6fcK8V7YLOR+NrlqZkXU0=;
        b=ENqIlrDMZJRpv+jAd5mTY4MvJgP+OfziXvfJlAZ8E7HJ5pWQJhBKqMEHFsl13UPkKw
         0tx6CVNNl6wibZROlHUG/XNJIc/5+vJtZ4pM+ViD+y1rcwPHmYE7/WzGxiYGdUAhnHrD
         1oN7bfqZjx36VxSxG152lobhe1013iUJB/7kXs9/1kdacMxHssVQhFhkXKGWuBC4kUGL
         hIHLphaLxqspRvFzod51N6AtJBcqTIDh0EJMHmM+Y3nIxAr906KHvfd0x73wlhP+dDMl
         DWL5965HTUs0OCYwLKyi3XlV81oXdoxLTJ6CYvsh96GroqF8AOcSECyiLGgDBHPM7ilh
         IzXg==
X-Forwarded-Encrypted: i=1; AJvYcCXBG+EqoJScLvda8SGiP+2Q+x50o0DYQPCPsqo0tULed+ZAKOPDMf79ifeR5lT4U+fXFHkkpJlmsqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXCAfWNKHz9ltlZWcbAjpSYT0n0cDJ6XApcF+1UZkO8Mv7PGS8
	eLpHZ09/wfohPIdKKjXqvvym2JpyBEpvnopmaNmUae9Wf6orWs06axF3B7MYxVXaygo=
X-Gm-Gg: AY/fxX4KPqbzlO3t6oQQAXUYwZcv2zu7aOyMnHLbhlV4R0nLVE46McagED13CZ1eLZJ
	C1VcIBKVK78gAlmcSnkAsthTHgljaTdySWR1KsRufGqBPHl225fpjZg1tmrRcho2a8BCPuazqUY
	N1f7g0JyZbNJLe2Jv6uo/ju5TbVi21XJ1tO/JTPUfuOGR2wepsSsRExs08bIiL97fZe90jKBhC/
	PKdHcldtDbblIe/9pfWZQmFtDHkUNM71HAFHpjFfoMSyddQRYmFHsIJZvAvmTIBq+lXjLC6255r
	XQ7yAlZSxdhOwqPGRxOxfLj5hU1igBGoUpfMyTmgKtak+1KLNjvVpH1Ys+1qEYiyAk/po9jM4cd
	Hb+KdalUKTFMQtKCLPsOden2fOuDyueVT9RGmMNesGb7ufXuCOo9k81GPM8jHq81rfQkXwCgjRb
	FOhhUyBZGUuO7IAUXZGR611pe4v9lyJG0ikoZQ68mB
X-Google-Smtp-Source: AGHT+IGMOXN3SUPQAVr+4rMg2uhbTT6gszrPHta6YOzDTU42mejwVH5KVf8wsbz8i5OAbWyz3sVNMw==
X-Received: by 2002:a05:600c:3495:b0:458:a7fa:211d with SMTP id 5b1f17b1804b1-47a8f90f364mr186111885e9.29.1765979550854;
        Wed, 17 Dec 2025 05:52:30 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310adf701csm4508000f8f.42.2025.12.17.05.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 05:52:30 -0800 (PST)
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
Subject: [PATCH v5 4/6] dmaengine: sh: rz-dmac: Add rz_dmac_invalidate_lmdesc()
Date: Wed, 17 Dec 2025 15:52:11 +0200
Message-ID: <20251217135213.400280-5-claudiu.beznea.uj@bp.renesas.com>
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

Add rz_dmac_invalidate_lmdesc() so that the same code can be shared
between rz_dmac_terminate_all() and rz_dmac_free_chan_resources().

Based on a patch in the BSP by Long Luu <long.luu.ur@renesas.com>.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
[claudiu.beznea: adjusted the commit description; defined the lmdesc
 inside the for block to have more compact code]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- adjusted the commit description
- defined the lmdesc inside the for block

 drivers/dma/sh/rz-dmac.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index ae8a4bd9d7fa..bb5677f5a318 100644
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


