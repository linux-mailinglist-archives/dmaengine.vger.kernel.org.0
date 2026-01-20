Return-Path: <dmaengine+bounces-8397-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GnSImKjb2l7DgAAu9opvQ
	(envelope-from <dmaengine+bounces-8397-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 16:46:42 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B7A469AA
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 16:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D68C5E3BAC
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 13:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1B242E000;
	Tue, 20 Jan 2026 13:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="CixNRAjb"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA4D42EEDE
	for <dmaengine@vger.kernel.org>; Tue, 20 Jan 2026 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768916025; cv=none; b=CdiGXerT7GDeE/L5bsdIXL0k9K8PSQF4X96lW5bd0bHmqb0tKLy+ux01QqSw89RXrSmS/A7jW66a/M8tuyUePHU/5It84Q+9cUgdApMIOKjLuq1i/P9xSAd1Fl+kILZUVNEPhsc+pR07IdvT9lfKXUwArce55uG3kaukdf9L+Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768916025; c=relaxed/simple;
	bh=7+lvctd+mOS+R5PxlA728yD1a8tDc2B4cTOJJy3B6f8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nvf4VMNmU7T8wBgAf8wUdLtBtc73bAuAbGwkpM1mf4z+GKasmEwwjnOhyZUj83rDrXI6a7dC7o6IbehHpnZ7VOolfkjsYMiUIxY3QBWJ9lipnPDvWc8DB2l5sKhZkX+T4qgNZT/SmkZ1ZQ0oIBnolYwrw8Wy8JUAI6iUaUJ0NpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=CixNRAjb; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42fb2314eb0so4380944f8f.2
        for <dmaengine@vger.kernel.org>; Tue, 20 Jan 2026 05:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768916022; x=1769520822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qrf/4ha8LTjYdiPZBpuP6fOy7D8F/H7Z7s3chjS0gfM=;
        b=CixNRAjb1G7T/nvjjGu1aiejOEP11qt1eKZW0mQqAGGRuYhR27bOOZXWbccdlt4dWb
         ji4onEXm2JU308Fc5rQpT4eDvd3w4QFlZwDeV3HUGLTCT9VkRQQDP/0WaYSgQM6n3NLs
         CM2lp1cOY0k/PjunQMV+nBt3j6c4SiN644V8eZS09FRMrObhEdpoCNLQQEEJWBOk7J4Q
         BD50aL7qo5VaO4GojuqlrliqWVmymr9/q7Mm91QrMP6EBLxVkUGXwwzfH5MxrZb7ERQ4
         7rgyU4mIwRP9liiBCdRdPypFfmeK6A1ezHtQtdt2EPTqL2dF7Q0Sin2z2i3LyDgfdjRU
         2FxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768916022; x=1769520822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qrf/4ha8LTjYdiPZBpuP6fOy7D8F/H7Z7s3chjS0gfM=;
        b=McGSbth8xDhh6ZZiVUJB9Czln/ycquCmUpRMN3iWsMXDRm9fBHAlEdQfBOfcv5OTNB
         6SRk/iVQQlaeFa+3GC6XGCVJX35OJRKQr6H91veh6ReNgr+6bP8frOLq40xsFQQUJS7u
         kGd/ENTFIQ/LAbFS6gX07vwxjHQzLjGxlbXICHNwYH0kdXCImaHhNIz5Bb8xONq1KP4Y
         7QZ0T8OGIBENwTtCaXHwk6MWEn2PwZm6y/M/bTDMBJ+LWPVhy4o7pavrCAE0JOin5MPU
         +clTslV9FzKCSUeUTj7u9j/jV8buUQCx2i38PLbGNcyj8ENDxu7nOfNib4Uw+VoS1m3k
         VENw==
X-Forwarded-Encrypted: i=1; AJvYcCWpLaVRv24TtX166AWoAG5P/AElO5mnEnv3CIfDob+7pDdAkyv29qfhOsmwxcOapOevuP7pRVGzK7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyae6J2jVA/gqRTly1CnfmKp/MuG8fynTx7sSZFmxb9cijkx6Gp
	8sJN5acBVi3iRbdA55FCkd62KcuJ4Q0wFeYHLlX6HlgXJLTvtuz0Zi5NFvDZUhbr1lE=
X-Gm-Gg: AZuq6aIuwSRRSpHYCrVBKxKFcA7adF3Nbp8/GmNRe53ZPapvO/ZIkmXt6pCs1LBi4qL
	X2SMMx1ZiO1hcRD7SyqXjbNhh1Z06YgJLOgrqPVZdKt+8z9DqI9kru0AwFdoEjvEMVfKQ57eC0y
	D7uXdDK4M88PLI4nt50sfjEwAOETDHJh3HLkvPA5/oL4xhutNDk82OTW+8VlNFJfYfwhY0LJgGj
	0xcqSyhG5f59TQ0tD176Jp2W1h/FiQVJ1UfN18ae7OdUauwzE6eUZqJAck9RH3TXgUau+iC1V2p
	t3oENwudwxyqhdkhqpnMzSXs8lhV4OvQ9+PlfYuV8rDT22K1O5OZw941qsAEtu1Zco032731/fa
	O+AV9Q8FnN7O+9uhVd42S9IMOfTlPJpxCYk6iNhzSy1cma/kALZfKxjWc/4SUsYLWv89exuDFht
	F2p7F4ITsXBNDvuZbIRGNBaTxtqNXNJWPu6F5MySo=
X-Received: by 2002:a05:6000:2481:b0:430:fdfc:7dd3 with SMTP id ffacd0b85a97d-4358ff62780mr2583333f8f.50.1768916021652;
        Tue, 20 Jan 2026 05:33:41 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996dad0sm29331439f8f.27.2026.01.20.05.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 05:33:41 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	geert+renesas@glider.be,
	biju.das.jz@bp.renesas.com,
	fabrizio.castro.jz@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v8 1/8] dmaengine: sh: rz-dmac: Protect the driver specific lists
Date: Tue, 20 Jan 2026 15:33:23 +0200
Message-ID: <20260120133330.3738850-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120133330.3738850-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260120133330.3738850-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8397-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,renesas.com:email,tuxon.dev:dkim]
X-Rspamd-Queue-Id: F2B7A469AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 3dde4b006bcc..36f5fc80a17a 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/interrupt.h>
@@ -453,6 +454,7 @@ static int rz_dmac_alloc_chan_resources(struct dma_chan *chan)
 		if (!desc)
 			break;
 
+		/* No need to lock. This is called only for the 1st client. */
 		list_add_tail(&desc->node, &channel->ld_free);
 		channel->descs_allocated++;
 	}
@@ -508,18 +510,21 @@ rz_dmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
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
 
@@ -535,27 +540,29 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
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


