Return-Path: <dmaengine+bounces-952-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D1C848BB6
	for <lists+dmaengine@lfdr.de>; Sun,  4 Feb 2024 08:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 675A21C214E7
	for <lists+dmaengine@lfdr.de>; Sun,  4 Feb 2024 07:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7BA14286;
	Sun,  4 Feb 2024 06:59:58 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C16F12B7C;
	Sun,  4 Feb 2024 06:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707029998; cv=none; b=GFYr1/iVbeZrEgzRizxikGlKb7ZzbKku6AoLjCdajEpeo8eeSTYA/Ge3HOIJgyY9PaMdCmzIB4bDDDZXS0lvO0Tz5ICokM5UULrAwHAxTJ9q4o2p7xwbeR0U6C8P7ov5xvnadOGi1KEa1Z/juvdpoU8DZzUki2qraY1lnrQxwoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707029998; c=relaxed/simple;
	bh=020N7Gb9gRsLhm34iARADqQ4O0GxTTu4o0v7s15PXOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gvYh58OLFA71Wj2JcXJeqE3qmOH5vGFVRFosVtqX/KxEYlBsyvsFhgduUq4JrenY81poGGoeK6wiDsQloTolKRs8zDvYFwP2uUeUPDoCJsArRm0CxYg+BbPeuZgU7ERJVcmbSe7i7g0nzwK/jxdOinDV9+QN9QJSjAnU8yhWPqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3240921DF4;
	Sun,  4 Feb 2024 06:59:55 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 190AB1338E;
	Sun,  4 Feb 2024 06:59:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ojjIA+s1v2WWZwAAD6G6ig
	(envelope-from <aporta@suse.de>); Sun, 04 Feb 2024 06:59:55 +0000
From: Andrea della Porta <andrea.porta@suse.com>
To: Vinod Koul <vkoul@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	dmaengine@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Maxime Ripard <maxime@cerno.tech>,
	Dom Cobley <popcornmix@gmail.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH 12/12] bcm2835-dma: Fixes for dma_abort
Date: Sun,  4 Feb 2024 07:59:40 +0100
Message-ID: <3d0dcc017339f7a78cd9840103db75f5be4034c6.1706948717.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1706948717.git.andrea.porta@suse.com>
References: <cover.1706948717.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3240921DF4
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

From: Dom Cobley <popcornmix@gmail.com>

There is a problem with the current abort scheme
when dma is blocked on a DREQ which prevents halting.

This is triggered by SPI driver which aborts dma
in this state and so leads to a halt timeout.

Discussion with Broadcom suggests the sequence:

CS.ACTIVE=0
while (CS.OUTSTANDING_TRANSACTIONS == 0)
  wait()
DEBUG.RESET=1

should be safe on a dma40 channel.

Unfortunately the non-dma40 channels don't have
OUTSTANDING_TRANSACTIONS, so we need a more
complicated scheme.

We attempt to abort the channel, which will work
if there is no blocked DREQ.

It it times out, we can assume there is no AXI
transfer in progress and reset anyway.

The length of the timeout is observed at ~20us.

