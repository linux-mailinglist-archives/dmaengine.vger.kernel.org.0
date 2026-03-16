Return-Path: <dmaengine+bounces-9433-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMHUBNYGuGkWYQEAu9opvQ
	(envelope-from <dmaengine+bounces-9433-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 14:34:14 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE9529A7DB
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 14:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 88ED2301C56E
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 13:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4151139A053;
	Mon, 16 Mar 2026 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="LCkImlyg"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E592E39B496
	for <dmaengine@vger.kernel.org>; Mon, 16 Mar 2026 13:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773667992; cv=none; b=I96oY+p/s9CudLLUJiEFSP97cmtizfyhrLVH/+EBe9YZrRst0BjsyTTSO9VrFpETwRvDndt8h8asaYzCHYHaTEoyvxyi9P2Ia7MyiUgZkws9oxTWjLO+NoUB9zyV6czSfIg6wGMdnH8XJjHVcs20AMpmav8bdI1PARh/lapZeJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773667992; c=relaxed/simple;
	bh=w56/D1XvAYs7LvPLRCM6cbsHJXo372cim496trKciKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1KZDLNV7Z5JJPBsS9GCkqL9wymTQocFXGN94xU7Ls6myNXdSVfkLES3lo+iP4cvMT1jrv9pOwascyiikK02JlaVGFPhGO6phF5Jixw5tKePHtyfF1XolnfGHs8JAuQF9A4KV7WiFRaHT5nEE2CKXxHe+hqa3M4VUblo5zduUI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=LCkImlyg; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43b44c0bcdbso876234f8f.1
        for <dmaengine@vger.kernel.org>; Mon, 16 Mar 2026 06:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773667989; x=1774272789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxqVhCvVzdGYo5p7MNaQSoRb8B7LFi+tQsLB+AJbD7g=;
        b=LCkImlygTuDD10WX33nHkCFhypglyMqWAnwW5tI7xIGcCo4j1FrQSWZAAbuzdu/Jeb
         GtNlYXZ7m9j2o+Pmae75KaKBXkIyio7BhtgBuagnvWlt8OY94CDIiihX55kR6crdzOP+
         AT0Icj+39ohL5s4b+ETKpuAwAocPNK+Agug3wbPwDj5WMqgEvUZXIijvdl8FR3060Tam
         14mdITEp/35bOlqI1BYc2CXWDdb5iWMitsEstCG22vfU9uHzBFrOXXSEbqcRY+/wQywB
         6fb1O4yre2pUl/f8VgYF0608ZYjkI5PgpBIbXLTWP3j5Imh1S42B75VXQ6IsFrnld19G
         lo/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773667989; x=1774272789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hxqVhCvVzdGYo5p7MNaQSoRb8B7LFi+tQsLB+AJbD7g=;
        b=kklBS3NIhpFn2Qdy+S5T0daQfsv5JNMf52+nzRyg9t5nCLOWjvmGESDoInJu3QzxmG
         JUOIlxLx6ArVhWfg4EQeeLj1+2vuEVKXf76BC5X+5KQLMduVsKqwSETcNjH7jtOzaUFL
         iltpaXoFU+Jlq8aDs+t4yxx7rhyWDetnJh8gcQR/qZcHbUc7EHPlU+AaI8b/O0MfBgrZ
         gMznnC2lyEMUsr+DQCofbSOICYSt1FtX/pPQc6C6JheDZyLgvO8+EZB9WNOt3Pt849ra
         5Kg5lUAFJ+XYsjxJ0fEJljlU+XCTQAG5GfuNq/OBKbLMaLOk291srzvM38kzQQ616U7v
         xYig==
X-Forwarded-Encrypted: i=1; AJvYcCWIQMDzX/3xsKLBMxJ2kO+R6/7ZRyMx9k0E80hhGFoToa/9Zx2MzN7xqjIp876XEF8wXTQkyps/65c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuJ/kpczuhRE/qF0yBsvHwFuBiEKzjtJYCO9mDtXyzF3izc/6A
	Bm+xgG2hf+mUYvw92mqPdB6nMqvn8hIRH5S1yEkGspL7wWN6xXgFa8wOexc6VAHrEAk=
X-Gm-Gg: ATEYQzx6Qme5hTRDESv0E4rcHX64UfEF2wBpp5w4DaIzWr3+d2sFWcZMaHy+XpG/f0B
	Dkevy9PNvmDq5NczoY0Y+kvXbpCirVGLSkQi06gSiZkKUsfMqrxnDkvP/87U94s/a/eCW0uQlRd
	QnM8/fH/rYDeF2b2Ct2NMz7xaC2kpWOZ59pW/9DvyVPJ8zzcWfbuA9oxn7KKealGByN9W7puwLA
	LLGTla1H2H4Z3tZYN/iBscy+TTXj8a+/kmBR+vGnI4/97aR06aQElO+8+sL6YaPjOWjrT4TE3T4
	1IJjvk/tdYd0xzy17DmyXKQO3DDSxeN3FTMm/IMMtq1hVAR+8kAkkiLmeYl0MS0CVBUCJ50YQuz
	kR6EkhpLiU5Y30zo7QfGEFMH7l6Dg5SjJv6pMVQm2HV4xYUvpKQgyq0+esmSZ7kpB1l4wX8JhEJ
	0fmUwRjV4L37VfWS5WKsMbAkvWrg37QBXq9lKoxWIOGTZZac5BrjwE0jGayFfVS/5ey/gKFXceZ
	vEos3g=
X-Received: by 2002:a05:6000:1845:b0:439:b5f9:eeba with SMTP id ffacd0b85a97d-43a04d78e7bmr22448970f8f.3.1773667989095;
        Mon, 16 Mar 2026 06:33:09 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6208:0:c5e3:3624:ad1c:6b4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b419270efsm11629888f8f.16.2026.03.16.06.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 06:33:08 -0700 (PDT)
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
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v10 4/8] dmaengine: sh: rz-dmac: Drop goto instruction and label
Date: Mon, 16 Mar 2026 15:32:48 +0200
Message-ID: <20260316133252.240348-5-claudiu.beznea.uj@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9433-lists,dmaengine=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: AEE9529A7DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There is no need to jump to the done label, so return immediately.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v10:
- none

Changes in v9:
- collected tags
- updated patch description

Changes in v8:
- none

Changes in v7:
- none

Changes in v6:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 29fa2ad07e30..6c9bfe39a11e 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -705,7 +705,7 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
 
 		scoped_guard(spinlock_irqsave, &channel->vc.lock)
 			rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
-		goto done;
+		return;
 	}
 
 	/*
@@ -713,8 +713,6 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
 	 * zeros to CHCTRL is just ignored by HW.
 	 */
 	rz_dmac_ch_writel(channel, CHCTRL_CLREND, CHCTRL, 1);
-done:
-	return;
 }
 
 static irqreturn_t rz_dmac_irq_handler(int irq, void *dev_id)
-- 
2.43.0


