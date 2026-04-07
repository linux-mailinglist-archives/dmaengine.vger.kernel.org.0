Return-Path: <dmaengine+bounces-9907-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OvQIe4J1WnMzgcAu9opvQ
	(envelope-from <dmaengine+bounces-9907-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 15:43:10 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B453AF5E8
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 15:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3430E309D2A2
	for <lists+dmaengine@lfdr.de>; Tue,  7 Apr 2026 13:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D673B8928;
	Tue,  7 Apr 2026 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="fdJxSFr5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5591D175A9F
	for <dmaengine@vger.kernel.org>; Tue,  7 Apr 2026 13:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568932; cv=none; b=cJ2MUZse5ar9QDGJCSRLr94vbmpz4+ry6h6eTi2+3u5IbNlxEiXshcZmh2ruQu2mtwkdVl/9yGPk3DFudFiRIPLYvu0cGUJaj3N58y8A1UnME6SuCiDLm/7eR0GF5Etyg2WDF3b9I05ejPd5LjFiQs1cHL884i9xE8a7nI+J0/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568932; c=relaxed/simple;
	bh=NqIhL7Kx94ecGHipdoYoYxEN9JWnQ7jKvcbzALuBTk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtmjjV6ITM+Ny2Z8G3nfQtpfuaR5ImCZP/q87EWA/yd3eBS6y3YXTSzMGnezZn/sKSTQXSg1sEDiTxr9xxF+AhcitFNxu1RjHYAx5qbHgHqARgHg5Q1m0j2LA8kGZ5qKR2hpw93ND1/0UZKMPWIXjuaVRmpw+fM/Kza0ygm0vqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=fdJxSFr5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4887ca8e529so37240905e9.0
        for <dmaengine@vger.kernel.org>; Tue, 07 Apr 2026 06:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775568930; x=1776173730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgdgMNUKOKJYt+Gxqf2ssPII5esh2nyuFo140mcmnaw=;
        b=fdJxSFr5H7ExMS7lgqwv7EoHIf/Pj00zEgfWLWbHMNC8tQAkDRhQVDV79L0x4GZWUa
         FZrM8/Te4Lp3lTy4y7mhrvDSoCepv7x/nxI0E/h4iIJUbpJ8V3OiN8pLdgrIFVLd6Dqe
         MsdXVXqmzmGvBVf3LXv1RD93Y3mpzLbHCqv78R0kxtVs/FuN/RC9Np1XhsP1KBxa4Hmi
         o3CWRSZ67rPeabluA9A/Z8Sjm4dBwO+vVXCHs0vicoyWoADFgh8A0HoM2920103k59EC
         NTx9VYy6m2tuWSBOrUx7ryQUJpSZJDZwXel5Hfa//IWzh89bbZvvXIwIJJ1zASHBHjfz
         HU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775568930; x=1776173730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rgdgMNUKOKJYt+Gxqf2ssPII5esh2nyuFo140mcmnaw=;
        b=BDGYxrfwtpCIdHZPg7CMogMVPqR/mYAifLojNGCX6YJbtMsiTz7aK+1CTJXh77jHAh
         9xkS6SHZYzKjT1QXtVQFSgXpHpB7xlKkhjqloaLyUSqkE4XzFDnSALf1QLq2sdIjHmuW
         WiGtRGjgSToDLB4CLF8WZr5ulxnDItuXY54Qps7ss8AHYDo9xyWTv5xkKCDVgMR5KyLs
         CoY2qLTceRn73cuBnLAfEAX4V5U+0L1yvDX90td70Kji1gicWqJ4Us5Prf+eBLlSVj4l
         arVfSbxwQeLTFQn1wO0T8cQeS89JgvZkaGPtyUlF7k4W7yGegfvHNwDeN/jDMZZ0Z4Do
         fkxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYWcXTrMpxHcRTpqSnhhA48XEr1xfZsFKDCYWaKYvkKavIvbXrYtaCt4aXp25Z571tzOztBV/UinQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIDAuTP41zSCm/B5FTFeqdDVxlvFNwtIluJVyOw+sUUcdoXBWy
	82txBcrT65yY5rpmHDvkj3Agq67HYwuY+7RxOS8alRv8efqvyCzsxGwoKmly77p9xJE=
X-Gm-Gg: AeBDievH6v0MXxUtFhKE5gzGh/xD9BUjBugK9I9NFS+jPGUeBSLF0+PtCu5zh7W08Yq
	26QxTEUOYyAI8F5qNDiVxSCX4UHs8F5mS3NCHAHhnT85yUCOlR29wV2ZoY18QyhU1M6/9z6/muc
	+HvuyJPjS3v70EJdjcmWgUgsDEdlsWhSoNbgBebBhtdT01vCoPxebU0wE16fzu6wdrKKX5BeaxZ
	yAaa1FH9zvoLy4q2dD3lOF/jf283v8wFzIK/xm8+ddpL8aQ+soFGcNtNJAQ72AF3TDI9AgvJT8j
	+Kjuy0AvWopX9fNhtJZa8+6gLJkJjU3TMh61PISlo5m4BrucH8JkTwfTvOXIV964ePuHCqYDVGs
	o0oZeYcZbQjXCBqCdlu9+K/wDTDmlkotzqie8qNWaHckVnlHMXIJe3MsU+pU8eMhG6AZCWMDn1V
	RJpOlfD6jSlG8UP1qV76p8IEOaBJddlHHVgjCydx0VyLwIjp9R18bQ
X-Received: by 2002:a05:600c:45cf:b0:477:9890:9ab8 with SMTP id 5b1f17b1804b1-4889945f8c3mr200858445e9.3.1775568929708;
        Tue, 07 Apr 2026 06:35:29 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a91686f9sm285777675e9.10.2026.04.07.06.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 06:35:29 -0700 (PDT)
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
	fabrizio.castro.jz@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 02/15] dmaengine: sh: rz-dmac: Use rz_dmac_disable_hw()
Date: Tue,  7 Apr 2026 16:34:54 +0300
Message-ID: <20260407133507.887404-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407133507.887404-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260407133507.887404-1-claudiu.beznea.uj@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9907-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bp.renesas.com:mid,tuxon.dev:dkim,renesas.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 22B453AF5E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Use rz_dmac_disable_hw() instead of open codding it. This unifies the
code and prepares it for the addition of suspend to RAM and cyclic DMA.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 3d383afebecd..12c1163cb6ef 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -873,7 +873,7 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
 			channel->index, chstat);
 
 		scoped_guard(spinlock_irqsave, &channel->vc.lock)
-			rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
+			rz_dmac_disable_hw(channel);
 		return;
 	}
 
@@ -1020,7 +1020,7 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 	rz_lmdesc_setup(channel, lmdesc);
 
 	/* Initialize register for each channel */
-	rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
+	rz_dmac_disable_hw(channel);
 
 	channel->vc.desc_free = rz_dmac_virt_desc_free;
 	vchan_init(&channel->vc, &dmac->engine);
-- 
2.43.0


