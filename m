Return-Path: <dmaengine+bounces-9982-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOg0I/gz2mlezAgAu9opvQ
	(envelope-from <dmaengine+bounces-9982-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 13:43:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 949593DF8A7
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 13:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E128F301B855
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 11:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029C7346E66;
	Sat, 11 Apr 2026 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="UaQ8JVKm"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88496345724
	for <dmaengine@vger.kernel.org>; Sat, 11 Apr 2026 11:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775907795; cv=none; b=UdsT++A8h/jAyoMNSTSqVmjLZ3Xpfw3ZjoL3jP4aJfy1G4xDOubG5qVIisBrDR72/hHiA2GFjgd+fyErXSCdVF4Nh8gOD+p96kGM/SuspOxeJJ4ts9bHxujN3aaswAZrchiz7JHRRUP+wVqMV0xE/MijdVNH0rtY5peOKAAjRHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775907795; c=relaxed/simple;
	bh=ZB6OzeV1iuOY4cphwcy1NTv7nOJuOcS76pQLBa2mvQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMVX2DMwafepHAJq5YVnuP16ioa8HLng1czIrPykDPNfLv8+rwGEM3qjAQRep96bvRcPyWvfmtpfn8FopAXxI5Wk95ulHI92l5SLSv0uk+83ZYOmV2qiKPMqvw0f1GQ9OQlnw6NwsDs7rr7qq7EVD4AhNebscXJhoqSFiTxr1hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=UaQ8JVKm; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d01d6b50cso2887374f8f.1
        for <dmaengine@vger.kernel.org>; Sat, 11 Apr 2026 04:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775907793; x=1776512593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7j+XdlT3aD7tJGwl9xLTbJEKXv1OztcK3gKQoyq2CgQ=;
        b=UaQ8JVKmly6Bd6KpAeT0HIxw89p8cBqDvUR3YQYkHE/dboPgPUIt5zz/3sQ9WRaykp
         WjWbWfeL4ZrflH41LxHJTDeWLNW9qevlHTs32AF5taRIYUe6gRsBhKuhWvFEL6mm29Zd
         IgkuzXYeNtW6KE8Zcfsh44WGDVqoTaudNdQGB5CxAXlOuj2Au7k918yjvU2FivDomPS+
         IXP5rcA6ADrXnJrGE9C5324eOo+B1XnRaUiiwU2n3ZgNSfdN0f9wEmA7ObbC+UelynZF
         BbOmyfEcjSgMWf3WfAs6+T53SvB2A/TmPFdILdbUwdNoIrnifDlezgzkVBUk1TZDbycQ
         fa8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775907793; x=1776512593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7j+XdlT3aD7tJGwl9xLTbJEKXv1OztcK3gKQoyq2CgQ=;
        b=rDPYZl+Zg7mgnHWh+nsJRm8mvl8UVd9UxtFVB2coPvcyAE0tNvuzRz8o1ch3n0ftda
         MjaG9qb4RoOhI9QYrkyJ2BoFsMVdPz4tqeMrxgcIhyIDibNXq+R4EBuKNqUoorAkaGXk
         QfOjp4zp798DYSxuF54N5AF8zGdUHRwwGC0GupLo3iBH7FdxIwncjSSQUVIatUnXLB4M
         33wS0mPBnjaCnfuMuNus21m1V3wcuU3elsMAJ0YQRcR9+eJXu1xBhezUWgy3trB9yft0
         NVWmhO6E6ToHP//frnqGqzarHAp9U70Ei9ZrSDMLSXxFuyP3v0QxEuoFr4zoDST5KXLz
         EBiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoVAsc2GInAnx8EZK1179ViwRdomRdnA4z4w0Tu+R3zOH3NhZd1blnIV07FzzdwVrLbDNY9XH0loM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUKrRoZXOTlxjwNeMrtu4kXt5O3dU3xe6uTVj+XoFVuQKb883p
	7N7ORpTCtb5jWApVIaU7elX89Q1PGPt+j/Ok3QJ15yf/gMN7uyu0mOeKeBPa01tqNcM=
X-Gm-Gg: AeBDietqAZfiO/VjDZvJhHCJV0EETN/pdMDQxaMTSA7uNClz+4GJIy5KGTMfnZREqax
	zI1Ylr4XdIxmIHugD5Xnuy3buEzfVjwx7/4+7h7gAOjOnITgSN2dK/XrLgJQDNXrBQvPjWCUMh3
	OQ48AVIPAzLv+wjpK1jsCFmShO/jSXS8jQwE1A3XYGeWKaEMUDrPAQnN3jyesQwyHmb+MUeIv5m
	X7Fb2ZBzkcRY2TlxcEdYlVFgIP+jqb5yLZHqqpu4Hyqm//gbo5tsXURUw30lB3MvZyrtkhw8inn
	OLbDBloRmYA++PwMGQe/MuglEb4GQpUdpyXnE2hF6HgJ5cwJwKz2xj8BCNFWwmC0shVQ6awxNa7
	BTPDQ5EdBTVrOshp/PkpyZpytwZOP6GSXVsXBKgrUsVv0GSKuC7tg5JBNaW279bl8ojOy7uE6Al
	YkbvxvrCNpNhQ1SWfYpwfNqAmes5FGwsf1QCzG8JD9HbaDcr6AlEsl
X-Received: by 2002:adf:e80d:0:b0:43d:69ff:6898 with SMTP id ffacd0b85a97d-43d69ff69c4mr3162191f8f.9.1775907792998;
        Sat, 11 Apr 2026 04:43:12 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c981sm15776447f8f.33.2026.04.11.04.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 04:43:12 -0700 (PDT)
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
Subject: [PATCH v4 03/17] dmaengine: sh: rz-dmac: Use list_first_entry_or_null()
Date: Sat, 11 Apr 2026 14:42:49 +0300
Message-ID: <20260411114303.2814115-4-claudiu.beznea.uj@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9982-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bp.renesas.com:mid]
X-Rspamd-Queue-Id: 949593DF8A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Use list_first_entry_or_null() instead of open-coding it with a
list_empty() check and list_first_entry(). This simplifies the code.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- none

Changes in v3:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 6d80cb668957..1717b407ab9e 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -503,11 +503,10 @@ rz_dmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 		__func__, channel->index, &src, &dest, len);
 
 	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
-		if (list_empty(&channel->ld_free))
+		desc = list_first_entry_or_null(&channel->ld_free, struct rz_dmac_desc, node);
+		if (!desc)
 			return NULL;
 
-		desc = list_first_entry(&channel->ld_free, struct rz_dmac_desc, node);
-
 		desc->type = RZ_DMAC_DESC_MEMCPY;
 		desc->src = src;
 		desc->dest = dest;
@@ -533,11 +532,10 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	int i = 0;
 
 	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
-		if (list_empty(&channel->ld_free))
+		desc = list_first_entry_or_null(&channel->ld_free, struct rz_dmac_desc, node);
+		if (!desc)
 			return NULL;
 
-		desc = list_first_entry(&channel->ld_free, struct rz_dmac_desc, node);
-
 		for_each_sg(sgl, sg, sg_len, i)
 			dma_length += sg_dma_len(sg);
 
-- 
2.43.0


