Return-Path: <dmaengine+bounces-9988-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGCpLd002ml9zAgAu9opvQ
	(envelope-from <dmaengine+bounces-9988-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 13:47:41 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 338203DF996
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 13:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 866D130918F7
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 11:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B042352921;
	Sat, 11 Apr 2026 11:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="d3kytsCz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA92634F241
	for <dmaengine@vger.kernel.org>; Sat, 11 Apr 2026 11:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775907806; cv=none; b=tTWbBJ7VXJ94MTS9tSVi2cU4erZ7HTs4FsC/Zkc8rvqgkp/Xi4ppZ2gIL/qkVcAcC3KnYQlIi50yImG3YzMcqvofnH/4YlNPw3lvBVAXchhtX5DhSccJvxvsnvzcCNigufO9jwvMDCGVolWMOQdRHhIRw+BP1UMwKN70sA5CfrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775907806; c=relaxed/simple;
	bh=kYxxf7UrOo/ylG412SxsscyOsq5s+9b6o32cDo3KE50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5Pghitvkd//anKeV/SwnhRmt9ErslLa8Vd/QEfYm/NAC/V/J4r8eFEJ7OPGH4b5RdauP7hQOavvI2+TO2tbFBfFA5aECLAFtUFbiZZUo2l+Sp1qGlg/uWDuUV0UOc4i9OfLJ094ppQfI1zzWXwm0KrPsNyxf+d/blzq/3TK0y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=d3kytsCz; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43d43e09de5so1587485f8f.1
        for <dmaengine@vger.kernel.org>; Sat, 11 Apr 2026 04:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775907803; x=1776512603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6HUr1gtJuXFA7idjOAe9L67Llkodm8s1OURzQhPdNQ=;
        b=d3kytsCzByQoV1C+S3h7V6B7XxGwePoepa3dKpEVrSoRCA3vWhJ1IcCcWaVBOP1gcL
         jlD0Oe9LoaCBkBx+HOuFGmRNq1aRs7hJSE3cfYH5do0R7xXpqpbf2zzquHkT3ruFJFMn
         onxfw0WXIMrmyXgVTK93gmKAUlUC+JUzjNIEa3Mkfkt+I1brd+adcSD1UHaBaH7rCChi
         toseYi5Vvex7AcqtXCGXEr/a/UbFf1gTytobSXHOFkb1GDs9jRI/UsfnPB1YSt5zE7Eq
         92sdt9OCcgmqovZXfFTFZ7+heN6CbS7HAS59vKtnHeCgQfwoqCY7JrudVUSyH8tDQuLx
         Q/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775907803; x=1776512603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y6HUr1gtJuXFA7idjOAe9L67Llkodm8s1OURzQhPdNQ=;
        b=Gskgv+hg+/frlSMkOcvus5wwS4scd9cJPUE4TZIuAnPgtsXmVVvj+gr1+Ro2+m9wKD
         btbIiYR7MiqX9IVPSHIBZn9bBE/0pjGzN9Eq5GXj2FOobHeNubb6SRJe3zjZfWICjWxe
         CiJeE1IP1TBt0G1Dx6bw27xMkaJURJT8ySJoKjrUfdnhwWTbO9O/2fL+W46BWD5V8KKx
         tdd19Vf3sEKWL36PlfzjFfnjp3sRf0y6i1hiA0Iz4rtO9J7DMT/VgnRXADAeBtn3bcO1
         3Y4LRYq3gbEbXC9SJ9w0DEI8Evkurf0+FLLFsaPJkmDrcL1U6h/VD00ihre5Z7HIGlGd
         EwwA==
X-Forwarded-Encrypted: i=1; AJvYcCU9dk1/uaRqVp5DtOWaDycqM2nu4KxT/uGtnRi8nrFrAYVKiw3MudGpbL9BqR/tVtY5+ppXd4EYT+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHE+Z7yjDCxVbLmJxlbUAoa+IdAG0NY3zSuq+3GkrwkDIAMhyy
	jpcNsZ+bjVNZwzXPOLR77EJPsFhuRS+njNL6+REoiBEIiiYQpX52SDGl4LOvyqUReg8=
X-Gm-Gg: AeBDieucFG7d/3Vh3LO4PqwjDj2CpQuQ92+oi4GTJFlZE7lPHyczYK51bE/7JDpz0g1
	45XPL3m7qJ34DtsYWFCeeb0jJ/sExYbg+WIVSA+Dwwo85kmXbXJBjo0hl7T26Nh1atqEHuJcx/s
	T3TuzuOk2FKdxrG1yMNSDmDztMvgb0nwcEnG+8w6yz1jzYgVU3Hfv8NadJnMXrFwIxI8E3LKSsv
	EV7DhLwWxwVlHL7UyBKHDTDdnVHeg3tFAiIZqPjrOOul0bDjnRHcjPa4pVF9Yf8Pnc2akmxHbVS
	TE9Rq/ldt9e/5bwtM+HJk5FQOka5IStRlmqgQ+KRNUaYn4ii6lTBXK/gVmqBUFW0LKRYjm3Pf8G
	AnGvWxz/8ABZM/K/jnBdBB8IMqDQGMq7gR9MCHjSACStpWljkkrwhCAVS8DL72mQDfzfI/Yp7XC
	Ofaw2RQ8D75VkRVQ/E1xr2Ri5uPdJbL68XhWVikcHZj4wJhLPQvaLW
X-Received: by 2002:a05:6000:3108:b0:43d:1c7a:8b5e with SMTP id ffacd0b85a97d-43d642c13e0mr9680005f8f.35.1775907803295;
        Sat, 11 Apr 2026 04:43:23 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c981sm15776447f8f.33.2026.04.11.04.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 04:43:22 -0700 (PDT)
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
Subject: [PATCH v4 09/17] dmaengine: sh: rz-dmac: Add helper to check if the channel is paused
Date: Sat, 11 Apr 2026 14:42:55 +0300
Message-ID: <20260411114303.2814115-10-claudiu.beznea.uj@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9988-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 338203DF996
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add a helper to check if the channel is paused. This will be reused in
subsequent patches.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- none

Changes in v3:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 1a3c33d28c6c..f35ff5739718 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -286,6 +286,13 @@ static bool rz_dmac_chan_is_enabled(struct rz_dmac_chan *chan)
 	return !!(val & CHSTAT_EN);
 }
 
+static bool rz_dmac_chan_is_paused(struct rz_dmac_chan *chan)
+{
+	u32 val = rz_dmac_ch_readl(chan, CHSTAT, 1);
+
+	return !!(val & CHSTAT_SUS);
+}
+
 static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
 {
 	struct dma_chan *chan = &channel->vc.chan;
@@ -822,12 +829,9 @@ static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
 		return status;
 
 	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
-		u32 val;
-
 		residue = rz_dmac_chan_get_residue(channel, cookie);
 
-		val = rz_dmac_ch_readl(channel, CHSTAT, 1);
-		if (val & CHSTAT_SUS)
+		if (rz_dmac_chan_is_paused(channel))
 			status = DMA_PAUSED;
 	}
 
-- 
2.43.0


