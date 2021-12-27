Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB4F47FC73
	for <lists+dmaengine@lfdr.de>; Mon, 27 Dec 2021 13:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbhL0MGd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Dec 2021 07:06:33 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:38865 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236574AbhL0MGc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Dec 2021 07:06:32 -0500
Received: from localhost.localdomain ([37.4.249.169]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N9MlI-1mPEMf2TIq-015LTo; Mon, 27 Dec 2021 13:06:17 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, dmaengine@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lukas Wunner <lukas@wunner.de>,
        linux-rpi-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH RFC 09/11] dmaengine: bcm2835: introduce multi platform support
Date:   Mon, 27 Dec 2021 13:05:43 +0100
Message-Id: <1640606743-10993-10-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1640606743-10993-1-git-send-email-stefan.wahren@i2se.com>
References: <1640606743-10993-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:hRYLB1N608LvE2RK10d2h3RkkDf6BDGvwFZi9WSLHZ66qnfEWBy
 m+8bFBsJermtvSfk4jjzM8SYeFIXCqSHv5laiqZ3ahBTzpj5HFw7N4JQZAoQwwCwJ+p+ATN
 UFKNy6dDCtMMsXp+B0PbtYBVm240y7VK0UK4l1gban2VKO56Up0jpSjGHlSJsPdkpvhHG1/
 2BNW6L8UNMx4o3JM7SXzA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UQEuk0NfnIA=:vK7MiNwq2h/Dg9jI6vth9U
 sCXYQDJCYUq69bRXK+zZC96f3Y4l+cg0SRgNWFcvDeo5Bdb45r+qNAhP/tp/Q51laNyaumcFR
 3Gbq6dreI/1F7rUx9n27Z0EMMXSFFA/IkTMV/nRkgsr0Ay9SXTQJVcvAwFBVNryHTUZeDaZ4Q
 P3zS6pjfT/Jmc6lnOAm4gZmZDv37YAWyl8AtqEdDBRQhQQhZ2ur1mCAndp6719HCarfGkaS28
 NT29ts95QROSv18hyPD7a/UJv96901M7Ey0ZpzOWcXPi2aJ/ntH8E9wC+lWni4cRv8a4rHHZb
 THWjNdyDP7/JPMjeoNNCc7DgzwTmbAtTYVumae7os/q8XZww2I0WYVDxVZjvwO8I/MJwn/B/Z
 O4XCcDY/qgA1d8T+IYgTfkl+KVj1rNXEX5YmRaveXztAlWkaaukC9+uvSp228PXavRTCZRrbE
 5Q2JN/DYQ+2FTmCAHW21awPlqD/d89aqyrCjf2UmKLcIG+8lH8SNHV7aB90cYieeJacVia4BM
 I5sdE7q9hsJR6FOQaJGa1EIs6T+Rl7ix8HaxAcyGnn3LAjK6E71ejhum8hgsxEO4UO2vNe6WB
 X5OOTW2cFBlsogIVG9667IjTq3MORdaiV1P3jeAH+5iCa2fYeEZiHEMd9bUBqmEe8IyzJqfLq
 tpJX2cdWGL7pJBH0NClohVC4SDprO/dBam9Ti+N1DuZWc9TDEzHciN+VQR3nzGu8ESFNgyso8
 oF2K+sDQNB0jAj94
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This finally moves all platform specific stuff into a separate structure,
which is initialized on the OF compatible during probing. Since the DMA
control block is different on the BCM2711 platform, we introduce a common
control block to reserve the necessary space and adequate methods for
access.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/dma/bcm2835-dma.c | 303 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 235 insertions(+), 68 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 0933404..7159fa2 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -48,6 +48,11 @@ struct bcm2835_dmadev {
 	struct dma_device ddev;
 	void __iomem *base;
 	dma_addr_t zero_page;
+	const struct bcm2835_dma_cfg *cfg;
+};
+
+struct bcm_dma_cb {
+	uint32_t rsvd[8];
 };
 
 struct bcm2835_dma_cb {
@@ -61,7 +66,7 @@ struct bcm2835_dma_cb {
 };
 
 struct bcm2835_cb_entry {
-	struct bcm2835_dma_cb *cb;
+	struct bcm_dma_cb *cb;
 	dma_addr_t paddr;
 };
 
@@ -82,6 +87,38 @@ struct bcm2835_chan {
 	bool is_lite_channel;
 };
 
+struct bcm2835_dma_cfg {
+	dma_addr_t addr_offset;
+	u32 cs_reg;
+	u32 cb_reg;
+
+	u32 wait_mask;
+	u32 reset_mask;
+	u32 int_mask;
+	u32 active_mask;
+
+	u32 (*cb_get_length)(void *data);
+	dma_addr_t (*cb_get_addr)(void *data, enum dma_transfer_direction);
+
+	void (*cb_init)(void *data, struct bcm2835_chan *c,
+			enum dma_transfer_direction, u32 src, u32 dst,
+			bool zero_page);
+	void (*cb_set_src)(void *data, enum dma_transfer_direction, u32 src);
+	void (*cb_set_dst)(void *data, enum dma_transfer_direction, u32 dst);
+	void (*cb_set_next)(void *data, u32 next);
+	void (*cb_set_length)(void *data, u32 length);
+	void (*cb_append_extra)(void *data,
+				struct bcm2835_chan *c,
+				enum dma_transfer_direction direction,
+				bool cyclic, bool final, unsigned long flags);
+
+	u32 (*to_cb_addr)(dma_addr_t addr);
+
+	void (*chan_plat_init)(struct bcm2835_chan *c);
+	dma_addr_t (*read_addr)(struct bcm2835_chan *c,
+				enum dma_transfer_direction);
+};
+
 struct bcm2835_desc {
 	struct bcm2835_chan *c;
 	struct virt_dma_desc vd;
@@ -190,6 +227,13 @@ static inline struct bcm2835_dmadev *to_bcm2835_dma_dev(struct dma_device *d)
 	return container_of(d, struct bcm2835_dmadev, ddev);
 }
 
+static inline const struct bcm2835_dma_cfg *to_bcm2835_cfg(struct dma_device *d)
+{
+	struct bcm2835_dmadev *od = container_of(d, struct bcm2835_dmadev, ddev);
+
+	return od->cfg;
+}
+
 static inline struct bcm2835_chan *to_bcm2835_dma_chan(struct dma_chan *c)
 {
 	return container_of(c, struct bcm2835_chan, vc.chan);
@@ -271,6 +315,104 @@ static inline bool need_dst_incr(enum dma_transfer_direction direction)
 	return false;
 }
 
+static inline u32 bcm2835_dma_cb_get_length(void *data)
+{
+	struct bcm2835_dma_cb *cb = data;
+
+	return cb->length;
+}
+
+static inline dma_addr_t
+bcm2835_dma_cb_get_addr(void *data, enum dma_transfer_direction direction)
+{
+	struct bcm2835_dma_cb *cb = data;
+
+	if (direction == DMA_DEV_TO_MEM)
+		return cb->dst;
+
+	return cb->src;
+}
+
+static inline void
+bcm2835_dma_cb_init(void *data, struct bcm2835_chan *c,
+		    enum dma_transfer_direction direction, u32 src, u32 dst,
+		    bool zero_page)
+{
+	struct bcm2835_dma_cb *cb = data;
+
+	cb->info = bcm2835_dma_prepare_cb_info(c, direction, zero_page);
+	cb->src = src;
+	cb->dst = dst;
+	cb->stride = 0;
+	cb->next = 0;
+}
+
+static inline void
+bcm2835_dma_cb_set_src(void *data, enum dma_transfer_direction direction,
+		       u32 src)
+{
+	struct bcm2835_dma_cb *cb = data;
+
+	cb->src = src;
+}
+
+static inline void
+bcm2835_dma_cb_set_dst(void *data, enum dma_transfer_direction direction,
+		       u32 dst)
+{
+	struct bcm2835_dma_cb *cb = data;
+
+	cb->dst = dst;
+}
+
+static inline void bcm2835_dma_cb_set_next(void *data, u32 next)
+{
+	struct bcm2835_dma_cb *cb = data;
+
+	cb->next = next;
+}
+
+static inline void bcm2835_dma_cb_set_length(void *data, u32 length)
+{
+	struct bcm2835_dma_cb *cb = data;
+
+	cb->length = length;
+}
+
+static inline void
+bcm2835_dma_cb_append_extra(void *data, struct bcm2835_chan *c,
+			    enum dma_transfer_direction direction,
+			    bool cyclic, bool final, unsigned long flags)
+{
+	struct bcm2835_dma_cb *cb = data;
+
+	cb->info |= bcm2835_dma_prepare_cb_extra(c, direction, cyclic, final,
+						 flags);
+}
+
+static inline dma_addr_t bcm2835_dma_to_cb_addr(dma_addr_t addr)
+{
+	return addr;
+}
+
+static void bcm2835_dma_chan_plat_init(struct bcm2835_chan *c)
+{
+	/* check in DEBUG register if this is a LITE channel */
+	if (readl(c->chan_base + BCM2835_DMA_DEBUG) & BCM2835_DMA_DEBUG_LITE)
+		c->is_lite_channel = true;
+}
+
+static dma_addr_t bcm2835_dma_read_addr(struct bcm2835_chan *c,
+					enum dma_transfer_direction direction)
+{
+	if (direction == DMA_MEM_TO_DEV)
+		return readl(c->chan_base + BCM2835_DMA_SOURCE_AD);
+	else if (direction == DMA_DEV_TO_MEM)
+		return readl(c->chan_base + BCM2835_DMA_DEST_AD);
+
+	return 0;
+}
+
 static void bcm2835_dma_free_cb_chain(struct bcm2835_desc *desc)
 {
 	size_t i;
@@ -290,16 +432,19 @@ static void bcm2835_dma_desc_free(struct virt_dma_desc *vd)
 
 static bool bcm2835_dma_create_cb_set_length(
 	struct dma_chan *chan,
-	struct bcm2835_dma_cb *control_block,
+	void *data,
 	size_t len,
 	size_t period_len,
 	size_t *total_len)
 {
+	const struct bcm2835_dma_cfg *cfg = to_bcm2835_cfg(chan->device);
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	size_t max_len = bcm2835_dma_max_frame_length(c);
 
 	/* set the length taking lite-channel limitations into account */
-	control_block->length = min_t(u32, len, max_len);
+	u32 length = min_t(u32, len, max_len);
+
+	cfg->cb_set_length(data, length);
 
 	/* finished if we have no period_length */
 	if (!period_len)
@@ -314,14 +459,14 @@ static bool bcm2835_dma_create_cb_set_length(
 	 */
 
 	/* have we filled in period_length yet? */
-	if (*total_len + control_block->length < period_len) {
+	if (*total_len + length < period_len) {
 		/* update number of bytes in this period so far */
-		*total_len += control_block->length;
+		*total_len += length;
 		return false;
 	}
 
 	/* calculate the length that remains to reach period_length */
-	control_block->length = period_len - *total_len;
+	cfg->cb_set_length(data, period_len - *total_len);
 
 	/* reset total_length for next period */
 	*total_len = 0;
@@ -367,15 +512,14 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 	bool cyclic, size_t frames, dma_addr_t src, dma_addr_t dst,
 	size_t buf_len,	size_t period_len, gfp_t gfp, unsigned long flags)
 {
+	const struct bcm2835_dma_cfg *cfg = to_bcm2835_cfg(chan->device);
 	struct bcm2835_dmadev *od = to_bcm2835_dma_dev(chan->device);
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	size_t len = buf_len, total_len;
 	size_t frame;
 	struct bcm2835_desc *d;
 	struct bcm2835_cb_entry *cb_entry;
-	struct bcm2835_dma_cb *control_block;
-	u32 extrainfo = bcm2835_dma_prepare_cb_extra(c, direction, cyclic,
-						     false, flags);
+	struct bcm_dma_cb *control_block;
 	bool zero_page = false;
 
 	if (!frames)
@@ -412,12 +556,7 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 
 		/* fill in the control block */
 		control_block = cb_entry->cb;
-		control_block->info = bcm2835_dma_prepare_cb_info(c, direction,
-								  zero_page);
-		control_block->src = src;
-		control_block->dst = dst;
-		control_block->stride = 0;
-		control_block->next = 0;
+		cfg->cb_init(control_block, c, src, dst, direction, zero_page);
 		/* set up length in control_block if requested */
 		if (buf_len) {
 			/* calculate length honoring period_length */
@@ -425,31 +564,33 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 				chan, control_block,
 				len, period_len, &total_len)) {
 				/* add extrainfo bits in info */
-				control_block->info |= extrainfo;
+				bcm2835_dma_cb_append_extra(control_block, c,
+							    direction, cyclic,
+							    false, flags);
 			}
 
 			/* calculate new remaining length */
-			len -= control_block->length;
+			len -= cfg->cb_get_length(control_block);
 		}
 
 		/* link this the last controlblock */
 		if (frame)
-			d->cb_list[frame - 1].cb->next = cb_entry->paddr;
+			cfg->cb_set_next(d->cb_list[frame - 1].cb,
+					 cb_entry->paddr);
 
 		/* update src and dst and length */
 		if (src && need_src_incr(direction))
-			src += control_block->length;
+			src += cfg->cb_get_length(control_block);
 		if (dst && need_dst_incr(direction))
-			dst += control_block->length;
+			dst += cfg->cb_get_length(control_block);
 
 		/* Length of total transfer */
-		d->size += control_block->length;
+		d->size += cfg->cb_get_length(control_block);
 	}
 
 	/* the last frame requires extra flags */
-	extrainfo = bcm2835_dma_prepare_cb_extra(c, direction, cyclic, true,
-						 flags);
-	d->cb_list[d->frames - 1].cb->info |= extrainfo;
+	cfg->cb_append_extra(d->cb_list[d->frames - 1].cb, c, direction, cyclic,
+			     true, flags);
 
 	/* detect a size missmatch */
 	if (buf_len && (d->size != buf_len))
@@ -469,6 +610,7 @@ static void bcm2835_dma_fill_cb_chain_with_sg(
 	struct scatterlist *sgl,
 	unsigned int sg_len)
 {
+	const struct bcm2835_dma_cfg *cfg = to_bcm2835_cfg(chan->device);
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	size_t len, max_len;
 	unsigned int i;
@@ -479,18 +621,19 @@ static void bcm2835_dma_fill_cb_chain_with_sg(
 	for_each_sg(sgl, sgent, sg_len, i) {
 		for (addr = sg_dma_address(sgent), len = sg_dma_len(sgent);
 		     len > 0;
-		     addr += cb->cb->length, len -= cb->cb->length, cb++) {
+		     addr += cfg->cb_get_length(cb->cb), len -= cfg->cb_get_length(cb->cb), cb++) {
 			if (direction == DMA_DEV_TO_MEM)
-				cb->cb->dst = addr;
+				cfg->cb_set_dst(cb->cb, direction, addr);
 			else
-				cb->cb->src = addr;
-			cb->cb->length = min(len, max_len);
+				cfg->cb_set_src(cb->cb, direction, addr);
+			cfg->cb_set_length(cb->cb, min(len, max_len));
 		}
 	}
 }
 
 static void bcm2835_dma_abort(struct dma_chan *chan)
 {
+	const struct bcm2835_dma_cfg *cfg = to_bcm2835_cfg(chan->device);
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	void __iomem *chan_base = c->chan_base;
 	long int timeout = 10000;
@@ -499,15 +642,15 @@ static void bcm2835_dma_abort(struct dma_chan *chan)
 	 * A zero control block address means the channel is idle.
 	 * (The ACTIVE flag in the CS register is not a reliable indicator.)
 	 */
-	if (!readl(chan_base + BCM2835_DMA_ADDR))
+	if (!readl(chan_base + cfg->cb_reg))
 		return;
 
 	/* Write 0 to the active bit - Pause the DMA */
-	writel(0, chan_base + BCM2835_DMA_CS);
+	writel(0, chan_base + cfg->cs_reg);
 
 	/* Wait for any current AXI transfer to complete */
-	while ((readl(chan_base + BCM2835_DMA_CS) &
-		BCM2835_DMA_WAITING_FOR_WRITES) && --timeout)
+	while ((readl(chan_base + cfg->cs_reg) & cfg->wait_mask) &&
+	       --timeout)
 		cpu_relax();
 
 	/* Peripheral might be stuck and fail to signal AXI write responses */
@@ -515,11 +658,12 @@ static void bcm2835_dma_abort(struct dma_chan *chan)
 		dev_err(c->vc.chan.device->dev,
 			"failed to complete outstanding writes\n");
 
-	writel(BCM2835_DMA_RESET, chan_base + BCM2835_DMA_CS);
+	writel(cfg->reset_mask, chan_base + cfg->cs_reg);
 }
 
 static void bcm2835_dma_start_desc(struct dma_chan *chan)
 {
+	const struct bcm2835_dma_cfg *cfg = to_bcm2835_cfg(chan->device);
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct virt_dma_desc *vd = vchan_next_desc(&c->vc);
 	struct bcm2835_desc *d;
@@ -533,13 +677,14 @@ static void bcm2835_dma_start_desc(struct dma_chan *chan)
 
 	c->desc = d = to_bcm2835_dma_desc(&vd->tx);
 
-	writel(d->cb_list[0].paddr, c->chan_base + BCM2835_DMA_ADDR);
-	writel(BCM2835_DMA_ACTIVE, c->chan_base + BCM2835_DMA_CS);
+	writel(cfg->to_cb_addr(d->cb_list[0].paddr), c->chan_base + cfg->cb_reg);
+	writel(cfg->active_mask, c->chan_base + cfg->cs_reg);
 }
 
 static irqreturn_t bcm2835_dma_callback(int irq, void *data)
 {
 	struct dma_chan *chan = data;
+	const struct bcm2835_dma_cfg *cfg = to_bcm2835_cfg(chan->device);
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_desc *d;
 	unsigned long flags;
@@ -547,9 +692,9 @@ static irqreturn_t bcm2835_dma_callback(int irq, void *data)
 	/* check the shared interrupt */
 	if (c->irq_flags & IRQF_SHARED) {
 		/* check if the interrupt is enabled */
-		flags = readl(c->chan_base + BCM2835_DMA_CS);
+		flags = readl(c->chan_base + cfg->cs_reg);
 		/* if not set then we are not the reason for the irq */
-		if (!(flags & BCM2835_DMA_INT))
+		if (!(flags & cfg->int_mask))
 			return IRQ_NONE;
 	}
 
@@ -562,8 +707,7 @@ static irqreturn_t bcm2835_dma_callback(int irq, void *data)
 	 * if this IRQ handler is threaded.) If the channel is finished, it
 	 * will remain idle despite the ACTIVE flag being set.
 	 */
-	writel(BCM2835_DMA_INT | BCM2835_DMA_ACTIVE,
-	       c->chan_base + BCM2835_DMA_CS);
+	writel(cfg->int_mask | cfg->active_mask, c->chan_base + cfg->cs_reg);
 
 	d = c->desc;
 
@@ -571,7 +715,7 @@ static irqreturn_t bcm2835_dma_callback(int irq, void *data)
 		if (d->cyclic) {
 			/* call the cyclic callback */
 			vchan_cyclic_callback(&d->vd);
-		} else if (!readl(c->chan_base + BCM2835_DMA_ADDR)) {
+		} else if (!readl(c->chan_base + cfg->cb_reg)) {
 			vchan_cookie_complete(&c->desc->vd);
 			bcm2835_dma_start_desc(chan);
 		}
@@ -594,7 +738,7 @@ static int bcm2835_dma_alloc_chan_resources(struct dma_chan *chan)
 	 * (32 byte) aligned address (BCM2835 ARM Peripherals, sec. 4.2.1.1).
 	 */
 	c->cb_pool = dma_pool_create(dev_name(dev), dev,
-				     sizeof(struct bcm2835_dma_cb), 32, 0);
+				     sizeof(struct bcm_dma_cb), 32, 0);
 	if (!c->cb_pool) {
 		dev_err(dev, "unable to allocate descriptor pool\n");
 		return -ENOMEM;
@@ -620,20 +764,16 @@ static size_t bcm2835_dma_desc_size(struct bcm2835_desc *d)
 	return d->size;
 }
 
-static size_t bcm2835_dma_desc_size_pos(struct bcm2835_desc *d, dma_addr_t addr)
+static size_t bcm2835_dma_desc_size_pos(const struct bcm2835_dma_cfg *cfg,
+					struct bcm2835_desc *d, dma_addr_t addr)
 {
 	unsigned int i;
 	size_t size;
 
 	for (size = i = 0; i < d->frames; i++) {
-		struct bcm2835_dma_cb *control_block = d->cb_list[i].cb;
-		size_t this_size = control_block->length;
-		dma_addr_t dma;
-
-		if (d->dir == DMA_DEV_TO_MEM)
-			dma = control_block->dst;
-		else
-			dma = control_block->src;
+		struct bcm_dma_cb *control_block = d->cb_list[i].cb;
+		size_t this_size = cfg->cb_get_length(control_block);
+		dma_addr_t dma = cfg->cb_get_addr(control_block, d->dir);
 
 		if (size)
 			size += this_size;
@@ -647,6 +787,7 @@ static size_t bcm2835_dma_desc_size_pos(struct bcm2835_desc *d, dma_addr_t addr)
 static enum dma_status bcm2835_dma_tx_status(struct dma_chan *chan,
 	dma_cookie_t cookie, struct dma_tx_state *txstate)
 {
+	const struct bcm2835_dma_cfg *cfg = to_bcm2835_cfg(chan->device);
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct virt_dma_desc *vd;
 	enum dma_status ret;
@@ -665,14 +806,8 @@ static enum dma_status bcm2835_dma_tx_status(struct dma_chan *chan,
 		struct bcm2835_desc *d = c->desc;
 		dma_addr_t pos;
 
-		if (d->dir == DMA_MEM_TO_DEV)
-			pos = readl(c->chan_base + BCM2835_DMA_SOURCE_AD);
-		else if (d->dir == DMA_DEV_TO_MEM)
-			pos = readl(c->chan_base + BCM2835_DMA_DEST_AD);
-		else
-			pos = 0;
-
-		txstate->residue = bcm2835_dma_desc_size_pos(d, pos);
+		pos = cfg->read_addr(c, d->dir);
+		txstate->residue = bcm2835_dma_desc_size_pos(cfg, d, pos);
 	} else {
 		txstate->residue = 0;
 	}
@@ -725,6 +860,7 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_slave_sg(
 	enum dma_transfer_direction direction,
 	unsigned long flags, void *context)
 {
+	const struct bcm2835_dma_cfg *cfg = to_bcm2835_cfg(chan->device);
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_desc *d;
 	dma_addr_t src = 0, dst = 0;
@@ -739,11 +875,11 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_slave_sg(
 	if (direction == DMA_DEV_TO_MEM) {
 		if (c->cfg.src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
 			return NULL;
-		src = c->cfg.src_addr;
+		src = cfg->addr_offset + c->cfg.src_addr;
 	} else {
 		if (c->cfg.dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
 			return NULL;
-		dst = c->cfg.dst_addr;
+		dst = cfg->addr_offset + c->cfg.dst_addr;
 	}
 
 	/* count frames in sg list */
@@ -767,6 +903,7 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 	size_t period_len, enum dma_transfer_direction direction,
 	unsigned long flags)
 {
+	const struct bcm2835_dma_cfg *cfg = to_bcm2835_cfg(chan->device);
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_desc *d;
 	dma_addr_t src, dst;
@@ -800,12 +937,12 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 	if (direction == DMA_DEV_TO_MEM) {
 		if (c->cfg.src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
 			return NULL;
-		src = c->cfg.src_addr;
+		src = cfg->addr_offset + c->cfg.src_addr;
 		dst = buf_addr;
 	} else {
 		if (c->cfg.dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
 			return NULL;
-		dst = c->cfg.dst_addr;
+		dst = cfg->addr_offset + c->cfg.dst_addr;
 		src = buf_addr;
 	}
 
@@ -826,7 +963,8 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 		return NULL;
 
 	/* wrap around into a loop */
-	d->cb_list[d->frames - 1].cb->next = d->cb_list[0].paddr;
+	cfg->cb_set_next(d->cb_list[d->frames - 1].cb,
+			 cfg->to_cb_addr(d->cb_list[0].paddr));
 
 	return vchan_tx_prep(&c->vc, &d->vd, flags);
 }
@@ -887,10 +1025,7 @@ static int bcm2835_dma_chan_init(struct bcm2835_dmadev *d, int chan_id,
 	c->irq_number = irq;
 	c->irq_flags = irq_flags;
 
-	/* check in DEBUG register if this is a LITE channel */
-	if (readl(c->chan_base + BCM2835_DMA_DEBUG) &
-		BCM2835_DMA_DEBUG_LITE)
-		c->is_lite_channel = true;
+	d->cfg->chan_plat_init(c);
 
 	return 0;
 }
@@ -909,8 +1044,34 @@ static void bcm2835_dma_free(struct bcm2835_dmadev *od)
 			     DMA_TO_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
 }
 
+static const struct bcm2835_dma_cfg bcm2835_data = {
+	.addr_offset = 0,
+
+	.cs_reg = BCM2835_DMA_CS,
+	.cb_reg = BCM2835_DMA_ADDR,
+
+	.wait_mask = BCM2835_DMA_WAITING_FOR_WRITES,
+	.reset_mask = BCM2835_DMA_RESET,
+	.int_mask = BCM2835_DMA_INT,
+	.active_mask = BCM2835_DMA_ACTIVE,
+
+	.cb_get_length = bcm2835_dma_cb_get_length,
+	.cb_get_addr = bcm2835_dma_cb_get_addr,
+	.cb_init = bcm2835_dma_cb_init,
+	.cb_set_src = bcm2835_dma_cb_set_src,
+	.cb_set_dst = bcm2835_dma_cb_set_dst,
+	.cb_set_next = bcm2835_dma_cb_set_next,
+	.cb_set_length = bcm2835_dma_cb_set_length,
+	.cb_append_extra = bcm2835_dma_cb_append_extra,
+
+	.to_cb_addr = bcm2835_dma_to_cb_addr,
+
+	.chan_plat_init = bcm2835_dma_chan_plat_init,
+	.read_addr = bcm2835_dma_read_addr,
+};
+
 static const struct of_device_id bcm2835_dma_of_match[] = {
-	{ .compatible = "brcm,bcm2835-dma", },
+	{ .compatible = "brcm,bcm2835-dma", .data = &bcm2835_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, bcm2835_dma_of_match);
@@ -933,6 +1094,7 @@ static struct dma_chan *bcm2835_dma_xlate(struct of_phandle_args *spec,
 
 static int bcm2835_dma_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *of_id;
 	struct bcm2835_dmadev *od;
 	struct resource *res;
 	void __iomem *base;
@@ -943,6 +1105,10 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 	uint32_t chans_available;
 	char chan_name[BCM2835_DMA_CHAN_NAME_SIZE];
 
+	of_id = of_match_node(bcm2835_dma_of_match, pdev->dev.of_node);
+	if (!of_id)
+		return -EINVAL;
+
 	if (!pdev->dev.dma_mask)
 		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
 
@@ -964,6 +1130,7 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	od->base = base;
+	od->cfg = of_id->data;
 
 	dma_cap_set(DMA_SLAVE, od->ddev.cap_mask);
 	dma_cap_set(DMA_PRIVATE, od->ddev.cap_mask);
-- 
2.7.4

