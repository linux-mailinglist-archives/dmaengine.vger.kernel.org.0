Return-Path: <dmaengine+bounces-9993-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDU5CHM02mlezAgAu9opvQ
	(envelope-from <dmaengine+bounces-9993-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 13:45:55 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A8D3DF925
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 13:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 940FC302CE11
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 11:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16367342C98;
	Sat, 11 Apr 2026 11:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ce1oBavX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97EB33F8D9
	for <dmaengine@vger.kernel.org>; Sat, 11 Apr 2026 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775907816; cv=none; b=tQBmhrOtXUXFKPbekvZzYcgrkWWF7GTkxAJlilroSZ4Ly21Wq7wGBoE+IalKRjZz1Gxaj3U1Mu1fHylajmiRrzrhvWRyh/6gOFsfqS9MUJZGutF71BD1aqRx+8IJqn9bOmhY25mvQ11LljwKo7phiNGm9hdDCR2iLlVz1P22pWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775907816; c=relaxed/simple;
	bh=gfdfvET+/ytu3LqE5vMvaJqB2mOAaDG7bZaE2zA+kYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFs9EQ6EnQ8aSaeud52BDwr8fCqA6Z4xgPnFpP4C8jeaRMlYAweCfLlZc0X/mo0pd8KzBZhUZ2wlMgUoRqMkEBZv2sBiil9ZkRM6MnFreKw1yTLkc8ZZeoCnScpR6ZRRNaTQNfPN1rgT1wDSxiplSMIzDibH965Q0mzGOat2JnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ce1oBavX; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d03db7f87so1843308f8f.3
        for <dmaengine@vger.kernel.org>; Sat, 11 Apr 2026 04:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775907812; x=1776512612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlj+q2kP9Cu8qVdUYl4BQTSd5aVqUZiR4xxofBEVNKY=;
        b=ce1oBavX78g5I5DDFvStqAdrE8XK2Ox/AAH46GnlEkNAGltzF1Zd177RBvbxMdSlG4
         94NtOHlPxe/jhLHR0gg6vUj4/0DwUV9qG8bX/H67hK7kqwaERrdMk3b4cte6ElTEiVHs
         CGo9Nx2533Ye8GMxb7UhGFRM4vQbvU89AGMV58FRhbLWRj1QfKbkUBR0wVmjNxb0+UBa
         d2qRby9haUhL4rpmmxivpn37I0IHBIK0LVcufZLKnuX0m6rsH+ezN+6S01QvgHCEqDBU
         jb6BC8OIb3VCkU1ZB6raRVOpxzQiPMZQot0e/egrZZ8AeY9qC5B2zLKS/VT/LfpCpV3m
         wGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775907812; x=1776512612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zlj+q2kP9Cu8qVdUYl4BQTSd5aVqUZiR4xxofBEVNKY=;
        b=csVBqPm+9r5gnzpIaJeoR135HaIIYHGZdhq+wzf2QxyICb53FuINT/YLgrX39UHPq6
         dm9j1t6xqhxyH1R1aj34nh4Lb0mRinlg8cwEHMQKzPiRHuZDulJSfvXr+olQDwkW1SXl
         98dycE+yZzNeTJqbKcmiV+l3oHTOjiB9K4IdjZfH1ltn+e/JHqApWNfYfemcZYZsjnRk
         Ah9ehixCUx3fmxO0UkJn0WLZ5Vyy0exYw1LZkzpWsiTEoE0rgNQO0oRKMy5H+vTRsilk
         c2VTTSYW8kaf5iMzFXYloxv+bu1pgsauxb6LWACEgGgBDgJjieHpTDUZdi135gb3rvCI
         OfEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/Y//Auy1lFleZWn78N4hvq2GI9v0Y5BmrFTG1wG+LubmoMhz3uyQMIUqVuUO+m6iB3XocdbbDCjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcA1cA3hLRZhxZ9iv3KeUn4CYvR7g8Lf5zCNU81i6J1Z/Eq9lm
	adEKgsgmt04x9EUc7GGU2+Hcumj9eUTK1qn3kJKF5h5waV7/dOpXNpMH/qrh7Zkvh2g=
X-Gm-Gg: AeBDiesfNrpDzCuuo/UXoPEW0KFuDKiIFmrNNS+1fDHNdoHkQqMOCdLKEAA1uqRgRhF
	imHWE8e6znFeI6KOEiWHGKzzvBE6CjVeeibJL2/zxyQ8uk/GdZSjf3fzyjcQtelFIAXx5LJxeC8
	rnaZ0IrhJeV5rYumVZVTNfsslbcXCcAyMKIrAGe6sHb/9yWHK7EvvWgcMM4xGtcuGi9WJnLB6b6
	kpjlKT+R8s1SVezmj7UCuxMO/srSyO3uMzFB6mr9RVfT5zNQ07BSGf1uF8zv55ZPDu5jOwOGlNf
	iFVSHSFlO+R1HZEoiq4QGD/4vSn47UWyP2VXaukIE/1aoG/gtQJ/+lFogRAdQavqJJjXucdUH+z
	FSXDEQqY+I6Gn5QNFPokuyrNa9cTzVFszYlgMLA3mkjOhYl9okZSQl/Dq7FNeUnUztwrMnXQ/bl
	mHJjl9bEwdIfrK/guT/0m8wt+pLXtKOgI6Sj7XnkcnaLdAoQLEEIwA2jfF2Bxgi88=
X-Received: by 2002:a05:6000:200f:b0:43d:2f94:3b40 with SMTP id ffacd0b85a97d-43d64255019mr9745909f8f.6.1775907812110;
        Sat, 11 Apr 2026 04:43:32 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c981sm15776447f8f.33.2026.04.11.04.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 04:43:31 -0700 (PDT)
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
Subject: [PATCH v4 14/17] dmaengine: sh: rz-dmac: Add suspend to RAM support
Date: Sat, 11 Apr 2026 14:43:00 +0300
Message-ID: <20260411114303.2814115-15-claudiu.beznea.uj@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9993-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bp.renesas.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,renesas.com:email,tuxon.dev:dkim]
X-Rspamd-Queue-Id: B6A8D3DF925
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

