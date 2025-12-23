Return-Path: <dmaengine+bounces-7892-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1625DCD97E1
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 14:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52124302176F
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 13:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCB1285CB4;
	Tue, 23 Dec 2025 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="D2qA2H0D"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A173274FD0
	for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766497844; cv=none; b=lMHSVpvRj/5vgCZV5eFtZQgCNePZEIC26/wR+MothnFwNvEC4/iX+jVRY+ffyqnwUEMZ2auCe8+MWdc15MULUMzCBjFlTPhNqhXYcpqGGtL+olbS0Vmv5/vdzmDm/cWCZjOjxyaCU9tAKQM9ywGAYkS3VqdqNt4+TRjLcq6IcCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766497844; c=relaxed/simple;
	bh=6ZSYMN2SKXVTTfYd0IARyp5Sd5OHsSjCDdnQL0dBWGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sS3WVzweXW5jqvxj3Oy+VeKWf4eRYEV2gXzFjhrhSxYWXTNgGFOXOwvPUKAsUcyqxG8wGU7XPzDNFxdk75v3q00oWBxBYKAsS7ftEc6wudIfi2xojw/z0FdTlaXLe6qYGhpj2juidxosz1ubtWayDxauTPlLevrrSTYmWHryVqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=D2qA2H0D; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so39920795e9.3
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 05:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1766497841; x=1767102641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLvTm305m57LTYmm1aI4ieZDb54ktZ6C9ruLi16NB8I=;
        b=D2qA2H0DzGKjYswYFXadFnb09xtAoVX0qtHfEywD7pD8Oftm1wKbwrwlA7BTYR9IQ6
         Uj8J9UNrSwBg4Yx6SatY7LkmHEiBuLZ/rv9Jc+Xp/8X3B5M4Ywjaw7gB2K25RfAEGvXg
         3cvBuG/HKVz8UM2JMHp63J8wbNb/TEQ9tR5Ff4FOx3cXwjnAlNawWA1TNKDq/QGBH7HX
         rZ0cLlQlg8Na/Hk4JYAMXM2LusUxyiVy1FkMQF8sYwLyK1bglVWyDpKZ9GFcxhiB0qxj
         QDPAsuWQT5R7H/Xb8e8e74Kh/uRGZ5bf1j2kUXjoDYvIjWJ7KreIiFatmH3s7zDjTIE1
         Gnww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766497841; x=1767102641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gLvTm305m57LTYmm1aI4ieZDb54ktZ6C9ruLi16NB8I=;
        b=ACR0qrc1VihhPt9IHn7qC3e85t/Vgx1q3sIusF/gaaJyythRatK3PgFQ+QaytbsCpL
         euDjehEzlSJPBfo8UF9g3EbvQaGZ61grIziWe43en8bSKveMkcMIXqJ7+6CcgzkbWzk2
         L18tHuEzOJBzCUFauU9uwA2pVy8upIvhNJcTXXU0WsCIUDVIzwST0f/NaAX01gZ6NLGi
         XMc0p/KJ7Yq/sWHER4agIEkTcLqr03tTGgf2SKiLWzQTqcvR3tNL9GY9M/7GufHUZfT7
         CC89tmHRyupkKaZ7rQyCmwz1sNG0ENxsXvLb3Hc/FlinqLgSOjtjDSMaC408GJxkfhJ5
         UtzA==
X-Forwarded-Encrypted: i=1; AJvYcCXtH2yhm3cThqjxJ5/GIbmRkxgCv7+suFg9ZLDwGoNoYq3NXL1nix8U53rjx5SEkWy9muBnKEXhwsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEJRAsmtQ32q5vENbErM1U3Isy0xWTfiwISRnDgA+SwJHd31kD
	36HsGtBdfFpCyzRq3YK9twWiLtY5CixHYgmr8ILWXylLOdNvO6W8w7eFT2TQE51AXgc=
X-Gm-Gg: AY/fxX4WgRA5cOG0tibqf6W/Gyo0/O2eAg3oYgclOeMV3HRLLRkhiy3eDxCFmu86nQ6
	aG4mP6BVlTbwIUtk04FrujRvNyi8EP8WrNA5cTheWXxfOOg9FeD+zUDx7J5MS+a0zuant5Bl2CC
	B3cnQCSJZIkD7biiSEIgR4eiTPxBml/4ia7JaeS4Ab6zup51nyyzpYH2yPNoS7LJl5Ok9jLHCFX
	fSVX+xZBNiUI2lXztoie/J+VyzCXHI1zVkQ08GtnsxM0UNZ9n/FU98mDFx9zcQwD0AcgqckA/oN
	SiioPxBOd4vppxTz2Za9aQE/QeEHFjODZggvnYWrXPLUBVoQOMd7D9bcBEEhc0fw+kc94n++rmN
	lmCE96c4d6UBXJLkBIggqK4jjr9tHkGie0Uq8x+adTRcZ1UxNBl12K0vsv0hDljoa86wLPsGuy2
	6GlVQkzd45i61OW59ROesr9ipkxk/pE0gw1qLm5QQVVjFqNyEm2n/BGAgX0UkcI6IndkN5qPg=
