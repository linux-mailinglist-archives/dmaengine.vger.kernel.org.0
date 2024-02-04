Return-Path: <dmaengine+bounces-948-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEFF848BAD
	for <lists+dmaengine@lfdr.de>; Sun,  4 Feb 2024 08:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32BBC1C214A7
	for <lists+dmaengine@lfdr.de>; Sun,  4 Feb 2024 07:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F54212B66;
	Sun,  4 Feb 2024 06:59:56 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44649DDBD;
	Sun,  4 Feb 2024 06:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707029996; cv=none; b=kIChef9ZKMLxh3i1WxYRpfTatBCos32bQoqr8bJXwvhpA9KKojIHDhZ1eIZjOrL823K5uyO8CoU5NsS6oA7mrlKsKhIGaz17oduSkylVj7KJcHwCtTXWByb0+P+DazLaYvD7rQ3BFnD/eXUvq9tcaSY9oA4Uvzyi6CTdQxrf1Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707029996; c=relaxed/simple;
	bh=ZcPciE1A5owLabkIC4nfdTFrxgIGeN/EJixCqoNdbFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjSQZFyNPypLt2o7MDlRC3BqGvVDPiSbSYzyA9NfrHEimkYpMlU+D3l9R3GmU/Txgmpxs4skCgRx3xFuZW1BnsSALvUMXNkrasB/T4eExbNHH683Pn6nJ2C8IJTpPC1d9VKKw+dgPM7tbM8EW49DfGsRpsWEwJps+stlajKoT48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 88BBD220A9;
	Sun,  4 Feb 2024 06:59:52 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D7B71338E;
	Sun,  4 Feb 2024 06:59:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HpxjGOg1v2WKZwAAD6G6ig
	(envelope-from <aporta@suse.de>); Sun, 04 Feb 2024 06:59:52 +0000
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
Subject: [PATCH 08/12] bcm2835-dma: Need to keep PROT bits set in CS on 40bit controller
Date: Sun,  4 Feb 2024 07:59:36 +0100
Message-ID: <98d536c4d9789e176ab83ab3d2257c08f0075bdb.1706948717.git.andrea.porta@suse.com>
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
X-Spamd-Result: default: False [1.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
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
	 RCPT_COUNT_TWELVE(0.00)[13];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FORGED_SENDER(0.30)[andrea.porta@suse.com,aporta@suse.de];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[cerno.tech,gmail.com,raspberrypi.com,suse.com];
	 FROM_NEQ_ENVFROM(0.10)[andrea.porta@suse.com,aporta@suse.de];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: *
X-Spam-Score: 1.30
X-Spam-Flag: NO

From: Dom Cobley <popcornmix@gmail.com>

Resetting them to zero puts DMA channel into secure mode
which makes further accesses impossible

Cc: Dom Cobley <popcornmix@gmail.com>
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 drivers/dma/bcm2835-dma.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index a20700a400a2..1b3f470274b2 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -239,6 +239,8 @@ struct bcm2835_desc {
 #define BCM2711_DMA40_WR_PAUSED		BIT(5)  /* Writing is paused */
 #define BCM2711_DMA40_DREQ_PAUSED	BIT(6)  /* Is paused by DREQ flow control */
 #define BCM2711_DMA40_WAITING_FOR_WRITES BIT(7)  /* Waiting for last write */
+// we always want to run in supervisor mode
+#define BCM2711_DMA40_PROT		(BIT(8) | BIT(9))
 #define BCM2711_DMA40_ERR		BIT(10)
 #define BCM2711_DMA40_QOS(x)		(((x) & 0x1f) << 16)
 #define BCM2711_DMA40_PANIC_QOS(x)	(((x) & 0x1f) << 20)
@@ -246,10 +248,10 @@ struct bcm2835_desc {
 #define BCM2711_DMA40_DISDEBUG		BIT(29)
 #define BCM2711_DMA40_ABORT		BIT(30)
 #define BCM2711_DMA40_HALT		BIT(31)
-#define BCM2711_DMA40_CS_FLAGS(x) ((x) & (BCM2711_DMA40_QOS(15) | \
-					BCM2711_DMA40_PANIC_QOS(15) | \
-					BCM2711_DMA40_WAIT_FOR_WRITES |	\
-					BCM2711_DMA40_DISDEBUG))
+#define BCM2711_DMA40_CS_FLAGS(x)	((x) & (BCM2711_DMA40_QOS(15) | \
+					 BCM2711_DMA40_PANIC_QOS(15) | \
+					 BCM2711_DMA40_WAIT_FOR_WRITES | \
+					 BCM2711_DMA40_DISDEBUG))
 
 /* Transfer information bits */
 #define BCM2711_DMA40_INTEN		BIT(0)
