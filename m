Return-Path: <dmaengine+bounces-943-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8542E848BA3
	for <lists+dmaengine@lfdr.de>; Sun,  4 Feb 2024 08:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BADE91F22D26
	for <lists+dmaengine@lfdr.de>; Sun,  4 Feb 2024 07:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A64C2FD;
	Sun,  4 Feb 2024 06:59:53 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B1079D8;
	Sun,  4 Feb 2024 06:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707029993; cv=none; b=Gk7lGT0Orlc4YNbMTu5MLoyykh1D3B+HptZLqKh43bLjw4NSKRNSppk0STKjFo2fnzwLLpy9xk8yY6BInxRTwdCn7EychPdyV3IlGc7sVV7S7VLTioLorzc66XGqqemOrdJMO7iPG1Er5NVdDJy0VJlOxGMbSxz3xTivzlEJNG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707029993; c=relaxed/simple;
	bh=Xyw7gW5U/d8cp7PNT38jd9N6/64VKpaUlMfO3uaqDvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lU+hMzNiZwZJuPsr6DRtPHXk87q3l6dN4dMJHD6AXKu823YBxMXO5rpZ7oO5uDtxGYTpjudQWnR7USLkwdqEMldKq+OsldmXm6bHh5PpXXFPZiB2cyvFt1GMIhBaqPqJ3u5i4pnZzVq5v8zOXiR6nrWNsspiDqz9j4oN5ZSxCO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8E91322094;
	Sun,  4 Feb 2024 06:59:48 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BCF81338E;
	Sun,  4 Feb 2024 06:59:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RYM+GOQ1v2V9ZwAAD6G6ig
	(envelope-from <aporta@suse.de>); Sun, 04 Feb 2024 06:59:48 +0000
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
Subject: [PATCH 02/12] bcm2835-dma: Add proper 40-bit DMA support
Date: Sun,  4 Feb 2024 07:59:30 +0100
Message-ID: <eeb94204c30c2182f5ffd3ec083c04399ecdee32.1706948717.git.andrea.porta@suse.com>
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
X-Spam-Level: 
X-Spam-Score: -1.40
X-Spamd-Result: default: False [-1.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_TLS_ALL(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 BAYES_HAM(-3.00)[99.99%];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RLecjp584x17qehbj331hhfqn7)];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FORGED_SENDER(0.30)[andrea.porta@suse.com,aporta@suse.de];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[cerno.tech,gmail.com,raspberrypi.com,raspberrypi.org,suse.com];
	 FROM_NEQ_ENVFROM(0.10)[andrea.porta@suse.com,aporta@suse.de];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

From: Phil Elwell <phil@raspberrypi.org>

BCM2711 has 4 DMA channels with a 40-bit address range, allowing them
to access the full 4GB of memory on a Pi 4.

Cc: Phil Elwell <phil@raspberrypi.org>
Cc: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 drivers/dma/bcm2835-dma.c | 601 ++++++++++++++++++++++++++++++++------
 1 file changed, 505 insertions(+), 96 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 2704e2578e23..11c6bf7d8a4b 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -36,6 +36,11 @@
 
 #define BCM2835_DMA_MAX_DMA_CHAN_SUPPORTED 14
 #define BCM2835_DMA_CHAN_NAME_SIZE 8
+#define BCM2711_DMA_MEMCPY_CHAN 14
+
+struct bcm2835_dma_cfg_data {
+	u32	chan_40bit_mask;
+};
 
 /**
  * struct bcm2835_dmadev - BCM2835 DMA controller
@@ -48,6 +53,7 @@ struct bcm2835_dmadev {
 	struct dma_device ddev;
 	void __iomem *base;
 	dma_addr_t zero_page;
+	const struct bcm2835_dma_cfg_data *cfg_data;
 };
 
 struct bcm2835_dma_cb {
@@ -60,6 +66,17 @@ struct bcm2835_dma_cb {
 	uint32_t pad[2];
 };
 
+struct bcm2711_dma40_scb {
+	u32 ti;
+	u32 src;
+	u32 srci;
+	u32 dst;
+	u32 dsti;
+	u32 len;
+	u32 next_cb;
+	u32 rsvd;
+};
+
 struct bcm2835_cb_entry {
 	struct bcm2835_dma_cb *cb;
 	dma_addr_t paddr;
@@ -80,6 +97,7 @@ struct bcm2835_chan {
 	unsigned int irq_flags;
 
 	bool is_lite_channel;
+	bool is_40bit_channel;
 };
 
 struct bcm2835_desc {
@@ -169,13 +187,118 @@ struct bcm2835_desc {
 #define BCM2835_DMA_DATA_TYPE_S128	16
 
 /* Valid only for channels 0 - 14, 15 has its own base address */
-#define BCM2835_DMA_CHAN(n)	((n) << 8) /* Base address */
+#define BCM2835_DMA_CHAN_SIZE	0x100
+#define BCM2835_DMA_CHAN(n)	((n) * BCM2835_DMA_CHAN_SIZE) /* Base address */
 #define BCM2835_DMA_CHANIO(base, n) ((base) + BCM2835_DMA_CHAN(n))
 
 /* the max dma length for different channels */
 #define MAX_DMA_LEN SZ_1G
 #define MAX_LITE_DMA_LEN (SZ_64K - 4)
 
