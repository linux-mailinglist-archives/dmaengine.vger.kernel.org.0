Return-Path: <dmaengine+bounces-7750-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AB0CC82AC
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 15:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B90F430928CD
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 14:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E96337A3D6;
	Wed, 17 Dec 2025 13:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="PJNOqyrK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9F836CE0B
	for <dmaengine@vger.kernel.org>; Wed, 17 Dec 2025 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979552; cv=none; b=JkLBwxxDiBVz709upa+zKdUrlgw0ij0U6QKooixI3+4HmJMWcL70/wQoE1gNSo+jn0oc0aejZqOTKfC7fuZnrU4bWAegm+RhpjuqJW41rvZ0vND5npFfD1BIVG+gYYGvrTQ72b1jhbwpPQZU0qgPsZ9E27OgLHfxcqnlEkqR5rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979552; c=relaxed/simple;
	bh=wu45FRjAX5rr5XwRhmViBxUJ1/TuJ66eIVeI/gV2slw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ji2OZD79UIMMpV82znEOL3Fkyip4tyh0ix3g/19wx9kmdZHXn5DWlZQ4Nr5UDIMcUhVILUS4DWAVY805co5D8Z3o0X2jziFV7jhyDzCjFocVEF6csvyIDT5xM0+cuAaMbhpRakQwELsNOMmN8MhP4rjJSbNs8gIVpvVBny/AMDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=PJNOqyrK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso61906795e9.3
        for <dmaengine@vger.kernel.org>; Wed, 17 Dec 2025 05:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765979547; x=1766584347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dmhSbGa11aoCwa2QR/4pZlPF5BdvQSf+YWgIGdjTtY=;
        b=PJNOqyrKYpSL6m+VlK/lFhP2/JrwSDRhD+pFYQsPgufCOYbK3FuIgXVlu+Z5vHqzik
         3awWcliwdqnCqnilf7nhlGmkVhvktoIMVUwIvrVC1DjYh+8SGXInBoOnX1weillXIpSX
         uGvRXrWLteFW6Rs1ZjfRFQQUc2egSHJxmbufv8o+BXfl6HeLaSI0BKYIBjxPny5R4ON/
         UjJg+FMp4AM+u83bMBNi5eBWjUJw6cCn83DYyen7pMNGt/AMSk5sH9wpisGcoahqTacC
         mgqNjKzKWNZH5fVWcjR0saG2ZPciQfZWF3R0JcsHrVqLQzeython6hKS+hlxFw9Qp4Uy
         +CvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765979547; x=1766584347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1dmhSbGa11aoCwa2QR/4pZlPF5BdvQSf+YWgIGdjTtY=;
        b=iHI2vwpseRti5ikODMOy8HWGWZPvGA/l/RgYYI3o5QKEQwtbSkFGIl6M1bYw7xsBfb
         6E9ZdWe7dcao7etD0XQAr0xfRL04zUbmRJV6dznbNhVaZAkNGtlClRQMTu6n6tYkIoeX
         aJAmUjyq6uDel4FoW212BMkO7+s21Fbvdi+4cUeyQzNFabR7nnWDl9zOd6brsyQFMuAL
         ttfhhVrYOjRE5xyLU0UiUXRZrvn6sH2zsWkjK04ZdevO/KXBCMB5JXziewL2hVYeG6Pe
         g0QRIHiXhzj8CdikSAgEO7UouwgDr2Ytb88JUMJglmsvOEJAPECOnVnlXB1asC5mcj/T
         NHBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtVJ0n/lRdnV+dUh0i0v/EoRimNes8F5XqGb7kgS/DdKajVQnMKludH7B+dwigq+B1IgGyQC52/U0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb+hvRanD2Lwj4mjj1r43T4IG7F5G5s6Qv3xQ3kjHOTiLKzW33
	Qb1MlF1TvCMcCVDqhwVGojoG5GzzgWSNja3O1viTFzPMtTPtw/16EecMGDHfImpJ0fg=
X-Gm-Gg: AY/fxX5tNLW/O2sN9Hy+KZ5xfQZleDBNN5EeL+7FhcQxGnfiXj4J2569/BUAZEYNQxw
	h7IhFVlzUbXfoQ61WVJiBVceXVvKPqbLrWhVqYeXUqR6H/5th6g6bbYDtiRSZiu2APyyU6LZLHO
	MWttqtpYhUg89H/HlZiSO+UphIr1Oc81F8pvWLLsaX6Uxr7a/2Hjvq4v6Nhz/lueWgJIlC09Ure
	QgMXNaTbUOCwzHQyNbNfcnAmgqC1aH2WkOMncYcHre6QusudLZcyGsXs8cmnV0h9RrGn/bqxYjc
	JgMSTbpfQmFpYsAf74bGTd3yvnyYEQ4MG6a+7s6zFLYlvrmIzosHh/QU2EGFWaplWszTLgns5t3
	7XB5uGYFUiIgQRZuFEq5K5PI7D3h3QaCRfhhHN44mBXj78ljPD1IUgK8F62YIqxG8vuz7OrBOQJ
	wqb9LJz8TGQSv4SzWalcT7kPrFZ9OB4TZXuTUWeHD40EkqbKMmE0s=
X-Google-Smtp-Source: AGHT+IFjWbNp9ucqit01hx4uiVylzLOMEnMuaieIZHHMFtzLDbezGqZEhZIONXkeIMCVRRvem4vK/A==
X-Received: by 2002:a05:600c:444b:b0:477:9b4a:a82 with SMTP id 5b1f17b1804b1-47a8f91561cmr176856225e9.35.1765979546692;
        Wed, 17 Dec 2025 05:52:26 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310adf701csm4508000f8f.42.2025.12.17.05.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 05:52:26 -0800 (PST)
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
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 1/6] dmaengine: sh: rz-dmac: Protect the driver specific lists
Date: Wed, 17 Dec 2025 15:52:08 +0200
Message-ID: <20251217135213.400280-2-claudiu.beznea.uj@bp.renesas.com>
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


