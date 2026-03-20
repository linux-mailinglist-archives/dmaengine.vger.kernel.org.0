Return-Path: <dmaengine+bounces-9562-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLY0MIMvvWmI7QIAu9opvQ
	(envelope-from <dmaengine+bounces-9562-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 12:29:07 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 628D72D98FD
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 12:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D418D3016AEC
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 11:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1BF3A960A;
	Fri, 20 Mar 2026 11:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Qb9z1Mz7"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988C93A7845
	for <dmaengine@vger.kernel.org>; Fri, 20 Mar 2026 11:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774006129; cv=none; b=B8Befvznq0JbKrqrRam16kNt6x5HQLW0bq7IjV3AgCFs66lxCK3olfWiAjvv0Z8HAjslcwLPyMLAOnDarcCHmFaTZF8tmqRZ4UbrS9LJvphIIXQo3o9vk9YFfa6BhyZZuKc9LJlYP4E6KqRgB/732sXWDc7ZeXe53/QB7jqdX2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774006129; c=relaxed/simple;
	bh=JdUzXmpCIZw4oaJUcFexv5JNulg2ymIkM6cKTdwhWCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RZe0Qe/omWZ7Iyk6goxYEuqRnD5mp4lh87sJ6EGNWJCT4qqDBfFuf0jeoI8Ul9dhOvq8vd0DJ2LYQ2EfFZOonIHL5s9OIkfhFb1Z1KiNCmri681cCPz3TIbvF4lVwAcVvweKqtqG/1VM1L0udnSec9qqtX4cjVlQGFG0g0igfQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Qb9z1Mz7; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48374014a77so17258655e9.3
        for <dmaengine@vger.kernel.org>; Fri, 20 Mar 2026 04:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1774006126; x=1774610926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFFm2+JqQAqu98CO2w98M9b7NER9zgq+RoPb1v33LV4=;
        b=Qb9z1Mz7Z1UTkOTrQoYqmRU4HAAQI6cBP1ssJiFfjp0RS0WdSqpsUf48GDvNVvx6Dj
         uC8gXe2yTaMnkgDzWcTnrrJAjcm52pYjdYdMsRZ9ybO/VIqFlKvP+8zjKSrXjR4XLhW+
         rc9pHA+snxrDYeR7xicOZtq9zkA9vXPEdo9dUQFjEyHpGmf3DZZFUGwP04bKxkk+PR+A
         WiblYFDC6RSfQrV+96NtQCszoOw5qZaDU7wT65kE1xvqZ2+3tmrGvr2pKrEPNIP/Dm2k
         09A2oYHPFvfZeFTjWpskiklRJshBZORmGkCLv/h4PxBnusx2PM/Q2WJ9gLhU602MTQb1
         gIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774006126; x=1774610926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KFFm2+JqQAqu98CO2w98M9b7NER9zgq+RoPb1v33LV4=;
        b=fN9DzxItHsS2PlaTYZnP5ke6hLGlseEYmmgEIyMm7pBDdsLrkuHbdScopfY4WjB6tI
         9ZWwTYcIiOh1qxM071BERuzq+XmKPFCstvsqIhMWc7eI7Kz0iTieWspGAGQpXQd7ZnMB
         mG2exq0Kq2HUXnIZkMHBpj5HvsggSu0WtlJWn1hFgulTBjo9fwAyFeDWrzRK269uVwqZ
         Qvv1BPHVG3oTXuJEiKM+nZspkGI6YSuegZFDUg2jvr0A3iUW9Igs+xwQh8Obd+tG2kz4
         QjyaCIDgL/t75QI/2THjL5BA+Hmg9Ma94PQACIhyA77/4ult+RDBLRajBk2XXDXQ14j7
         yo+g==
X-Forwarded-Encrypted: i=1; AJvYcCUHP/6XJKxdvwi6V58aO7f0uuz0n4ZXrle2VN0ZoFou/rGmvy+FukzBH4Yf33bvaUXhVsjc/25Wweg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPMlX7S3QauDnZjBPZeQwr2UwMMiqDLelKkXvWZ3GaOYj8BJZf
	3i5KJkWa1+KDmTk+IkyRrDpExjigNvd+VzePQL6ZZXmU43wcKBQ8515aGl5x4HnyUbg=
X-Gm-Gg: ATEYQzx/WjIg1D8z/kk4h34UAFOxSJBG8ucnvg/WZKb21697w8j8EUkbg23ubYD0zB6
	0iO16YubAvudis4Yp36LKp4vSZDZ73BArtQqQTdfqzt9MTABJ+hhYxBmwsBtRJ6iE+GdK92WKnP
	SdSY38yqb/lmHU95HEtcONB1+5IuPS8dLbzk1+mVZFS5e+iUX3Q4GMIfdDGOcZHWuf21lUQXh19
	uIVOLxa9wicbLnCu5U4jyvHxqnkhzS648jm06sF+TvZspUfkPjawR/Ph3fGDylIJXYc1DPfagH3
	IVBy6ikIoq7+CUvJj/SOD/FC36rlMH3C0oq602+aVyzBmfqESoxMBS7xkiuEk09fcJt8pJOXrnQ
	Gb3hJ+ENLBWmozUxwrfsUGBQ42cvhlrFSDFDw9GBn/Yp3ar/5IKq9ekZ2g97JHAT0DiOl96ol3f
	rQy7cdCvYbmbIA8tXbr8m8BbQi2WMwSUmI6/cyaadyUsfzY+xSgT4b
X-Received: by 2002:a05:600c:530f:b0:485:2ce2:4c87 with SMTP id 5b1f17b1804b1-486febb455dmr42143615e9.4.1774006125654;
        Fri, 20 Mar 2026 04:28:45 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe836784sm49869935e9.13.2026.03.20.04.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 04:28:44 -0700 (PDT)
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
	john.madieu.xa@bp.renesas.com,
	kuninori.morimoto.gx@renesas.com,
	tommaso.merciai.xr@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 2/7] dmaengine: sh: rz-dmac: Add pause status bit
