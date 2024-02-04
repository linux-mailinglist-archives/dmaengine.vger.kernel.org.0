Return-Path: <dmaengine+bounces-951-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7700848BB3
	for <lists+dmaengine@lfdr.de>; Sun,  4 Feb 2024 08:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EFAD1F21AC8
	for <lists+dmaengine@lfdr.de>; Sun,  4 Feb 2024 07:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9AF13FFC;
	Sun,  4 Feb 2024 06:59:58 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A4A125B2;
	Sun,  4 Feb 2024 06:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707029997; cv=none; b=jk5OgxJpmmFKwNd57KmY3+VrCs08YXwM3xuhuZClNOhfrnbgeW+rBezRTCXGGZ8YlA1dsvsy0IDm3lNGPBhttShQKg6BoClrGsSQPkFSCiZ3bqRwMRjrwXOKeKkE6XyWbrL0BmulGl3UGua65Hip9ZHluetSqad6pMgGYkocy/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707029997; c=relaxed/simple;
	bh=56+EYnhTzYCX4V42OfpniywmQllqA5fZMDMWcPIdodA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qIfIcj0w9du4mBz+BbFMHjyppo0PSVfs5LoSkLbqCSpoZTpW63TgDCiGL15GRZio+Ug/wIq7geF8H4dS0HSxiIfsofmt0Mdfc+moZnOPQTBePKD6DRzNX2+UE2852PqtGMRI0sCtzIkdTprmM1oXTdNPIREaeL5eXoAJbrVYxnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7E72921D16;
	Sun,  4 Feb 2024 06:59:54 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66FA61338E;
	Sun,  4 Feb 2024 06:59:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wgoUF+o1v2WUZwAAD6G6ig
	(envelope-from <aporta@suse.de>); Sun, 04 Feb 2024 06:59:54 +0000
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
	Phil Elwell <phil@raspberrypi.com>
Subject: [PATCH 11/12] dmaengine: bcm2835: Rename to_bcm2711_cbaddr to to_40bit_cbaddr
Date: Sun,  4 Feb 2024 07:59:39 +0100
Message-ID: <a6e1aee2e719745ead7402684df4ab0fd840cc07.1706948717.git.andrea.porta@suse.com>
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
	dkim=none
X-Spamd-Result: default: False [7.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLckep3cwzuj8o9t5iepipyqkk)];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 MID_CONTAINS_FROM(1.00)[];
	 FORGED_SENDER(0.30)[andrea.porta@suse.com,aporta@suse.de];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[cerno.tech,gmail.com,raspberrypi.com];
	 FROM_NEQ_ENVFROM(0.10)[andrea.porta@suse.com,aporta@suse.de];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 7.49
X-Rspamd-Queue-Id: 7E72921D16
X-Spam-Level: *******
X-Spam-Flag: NO
X-Spamd-Bar: +++++++

From: Dom Cobley <popcornmix@gmail.com>

As the shifted address also applies to bcm2712,
give the function a more specific name.

Signed-off-by: Dom Cobley <popcornmix@gmail.com>
---
 drivers/dma/bcm2835-dma.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 055c558caa0e..40df0a165992 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -386,7 +386,7 @@ static inline uint32_t to_bcm2711_dsti(uint32_t info)
 	       BCM2711_DMA40_BURST_LEN(BCM2835_DMA_GET_BURST_LENGTH(info));
 }
 
-static inline uint32_t to_bcm2711_cbaddr(dma_addr_t addr)
+static inline uint32_t to_40bit_cbaddr(dma_addr_t addr)
 {
 	WARN_ON_ONCE(addr & 0x1f);
 	return (addr >> 5);
@@ -573,10 +573,10 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 		if (frame && c->is_40bit_channel)
 			((struct bcm2711_dma40_scb *)
 			 d->cb_list[frame - 1].cb)->next_cb =
-				to_bcm2711_cbaddr(cb_entry->paddr);
+				to_40bit_cbaddr(cb_entry->paddr);
 		if (frame && !c->is_40bit_channel)
 			d->cb_list[frame - 1].cb->next = c->is_2712 ?
-			to_bcm2711_cbaddr(cb_entry->paddr) : cb_entry->paddr;
+			to_40bit_cbaddr(cb_entry->paddr) : cb_entry->paddr;
 
 		/* update src and dst and length */
 		if (src && (info & BCM2835_DMA_S_INC)) {
@@ -751,14 +751,14 @@ static void bcm2835_dma_start_desc(struct bcm2835_chan *c)
 	c->desc = d = to_bcm2835_dma_desc(&vd->tx);
 
 	if (c->is_40bit_channel) {
-		writel(to_bcm2711_cbaddr(d->cb_list[0].paddr),
+		writel(to_40bit_cbaddr(d->cb_list[0].paddr),
 		       c->chan_base + BCM2711_DMA40_CB);
 		writel(BCM2711_DMA40_ACTIVE | BCM2711_DMA40_PROT | BCM2711_DMA40_CS_FLAGS(c->dreq),
 		       c->chan_base + BCM2711_DMA40_CS);
 	} else {
 		writel(BIT(31), c->chan_base + BCM2835_DMA_CS);
 
-		writel(c->is_2712 ? to_bcm2711_cbaddr(d->cb_list[0].paddr) : d->cb_list[0].paddr,
+		writel(c->is_2712 ? to_40bit_cbaddr(d->cb_list[0].paddr) : d->cb_list[0].paddr,
 		       c->chan_base + BCM2835_DMA_ADDR);
 		writel(BCM2835_DMA_ACTIVE | BCM2835_DMA_CS_FLAGS(c->dreq),
 		       c->chan_base + BCM2835_DMA_CS);
@@ -1126,10 +1126,10 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 	if (c->is_40bit_channel)
 		((struct bcm2711_dma40_scb *)
 		 d->cb_list[frames - 1].cb)->next_cb =
-			to_bcm2711_cbaddr(d->cb_list[0].paddr);
+			to_40bit_cbaddr(d->cb_list[0].paddr);
 	else
 		d->cb_list[d->frames - 1].cb->next = c->is_2712 ?
-		to_bcm2711_cbaddr(d->cb_list[0].paddr) : d->cb_list[0].paddr;
+		to_40bit_cbaddr(d->cb_list[0].paddr) : d->cb_list[0].paddr;
 
 	return vchan_tx_prep(&c->vc, &d->vd, flags);
 }
@@ -1251,7 +1251,7 @@ void bcm2711_dma40_memcpy(dma_addr_t dst, dma_addr_t src, size_t size)
 	scb->len = size;
 	scb->next_cb = 0;
 
-	writel(to_bcm2711_cbaddr(memcpy_scb_dma), memcpy_chan + BCM2711_DMA40_CB);
+	writel(to_40bit_cbaddr(memcpy_scb_dma), memcpy_chan + BCM2711_DMA40_CB);
 	writel(BCM2711_DMA40_MEMCPY_FLAGS | BCM2711_DMA40_ACTIVE | BCM2711_DMA40_PROT,
 	       memcpy_chan + BCM2711_DMA40_CS);
 
-- 
2.41.0


