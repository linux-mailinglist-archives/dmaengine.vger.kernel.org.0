Return-Path: <dmaengine+bounces-9906-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OADUOS4I1WnMzgcAu9opvQ
	(envelope-from <dmaengine+bounces-9906-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 15:35:42 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F3C3AF3C2
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 15:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C1B66300F2AA
	for <lists+dmaengine@lfdr.de>; Tue,  7 Apr 2026 13:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4186D3B6352;
	Tue,  7 Apr 2026 13:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="WQviGMsc"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBEF3ACA7E
	for <dmaengine@vger.kernel.org>; Tue,  7 Apr 2026 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568931; cv=none; b=XGYRiHVZyfe025FB+UyV28Q0HLTwbJaJ27Du4G25lq0gucXfg8s7MryjmiPktrnnW3roBeKt5TfZip1oYAEKZqwwo5//ERjCfye2c6U0N1WykdlTAn4UMftdAA2u6tqVxnxsekJgQUKOOdJV2+X9Ipz7rja4ybr8KNN7lpHyHKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568931; c=relaxed/simple;
	bh=LcM1SQxlU2zEePNOi96MarO1mcGQ7md8H0StgtARPbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cAEpW044Flw4tVQH04iNPwmtFlmg1gE8oa1wfTGFP4/hz8iDVSgcCCzYpGI0rZGLyR7hp1egsVvIhtWAN7lTPdjZgTU5zaU7o0y/4F7swJRXlVS54olDKqcLTSS/Uk7nd57Q8P72GoW6P76PXAbuAl2Q30kNhReYEmkNrzcIZR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=WQviGMsc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48896199cbaso44999075e9.1
        for <dmaengine@vger.kernel.org>; Tue, 07 Apr 2026 06:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775568928; x=1776173728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCNFfp+Y9opqUXxX/kFeUJeNq0Sa3NxuCau415grZd0=;
        b=WQviGMsc+PBHWW6R4QWTxwm67V2khKr+ngGMwqh1WOalxQ1dhASp08TdsHXSl4zQm2
         tRn6A/WsnuiRzPAWktaDBfmiqccyd0PBJJbKvaIJMxGTThBMxwrmmBu7vqxvNg5Zo0Q2
         7Ys21l40Gv+fSmVHC1g0Tp2TVa2+NQxj7zN/4qJqtzDkeRds20XQRJMy7oUBh73s6BI2
         +iEeX/TsjaNvFnF9aNNlHULzvyYGfmUb1GdIAeXHzN9V9C4WyqLmorM+ajeUM7DR+iIg
         zr3NGWmqjXMoqMzNEyGRa8hq5Ax312SIv4on2s7DPza4MG7S1/x6tj4OrEvq5nYfRMrt
         +YAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775568928; x=1776173728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zCNFfp+Y9opqUXxX/kFeUJeNq0Sa3NxuCau415grZd0=;
        b=PMeQA+FDZMKOMKuaUbx51xKl9r+9qQxown6jOXWG+KwQz1aRghCneFLR6mgPlry9Ow
         6nl2fi5Mq2A7T6NjdDDoo68XBTXMh0KOW+4vE9yyl7ZYPRl+Ojn8BREuep+2p9QslaTv
         NPRHLhh0vHF4Cy1TOMWelBKwn6k+WxqbzhYQRR5lKmRa9eWt+44aCb2Xco5O4GnmDF/T
         fQam8lmIhuOEflLogu6UbjRAYonlDLy8Olj+sxkInPDTIDxmSaBVWoGTYxPUnVb6tjs0
         kxxIx1lHVq7snOdqAxO08DNIHCrDaBaWzQa6ywkH7nu5FpXCgjDblbOLUbv0VqkAeTMN
         Hajw==
X-Forwarded-Encrypted: i=1; AJvYcCXELDTIiKWG20Obg4ys0GdIaGRc62cRHJD6V/oOR7qif3x3NuFWIxwq6jqgB9YQR4MEMgCWOj4ucRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YybzwyQMNPxj2hFBouHwCElsaRAgUXrGcEQg8AsMPr4krm+PxOF
	urCVJTcITYp3KC+ZJ+C+vfbTmfYgNc0FKczoV78q1lbl7TmYzNuVoLUYs6lVqpfWdWuc+PUx/yb
	1284X
X-Gm-Gg: AeBDietp+VYpIeh0WvIUC1s+omH3ERLy5v5TJ40pWk5NdYQn/LsEAK1s30oG/ngMVhn
	IG/vtPH8QItzVsh5y2h1wou/k/w/ijPqooV5OoxzhgP9qeZ2EOSUBBOpT1WQVHMlwnXInP3nxAG
	D9rk32Uo0fhGTB1KvwtkOU6XXRMglseUkYrlLTadZURJYF4ywTW1JPLrd8rGEbeXxQqIiFtNokF
	IWoXukrW/EFFJGLHYMmQRglfIdqRqxQqN1p1BHo9d/HvqBDHEeGwj/Glzwat5AcScq4zIXak7nI
	7uo1725ieGcuuMQUeqlGH/qnPVC7AU3X2DM8sxAVjTwIn+49V/0L1HZFKv6EztrqxAdpiG2xdUH
	Ck+T/sG4FRQqiwbS9PzOf5yT3B+uGlWlhz1WyH2sWJTp6ZLRt45J6SAhcuX9jgAEYNFhhORDwZX
	6EMCUExVYMaR+g6JhxBFMucqRm8liLe8h8K54l5g6x7Q0u2+l2WNH7
X-Received: by 2002:a05:600c:8b34:b0:487:1fb4:7e1 with SMTP id 5b1f17b1804b1-488997d530fmr246087405e9.22.1775568928120;
        Tue, 07 Apr 2026 06:35:28 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a91686f9sm285777675e9.10.2026.04.07.06.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 06:35:27 -0700 (PDT)
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
Subject: [PATCH v3 01/15] dmaengine: sh: rz-dmac: Use list_first_entry_or_null()
Date: Tue,  7 Apr 2026 16:34:53 +0300
Message-ID: <20260407133507.887404-2-claudiu.beznea.uj@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9906-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bp.renesas.com:mid]
X-Rspamd-Queue-Id: 93F3C3AF3C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Use list_first_entry_or_null() instead of open-coding it with a
list_empty() check and list_first_entry(). This simplifies the code.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 625ff29024de..3d383afebecd 100644
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


