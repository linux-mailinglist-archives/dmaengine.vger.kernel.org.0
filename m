Return-Path: <dmaengine+bounces-1366-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3742A87A929
	for <lists+dmaengine@lfdr.de>; Wed, 13 Mar 2024 15:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9BC1C228FF
	for <lists+dmaengine@lfdr.de>; Wed, 13 Mar 2024 14:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F38D51C3B;
	Wed, 13 Mar 2024 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QCikcQLC"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF03F4DA05
	for <dmaengine@vger.kernel.org>; Wed, 13 Mar 2024 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338945; cv=none; b=FlX1GvkYRjpWSwxJ6Qqvs+38epCV/apS0XNxcjMPMu3egiRkzR/dY5zZegN8GeLZRPSiLua60EJ/h6bd7pKIdX8qxfx0XzkLYluGxIkBKg3veyQN/YtYZmwnxaqya6cV7mFP5dRFpMLNViR+ruryFaAZVdoCnW0qrFDtFBS8qdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338945; c=relaxed/simple;
	bh=vIs76kYyjwJXw/ha/aHUzP99GhVmGXrKseYwAg7s1m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ND2JZIIamy+2jBXHFdK8tWwxfRIxJQ0J3F+28I+DtpfZi29yW0xkP3yVsZz9Fe5BypIFnVEBnEu0mU5izD/lQBajvF45qHzIYqmmaZV8ss9K98/Oc+x6a036Jgbl8g86RVZc/dBDeUNJwSE5HVRFzs5FX08RpCrRqhyotJ/vbjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QCikcQLC; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a45c006ab82so145164866b.3
        for <dmaengine@vger.kernel.org>; Wed, 13 Mar 2024 07:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710338941; x=1710943741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQCAxLcWayDk9E0aIZHof0VU6EySMCm0kMz7fVOHPV4=;
        b=QCikcQLCd2a5sr8cgtxc8d0dPTECENlYFLNq0EqvKr2awLoEV+/6TJ4dhDHowbr6O8
         EJWNnBMI7AlFaw9SrnSgQ7tBfn74wr3KVdgZ5Z9MXgwUpapNpzLr770aoLgW6WOXmtTH
         hohwDCLp/wfq56g42jRtplc6QgO0JeYGQY8fpB4FYzteo5Kp89Wmq7w+71gGaHlY5RDt
         Wvhv8D7GHX4pkRgut1BOSqjVYeorAveGa5UHGbBSk1sCl2VkqngsYfw9ysV3a36Wg5P9
         Y0KsJRSZH2EKFfqEmyk2keF1JdngdWjqFGN4WTTmsGPp9OWbFEgD80+yXeOmkSoEO3Uk
         UnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710338941; x=1710943741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQCAxLcWayDk9E0aIZHof0VU6EySMCm0kMz7fVOHPV4=;
        b=TqTuKwrks/DdRmCpZkYKNuX/qHi8nnrpL64DfdqwLUEsgqKq21GDgjyWNgBudnUn8y
         fRoB3KSLvrqx9ylPZRToQ2SSkrjA3UTbzrIlai0uyS6KWBAG4AYfXiAko+wrO9peWQSI
         3BKPSDl/ErsQECUltdxYiQO4AuG9eTg8epCo4ieUrBapNFyimAWlyEZi2LvyTX1mN1Yv
         iznZl4qrC1r5LMV7CRDashBAJbuq3mgYoexyHYYexmUw4FwJDTUle3aiY1rTv7sHpsIF
         OG+kRiJPn3R7qHAcD5nCSsKrBB4d4IaC4cG62uWwXP0o/lfPX3QO4jNpnhTl9et1G8fc
         KWew==
X-Forwarded-Encrypted: i=1; AJvYcCU2YaoVmkbdkOlfHHPpU4rF3IeFwqTXeW3lPEoci9p0hM4PD5si077y3MdSwhjuhVZ17LlzUvrqQILP3yfw03L5WjmKeDkRzF0j
X-Gm-Message-State: AOJu0YzqHkxh+jHnZxM1zrRDuD8BP0i+1SLWbg8bm+svBGMxLw4vF33v
	mO4ycFAqhoBXxKSfEdIsmRUMhJk7QOBcrTYuR8Fq8Dz62HG8/n2UqVyg/QeOHqI=
