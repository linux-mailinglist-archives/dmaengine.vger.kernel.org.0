Return-Path: <dmaengine+bounces-9302-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMabNPLMqmnwXAEAu9opvQ
	(envelope-from <dmaengine+bounces-9302-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 13:47:46 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E94B0220EF9
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 13:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E1043049C94
	for <lists+dmaengine@lfdr.de>; Fri,  6 Mar 2026 12:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1747D38E10F;
	Fri,  6 Mar 2026 12:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ntIAK4q7"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE3229ACC0
	for <dmaengine@vger.kernel.org>; Fri,  6 Mar 2026 12:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772800908; cv=none; b=nnm3SWh2doAk6f2481nZisHWdYh32FwNlhe4hNFjaNCnxgbBF/J87xbBWEr2exkvdEk/KPxShDHlckTf+olTE7Ph5n1vAVevJGPO7kWoJqtSC5wKW12c+aWbB4ILyNG/nNux4zbZvgydEIuKCr/9f7/NWyZw/I3UhkGx/2rj2tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772800908; c=relaxed/simple;
	bh=1BaQ5eOGmq5cxUJDWe8gk0vsUkz4EwiNSGLh3VMzngE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DuxvGdwb9UgiCDafllS599HSwQnjl3DwBmypbl2O3mY3XQw5aUjc/4lvBOkyqHbb9MjEf03O3Vk2iPonNe8Zo9w2SbRbZ31IbNrnxXuTGbU+n88780Ajeg9f+VgTpADKuKFlOtZfDfXMH7riUeEUDwevdPOL5t1yJS/M+JcimD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ntIAK4q7; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439ac15f35fso5845507f8f.0
        for <dmaengine@vger.kernel.org>; Fri, 06 Mar 2026 04:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1772800904; x=1773405704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmNjUk7kVZWIP4LPt/EwE/P4I5p8ejRGJw2udSg4T6w=;
        b=ntIAK4q7nvcmULy9GXsHRaTDuW1bApJS7IvPGxskFo7Uv4lm7h8kHBrdYxwHSK1Yz6
         +j4om18I6EwulezJehAbPlWD0lBdfVVDfguUTTd1Q6tf6AFd+m2yVe5y14yONS0Y3EfO
         vXNbbb9ygguyHN/zWV7tV0ogJeKMPR+hpPKSWC/b9Yg0tQt2rD4TWfAgngj1Hq/qcAfl
         g1JT9ibQQ1WNdEoab9y9sPH0nrUcEDZYKL2IkBY+cqH+uyaOkl/mNDFHK+5L6N+wl+Ss
         CVJf+/KThSudQJCr7vy/qaqGofzNV7w9GQhr6O7eyk7Rxz7+O7XnsV4aI/5S6KaV6X2F
         GUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772800904; x=1773405704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GmNjUk7kVZWIP4LPt/EwE/P4I5p8ejRGJw2udSg4T6w=;
        b=JybrGe71IbSHkSWcCZpgfxamWb3jvhVUVhCsmjlSfEEtkc6FHBNAPoowEIJRvqZaSe
         XsjwfeCcNhirNaXgvTDGNzsUh7ajVZ4dAX/33avZAe2eO96R1vefGCKzATWSNTs+gNyf
         dC8+WqqD++oshFS9ITrz88qn+HKK8I53quRFoGjF57hibCiE4wBDaE0xssiBB0iz+TwF
         zgDcBAZzoeredLuWMpvZ6Voz68lqoLcZNpc94ng0rK7MlUXczOf68dQ8v7476Jrb2T17
         Q7qZj6arE46u+JTBg32V3HLbPJPZfuZ/5spYgkBkgE09ZXV2u3tJBPtX35fvTrMYL1HD
         17uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxyDVlaaaeBb+L1Wg1arbLsGUilmKr4AuvjyIfJ/RJOi9EdX+vhUo2U82aH3tnkK//lSBzsL++N28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3+Nf9t0VT/z534Xi5FnmwQ4YnhHA2sFzImjSI8Wjz2SCQxMX6
	ja9WUmEBRmdmSIHyrIN4XP5bNqtDcN0B+vzoFtC/P1HtP69FDG6ZzQ6/oFvBF37MeiY=
X-Gm-Gg: ATEYQzxrOXCroBQe6PemLg5SPnCp1VD3Naaqo9Wy/M4rwHj3621CqhSwq+9tb84e9TH
	/sRp541Qkxut74oAXEZawS1Kr4Bw+IxpLIba3NtP8tvEVhRNkYuT7OZ1pbfSmLv57G1jSGc3SV7
	ZuJyL7+RKEXbjD4ee1ZztEQKKgxTVzepkInb46pnSBAvVohizKMdRyPDjWdePY80pwAFwWMh3sf
	1Uo+LFvNKnLJlbLY6WiovETMHLoiDMNJgRjESPzcZVzh35A71/4OsCQ9V4hhpTOOgBfMO2Xoqi+
	9XAL2DgbsXuv9C5u2v8MDBfSh8d7zMPECxmeq+pJyPSbfJ9noHGlzlzX7JRNg5g9KkfjBCC+UIQ
	4pYloJDHNyXIrped8uNA44VHR1vcHB4fEwl0DWJXh+W0VD4llTj0vT9sMsR1Wy2GCuKBO8J1NmP
	jDh4x3X9bvEdGdyg+zL2oTtf3WfbFAOSZYVciOz1EqbDinFfzGOI7+
X-Received: by 2002:a05:600c:6085:b0:479:2f95:5179 with SMTP id 5b1f17b1804b1-4852692fec0mr32246445e9.15.1772800904402;
        Fri, 06 Mar 2026 04:41:44 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485276b0c38sm38150505e9.9.2026.03.06.04.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:41:43 -0800 (PST)
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
	Frank Li <Frank.Li@nxp.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v9 6/8] dmaengine: sh: rz-dmac: Add rz_dmac_invalidate_lmdesc()
