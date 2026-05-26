Return-Path: <dmaengine+bounces-10898-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDaAMA5fFWp7UgcAu9opvQ
	(envelope-from <dmaengine+bounces-10898-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 10:51:26 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E48E5D2B2D
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 10:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8049304C072
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 08:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A573CEB9D;
	Tue, 26 May 2026 08:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWSE398b"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA06313534;
	Tue, 26 May 2026 08:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779785248; cv=none; b=W7+IEloQ/Ia4zoaYqHaRLcZWtCWMPm1L7+Fnpo6ABJ24eHnVYP5Vpgeumfohf7jeVsKMyiGGsNVW+/T1vBm27ag70/zkahPPz1a9NXn2Ax2OuLK1U3RksbHOg5tlQoxH7INmgp8BWUcw1J+DIYzAAKkaxW9RdCQb/mfHf4ifYN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779785248; c=relaxed/simple;
	bh=rGmk+aRvwZHemphDVw2DSidKFuqGLSOAAK3nTf4c6XM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hju1b4mcrqIEOV0ZQMwHgRnIqTs4EzFbtfG+ZRI4MLFwX8gpcUAENI4l76HXN2Sxjnw/7V+O1XQnJeB8mmKMjnkuQuUbj9Lt6qCRNOkzz7hCy2kra9jDE7m3aB5leATXh0jeCTQH10hBeii+8zYuO0Sjr52UyFRdHmi2GUQrYB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWSE398b; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406B41F00A3A;
	Tue, 26 May 2026 08:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779785246;
	bh=oXZDe2HD4PFCzhVKiGOwCFw4izD60puGS18pY29Fm8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TWSE398brq52YA4Y9SxBzNWcScByBrVURjhNMUjePuzIkeYknHzx3Yo/btnzo/i+L
	 t9hwEz48RUtyws4+0mKFqrc/KXZcCRO/W6dfZFP9W44fZaTipRQ3/Roq+vaz+nyGoH
	 4LzhII/PWwbMW9r3ZkgsopAZYGOyVa+g5fij3UAXHgskDLm+F/vpgCTsM8ndnyj5xc
	 vfb6JAmQ1zp5cOR5vLLL86o89WOLaHq9Y+2kLmBmpuGiRR7hsxzAAL/goZ2yI1Zm7q
	 uq/7fR7nUzHvi0tqqcGnV57S+zsfpQV6I31Qfnhw+/0nELkclJMkvzzcXk9cu1dS0Q
	 defuPDnAAWd9A==
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
	stable@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH v6 01/18] dmaengine: sh: rz-dmac: Move interrupt request after everything is set up
Date: Tue, 26 May 2026 11:46:53 +0300
Message-ID: <20260526084710.3491480-2-claudiu.beznea@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10898-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1E48E5D2B2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Once the interrupt is requested, the interrupt handler may run immediately.
Since the IRQ handler can access channel->ch_base, which is initialized
only after requesting the IRQ, this may lead to invalid memory access.
Likewise, the IRQ thread may access uninitialized data (the ld_free,
ld_queue, and ld_active lists), which may also lead to issues.

Request the interrupts only after everything is set up. To keep the error
path simpler, use dmam_alloc_coherent() instead of dma_alloc_coherent().

Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v6:
- collected tags

Changes in v5:
- none

Changes in v4:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 88 +++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 55 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 625ff29024de..9f206a33dcc6 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -981,25 +981,6 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 	channel->index = index;
 	channel->mid_rid = -EINVAL;
 
-	/* Request the channel interrupt. */
-	scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
-	irq = platform_get_irq_byname(pdev, pdev_irqname);
-	if (irq < 0)
-		return irq;
-
-	irqname = devm_kasprintf(dmac->dev, GFP_KERNEL, "%s:%u",
-				 dev_name(dmac->dev), index);
-	if (!irqname)
-		return -ENOMEM;
-
-	ret = devm_request_threaded_irq(dmac->dev, irq, rz_dmac_irq_handler,
-					rz_dmac_irq_handler_thread, 0,
-					irqname, channel);
-	if (ret) {
-		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n", irq, ret);
-		return ret;
-	}
-
 	/* Set io base address for each channel */
 	if (index < 8) {
 		channel->ch_base = dmac->base + CHANNEL_0_7_OFFSET +
@@ -1012,9 +993,9 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 	}
 
 	/* Allocate descriptors */
