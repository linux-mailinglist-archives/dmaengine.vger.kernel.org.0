Return-Path: <dmaengine+bounces-10911-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yL3ZE2FfFWp7UgcAu9opvQ
	(envelope-from <dmaengine+bounces-10911-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 10:52:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D17955D2BA6
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 10:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C446B30684F1
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 08:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F423CFF44;
	Tue, 26 May 2026 08:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIEoEaYN"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843E03CF024;
	Tue, 26 May 2026 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779785312; cv=none; b=Omj86nKzKWpteDvJauepAOS1Yc4Kb6u0BtVp7BFB1obe2/vv1wFuZj1YKKydKcU2pJalrsKqfqHjoyKkaslmTrDodcuJ636mx6IOdLB7PTW8RTsrtsOcdz62srTChQ9Hs+l1UMtivJSaXIgfZiJDf8Kphk2v2ICsbH3BRtAvarw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779785312; c=relaxed/simple;
	bh=m1KlBWocMTaKeL2I7DjJjPCsBJsX0O/2ZVJ/+9qVpDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hkud3OFGsN5IKBhoDf4Qin/Y0OmIP+wDVbeJ63ybJS5r2XN6SMM98VpyHjL3UzKxp5YAx+Z9dP+W++Wn9f9U4nK598EWE9a4WMNz//YORHQX6fDKnejffGX3pCTwAavhW9ed+INdIXkMf0beAE3ELA++HftB9N5VJxIxtTzJhfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIEoEaYN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15EE1F00A3A;
	Tue, 26 May 2026 08:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779785311;
	bh=/mw3tHwxqJxGzAwNQxvMiWiETvEIWUbWQPBUbh+bwdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GIEoEaYNcAVYoU8IEHiAqSSmH6ZksKVh/VfQPRQ/biBK9Hea5ddaCZM42QoIFULTC
	 HFUFsCGBPXxmX8BFfWDepxIj7r7FVHyRpkxjZCQNDQB/QDcCmzheTpv10Qsyls6Nbj
	 +hSwGRRv2/DSNJjN13lHUZVCVMCRgssyLYlOxt6vuXi7whrpdxlIqojp2TPez2PF4v
	 xMuy6hIWFilUrJ+kvvqDy+fBetC//n5bbS6JwH6J/0DFob5mQ270qexTYKiXIdDw3p
	 Wb8Q9/TusYW21NJcm/TooOCEt9ZGs59nz1VTwXa/epxK5pfnx5ZqEJ5U5MBu2xqdtH
	 Jw4e2v1ZMPwvw==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
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
	kuninori.morimoto.gx@renesas.com,
	long.luu.ur@renesas.com
Cc: claudiu.beznea@kernel.org,
	claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH v6 14/18] dmaengine: sh: rz-dmac: Add runtime PM support
Date: Tue, 26 May 2026 11:47:06 +0300
Message-ID: <20260526084710.3491480-15-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526084710.3491480-1-claudiu.beznea@kernel.org>
References: <20260526084710.3491480-1-claudiu.beznea@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10911-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D17955D2BA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Protect the driver exposed APIs with runtime PM suspend/resume calls
before accessing HW registers. As the current driver leaves runtime PM
enabled in probe, the purpose of the changes in this patch is to avoid
accessing HW registers after a failed system suspend leaves the runtime
PM state of the device improperly reinitialized.

In that case, the driver remains bound to the device, the APIs are still
exposed, and any access to HW registers without runtime resuming the
device may lead to synchronous aborts.

To avoid leaking resources in case of runtime PM failures, save the error
code returned by PM_RUNTIME_ACQUIRE_ERR() in rz_dmac_terminate_all() and
return it only at the end of the function to allow the cleanup code to
run. A similar approach is used in rz_dmac_free_chan_resources().

Because some exposed APIs (e.g. ->device_terminate_all()) may be called
from atomic context according to the documentation, mark the DMA device as
pm_runtime_irq_safe().

This patch prepares the driver for suspend-to-RAM support.

Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v6:
- updated patch description
- collected tags
- in rz_dmac_free_chan_resources() and rz_dmac_terminate_all() don't touch
  the HW registers if runtime resume failed but allow freeing resources
  as suggested by sashiko; along with it added debug messages in case the
  RPM resume failed
- dropped the runtime resume from rz_dmac_xfer_desc() and move it instead
  in rz_dmac_issue_pending() only to avoid calling rpm resume code in
  interrupt path as, if we are in the interrupt path the device is sanely
  in runtime resume state
- moved the RPM resume code in from rz_dmac_tx_status to
  rz_dmac_chan_get_residue(), as close as possible to the HW registers read
  to avoid RPM resume in case the residue could be returned w/o interracting
  with the HW
- updated patch description

