Return-Path: <dmaengine+bounces-8494-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIFVFAtDd2mMdQEAu9opvQ
	(envelope-from <dmaengine+bounces-8494-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 11:33:47 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFADC87081
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 11:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41970302B50C
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 10:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11C93328FA;
	Mon, 26 Jan 2026 10:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="kPQjfLTV"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B072E331A7B
	for <dmaengine@vger.kernel.org>; Mon, 26 Jan 2026 10:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769423537; cv=none; b=cOxveQ7YpAfu1OGXHEPEd3vWVJOXOzcShXZk0UF0YL2o+SyeGJZaofeFRzGEBDkEQ0lQf3LPkSzUN0PZ2k34d0XXHIbrFRlDx7naW4CqnWPKbbexvfCxmlY5kX95wvpPCQvITNboQscyBAk83pA73W9/zC1RatqgFuIeVo1UYo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769423537; c=relaxed/simple;
	bh=rLi08UdXsCL3zvjViBaowms6zxtQNJXRNf02+HbElyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pePjL8eTqjoqPbUYZVdzcE+oGFyShasmATuyg+CeJkS8Ame8cLRr1l5etVje0JXnHN6NIZBZvAhUbMuFWxs6FNkSH5uPGTIn92xxf+J2MbjQ9GuFGA1MBeKd2mXMaPDv1pvFVYmQXYDiu7pBgkkGSX5OdsF1LJzCXisMQBNawDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=kPQjfLTV; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4358fb60802so2493178f8f.1
        for <dmaengine@vger.kernel.org>; Mon, 26 Jan 2026 02:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1769423534; x=1770028334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVTiMUECZKumoxUGmttzNBifGHS5PA4+h4GwvqluTUU=;
        b=kPQjfLTVMBWsaLlE8cWmxYXSBVeil1Z7g5Uco6hreXEpt8zOO1NH+trhVC2EPxwToT
         VxRjk+OymT9ZQ7Qg/JpxwGpTLoX8BO6fS3/JODGcmWD04ZZYS7E/jevsAQFVu0zo7s6Q
         cv9ylzUahw85/bLx/+6VuMjTqqUO0QROVkouPhRNBW9jlxiEeZQVPOYcaWIk17rY+ySP
         aX8lmdeUuwmq1/0ouwJ+42YacK0qLs+R3V4KP4IiOrIx2W7BzEMeJh5lrV5hIbYPcAgT
         bI3CNsGBkyn7NuA+kTkqOWRbUZ1CbHtrXQT1CuCYNmI+yUzPjpcUVevDpTEAH0Oa7c3l
         9UHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769423534; x=1770028334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mVTiMUECZKumoxUGmttzNBifGHS5PA4+h4GwvqluTUU=;
        b=Z/bWJcCg8B92JE1qz436Uk2xz8rcJV7D2DgqVo/2+txMDdNRh/OqwH2HKaQ4G/1nrF
         YWSXnQ/fXi+fJCiKRCmKqTKRaZ8tBq9IlJNuZTLpK8JU/yLkpcH6y7diK3h9difm2QPv
         CylZ5G50KdSYu05mK1rwa8qF1/fBc5rqviBe/NYrSeM60N3Ce+3H7Htfi1hbYEOImvdM
         gfVIFN2r9joVlFkKpiZUUGCHPBqsC8E5Cg8Hg9ZKCiMDQt28SnFMlPGyCGAgRz2wr1ID
         SHtMUkWaKVn0y0cxBkEQjvEqR5f/eKh+ceOJI7B0oLk9J1WpSJhw8IJUr38qvnweLmZM
         WNFg==
X-Forwarded-Encrypted: i=1; AJvYcCUGUIK5/QWL3aA8txM7cGXEDplUCMksgsCfpymwJer83a3/O/4BUgWmeZQT8IWU/A5achqjDrivS9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnhInFuDAiX3FNeCB9NM5fcPyFqOTCrOGqZ1EbZPAziS29Dmyl
	OXKcwqLUgfeb1F2D9uagT2yt/54FctJitk9Aguj+ac886sEqAf+SgJHpXwMUM9dOdQs=
X-Gm-Gg: AZuq6aJm357Rcj+4Wkw7HVJFb7eFvisCsf8SKJwQHrzYoK2syMr+akb6QCfDy3eUktz
	SyVKZKO/RlHb0BDH7s80xIPivIwwpl0zbrOO4/TC1CxW0p4G3ciI+mHvGqrbm9aW1ayir6NWrQC
	K4FFT/t+6Fqea7j/zDh9H6ija5ls+bZDToveAF3kX9wJhNE2sCWlCyp5DS7D0pK9e60+/RTOpND
	Sw1q9Bw0WHu0DglRAduB+8fh+20u4kfS4wEkn13G004moyDGSc57Yi+XF4gCkFCF6j9Bfahaf0X
	edAciVzgK6IHgpc4qdH0pfYZ9YaliEuJLXE/i19xxTadPn5WPeTU0FhZa4foi3Mfu7eDpCjdoTZ
	JLZb4qeJgI+pYlqLzVwg2d77ya1Bv7QswjKpK4uQWNOPKoNzb4fo+SW1sehEI6NgNRbGQg/+TGW
	Key03jWoWhSXv5B55yarxE0Ui0IOFAd71aPNk2LIQL111XkWv1mw==
X-Received: by 2002:a05:6000:2210:b0:435:bdc2:461 with SMTP id ffacd0b85a97d-435c9d18f01mr7343320f8f.21.1769423533834;
        Mon, 26 Jan 2026 02:32:13 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c246ecsm29715049f8f.10.2026.01.26.02.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 02:32:13 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	fabrizio.castro.jz@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 7/7] dmaengine: sh: rz-dmac: Set the Link End (LE) bit on the last descriptor
Date: Mon, 26 Jan 2026 12:31:55 +0200
Message-ID: <20260126103155.2644586-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126103155.2644586-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260126103155.2644586-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-8494-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,bp.renesas.com,gmail.com,perex.cz,suse.com,pengutronix.de,glider.be,renesas.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bp.renesas.com:mid,tuxon.dev:dkim]
X-Rspamd-Queue-Id: BFADC87081
X-Rspamd-Action: no action

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
 drivers/dma/sh/rz-dmac.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 8f3e2719e639..3a77a560fcd5 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -206,6 +206,7 @@ struct rz_dmac {
 
 /* LINK MODE DESCRIPTOR */
 #define HEADER_LV			BIT(0)
+#define HEADER_LE			BIT(1)
 #define HEADER_WBD			BIT(2)
 
 #define RZ_DMAC_MAX_CHAN_DESCRIPTORS	16
@@ -383,7 +384,7 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan *channel)
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


