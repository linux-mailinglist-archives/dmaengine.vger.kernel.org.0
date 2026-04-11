Return-Path: <dmaengine+bounces-9996-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OU1Owk22ml9zAgAu9opvQ
	(envelope-from <dmaengine+bounces-9996-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 13:52:41 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 750C83DFA18
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 13:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B9C9306F94E
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 11:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944DC35C19B;
	Sat, 11 Apr 2026 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="aR2uSJiy"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA1A34A795
	for <dmaengine@vger.kernel.org>; Sat, 11 Apr 2026 11:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775907823; cv=none; b=mzOoZN+YRCZEK4dZnx0OdcLacDZ0g69GXBBYRBCEwpVHfGgGKNTn2TDOsJ9nN6J0Tzi2ipHNNkxNLc+V9r1AorAoPtm0MKqkFstus/qe3k/Q1j230Bz6Q7G+GTn+YgdGK9fxFHPpfzJBgdTnZzfNEWFzeTQD10riYxBr82UAJzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775907823; c=relaxed/simple;
	bh=00agU9G8WCwFdL8wNmeE5/RI+LQevLHKH0zoSbPnvhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrZ3zxYWkZQgoUNQERgs2A4RZ5J2AR5j+VaqOiscjizMjHHpY0g/nLXpVbPASAaeFx3MXpO4IkZTGADrqCMoOH4Krid+KE01a49pLuUyjdWgiyfXE5dALkL6kMCzrSFbU9aNRNKvf9mRl01eJxr9oTZof8z3W8ICEWv+k02VPog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=aR2uSJiy; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43cfe71e5d3so1965308f8f.0
        for <dmaengine@vger.kernel.org>; Sat, 11 Apr 2026 04:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775907820; x=1776512620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woi0lrK3i2kpcKywf5o3X0tfp9llXfvPOtNyhrNBRjY=;
        b=aR2uSJiyLT6jmwBC3UH6WcfEo4IK6ecwdENClhaWAE8OcMX2Qiug9EqrsvgpYVJGVc
         zjdpK19ssdSr/KKwrSrTYiHPIBJzL59S1aNHGw5vS1XlY1y0PD2c0BdBkXpS/gC/8PLM
         XfRB6JC6lK3hlu5S+72CT6foKn880JNNQXQ6lqjIhzMvpnavRgiyqup/ZZURyM8P5xOz
         DuWEU0irOKUhCuNd+lneHGGGICr8iqau0A73S9s2/bKwTJvTMbjKMk7U9UK9gXxFGoPK
         g6fDAvDW7Zz3gCCY9JWgKD7YVr+ADGCwDXFTP4AM2hSR/I9vCv78xsFCZaqbw/Y7csqE
         3C+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775907820; x=1776512620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=woi0lrK3i2kpcKywf5o3X0tfp9llXfvPOtNyhrNBRjY=;
        b=ju0nF4fKgKxuL5frl+X8qGGt+FCD6VqKSKks4PHm1lB3bqU574Y+53QDcCAUSwa70S
         A7rQlEF4NHhhaT88xrdyF8NXpgAJLc0HB6ywK6MLcgUfa7S58O/2cUr4MEqmS5enSOvJ
         bMoGCa2cfXKcLLgTIeYIm6M47WbWhtZ+zouEAsnxidqdmgGXy3QWn22LPERaHgwf8jkM
         Fj2mC7KAf3netAXUZlRnEcYlfh0x6giO1aVZBEaZfnCvxRJj9HlrvIAXgECUtGbQZM/j
         org4Qk5h98Z0HqvHYCuNUaKxYQWfgUl2kcu+VCBon2CWqZLt9fdYUq7vm9dCvHVgqkva
         OlbA==
X-Forwarded-Encrypted: i=1; AJvYcCUBtkv3ae+sxU0n0kzK7eJT34utr7EN5iYgzkqnFjjWDqycjkf/d5dk07DqMTR5BhVJGfRFOiJ2JjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvw74xknXT0+RmiC5sLPB7Tb0dQvlqH18tDpWueLpsjkVssGyb
	oJ0FNatyUJfsJjATkXMUNEOUzeAKD/Zs2aaf51pL8n74hAapEbLKsOa3k4zfYrFqZ8s=
X-Gm-Gg: AeBDiesxM6IVcm8zaNoDdJOu+CBj94tjeOPAuiEG7RWrdGLnY61KovHoM2kqiopbPp/
	gknruHgIBZs97NapUl0MGGtdurJWeHjvMbn6U4ohsnwgLmboUoqpXTJ1ERreNu8J7EVp/cIjFDH
	M44Z5S0UZ+E7nhfTJA75mhUX8wTNJAJNubgYFY0oIU4npDV08WkUX8UMvMItv8HDpz/ww6k0Woc
	5SJVsBlJQb/aSoTaOKlwWVc0d9afWpvslRXn67b5ymTCID4cGDW1/3kbe8lqVFrfYKi/c7WDgbu
	71jYzwNPHfvMuwxwD0hswjTdsJ5jNKmfvfIDREQFUJ97LgVZRAKzbk8hicH1AK9+v/pIOqJ3odd
	p7YeSJa5B54Y4+NsdYl4Fs5srI923AllbZdzCQYFSKdJyTdyRPHU0BTGtNPcfbVX6McKXOAkivz
	M7RNsf3Zz3OFY6PIktimKwme+J4NuTIOIZgu6RsLmt6ZIM1DqiMGRbsmhH+JjR6Nk=
X-Received: by 2002:a05:6000:420b:b0:43c:ff3f:c635 with SMTP id ffacd0b85a97d-43d642b188amr9465975f8f.34.1775907819734;
        Sat, 11 Apr 2026 04:43:39 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c981sm15776447f8f.33.2026.04.11.04.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 04:43:38 -0700 (PDT)
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
Subject: [PATCH v4 17/17] dmaengine: sh: rz-dmac: Set the Link End (LE) bit on the last descriptor
Date: Sat, 11 Apr 2026 14:43:03 +0300
Message-ID: <20260411114303.2814115-18-claudiu.beznea.uj@bp.renesas.com>
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
	TAGGED_FROM(0.00)[bounces-9996-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: 750C83DFA18
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

Changes in v4:
- none

Changes in v3:
- none

Changes in v2:
- none

 drivers/dma/sh/rz-dmac.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 00e18d8213ca..f5d2e206f4bb 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -200,6 +200,7 @@ struct rz_dmac {
 
 /* LINK MODE DESCRIPTOR */
 #define HEADER_LV			BIT(0)
+#define HEADER_LE			BIT(1)
 #define HEADER_WBD			BIT(2)
 
 #define RZ_DMAC_MAX_CHAN_DESCRIPTORS	16
@@ -382,7 +383,7 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan *channel)
 	lmdesc->chcfg = chcfg;
 	lmdesc->chitvl = 0;
 	lmdesc->chext = 0;
-	lmdesc->header = HEADER_LV;
+	lmdesc->header = HEADER_LV | HEADER_LE;
 
 	rz_dmac_set_dma_req_no(dmac, channel->index, dmac->info->default_dma_req_no);
 
@@ -425,7 +426,7 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
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