+/* 40-bit DMA support */
+#define BCM2711_DMA40_CS	0x00
+#define BCM2711_DMA40_CB	0x04
+#define BCM2711_DMA40_DEBUG	0x0c
+#define BCM2711_DMA40_TI	0x10
+#define BCM2711_DMA40_SRC	0x14
+#define BCM2711_DMA40_SRCI	0x18
+#define BCM2711_DMA40_DEST	0x1c
+#define BCM2711_DMA40_DESTI	0x20
+#define BCM2711_DMA40_LEN	0x24
+#define BCM2711_DMA40_NEXT_CB	0x28
+#define BCM2711_DMA40_DEBUG2	0x2c
+
+#define BCM2711_DMA40_ACTIVE		BIT(0)
+#define BCM2711_DMA40_END		BIT(1)
+#define BCM2711_DMA40_INT		BIT(2)
+#define BCM2711_DMA40_DREQ		BIT(3)  /* DREQ state */
+#define BCM2711_DMA40_RD_PAUSED		BIT(4)  /* Reading is paused */
+#define BCM2711_DMA40_WR_PAUSED		BIT(5)  /* Writing is paused */
+#define BCM2711_DMA40_DREQ_PAUSED	BIT(6)  /* Is paused by DREQ flow control */
+#define BCM2711_DMA40_WAITING_FOR_WRITES BIT(7)  /* Waiting for last write */
+#define BCM2711_DMA40_ERR		BIT(10)
+#define BCM2711_DMA40_QOS(x)		(((x) & 0x1f) << 16)
+#define BCM2711_DMA40_PANIC_QOS(x)	(((x) & 0x1f) << 20)
+#define BCM2711_DMA40_WAIT_FOR_WRITES	BIT(28)
+#define BCM2711_DMA40_DISDEBUG		BIT(29)
+#define BCM2711_DMA40_ABORT		BIT(30)
+#define BCM2711_DMA40_HALT		BIT(31)
+#define BCM2711_DMA40_CS_FLAGS(x) ((x) & (BCM2711_DMA40_QOS(15) | \
+					BCM2711_DMA40_PANIC_QOS(15) | \
+					BCM2711_DMA40_WAIT_FOR_WRITES |	\
+					BCM2711_DMA40_DISDEBUG))
+
+/* Transfer information bits */
+#define BCM2711_DMA40_INTEN		BIT(0)
+#define BCM2711_DMA40_TDMODE		BIT(1) /* 2D-Mode */
+#define BCM2711_DMA40_WAIT_RESP		BIT(2) /* wait for AXI write to be acked */
+#define BCM2711_DMA40_WAIT_RD_RESP	BIT(3) /* wait for AXI read to complete */
+#define BCM2711_DMA40_PER_MAP(x)	(((x) & 31) << 9) /* REQ source */
+#define BCM2711_DMA40_S_DREQ		BIT(14) /* enable SREQ for source */
+#define BCM2711_DMA40_D_DREQ		BIT(15) /* enable DREQ for destination */
+#define BCM2711_DMA40_S_WAIT(x)		(((x) & 0xff) << 16) /* add DMA read-wait cycles */
+#define BCM2711_DMA40_D_WAIT(x)		(((x) & 0xff) << 24) /* add DMA write-wait cycles */
+
+/* debug register bits */
+#define BCM2711_DMA40_DEBUG_WRITE_ERR		BIT(0)
+#define BCM2711_DMA40_DEBUG_FIFO_ERR		BIT(1)
+#define BCM2711_DMA40_DEBUG_READ_ERR		BIT(2)
+#define BCM2711_DMA40_DEBUG_READ_CB_ERR		BIT(3)
+#define BCM2711_DMA40_DEBUG_IN_ON_ERR		BIT(8)
+#define BCM2711_DMA40_DEBUG_ABORT_ON_ERR	BIT(9)
+#define BCM2711_DMA40_DEBUG_HALT_ON_ERR		BIT(10)
+#define BCM2711_DMA40_DEBUG_DISABLE_CLK_GATE	BIT(11)
+#define BCM2711_DMA40_DEBUG_RSTATE_SHIFT	14
+#define BCM2711_DMA40_DEBUG_RSTATE_BITS		4
+#define BCM2711_DMA40_DEBUG_WSTATE_SHIFT	18
+#define BCM2711_DMA40_DEBUG_WSTATE_BITS		4
+#define BCM2711_DMA40_DEBUG_RESET		BIT(23)
+#define BCM2711_DMA40_DEBUG_ID_SHIFT		24
+#define BCM2711_DMA40_DEBUG_ID_BITS		4
+#define BCM2711_DMA40_DEBUG_VERSION_SHIFT	28
+#define BCM2711_DMA40_DEBUG_VERSION_BITS	4
+
+/* Valid only for channels 0 - 3 (11 - 14) */
+#define BCM2711_DMA40_CHAN(n)	(((n) + 11) << 8) /* Base address */
+#define BCM2711_DMA40_CHANIO(base, n) ((base) + BCM2711_DMA_CHAN(n))
+
+/* the max dma length for different channels */
+#define MAX_DMA40_LEN SZ_1G
+
+#define BCM2711_DMA40_BURST_LEN(x)	((min(x, 16) - 1) << 8)
+#define BCM2711_DMA40_INC		BIT(12)
+#define BCM2711_DMA40_SIZE_32		(0 << 13)
+#define BCM2711_DMA40_SIZE_64		(1 << 13)
+#define BCM2711_DMA40_SIZE_128		(2 << 13)
+#define BCM2711_DMA40_SIZE_256		(3 << 13)
+#define BCM2711_DMA40_IGNORE		BIT(15)
+#define BCM2711_DMA40_STRIDE(x)		((x) << 16) /* For 2D mode */
+
+#define BCM2711_DMA40_MEMCPY_FLAGS \
+	(BCM2711_DMA40_QOS(0) | \
+	 BCM2711_DMA40_PANIC_QOS(0) | \
+	 BCM2711_DMA40_WAIT_FOR_WRITES | \
+	 BCM2711_DMA40_DISDEBUG)
+
+#define BCM2711_DMA40_MEMCPY_XFER_INFO \
+	(BCM2711_DMA40_SIZE_128 | \
+	 BCM2711_DMA40_INC | \
+	 BCM2711_DMA40_BURST_LEN(16))
+
+struct bcm2835_dmadev *memcpy_parent;
+static void __iomem *memcpy_chan;
+static struct bcm2711_dma40_scb *memcpy_scb;
+static dma_addr_t memcpy_scb_dma;
+DEFINE_SPINLOCK(memcpy_lock);
+
+static const struct bcm2835_dma_cfg_data bcm2835_dma_cfg = {
+	.chan_40bit_mask = 0,
+};
+
+static const struct bcm2835_dma_cfg_data bcm2711_dma_cfg = {
+	.chan_40bit_mask = BIT(11) | BIT(12) | BIT(13) | BIT(14),
+};
+
 static inline size_t bcm2835_dma_max_frame_length(struct bcm2835_chan *c)
 {
 	/* lite and normal channels have different max frame length */
@@ -205,6 +328,32 @@ static inline struct bcm2835_desc *to_bcm2835_dma_desc(
 	return container_of(t, struct bcm2835_desc, vd.tx);
 }
 
+static inline uint32_t to_bcm2711_ti(uint32_t info)
+{
+	return ((info & BCM2835_DMA_INT_EN) ? BCM2711_DMA40_INTEN : 0) |
+		((info & BCM2835_DMA_WAIT_RESP) ? BCM2711_DMA40_WAIT_RESP : 0) |
+		((info & BCM2835_DMA_S_DREQ) ?
+		 (BCM2711_DMA40_S_DREQ | BCM2711_DMA40_WAIT_RD_RESP) : 0) |
+		((info & BCM2835_DMA_D_DREQ) ? BCM2711_DMA40_D_DREQ : 0) |
+		BCM2711_DMA40_PER_MAP((info >> 16) & 0x1f);
+}
+
+static inline uint32_t to_bcm2711_srci(uint32_t info)
+{
+	return ((info & BCM2835_DMA_S_INC) ? BCM2711_DMA40_INC : 0);
+}
+
+static inline uint32_t to_bcm2711_dsti(uint32_t info)
+{
+	return ((info & BCM2835_DMA_D_INC) ? BCM2711_DMA40_INC : 0);
+}
+
+static inline uint32_t to_bcm2711_cbaddr(dma_addr_t addr)
+{
+	WARN_ON_ONCE(addr & 0x1f);
+	return (addr >> 5);
+}
+
 static void bcm2835_dma_free_cb_chain(struct bcm2835_desc *desc)
 {
 	size_t i;
@@ -223,45 +372,53 @@ static void bcm2835_dma_desc_free(struct virt_dma_desc *vd)
 }
 
 static void bcm2835_dma_create_cb_set_length(
-	struct bcm2835_chan *chan,
+	struct bcm2835_chan *c,
 	struct bcm2835_dma_cb *control_block,
 	size_t len,
 	size_t period_len,
 	size_t *total_len,
 	u32 finalextrainfo)
 {
-	size_t max_len = bcm2835_dma_max_frame_length(chan);
+	size_t max_len = bcm2835_dma_max_frame_length(c);
+	u32 cb_len;
 
 	/* set the length taking lite-channel limitations into account */
-	control_block->length = min_t(u32, len, max_len);
+	cb_len = min_t(u32, len, max_len);
 
-	/* finished if we have no period_length */
-	if (!period_len)
-		return;
+	if (period_len) {
+		/*
+		 * period_len means: that we need to generate
+		 * transfers that are terminating at every
+		 * multiple of period_len - this is typically
+		 * used to set the interrupt flag in info
+		 * which is required during cyclic transfers
+		 */
 
-	/*
-	 * period_len means: that we need to generate
-	 * transfers that are terminating at every
-	 * multiple of period_len - this is typically
-	 * used to set the interrupt flag in info
-	 * which is required during cyclic transfers
-	 */
+		/* have we filled in period_length yet? */
+		if (*total_len + cb_len < period_len) {
+			/* update number of bytes in this period so far */
+			*total_len += cb_len;
+		} else {
+			/* calculate the length that remains to reach period_len */
+			cb_len = period_len - *total_len;
 
-	/* have we filled in period_length yet? */
-	if (*total_len + control_block->length < period_len) {
-		/* update number of bytes in this period so far */
-		*total_len += control_block->length;
-		return;
+			/* reset total_length for next period */
+			*total_len = 0;
+		}
 	}
 
-	/* calculate the length that remains to reach period_length */
-	control_block->length = period_len - *total_len;
-
-	/* reset total_length for next period */
-	*total_len = 0;
+	if (c->is_40bit_channel) {
+		struct bcm2711_dma40_scb *scb =
+			(struct bcm2711_dma40_scb *)control_block;
 
-	/* add extrainfo bits in info */
-	control_block->info |= finalextrainfo;
+		scb->len = cb_len;
+		/* add extrainfo bits to ti */
+		scb->ti |= to_bcm2711_ti(finalextrainfo);
+	} else {
+		control_block->length = cb_len;
+		/* add extrainfo bits to info */
+		control_block->info |= finalextrainfo;
+	}
 }
 
 static inline size_t bcm2835_dma_count_frames_for_sg(
@@ -284,7 +441,7 @@ static inline size_t bcm2835_dma_count_frames_for_sg(
 /**
  * bcm2835_dma_create_cb_chain - create a control block and fills data in
  *
- * @chan:           the @dma_chan for which we run this
+ * @c:              the @bcm2835_chan for which we run this
  * @direction:      the direction in which we transfer
  * @cyclic:         it is a cyclic transfer
  * @info:           the default info bits to apply per controlblock
@@ -302,12 +459,11 @@ static inline size_t bcm2835_dma_count_frames_for_sg(
  * @gfp:            the GFP flag to use for allocation
  */
 static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
-	struct dma_chan *chan, enum dma_transfer_direction direction,
+	struct bcm2835_chan *c, enum dma_transfer_direction direction,
 	bool cyclic, u32 info, u32 finalextrainfo, size_t frames,
 	dma_addr_t src, dma_addr_t dst, size_t buf_len,
 	size_t period_len, gfp_t gfp)
 {
-	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	size_t len = buf_len, total_len;
 	size_t frame;
 	struct bcm2835_desc *d;
@@ -339,11 +495,23 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 
 		/* fill in the control block */
 		control_block = cb_entry->cb;
-		control_block->info = info;
-		control_block->src = src;
-		control_block->dst = dst;
-		control_block->stride = 0;
-		control_block->next = 0;
+		if (c->is_40bit_channel) {
+			struct bcm2711_dma40_scb *scb =
+				(struct bcm2711_dma40_scb *)control_block;
+			scb->ti = to_bcm2711_ti(info);
+			scb->src = lower_32_bits(src);
+			scb->srci = upper_32_bits(src) | to_bcm2711_srci(info);
+			scb->dst = lower_32_bits(dst);
+			scb->dsti = upper_32_bits(dst) | to_bcm2711_dsti(info);
+			scb->next_cb = 0;
+		} else {
+			control_block->info = info;
+			control_block->src = src;
+			control_block->dst = dst;
+			control_block->stride = 0;
+			control_block->next = 0;
+		}
+
 		/* set up length in control_block if requested */
 		if (buf_len) {
 			/* calculate length honoring period_length */
@@ -353,25 +521,51 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 				cyclic ? finalextrainfo : 0);
 
 			/* calculate new remaining length */
-			len -= control_block->length;
+			if (c->is_40bit_channel)
+				len -= ((struct bcm2711_dma40_scb *)control_block)->len;
+			else
+				len -= control_block->length;
 		}
 
 		/* link this the last controlblock */
-		if (frame)
+		if (frame && c->is_40bit_channel)
+			((struct bcm2711_dma40_scb *)
+			 d->cb_list[frame - 1].cb)->next_cb =
+				to_bcm2711_cbaddr(cb_entry->paddr);
+		if (frame && !c->is_40bit_channel)
 			d->cb_list[frame - 1].cb->next = cb_entry->paddr;
 
 		/* update src and dst and length */
-		if (src && (info & BCM2835_DMA_S_INC))
-			src += control_block->length;
-		if (dst && (info & BCM2835_DMA_D_INC))
-			dst += control_block->length;
+		if (src && (info & BCM2835_DMA_S_INC)) {
+			if (c->is_40bit_channel)
+				src += ((struct bcm2711_dma40_scb *)control_block)->len;
+			else
+				src += control_block->length;
+		}
+
+		if (dst && (info & BCM2835_DMA_D_INC)) {
+			if (c->is_40bit_channel)
+				dst += ((struct bcm2711_dma40_scb *)control_block)->len;
+			else
+				dst += control_block->length;
+		}
 
 		/* Length of total transfer */
-		d->size += control_block->length;
+		if (c->is_40bit_channel)
+			d->size += ((struct bcm2711_dma40_scb *)control_block)->len;
+		else
+			d->size += control_block->length;
 	}
 
 	/* the last frame requires extra flags */
-	d->cb_list[d->frames - 1].cb->info |= finalextrainfo;
+	if (c->is_40bit_channel) {
+		struct bcm2711_dma40_scb *scb =
+			(struct bcm2711_dma40_scb *)d->cb_list[d->frames - 1].cb;
+
+		scb->ti |= to_bcm2711_ti(finalextrainfo);
+	} else {
+		d->cb_list[d->frames - 1].cb->info |= finalextrainfo;
+	}
 
 	/* detect a size missmatch */
 	if (buf_len && (d->size != buf_len))
@@ -385,13 +579,12 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 }
 
 static void bcm2835_dma_fill_cb_chain_with_sg(
-	struct dma_chan *chan,
+	struct bcm2835_chan *c,
 	enum dma_transfer_direction direction,
 	struct bcm2835_cb_entry *cb,
 	struct scatterlist *sgl,
 	unsigned int sg_len)
 {
-	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	size_t len, max_len;
 	unsigned int i;
 	dma_addr_t addr;
@@ -399,14 +592,35 @@ static void bcm2835_dma_fill_cb_chain_with_sg(
 
 	max_len = bcm2835_dma_max_frame_length(c);
 	for_each_sg(sgl, sgent, sg_len, i) {
-		for (addr = sg_dma_address(sgent), len = sg_dma_len(sgent);
-		     len > 0;
-		     addr += cb->cb->length, len -= cb->cb->length, cb++) {
-			if (direction == DMA_DEV_TO_MEM)
-				cb->cb->dst = addr;
-			else
-				cb->cb->src = addr;
-			cb->cb->length = min(len, max_len);
+		if (c->is_40bit_channel) {
+			struct bcm2711_dma40_scb *scb;
+
+			for (addr = sg_dma_address(sgent),
+			     len = sg_dma_len(sgent);
+			     len > 0;
+			     addr += scb->len, len -= scb->len, cb++) {
+				scb = (struct bcm2711_dma40_scb *)cb->cb;
+				if (direction == DMA_DEV_TO_MEM) {
+					scb->dst = lower_32_bits(addr);
+					scb->dsti = upper_32_bits(addr) | BCM2711_DMA40_INC;
+				} else {
+					scb->src = lower_32_bits(addr);
+					scb->srci = upper_32_bits(addr) | BCM2711_DMA40_INC;
+				}
+				scb->len = min(len, max_len);
+			}
+		} else {
+			for (addr = sg_dma_address(sgent),
+			     len = sg_dma_len(sgent);
+			     len > 0;
+			     addr += cb->cb->length, len -= cb->cb->length,
+			     cb++) {
+				if (direction == DMA_DEV_TO_MEM)
+					cb->cb->dst = addr;
+				else
+					cb->cb->src = addr;
+				cb->cb->length = min(len, max_len);
+			}
 		}
 	}
 }
@@ -423,20 +637,60 @@ static void bcm2835_dma_abort(struct bcm2835_chan *c)
 	if (!readl(chan_base + BCM2835_DMA_ADDR))
 		return;
 
-	/* Write 0 to the active bit - Pause the DMA */
-	writel(0, chan_base + BCM2835_DMA_CS);
+	if (c->is_40bit_channel) {
+		/* Halt the current DMA */
+		writel(readl(chan_base + BCM2711_DMA40_CS) | BCM2711_DMA40_HALT,
+		       chan_base + BCM2711_DMA40_CS);
 
-	/* Wait for any current AXI transfer to complete */
-	while ((readl(chan_base + BCM2835_DMA_CS) &
-		BCM2835_DMA_WAITING_FOR_WRITES) && --timeout)
-		cpu_relax();
+		while ((readl(chan_base + BCM2711_DMA40_CS) & BCM2711_DMA40_HALT) && --timeout)
+			cpu_relax();
 
-	/* Peripheral might be stuck and fail to signal AXI write responses */
-	if (!timeout)
-		dev_err(c->vc.chan.device->dev,
-			"failed to complete outstanding writes\n");
+		/* Peripheral might be stuck and fail to halt */
+		if (!timeout)
+			dev_err(c->vc.chan.device->dev,
+				"failed to halt dma\n");
 
-	writel(BCM2835_DMA_RESET, chan_base + BCM2835_DMA_CS);
+		writel(0, chan_base + BCM2711_DMA40_CS);
+		writel(0, chan_base + BCM2711_DMA40_CB);
+	} else {
+		/*
+		 * A zero control block address means the channel is idle.
+		 * (The ACTIVE flag in the CS register is not a reliable indicator.)
+		 */
+		if (!readl(chan_base + BCM2835_DMA_ADDR))
+			return;
+
+		/* Write 0 to the active bit - Pause the DMA */
+		writel(readl(chan_base + BCM2835_DMA_CS) & ~BCM2835_DMA_ACTIVE,
+		       chan_base + BCM2835_DMA_CS);
+
+		/* wait for DMA to be paused */
+		while ((readl(chan_base + BCM2835_DMA_CS) & BCM2835_DMA_WAITING_FOR_WRITES) &&
+		       --timeout)
+			cpu_relax();
+
+		/* Peripheral might be stuck and fail to signal AXI write responses */
+		if (!timeout)
+			dev_err(c->vc.chan.device->dev,
+				"failed to pause dma\n");
+
+		/* We need to clear the next DMA block pending */
+		writel(0, chan_base + BCM2835_DMA_NEXTCB);
+
+		/* Abort the DMA, which needs to be enabled to complete */
+		writel(readl(chan_base + BCM2835_DMA_CS) | BCM2835_DMA_ABORT | BCM2835_DMA_ACTIVE,
+		       chan_base + BCM2835_DMA_CS);
+
+		/* wait for DMA to have been aborted */
+		timeout = 10000;
+		while ((readl(chan_base + BCM2835_DMA_CS) & BCM2835_DMA_ABORT) && --timeout)
+			cpu_relax();
+
+		/* Peripheral might be stuck and fail to signal AXI write responses */
+		if (!timeout)
+			dev_err(c->vc.chan.device->dev,
+				"failed to abort dma\n");
+	}
 }
 
 static void bcm2835_dma_start_desc(struct bcm2835_chan *c)
@@ -453,9 +707,16 @@ static void bcm2835_dma_start_desc(struct bcm2835_chan *c)
 
 	c->desc = d = to_bcm2835_dma_desc(&vd->tx);
 
-	writel(d->cb_list[0].paddr, c->chan_base + BCM2835_DMA_ADDR);
-	writel(BCM2835_DMA_ACTIVE | BCM2835_DMA_CS_FLAGS(c->dreq),
-	       c->chan_base + BCM2835_DMA_CS);
+	if (c->is_40bit_channel) {
+		writel(to_bcm2711_cbaddr(d->cb_list[0].paddr),
+		       c->chan_base + BCM2711_DMA40_CB);
+		writel(BCM2711_DMA40_ACTIVE | BCM2711_DMA40_CS_FLAGS(c->dreq),
+		       c->chan_base + BCM2711_DMA40_CS);
+	} else {
+		writel(d->cb_list[0].paddr, c->chan_base + BCM2835_DMA_ADDR);
+		writel(BCM2835_DMA_ACTIVE | BCM2835_DMA_CS_FLAGS(c->dreq),
+		       c->chan_base + BCM2835_DMA_CS);
+	}
 }
 
 static irqreturn_t bcm2835_dma_callback(int irq, void *data)
@@ -482,8 +743,7 @@ static irqreturn_t bcm2835_dma_callback(int irq, void *data)
 	 * if this IRQ handler is threaded.) If the channel is finished, it
 	 * will remain idle despite the ACTIVE flag being set.
 	 */
