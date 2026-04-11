Return-Path: <dmaengine+bounces-9986-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOLwNaE02mlezAgAu9opvQ
	(envelope-from <dmaengine+bounces-9986-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 13:46:41 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AEA3DF977
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 13:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C314C308711F
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 11:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A673451D9;
	Sat, 11 Apr 2026 11:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="lheJ0/6G"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BE234AB00
	for <dmaengine@vger.kernel.org>; Sat, 11 Apr 2026 11:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775907802; cv=none; b=LlTOc4MTiRGI1pPByA30aUNsRGm9Q4AFptXpe2nN6/CCpMkJ0hQUSxfjbMCqvKC8YkVvOjso4Pb8GQOlQZ0BcyQOFcKdTYlQz/xP+UPGyy5Z+D/uvrXWxksTB7vgIPejuwAWkEF1sv9YF65ZlSHhG69pt5cfUuQySd9I9mYlB2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775907802; c=relaxed/simple;
	bh=HYbQIS34NFlLeT+Ow3XXD+QsBaX+UteI12v9t0ej3d8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJjLnHoPFVty8b4gUEbXoYJW3P49cqUCtmQJ5S8nhDbfIbDBMFdP6iiSYcfl2yhW8dwoTOM2mF2oEfLcDsUTjUWUnfVPyf/9tkmaKoNzVDS6Y85jWiYI9DIjfuY0CmwxiH1jwoI+PTSqAewpszN1QwvNl2lrMWzyLr5OuC/sras=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=lheJ0/6G; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43cfd1f9fd1so1848496f8f.3
        for <dmaengine@vger.kernel.org>; Sat, 11 Apr 2026 04:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775907800; x=1776512600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpIDGi3F2+bKdB1eNAASENpLimdw7rfW2AbsZjsrSxU=;
        b=lheJ0/6GzGGNT5oXXikI2VArSjVzV7mPgXvXzlHPilsIP8a7v/hbJMtevxVDccN0Oc
         cj2txzl2z2slrH268e+9HxxlHQLcWr5TngTeVHbaeqZZpirdaWu5+sE3hB9mUDAFG/xu
         1CoT8kAss3lFPexXlMM6Q4q7TkIpBGmhBAasDs+teldxd31geUSFxiMp5F+iSv3xaP8E
         Tt1YGE7oZE0B8B4tGMwkPqHtOUS9vzTx2dzHgtq8JCKG9AknYx0RsvOvA2bmvh0dW+Z3
         cEuk7LOaIN1KywxMR6ZOehq6Szf4/4tMVsw0waFDJtB/CjRqa9M2YT632AfS0OVheUEC
         ydmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775907800; x=1776512600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BpIDGi3F2+bKdB1eNAASENpLimdw7rfW2AbsZjsrSxU=;
        b=VCscEj5AqT1sQuiBGMZDAGv1cU0nGUWbLXiVjz0w96ff/4VscRf40d/R4ShXbI4yas
         3WDrHbsHJSTUP/HOr7qvL5Sm08GBmdpscnl1M8sRZBtJuqU/4W/45xZGWdokyNeykfx0
         v92dXtt7tbh5AVLEzRFJi/7A9pxa0Ay98qJHvak4DvIHyYPdg4PCXRVuJAwtNZdTBTQ1
         FFJGsruz/i3ef01Qr5kpTsJsiJUKnw/pm6PllxG7Fwz0f1Xki7gtTjJNYXrUyUUcXamu
         2JKt2tce8lKYx05RCxI4RQlwiQpXHnzbEF36FUbvfGAbvbrVJQsRDajWEf45lbnectLE
         5v7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnccaQnIzyZAgBSN5zGeTqfFoP917+V+j8AHv7cY5ymFHDFSkV1LCWRDZCErmtdEUyeGa5nhCM8go=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBzVnVXUoRMeEqcCL74HvQdo95TtNYNWUiszD9vq3RixKvsxEO
	2L2+RcsLFlVE78Qjgpv7AjAzs9Boc609fIPHMMfFHnwHaG9XsnM8c82RUemsQYqNKoM=
X-Gm-Gg: AeBDiesBeKw2ZOBmEnEUUogQGIRtjgdd16BbjkH2fiDKgT6mu2VQAD7AWlUJNN/HA2H
	eJyhA8Cexb6uFJJ67IOMzy1pHH0/5CZQ/MaZQm0mBINKHtzmiFF4WtpJ5wMPMUtEUIDlGGgfpGS
	zdbjXKClFl2x3Y901CIb2uaVVCb/lhEa+cU851CiUKU5XPQ9SklghIVj7uTyUfwaHgvaNrJdYEL
	yIBVg2Sn3rZ/oRdIbnp3aH311JrVuUrANOwITr/cZ/XVLrNIh16Z3YalWm3UcK/rQMZUhfBF/wt
	0RrskHdxIliPV8rwuEoh8cYL8SlwpVqbhIOC8lXyZ/Oteb2t7XxTUW34Rb3lxpnOvEXrpSJePPm
	AQWvihk4qwpR3kh6hIUobsSO3rvSSHLNUI/F4SOTaHSHZGAXpjaZAHIVnwxjlxawTTe1jBUl44o
	DvxMSftdbiiiVMw+WMYVyAgko5qeKJ3q369wt1TkG7rgjDillXc2yI
X-Received: by 2002:a05:6000:2885:b0:439:c661:3245 with SMTP id ffacd0b85a97d-43d642d1968mr9382553f8f.34.1775907799752;
        Sat, 11 Apr 2026 04:43:19 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c981sm15776447f8f.33.2026.04.11.04.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 04:43:19 -0700 (PDT)
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
Subject: [PATCH v4 07/17] dmaengine: sh: rz-dmac: Save the start LM descriptor
Date: Sat, 11 Apr 2026 14:42:53 +0300
Message-ID: <20260411114303.2814115-8-claudiu.beznea.uj@bp.renesas.com>
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
	TAGGED_FROM(0.00)[bounces-9986-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: 56AEA3DF977
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Save the start LM descriptor to avoid looping through the entire
channel's LM descriptor list when computing the residue. This avoids
unnecessary iterations.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- none

Changes in v3:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 6bea7c8c7053..0f871c0a28bd 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -58,6 +58,7 @@ struct rz_dmac_desc {
 	/* For slave sg */
 	struct scatterlist *sg;
 	unsigned int sgcount;
+	struct rz_lmdesc *start_lmdesc;
 };
 
 #define to_rz_dmac_desc(d)	container_of(d, struct rz_dmac_desc, vd)
@@ -343,6 +344,8 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan *channel)
 	struct rz_dmac_desc *d = channel->desc;
 	u32 chcfg = CHCFG_MEM_COPY;
 
+	d->start_lmdesc = lmdesc;
+
 	/* prepare descriptor */
 	lmdesc->sa = d->src;
 	lmdesc->da = d->dest;
@@ -377,6 +380,7 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
 	}
 
 	lmdesc = channel->lmdesc.tail;
