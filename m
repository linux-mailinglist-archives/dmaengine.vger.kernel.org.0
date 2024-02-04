Return-Path: <dmaengine+bounces-950-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325D2848BB2
	for <lists+dmaengine@lfdr.de>; Sun,  4 Feb 2024 08:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 647411C214B2
	for <lists+dmaengine@lfdr.de>; Sun,  4 Feb 2024 07:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9747C134DB;
	Sun,  4 Feb 2024 06:59:57 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADEF11711;
	Sun,  4 Feb 2024 06:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707029997; cv=none; b=uuG3FqtGzsEWLnoJbXNURNib/aECGvEcjr1DYahhgeCcE82Px3hD/8kcKfsDx4PqBGR2Mdk8zDRWsLSp9G0ba1aX75twJnVaifptliS6fVQEJNvpX5SP+6zrJUijAhmWp+7tTwlR/iy+diubqXwHGE6nW2wE6ag7wHNbZS7Q2CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707029997; c=relaxed/simple;
	bh=wR9KQckiXJ/6mdUyoKxOkZza7vkEBB1pPReU3rZrC24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKzPtFV8SZVCNIy5Kw3rUWQaMY4FI9pJD3SXwzfHLfVhEm6p3dAStK3BwyAsAX3ylI4thELG1vrg7UAWKpU1EH7qN8A363bO5r9u7c4HIIKxX9SzS0OocHwXdlZsy/2yQXbLlqzHKD1HUZNnJ+VJ+WN2NH1lZpRIndI/RCfSSNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D959B220B1;
	Sun,  4 Feb 2024 06:59:53 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C12131338E;
	Sun,  4 Feb 2024 06:59:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2G4SLek1v2WOZwAAD6G6ig
	(envelope-from <aporta@suse.de>); Sun, 04 Feb 2024 06:59:53 +0000
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
Subject: [PATCH 10/12] dmaengine: bcm2835: Support DMA-Lite channels
Date: Sun,  4 Feb 2024 07:59:38 +0100
Message-ID: <ca956587595954525fca0b635a66ca78b7000bf4.1706948717.git.andrea.porta@suse.com>
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

From: Maxime Ripard <maxime@cerno.tech>

The BCM2712 has a DMA-Lite controller that is basically a BCM2835-style
DMA controller that supports 40 bits DMA addresses.

We need it for HDMI audio to work.

Cc: Maxime Ripard <maxime@cerno.tech>
Cc: Dom Cobley <popcornmix@gmail.com>
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 drivers/dma/bcm2835-dma.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 548cf7343d83..055c558caa0e 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -100,6 +100,7 @@ struct bcm2835_chan {
 
 	bool is_lite_channel;
 	bool is_40bit_channel;
+	bool is_2712;
 };
 
 struct bcm2835_desc {
@@ -545,7 +546,11 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 			control_block->info = info;
 			control_block->src = src;
 			control_block->dst = dst;
-			control_block->stride = 0;
+			if (c->is_2712)
+				control_block->stride = (upper_32_bits(dst) << 8) |
+							upper_32_bits(src);
+			else
+				control_block->stride = 0;
 			control_block->next = 0;
 		}
 
@@ -570,7 +575,8 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 			 d->cb_list[frame - 1].cb)->next_cb =
 				to_bcm2711_cbaddr(cb_entry->paddr);
 		if (frame && !c->is_40bit_channel)
-			d->cb_list[frame - 1].cb->next = cb_entry->paddr;
+			d->cb_list[frame - 1].cb->next = c->is_2712 ?
+			to_bcm2711_cbaddr(cb_entry->paddr) : cb_entry->paddr;
 
 		/* update src and dst and length */
 		if (src && (info & BCM2835_DMA_S_INC)) {
@@ -750,7 +756,10 @@ static void bcm2835_dma_start_desc(struct bcm2835_chan *c)
 		writel(BCM2711_DMA40_ACTIVE | BCM2711_DMA40_PROT | BCM2711_DMA40_CS_FLAGS(c->dreq),
 		       c->chan_base + BCM2711_DMA40_CS);
 	} else {
-		writel(d->cb_list[0].paddr, c->chan_base + BCM2835_DMA_ADDR);
+		writel(BIT(31), c->chan_base + BCM2835_DMA_CS);
+
+		writel(c->is_2712 ? to_bcm2711_cbaddr(d->cb_list[0].paddr) : d->cb_list[0].paddr,
+		       c->chan_base + BCM2835_DMA_ADDR);
 		writel(BCM2835_DMA_ACTIVE | BCM2835_DMA_CS_FLAGS(c->dreq),
 		       c->chan_base + BCM2835_DMA_CS);
 	}
@@ -1119,7 +1128,8 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 		 d->cb_list[frames - 1].cb)->next_cb =
 			to_bcm2711_cbaddr(d->cb_list[0].paddr);
 	else
-		d->cb_list[d->frames - 1].cb->next = d->cb_list[0].paddr;
+		d->cb_list[d->frames - 1].cb->next = c->is_2712 ?
+		to_bcm2711_cbaddr(d->cb_list[0].paddr) : d->cb_list[0].paddr;
 
 	return vchan_tx_prep(&c->vc, &d->vd, flags);
 }
@@ -1186,6 +1196,8 @@ static int bcm2835_dma_chan_init(struct bcm2835_dmadev *d, int chan_id,
 	else if (readl(c->chan_base + BCM2835_DMA_DEBUG) &
 		 BCM2835_DMA_DEBUG_LITE)
 		c->is_lite_channel = true;
+	if (d->cfg_data->dma_mask == DMA_BIT_MASK(40))
+		c->is_2712 = true;
 
 	return 0;
 }
-- 
2.41.0


