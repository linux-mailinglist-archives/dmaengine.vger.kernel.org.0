Return-Path: <dmaengine+bounces-941-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26885848B9F
	for <lists+dmaengine@lfdr.de>; Sun,  4 Feb 2024 08:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E88EB21DD7
	for <lists+dmaengine@lfdr.de>; Sun,  4 Feb 2024 07:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A718BFC;
	Sun,  4 Feb 2024 06:59:51 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9A479C2;
	Sun,  4 Feb 2024 06:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707029991; cv=none; b=AxVa73+1flqkrLX3G9goOuq6/WrxKwBo/QvU7GaZ79eFK0WjDfBs3GZJHn1hjhIY/qmFAcytpcHCVO0lGK5b3G4RKi1TulovMKoSfStCOOiHfEBHpZRFRB0MCXwJdufmdCCqAe5jn1ewiAI9SUr7g9R7UE1pn23ZN/bcePXImJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707029991; c=relaxed/simple;
	bh=RLYgg5uhQAylhts/gCnRLQvxBY4oj1aNfe4bZ1vMoX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jmRbqLgi78ll+o/WQ7RShSue9zYAN5WbeswnsOVMOBvpoi8iFALGC06lzWYOAtdWmOuSuKIIk1AWVlWFWBl4PrvLL//GpwmkKPM8yRQg6svIQVbMY9tkAHfZNrCEYM2A80wsu8QVWBFNKqhguRG0YeKqG5mLIOPWPZLAHlBZnGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D8B0722083;
	Sun,  4 Feb 2024 06:59:47 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFF061338E;
	Sun,  4 Feb 2024 06:59:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MJ63LOM1v2V7ZwAAD6G6ig
	(envelope-from <aporta@suse.de>); Sun, 04 Feb 2024 06:59:47 +0000
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
	Phil Elwell <phil@raspberrypi.org>,
	Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH 01/12] bcm2835-dma: Add support for per-channel flags
Date: Sun,  4 Feb 2024 07:59:29 +0100
Message-ID: <ca23b0dcaa1b5f70ff5f0a9bef4ed0a6ea014a48.1706948717.git.andrea.porta@suse.com>
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
X-Spamd-Result: default: False [2.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_TLS_ALL(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLecjp584x17qehbj331hhfqn7)];
	 RCVD_COUNT_THREE(0.00)[3];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FORGED_SENDER(0.30)[andrea.porta@suse.com,aporta@suse.de];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[cerno.tech,gmail.com,raspberrypi.com,raspberrypi.org,suse.com];
	 FROM_NEQ_ENVFROM(0.10)[andrea.porta@suse.com,aporta@suse.de];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: **
X-Spam-Score: 2.80
X-Spam-Flag: NO

From: Phil Elwell <phil@raspberrypi.org>

Add the ability to interpret the high bits of the dreq specifier as
flags to be included in the DMA_CS register. The motivation for this
change is the ability to set the DISDEBUG flag for SD card transfers
to avoid corruption when using the VPU debugger.

Signed-off-by: Phil Elwell <phil@raspberrypi.org>
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 drivers/dma/bcm2835-dma.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 9d74fe97452e..2704e2578e23 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -137,6 +137,10 @@ struct bcm2835_desc {
 #define BCM2835_DMA_S_DREQ	BIT(10) /* enable SREQ for source */
 #define BCM2835_DMA_S_IGNORE	BIT(11) /* ignore source reads - read 0 */
 #define BCM2835_DMA_BURST_LENGTH(x) ((x & 15) << 12)
+#define BCM2835_DMA_CS_FLAGS(x) ((x) & (BCM2835_DMA_PRIORITY(15) | \
+				      BCM2835_DMA_PANIC_PRIORITY(15) | \
+				      BCM2835_DMA_WAIT_FOR_WRITES | \
+				      BCM2835_DMA_DIS_DEBUG))
 #define BCM2835_DMA_PER_MAP(x)	((x & 31) << 16) /* REQ source */
 #define BCM2835_DMA_WAIT(x)	((x & 31) << 21) /* add DMA-wait cycles */
 #define BCM2835_DMA_NO_WIDE_BURSTS BIT(26) /* no 2 beat write bursts */
@@ -450,7 +454,8 @@ static void bcm2835_dma_start_desc(struct bcm2835_chan *c)
 	c->desc = d = to_bcm2835_dma_desc(&vd->tx);
 
 	writel(d->cb_list[0].paddr, c->chan_base + BCM2835_DMA_ADDR);
-	writel(BCM2835_DMA_ACTIVE, c->chan_base + BCM2835_DMA_CS);
+	writel(BCM2835_DMA_ACTIVE | BCM2835_DMA_CS_FLAGS(c->dreq),
+	       c->chan_base + BCM2835_DMA_CS);
 }
 
 static irqreturn_t bcm2835_dma_callback(int irq, void *data)
@@ -477,7 +482,8 @@ static irqreturn_t bcm2835_dma_callback(int irq, void *data)
 	 * if this IRQ handler is threaded.) If the channel is finished, it
 	 * will remain idle despite the ACTIVE flag being set.
 	 */
-	writel(BCM2835_DMA_INT | BCM2835_DMA_ACTIVE,
+	writel(BCM2835_DMA_INT | BCM2835_DMA_ACTIVE |
+	       BCM2835_DMA_CS_FLAGS(c->dreq),
 	       c->chan_base + BCM2835_DMA_CS);
 
 	d = c->desc;
-- 
2.41.0


