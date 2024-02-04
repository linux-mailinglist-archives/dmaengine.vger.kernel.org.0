Return-Path: <dmaengine+bounces-947-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9C5848BAA
	for <lists+dmaengine@lfdr.de>; Sun,  4 Feb 2024 08:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 413CA284ED2
	for <lists+dmaengine@lfdr.de>; Sun,  4 Feb 2024 07:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C78B11701;
	Sun,  4 Feb 2024 06:59:55 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6A0C2C6;
	Sun,  4 Feb 2024 06:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707029995; cv=none; b=KYHMxYX/lxeut0hBNj77tnrBYaeULVrRtSGA+k2FRHi6jAcPAA25WkcV+KD0gdqh0KevjvnIwl1Qm1R2Ki5OJSxTI2k0LZ9u6XBe63M3rBRha6pbSqZvHD4W6+HBUWbo36sRrLzw68HrmAkVZOztm6UJTuaCt5drXGmkCPaeBjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707029995; c=relaxed/simple;
	bh=9OW5lbTgsybuOL7jtGkXXqnABZ3G6uX7yDMsBY+osVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1UqGvqw5sSz/jiXb87alejd9Y/+U3jG3WnQKatxDL88haxIpayKjB+B+dY4Qgav4fQXj9QS74s/2EWhU7yvuf3lDhqqyVk4s3NXjsZshAm/JgKeQSJ9kaS6ORZJKpa3Bg2qYVhGtzlf/Tka4tegp+Mz+jy3lfPR75b1QsmhV/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CFB1A220A6;
	Sun,  4 Feb 2024 06:59:51 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6A711338E;
	Sun,  4 Feb 2024 06:59:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1ft/Kuc1v2WIZwAAD6G6ig
	(envelope-from <aporta@suse.de>); Sun, 04 Feb 2024 06:59:51 +0000
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
Subject: [PATCH 07/12] bcm2835-dma: Support dma flags for multi-beat burst
Date: Sun,  4 Feb 2024 07:59:35 +0100
Message-ID: <570953f9532e2dc46568674d3c1348cdf26488b6.1706948717.git.andrea.porta@suse.com>
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

Add a control bit to enable a multi-beat burst on a DMA.
This improves DMA performance and is required for HDMI audio.

Signed-off-by: Dom Cobley <popcornmix@gmail.com>
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 drivers/dma/bcm2835-dma.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index d8d1f9ba2572..a20700a400a2 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -156,7 +156,8 @@ struct bcm2835_desc {
 #define BCM2835_DMA_S_WIDTH	BIT(9) /* 128bit writes if set */
 #define BCM2835_DMA_S_DREQ	BIT(10) /* enable SREQ for source */
 #define BCM2835_DMA_S_IGNORE	BIT(11) /* ignore source reads - read 0 */
-#define BCM2835_DMA_BURST_LENGTH(x) ((x & 15) << 12)
+#define BCM2835_DMA_BURST_LENGTH(x) (((x) & 15) << 12)
+#define BCM2835_DMA_GET_BURST_LENGTH(x) (((x) >> 12) & 15)
 #define BCM2835_DMA_CS_FLAGS(x) ((x) & (BCM2835_DMA_PRIORITY(15) | \
 				      BCM2835_DMA_PANIC_PRIORITY(15) | \
 				      BCM2835_DMA_WAIT_FOR_WRITES | \
@@ -180,6 +181,11 @@ struct bcm2835_desc {
 #define WIDE_DEST(x) (((x) & BCM2835_DMA_WIDE_DEST) ? \
 		      BCM2835_DMA_D_WIDTH : 0)
 
+/* A fake bit to request that the driver requires multi-beat burst */
+#define BCM2835_DMA_BURST BIT(30)
+#define BURST_LENGTH(x) (((x) & BCM2835_DMA_BURST) ? \
+			 BCM2835_DMA_BURST_LENGTH(3) : 0)
+
 /* debug register bits */
 #define BCM2835_DMA_DEBUG_LAST_NOT_SET_ERR	BIT(0)
 #define BCM2835_DMA_DEBUG_FIFO_ERR		BIT(1)
