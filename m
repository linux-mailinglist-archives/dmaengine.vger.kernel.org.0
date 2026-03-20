Return-Path: <dmaengine+bounces-9565-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMEeNfgvvWmI7QIAu9opvQ
	(envelope-from <dmaengine+bounces-9565-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 12:31:04 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACCE2D9999
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 12:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51883306306C
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 11:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4963AA4F0;
	Fri, 20 Mar 2026 11:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="XwKMm19E"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF67B3AA1A8
	for <dmaengine@vger.kernel.org>; Fri, 20 Mar 2026 11:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774006134; cv=none; b=fV0OwXDJwJl7zPQdj+JkNPeL0+aRk/AwHYvnNDOC/kog4lY8Q0oI4Q1QFoenNYJWeapYQzNblniF9tXgMi14X5gb1ftw8AHbv1QQU67fF+2jnNBLjs0q3wMg2FxgSxfZRQps2u6OtVrNCA8La/PXhNJRdSCRdYgSvSiXKFsMD4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774006134; c=relaxed/simple;
	bh=8W8B7IOd8EkL9ZxUe9bYG4G40slTwd/W6qN26L0cJfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IttHJzvW6LIKrwR+fFS0UWKSr0jHyMfssANqiTE+3iwji9HKNrFqKwgkZwKgj17WcVui4EaLWhkt2QluywLBwpeeEk64YEHCpGkg6073F/1Xj9cRSAso94SUVqzEreynnM1Kc3j8zY0V5fNQmzR+RHOEPaIMEalDMinPdNA3020=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=XwKMm19E; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486fe655187so9448505e9.2
        for <dmaengine@vger.kernel.org>; Fri, 20 Mar 2026 04:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1774006131; x=1774610931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rHziFuJH0O/h8GS9IhPrrtY5hqbHqGAKO0ZR1pWFq0=;
        b=XwKMm19EF1f6+dUkf+axH13Br3z7haOiYC5QilJ+Tl/vgnIyFCLsJssD/VqS82z+Np
         spXclsqZe1LU/Mw4KSq7EZPLwQrsvrRXIdQfpMoFb8XWu7IKQ3EnfFWNFDsVgRooeR8R
         wYkfCxK89g9aXiCcGZNgzBSrkziWuHhv/zQmmfDMR2atwk+7fJF3qHQfw344Av/h+YJY
         tZ5JDtH/MMMJsnXEncL/iEbr0E8uUSkJ2SKWq6qDY+HR5XAkfkmViLJaDOJHZPAMlASf
         azhpzg1Q1batZdKRR4QpyR8QRpRNAC10hY41hV4AkSUuJ0xzZgXk+w0I+j7pQ5JzrZdL
         k8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774006131; x=1774610931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/rHziFuJH0O/h8GS9IhPrrtY5hqbHqGAKO0ZR1pWFq0=;
        b=ma1UVBY3E+zNrt50MmOCeyAinS8Pwxre4iZMQIT/uUgIRrLsWWct20kBUIIdSJTJos
         l42bcWswrL8lbQEOMYC3GwAFf3XwZSQovSr7RUDG7r3HOqCuTNj/Il5pDDyz+L6wo1e5
         fG4ljb1JUO8r3z6kHjasWPPNIgAzhROQEEhNlDRv7Tvl9HUu1wrCik0PrznOy2znUFmc
         VbVaPmj4IPzWthtUeUJs/grcCerjagjQyV274h7+i5pMyaovmkyNWfDEzT352Urk6brZ
         LSx+cDempD9w1zxfRVFbXiKm4ly4lHREXWbxZCRCM6dnhKHB+Bxwjnk+VJouYYVomU1Z
         0VSA==
X-Forwarded-Encrypted: i=1; AJvYcCW0C9BS6yveg9FvMbzyX7TXnlfDQ27cFv66bDhUU7rC9Abn+dULNhRIY7Ftm9bwi43CQm7m74iZr1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlperlkZ6SI1v/SKhBlZDRJVQmC/30hYYJC9lefUoz9fDxmlmf
	0/NL8qvgcwGUA/QnN6V5Qq7dp3LoERwZjKWp9s7LtTT1aAbrl8WbdOOCCRf8q0LKHzg=
X-Gm-Gg: ATEYQzyVvFQrZPLVuFbbkbO5dCuqB9AMUK31kp2Tz9rq53BSX2S/nu4tH6JUowwe1NY
	XDG8+gtf3jFxqjq9SOl79JuZDWdK/cwvbZiVFnVZVBmfaytSzRiE+KvJc2hcsQbmbQ5ve/n+738
	v7JypoOYFboMEDZrnj8kP1JvohnG+MvDWJjSdvob5ltrLtzApBvr+jIOhFyoEIk/jCNpaV8uRnD
	P2hn6pT4cM9Jnfi7sjiXcCXCmxIgdoOhPqzvI1CbH5XtDRi5zQ9Y/03qxrAbz0lbNvuPTFEh74M
	uj5SAiQA3vN74YFHBIqcrvvOQBgNTU5NqmXAgdn3Y6RqDCx2OLxjI9dziFyr6UAgvOqQslNDgHX
	6gozUdM/HSxzhfJXMrzRKJL5g08VcRFagDryqJSCy+wSimg6tZOK7w9P4Cg/YOFKQ08QsHHwdPe
	kgoPfDEIoM3R2PMTb2WOPZHpkWrZ7h/nXEidLIPzuLb8gaE5nkICFr
X-Received: by 2002:a05:600d:8401:b0:485:35a4:939f with SMTP id 5b1f17b1804b1-486fee297bcmr29826535e9.28.1774006131195;
        Fri, 20 Mar 2026 04:28:51 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe836784sm49869935e9.13.2026.03.20.04.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 04:28:50 -0700 (PDT)
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
Subject: [PATCH v2 5/7] dmaengine: sh: rz-dmac: Add suspend to RAM support
Date: Fri, 20 Mar 2026 13:28:36 +0200
Message-ID: <20260320112838.2200198-6-claudiu.beznea.uj@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	TAGGED_FROM(0.00)[bounces-9565-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 5ACCE2D9999
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

Changes in v2:
- fixed typos in patch description
- in rz_dmac_suspend_prepare(): return -EAGAIN based on the value returned
  by vchan_issue_pending()
- in rz_dmac_suspend_recover(): clear RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED for
  non cyclic channels
- in rz_dmac_resume(): call rz_dmac_set_dma_req_no() only for cyclic channels

 drivers/dma/sh/rz-dmac.c | 185 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 177 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index ca8c0aa8ae59..6f83ccdf94c6 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -69,11 +69,15 @@ struct rz_dmac_desc {
  * enum rz_dmac_chan_status: RZ DMAC channel status
  * @RZ_DMAC_CHAN_STATUS_ENABLED: Channel is enabled
  * @RZ_DMAC_CHAN_STATUS_PAUSED: Channel is paused though DMA engine callbacks
+ * @RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL: Channel is paused through driver internal logic
+ * @RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED: Channel was prepared for system suspend
  * @RZ_DMAC_CHAN_STATUS_CYCLIC: Channel is cyclic
  */
 enum rz_dmac_chan_status {
 	RZ_DMAC_CHAN_STATUS_ENABLED,
 	RZ_DMAC_CHAN_STATUS_PAUSED,
+	RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL,
+	RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED,
 	RZ_DMAC_CHAN_STATUS_CYCLIC,
 };
 
@@ -94,6 +98,10 @@ struct rz_dmac_chan {
 	u32 chctrl;
 	int mid_rid;
 
+	struct {
+		u32 nxla;
+	} pm_state;
+
 	struct list_head ld_free;
 	struct list_head ld_queue;
 	struct list_head ld_active;
@@ -994,10 +1002,17 @@ static int rz_dmac_device_pause(struct dma_chan *chan)
 	return rz_dmac_device_pause_set(channel, RZ_DMAC_CHAN_STATUS_PAUSED);
 }
 
+static int rz_dmac_device_pause_internal(struct rz_dmac_chan *channel)
+{
+	lockdep_assert_held(&channel->vc.lock);
+
+	return rz_dmac_device_pause_set(channel, RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL);
+}
+
 static int rz_dmac_device_resume_set(struct rz_dmac_chan *channel,
 				     enum rz_dmac_chan_status status)
 {
-	u32 val;
+	u32 val, chctrl;
 	int ret;
 
 	lockdep_assert_held(&channel->vc.lock);
@@ -1005,14 +1020,33 @@ static int rz_dmac_device_resume_set(struct rz_dmac_chan *channel,
 	if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED)))
 		return 0;
 
-	rz_dmac_ch_writel(channel, CHCTRL_CLRSUS, CHCTRL, 1);
-	ret = read_poll_timeout_atomic(rz_dmac_ch_readl, val,
-				       !(val & CHSTAT_SUS), 1, 1024, false,
-				       channel, CHSTAT, 1);
-	if (ret)
-		return ret;
+	if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED)) {
+		/*
+		 * We can be after a sleep state with power loss. If power was
+		 * lost, the CHSTAT_SUS bit is zero. In this case, we need to
+		 * enable the channel directly. Otherwise, just set the CLRSUS
+		 * bit.
+		 */
+		val = rz_dmac_ch_readl(channel, CHSTAT, 1);
+		if (val & CHSTAT_SUS)
+			chctrl = CHCTRL_CLRSUS;
+		else
+			chctrl = CHCTRL_SETEN;
+	} else {
+		chctrl = CHCTRL_CLRSUS;
+	}
+
+	rz_dmac_ch_writel(channel, chctrl, CHCTRL, 1);
 
