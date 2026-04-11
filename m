Return-Path: <dmaengine+bounces-9987-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJqjE7g02mlezAgAu9opvQ
	(envelope-from <dmaengine+bounces-9987-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 13:47:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7CA3DF980
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 13:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABF8A308AF6C
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 11:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815FD34E770;
	Sat, 11 Apr 2026 11:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="LhxKW00h"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182F134D3B0
	for <dmaengine@vger.kernel.org>; Sat, 11 Apr 2026 11:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775907804; cv=none; b=nCPYig8gG33/O62w1Ab/dBxRe4m5f8dJBKxnH3r3BCnZ5Z7vfUREt2MTBbW/Kz+O3kKPfcE03qqqJ091vsVTcW+GPyElw12Dnno0G0nnw6ZBKCb/2eIQB8T0ahA680FoySWrWVZFYPd0FzqbsEVHw4hBxAQ5iX+38T5dPe9t+BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775907804; c=relaxed/simple;
	bh=G3TmLj2FVJVqKtKvmLk2oUEY0r77TRMnpm3HstyV+7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omoKij30Dhzy6HNrRlc/TntgpRl0QIXsnllsEXGzWyfEgiP6j1jxQwJk/06bLlO19sPNYO1RVB1fSxQpSJOSymsPTEWHst6fQsieQ5RIz6KXGJ49PPdtpwafUIdrGo3okD6dt0RbQK2jjJ7hBjZwUAW0ggjn5OgmV28T4t61GxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=LhxKW00h; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so20476055e9.3
        for <dmaengine@vger.kernel.org>; Sat, 11 Apr 2026 04:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775907801; x=1776512601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ofhw21hwQOsSk68dsZGLNvbmOD1TuowEEUPnaN2gTE=;
        b=LhxKW00hbKBJorlbA10anBSFzNH/waBeFm6dI10TfVYnMW1ccTDc4u3+fayFdCMP7a
         Iw5qHMXP14sSDK9fO3Oc20X9C7TK1MEfaPgscsiZKSeBMYsadvCCS+cFIoCPH78UDED7
         7GWh2EdFACDnJCJnS7RXVkjiXUjP020BziHMr79vr1vK4/b7u8yoaMzui15Wbt1BvLjZ
         3Js5z3b19EhkFZzNaJ5cgzYNywQYyRmPH6Z7Gjxn2z5FUKgJe3JcmkWUFf/YqmU2xhgL
         4fb9wnbOeBDbmbJSupubrqiVqxBWp3ULZ3pIws4gdra6CCBwCWbQU0KJKS1XuLtFO3Ml
         jRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775907801; x=1776512601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Ofhw21hwQOsSk68dsZGLNvbmOD1TuowEEUPnaN2gTE=;
        b=iIySHdw6aMDec+k6DL78VmS0vVRlkvyy1ko4f/CNkaelVCoOw03S0GXI+1svITIXtQ
         amrVqd3IWv+JOypsmysA3e4pCkYabgRG5IAqvZmxAAuOh4LBYW6IKLI44oXFzExl/N8J
         dLbZtlv0BOYd9MlNDDt30SkD4YcXURPkDKRN7QPNlbD1Gx5ADDMkP7g4fF/xvBsOcQjx
         ZrBFebYmO0oSUIKgKrw/JYrADHy7VOPRk+wuEJ0hqv5v7qF9VNpOBNuXU236P0+ak40z
         UtwcPb83bgHEYD0zg08cqY+EepzTVKmZ7cujVwaFEYQYtkov19o1f/sE5byjH7patGCn
         KqFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvgwZu3JeGEHPw6TyRstcU96RQSNpLHRmBx6QSJZFAxrhDpFigr+Nh7BnMfGWwME+pC58JoSSZNYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmJfHvoU/kmAGSwjAiFzStKlV9FTi9ob4oebZfaAv/6YcFxi7J
	uw+bbTqK2/R8yrNy3598ObBPWKexUbfWmC901g5R9j4mwW8wKpsLdmmOJZ2v48Xb4/g=
X-Gm-Gg: AeBDieua/ciTWESV5oFtZ8fDXk9I6k/SBqIzQTV+cpQ/MAQTcnaQI8uAmEWUqoXfjsh
	dBROWEZ0KQchGEGRgGj6BSXVfgcjqP+/m6UawXT5WLAu5Oh2KmGzYfSsExlBTovhw1rYeRv7TjQ
	weOkVU+ouUHhA+IfLsNGNnlAiJrmkPd1lGgebhO2wJq7JnDNCuZ5h43cxUpKBVOv7Xtff+qfpq/
	3x8ahh0xCoI8bV624n3ZYlYhxfwQ3DPI1CcOOPBFk7FXF5FejP7QWJCzk3FDJV9hL+T7tswfAsD
	zQMOc47e6vYPQ9i0iDHEXFr1usDQIzGp0RBeCtD7jSHC7mpxmnnfDgbLlTRQ1RLZa0H+dbb0pWZ
	ALNW76S7zaJLl0I4x2p0cHcxA03t6tAV8s4ukLEgYZZDqjCD8o8Wy+qzOPVZ6ae1yupJ1ziyjqT
	oFgs1P3n37ptA9txPnmHUTBfhNqI0c6PfOSQzjrD9Z+hN15vfhhzeE
X-Received: by 2002:a05:600c:c0cc:b0:480:1c69:9d36 with SMTP id 5b1f17b1804b1-488d68af13dmr58285165e9.17.1775907801492;
        Sat, 11 Apr 2026 04:43:21 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c981sm15776447f8f.33.2026.04.11.04.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 04:43:20 -0700 (PDT)
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
	long.luu.ur@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 08/17] dmaengine: sh: rz-dmac: Add helper to check if the channel is enabled
Date: Sat, 11 Apr 2026 14:42:54 +0300
Message-ID: <20260411114303.2814115-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260411114303.2814115-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260411114303.2814115-1-claudiu.beznea.uj@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9987-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,bp.renesas.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tuxon.dev:dkim]
X-Rspamd-Queue-Id: CA7CA3DF980
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add a helper to check if the channel is enabled. This will be reused in
subsequent patches.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- none

Changes in v3:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 0f871c0a28bd..1a3c33d28c6c 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -279,6 +279,13 @@ static void rz_dmac_lmdesc_recycle(struct rz_dmac_chan *channel)
 	channel->lmdesc.head = lmdesc;
 }
 
+static bool rz_dmac_chan_is_enabled(struct rz_dmac_chan *chan)
+{
+	u32 val = rz_dmac_ch_readl(chan, CHSTAT, 1);
+
+	return !!(val & CHSTAT_EN);
+}
+
 static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
 {
 	struct dma_chan *chan = &channel->vc.chan;
@@ -840,8 +847,7 @@ static int rz_dmac_device_pause(struct dma_chan *chan)
 
 	guard(spinlock_irqsave)(&channel->vc.lock);
 
-	val = rz_dmac_ch_readl(channel, CHSTAT, 1);
-	if (!(val & CHSTAT_EN))
+	if (!rz_dmac_chan_is_enabled(channel))
 		return 0;
 
 	rz_dmac_ch_writel(channel, CHCTRL_SETSUS, CHCTRL, 1);
-- 
2.43.0


