Return-Path: <dmaengine+bounces-949-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9136A848BB0
	for <lists+dmaengine@lfdr.de>; Sun,  4 Feb 2024 08:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E535284F1E
	for <lists+dmaengine@lfdr.de>; Sun,  4 Feb 2024 07:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191E8134A0;
	Sun,  4 Feb 2024 06:59:57 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3194611199;
	Sun,  4 Feb 2024 06:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707029997; cv=none; b=uznueJbESrBXFMs15dyzG+SpwTqUlu4sL9+v3zI9Hl88QexGSNuI/wAUlEsiDkFrqGAMYLfFwhKwSUvcO424hAUe25VgZ4WwqUjLViRA1BDpg9IyaF4efD64g9Xn0fS/YPObegyfyI5X7DMXFdeomqd213obkC8PaoAlKjRas48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707029997; c=relaxed/simple;
	bh=fEiZY2YX2MHJuQp5ijo0Czu63wTrLJQIY2BAuIr7Q3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NtvQHK15IKUpTIP53reCYnCGvNKfrY1Yn/FNG7irtWmaHN3yZ0efkLV+wdQQlyOpTWVsXTd6htMioO4NX8rvnb8vH/G2/aJwbJ+S+WcM4YhCeg8VD58sjl6BA3n1kky163CFlasXWZ/qnI+S60qHXitrAoNV4khcMngisRoPJYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 350CC1F7EE;
	Sun,  4 Feb 2024 06:59:53 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CD541338E;
	Sun,  4 Feb 2024 06:59:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tsDtBOk1v2WMZwAAD6G6ig
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
	Phil Elwell <phil@raspberrypi.com>
Subject: [PATCH 09/12] dmaengine: bcm2835: Add BCM2712 support
Date: Sun,  4 Feb 2024 07:59:37 +0100
Message-ID: <eb48d7f35252c7a2ddeda54fb326210c4bef8f18.1706948717.git.andrea.porta@suse.com>
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
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ****
X-Spam-Score: 4.10
X-Spamd-Result: default: False [4.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RLecjp584x17qehbj331hhfqn7)];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 MID_CONTAINS_FROM(1.00)[];
	 FORGED_SENDER(0.30)[andrea.porta@suse.com,aporta@suse.de];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[cerno.tech,gmail.com,raspberrypi.com];
	 FROM_NEQ_ENVFROM(0.10)[andrea.porta@suse.com,aporta@suse.de];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

From: Phil Elwell <phil@raspberrypi.com>

BCM2712 has 6 40-bit channels - DMA6 to DMA11. Add a new compatible
string to indicate that the current platform is BCM2712.

Signed-off-by: Phil Elwell <phil@raspberrypi.com>
---
 drivers/dma/bcm2835-dma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 1b3f470274b2..548cf7343d83 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -326,6 +326,12 @@ static const struct bcm2835_dma_cfg_data bcm2711_dma_cfg = {
 	.dma_mask = DMA_BIT_MASK(36),
 };
 
+static const struct bcm2835_dma_cfg_data bcm2712_dma_cfg = {
+	.chan_40bit_mask = BIT(6) | BIT(7) | BIT(8) | BIT(9) |
+				 BIT(10) | BIT(11),
+	.dma_mask = DMA_BIT_MASK(40),
+};
+
 static inline size_t bcm2835_dma_max_frame_length(struct bcm2835_chan *c)
 {
 	/* lite and normal channels have different max frame length */
@@ -1250,6 +1256,7 @@ EXPORT_SYMBOL(bcm2711_dma40_memcpy);
 static const struct of_device_id bcm2835_dma_of_match[] = {
 	{ .compatible = "brcm,bcm2835-dma", .data = &bcm2835_dma_cfg },
 	{ .compatible = "brcm,bcm2711-dma", .data = &bcm2711_dma_cfg },
+	{ .compatible = "brcm,bcm2712-dma", .data = &bcm2712_dma_cfg },
 	{},
 };
 MODULE_DEVICE_TABLE(of, bcm2835_dma_of_match);
-- 
2.41.0