X-Google-Smtp-Source: AGHT+IEHaI451aDZyjBnBK6G77N/7eVYDQxAvy5RL96QV1B2EAWVR4YQBYxfsbJGhMmbq7yO9N9+Ww==
X-Received: by 2002:a05:600c:4f42:b0:477:55ce:f3c2 with SMTP id 5b1f17b1804b1-47d19556d02mr172647885e9.14.1766497840923;
        Tue, 23 Dec 2025 05:50:40 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:620a:8300:4258:c40f:5faf:7af5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d192e88f5sm237921025e9.0.2025.12.23.05.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 05:50:40 -0800 (PST)
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
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v6 1/8] dmaengine: sh: rz-dmac: Protect the driver specific lists
Date: Tue, 23 Dec 2025 15:49:45 +0200
Message-ID: <20251223134952.460284-2-claudiu.beznea.uj@bp.renesas.com>
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

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The driver lists (ld_free, ld_queue) are used in
rz_dmac_free_chan_resources(), rz_dmac_terminate_all(),
rz_dmac_issue_pending(), and rz_dmac_irq_handler_thread(), all under
the virtual channel lock. Take the same lock in rz_dmac_prep_slave_sg()
and rz_dmac_prep_dma_memcpy() as well to avoid concurrency issues, since
these functions also check whether the lists are empty and update or
remove list entries.

Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v6:
- none

Changes in v5:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 57 ++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 9e5f088355e2..c8e3d9f77b8a 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/interrupt.h>
@@ -448,6 +449,7 @@ static int rz_dmac_alloc_chan_resources(struct dma_chan *chan)
 		if (!desc)
 			break;
 
+		/* No need to lock. This is called only for the 1st client. */
 		list_add_tail(&desc->node, &channel->ld_free);
 		channel->descs_allocated++;
 	}
@@ -503,18 +505,21 @@ rz_dmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 	dev_dbg(dmac->dev, "%s channel: %d src=0x%pad dst=0x%pad len=%zu\n",
 		__func__, channel->index, &src, &dest, len);
 
-	if (list_empty(&channel->ld_free))
-		return NULL;
+	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
+		if (list_empty(&channel->ld_free))
+			return NULL;
+
+		desc = list_first_entry(&channel->ld_free, struct rz_dmac_desc, node);
 
-	desc = list_first_entry(&channel->ld_free, struct rz_dmac_desc, node);
+		desc->type = RZ_DMAC_DESC_MEMCPY;
+		desc->src = src;
+		desc->dest = dest;
+		desc->len = len;
+		desc->direction = DMA_MEM_TO_MEM;
 
-	desc->type = RZ_DMAC_DESC_MEMCPY;
-	desc->src = src;
-	desc->dest = dest;
-	desc->len = len;
-	desc->direction = DMA_MEM_TO_MEM;
+		list_move_tail(channel->ld_free.next, &channel->ld_queue);
+	}
 
-	list_move_tail(channel->ld_free.next, &channel->ld_queue);
 	return vchan_tx_prep(&channel->vc, &desc->vd, flags);
 }
 
@@ -530,27 +535,29 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	int dma_length = 0;
 	int i = 0;
 
-	if (list_empty(&channel->ld_free))
-		return NULL;
+	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
+		if (list_empty(&channel->ld_free))
+			return NULL;
 
-	desc = list_first_entry(&channel->ld_free, struct rz_dmac_desc, node);
+		desc = list_first_entry(&channel->ld_free, struct rz_dmac_desc, node);
 
-	for_each_sg(sgl, sg, sg_len, i) {
-		dma_length += sg_dma_len(sg);
-	}
+		for_each_sg(sgl, sg, sg_len, i)
+			dma_length += sg_dma_len(sg);
 
-	desc->type = RZ_DMAC_DESC_SLAVE_SG;
-	desc->sg = sgl;
-	desc->sgcount = sg_len;
-	desc->len = dma_length;
-	desc->direction = direction;
+		desc->type = RZ_DMAC_DESC_SLAVE_SG;
+		desc->sg = sgl;
+		desc->sgcount = sg_len;
+		desc->len = dma_length;
+		desc->direction = direction;
 
-	if (direction == DMA_DEV_TO_MEM)
-		desc->src = channel->src_per_address;
-	else
-		desc->dest = channel->dst_per_address;
+		if (direction == DMA_DEV_TO_MEM)
+			desc->src = channel->src_per_address;
+		else
+			desc->dest = channel->dst_per_address;
+
+		list_move_tail(channel->ld_free.next, &channel->ld_queue);
+	}
 
-	list_move_tail(channel->ld_free.next, &channel->ld_queue);
 	return vchan_tx_prep(&channel->vc, &desc->vd, flags);
 }
 
-- 
2.43.0


