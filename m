Return-Path: <dmaengine+bounces-9919-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNqvMKEK1WlQzwcAu9opvQ
	(envelope-from <dmaengine+bounces-9919-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 15:46:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECDF3AF6A9
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 15:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC7CB312536C
	for <lists+dmaengine@lfdr.de>; Tue,  7 Apr 2026 13:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854D23BED78;
	Tue,  7 Apr 2026 13:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Nai77aew"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925643B895F
	for <dmaengine@vger.kernel.org>; Tue,  7 Apr 2026 13:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568958; cv=none; b=uvdmtbmBZ9PvlUeN6vJz++OpgLztKFevotqLMmyhetQIUCwELlN6u6Ng1WSLcPK28l6gagO5w61DQuK4O8d2cSmIq4MlggQRdzc7mP7o/hCpSE1AsUbq48iZPQf1gBCBx6++YqqwaoBkjj06rCmEejinqlob1eEH8aN+F6XlWlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568958; c=relaxed/simple;
	bh=qj2erbi8E1PHLHMBePLWqnr6WpeMTkKkmKKSAlTnqiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+FDrpaxkJSJ2IOU2TVr+FwU060zzxBgNRpUzl2LbrTNSRomwRbUbCDl/dMnBeBPANuqq1HEbIDVeR791QwTjqGosJMngv4/LrdIYfCkQqvbD9BICZKaAdQw8vX1pPbDWFUj5S0m3p5znMJQTtE1DTLyy3KSvNQFQ3Kk24AagxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Nai77aew; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4889e045bc6so33196145e9.2
        for <dmaengine@vger.kernel.org>; Tue, 07 Apr 2026 06:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775568953; x=1776173753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQUgXvLWYybp144uyKlEx9/0iJj8Kfku3jsi1mOzCQA=;
        b=Nai77aew6DrKho186rrpgwSBX1nT6l5LAiqCPZLoJE/1j8eVlYfuPHS2BEF4EMxI02
         LlIFiNFCFOldNbFwuH+hJUhU9GtZNK6bsm5kXXNjTfylpqDnn2mTPtXUYA4Fegl9RzVE
         wGRp9a4UvLp1kfFvV3+zYztj6aI7bcXZGpKWibI5zISiHDnk53vl+8YOwEyEwyIrgOns
         JX+mt4T85OulqeptHdzq0mJJiKtF5LMSDrfcZ2Ak3yZgiWgEmM5CEWv/kqR1XEscyh/w
         +XmdyrkCyp62RjKMhDmLHGjhYq4fEjuiZAMPkRgJfBp8WlkfIlvyOZpdPfsfcxQEwHAH
         5DcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775568953; x=1776173753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rQUgXvLWYybp144uyKlEx9/0iJj8Kfku3jsi1mOzCQA=;
        b=NQfWwtTT9IUqvqsCaDLwV4XQHNSG7Iyj0APCVcRvfYTYm5pSZXFAJn8ZiCdPy6dj5h
         wYaQnLe/nxOJKY86MTfvFh3Om/d5Huazy4oGkeoUvT+olQkcj5Or2edKEAVkrKzoI5fi
         LbWBATjjeBHzS4NBHzxnNwn1meQsdK2iH9Vyqf9PP5tX3RLqpeqRiY9oLYoYEh6rhkYb
         8xVgrC+72B6icEy7YZuMQu91jkF3ihnWJD8Hj4/krUofxrdH3QGrDYIZKreMvU+iYBMW
         U4GbA+24InSSBxGETcyjG7Wp8wsuN77rC88H/feKJNO14TuYmr2ejeB3+P1jid/nP3E9
         XKDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhZrwqM/OhgiB/QDD01D3GQ46WNJUsEn9WmBM03gCJTIl+F+kJ3GMG3J5EkLazJ8E1VW2fep7ovhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUyU6E7VlwnZTbTSrtzQfseQdCk/zqbOk/1U0cGIlZBsnP15VE
	rHZp/blyaFB8FP74L+mH072nIHvsoduKC2sKf2AOAibTIfx+SOKdJD5fVADj3VwD0BQ=
X-Gm-Gg: AeBDieuQuHROj2aL+HitC9hZ4jiL2aGPgGGmjAMr2n0jMpskAvGifgc9Fvgq9Ckd5fi
	RloL0bR/jfEbTQNuoOpZIywPpNFzxle+EYavBjwCWTiKw1K3TjXnhCA4vBPm/8hQgVKPFa0My3m
	7js7xinYNrMrNPOLg344JgdPhXkYIx856OhKovQtzyBBAVrAT2vKb6pLtq+lltpqY3ONRbt2CoC
	UkBtmWivNx26BuolZFjPWXM4XYzwym7E9kBBEUdn/Z5ukUVHoa+yWT4DGl9jsvaAFnj8ofzf8Lk
	FANcPmLGlu+HnA5tKeATqqs3vPK63Kt0JdUB0V1v/FEURcgY7bQFDzZltDZEt35B2R/Urg5swqs
	a5trCcwNxTJOOQwrORP2Vqen1VSmNmrPhyW8u9WRubnBk2k51A7LWzsB9e9E2d7g50OJTHOkri5
	1UOTrGw6DkoXaY6m1PI+fkQrl7DZomVWtP+0LIX0ADe7LssG3fvUyF
X-Received: by 2002:a05:600c:638e:b0:485:1878:7b8c with SMTP id 5b1f17b1804b1-488997b21e9mr238787175e9.18.1775568953327;
        Tue, 07 Apr 2026 06:35:53 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a91686f9sm285777675e9.10.2026.04.07.06.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 06:35:52 -0700 (PDT)
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
Subject: [PATCH v3 15/15] dmaengine: sh: rz-dmac: Set the Link End (LE) bit on the last descriptor
Date: Tue,  7 Apr 2026 16:35:07 +0300
Message-ID: <20260407133507.887404-16-claudiu.beznea.uj@bp.renesas.com>
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
	TAGGED_FROM(0.00)[bounces-9919-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: 6ECDF3AF6A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

On an RZ/G2L-based system, it has been observed that when the DMA channels
for all enabled IPs are active (TX and RX for one serial IP, TX and RX for
one audio IP, and TX and RX for one SPI IP), shortly after all of them are
started, the system can become irrecoverably blocked. In one debug session
the system did not block, and the DMA HW registers were inspected. It was
found that the DER (Descriptor Error) bit in the CHSTAT register for one of
the SPI DMA channels was set.

According to the RZ/G2L HW Manual, Rev. 1.30, chapter 14.4.7 Channel
Status Register n/nS (CHSTAT_n/nS), description of the DER bit, the DER
bit is set when the LV (Link Valid) value loaded with a descriptor in link
mode is 0. This means that the DMA engine has loaded an invalid
descriptor (as defined in Table 14.14, Header Area, of the same manual).

The same chapter states that when a descriptor error occurs, the transfer
is stopped, but no DMA error interrupt is generated.

Set the LE bit on the last descriptor of a transfer. This informs the DMA
engine that this is the final descriptor for the transfer.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none

Changes in v2:
- none

 drivers/dma/sh/rz-dmac.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 3265c7b3ab83..ac388e7607df 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -200,6 +200,7 @@ struct rz_dmac {
 
 /* LINK MODE DESCRIPTOR */
 #define HEADER_LV			BIT(0)
+#define HEADER_LE			BIT(1)
 #define HEADER_WBD			BIT(2)
 
 #define RZ_DMAC_MAX_CHAN_DESCRIPTORS	16
@@ -385,7 +386,7 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan *channel)
 	lmdesc->chcfg = chcfg;
 	lmdesc->chitvl = 0;
 	lmdesc->chext = 0;
-	lmdesc->header = HEADER_LV;
+	lmdesc->header = HEADER_LV | HEADER_LE;
 
 	rz_dmac_set_dma_req_no(dmac, channel->index, dmac->info->default_dma_req_no);
 
@@ -428,7 +429,7 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
 		lmdesc->chext = 0;
 		if (i == (sg_len - 1)) {
 			lmdesc->chcfg = (channel->chcfg & ~CHCFG_DEM);
-			lmdesc->header = HEADER_LV;
+			lmdesc->header = HEADER_LV | HEADER_LE;
 		} else {
 			lmdesc->chcfg = channel->chcfg;
 			lmdesc->header = HEADER_LV;
-- 
2.43.0


