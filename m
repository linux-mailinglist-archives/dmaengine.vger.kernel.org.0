Return-Path: <dmaengine+bounces-9984-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDgWEXM02mlezAgAu9opvQ
	(envelope-from <dmaengine+bounces-9984-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 13:45:55 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B359F3DF924
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 13:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB584307D94D
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 11:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E4634B661;
	Sat, 11 Apr 2026 11:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ld2ZFpE4"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1171348866
	for <dmaengine@vger.kernel.org>; Sat, 11 Apr 2026 11:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775907800; cv=none; b=nt3cYmFXJtWxNeBppq+6krAB4cdxoAlbbVCqDhqpqOm+WGbQqZA6pzTzV1GGdEbPsZl+sxSJ6H7YUI3wotmOyCg9Mec0F/qAV5JpPi4obhS+UPXumvcKzWnHJB28lu0DzkQjfpLpSL8MnJg2OSfUXxMaACe6ZUm2bF/rRearJEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775907800; c=relaxed/simple;
	bh=FswV1zMeTY8mzOC5mjgtkEA10SnivHgCzyn5u3OdJMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1Uo3Fcqqf4Z5ekxV2RTCI2gegzE1emt4v1Jt829/2V5CPKv6N4ppFmQxy9tvyehmZkAktI0HjC54d2yz70DaISHctIHfD38ie+4sYWr+zCEsA72pysDlnHrIet3VPa7owaKntskUmEwAVf4VZiMqHomFCsdfn1anP1ctFd2844=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ld2ZFpE4; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43cfbd17589so1916475f8f.0
        for <dmaengine@vger.kernel.org>; Sat, 11 Apr 2026 04:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775907796; x=1776512596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCFzuE61zyUmhYiJf5OgZu1cO7csJ6djKP2u11HWSmA=;
        b=ld2ZFpE4uncheIVERSHKOhXIRdBq4yjwrpLJj2XQt8Ji5hZDw0Zr83nHwaGArpiIfy
         jFy4kRt+36wjatPI4mYL6u0NBWa9vCCw64BI7T3cpZxQp5mWbsB8U4wmdHT1PRgNCEfd
         b3Gg5Wgm0QzBRnoygAQeNJanEuByJO1EyywBC/o0vAuE0MDhGLxYL3KJUp+9TIKCNwcY
         mU0ycjpu9fwBgW2PCV/OhM5bU31usxQ3a1qYiYbnc//wEf3rl1Iz/vMiCqSow/8/D/8E
         9xQ2fWACX4lH59mSB/SjljTOs2/Aw5olXhbAkr7sz0U9kFF8kgtTwaqA9F4ippFfukcW
         cJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775907796; x=1776512596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LCFzuE61zyUmhYiJf5OgZu1cO7csJ6djKP2u11HWSmA=;
        b=JJPct+lV/X1VaB2R1Dygjyl5TbO0Ub5MZ67go4j3DPouF3ve9VmOj9VYLF1HoC/CH1
         iC+vo/2o+5nAQ9H+XKLnU402EuC41pDRDCL52b/DheiwH/Rb2todLDO/pSEhZCQD6zig
         ZFWCJR+PE9JCXS5T80Y+oxpTbUeN90rBShBV4JnMoKBwz2qXvyneUTsmgre1OsyURZgc
         CcxaHMIIgQVTlQ1yiax4kZuCGm2hugXMz19EfwiVaBlMY2ucUeAsxgZmVvbOIYsP79AT
         kSAsIYOLr4nKmNcqzuwjU4wPisGNUVtCDL+wJ4opDMM83YJ8gkukS7o3FQUVDdB0kt+7
         JdvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxO6lPWOEx6nXNQMD9lIi/JleXTF2tBe81UmlAsNX+GMdGFZnnKeLk9aB5i0yfZ26ydZ1+9+6UMKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXnMxYS+1hKmHEXI+44wl7h5+lAlfIf4gOuDaaUBx4Idhsv9Mw
	DgE8XfsaCbq0/Bl2mLok+gS4VPRhXrYxyWYB/IXViL0RiKSf/ZUZB4YUQFXO55waOuA=
X-Gm-Gg: AeBDieuVh5EsbGwsWWBRZSWNy0roWqlsEotlgDDvOohvlq2PHqT84E92TMnjdSp1HsZ
	UdKThcUWCGjuaKdXKPedHpbNtYKO8N1LXQHOYuWEgVmNkvcxa6N39yNbHoX7y03Neju3PzFnVV7
	+vKfCyyoKw3kjBsjo/WTEmNWSRgxvpLg+GTj15PVpQSLVYX9GO41Uti/VCD539k8+Vqly4owKNz
	47MBpJwTrhSsohw8Ex9eBKa36uOZ6BNQhW7FreFXeOK3RVjGnhQA5aXthpgHzYDuPZ+dQ+easjR
	dVFlpFbJcHac8ObUp4gzKxebEtu01EACAtAw9XsLagkzpcpLF5jpkgQjvSzTkCQfsvOUss2UXlH
	1Wd5CqqEZF378jx4vNP/z+070iEqkuEu4rHB1SizGmzs8YW3/jrktcn5TtSzUa8126oHSQ9JzZ2
	7GElvPUa9FCildvii1vD6Q2P2t28RsSYUHBygaGD40R4XjAsgg40UQ
X-Received: by 2002:a05:6000:26c4:b0:439:ac6b:dd38 with SMTP id ffacd0b85a97d-43d642ab99bmr9178051f8f.31.1775907796358;
        Sat, 11 Apr 2026 04:43:16 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c981sm15776447f8f.33.2026.04.11.04.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 04:43:15 -0700 (PDT)
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
Subject: [PATCH v4 05/17] dmaengine: sh: rz-dmac: Do not disable the channel on error
Date: Sat, 11 Apr 2026 14:42:51 +0300
Message-ID: <20260411114303.2814115-6-claudiu.beznea.uj@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9984-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: B359F3DF924
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Disabling the channel on error is pointless, as if other transfers are
queued, the IRQ thread will be woken up and will execute them anyway by
calling rz_dmac_xfer_desc().

rz_dmac_xfer_desc() re-enables the transfer. Before doing so, it sets
CHCTRL.SWRST, which clears CHSTAT.DER and CHSTAT.END anyway.

Skip disabling the DMA channel and just log the error instead.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- none

Changes in v3:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 40ddf534c094..943c005f52bd 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -871,10 +871,6 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
 	if (chstat & CHSTAT_ER) {
 		dev_err(dmac->dev, "DMAC err CHSTAT_%d = %08X\n",
 			channel->index, chstat);
-
-		scoped_guard(spinlock_irqsave, &channel->vc.lock)
-			rz_dmac_disable_hw(channel);
-		return;
 	}
 
 	/*
-- 
2.43.0


