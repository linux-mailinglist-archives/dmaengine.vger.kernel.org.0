Return-Path: <dmaengine+bounces-9431-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFtuKEIHuGkWYQEAu9opvQ
	(envelope-from <dmaengine+bounces-9431-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 14:36:02 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C4829A894
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 14:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8CAF0301EA27
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 13:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83080399368;
	Mon, 16 Mar 2026 13:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Y3cleuAq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0488399351
	for <dmaengine@vger.kernel.org>; Mon, 16 Mar 2026 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773667988; cv=none; b=aU7vfV52yV5ahphXy7zQJhiwgA1KBx43XIv139c7tcsp7FwsVdGjWQZ/DinxkYP/tF8Vt5p0r8NLQJmO3pZmbCk96b3vyJzOl+Aa1U5h4fmKCoV1y1TjFuBMGbnA71lv7AcgdaBtkmxpXT3WCc9EShYwIRq8QSbPtrnZziyZe1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773667988; c=relaxed/simple;
	bh=5vNGiQOV9z2LuY7BexBTaM4+b8WdnI5Dm+Qs8Ojt3x4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTT5nSh/zIKjbxymtNOHWZuxqD6AX3kEAvzNVpmNZJJpR6DvzUlLI1iocIjYvvtT02Jq1SRJNfSQ2Hl1o7xqzcQ6+itdQpA4blQ8Bo8G0YdBoMhQKZwFdG1922t9hvLwfqFKql94B8RLMJQrvM0r8mGA8Ciaf4j/DtnSyMtfw84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Y3cleuAq; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so602120166b.2
        for <dmaengine@vger.kernel.org>; Mon, 16 Mar 2026 06:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773667984; x=1774272784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+W56HzNycC2wMkiULlWF3cNiCiN6FevvWbhSc6vRfM=;
        b=Y3cleuAqHMD2a1ulTa1eWT8AYviCDnSgUM1AjUDk3vEQfxmWIN1okEtY2l/sUvGgLl
         hoYhqQGkCZH1YOQAmJ/Q+hRM5TsSbvmrbD0u4XVRbar9sKzQO4E3H0FKVpBwwaaNf1RB
         OQVVM15AxdJ/KwTYgCxt1jdcdfl4wMj3a9L70LDq0SKSLhQh/ToEDQnrV0wGzrzF6egR
         3mM+Niqtg7eKyq3Ai36fl5QliY9C0gEt1NyZAdAVWhPkuLFlpdT1rmXurk6Lpc0sqQFB
         Pdjzj5d8YQ+LlqlLTbgv8LAjIzwjKFgyBdtZS6DCREyQWR8JTAmfaQsgWH2uPZov9axC
         xx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773667984; x=1774272784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3+W56HzNycC2wMkiULlWF3cNiCiN6FevvWbhSc6vRfM=;
        b=Yu1H23MEN7kfucKaDtDuSlSkLbI/gfCELPch1CKEryNOt/Vu/NYlRWal0OC9+OrNId
         OFxcvRjUKz3NW4H5253Y5ItnDqyr/9SO2HmvaGE6SPdcD7XzJ2wLXnHY9wVjbSZJDx4u
         utEPxzRZPkK7fwdcLc1F12rY5XMBgL4yNh0++0BKbpOSRxPs2LcXKqXwe9vYvgvT6F1N
         cHcb027LmGKvyZhO4PN7Mn+F9fOOTDEfRn5L9puQCv3A60YEIr9eWCanLLNLNg0yG5w6
         YUI+fP6+8unWXKe4Z8o+WpzcCzx9nf7YYPzdkJwKdSO5uvYnXFHe0zmMjcjDLVYpmxgP
         ZUkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCGSmmNNsFwkP+drBAQ13Em/AKxSq65qwHR33k6PKOAC5Q67B4HetDr9ZAbBTXHDCkaIyfhaMr26Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWCv5LD/4uEWjxaY4RNse76GC3ktX4lmJtHGU4mI9RJUKUg6u9
	4Ga2v4KiIviQ2StdnYMJs+SxBySdQHmZj+xW8UV781aYqUz06ywtsbeyPwmB4e9WqlY=
X-Gm-Gg: ATEYQzzSa0qg8b/2ac3lhF4bCzS8xmjQRfe8b3m0NckiS/DzwpVnHa93o0kFLM4STZr
	Z2/ZSveeiN2H2pwOitsMkfLLNadQPFpVk1EfPY9CeJebUxK6dupdZNteR1YZSTLHGhT/xLHAd8e
	e7Z5IkE6v7BywmTImRFkZ2HinBvczreMhFn7NLFtMWDq772QbPU3qxQE8pHqtK2Jf0aXUo36y9i
	lS/PdbY+hJT5G+tz6xDBP1yq11I+xT6PylY5HQle6wzVhAeJzxvFvehoBqqEO+TBTm/fQWHnsq1
	GZD5iNgv3DFbUjMHCjrY/Ed5H8Z+88cA9kgYZz8XwRyKACZRWDf4mFWUifufoANKvrmfbxjIJDU
	aegYCjEp9ArXzp0V1QYsmqCyk3utClVOBltE7p0NdcRzpGE7PzoNHfwsl3n3DjvsnpuZqAupCPI
	Fu59IjCRq55Nemk0vfwTVWeOzokpGPJdLUsecXEtcCXIxzcGUCG1QukQhX0Xx1RrD7/ba9kwIVf
	+mj6hs=
X-Received: by 2002:a17:907:2982:b0:b93:5405:9260 with SMTP id a640c23a62f3a-b976519a1e1mr613963966b.30.1773667983963;
        Mon, 16 Mar 2026 06:33:03 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6208:0:c5e3:3624:ad1c:6b4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b419270efsm11629888f8f.16.2026.03.16.06.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 06:33:03 -0700 (PDT)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	Frank.Li@kernel.org,
	geert+renesas@glider.be,
	biju.das.jz@bp.renesas.com,
	john.madieu.xa@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v10 1/8] dmaengine: sh: rz-dmac: Protect the driver specific lists
Date: Mon, 16 Mar 2026 15:32:45 +0200
Message-ID: <20260316133252.240348-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316133252.240348-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260316133252.240348-1-claudiu.beznea.uj@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[tuxon.dev];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9431-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bp.renesas.com:mid,nxp.com:email,renesas.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,tuxon.dev:dkim]
X-Rspamd-Queue-Id: D7C4829A894
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver lists (ld_free, ld_queue) are used in
rz_dmac_free_chan_resources(), rz_dmac_terminate_all(),
rz_dmac_issue_pending(), and rz_dmac_irq_handler_thread(), all under
the virtual channel lock. Take the same lock in rz_dmac_prep_slave_sg()
and rz_dmac_prep_dma_memcpy() as well to avoid concurrency issues, since
these functions also check whether the lists are empty and update or
remove list entries.

Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v10:
- none

Changes in v9:
- collected tags

Changes in v8:
- none

Changes in v7:
- none

Changes in v6:
- none

Changes in v5:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 57 ++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index c75e9202e239..ec1b6b00af76 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/interrupt.h>
@@ -452,6 +453,7 @@ static int rz_dmac_alloc_chan_resources(struct dma_chan *chan)
 		if (!desc)
 			break;
 
+		/* No need to lock. This is called only for the 1st client. */
 		list_add_tail(&desc->node, &channel->ld_free);
 		channel->descs_allocated++;
 	}
@@ -507,18 +509,21 @@ rz_dmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
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
 
@@ -534,27 +539,29 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
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