@@ -679,7 +681,7 @@ static void bcm2835_dma_abort(struct bcm2835_chan *c)
 			dev_err(c->vc.chan.device->dev,
 				"failed to halt dma\n");
 
-		writel(0, chan_base + BCM2711_DMA40_CS);
+		writel(BCM2711_DMA40_PROT, chan_base + BCM2711_DMA40_CS);
 		writel(0, chan_base + BCM2711_DMA40_CB);
 	} else {
 		/*
@@ -739,7 +741,7 @@ static void bcm2835_dma_start_desc(struct bcm2835_chan *c)
 	if (c->is_40bit_channel) {
 		writel(to_bcm2711_cbaddr(d->cb_list[0].paddr),
 		       c->chan_base + BCM2711_DMA40_CB);
-		writel(BCM2711_DMA40_ACTIVE | BCM2711_DMA40_CS_FLAGS(c->dreq),
+		writel(BCM2711_DMA40_ACTIVE | BCM2711_DMA40_PROT | BCM2711_DMA40_CS_FLAGS(c->dreq),
 		       c->chan_base + BCM2711_DMA40_CS);
 	} else {
 		writel(d->cb_list[0].paddr, c->chan_base + BCM2835_DMA_ADDR);
@@ -772,8 +774,13 @@ static irqreturn_t bcm2835_dma_callback(int irq, void *data)
 	 * if this IRQ handler is threaded.) If the channel is finished, it
 	 * will remain idle despite the ACTIVE flag being set.
 	 */
-	writel(BCM2835_DMA_INT | BCM2835_DMA_ACTIVE | BCM2835_DMA_CS_FLAGS(c->dreq),
-	       c->chan_base + BCM2835_DMA_CS);
+	if (c->is_40bit_channel)
+		writel(BCM2835_DMA_INT | BCM2711_DMA40_ACTIVE | BCM2711_DMA40_PROT |
+		       BCM2711_DMA40_CS_FLAGS(c->dreq),
+		       c->chan_base + BCM2711_DMA40_CS);
+	else
+		writel(BCM2835_DMA_INT | BCM2835_DMA_ACTIVE | BCM2835_DMA_CS_FLAGS(c->dreq),
+		       c->chan_base + BCM2835_DMA_CS);
 
 	d = c->desc;
 
@@ -1227,14 +1234,14 @@ void bcm2711_dma40_memcpy(dma_addr_t dst, dma_addr_t src, size_t size)
 	scb->next_cb = 0;
 
 	writel(to_bcm2711_cbaddr(memcpy_scb_dma), memcpy_chan + BCM2711_DMA40_CB);
-	writel(BCM2711_DMA40_MEMCPY_FLAGS + BCM2711_DMA40_ACTIVE,
+	writel(BCM2711_DMA40_MEMCPY_FLAGS | BCM2711_DMA40_ACTIVE | BCM2711_DMA40_PROT,
 	       memcpy_chan + BCM2711_DMA40_CS);
 
 	/* Poll for completion */
 	while (!(readl(memcpy_chan + BCM2711_DMA40_CS) & BCM2711_DMA40_END))
 		cpu_relax();
 
-	writel(BCM2711_DMA40_END, memcpy_chan + BCM2711_DMA40_CS);
+	writel(BCM2711_DMA40_END | BCM2711_DMA40_PROT, memcpy_chan + BCM2711_DMA40_CS);
 
 	spin_unlock_irqrestore(&memcpy_lock, flags);
 }
-- 
2.41.0


