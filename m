Return-Path: <dmaengine+bounces-8401-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOzEEAgfcGlRVwAAu9opvQ
	(envelope-from <dmaengine+bounces-8401-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 01:34:16 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4434E8C9
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 01:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 587517084C2
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 13:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B8943C064;
	Tue, 20 Jan 2026 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="PiprLM5W"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01343438FE4
	for <dmaengine@vger.kernel.org>; Tue, 20 Jan 2026 13:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768916032; cv=none; b=FhPBR5/5kA5eMMyUrjjyWH8VNLY89BvNvfqVwY+ChsFs33tOGqsCZUiiRELU3mMAY8qKaxp0D1wJK9xRrPTB9inDZQFvChzTlSqbEdDiBmGSwN9UF7HD2JOjG4SnGk6fUfoDlkTXC+YkHrZo1pof7kxcX1qHJHPnmLLDP/AFW3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768916032; c=relaxed/simple;
	bh=m77zOpALSyNtcyFmOUw9w2UEW+MDDblSkvPS8bNGpNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BpgVYR7Lfp2FqWRPnbtkznsmZwhOlY10irDzverN7zkxa/tqU+Mn1HkoXNUNjmEqQgDMlO8mMnS40/3AkPbbza5zjFMqA/BAvEbYNTRotvQV+LIXs42q7UhdSp4lA06SAfvbVxq92qcD5N2u3BrXUTRLUY6VulnVBoA3UvZB9fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=PiprLM5W; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-430fbb6012bso4572127f8f.1
        for <dmaengine@vger.kernel.org>; Tue, 20 Jan 2026 05:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768916028; x=1769520828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKsTj4m4+06Hp+IFPIu8Y7r+3Udg8E1fB4/dkbfWl54=;
        b=PiprLM5Wqrs2WxZ8VhvSZIJoP57Mbw3RBm5T3YEEvhOcizs37m61/vZxaw+0tROTUY
         +qamxBCWAVmD7nYROG66j2i1djEVdgYgbrYUSJwNnLMRgk48VpCR+AYUn6pHb485671G
         MM8uzxbCP1HFzJKL1e1THPj+EjlJ1ZNfYhHxIJ7wDc/n6Mxl+NBMjqZG+j2r3SWK1NCx
         acn7UlOo7r2bh01h+LTcR6WGCtE+v2URDQg+HwFSUg/x+tzuqSKfgJP3gx/99Yyp8ccJ
         wUy1We93hYCJ5RHzBpnEBJMRdEyFEA8E3jVfqV2JOwQfeEEwLScL9maoPvtCCIoFknQP
         2oJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768916028; x=1769520828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QKsTj4m4+06Hp+IFPIu8Y7r+3Udg8E1fB4/dkbfWl54=;
        b=UnUaSmgV1I2cEqn+dYOMLX67JrCVfA8PGJpOwFMk5uMTHYalcZJvCrqshI49pmLuXK
         HS8jok8sx8Zh76dJXoRluGa8tI7vlrHEteshDwP9RCDAU+L2JrEdSuZYKZ4emAAbphh1
         8J8LMl2khY1dnsTzG4zIOsNNft7ytk25ZaGkMlY/SH7/d5QL4inQH9HrPkForIgdQ4ED
         pBhcwKDS7OFs8A7MI9wBmlLXfeg4ZONJYhnqZ5D/pt6TX4byaEvDtnrhj41LmG4GphfX
         S/XpYje+GEAV3lIVc+PQ6FEFBekD7f7KeG0+ns69ELJ+OjRiEh+z8rw8gI8LQ2yH4gv0
         gdDQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0l/FRGuaA553hB8iBs11pgF0IYkiw0XOx/oVPnOzAHLIE6GS6Q8bDF4WDm8PZwxZdYXn7y+fjuuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYgf9PHCdrVUkJEsuEXBkBrl33FCXdu9D0Lnlz3Wiv5lM+aT4P
	oOkN3rI9mxE1UCVDuamHvdRyVrNn/waqnQ1dzz20YKPgmO44IIPrMvLGMeiAArIausw=
X-Gm-Gg: AZuq6aL97YulQSUSgmLPXw0qqQAATM3eUdXIV8tCXR5DCG09JgaFi5XbEB7e+PYZqd+
	WfS6yTjQrQKKkAWH85ZmiIvw7TVB6eZbZschEnepGhn+20L99euuyo/IGVOBf+ihyMsEgV0uvtR
	XR9guKXn/IYsnqCpuY7/AHrvF79LTH/RyF3hLQf58q2Vu+OyNTkVdWQDI2QlLPUDCjLUMBcU9cH
	kC5Cu6TwLujrtCbSDzkk3DLmwUN3j9XFa+7A1avYKb7/4pUZSDXfyQkaXj/GyXH9ZqqUNZkoQ8j
	1NtuNV7NawSiCn+rP9FJl/LMj2iW72noj6arZAfQqvzVoNuOpvMnJ1V29LzhMdrWriiMUM1UvXf
	YG7YH6VZu80/pcXTi+A2G8mlYPugPH+/OLzVP3rJPvYiW7vIj0XpILrE9G8RVUkVviIcYT41ocW
	aymOGymTL63vYe7mQgIG+Tg4365vWXvjX1r6W3JSM=
X-Received: by 2002:a05:6000:2486:b0:432:dfea:1fa8 with SMTP id ffacd0b85a97d-4358ff300f1mr2754677f8f.45.1768916028280;
        Tue, 20 Jan 2026 05:33:48 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996dad0sm29331439f8f.27.2026.01.20.05.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 05:33:47 -0800 (PST)
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
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v8 6/8] dmaengine: sh: rz-dmac: Add rz_dmac_invalidate_lmdesc()
Date: Tue, 20 Jan 2026 15:33:28 +0200
Message-ID: <20260120133330.3738850-7-claudiu.beznea.uj@bp.renesas.com>
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
	TAGGED_FROM(0.00)[bounces-8401-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bp.renesas.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,renesas.com:email,tuxon.dev:dkim]
X-Rspamd-Queue-Id: DF4434E8C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Biju Das <biju.das.jz@bp.renesas.com>

Add rz_dmac_invalidate_lmdesc() so that the same code can be shared
between rz_dmac_terminate_all() and rz_dmac_free_chan_resources().

Based on a patch in the BSP by Long Luu <long.luu.ur@renesas.com>.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
[claudiu.beznea: adjusted the commit description; defined the lmdesc
 inside the for block to have more compact code]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v8:
- none

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
index 1d2b50d6273b..4602f8b7408a 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -256,6 +256,13 @@ static void rz_lmdesc_setup(struct rz_dmac_chan *channel,
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
@@ -461,15 +468,12 @@ static void rz_dmac_free_chan_resources(struct dma_chan *chan)
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
@@ -561,15 +565,12 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
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