@@ -282,7 +288,7 @@ struct bcm2835_desc {
 /* the max dma length for different channels */
 #define MAX_DMA40_LEN SZ_1G
 
-#define BCM2711_DMA40_BURST_LEN(x)	((min(x, 16) - 1) << 8)
+#define BCM2711_DMA40_BURST_LEN(x)	(((x) & 15) << 8)
 #define BCM2711_DMA40_INC		BIT(12)
 #define BCM2711_DMA40_SIZE_32		(0 << 13)
 #define BCM2711_DMA40_SIZE_64		(1 << 13)
@@ -359,12 +365,16 @@ static inline uint32_t to_bcm2711_ti(uint32_t info)
 
 static inline uint32_t to_bcm2711_srci(uint32_t info)
 {
-	return ((info & BCM2835_DMA_S_INC) ? BCM2711_DMA40_INC : 0);
+	return ((info & BCM2835_DMA_S_INC) ? BCM2711_DMA40_INC : 0) |
+	       ((info & BCM2835_DMA_S_WIDTH) ? BCM2711_DMA40_SIZE_128 : 0) |
+	       BCM2711_DMA40_BURST_LEN(BCM2835_DMA_GET_BURST_LENGTH(info));
 }
 
 static inline uint32_t to_bcm2711_dsti(uint32_t info)
 {
-	return ((info & BCM2835_DMA_D_INC) ? BCM2711_DMA40_INC : 0);
+	return ((info & BCM2835_DMA_D_INC) ? BCM2711_DMA40_INC : 0) |
+	       ((info & BCM2835_DMA_D_WIDTH) ? BCM2711_DMA40_SIZE_128 : 0) |
+	       BCM2711_DMA40_BURST_LEN(BCM2835_DMA_GET_BURST_LENGTH(info));
 }
 
 static inline uint32_t to_bcm2711_cbaddr(dma_addr_t addr)
@@ -933,7 +943,8 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_memcpy(
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_desc *d;
 	u32 info = BCM2835_DMA_D_INC | BCM2835_DMA_S_INC |
-		   WAIT_RESP(c->dreq) | WIDE_SOURCE(c->dreq) | WIDE_DEST(c->dreq);
+		   WAIT_RESP(c->dreq) | WIDE_SOURCE(c->dreq) |
+		   WIDE_DEST(c->dreq) | BURST_LENGTH(c->dreq);
 	u32 extra = BCM2835_DMA_INT_EN;
 	size_t max_len = bcm2835_dma_max_frame_length(c);
 	size_t frames;
@@ -964,8 +975,8 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_slave_sg(
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_desc *d;
 	dma_addr_t src = 0, dst = 0;
-	u32 info = WAIT_RESP(c->dreq) |
-		   WIDE_SOURCE(c->dreq) | WIDE_DEST(c->dreq);
+	u32 info = WAIT_RESP(c->dreq) | WIDE_SOURCE(c->dreq) |
+		   WIDE_DEST(c->dreq) | BURST_LENGTH(c->dreq);
 	u32 extra = BCM2835_DMA_INT_EN;
 	size_t frames;
 
@@ -1017,7 +1028,8 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_desc *d;
 	dma_addr_t src, dst;
-	u32 info = WAIT_RESP(c->dreq) | WIDE_SOURCE(c->dreq) | WIDE_DEST(c->dreq);
+	u32 info = WAIT_RESP(c->dreq) | WIDE_SOURCE(c->dreq) |
+		   WIDE_DEST(c->dreq) | BURST_LENGTH(c->dreq);
 	u32 extra = 0;
 	size_t max_len = bcm2835_dma_max_frame_length(c);
 	size_t frames;
-- 
2.41.0