-	channel->status &= ~BIT(status);
+	if (chctrl & CHCTRL_CLRSUS) {
+		ret = read_poll_timeout_atomic(rz_dmac_ch_readl, val,
+					       !(val & CHSTAT_SUS), 1, 1024, false,
+					       channel, CHSTAT, 1);
+		if (ret)
+			return ret;
+	}
+
+	channel->status &= ~(BIT(status) | BIT(RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED));
 
 	return 0;
 }
@@ -1026,6 +1060,13 @@ static int rz_dmac_device_resume(struct dma_chan *chan)
 	return rz_dmac_device_resume_set(channel, RZ_DMAC_CHAN_STATUS_PAUSED);
 }
 
+static int rz_dmac_device_resume_internal(struct rz_dmac_chan *channel)
+{
+	lockdep_assert_held(&channel->vc.lock);
+
+	return rz_dmac_device_resume_set(channel, RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL);
+}
+
 /*
  * -----------------------------------------------------------------------------
  * IRQ handling
@@ -1430,6 +1471,133 @@ static void rz_dmac_remove(struct platform_device *pdev)
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
+		if (vchan_issue_pending(&channel->vc) &&
+		    !(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)))
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
+		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL))) {
+			channel->status &= ~BIT(RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED);
+			continue;
+		}
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
+		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED))) {
+			ret = rz_dmac_device_pause_internal(channel);
+			if (ret) {
+				dev_err(dev, "Failed to suspend channel %s\n",
+					dma_chan_name(&channel->vc.chan));
+				continue;
+			}
+		}
+
+		channel->pm_state.nxla = rz_dmac_ch_readl(channel, NXLA, 1);
+		channel->status |= BIT(RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED);
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
+	int ret;
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
+		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC))) {
+			rz_dmac_ch_writel(&dmac->channels[i], CHCTRL_DEFAULT, CHCTRL, 1);
+			continue;
+		}
+
+		rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);
+
+		rz_dmac_ch_writel(channel, channel->pm_state.nxla, NXLA, 1);
+		rz_dmac_ch_writel(channel, channel->chcfg, CHCFG, 1);
+		rz_dmac_ch_writel(channel, CHCTRL_SWRST, CHCTRL, 1);
+		rz_dmac_ch_writel(channel, channel->chctrl, CHCTRL, 1);
+
+		if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL)) {
+			ret = rz_dmac_device_resume_internal(channel);
+			if (ret) {
+				dev_err(dev, "Failed to resume channel %s\n",
+					dma_chan_name(&channel->vc.chan));
+				continue;
+			}
+		}
+	}
+
+	return 0;
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
@@ -1456,6 +1624,7 @@ static struct platform_driver rz_dmac_driver = {
 	.driver		= {
 		.name	= "rz-dmac",
 		.of_match_table = of_rz_dmac_match,
+		.pm	= pm_sleep_ptr(&rz_dmac_pm_ops),
 	},
 	.probe		= rz_dmac_probe,
 	.remove		= rz_dmac_remove,
-- 
2.43.0