Date: Fri, 20 Mar 2026 13:28:33 +0200
Message-ID: <20260320112838.2200198-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320112838.2200198-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260320112838.2200198-1-claudiu.beznea.uj@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	TAGGED_FROM(0.00)[bounces-9562-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	NEURAL_HAM(-0.00)[-0.981];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 628D72D98FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add the RZ_DMAC_CHAN_STATUS_PAUSED status bit index. This is needed to
implement suspend to RAM support for cyclic DMA channels, which will be
added in subsequent commits.

The pause and resume implementations are updated to be reused by the code
that will be added for suspend to RAM handling. Since the pause state is
now stored in a per-channel software cache, there is no longer a need to
interrogate the hardware registers in the pause path. Using the software
status cache simplifies the implementation. The resume code was updated to
use the software status cache as well.

This is a preparatory commit for cyclic DMA suspend to RAM support.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- fixed typos in patch description

 drivers/dma/sh/rz-dmac.c | 68 ++++++++++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 8148a1c78e12..32349d214f68 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -18,6 +18,7 @@
 #include <linux/irqchip/irq-renesas-rzv2h.h>
 #include <linux/irqchip/irq-renesas-rzt2h.h>
 #include <linux/list.h>
+#include <linux/lockdep.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_dma.h>
@@ -65,9 +66,11 @@ struct rz_dmac_desc {
 /**
  * enum rz_dmac_chan_status: RZ DMAC channel status
  * @RZ_DMAC_CHAN_STATUS_ENABLED: Channel is enabled
+ * @RZ_DMAC_CHAN_STATUS_PAUSED: Channel is paused though DMA engine callbacks
  */
 enum rz_dmac_chan_status {
 	RZ_DMAC_CHAN_STATUS_ENABLED,
+	RZ_DMAC_CHAN_STATUS_PAUSED,
 };
 
 struct rz_dmac_chan {
@@ -825,12 +828,9 @@ static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
 		return status;
 
 	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
-		u32 val;
-
 		residue = rz_dmac_chan_get_residue(channel, cookie);
 
-		val = rz_dmac_ch_readl(channel, CHSTAT, 1);
-		if (val & CHSTAT_SUS)
+		if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED))
 			status = DMA_PAUSED;
 	}
 
@@ -843,35 +843,71 @@ static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
 	return status;
 }
 
-static int rz_dmac_device_pause(struct dma_chan *chan)
+static int rz_dmac_device_pause_set(struct rz_dmac_chan *channel,
+				    enum rz_dmac_chan_status status)
 {
-	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
 	u32 val;
+	int ret;
 
-	guard(spinlock_irqsave)(&channel->vc.lock);
+	lockdep_assert_held(&channel->vc.lock);
 
 	if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_ENABLED)))
 		return 0;
 
 	rz_dmac_ch_writel(channel, CHCTRL_SETSUS, CHCTRL, 1);
-	return read_poll_timeout_atomic(rz_dmac_ch_readl, val,
-					(val & CHSTAT_SUS), 1, 1024,
-					false, channel, CHSTAT, 1);
+	ret = read_poll_timeout_atomic(rz_dmac_ch_readl, val,
+				       (val & CHSTAT_SUS), 1, 1024, false,
+				       channel, CHSTAT, 1);
+	if (ret)
+		return ret;
+
+	channel->status |= BIT(status);
+
+	return 0;
 }
 
-static int rz_dmac_device_resume(struct dma_chan *chan)
+static int rz_dmac_device_pause(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
-	u32 val;
 
 	guard(spinlock_irqsave)(&channel->vc.lock);
 
-	/* Do not check CHSTAT_SUS but rely on HW capabilities. */
+	if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED))
+		return 0;
+
+	return rz_dmac_device_pause_set(channel, RZ_DMAC_CHAN_STATUS_PAUSED);
+}
+
+static int rz_dmac_device_resume_set(struct rz_dmac_chan *channel,
+				     enum rz_dmac_chan_status status)
+{
+	u32 val;
+	int ret;
+
+	lockdep_assert_held(&channel->vc.lock);
+
+	if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED)))
+		return 0;
 
 	rz_dmac_ch_writel(channel, CHCTRL_CLRSUS, CHCTRL, 1);
-	return read_poll_timeout_atomic(rz_dmac_ch_readl, val,
-					!(val & CHSTAT_SUS), 1, 1024,
-					false, channel, CHSTAT, 1);
+	ret = read_poll_timeout_atomic(rz_dmac_ch_readl, val,
+				       !(val & CHSTAT_SUS), 1, 1024, false,
+				       channel, CHSTAT, 1);
+	if (ret)
+		return ret;
+
+	channel->status &= ~BIT(status);
+
+	return 0;
+}
+
+static int rz_dmac_device_resume(struct dma_chan *chan)
+{
+	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
+
+	guard(spinlock_irqsave)(&channel->vc.lock);
+
+	return rz_dmac_device_resume_set(channel, RZ_DMAC_CHAN_STATUS_PAUSED);
 }
 
 /*
-- 
2.43.0


