Return-Path: <dmaengine+bounces-7357-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A113C88ACF
	for <lists+dmaengine@lfdr.de>; Wed, 26 Nov 2025 09:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23CFB3A2963
	for <lists+dmaengine@lfdr.de>; Wed, 26 Nov 2025 08:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1215231B10E;
	Wed, 26 Nov 2025 08:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEC1JKJa"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3B031AF2A;
	Wed, 26 Nov 2025 08:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764146167; cv=none; b=ZrTtYrphgm4sAaSJyU/you/G+OzmUq6xXXn976gk/oFmYjKxDgMJUvPUOe04JiAs4oMt6ExfHE/71urMFqdwmEmxAZWUW+PWCcAdPG3lQahLa0QUTOYUzN8ZC/F/SUYGjYlbyQSgiCJHZuq+E/9MaZPpInsmgzRnGfUgifWNtDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764146167; c=relaxed/simple;
	bh=xg86XDj9pRDdo0U6V4j1oVQz4TQKTZ8SIFQx2ZFaDEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g6Z5aIeZRQpqa4X9QMCCyVXM8HZAlH/3PTkWzq+wmWYCRfYfFUP0fqbpDeHVwwxSq+/4HEPAFx5RvMXkJY+VRr2GxFk8oyUGlo20bu9WyBxEfegyHW7PGjHN1y0KxwwPL2JazYFJ5LJ3ssJq83nxwWt2N+TepOODBvoMiLqCxTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEC1JKJa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 804EBC19423;
	Wed, 26 Nov 2025 08:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764146164;
	bh=xg86XDj9pRDdo0U6V4j1oVQz4TQKTZ8SIFQx2ZFaDEE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oEC1JKJacR6ZCpJ8mWBXoQLMQ3hgv0Qlds7bYlriGmSPCSoGAQ/z9/bO/XkFynSik
	 Ulm+pxjCFVULteVv4jx0fVf9LzYB0zXY72Ne5eaSm0KWcOMVH6kKYWvcXGJVvHggF0
	 0See5+YeSx+GP2oCzNeuqrQEovj+2F1d3E1xv484INKHVBww/0BhLS3UssVV2vsF9H
	 j9hmt5jGe/uD/2xk7lya+vB7oV3VeZ6SsvFc1rk3kIhk2IRJmlvS0iEUa6lf0/cpeO
	 nYBwdaFRJNGZv7o+08Vz7z6jPXk7FUpgg0Jo6crp3qrGEeObIKbDoZiYeYtVBPpRNm
	 at6/LPgeLYMtg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71664D10391;
	Wed, 26 Nov 2025 08:36:04 +0000 (UTC)
From: Jean-Michel Hautbois via B4 Relay <devnull+jeanmichel.hautbois.yoseli.org@kernel.org>
Date: Wed, 26 Nov 2025 09:36:06 +0100
Subject: [PATCH v2 5/5] dma: mcf-edma: Fix error handler for all 64 DMA
 channels
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-dma-coldfire-v2-5-5b1e4544d609@yoseli.org>
References: <20251126-dma-coldfire-v2-0-5b1e4544d609@yoseli.org>
In-Reply-To: <20251126-dma-coldfire-v2-0-5b1e4544d609@yoseli.org>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
 Angelo Dureghello <angelo@sysam.it>
Cc: Greg Ungerer <gerg@linux-m68k.org>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-kernel@vger.kernel.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764146162; l=2813;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=vl4xoSP2zo/uChO0eC60aaXD5ndaGWcvFMvKviIm1xU=;
 b=LymQXM4KCzVvv0kmu11h2B4RJ+ha1izOfOtd0vxxxL+XGROu79FCczZRnBubCYOCyRNYJQUUi
 0lebl7db8Y/BSFA/GHXxHopMxdmDgce7MpjluF9wBvCYbojkdJx3udv
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-Endpoint-Received: by B4 Relay for
 jeanmichel.hautbois@yoseli.org/20240925 with auth_id=570
X-Original-From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Reply-To: jeanmichel.hautbois@yoseli.org

From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>

Fix the DMA error interrupt handler to properly handle errors on all
64 channels. The previous implementation had several issues:

1. Returned IRQ_NONE if low channels had no errors, even if high
   channels did
2. Used direct status assignment instead of fsl_edma_err_chan_handler()
   for high channels

Split the error handling into two separate loops for the low (0-31)
and high (32-63) channel groups, using for_each_set_bit() for cleaner
iteration. Both groups now consistently use fsl_edma_err_chan_handler()
for proper error status reporting.

Fixes: e7a3ff92eaf1 ("dmaengine: fsl-edma: add ColdFire mcf5441x edma support")
Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
 drivers/dma/mcf-edma-main.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
index 6353303df957..5bd04faa639c 100644
--- a/drivers/dma/mcf-edma-main.c
+++ b/drivers/dma/mcf-edma-main.c
@@ -12,6 +12,7 @@
 #include "fsl-edma-common.h"
 
 #define EDMA_CHANNELS		64
+#define EDMA_CHANS_PER_REG	(EDMA_CHANNELS / 2)
 #define EDMA_MASK_CH(x)		((x) & GENMASK(5, 0))
 
 static irqreturn_t mcf_edma_tx_handler(int irq, void *dev_id)
@@ -42,33 +43,33 @@ static irqreturn_t mcf_edma_err_handler(int irq, void *dev_id)
 {
 	struct fsl_edma_engine *mcf_edma = dev_id;
 	struct edma_regs *regs = &mcf_edma->regs;
-	unsigned int err, ch;
+	unsigned int ch;
+	unsigned long err;
+	bool handled = false;
 
+	/* Check low 32 channels (0-31) */
 	err = ioread32(regs->errl);
-	if (!err)
-		return IRQ_NONE;
-
-	for (ch = 0; ch < (EDMA_CHANNELS / 2); ch++) {
-		if (err & BIT(ch)) {
+	if (err) {
+		handled = true;
+		for_each_set_bit(ch, &err, EDMA_CHANS_PER_REG) {
 			fsl_edma_disable_request(&mcf_edma->chans[ch]);
 			iowrite8(EDMA_CERR_CERR(ch), regs->cerr);
 			fsl_edma_err_chan_handler(&mcf_edma->chans[ch]);
 		}
 	}
 
+	/* Check high 32 channels (32-63) */
 	err = ioread32(regs->errh);
-	if (!err)
-		return IRQ_NONE;
-
-	for (ch = (EDMA_CHANNELS / 2); ch < EDMA_CHANNELS; ch++) {
-		if (err & (BIT(ch - (EDMA_CHANNELS / 2)))) {
-			fsl_edma_disable_request(&mcf_edma->chans[ch]);
-			iowrite8(EDMA_CERR_CERR(ch), regs->cerr);
-			mcf_edma->chans[ch].status = DMA_ERROR;
+	if (err) {
+		handled = true;
+		for_each_set_bit(ch, &err, EDMA_CHANS_PER_REG) {
+			fsl_edma_disable_request(&mcf_edma->chans[ch + EDMA_CHANS_PER_REG]);
+			iowrite8(EDMA_CERR_CERR(ch + EDMA_CHANS_PER_REG), regs->cerr);
+			fsl_edma_err_chan_handler(&mcf_edma->chans[ch + EDMA_CHANS_PER_REG]);
 		}
 	}
 
-	return IRQ_HANDLED;
+	return handled ? IRQ_HANDLED : IRQ_NONE;
 }
 
 static int mcf_edma_irq_init(struct platform_device *pdev,

-- 
2.39.5



