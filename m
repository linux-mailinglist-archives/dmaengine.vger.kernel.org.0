Return-Path: <dmaengine+bounces-944-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E19C848BA4
	for <lists+dmaengine@lfdr.de>; Sun,  4 Feb 2024 08:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B821C2118E
	for <lists+dmaengine@lfdr.de>; Sun,  4 Feb 2024 07:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD3DD310;
	Sun,  4 Feb 2024 06:59:54 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462F1B657;
	Sun,  4 Feb 2024 06:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707029994; cv=none; b=ZDpf3RjUm2SPp4NQDihuwvwEvSHEHIZaL/AkB5xxOJmhgyIhP6sQevUbcrNq9rIIMI5DtJzQhjdHfKCZFaktGKTrsWCfLl18q2P/S3sw+Q3eb0kE5zxp/AbrDdW4Fhdxbpywxj53//AcFprLtp69Jnwxv0AJ9pZqdmQ/AWcOpY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707029994; c=relaxed/simple;
	bh=5kh8IMg0n6Kqqa0rKuDttiR7WGh9gumvPfhqew3EzT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4OUbPfIzjLsxGOvhbGhNnCpHAt2iYjiwpGQZ8yI701Ja1rhwohI3j9VMG6YhbNkkOyy83MGvxCU2jzRJiLXoRc4R72bSakXtgdzmGMgFgTLkrI6LISPL/TYGtuXu9duu6woH5GNrWTuUJjzZNfO3TZAglqvaZUTknoPcDsD+0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7BB3A220A5;
	Sun,  4 Feb 2024 06:59:50 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 645071338E;
	Sun,  4 Feb 2024 06:59:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8ZZ8FuY1v2WEZwAAD6G6ig
	(envelope-from <aporta@suse.de>); Sun, 04 Feb 2024 06:59:50 +0000
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
Subject: [PATCH 05/12] bcm2835-dma: Derive slave DMA addresses correctly
Date: Sun,  4 Feb 2024 07:59:33 +0100
Message-ID: <30da53ebdf43b712da790fd2ae0f0040f71762b8.1706948717.git.andrea.porta@suse.com>
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
X-Rspamd-Queue-Id: 7BB3A220A5
X-Spam-Level: *******
X-Spam-Flag: NO
X-Spamd-Bar: +++++++

From: Phil Elwell <phil@raspberrypi.com>

Slave addresses for DMA are meant to be supplied as physical addresses
(contrary to what struct snd_dmaengine_dai_dma_data does). It is up to
the DMA controller driver to perform the translation based on its own
view of the world, as described in Device Tree.

Now that the Pi Device Trees have the correct peripheral mappings,
replace the hacky address munging with phys_to_dma().

Signed-off-by: Phil Elwell <phil@raspberrypi.com>
---
 drivers/dma/bcm2835-dma.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 237dcdb8d726..077812eda609 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -18,6 +18,7 @@
  *	Copyright 2012 Marvell International Ltd.
  */
 #include <linux/dmaengine.h>
+#include <linux/dma-direct.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmapool.h>
 #include <linux/err.h>
@@ -980,22 +981,12 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_slave_sg(
 	if (direction == DMA_DEV_TO_MEM) {
 		if (c->cfg.src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
 			return NULL;
-		src = c->cfg.src_addr;
-		/*
-		 * One would think it ought to be possible to get the physical
-		 * to dma address mapping information from the dma-ranges DT
-		 * property, but I've not found a way yet that doesn't involve
-		 * open-coding the whole thing.
-		 */
-		if (c->is_40bit_channel)
-			src |= 0x400000000ull;
+		src = phys_to_dma(chan->device->dev, c->cfg.src_addr);
 		info |= BCM2835_DMA_S_DREQ | BCM2835_DMA_D_INC;
 	} else {
 		if (c->cfg.dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
 			return NULL;
-		dst = c->cfg.dst_addr;
-		if (c->is_40bit_channel)
-			dst |= 0x400000000ull;
+		dst = phys_to_dma(chan->device->dev, c->cfg.dst_addr);
 		info |= BCM2835_DMA_D_DREQ | BCM2835_DMA_S_INC;
 	}
 
@@ -1064,17 +1055,13 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 	if (direction == DMA_DEV_TO_MEM) {
 		if (c->cfg.src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
 			return NULL;
-		src = c->cfg.src_addr;
-		if (c->is_40bit_channel)
-			src |= 0x400000000ull;
+		src = phys_to_dma(chan->device->dev, c->cfg.src_addr);
 		dst = buf_addr;
 		info |= BCM2835_DMA_S_DREQ | BCM2835_DMA_D_INC;
 	} else {
 		if (c->cfg.dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
 			return NULL;
-		dst = c->cfg.dst_addr;
-		if (c->is_40bit_channel)
-			dst |= 0x400000000ull;
+		dst = phys_to_dma(chan->device->dev, c->cfg.dst_addr);
 		src = buf_addr;
 		info |= BCM2835_DMA_D_DREQ | BCM2835_DMA_S_INC;
 
-- 
2.41.0


