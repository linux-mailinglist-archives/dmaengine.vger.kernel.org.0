Return-Path: <dmaengine+bounces-9298-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAu2FaDMqmnwXAEAu9opvQ
	(envelope-from <dmaengine+bounces-9298-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 13:46:24 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BE1220E9A
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 13:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E149302967D
	for <lists+dmaengine@lfdr.de>; Fri,  6 Mar 2026 12:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EE1292B44;
	Fri,  6 Mar 2026 12:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="kdApaBin"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A4324DCF6
	for <dmaengine@vger.kernel.org>; Fri,  6 Mar 2026 12:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772800903; cv=none; b=pLTsvyD8NVgzi+nQzYgrVufkklIuaCfDHu379ncYa3qbWTT6WKe8aicXlYeMiMXk9mwhF6k/9ibG1Nh0bXOp4TLXVJDQkwBkdE60/oL5hQebhZwWCqke78XAcBUQpMDeQLhSIHpzz3jQ/s0H4Xxes90jteCACS9ldwnDTS7F2Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772800903; c=relaxed/simple;
	bh=HZ/1WFdnj+qO0WVw6GV1ZKDvd1Zn76kMVG0yFAr2u44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngOSzvrBI7N8j6QVSQjtmeRlv9MkvCqhbPoVEQ5Qbnt+PqWsaQy30DkDaL8SjBN8BMTJq5+sUOe6mC4aDKndPbVx2rok21+dxHHXHFOd9+Bj6Ayzvfz3CtUV7b3rwNxWcvLHpFi46XhiHdV3jzWuKFua/kBuAdxs15aYeOxXqXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=kdApaBin; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4836d4c26d3so72724175e9.2
        for <dmaengine@vger.kernel.org>; Fri, 06 Mar 2026 04:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1772800899; x=1773405699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtS0r5TfYlqaL5VTrxQnay2hKIBKEN7+yQrm8HEoL/c=;
        b=kdApaBinAt2kDkuIVkkiY6ZUkaY5pZz5QD5TdUX9op/vnu2Zu1O0IhSl2nZ8bbgKZd
         IGa+dkdb/uvENx0/+TTDk5L6lgeFIACyM7bflYNrQ1ZqDda+mZDXPgykd0/lH2LUZjP2
         411sWRLd55WzmvaHSS0F7UPzxlartjTKxDdvWYD+R20afVZ66BGZFj+dMrZeAv4J0XI2
         meXPRxwAg3KtG5CvSLSL/ru9RS0DdYHa9wC9NK4RgEpdcJReIg0K+APFfGN3od0gcTkQ
         /P5ctNkwpdFTNGX6FxN+X12wkl/fN+I3QPRth0VRimQ5IRqhZoh9ZJnPxjFaqCrEHtl0
         76Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772800899; x=1773405699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CtS0r5TfYlqaL5VTrxQnay2hKIBKEN7+yQrm8HEoL/c=;
        b=LbP3Z7gCe6c1qdZTkrhFXRQsZkdM6uxbyShIOVXzAbA5rjNfEUQ69jY2RhY92gTqT7
         Yh5BUjfBtDAfKTc19kpUj7snOip+2QOFT/tJi+6jHZfB6GF1xXhCBeodf0cylhFejGl2
         hMSLTJ4s/kJ+ZWsYCEMS7a//TN4BXCC7nVVTCAXAlP67GhUykBas9213ILIE6yNvx3z7
         BdzCgrp6YTQFg7V3iTeaUCGexG7FPYkhlT1/4b3FfDJN6fw0LJPsDO7PlU0OXDN/DDxW
         GHo8fOrwgQlkmUQJN71NFwY293bP7GLb7xSdacQRClLhHM0KSMSBmbmtJJswht/XruE4
         ZBAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrmkdXDnIiFI/WM+Vcj9y25v4Fx4C+PSn5SKABRID7d5b7Cml+NFWSRvioWwzvAtWKDOxQmbqWDyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx711QSTZtC1/I69vcc31URR3aswat5CiOVsP8sJ2eXtqvM0w7k
	hFWhoByvQlNQuPEDtkDyBdjs6IOWW0tZDVT2SIlwQ89FyFKp8C3sN7QGdiH+9VhSrK0=
X-Gm-Gg: ATEYQzw1OQiCTzT3b6xnzop9OpZsEIVa4QCYgtkxqVkgVw5ERfRbiGw9VTHmZQLfv9c
	0aAu+JzqTC394STnAO6MqabwVhxzYj7c9MkA7CgyRtifz3Uxs4EbhlEV9rQ1rD1umitFtswRGhe
	fusGwLMJ2kwSYdjlsohd46FtFVpQmpxWIyG1cHopasBE/b/eOy/bushvKBKfwoSvi8DhKhJ05yZ
	MMVEAEdHRB5sPO20rGcxD5gIopMGQq2mOxVK6JYlbsH1KQcFFg4/uT9Cq9cIbjhQMZ7En0zvRD5
	2LNdErB2LkxZsyLynjNU6QeoaC1AgDQDaaXbr5UXUuzrWbAVDy+9ESIxJ/E39nJZ4p6oo2vj8Na
	BDGhMJTRgS42kg5qUytbE9TWTuutltjoHOLu1/WS5YOEfE+JtWhQkycNsly1SImf8xxxg7E1T9+
	V04Hn4Vcj21Ld7khkW/5KTeAK3VIDYPQgeItaB5JuIM860UYZZTTA7
X-Received: by 2002:a05:600c:3e08:b0:483:7eea:b172 with SMTP id 5b1f17b1804b1-485269675a7mr33794685e9.23.1772800899339;
        Fri, 06 Mar 2026 04:41:39 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485276b0c38sm38150505e9.9.2026.03.06.04.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:41:38 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	Frank.Li@kernel.org,
	biju.das.jz@bp.renesas.com,
	geert+renesas@glider.be,
	fabrizio.castro.jz@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v9 2/8] dmaengine: sh: rz-dmac: Move CHCTRL updates under spinlock