Date: Fri,  6 Mar 2026 14:41:31 +0200
Message-ID: <20260306124133.2304687-7-claudiu.beznea.uj@bp.renesas.com>
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
X-Rspamd-Queue-Id: E94B0220EF9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9302-lists,dmaengine=lfdr.de];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,bp.renesas.com:mid,tuxon.dev:dkim,nxp.com:email]
X-Rspamd-Action: no action

From: Biju Das <biju.das.jz@bp.renesas.com>

Add rz_dmac_invalidate_lmdesc() so that the same code can be shared
between rz_dmac_terminate_all() and rz_dmac_free_chan_resources().

Based on a patch in the BSP by Long Luu <long.luu.ur@renesas.com>.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
[claudiu.beznea: adjusted the commit description; defined the lmdesc
 inside the for block to have more compact code]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v9:
- collected tags

Changes in v8:
- none

Changes in v7:
- none

Changes in v6:
- none

Changes in v5:
- adjusted the commit description
- defined the lmdesc inside the for block

 drivers/dma/sh/rz-dmac.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 9c159c53e3ee..274c9cd40713 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -249,6 +249,13 @@ static void rz_lmdesc_setup(struct rz_dmac_chan *channel,
  * Descriptors preparation
  */
 
+static void rz_dmac_invalidate_lmdesc(struct rz_dmac_chan *channel)
+{
+	for (struct rz_lmdesc *lmdesc = channel->lmdesc.base;
+	     lmdesc < channel->lmdesc.base + DMAC_NR_LMDESC; lmdesc++)
+		lmdesc->header = 0;
+}
+
 static void rz_dmac_lmdesc_recycle(struct rz_dmac_chan *channel)
 {
 	struct rz_lmdesc *lmdesc = channel->lmdesc.head;
@@ -455,15 +462,12 @@ static void rz_dmac_free_chan_resources(struct dma_chan *chan)
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
+	rz_dmac_invalidate_lmdesc(channel);
 
 	rz_dmac_disable_hw(channel);
 	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
@@ -555,15 +559,12 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
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
+	rz_dmac_invalidate_lmdesc(channel);
 
 	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
 	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
-- 
2.43.0