-	writel(BCM2835_DMA_INT | BCM2835_DMA_ACTIVE |
-	       BCM2835_DMA_CS_FLAGS(c->dreq),
+	writel(BCM2835_DMA_INT | BCM2835_DMA_ACTIVE | BCM2835_DMA_CS_FLAGS(c->dreq),
 	       c->chan_base + BCM2835_DMA_CS);
 
 	d = c->desc;
@@ -546,20 +806,39 @@ static size_t bcm2835_dma_desc_size_pos(struct bcm2835_desc *d, dma_addr_t addr)
 	unsigned int i;
 	size_t size;
 
-	for (size = i = 0; i < d->frames; i++) {
-		struct bcm2835_dma_cb *control_block = d->cb_list[i].cb;
-		size_t this_size = control_block->length;
-		dma_addr_t dma;
+	if (d->c->is_40bit_channel) {
+		for (size = i = 0; i < d->frames; i++) {
+			struct bcm2711_dma40_scb *control_block =
+				(struct bcm2711_dma40_scb *)d->cb_list[i].cb;
+			size_t this_size = control_block->len;
+			dma_addr_t dma;
 
-		if (d->dir == DMA_DEV_TO_MEM)
-			dma = control_block->dst;
-		else
-			dma = control_block->src;
+			if (d->dir == DMA_DEV_TO_MEM)
+				dma = control_block->dst;
+			else
+				dma = control_block->src;
 
-		if (size)
-			size += this_size;
-		else if (addr >= dma && addr < dma + this_size)
-			size += dma + this_size - addr;
+			if (size)
+				size += this_size;
+			else if (addr >= dma && addr < dma + this_size)
+				size += dma + this_size - addr;
+		}
+	} else {
+		for (size = i = 0; i < d->frames; i++) {
+			struct bcm2835_dma_cb *control_block = d->cb_list[i].cb;
+			size_t this_size = control_block->length;
+			dma_addr_t dma;
+
+			if (d->dir == DMA_DEV_TO_MEM)
+				dma = control_block->dst;
+			else
+				dma = control_block->src;
+
+			if (size)
+				size += this_size;
+			else if (addr >= dma && addr < dma + this_size)
+				size += dma + this_size - addr;
+		}
 	}
 
 	return size;
@@ -586,12 +865,25 @@ static enum dma_status bcm2835_dma_tx_status(struct dma_chan *chan,
 		struct bcm2835_desc *d = c->desc;
 		dma_addr_t pos;
 
-		if (d->dir == DMA_MEM_TO_DEV)
+		if (d->dir == DMA_MEM_TO_DEV && c->is_40bit_channel) {
+			u64 lo_bits, hi_bits;
+
+			lo_bits = readl(c->chan_base + BCM2711_DMA40_SRC);
+			hi_bits = readl(c->chan_base + BCM2711_DMA40_SRCI) & 0xff;
+			pos = (hi_bits << 32) | lo_bits;
+		} else if (d->dir == DMA_MEM_TO_DEV && !c->is_40bit_channel) {
 			pos = readl(c->chan_base + BCM2835_DMA_SOURCE_AD);
-		else if (d->dir == DMA_DEV_TO_MEM)
+		} else if (d->dir == DMA_DEV_TO_MEM && c->is_40bit_channel) {
+			u64 lo_bits, hi_bits;
+
+			lo_bits = readl(c->chan_base + BCM2711_DMA40_DEST);
+			hi_bits = readl(c->chan_base + BCM2711_DMA40_DESTI) & 0xff;
+			pos = (hi_bits << 32) | lo_bits;
+		} else if (d->dir == DMA_DEV_TO_MEM && !c->is_40bit_channel) {
 			pos = readl(c->chan_base + BCM2835_DMA_DEST_AD);
-		else
+		} else {
 			pos = 0;
+		}
 
 		txstate->residue = bcm2835_dma_desc_size_pos(d, pos);
 	} else {
@@ -634,7 +926,7 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_memcpy(
 	frames = bcm2835_dma_frames_for_length(len, max_len);
 
 	/* allocate the CB chain - this also fills in the pointers */
-	d = bcm2835_dma_create_cb_chain(chan, DMA_MEM_TO_MEM, false,
+	d = bcm2835_dma_create_cb_chain(c, DMA_MEM_TO_MEM, false,
 					info, extra, frames,
 					src, dst, len, 0, GFP_KERNEL);
 	if (!d)
@@ -669,11 +961,21 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_slave_sg(
 		if (c->cfg.src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
 			return NULL;
 		src = c->cfg.src_addr;
+		/*
+		 * One would think it ought to be possible to get the physical
+		 * to dma address mapping information from the dma-ranges DT
+		 * property, but I've not found a way yet that doesn't involve
+		 * open-coding the whole thing.
+		 */
+		if (c->is_40bit_channel)
+			src |= 0x400000000ull;
 		info |= BCM2835_DMA_S_DREQ | BCM2835_DMA_D_INC;
 	} else {
 		if (c->cfg.dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
 			return NULL;
 		dst = c->cfg.dst_addr;
+		if (c->is_40bit_channel)
+			dst |= 0x400000000ull;
 		info |= BCM2835_DMA_D_DREQ | BCM2835_DMA_S_INC;
 	}
 
@@ -681,7 +983,7 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_slave_sg(
 	frames = bcm2835_dma_count_frames_for_sg(c, sgl, sg_len);
 
 	/* allocate the CB chain */
-	d = bcm2835_dma_create_cb_chain(chan, direction, false,
+	d = bcm2835_dma_create_cb_chain(c, direction, false,
 					info, extra,
 					frames, src, dst, 0, 0,
 					GFP_NOWAIT);
@@ -689,7 +991,7 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_slave_sg(
 		return NULL;
 
 	/* fill in frames with scatterlist pointers */
-	bcm2835_dma_fill_cb_chain_with_sg(chan, direction, d->cb_list,
+	bcm2835_dma_fill_cb_chain_with_sg(c, direction, d->cb_list,
 					  sgl, sg_len);
 
 	return vchan_tx_prep(&c->vc, &d->vd, flags);
@@ -743,12 +1045,16 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 		if (c->cfg.src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
 			return NULL;
 		src = c->cfg.src_addr;
+		if (c->is_40bit_channel)
+			src |= 0x400000000ull;
 		dst = buf_addr;
 		info |= BCM2835_DMA_S_DREQ | BCM2835_DMA_D_INC;
 	} else {
 		if (c->cfg.dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
 			return NULL;
 		dst = c->cfg.dst_addr;
+		if (c->is_40bit_channel)
+			dst |= 0x400000000ull;
 		src = buf_addr;
 		info |= BCM2835_DMA_D_DREQ | BCM2835_DMA_S_INC;
 
@@ -768,7 +1074,7 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 	 * note that we need to use GFP_NOWAIT, as the ALSA i2s dmaengine
 	 * implementation calls prep_dma_cyclic with interrupts disabled.
 	 */
-	d = bcm2835_dma_create_cb_chain(chan, direction, true,
+	d = bcm2835_dma_create_cb_chain(c, direction, true,
 					info, extra,
 					frames, src, dst, buf_len,
 					period_len, GFP_NOWAIT);
@@ -776,7 +1082,12 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 		return NULL;
 
 	/* wrap around into a loop */
-	d->cb_list[d->frames - 1].cb->next = d->cb_list[0].paddr;
+	if (c->is_40bit_channel)
+		((struct bcm2711_dma40_scb *)
+		 d->cb_list[frames - 1].cb)->next_cb =
+			to_bcm2711_cbaddr(d->cb_list[0].paddr);
+	else
+		d->cb_list[d->frames - 1].cb->next = d->cb_list[0].paddr;
 
 	return vchan_tx_prep(&c->vc, &d->vd, flags);
 }
@@ -837,9 +1148,11 @@ static int bcm2835_dma_chan_init(struct bcm2835_dmadev *d, int chan_id,
 	c->irq_number = irq;
 	c->irq_flags = irq_flags;
 
-	/* check in DEBUG register if this is a LITE channel */
-	if (readl(c->chan_base + BCM2835_DMA_DEBUG) &
-		BCM2835_DMA_DEBUG_LITE)
+	/* check for 40bit and lite channels */
+	if (d->cfg_data->chan_40bit_mask & BIT(chan_id))
+		c->is_40bit_channel = true;
+	else if (readl(c->chan_base + BCM2835_DMA_DEBUG) &
+		 BCM2835_DMA_DEBUG_LITE)
 		c->is_lite_channel = true;
 
 	return 0;
@@ -859,8 +1172,58 @@ static void bcm2835_dma_free(struct bcm2835_dmadev *od)
 			     DMA_TO_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
 }
 
+int bcm2711_dma40_memcpy_init(void)
+{
+	if (!memcpy_parent)
+		return -EPROBE_DEFER;
+
+	if (!memcpy_chan)
+		return -EINVAL;
+
+	if (!memcpy_scb)
+		return -ENOMEM;
+
+	return 0;
+}
+EXPORT_SYMBOL(bcm2711_dma40_memcpy_init);
+
+void bcm2711_dma40_memcpy(dma_addr_t dst, dma_addr_t src, size_t size)
+{
+	struct bcm2711_dma40_scb *scb = memcpy_scb;
+	unsigned long flags;
+
+	if (!scb) {
+		pr_err("%s not initialised!\n", __func__);
+		return;
+	}
+
+	spin_lock_irqsave(&memcpy_lock, flags);
+
+	scb->ti = 0;
+	scb->src = lower_32_bits(src);
+	scb->srci = upper_32_bits(src) | BCM2711_DMA40_MEMCPY_XFER_INFO;
+	scb->dst = lower_32_bits(dst);
+	scb->dsti = upper_32_bits(dst) | BCM2711_DMA40_MEMCPY_XFER_INFO;
+	scb->len = size;
+	scb->next_cb = 0;
+
+	writel((u32)(memcpy_scb_dma >> 5), memcpy_chan + BCM2711_DMA40_CB);
+	writel(BCM2711_DMA40_MEMCPY_FLAGS + BCM2711_DMA40_ACTIVE,
+	       memcpy_chan + BCM2711_DMA40_CS);
+
+	/* Poll for completion */
+	while (!(readl(memcpy_chan + BCM2711_DMA40_CS) & BCM2711_DMA40_END))
+		cpu_relax();
+
+	writel(BCM2711_DMA40_END, memcpy_chan + BCM2711_DMA40_CS);
+
+	spin_unlock_irqrestore(&memcpy_lock, flags);
+}
+EXPORT_SYMBOL(bcm2711_dma40_memcpy);
+
 static const struct of_device_id bcm2835_dma_of_match[] = {
-	{ .compatible = "brcm,bcm2835-dma", },
+	{ .compatible = "brcm,bcm2835-dma", .data = &bcm2835_dma_cfg },
+	{ .compatible = "brcm,bcm2711-dma", .data = &bcm2711_dma_cfg },
 	{},
 };
 MODULE_DEVICE_TABLE(of, bcm2835_dma_of_match);
@@ -884,6 +1247,7 @@ static struct dma_chan *bcm2835_dma_xlate(struct of_phandle_args *spec,
 static int bcm2835_dma_probe(struct platform_device *pdev)
 {
 	struct bcm2835_dmadev *od;
+	struct resource *res;
 	void __iomem *base;
 	int rc;
 	int i, j;
@@ -891,6 +1255,8 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 	int irq_flags;
 	uint32_t chans_available;
 	char chan_name[BCM2835_DMA_CHAN_NAME_SIZE];
+	const struct of_device_id *of_id;
+	int chan_count, chan_start, chan_end;
 
 	if (!pdev->dev.dma_mask)
 		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
@@ -907,10 +1273,17 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 
 	dma_set_max_seg_size(&pdev->dev, 0x3FFFFFFF);
 
-	base = devm_platform_ioremap_resource(pdev, 0);
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
+	/* The set of channels can be split across multiple instances. */
+	chan_start = ((u32)(uintptr_t)base / BCM2835_DMA_CHAN_SIZE) & 0xf;
+	base -= BCM2835_DMA_CHAN(chan_start);
+	chan_count = resource_size(res) / BCM2835_DMA_CHAN_SIZE;
+	chan_end = min(chan_start + chan_count,
+		       BCM2835_DMA_MAX_DMA_CHAN_SUPPORTED + 1);
+
 	od->base = base;
 
 	dma_cap_set(DMA_SLAVE, od->ddev.cap_mask);
@@ -946,6 +1319,14 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	of_id = of_match_node(bcm2835_dma_of_match, pdev->dev.of_node);
+	if (!of_id) {
+		dev_err(&pdev->dev, "Failed to match compatible string\n");
+		return -EINVAL;
+	}
+
+	od->cfg_data = of_id->data;
+
 	/* Request DMA channel mask from device tree */
 	if (of_property_read_u32(pdev->dev.of_node,
 			"brcm,dma-channel-mask",
@@ -955,8 +1336,23 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 		goto err_no_dma;
 	}
 
+	/* One channel is reserved for the 40-bit DMA memcpy API */
+	if (chans_available & od->cfg_data->chan_40bit_mask &
+	    BIT(BCM2711_DMA_MEMCPY_CHAN)) {
+		memcpy_parent = od;
+		memcpy_chan = BCM2835_DMA_CHANIO(base, BCM2711_DMA_MEMCPY_CHAN);
+		memcpy_scb = dma_alloc_coherent(memcpy_parent->ddev.dev,
+						sizeof(*memcpy_scb),
+						&memcpy_scb_dma, GFP_KERNEL);
+		if (!memcpy_scb)
+			dev_warn(&pdev->dev,
+				 "Failed to allocated memcpy scb\n");
+
+		chans_available &= ~BIT(BCM2711_DMA_MEMCPY_CHAN);
+	}
+
 	/* get irqs for each channel that we support */
-	for (i = 0; i <= BCM2835_DMA_MAX_DMA_CHAN_SUPPORTED; i++) {
+	for (i = chan_start; i < chan_end; i++) {
 		/* skip masked out channels */
 		if (!(chans_available & (1 << i))) {
 			irq[i] = -1;
@@ -979,13 +1375,18 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 		irq[i] = platform_get_irq(pdev, i < 11 ? i : 11);
 	}
 
+	chan_count = 0;
+
 	/* get irqs for each channel */
-	for (i = 0; i <= BCM2835_DMA_MAX_DMA_CHAN_SUPPORTED; i++) {
+	for (i = chan_start; i < chan_end; i++) {
 		/* skip channels without irq */
 		if (irq[i] < 0)
 			continue;
 
 		/* check if there are other channels that also use this irq */
+		/* FIXME: This will fail if interrupts are shared across
+		 * instances
+		 */
 		irq_flags = 0;
 		for (j = 0; j <= BCM2835_DMA_MAX_DMA_CHAN_SUPPORTED; j++)
 			if ((i != j) && (irq[j] == irq[i])) {
@@ -997,9 +1398,10 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 		rc = bcm2835_dma_chan_init(od, i, irq[i], irq_flags);
 		if (rc)
 			goto err_no_dma;
+		chan_count++;
 	}
 
-	dev_dbg(&pdev->dev, "Initialized %i DMA channels\n", i);
+	dev_dbg(&pdev->dev, "Initialized %i DMA channels\n", chan_count);
 
 	/* Device-tree DMA controller registration */
 	rc = of_dma_controller_register(pdev->dev.of_node,
@@ -1030,6 +1432,13 @@ static void bcm2835_dma_remove(struct platform_device *pdev)
 	struct bcm2835_dmadev *od = platform_get_drvdata(pdev);
 
 	dma_async_device_unregister(&od->ddev);
+	if (memcpy_parent == od) {
+		dma_free_coherent(&pdev->dev, sizeof(*memcpy_scb), memcpy_scb,
+				  memcpy_scb_dma);
+		memcpy_parent = NULL;
+		memcpy_scb = NULL;
+		memcpy_chan = NULL;
+	}
 	bcm2835_dma_free(od);
 }
 
-- 
2.41.0