For non-cyclic channels, the dev_pm_ops::prepare callback waits for all
the ongoing transfers to complete before allowing suspend-to-RAM to
proceed.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- in rz_dmac_device_synchronize() kept the read_poll_timeout() as
  this doesn't fail anymore with the proper status return from
  ->device_tx_status() API in case the channel is paused; with it
  the patch description was updated
- keep the cleanup path in rz_dmac_suspend() simpler to avoid
  confusion when using guard()
- used SYSTEM_SLEEP_PM_OPS() as there is no need for having the
  suspend/resume callbacks being called in NOIRQ phase

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

 drivers/dma/sh/rz-dmac.c | 188 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 183 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 9a10430109e5..00e18d8213ca 100644
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
@@ -962,20 +968,57 @@ static int rz_dmac_device_pause(struct dma_chan *chan)
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
 
@@ -994,6 +1037,16 @@ static int rz_dmac_device_resume(struct dma_chan *chan)
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
@@ -1354,6 +1407,130 @@ static void rz_dmac_remove(struct platform_device *pdev)
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
+			break;
+		}
+
+		channel->pm_state.nxla = rz_dmac_ch_readl(channel, NXLA, 1);
+	}
+
+	if (ret) {
+		rz_dmac_suspend_recover(dmac);
+		return ret;
+	}
+
+	pm_runtime_put_sync(dmac->dev);
+
+	ret = reset_control_assert(dmac->rstc);
+	if (ret) {
+		pm_runtime_resume_and_get(dmac->dev);
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
+	SYSTEM_SLEEP_PM_OPS(rz_dmac_suspend, rz_dmac_resume)
+};
+
 static const struct rz_dmac_info rz_dmac_v2h_info = {
 	.icu_register_dma_req = rzv2h_icu_register_dma_req,
 	.default_dma_req_no = RZV2H_ICU_DMAC_REQ_NO_DEFAULT,
@@ -1380,6 +1557,7 @@ static struct platform_driver rz_dmac_driver = {
 	.driver		= {
 		.name	= "rz-dmac",
 		.of_match_table = of_rz_dmac_match,
+		.pm	= pm_sleep_ptr(&rz_dmac_pm_ops),
 	},
 	.probe		= rz_dmac_probe,
 	.remove		= rz_dmac_remove,
-- 
2.43.0


