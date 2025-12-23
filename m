Return-Path: <dmaengine+bounces-7894-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 649CBCD97F6
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 14:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6924A30424AA
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 13:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDCF2BE65B;
	Tue, 23 Dec 2025 13:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="JZCbpAFb"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50CD283FD9
	for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766497847; cv=none; b=O0UZYErJZVdrE/z3RLrdD0f0DHM593C0dsOC5bWlY76F+7FS+lA50jhDv+CD1HZaGfH808cxUJqezelKIgrss0hE7fZb49GBCK7QMWM1lM6SiBjypKKSq1d0DfPEg9NSRX1XfcdaFMk2Q1Rvwf97LKCS4Slo3GUbAmoHKBwQ9Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766497847; c=relaxed/simple;
	bh=LiPltN3HUsoWZgG0b3XladhmIyhEPP3aMOM9Buc1+pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHlY5VdthNkCIIEJisM5D42lyzM3qbEUgRAxyw8fimP019nsgzIqzsk2w5zkPu6LYKF1AiBurbmoxwJbcTAgOtH0ozY3vaC3m/jztI1BvGWh4UqvO3MxMxrNfheYNu8U1T+eVmha2ITIgUgwD6F6e7ULlwezKIcHW+Pqg8sOESU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=JZCbpAFb; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4779a4fc95aso29204545e9.1
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 05:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1766497844; x=1767102644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FH6nXiaIYwI1+2t9P55h/qNKuU+/btAtGFOCQCzQEyM=;
        b=JZCbpAFb69Xg08KBXPX0lkodb50kdhkMiNNbq5RU3CMap5ogZ/96QN5PRkhImEL0Dh
         nkcEtGCKb7jDodp7Fn/fATa1i3PohorHUfouQLlLDn8n7vZCt2d9ynQNIvNNP5zYF9aY
         n86wwvK1xXbCK7JZpaRSOyXomZn47TSsyNmpah+gwXC0otbBdWBn0/vlJfGb2E4IMkyz
         fLkXv18H+qWDUBPaAv0ooWkMh5m/mr9RZHl5U3O4ES5TQGsdLmbUSgIakrnIRc4V2GRG
         XlQf7ZGlZLN+IZN9dufZr6KF4N9TpegKufPwNunk4Z9gqeTSGJgqDxCSzHX4tgbyna17
         X+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766497844; x=1767102644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FH6nXiaIYwI1+2t9P55h/qNKuU+/btAtGFOCQCzQEyM=;
        b=PZT/fPKMWaA5/wpjohpbQ9Sutg4042kWu6d6bumf5epXNEhXoqVw10SfThS51nZ0wg
         ACyt+JyMxRQV3mtIT8I1QHkY7KCHc0efQ81S7lfmw+J7hVF+GunJDAnSNdT+B9ixzZ7o
         0+Eei1BvSiC0/uvs4svjKJOJqcBi+1x5LMHZso/wBPDmYc5+9RXBdMpGuLEkdQ2hk2xz
         MyZ3I52xdh6Tl508scYddUBgCZcNPUmjdvLVO7lga+ZEWgZKjCUJlgzV+AF9gquQ/XXK
         /ioycGZvRxZn+PoeMWfr0i4E5onURZ/EMvDAxM1Pe+VZO++hxQlr4cMS8OPl+dhywwQr
         QmjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaEgL+TSuJxMPm13XZNRBBLGEvdWW8fq3/bev30dClPhIbqsNTWVa9GNCxv5fVLYhPjFo63mq6uWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAjWjT/walVozUvUw3IWM914xREH7Y6vLHsJ46QjIBEYAsEVJJ
	Do+1dcjxgHofyfMNE4GvkT02usPonHvP81MI83WQpA69Ff7QZHOfWZFZzlF3hr3CWYU=
