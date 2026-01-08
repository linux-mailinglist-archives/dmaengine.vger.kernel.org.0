Return-Path: <dmaengine+bounces-8107-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C27BD0325A
	for <lists+dmaengine@lfdr.de>; Thu, 08 Jan 2026 14:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DC7530B7168
	for <lists+dmaengine@lfdr.de>; Thu,  8 Jan 2026 13:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB164BB0DB;
	Thu,  8 Jan 2026 10:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="DR9o07p6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4145E4B9E4B
	for <dmaengine@vger.kernel.org>; Thu,  8 Jan 2026 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868591; cv=none; b=cch60UVJXg/dOCKIc1DNxAHMLLBIQwwWNwyF2PifTyYn80AElv4gg4UmtR7p9GIuyfY9nNH0Hp9bby8yaNUxe13n7eSXIJwDzxN/V9b7+0nVhuHxJs2ecxohGsU6hhQjnJiLFWGlRvgYPqMFjO3VUhi2K5leT4MT9TcO5I9Ds6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868591; c=relaxed/simple;
	bh=JyEbq8Tn/Uo5/rzkdivZJn8DiJudAQoXSYyRKYcviZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqVaicfwCeSJ3O/ZTOPvqoZu4duVludr6eiZaq5yVKpRUINZGAQWmPKR67i6ycGcwd2WDl8eGUuNyKTmxJ8GCK+1U3j2lkt1CqyHqhYyMYhdBRQPTBEQpdiLxMw0bfbrhNJ3SdPsaHWggbCjPcPGbuIyLo3FmJCeQbWRDPpoGR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=DR9o07p6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47d1d8a49f5so20219025e9.3
        for <dmaengine@vger.kernel.org>; Thu, 08 Jan 2026 02:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1767868584; x=1768473384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJKnYHH5iFZVhNa979c5sT22P1hY4dxyKYzImPI2Bi0=;
        b=DR9o07p64tbezMxLYgt9ijnbUpSDNT+02CyrkEiBtu9P3BLXV06RGmViY/nijp1YDY
         dZX4o8uOEBHtpv9zbHVR4Askt9wWTGMA+gte06xxBvmN7hAlU1DkjRgq/qxcNXLP21Sn
         ypuKN2vtQMgDxssyyUGc9yNAEnvlmHesiOk8Io6EzmkrmFUIkSeIfyvu0WKelQK2mjLG
         49lxo2nEoabXROTamyscDWxCMcixIDA8nFzYtDhINBPyw4ZVhM5frKevD0tC+JXU12Fs
         +nyg/P4zP38jvs17m7UPBRSQwJTkp0BEn77Hp2ZgQabPMEYCpNvHJeGBfYIZAEUVgRDO
         9j3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767868584; x=1768473384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tJKnYHH5iFZVhNa979c5sT22P1hY4dxyKYzImPI2Bi0=;
        b=L7wTUrnfgIrGPgVM7cCMd3RhMDZpkZQ6YvErrkp7dqjmbLoBQ6LQ0UGSGusQ0ECRo+
         c5FZVeyDtS/xsadIZakYMvb4XtAjRHu17x1JlDu2MNr+UmJaC7OG76Er9w+I4xfZOURz
         eLDKDQ7/I2kwih+Z3FS0oZtS2j+vASYlSE9CTizlYz+O2o9SdBJsLHMkUZNrkdg/eAZ/
         nKkMLZLo0Phsh+7ycTuXj1w9SNUs1c25UZJAGys5XvEfGRJ3dO10kXkvx7cTXT1ApmtW
         B7gQOdZIUjGbPTNs9StalFhJ8+H5CmrjwOk9yS+ZpyvY4R06/omyfi7t/NpuM9FiWsnR
         aBMA==
X-Forwarded-Encrypted: i=1; AJvYcCWSdw17jWpOaYfRMECTj8v9Uif91uyIZNgBaDQq8hqFNTJAa+ylTOYZ/ttKL7cIVT+qlpRAZKSZ0zk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr2lq+YlKYCux2SCzE9ewG2AJlrQNR55WBTOXklsq++3IjQ/NT
	Cqlw6TiklHDNX4zuq6Q9l82/u4AxbSm/dtMVlvRzTlIadEZVIihhBexFR81QhLjT7S4=
X-Gm-Gg: AY/fxX4P45sTKNep+xMKOklTfs9CdPCHG9M5e1Lkcacu/RfuZHAGdWXv/E8Eo0QxOvD
	RAmcRUuAhMMBTD6weOZ1gNCyPNhraA5xZgrvAahJL6/BRZhJYKCO1D4ph1NBNgPvxtBUMPxL5FU
	Zz6FMeKqk9r0nadCB+emwmiln1FMjkmGKcCdix+obMuoL3se1wOlUhl+QEs3LUw4dSot28bArbC
	Iq0XLLDlGdJ+7/xEaJmCPTf7fjblhwfCYJPss+uFHPOatrooN4LkymWS+Z6OnDjGLTGFkf9QQzz
	yARSFFEjpziSh4qrmG1YgEnZSRW19rbkkqHW72mPQx3nqvFiUChTT380aq0+3vGuqsoY6m3goCA
	jbWkhtJxgIWkde2cdUJB7TWvkagvve6Kyrm3miDxCfornJbSOIJoQHTyqAFQZhSoHutw35KZb/y
	OdUyDycGXf4bRF37GFJcn/Jds4UnDJV+ikYI5IghM=
X-Google-Smtp-Source: AGHT+IHIn4DooV1mtjazn7yQKWIVyIXO9iOYz2GWsNA8OQ/d9RWgsYlYP49zJM9rtUcU0rRpnde25A==
X-Received: by 2002:a05:600c:4f0e:b0:470:fe3c:a3b7 with SMTP id 5b1f17b1804b1-47d84b1a3dfmr68260285e9.5.1767868583679;
        Thu, 08 Jan 2026 02:36:23 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee243sm15399033f8f.31.2026.01.08.02.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 02:36:23 -0800 (PST)
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
Subject: [PATCH v7 1/8] dmaengine: sh: rz-dmac: Protect the driver specific lists
Date: Thu,  8 Jan 2026 12:36:13 +0200
Message-ID: <20260108103620.3482147-2-claudiu.beznea.uj@bp.renesas.com>
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

Changes in v7:
- none

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