X-Google-Smtp-Source: AGHT+IGz+F3N9s1yqpgvtHwiw7lZ8mJ6jYatA61Yu9YqH5ShW7KVEDKZi1EDxzexoGOUe2u3CrXDzw==
X-Received: by 2002:a17:907:c783:b0:a46:37db:b57d with SMTP id tz3-20020a170907c78300b00a4637dbb57dmr149485ejc.15.1710338941200;
        Wed, 13 Mar 2024 07:09:01 -0700 (PDT)
Received: from localhost (host-82-56-173-172.retail.telecomitalia.it. [82.56.173.172])
        by smtp.gmail.com with ESMTPSA id h10-20020a170906718a00b00a4658d3e405sm691966ejk.196.2024.03.13.07.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 07:09:00 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Saenz Julienne <nsaenz@kernel.org>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dave.stevenson@raspberrypi.com
Cc: Phil Elwell <phil@raspberrypi.org>,
	Maxime Ripard <maxime@cerno.tech>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Dom Cobley <popcornmix@gmail.com>,
	Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v2 10/15] dmaengine: bcm2385: drop info parameters
Date: Wed, 13 Mar 2024 15:08:35 +0100
Message-ID: <27e4028259c6c70b6439e198f62873bf12975b63.1710226514.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710226514.git.andrea.porta@suse.com>
References: <cover.1710226514.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The parameters info and finalextrainfo are platform specific. So drop
them by generating them within bcm2835_dma_create_cb_chain().

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 drivers/dma/bcm2835-dma.c | 80 +++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 41 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 6f896bb1a4fe..03d97312a3f8 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -308,12 +308,11 @@ static void bcm2835_dma_desc_free(struct virt_dma_desc *vd)
 	bcm2835_dma_free_cb_chain(container_of(vd, struct bcm2835_desc, vd));
 }
 
