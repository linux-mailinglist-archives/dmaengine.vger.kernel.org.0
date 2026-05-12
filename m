Return-Path: <dmaengine+bounces-10358-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMOhGvUaA2pD0gEAu9opvQ
	(envelope-from <dmaengine+bounces-10358-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 14:20:05 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CFD51FFF8
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 14:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2968E30C7CDE
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 12:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0025F4F7973;
	Tue, 12 May 2026 12:13:32 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0B5379C4F;
	Tue, 12 May 2026 12:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778588012; cv=none; b=EL9+zxjxvytKWSD8rpD7fRQ+aPMAsQWNU7phNLAHujkgfGAsrt45U3jf8TnzBBJuuFhpPYAbl7IYMSt9MLB8hjsDrZFFoLNXsBArKV1MfdYE1Y3VX9FVjCZ74pwijjsnmX2oB25cC9W8vevCnadO+0ltEUkZFt3QxWXkYTYIyms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778588012; c=relaxed/simple;
	bh=8t65VgXhLIJLjonli8OKtYr5Wv0hGAfxcXujWKJJxSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NPN+/TF7AR8c5w3aTXdmruVMVNMPtihDCrUQ9HDRCpCRqkDy+qgOvR5MCELYJsIBsX5R4QVaMuAZW4yfpfLWOCYoOpp4k56BlWHMIaaO1f9gnmn+g7UZ/vKTt/lq7+TidBD6CWaFODiTt0ODSEHLdENPCwD46Zo4Mfdjx+KYVwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00654C2BCFB;
	Tue, 12 May 2026 12:13:27 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
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
	kuninori.morimoto.gx@renesas.com,
	long.luu.ur@renesas.com
Cc: claudiu.beznea@kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v5 14/17] dmaengine: sh: rz-dmac: Add suspend to RAM support
Date: Tue, 12 May 2026 15:12:15 +0300
Message-ID: <20260512121219.216159-15-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512121219.216159-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260512121219.216159-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 13CFD51FFF8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10358-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea.uj@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.017];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,renesas.com:email,bp.renesas.com:mid]
X-Rspamd-Action: no action

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

Changes in v5:
- runtime PM enable in rz_dmac_suspend_prepare() and rz_dmac_suspend_recover()
- initialize ret in rz_dmac_suspend()
- in suspend/resume APIs changed the order b/w runtime PM and reset calls
  to follow the sequence present in remove and probe
- in rz_dmac_suspend(): take into account the error code returned by
  pm_runtime_put_sync()
- in rz_dmac_resume(): use "return errors ? : 0;" instead of
  "return errors ? : ret;"

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


 drivers/dma/sh/rz-dmac.c | 209 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 204 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index df91657fd5e3..b0a8590f4a9d 100644
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
@@ -1002,20 +1008,57 @@ static int rz_dmac_device_pause(struct dma_chan *chan)
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
 
@@ -1041,6 +1084,16 @@ static int rz_dmac_device_resume(struct dma_chan *chan)
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
@@ -1406,6 +1459,151 @@ static void rz_dmac_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
+static int rz_dmac_suspend_prepare(struct device *dev)
+{
+	struct rz_dmac *dmac = dev_get_drvdata(dev);
+	int ret;
+
+	PM_RUNTIME_ACQUIRE_IF_ENABLED(dmac->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
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
+	int ret;
+
+	PM_RUNTIME_ACQUIRE_IF_ENABLED(dmac->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return;
+
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
+	int ret = 0;
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
+	if (ret)
+		goto suspend_recover;
+
+	ret = reset_control_assert(dmac->rstc);
+	if (ret)
+		goto suspend_recover;
+
+	ret = pm_runtime_put_sync(dev);
+	if (ret < 0)
+		goto reset_deassert;
+
+	return 0;
+
+reset_deassert:
+	reset_control_deassert(dmac->rstc);
+suspend_recover:
+	rz_dmac_suspend_recover(dmac);
+	return ret;
+}
+
+static int rz_dmac_resume(struct device *dev)
+{
+	struct rz_dmac *dmac = dev_get_drvdata(dev);
+	int errors = 0, ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	ret = reset_control_deassert(dmac->rstc);
+	if (ret) {
+		/*
+		 * Do not put runtime PM here and keep the same state as in
+		 * probe. As subsequent suspend/resume cycles may follow, leave
+		 * the runtime PM as is, here, to avoid imbalances.
+		 */
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
+			dev_err(dev, "Failed to resume channel %s, ret=%d\n",
+				dma_chan_name(&channel->vc.chan), ret);
+		}
+	}
+
+	return errors ? : 0;
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
@@ -1432,6 +1630,7 @@ static struct platform_driver rz_dmac_driver = {
 	.driver		= {
 		.name	= "rz-dmac",
 		.of_match_table = of_rz_dmac_match,
+		.pm	= pm_sleep_ptr(&rz_dmac_pm_ops),
 	},
 	.probe		= rz_dmac_probe,
 	.remove		= rz_dmac_remove,
-- 
2.43.0