Signed-off-by: Dom Cobley <popcornmix@gmail.com>
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 drivers/dma/bcm2835-dma.c | 72 +++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 33 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 40df0a165992..5751d1c6ff94 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -245,6 +245,7 @@ struct bcm2835_desc {
 #define BCM2711_DMA40_ERR		BIT(10)
 #define BCM2711_DMA40_QOS(x)		(((x) & 0x1f) << 16)
 #define BCM2711_DMA40_PANIC_QOS(x)	(((x) & 0x1f) << 20)
+#define BCM2711_DMA40_TRANSACTIONS	BIT(25)
 #define BCM2711_DMA40_WAIT_FOR_WRITES	BIT(28)
 #define BCM2711_DMA40_DISDEBUG		BIT(29)
 #define BCM2711_DMA40_ABORT		BIT(30)
@@ -671,30 +672,37 @@ static void bcm2835_dma_fill_cb_chain_with_sg(
 static void bcm2835_dma_abort(struct bcm2835_chan *c)
 {
 	void __iomem *chan_base = c->chan_base;
-	long int timeout = 10000;
-
-	/*
-	 * A zero control block address means the channel is idle.
-	 * (The ACTIVE flag in the CS register is not a reliable indicator.)
-	 */
-	if (!readl(chan_base + BCM2835_DMA_ADDR))
-		return;
+	long timeout = 100;
 
 	if (c->is_40bit_channel) {
-		/* Halt the current DMA */
-		writel(readl(chan_base + BCM2711_DMA40_CS) | BCM2711_DMA40_HALT,
+		/*
+		 * A zero control block address means the channel is idle.
+		 * (The ACTIVE flag in the CS register is not a reliable indicator.)
+		 */
+		if (!readl(chan_base + BCM2711_DMA40_CB))
+			return;
+
+		/* Pause the current DMA */
+		writel(readl(chan_base + BCM2711_DMA40_CS) & ~BCM2711_DMA40_ACTIVE,
 		       chan_base + BCM2711_DMA40_CS);
 
-		while ((readl(chan_base + BCM2711_DMA40_CS) & BCM2711_DMA40_HALT) && --timeout)
+		/* wait for outstanding transactions to complete */
+		while ((readl(chan_base + BCM2711_DMA40_CS) & BCM2711_DMA40_TRANSACTIONS) &&
+		       --timeout)
 			cpu_relax();
 
-		/* Peripheral might be stuck and fail to halt */
+		/* Peripheral might be stuck and fail to complete */
 		if (!timeout)
 			dev_err(c->vc.chan.device->dev,
-				"failed to halt dma\n");
+				"failed to complete pause on dma %d (CS:%08x)\n", c->ch,
+				readl(chan_base + BCM2711_DMA40_CS));
 
+		/* Set CS back to default state */
 		writel(BCM2711_DMA40_PROT, chan_base + BCM2711_DMA40_CS);
-		writel(0, chan_base + BCM2711_DMA40_CB);
+
+		/* Reset the DMA */
+		writel(readl(chan_base + BCM2711_DMA40_DEBUG) | BCM2711_DMA40_DEBUG_RESET,
+		       chan_base + BCM2711_DMA40_DEBUG);
 	} else {
 		/*
 		 * A zero control block address means the channel is idle.
@@ -703,20 +711,6 @@ static void bcm2835_dma_abort(struct bcm2835_chan *c)
 		if (!readl(chan_base + BCM2835_DMA_ADDR))
 			return;
 
-		/* Write 0 to the active bit - Pause the DMA */
-		writel(readl(chan_base + BCM2835_DMA_CS) & ~BCM2835_DMA_ACTIVE,
-		       chan_base + BCM2835_DMA_CS);
-
-		/* wait for DMA to be paused */
-		while ((readl(chan_base + BCM2835_DMA_CS) & BCM2835_DMA_WAITING_FOR_WRITES) &&
-		       --timeout)
-			cpu_relax();
-
-		/* Peripheral might be stuck and fail to signal AXI write responses */
-		if (!timeout)
-			dev_err(c->vc.chan.device->dev,
-				"failed to pause dma\n");
-
 		/* We need to clear the next DMA block pending */
 		writel(0, chan_base + BCM2835_DMA_NEXTCB);
 
@@ -724,15 +718,27 @@ static void bcm2835_dma_abort(struct bcm2835_chan *c)
 		writel(readl(chan_base + BCM2835_DMA_CS) | BCM2835_DMA_ABORT | BCM2835_DMA_ACTIVE,
 		       chan_base + BCM2835_DMA_CS);
 
-		/* wait for DMA to have been aborted */
-		timeout = 10000;
+		/* wait for DMA to be aborted */
 		while ((readl(chan_base + BCM2835_DMA_CS) & BCM2835_DMA_ABORT) && --timeout)
 			cpu_relax();
 
-		/* Peripheral might be stuck and fail to signal AXI write responses */
-		if (!timeout)
+		/* Write 0 to the active bit - Pause the DMA */
+		writel(readl(chan_base + BCM2835_DMA_CS) & ~BCM2835_DMA_ACTIVE,
+		       chan_base + BCM2835_DMA_CS);
+
+		/*
+		 * Peripheral might be stuck and fail to complete
+		 * This is expected when dreqs are enabled but not asserted
+		 * so only report error in non dreq case
+		 */
+		if (!timeout && !(readl(chan_base + BCM2835_DMA_TI) &
+		   (BCM2835_DMA_S_DREQ | BCM2835_DMA_D_DREQ)))
 			dev_err(c->vc.chan.device->dev,
-				"failed to abort dma\n");
+				"failed to complete pause on dma %d (CS:%08x)\n", c->ch,
+				readl(chan_base + BCM2835_DMA_CS));
+
+		/* Set CS back to default state and reset the DMA */
+		writel(BCM2835_DMA_RESET, chan_base + BCM2835_DMA_CS);
 	}
 }
 
-- 
2.41.0