X-Gm-Gg: AY/fxX4T1IPhJFOK6Bf4z4K9fftOF8eHOpkiPUDgVcRhrGHMDzSlH1Oqn5lLA+bU9k1
	V27XZltw2pPMq+MyeBb9rv6BpHpsW4U63Dl1QH8/3nwTWP/BQNRkKinbVZ11iAZaZnz45MiMJjw
	hK0vz5kvv6lZVIqKRV7Sv7DXaB1kaEJ69TzjNv47uljvX4HO/BGPhNI6EuFYq9wltfxdI90ksdn
	DqyQ9SaRY/Hf6GmENNou8jChcWCIaPepLZBOYdSp+UOub1Rr7VIRYROWhcgAbhbatw7nv9KTgcS
	Pa7djFx3x7rNwlG1gOVemAfgXnCBOi34dRdFh1UCIOHXDZsZpU2EWEd5mFX1Rh63zFQ/rSmPiCd
	D0rmmOlN1ledIRbA6YRx+tnQIgM8cRD4vtZxhxQkK2VHhvMot1OhSdvVw3qhOKxjJaGH4Wcf6xX
	3yiP/YTkvDDWsUxYOobAQCoT4WSuAqrPY8v4SZ/bchNZgLDdFS6YJodHs8GnsUoBPHjHBIJUA6X
	y23oUdA7A==
X-Google-Smtp-Source: AGHT+IGd2yb8Lh+TigEcZp8LwOOGhaNo5nK6cQEpeL5J7doUtoN8Z0uWPDioes/NiDuiaoBlgbg2Ag==
X-Received: by 2002:a05:600c:608e:b0:46f:a2ba:581f with SMTP id 5b1f17b1804b1-47d18be1812mr163275705e9.16.1766497844006;
        Tue, 23 Dec 2025 05:50:44 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:620a:8300:4258:c40f:5faf:7af5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d192e88f5sm237921025e9.0.2025.12.23.05.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 05:50:43 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	biju.das.jz@bp.renesas.com,
	fabrizio.castro.jz@renesas.com,
	geert+renesas@glider.be,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v6 3/8] dmaengine: sh: rz-dmac: Drop read of CHCTRL register
Date: Tue, 23 Dec 2025 15:49:47 +0200
Message-ID: <20251223134952.460284-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223134952.460284-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251223134952.460284-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The CHCTRL register has 11 bits that can be updated by software. The
documentation for all these bits states the following:
- A read operation results in 0 being read
- Writing zero does not affect the operation

All bits in the CHCTRL register accessible by software are set and clear
bits.

The documentation for the CLREND bit of CHCTRL states:
Setting this bit to 1 can clear the END bit of the CHSTAT_n/nS register.
Also, the DMA transfer end interrupt is cleared. An attempt to read this
bit results in 0 being read.
1: Clears the END bit.
0: Does not affect the operation.

Since writing zero to any bit in this register does not affect controller
operation and reads always return zero, there is no need to perform
read-modify-write accesses to set the CLREND bit. Drop the read of the
CHCTRL register.

Also, since setting the CLREND bit does not interact with other
functionalities exposed through this register and only clears the END
interrupt, there is no need to lock around this operation. Add a comment
to document this.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v6:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 818d1ef6f0bf..43a772e4478c 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -698,7 +698,7 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
 {
 	struct dma_chan *chan = &channel->vc.chan;
 	struct rz_dmac *dmac = to_rz_dmac(chan->device);
-	u32 chstat, chctrl;
+	u32 chstat;
 
 	chstat = rz_dmac_ch_readl(channel, CHSTAT, 1);
 	if (chstat & CHSTAT_ER) {
@@ -710,8 +710,11 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
 		goto done;
 	}
 
-	chctrl = rz_dmac_ch_readl(channel, CHCTRL, 1);
-	rz_dmac_ch_writel(channel, chctrl | CHCTRL_CLREND, CHCTRL, 1);
+	/*
+	 * No need to lock. This just clears the END interrupt. Writing
+	 * zeros to CHCTRL is just ignored by HW.
+	 */
+	rz_dmac_ch_writel(channel, CHCTRL_CLREND, CHCTRL, 1);
 done:
 	return;
 }
-- 
2.43.0


