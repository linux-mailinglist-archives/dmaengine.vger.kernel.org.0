Return-Path: <dmaengine+bounces-9985-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDBiBYE02mlezAgAu9opvQ
	(envelope-from <dmaengine+bounces-9985-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 13:46:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 960633DF939
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 13:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B32C3307F570
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 11:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EA434C81E;
	Sat, 11 Apr 2026 11:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="a7wzxxxa"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C06034AB00
	for <dmaengine@vger.kernel.org>; Sat, 11 Apr 2026 11:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775907800; cv=none; b=REacUnMsdN7AaoRl0Uxt/ILHN8mGlyrl5Xg8Kx8Xt3gjXL31ETqS4VwsWJUSUlIGweZgPT2FOPjaooxbaXTXorTYQE1Vx3SoM+iYPhh6mh+4THfGc/t6TWEEvgLB3jibYQ/EscJhtHAVkOUxsWNrn28k9MPNLFubaAOUIkwpVzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775907800; c=relaxed/simple;
	bh=hCcTy5ooGYC8iDVpkjkx2X0iImn3Ks2K6Vfc4FCM9QE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lo5eVC6Mk/pjOK6bgud+XVMJfiu+QEzCl9sLAvMRqNb1ypfF+1wuLnv2OmTr5vEN3G+WxZpVKRXZWP5WNE4kgLGtIrZHepNv2xpIZXVUJrfqwHOt0Dvd81XvKMjs5WmUhZ4ijibjhlmvdouv3fihjDcFWpk0xUCZQLBktYIFDyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=a7wzxxxa; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43cf5fbacc9so1361830f8f.1
        for <dmaengine@vger.kernel.org>; Sat, 11 Apr 2026 04:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775907798; x=1776512598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBAh3mtPfHrVsqP6yv8NM6dVTsui6/Je8uMjHCO4v28=;
        b=a7wzxxxaxIsoxYcmbeQZSVnkQjA4ADezdYt53TXIP1lFzE/qzyes2Ta6gq/RoPuEy9
         zu0gJ9NpVekVwKfj5CB6fGCaGrtz+OPFXQ7f6mNqcbxsfZEWx1Z7LQBlfLCHfv77dKxu
         ZwAUhXNsbo70OfLuRbvObfUSyXrS1PqJP30iMDJbiIp8r8PAjmqL84jJSyhkC/8NNOE9
         Wc0s4nl4kjSNaiSwCksWnxa+8pIF0A/i/TUQ/vZEpT5woEL/yErfZryZrMgetW61BjY2
         HNwPtIPN8dgc+bpdXgrE3kMxoCT/roCA0TD8b4oQvED+ZzYUKoK6AdHADiK5Xn9c4nEF
         HP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775907798; x=1776512598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BBAh3mtPfHrVsqP6yv8NM6dVTsui6/Je8uMjHCO4v28=;
        b=SPOCAhFEu+v99KjKQUG+1mTHo0NwXElgidDnJJkHFMUb/59FWp2Upg2e5aESSU9+7P
         ljuuwLwf0CKeTz9/DriSPkPJEnHAZt8mJFQVuKrbPkvZ1GA8nyKuVW6UmAKiIIlRvNSY
         EYD/ytFcgrIU86jT8r+I2INmONGvinIA0ZcNJkhnwrzORI/MHWaavtpHvaA3XuW/FNbE
         MtMnpHvyZDh/bLw3C7SzY0qrhQ4HKe9alFaAjwqUdhLIXnfc9HOyNEe6SINE87Vw/6E3
         wMaQbcHj895liblyhEYhFQu3XUboiyIvxW/hVKOgb4+uy4ga9/aDHG9yAZVQvIw+iPUh
         tzwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0H4KL6u89nxOIGe+wsZRUyG63g/PZDzGs/lWgm4J2CCwJvqxJ0NUG5zOWhu7qrZ4G7EHfE5epn+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8H0QohxlWl9i1PWZGG006yby4HpBJGAi+M2tLhAiqjZL/Su5G
	XH8jRArwXWDACzbQiXSjntFBO0pp2BU0rctbRyDhypXkmpkKhDONz6qUBQ42Aq44ssM=
X-Gm-Gg: AeBDieuA63tN5SLIH03YIgDYw7vx7nV0g8QkRkseKDVniz69bWXKJOfj0Jjwb6WtXqp
	OWROknHp1vYxpuGITc/kJ4mCVZkCIzW8wq4wvc96WnHzBghslQq5IZtwx4FHqkYmYxMixsbmjYl
	lekmeRH8YpyDyiobNI8/O6SL4bPVFESwbPyb/qJiQLw3JGcUB7sPhElcN+xs0hWViauX3c6THzL
	zMAInrH4nitQv2wAl6Q74SCcojlbOU+I1Int0LUfcQ3wm9TZ9Fq+/PJ3INTuxPR3elB6ujhdeok
	lYlbagTS7jlS+F5q0UncA93FwMktes008pgSuSycSKp9/wY+vDLc3WU+1dVXuzOGMD4u35J5xBl
	RIHUcaKXDGOIUfBPCoAyraybeZDEnRUB1lK3R7oJS9mmO5KCdezyF+3tHLfDiJaW+lylRFF4hiC
	hQ1YmeQqbNlRTAdxAi4g5PxAbyCLMCyAd1/vUvzx/L7sZgxDG8fvNR
X-Received: by 2002:a05:6000:2804:b0:43b:9d69:43a with SMTP id ffacd0b85a97d-43d5957372dmr10511283f8f.8.1775907797979;
        Sat, 11 Apr 2026 04:43:17 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c981sm15776447f8f.33.2026.04.11.04.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 04:43:17 -0700 (PDT)
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
Subject: [PATCH v4 06/17] dmaengine: sh: rz-dmac: Add helper to compute the lmdesc address
Date: Sat, 11 Apr 2026 14:42:52 +0300
Message-ID: <20260411114303.2814115-7-claudiu.beznea.uj@bp.renesas.com>
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
	TAGGED_FROM(0.00)[bounces-9985-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: 960633DF939
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add a helper function to compute the lmdesc address. This makes the
code easier to understand, and the helper will be used in subsequent
patches.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- none

Changes in v3:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 943c005f52bd..6bea7c8c7053 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -259,6 +259,12 @@ static void rz_lmdesc_setup(struct rz_dmac_chan *channel,
  * Descriptors preparation
  */
 
+static u32 rz_dmac_lmdesc_addr(struct rz_dmac_chan *channel, struct rz_lmdesc *lmdesc)
+{
+	return channel->lmdesc.base_dma +
+	       (sizeof(struct rz_lmdesc) * (lmdesc - channel->lmdesc.base));
+}
+
 static void rz_dmac_lmdesc_recycle(struct rz_dmac_chan *channel)
 {
 	struct rz_lmdesc *lmdesc = channel->lmdesc.head;
@@ -284,9 +290,7 @@ static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
 
 	rz_dmac_lmdesc_recycle(channel);
 
-	nxla = channel->lmdesc.base_dma +
-		(sizeof(struct rz_lmdesc) * (channel->lmdesc.head -
-					     channel->lmdesc.base));
+	nxla = rz_dmac_lmdesc_addr(channel, channel->lmdesc.head);
 
 	chstat = rz_dmac_ch_readl(channel, CHSTAT, 1);
 	if (!(chstat & CHSTAT_EN)) {
-- 
2.43.0