-static void bcm2835_dma_create_cb_set_length(struct bcm2835_chan *chan,
+static bool bcm2835_dma_create_cb_set_length(struct bcm2835_chan *chan,
 					     struct bcm2835_dma_cb *control_block,
 					     size_t len,
 					     size_t period_len,
-					     size_t *total_len,
-					     u32 finalextrainfo)
+					     size_t *total_len)
 {
 	size_t max_len = bcm2835_dma_max_frame_length(chan);
 
@@ -322,7 +321,7 @@ static void bcm2835_dma_create_cb_set_length(struct bcm2835_chan *chan,
 
 	/* finished if we have no period_length */
 	if (!period_len)
-		return;
+		return false;
 
 	/*
 	 * period_len means: that we need to generate
@@ -336,7 +335,7 @@ static void bcm2835_dma_create_cb_set_length(struct bcm2835_chan *chan,
 	if (*total_len + control_block->length < period_len) {
 		/* update number of bytes in this period so far */
 		*total_len += control_block->length;
-		return;
+		return false;
 	}
 
 	/* calculate the length that remains to reach period_length */
@@ -345,8 +344,7 @@ static void bcm2835_dma_create_cb_set_length(struct bcm2835_chan *chan,
 	/* reset total_length for next period */
 	*total_len = 0;
 
-	/* add extrainfo bits in info */
-	control_block->info |= finalextrainfo;
+	return true;
 }
 
 static inline size_t bcm2835_dma_count_frames_for_sg(struct bcm2835_chan *c,
@@ -371,7 +369,6 @@ static inline size_t bcm2835_dma_count_frames_for_sg(struct bcm2835_chan *c,
  * @chan:           the @dma_chan for which we run this
  * @direction:      the direction in which we transfer
  * @cyclic:         it is a cyclic transfer
- * @info:           the default info bits to apply per controlblock
  * @frames:         number of controlblocks to allocate
  * @src:            the src address to assign
  * @dst:            the dst address to assign
@@ -379,25 +376,27 @@ static inline size_t bcm2835_dma_count_frames_for_sg(struct bcm2835_chan *c,
  * @period_len:     the period length when to apply @finalextrainfo
  *                  in addition to the last transfer
  *                  this will also break some control-blocks early
- * @finalextrainfo: additional bits in last controlblock
- *                  (or when period_len is reached in case of cyclic)
  * @gfp:            the GFP flag to use for allocation
+ * @flags
  */
 static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 					struct dma_chan *chan,
 					enum dma_transfer_direction direction,
-					bool cyclic, u32 info,
-					u32 finalextrainfo,
-					size_t frames, dma_addr_t src,
-					dma_addr_t dst, size_t buf_len,
-					size_t period_len, gfp_t gfp)
+					bool cyclic, size_t frames,
+					dma_addr_t src,	dma_addr_t dst,
+					size_t buf_len, size_t period_len,
+					gfp_t gfp, unsigned long flags)
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
@@ -411,6 +410,14 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
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
 	/*
 	 * Iterate over all frames, create a control block
 	 * for each frame and link them together.
@@ -424,7 +431,8 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 
 		/* fill in the control block */
 		control_block = cb_entry->cb;
-		control_block->info = info;
+		control_block->info = bcm2835_dma_prepare_cb_info(c, direction,
+								  zero_page);
 		control_block->src = src;
 		control_block->dst = dst;
 		control_block->stride = 0;
@@ -432,10 +440,12 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 		/* set up length in control_block if requested */
 		if (buf_len) {
 			/* calculate length honoring period_length */
-			bcm2835_dma_create_cb_set_length(c, control_block,
-							 len, period_len,
-							 &total_len,
-							 cyclic ? finalextrainfo : 0);
+			if (bcm2835_dma_create_cb_set_length(
+				c, control_block,
+				len, period_len, &total_len)) {
+				/* add extrainfo bits in info */
+				control_block->info |= extrainfo;
+			}
 
 			/* calculate new remaining length */
 			len -= control_block->length;
@@ -456,7 +466,9 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 	}
 
 	/* the last frame requires extra flags */
-	d->cb_list[d->frames - 1].cb->info |= finalextrainfo;
+	extrainfo = bcm2835_dma_prepare_cb_extra(c, direction, cyclic, true,
+						 flags);
+	d->cb_list[d->frames - 1].cb->info |= extrainfo;
 
 	/* detect a size mismatch */
 	if (buf_len && d->size != buf_len)
@@ -720,9 +732,6 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_memcpy(
 {
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_desc *d;
-	u32 info = bcm2835_dma_prepare_cb_info(c, DMA_MEM_TO_MEM, false);
-	u32 extra = bcm2835_dma_prepare_cb_extra(c, DMA_MEM_TO_MEM, false,
-						 true, 0);
 	size_t max_len = bcm2835_dma_max_frame_length(c);
 	size_t frames;
 
@@ -734,9 +743,8 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_memcpy(
 	frames = bcm2835_dma_frames_for_length(len, max_len);
 
 	/* allocate the CB chain - this also fills in the pointers */
-	d = bcm2835_dma_create_cb_chain(chan, DMA_MEM_TO_MEM, false,
-					info, extra, frames,
-					src, dst, len, 0, GFP_KERNEL);
+	d = bcm2835_dma_create_cb_chain(chan, DMA_MEM_TO_MEM, false, frames,
+					src, dst, len, 0, GFP_KERNEL, 0);
 	if (!d)
 		return NULL;
 
@@ -752,8 +760,6 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_slave_sg(
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_desc *d;
 	dma_addr_t src = 0, dst = 0;
-	u32 info = bcm2835_dma_prepare_cb_info(c, direction, false);
-	u32 extra = bcm2835_dma_prepare_cb_extra(c, direction, false, true, 0);
 	size_t frames;
 
 	if (!is_slave_direction(direction)) {
@@ -776,10 +782,8 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_slave_sg(
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
 
@@ -795,13 +799,9 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
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
 
@@ -852,10 +852,8 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
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
2.35.3


