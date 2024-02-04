Return-Path: <dmaengine+bounces-946-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0606848BA7
	for <lists+dmaengine@lfdr.de>; Sun,  4 Feb 2024 08:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F3651F22E70
	for <lists+dmaengine@lfdr.de>; Sun,  4 Feb 2024 07:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45CB10A25;
	Sun,  4 Feb 2024 06:59:54 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D128C17;
	Sun,  4 Feb 2024 06:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707029994; cv=none; b=mjkgeCA6xlci04n1Hp0UFmjTgniggA+HdHC+A779emJelHv/WoeP2/lSgop7nawV9J0FGBdy+EIDdhVvoYVH+hg6LFiTl2/ZBLnfxR9ttkjEcp0N83EiTNB7neqM4C0EhMAXS6SPqZ4fl49PHglEnslq+mzHnWBEw6BeV7Tjb7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707029994; c=relaxed/simple;
	bh=T0cXZKxURE4YghBQLPnvhURdvp3T10Ujdc6SAFKDpIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3z3fNW8MiLrr/pUZUOWqzXZdVpIcj0fytyTzX1E9/GLprx1y4Uqs9XAg7WXtzWwK1pw4+R8zPh/Rk72tDa1HjnAatyj7Pm0pcPPtSsDPyT/iFKIkmbAjBWvpJzlM2v+I7XrLcfXaW7emBYrL9GuXYFifhU7BL6igwEvA7tAadY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D68081F7F1;
	Sun,  4 Feb 2024 06:59:49 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE0CA1338E;
	Sun,  4 Feb 2024 06:59:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 29hkLOU1v2WCZwAAD6G6ig
	(envelope-from <aporta@suse.de>); Sun, 04 Feb 2024 06:59:49 +0000
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
Subject: [PATCH 04/12] bcm2835-dma: Advertise the full DMA range
Date: Sun,  4 Feb 2024 07:59:32 +0100
Message-ID: <a56a6d24066a64598efe4343090e51e2223475b8.1706948717.git.andrea.porta@suse.com>
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
X-Spam-Level: ******
X-Spamd-Bar: ++++++
Authentication-Results: smtp-out2.suse.de;
	dkim=none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [6.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.997];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 MID_CONTAINS_FROM(1.00)[];
	 FORGED_SENDER(0.30)[andrea.porta@suse.com,aporta@suse.de];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[cerno.tech,gmail.com,raspberrypi.com];
	 FROM_NEQ_ENVFROM(0.10)[andrea.porta@suse.com,aporta@suse.de];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 6.29
X-Rspamd-Queue-Id: D68081F7F1
X-Spam-Flag: NO

From: Phil Elwell <phil@raspberrypi.com>

Unless the DMA mask is set wider than 32 bits, DMA mapping will use a
bounce buffer.

Signed-off-by: Phil Elwell <phil@raspberrypi.com>
---
 drivers/dma/bcm2835-dma.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 36bad198b655..237dcdb8d726 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -39,6 +39,7 @@
 #define BCM2711_DMA_MEMCPY_CHAN 14
 
 struct bcm2835_dma_cfg_data {
+	u64	dma_mask;
 	u32	chan_40bit_mask;
 };
 
@@ -308,10 +309,12 @@ DEFINE_SPINLOCK(memcpy_lock);
 
 static const struct bcm2835_dma_cfg_data bcm2835_dma_cfg = {
 	.chan_40bit_mask = 0,
+	.dma_mask = DMA_BIT_MASK(32),
 };
 
 static const struct bcm2835_dma_cfg_data bcm2711_dma_cfg = {
 	.chan_40bit_mask = BIT(11) | BIT(12) | BIT(13) | BIT(14),
+	.dma_mask = DMA_BIT_MASK(36),
 };
 
 static inline size_t bcm2835_dma_max_frame_length(struct bcm2835_chan *c)
@@ -1263,6 +1266,8 @@ static struct dma_chan *bcm2835_dma_xlate(struct of_phandle_args *spec,
 
 static int bcm2835_dma_probe(struct platform_device *pdev)
 {
+	const struct bcm2835_dma_cfg_data *cfg_data;
+	const struct of_device_id *of_id;
 	struct bcm2835_dmadev *od;
 	struct resource *res;
 	void __iomem *base;
@@ -1272,13 +1277,20 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 	int irq_flags;
 	uint32_t chans_available;
 	char chan_name[BCM2835_DMA_CHAN_NAME_SIZE];
-	const struct of_device_id *of_id;
 	int chan_count, chan_start, chan_end;
 
+	of_id = of_match_node(bcm2835_dma_of_match, pdev->dev.of_node);
+	if (!of_id) {
+		dev_err(&pdev->dev, "Failed to match compatible string\n");
+		return -EINVAL;
+	}
+
+	cfg_data = of_id->data;
+
 	if (!pdev->dev.dma_mask)
 		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
 
-	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	rc = dma_set_mask_and_coherent(&pdev->dev, cfg_data->dma_mask);
 	if (rc) {
 		dev_err(&pdev->dev, "Unable to set DMA mask\n");
 		return rc;
@@ -1342,7 +1354,7 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	od->cfg_data = of_id->data;
+	od->cfg_data = cfg_data;
 
 	/* Request DMA channel mask from device tree */
 	if (of_property_read_u32(pdev->dev.of_node,
-- 
2.41.0


