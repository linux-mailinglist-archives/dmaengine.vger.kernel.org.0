Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCC947FC74
	for <lists+dmaengine@lfdr.de>; Mon, 27 Dec 2021 13:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbhL0MGe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Dec 2021 07:06:34 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:35911 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236543AbhL0MGd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Dec 2021 07:06:33 -0500
Received: from localhost.localdomain ([37.4.249.169]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Ml6i4-1ma8Rg1zeG-00lUD6; Mon, 27 Dec 2021 13:06:16 +0100
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
Subject: [PATCH RFC 07/11] dmaengine: bcm2385: drop info parameters
Date:   Mon, 27 Dec 2021 13:05:41 +0100
Message-Id: <1640606743-10993-8-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1640606743-10993-1-git-send-email-stefan.wahren@i2se.com>
References: <1640606743-10993-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:veQprJd5ydJ2eSPjMP4NQjyRPxhb9yVxCJ9uCTSwnJ7PEmBIYDV
 FnvEWSKgnsbLrrYaHkBzF6YUSQS7D2j5YnYLkLLQ+WJWQwrhYFFCDjYqCa3GVi/wQc6+puL
 RL26IYqGiQ9BXq3cv1Ki5FJgfLwjQoXFcBqb78B2lGd5NK5GLjOs261pTc2Z/KaEdy0EDKX
 tpGW4VeHP5pLa7fPmC00w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/PmHXNHlx3M=:EarIMjBb0WU74G31gJ373C
 98/eMtcNYB6jIYH4uiLPtJEynkaeUbBLdldZfrYsQ/hcLGmxM31Sk2HhohlKdKXl4oZH9f2YF
 AG3j0SvJKH5fE3+5ZuT+0GrnpmVBJ1DfIT1Of+1mD9iHIzMPVgEMjkrUpsjr3L6g+YNUJ55TL
 D/yPQ0eInsxWlClo5woXLqhprFmIfTbz0DmLt1pn8ZXvr+4UE51+E4lGA6DSQI//9KtG5iGD2
 DZtE4Ff6BbKk4wM4FzglW2jTxusJTyJkP9Ykv942sBaB/iwtb6ggI+wxyRh83M5MGUy3FC6s5
 IzE3vKeectS9/5iiSpWuDE9uZwHOjPW99fT/7ddvSUSMKBWItxT701uyLBxuRp1JJfVR/kZmB
 0NvESVSFxWK1OfRtlgvjfXgpwQXtEPjPIYQUwK0IQ++sg/TZLLAq4hMtgyxjiXInK+aY6fj1V
 ciV/JolciAqXaC8Pmq2HNDP0ZlXWxQfmtvIX4tc5IToSzCn1rHFp4B+NXRRWWBTXnpv5RdIRJ
 OnvqSGFZ7L5YXi+HmmhmCyl5s7IwL2Cwx9IJCf84m32XIdZZNkeILvn+ERxREN6xEuGDDjDEd
 cK1ps8VpbUsnEJotEpCBteZSVme3lCFshGBSfQryqw0hKHwOFEW8Q4tAmAeGOyIM0zWLjRsHI
 x55FFtgyphbK0aRqVS7pocoDDuG/7UiwfCGlDe6GDWnfCjWSe5Rb7j4suorCEznIr4ZWz3gLH
 UpYF1P2wc3KA+Aud
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The parameters info and finalextrainfo are platform specific. So drop
them by generating them within bcm2835_dma_create_cb_chain().

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/dma/bcm2835-dma.c | 75 +++++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 38 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index a7b9f88..997fe6e 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -288,13 +288,12 @@ static void bcm2835_dma_desc_free(struct virt_dma_desc *vd)
 		container_of(vd, struct bcm2835_desc, vd));
 }
 