Date: Fri,  6 Mar 2026 14:41:27 +0200
Message-ID: <20260306124133.2304687-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306124133.2304687-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260306124133.2304687-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 72BE1220E9A
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-9298-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tuxon.dev:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nxp.com:email,bp.renesas.com:mid,renesas.com:email]
X-Rspamd-Action: no action

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Both rz_dmac_disable_hw() and rz_dmac_irq_handle_channel() update the
CHCTRL register. To avoid concurrency issues when configuring
functionalities exposed by this registers, take the virtual channel lock.
All other CHCTRL updates were already protected by the same lock.

Previously, rz_dmac_disable_hw() disabled and re-enabled local IRQs, before
accessing CHCTRL registers but this does not ensure race-free access.
Remove the local IRQ disable/enable code as well.

Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
Cc: stable@vger.kernel.org
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v9:
- collected tags

Changes in v8:
- none

Changes in v7:
- collected tags

Changes in v6:
- update patch title and description
- in rz_dmac_irq_handle_channel() lock only around the
  updates for the error path and continued using the vc lock
  as this is the error path and the channel will anyway be
  stopped; this avoids updating the code with another lock
  as it was suggested in the review process of v5 and the code
  remain simpler for a fix, w/o any impact on performance

Changes in v5:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 089e1ab29159..f30bdf69c740 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -297,13 +297,10 @@ static void rz_dmac_disable_hw(struct rz_dmac_chan *channel)
 {
 	struct dma_chan *chan = &channel->vc.chan;
 	struct rz_dmac *dmac = to_rz_dmac(chan->device);
-	unsigned long flags;
 
 	dev_dbg(dmac->dev, "%s channel %d\n", __func__, channel->index);
 
-	local_irq_save(flags);
 	rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
-	local_irq_restore(flags);
 }
 
 static void rz_dmac_set_dmars_register(struct rz_dmac *dmac, int nr, u32 dmars)
@@ -568,8 +565,8 @@ static int rz_dmac_terminate_all(struct dma_chan *chan)
 	unsigned int i;
 	LIST_HEAD(head);
 
-	rz_dmac_disable_hw(channel);
 	spin_lock_irqsave(&channel->vc.lock, flags);
+	rz_dmac_disable_hw(channel);
 	for (i = 0; i < DMAC_NR_LMDESC; i++)
 		lmdesc[i].header = 0;
 
@@ -706,7 +703,9 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
 	if (chstat & CHSTAT_ER) {
 		dev_err(dmac->dev, "DMAC err CHSTAT_%d = %08X\n",
 			channel->index, chstat);
-		rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
+
+		scoped_guard(spinlock_irqsave, &channel->vc.lock)
+			rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
 		goto done;
 	}
 
-- 
2.43.0