+	d->start_lmdesc = lmdesc;
 
 	for (i = 0, sg = sgl; i < sg_len; i++, sg = sg_next(sg)) {
 		if (d->direction == DMA_DEV_TO_MEM) {
@@ -693,9 +697,10 @@ rz_dmac_get_next_lmdesc(struct rz_lmdesc *base, struct rz_lmdesc *lmdesc)
 	return next;
 }
 
-static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *channel, u32 crla)
+static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *channel,
+						 struct rz_dmac_desc *desc, u32 crla)
 {
-	struct rz_lmdesc *lmdesc = channel->lmdesc.head;
+	struct rz_lmdesc *lmdesc = desc->start_lmdesc;
 	struct dma_chan *chan = &channel->vc.chan;
 	struct rz_dmac *dmac = to_rz_dmac(chan->device);
 	u32 residue = 0, i = 0;
@@ -794,7 +799,7 @@ static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan *channel,
 	 * Calculate number of bytes transferred in processing virtual descriptor.
 	 * One virtual descriptor can have many lmdesc.
 	 */
-	return crtb + rz_dmac_calculate_residue_bytes_in_vd(channel, crla);
+	return crtb + rz_dmac_calculate_residue_bytes_in_vd(channel, current_desc, crla);
 }
 
 static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
-- 
2.43.0