-static void bcm2835_dma_create_cb_set_length(
+static bool bcm2835_dma_create_cb_set_length(
 	struct bcm2835_chan *chan,
 	struct bcm2835_dma_cb *control_block,
 	size_t len,
 	size_t period_len,
-	size_t *total_len,
-	u32 finalextrainfo)
+	size_t *total_len)
 {
 	size_t max_len = bcm2835_dma_max_frame_length(chan);
 
@@ -303,7 +302,7 @@ static void bcm2835_dma_create_cb_set_length(
 
 	/* finished if we have no period_length */
 	if (!period_len)
-		return;
+		return false;
 
 	/*
 	 * period_len means: that we need to generate
@@ -317,7 +316,7 @@ static void bcm2835_dma_create_cb_set_length(
 	if (*total_len + control_block->length < period_len) {
 		/* update number of bytes in this period so far */
 		*total_len += control_block->length;
-		return;
+		return false;
 	}
 
 	/* calculate the length that remains to reach period_length */
@@ -326,8 +325,7 @@ static void bcm2835_dma_create_cb_set_length(
 	/* reset total_length for next period */
 	*total_len = 0;
 
-	/* add extrainfo bits in info */
-	control_block->info |= finalextrainfo;
+	return true;
 }
 
 static inline size_t bcm2835_dma_count_frames_for_sg(
@@ -353,7 +351,6 @@ static inline size_t bcm2835_dma_count_frames_for_sg(
  * @chan:           the @dma_chan for which we run this
  * @direction:      the direction in which we transfer
  * @cyclic:         it is a cyclic transfer
- * @info:           the default info bits to apply per controlblock
  * @frames:         number of controlblocks to allocate
  * @src:            the src address to assign
  * @dst:            the dst address to assign
@@ -361,22 +358,24 @@ static inline size_t bcm2835_dma_count_frames_for_sg(
  * @period_len:     the period length when to apply @finalextrainfo
  *                  in addition to the last transfer
  *                  this will also break some control-blocks early
- * @finalextrainfo: additional bits in last controlblock
- *                  (or when period_len is reached in case of cyclic)
  * @gfp:            the GFP flag to use for allocation
+ * @flags
  */
 static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 	struct dma_chan *chan, enum dma_transfer_direction direction,
-	bool cyclic, u32 info, u32 finalextrainfo, size_t frames,
-	dma_addr_t src, dma_addr_t dst, size_t buf_len,
-	size_t period_len, gfp_t gfp)
+	bool cyclic, size_t frames, dma_addr_t src, dma_addr_t dst,
+	size_t buf_len,	size_t period_len, gfp_t gfp, unsigned long flags)
 {
+	struct bcm2835_dmadev *od = to_bcm2835_dma_dev(chan->device);
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	size_t len = buf_len, total_len;
 	size_t frame;
 	struct bcm2835_desc *d;
 	struct bcm2835_cb_entry *cb_entry;
 	struct bcm2835_dma_cb *control_block;
+	u32 extrainfo = bcm2835_dma_prepare_cb_extra(c, direction, cyclic,
+						     false, flags);
+	bool zero_page = false;
 
 	if (!frames)
 		return NULL;
@@ -390,6 +389,15 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 	d->dir = direction;
 	d->cyclic = cyclic;
 
+	switch (direction) {
+	case DMA_MEM_TO_MEM:
+	case DMA_DEV_TO_MEM:
+		break;
+	default:
+		zero_page = src == od->zero_page;
+	}
+
+
 	/*
 	 * Iterate over all frames, create a control block
 	 * for each frame and link them together.
@@ -403,7 +411,8 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 
 		/* fill in the control block */
 		control_block = cb_entry->cb;
-		control_block->info = info;
+		control_block->info = bcm2835_dma_prepare_cb_info(c, direction,
+								  zero_page);
 		control_block->src = src;
 		control_block->dst = dst;
 		control_block->stride = 0;
@@ -411,10 +420,12 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 		/* set up length in control_block if requested */
 		if (buf_len) {
 			/* calculate length honoring period_length */
-			bcm2835_dma_create_cb_set_length(
+			if (bcm2835_dma_create_cb_set_length(
 				c, control_block,
-				len, period_len, &total_len,
-				cyclic ? finalextrainfo : 0);
+				len, period_len, &total_len)) {
+				/* add extrainfo bits in info */
+				control_block->info |= extrainfo;
+			}
 
 			/* calculate new remaining length */
 			len -= control_block->length;
@@ -435,7 +446,9 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 	}
 
 	/* the last frame requires extra flags */
-	d->cb_list[d->frames - 1].cb->info |= finalextrainfo;
+	extrainfo = bcm2835_dma_prepare_cb_extra(c, direction, cyclic, true,
+						 flags);
+	d->cb_list[d->frames - 1].cb->info |= extrainfo;
 
 	/* detect a size missmatch */
 	if (buf_len && (d->size != buf_len))
@@ -683,9 +696,6 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_memcpy(
 {
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_desc *d;
-	u32 info = bcm2835_dma_prepare_cb_info(c, DMA_MEM_TO_MEM, false);
-	u32 extra = bcm2835_dma_prepare_cb_extra(c, DMA_MEM_TO_MEM, false,
-						 true, 0);
 	size_t max_len = bcm2835_dma_max_frame_length(c);
 	size_t frames;
 
@@ -697,9 +707,8 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_memcpy(
 	frames = bcm2835_dma_frames_for_length(len, max_len);
 
 	/* allocate the CB chain - this also fills in the pointers */
-	d = bcm2835_dma_create_cb_chain(chan, DMA_MEM_TO_MEM, false,
-					info, extra, frames,
-					src, dst, len, 0, GFP_KERNEL);
+	d = bcm2835_dma_create_cb_chain(chan, DMA_MEM_TO_MEM, false, frames,
+					src, dst, len, 0, GFP_KERNEL, 0);
 	if (!d)
 		return NULL;
 
@@ -715,8 +724,6 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_slave_sg(
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_desc *d;
 	dma_addr_t src = 0, dst = 0;
-	u32 info = bcm2835_dma_prepare_cb_info(c, direction, false);
-	u32 extra = bcm2835_dma_prepare_cb_extra(c, direction, false, true, 0);
 	size_t frames;
 
 	if (!is_slave_direction(direction)) {
@@ -739,10 +746,8 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_slave_sg(
 	frames = bcm2835_dma_count_frames_for_sg(c, sgl, sg_len);
 
 	/* allocate the CB chain */
-	d = bcm2835_dma_create_cb_chain(chan, direction, false,
-					info, extra,
-					frames, src, dst, 0, 0,
-					GFP_NOWAIT);
+	d = bcm2835_dma_create_cb_chain(chan, direction, false, frames, src,
+					dst, 0, 0, GFP_NOWAIT, 0);
 	if (!d)
 		return NULL;
 
@@ -758,13 +763,9 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 	size_t period_len, enum dma_transfer_direction direction,
 	unsigned long flags)
 {
-	struct bcm2835_dmadev *od = to_bcm2835_dma_dev(chan->device);
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_desc *d;
 	dma_addr_t src, dst;
-	u32 info = bcm2835_dma_prepare_cb_info(c, direction,
-					       buf_addr == od->zero_page);
-	u32 extra = bcm2835_dma_prepare_cb_extra(c, direction, true, true, 0);
 	size_t max_len = bcm2835_dma_max_frame_length(c);
 	size_t frames;
 
@@ -815,10 +816,8 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 	 * note that we need to use GFP_NOWAIT, as the ALSA i2s dmaengine
 	 * implementation calls prep_dma_cyclic with interrupts disabled.
 	 */
-	d = bcm2835_dma_create_cb_chain(chan, direction, true,
-					info, extra,
-					frames, src, dst, buf_len,
-					period_len, GFP_NOWAIT);
+	d = bcm2835_dma_create_cb_chain(chan, direction, true, frames, src, dst,
+					buf_len, period_len, GFP_NOWAIT, flags);
 	if (!d)
 		return NULL;
 
-- 
2.7.4

