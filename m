Return-Path: <dmaengine+bounces-9435-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNJWDh0IuGkWYQEAu9opvQ
	(envelope-from <dmaengine+bounces-9435-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 14:39:41 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F6829A96D
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 14:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 814073067FDE
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 13:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7A539B96A;
	Mon, 16 Mar 2026 13:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Ra3GcFmS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768FC39B94D
	for <dmaengine@vger.kernel.org>; Mon, 16 Mar 2026 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773667995; cv=none; b=fcplrtk8u8CeIvJBmrkGwUw4xQs/vky1cMUCnVWe9zXsf4wuqVs07QABFjuuhwRZpleNY3AzBqfWpJENesaMgGrXXmfhOy9PUAVBsnZ0Bi27m318ZvhBFQmgWJVP2TDR0i2LPjrprKZM+xZBw7TgwWCP+UWqayKMiOUUqaz3XmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773667995; c=relaxed/simple;
	bh=B2RbK6kjk6s67mYLWwiA6Nze/yCN+GHj144MbZkTQcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TxkgPncST+HFiose8LQLcjNu9LWYVCNkJDfxJSTxOnUISb5xKoW+KmchpjwhAS8o5HgheYkjdTbYd7UiHJbtbr82Jup3JzOiGx3qu+zGppAosFfVdQ/rGbdm5nc1VLTg0j3mkgPPNC3NFbCPUe8xliK/BBNTIW78e2QV5PJC5vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Ra3GcFmS; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43b3d9d0695so1275446f8f.0
        for <dmaengine@vger.kernel.org>; Mon, 16 Mar 2026 06:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773667993; x=1774272793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwjXM8kgcUK2RRM+wE8XQ1aADlrQmhM2JzmmP4SWYBQ=;
        b=Ra3GcFmSqNoyk/No8bseYy0dSSB4CyBlKg9fjx7ZreyUorwk7oo8HaNtnbvPdzMld0
         XQ1qFmg2ln36SvV+4u+YiGtkiJZErz+DpeRgkJ/gdFQX3tPs6oXkZBok/x79lXnyAXDw
         GSFKTJk3pRcL3hHv6HNfPSQw0agA1k0QKG0n2Vo+qHwee7hPT2+Q/hT/DMTB3xIFaGy2
         3jv/eGVHYLSDj8t3hCk1n0VwbtU5RgzE7KbaToD5TQKKyem2gdB62lswZ66FoyzmnsOW
         BPY7xr8Co2G4d6J4Pq0CwBDhvL9UyX0wWPDGw4vABCLJGdk3WOAX3ydr3XX6PvtnS/sH
         cpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773667993; x=1774272793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uwjXM8kgcUK2RRM+wE8XQ1aADlrQmhM2JzmmP4SWYBQ=;
        b=rAF8Wb6yKjgpxj4IxYto2OuirDP70Upa3VZnkBrYOAORiLYBYQd27sKY1j4GPFKZ6+
         zfSq34ts7TUloSBKakpba9rTBOkwUdg4KrGXgZMfcWzbx3BCrZKuhL2tSHF7XTzd7jNY
         vaelIRz7ygRXHO+rsftm7UAw9IkYPSX/dnp07QDRufJ3cjQQ0MQWFW178QaFsj+SCA6p
         GQDEgb+hoqMNCU2dp1b0IcHj+/VHzUkppdnKy+FlLsrI8PMlKMBmphEwq0b1zLx8g5KT
         O9VHGPdYQ9V4PyLPOV6/17eKuxtD7EZJBSQ5b69Ut1FagfOceDywj6pdMwv3Ih3/xmYl
         BN5A==
X-Forwarded-Encrypted: i=1; AJvYcCWl1w2IzUgqR2WftUhw/dhxRQOqT6Ogtm6I4/h9mma9ODfcRysuqTq9nKAvXLm76Pafc5zrprgDxzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOiF0sXNO9/jusLBoabDMfKEWX+b8ago64CD7/eAJZFj5Zt/JF
	x0RcnSaeIyJg57diQM88+y5bRbEE/ZP98qU0upyCnSXAFYdq5tjfzLclxXX4xrgicZE=
X-Gm-Gg: ATEYQzysDlje6PHKKFasvzuzcUOjx6l9U6gMCiN/00pgr+YSODFiRe4RXbMkuZsZghc
	nChgSG0fffxuvMWz6egcRiGnBWX2tTdqXjkWqG0F1GjHk+7KdgijQS+IhmmEvZxvlOBgYMlou0/
	1AW/ymrVO0eBpHtl6MYGPY/oGySJxSPsSEplkiw6v+xGPgwd0UwnBSp0ndJtaaKy/jzHjII6QpK
	9jmgRqSeFszSfHrDd0I0DJNPCW2T1XAIqQE0SnjXQ/8vHBOyG+ktH1Wg6KJRyOOAn8GC42Y09LO
	uQGTSOE+vV4s5EZUoNa47ZkE/fkZJTt6Tzgrt39WgR3hxTs2Bfvnon/2Ysnc4w+Iuh+Zu4FNy99
	qagvMZW3kjU5ep59KyQ6r1q/U/Uj9LlQch1RXw9eiBXfFsDU9QMnWHt9abiHj37SAgpvAMTCbBL
	emF3pMRpVz6Ax6BgTg905gcXKNU6PsTt7ckfz8iN8Mb8w6nGPN092rmcMn+Nv/YkWGAKu54LVaL
	jsPE6c=
X-Received: by 2002:a05:6000:1a8e:b0:437:7300:eb1c with SMTP id ffacd0b85a97d-439fe1addc8mr29819532f8f.26.1773667992593;
        Mon, 16 Mar 2026 06:33:12 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6208:0:c5e3:3624:ad1c:6b4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b419270efsm11629888f8f.16.2026.03.16.06.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 06:33:12 -0700 (PDT)
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
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v10 6/8] dmaengine: sh: rz-dmac: Use rz_lmdesc_setup() to invalidate descriptors
Date: Mon, 16 Mar 2026 15:32:50 +0200
Message-ID: <20260316133252.240348-7-claudiu.beznea.uj@bp.renesas.com>
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
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	TAGGED_FROM(0.00)[bounces-9435-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 99F6829A96D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: John Madieu <john.madieu.xa@bp.renesas.com>

rz_lmdesc_setup() invalidates DMA descriptors more comprehensively.
It resets the base, head, and tail pointers of the descriptor list and
clears the descriptor headers and their NXLA pointers. Use
rz_lmdesc_setup() instead of open-coding parts of its logic.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v10:
- none, this patch is new and replaces the patch 6/8
  ("dmaengine: sh: rz-dmac: Add rz_dmac_invalidate_lmdesc()") from v9

 drivers/dma/sh/rz-dmac.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index eca62d9e9772..6bfa77844e02 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -460,15 +460,12 @@ static void rz_dmac_free_chan_resources(struct dma_chan *chan)
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
+	rz_lmdesc_setup(channel, channel->lmdesc.base);
 
 	rz_dmac_disable_hw(channel);
 	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
@@ -560,15 +557,12 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
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
+	rz_lmdesc_setup(channel, channel->lmdesc.base);
 
 	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
 	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
-- 
2.43.0