Changes in v5:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 60 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 93394b9934c8..bd4ca8e939f1 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -549,12 +549,22 @@ static void rz_dmac_free_chan_resources(struct dma_chan *chan)
 	struct rz_dmac *dmac = to_rz_dmac(chan->device);
 	struct rz_dmac_desc *desc, *_desc;
 	unsigned long flags;
+	int ret;
+
+	PM_RUNTIME_ACQUIRE_IF_ENABLED(dmac->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret) {
+		dev_err(dmac->dev, "RPM resume failed for channel %s, ret=%d\n!",
+			dma_chan_name(chan), ret);
+	}
 
 	spin_lock_irqsave(&channel->vc.lock, flags);
 
 	rz_lmdesc_setup(channel, channel->lmdesc.base);
 
-	rz_dmac_disable_hw(channel);
+	/*  Skip touching HW if RPM resume failed. Let the cleanup do its jobs. */
+	if (!ret)
+		rz_dmac_disable_hw(channel);
 
 	if (channel->mid_rid >= 0) {
 		clear_bit(channel->mid_rid, dmac->modules);
@@ -697,11 +707,22 @@ rz_dmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
 static int rz_dmac_terminate_all(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
+	struct rz_dmac *dmac = to_rz_dmac(chan->device);
 	unsigned long flags;
 	LIST_HEAD(head);
+	int ret;
+
+	PM_RUNTIME_ACQUIRE_IF_ENABLED(dmac->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret) {
+		dev_err(dmac->dev, "RPM resume failed for channel %s, ret=%d\n!",
+			dma_chan_name(chan), ret);
+	}
 
 	spin_lock_irqsave(&channel->vc.lock, flags);
-	rz_dmac_disable_hw(channel);
+	/* Don't return if RPM failed. Let the cleanup do its jobs. */
+	if (!ret)
+		rz_dmac_disable_hw(channel);
 	rz_lmdesc_setup(channel, channel->lmdesc.base);
 
 	if (channel->desc) {
@@ -716,13 +737,20 @@ static int rz_dmac_terminate_all(struct dma_chan *chan)
 	spin_unlock_irqrestore(&channel->vc.lock, flags);
 	vchan_dma_desc_free_list(&channel->vc, &head);
 
-	return 0;
+	return ret;
 }
 
 static void rz_dmac_issue_pending(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
+	struct rz_dmac *dmac = to_rz_dmac(chan->device);
 	unsigned long flags;
+	int ret;
+
+	PM_RUNTIME_ACQUIRE_IF_ENABLED(dmac->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return;
 
 	spin_lock_irqsave(&channel->vc.lock, flags);
 
@@ -807,6 +835,11 @@ static void rz_dmac_device_synchronize(struct dma_chan *chan)
 
 	vchan_synchronize(&channel->vc);
 
+	PM_RUNTIME_ACQUIRE_IF_ENABLED(dmac->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return;
+
 	ret = read_poll_timeout(rz_dmac_ch_readl, chstat, !(chstat & CHSTAT_EN),
 				100, 100000, false, channel, CHSTAT, 1);
 	if (ret < 0)
@@ -866,6 +899,7 @@ static int rz_dmac_chan_get_residue(struct device *dev, struct rz_dmac_chan *cha
 	struct rz_dmac_desc *desc = NULL;
 	struct virt_dma_desc *vd;
 	u32 crla, crtb, i;
+	int ret;
 
 	vd = vchan_find_desc(&channel->vc, cookie);
 	if (vd) {
@@ -884,6 +918,11 @@ static int rz_dmac_chan_get_residue(struct device *dev, struct rz_dmac_chan *cha
 		return 0;
 	}
 
+	PM_RUNTIME_ACQUIRE_IF_ENABLED(dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
 	/*
 	 * We need to read two registers. Make sure the hardware does not move
 	 * to next lmdesc while reading the current lmdesc. Trying it 3 times
@@ -965,6 +1004,13 @@ static int rz_dmac_device_pause_set(struct rz_dmac_chan *channel,
 static int rz_dmac_device_pause(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
+	struct rz_dmac *dmac = to_rz_dmac(chan->device);
+	int ret;
+
+	PM_RUNTIME_ACQUIRE_IF_ENABLED(dmac->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
 
 	guard(spinlock_irqsave)(&channel->vc.lock);
 
@@ -994,6 +1040,13 @@ static int rz_dmac_device_resume_set(struct rz_dmac_chan *channel,
 static int rz_dmac_device_resume(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
+	struct rz_dmac *dmac = to_rz_dmac(chan->device);
+	int ret;
+
+	PM_RUNTIME_ACQUIRE_IF_ENABLED(dmac->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
 
 	guard(spinlock_irqsave)(&channel->vc.lock);
 
@@ -1274,6 +1327,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(dmac->rstc),
 				     "failed to get resets\n");
 
+	pm_runtime_irq_safe(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0) {
-- 
2.43.0


