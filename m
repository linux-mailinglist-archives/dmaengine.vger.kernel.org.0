Return-Path: <dmaengine+bounces-9918-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LxVOIcK1WlQzwcAu9opvQ
	(envelope-from <dmaengine+bounces-9918-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 15:45:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 394523AF676
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 15:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B95E2308C500
	for <lists+dmaengine@lfdr.de>; Tue,  7 Apr 2026 13:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A6C3B8BBB;
	Tue,  7 Apr 2026 13:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="FMOl4At/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5B83B8937
	for <dmaengine@vger.kernel.org>; Tue,  7 Apr 2026 13:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568957; cv=none; b=OwYv3eGxx61cRoB6nK8fXsPhKCersyItMxxPyf5VuDcZS5dUSdabXk9ZVAtkI1IawbXqwrcslHmVRcEcGiwJ2B+tjqXikWou6koD4tn3dMGjL/vBBTNGP9E2thZaPru4TELoXDW9ZGSqKMTsWn4Sjpu43DA7i3M4MjGbNAsa0r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568957; c=relaxed/simple;
	bh=Xs7tieydv3sKiMcD+C+sF1niTjjJU5jYr8NdxZL5LbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sP1TroOYcoI/58gK8uTsMP4FZyYvmdiqkGUHJggA5qSxs5A5IH0E5r5EQaHaYFmxCtcd+ypepEFIsw3ZTYJggbAgypiRf9NUJEM39pcrUo3/1zOnPeTrwuKQCEg4/dSpZpxH4cRjIY1Uj/QOsVT5S99i997OyljSr7+FuTVFypI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=FMOl4At/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso32121935e9.3
        for <dmaengine@vger.kernel.org>; Tue, 07 Apr 2026 06:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775568949; x=1776173749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcU1x9xfP8ibyZGw0FaYmtMSZB/JFgRwhCjX8R29DUo=;
        b=FMOl4At/PFu/np+zOzCWBTU+2jfstG0/9CZDNgOwLWHQe9UnlqMcE2JyPg9ufM75kJ
         4v9++TtmLgL2lIJ3h+TGsyL0/tokhzhOyscaSit++NSUJ/u63/tJfA89SYHpyVnN1UfP
         kYgsqKrazz0vJm/J4ZEpk2cWDO00ZH/r4UbEbfe4EngE3zcTGS0/h3AITnR7rzasfKYH
         Y/tA2P8FWgzsahsnsd5hOLiZhSWaL60GG+f3wWmtA+wN2QGJbdx9uEYEaqMRPj1ZOiPX
         5NZc8F0vPe+9M0eoq/Xf8mFDDxuomGjDrVVh4U/cjxStj0v+97YHP+km5PAtNrTwzNo0
         Hdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775568949; x=1776173749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qcU1x9xfP8ibyZGw0FaYmtMSZB/JFgRwhCjX8R29DUo=;
        b=na4tllrcy7OF84ltOCOHoYg+mYSKKLKa3AyXkcICa3ITjpg/nhg0qGBpimWz7axbFm
         geI1w9UnzCht+Iltq8b1X0n/rY/3fuxz8xHbJPMM6hlb73yJc4M3P/JSyfBm0a+1AbLL
         iy08Np9FtTQrj6KZ9VB/KNCZ2Fa5cj+14NZR2ylgEwjxv4TB/VNdvfDfNdIaybugCQ62
         dP4FE2xbjwrt8t6SoKhb3J+4f2wz8IlJyCIJppDS27qrs89Gs/LxiEhgBuKWXSJqtzXH
         zgIlBofbkh4wkq6Mj//gA7HT/pxD49LqD9IX+1+Bw4d6WWp85BY1dZXGXTlLdZP/snM+
         cjFA==
X-Forwarded-Encrypted: i=1; AJvYcCW9+nUSigl6uxCfkmFkJgJoYvhHJwrhhCzRq4KnVpLvEAvRZm4cl8Oua/FriyEUhNxpja/SHa/fLq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHy3Zg5UXHICWbqxgkqE8qZSmENJ70jxQ+xA/tvw8jUuhfSXqT
	qsuKAOlO4HNB1KjykR2RiDsrSA4KzM+F9oH6U9H28smBRwCRUcMjw9vtTp/MAdc9bYs=
X-Gm-Gg: AeBDieuiDdizfY6+ZFXhJEVv2OzY6byNIjiwxiSp8Ho5Co88VOE0vNSH+vqigzia2Ac
	8LVkxm2qU8lYMH8WFlif2pMnYsnpNhwkLy9sNXEMx1iji0f3h6fNIPUDh3XY7pibs6ht3Cehe6L
	GB9x9xtngU7F16oXIW7NSVidsyxLb6QZcOaXqSYrbt7mfih2uEMX4ZayaOUqjd4tQf+h9I0/XcP
	hR9LKgtsyu9T2kk8Ff5mKZeXzcAFZFOvO3h7ODo5DSsRPr9lvfuawHfC4ZWVMaIq5wkEl0QKA68
	1rqmFTau19WnZ4nhqgUQpBwF2U00wvVuX1pmoFhcAcVXcpafGLtD02cKgvEUV3orYHbR+VGKkwv
	pUQOmSV3TalCmiTkJNSuv4qjlXx0uhqqNHitnqjjZ7GFqX/7fC5Fde4QOyX/uGD9T6UlCMvTyXB
	XV9nsJAJbBnna1gOcsqiFfZt3CjnU3B55pzJGfX3FabZQCayALSjm5
X-Received: by 2002:a05:600c:1f96:b0:487:4eb:d125 with SMTP id 5b1f17b1804b1-48899753e5fmr238859485e9.9.1775568948579;
        Tue, 07 Apr 2026 06:35:48 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a91686f9sm285777675e9.10.2026.04.07.06.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 06:35:48 -0700 (PDT)
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
Subject: [PATCH v3 12/15] dmaengine: sh: rz-dmac: Add suspend to RAM support
Date: Tue,  7 Apr 2026 16:35:04 +0300
Message-ID: <20260407133507.887404-13-claudiu.beznea.uj@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9918-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 394523AF676
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The Renesas RZ/G3S SoC supports a power saving mode in which power to most
of the SoC components is turned off, including the DMA IP. Add suspend to
RAM support to save and restore the DMA IP registers.

Cyclic DMA channels require special handling. Since they can be paused and
resumed during system suspend/resume, the driver restores additional
registers for these channels during the system resume phase. If a channel
was not explicitly paused during suspend, the driver ensures that it is
paused and resumed as part of the system suspend/resume flow. This might be
the case of a serial device being used with no_console_suspend.

The cyclic DMA channels used by the sound IPs may be paused during system
suspend. In this case, since rz_dmac_device_synchronize() is called
through the ASoC PCM dmaengine APIs after the channel has been paused,
the CHSTAT.EN bit never goes to zero because the channel remains paused
and enabled.

As a result, the read_poll_timeout() call in rz_dmac_device_synchronize()
times out during system suspend. Since vchan_synchronize() is called to
complete any ongoing transfers and stop descriptor queuing, it should be
safe to drop the read_poll_timeout() from rz_dmac_device_synchronize().

For non-cyclic channels, the dev_pm_ops::prepare callback waits for all
the ongoing transfers to complete before allowing suspend-to-RAM to
proceed.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- dropped RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED
- dropped read_poll_timeout() from rz_dmac_device_synchronze() as
  with audio drivers this times out all the time on suspend because
  the audio DMA is already paused when the rz_dmac_device_synchronize()
  is called; updated the commit description to describe this change
- call rz_dmac_device_pause_internal() only if RZ_DMAC_CHAN_STATUS_PAUSED
  bit is not set or the device is enabled in HW
- updated rz_dmac_device_resume_set() to have it simpler and cover
  the cases when it is called with the channel enabled or paused;
  updated the comment describing the covered use cases
- call rz_dmac_device_resume_internal() only if
  RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL bit is set
- in rz_dmac_chan_is_enabled() return -EAGAIN only if the channel is
  enabled in HW
- in rz_dmac_suspend_recover() drop the update of
  RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED as this is not available anymore
- in rz_dmac_suspend() call rz_dmac_device_pause_internal() unconditionally
  as the logic is now handled inside the called function; also, do not
  ignore anymore the failure of internal suspend and abort the suspend
  instead
- report channel internal resume failures in rz_dmac_resume()
- use rz_dmac_disable_hw() instead of open coding it in rz_dmac_resume()
- call rz_dmac_device_resume_internal() uncoditionally as the skip
  logic is now handled in the function itself
- use NOIRQ_SYSTEM_SLEEP_PM_OPS()
- didn't collect Tommaso's Tb tag as the series was changed a lot since
  v2

Changes in v2:
- fixed typos in patch description
- in rz_dmac_suspend_prepare(): return -EAGAIN based on the value returned
  by vchan_issue_pending()
- in rz_dmac_suspend_recover(): clear RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED for
  non cyclic channels
- in rz_dmac_resume(): call rz_dmac_set_dma_req_no() only for cyclic channels


 drivers/dma/sh/rz-dmac.c | 191 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 179 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index f7133ac6af60..3265c7b3ab83 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -69,10 +69,12 @@ struct rz_dmac_desc {
  * enum rz_dmac_chan_status: RZ DMAC channel status
  * @RZ_DMAC_CHAN_STATUS_PAUSED: Channel is paused though DMA engine callbacks
  * @RZ_DMAC_CHAN_STATUS_CYCLIC: Channel is cyclic
+ * @RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL: Channel is paused through driver internal logic
  */
 enum rz_dmac_chan_status {
 	RZ_DMAC_CHAN_STATUS_PAUSED,
 	RZ_DMAC_CHAN_STATUS_CYCLIC,
+	RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL,
 };
 
 struct rz_dmac_chan {
@@ -92,6 +94,10 @@ struct rz_dmac_chan {
 	u32 chctrl;
 	int mid_rid;
 
+	struct {
+		u32 nxla;
+	} pm_state;
+
 	struct list_head ld_free;
 
 	struct {
@@ -803,16 +809,9 @@ static void rz_dmac_device_synchronize(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
 	struct rz_dmac *dmac = to_rz_dmac(chan->device);
-	u32 chstat;
-	int ret;
 
 	vchan_synchronize(&channel->vc);
 
-	ret = read_poll_timeout(rz_dmac_ch_readl, chstat, !(chstat & CHSTAT_EN),
-				100, 100000, false, channel, CHSTAT, 1);
-	if (ret < 0)
-		dev_warn(dmac->dev, "DMA Timeout");
-
 	rz_dmac_set_dma_req_no(dmac, channel->index, dmac->info->default_dma_req_no);
 }
 
@@ -960,20 +959,57 @@ static int rz_dmac_device_pause(struct dma_chan *chan)
 	return rz_dmac_device_pause_set(channel, BIT(RZ_DMAC_CHAN_STATUS_PAUSED));
 }
 
+static int rz_dmac_device_pause_internal(struct rz_dmac_chan *channel)
+{
+	lockdep_assert_held(&channel->vc.lock);
+
+	/* Skip channels explicitly paused by consummers or disabled. */
+	if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED) ||
+	    !rz_dmac_chan_is_enabled(channel))
+		return 0;
+
+	return rz_dmac_device_pause_set(channel, BIT(RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL));
+}
+
 static int rz_dmac_device_resume_set(struct rz_dmac_chan *channel,
 				     unsigned long clear_bitmask)
 {
-	int ret = 0;
 	u32 val;
+	int ret;
 
 	lockdep_assert_held(&channel->vc.lock);
 
-	/* Do not check CHSTAT_SUS but rely on HW capabilities. */
+	/*
+	 * We can be:
+	 *
+	 * 1/ after the channel was paused by a consummer and now it
+	 *    needs to be resummed
+	 * 2/ after the channel was paused internally (as a result of
+	 *    a system suspend with power loss or not)
+	 * 3/ after the channel was paused by a consummer, the system
+	 *    went through a system suspend (with power loss or not)
+	 *    and the consummer wants to resume the channel
+	 *
+	 * To cover all the above cases we set both CLRSUS and SETEN.
+	 *
+	 * In case 1/ setting SETEN while the channel is still enabled
+	 * is harmless for the controller.
+	 *
+	 * In case 2/ the channel is disabled when calling this function
+	 * and setting CLRSUS is harmless for the controller as the
+	 * channel is disabled anyway.
+	 *
+	 * In case 3/ the channel is disabled/enabled if the system
+	 * went though a suspend with power loss/or not and setting
+	 * CLRSUS/SETEN is harmless for the controller as the channel
+	 * is enabled/disabled anyway.
+	 */
+
+	rz_dmac_ch_writel(channel, CHCTRL_CLRSUS | CHCTRL_SETEN, CHCTRL, 1);
 
-	rz_dmac_ch_writel(channel, CHCTRL_CLRSUS, CHCTRL, 1);
 	ret = read_poll_timeout_atomic(rz_dmac_ch_readl, val,
-				       !(val & CHSTAT_SUS), 1, 1024, false,
-				       channel, CHSTAT, 1);
+				       ((val & (CHSTAT_SUS | CHSTAT_EN)) == CHSTAT_EN),
+				       1, 1024, false, channel, CHSTAT, 1);
 
 	channel->status &= ~clear_bitmask;
 
@@ -992,6 +1028,16 @@ static int rz_dmac_device_resume(struct dma_chan *chan)
 	return rz_dmac_device_resume_set(channel, BIT(RZ_DMAC_CHAN_STATUS_PAUSED));
 }
 
+static int rz_dmac_device_resume_internal(struct rz_dmac_chan *channel)
+{
+	lockdep_assert_held(&channel->vc.lock);
+
+	if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL)))
+		return 0;
+
+	return rz_dmac_device_resume_set(channel, BIT(RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL));
+}
+
 /*
  * -----------------------------------------------------------------------------
  * IRQ handling
@@ -1374,6 +1420,126 @@ static void rz_dmac_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
+static int rz_dmac_suspend_prepare(struct device *dev)
+{
+	struct rz_dmac *dmac = dev_get_drvdata(dev);
+
+	for (unsigned int i = 0; i < dmac->n_channels; i++) {
+		struct rz_dmac_chan *channel = &dmac->channels[i];
+
+		guard(spinlock_irqsave)(&channel->vc.lock);
+
+		/* Wait for transfer completion, except in cyclic case. */
+		if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC))
+			continue;
+
+		if (rz_dmac_chan_is_enabled(channel))
+			return -EAGAIN;
+	}
+
+	return 0;
+}
+
+static void rz_dmac_suspend_recover(struct rz_dmac *dmac)
+{
+	for (unsigned int i = 0; i < dmac->n_channels; i++) {
+		struct rz_dmac_chan *channel = &dmac->channels[i];
+
+		guard(spinlock_irqsave)(&channel->vc.lock);
+
+		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)))
+			continue;
+
+		rz_dmac_device_resume_internal(channel);
+	}
+}
+
+static int rz_dmac_suspend(struct device *dev)
+{
+	struct rz_dmac *dmac = dev_get_drvdata(dev);
+	int ret;
+
+	for (unsigned int i = 0; i < dmac->n_channels; i++) {
+		struct rz_dmac_chan *channel = &dmac->channels[i];
+
+		guard(spinlock_irqsave)(&channel->vc.lock);
+
+		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)))
+			continue;
+
+		ret = rz_dmac_device_pause_internal(channel);
+		if (ret) {
+			dev_err(dev, "Failed to suspend channel %s\n",
+				dma_chan_name(&channel->vc.chan));
+			goto recover;
+		}
+
+		channel->pm_state.nxla = rz_dmac_ch_readl(channel, NXLA, 1);
+	}
+
+	pm_runtime_put_sync(dmac->dev);
+
+	ret = reset_control_assert(dmac->rstc);
+	if (ret) {
+		pm_runtime_resume_and_get(dmac->dev);
+recover:
+		rz_dmac_suspend_recover(dmac);
+	}
+
+	return ret;
+}
+
+static int rz_dmac_resume(struct device *dev)
+{
+	struct rz_dmac *dmac = dev_get_drvdata(dev);
+	int errors = 0, ret;
+
+	ret = reset_control_deassert(dmac->rstc);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_resume_and_get(dmac->dev);
+	if (ret) {
+		reset_control_assert(dmac->rstc);
+		return ret;
+	}
+
+	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_0_7_COMMON_BASE + DCTRL);
+	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_8_15_COMMON_BASE + DCTRL);
+
+	for (unsigned int i = 0; i < dmac->n_channels; i++) {
+		struct rz_dmac_chan *channel = &dmac->channels[i];
+
+		guard(spinlock_irqsave)(&channel->vc.lock);
+
+		rz_dmac_disable_hw(&dmac->channels[i]);
+
+		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)))
+			continue;
+
+		rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);
+
+		rz_dmac_ch_writel(channel, channel->pm_state.nxla, NXLA, 1);
+		rz_dmac_ch_writel(channel, channel->chcfg, CHCFG, 1);
+		rz_dmac_ch_writel(channel, CHCTRL_SWRST, CHCTRL, 1);
+		rz_dmac_ch_writel(channel, channel->chctrl, CHCTRL, 1);
+
+		ret = rz_dmac_device_resume_internal(channel);
+		if (ret) {
+			errors = ret;
+			dev_err(dev, "Failed to resume channel %s\n",
+				dma_chan_name(&channel->vc.chan));
+		}
+	}
+
+	return errors ? : ret;
+}
+
+static const struct dev_pm_ops rz_dmac_pm_ops = {
+	.prepare = rz_dmac_suspend_prepare,
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(rz_dmac_suspend, rz_dmac_resume)
+};
+
 static const struct rz_dmac_info rz_dmac_v2h_info = {
 	.icu_register_dma_req = rzv2h_icu_register_dma_req,
 	.default_dma_req_no = RZV2H_ICU_DMAC_REQ_NO_DEFAULT,
@@ -1400,6 +1566,7 @@ static struct platform_driver rz_dmac_driver = {
 	.driver		= {
 		.name	= "rz-dmac",
 		.of_match_table = of_rz_dmac_match,
+		.pm	= pm_sleep_ptr(&rz_dmac_pm_ops),
 	},
 	.probe		= rz_dmac_probe,
 	.remove		= rz_dmac_remove,
-- 
2.43.0