-	lmdesc = dma_alloc_coherent(&pdev->dev,
-				    sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
-				    &channel->lmdesc.base_dma, GFP_KERNEL);
+	lmdesc = dmam_alloc_coherent(&pdev->dev,
+				     sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
+				     &channel->lmdesc.base_dma, GFP_KERNEL);
 	if (!lmdesc) {
 		dev_err(&pdev->dev, "Can't allocate memory (lmdesc)\n");
 		return -ENOMEM;
@@ -1030,7 +1011,24 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 	INIT_LIST_HEAD(&channel->ld_free);
 	INIT_LIST_HEAD(&channel->ld_active);
 
-	return 0;
+	/* Request the channel interrupt. */
+	scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
+	irq = platform_get_irq_byname(pdev, pdev_irqname);
+	if (irq < 0)
+		return irq;
+
+	irqname = devm_kasprintf(dmac->dev, GFP_KERNEL, "%s:%u",
+				 dev_name(dmac->dev), index);
+	if (!irqname)
+		return -ENOMEM;
+
+	ret = devm_request_threaded_irq(dmac->dev, irq, rz_dmac_irq_handler,
+					rz_dmac_irq_handler_thread, 0,
+					irqname, channel);
+	if (ret)
+		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n", irq, ret);
+
+	return ret;
 }
 
 static void rz_dmac_put_device(void *_dev)
@@ -1099,7 +1097,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	const char *irqname = "error";
 	struct dma_device *engine;
 	struct rz_dmac *dmac;
-	int channel_num;
 	int ret;
 	int irq;
 	u8 i;
@@ -1132,18 +1129,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
 			return PTR_ERR(dmac->ext_base);
 	}
 
-	/* Register interrupt handler for error */
-	irq = platform_get_irq_byname_optional(pdev, irqname);
-	if (irq > 0) {
-		ret = devm_request_irq(&pdev->dev, irq, rz_dmac_irq_handler, 0,
-				       irqname, NULL);
-		if (ret) {
-			dev_err(&pdev->dev, "failed to request IRQ %u (%d)\n",
-				irq, ret);
-			return ret;
-		}
-	}
-
 	/* Initialize the channels. */
 	INIT_LIST_HEAD(&dmac->engine.channels);
 
@@ -1169,6 +1154,18 @@ static int rz_dmac_probe(struct platform_device *pdev)
 			goto err;
 	}
 
+	/* Register interrupt handler for error */
+	irq = platform_get_irq_byname_optional(pdev, irqname);
+	if (irq > 0) {
+		ret = devm_request_irq(&pdev->dev, irq, rz_dmac_irq_handler, 0,
+				       irqname, NULL);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to request IRQ %u (%d)\n",
+				irq, ret);
+			goto err;
+		}
+	}
+
 	/* Register the DMAC as a DMA provider for DT. */
 	ret = of_dma_controller_register(pdev->dev.of_node, rz_dmac_of_xlate,
 					 NULL);
@@ -1210,16 +1207,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
 dma_register_err:
 	of_dma_controller_free(pdev->dev.of_node);
 err:
-	channel_num = i ? i - 1 : 0;
-	for (i = 0; i < channel_num; i++) {
-		struct rz_dmac_chan *channel = &dmac->channels[i];
-
-		dma_free_coherent(&pdev->dev,
-				  sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
-				  channel->lmdesc.base,
-				  channel->lmdesc.base_dma);
-	}
-
 	reset_control_assert(dmac->rstc);
 err_pm_runtime_put:
 	pm_runtime_put(&pdev->dev);
@@ -1232,18 +1219,9 @@ static int rz_dmac_probe(struct platform_device *pdev)
 static void rz_dmac_remove(struct platform_device *pdev)
 {
 	struct rz_dmac *dmac = platform_get_drvdata(pdev);
-	unsigned int i;
 
 	dma_async_device_unregister(&dmac->engine);
 	of_dma_controller_free(pdev->dev.of_node);
-	for (i = 0; i < dmac->n_channels; i++) {
-		struct rz_dmac_chan *channel = &dmac->channels[i];
-
-		dma_free_coherent(&pdev->dev,
-				  sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
-				  channel->lmdesc.base,
-				  channel->lmdesc.base_dma);
-	}
 	reset_control_assert(dmac->rstc);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.43.0


