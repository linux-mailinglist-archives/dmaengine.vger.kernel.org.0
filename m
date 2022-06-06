Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C55653E312
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jun 2022 10:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiFFHrs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Jun 2022 03:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiFFHrr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Jun 2022 03:47:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0836558C;
        Mon,  6 Jun 2022 00:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=rLJqO2vDd/zBYDlbCoOVEpqKg4WSe962MJwSjo+PSnk=; b=lRw+8GaB9nmv3os8bawHrr1L1r
        XDUxKvG6pQT6dtOYkkssGheemnPBeRXZc7D4wcYNOTTj9kQ88GLoE9nWDW2uSrOXyAbitGgA6uHEn
        t/M7FRNUnr/CQDBTwKYAchbC4udMN7qPQz7YhsfDDZqJqw9Njz/d2v/euqFwLd3pzsKCr3/z6kvxg
        ywTDvHIWEJOgMbeqKnk/HxMOGv1fiJNo8ks3bT6B6xC0Sasq0fQ0Jwgkt40BA6EzyhGMnFkVh4Kxo
        mqeD78oYIEkUOmvuF+4RB3g42N1yQJze3jk2RewSVBK8krzvQpLtluuxRHDy+NYwGNL5epHFaVUul
        fKQSbbQA==;
Received: from [2001:4bb8:190:726c:bbd1:d45d:a235:6422] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ny7Sa-00HZ9k-9B; Mon, 06 Jun 2022 07:47:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     vkoul@kernel.org
Cc:     michal.simek@xilinx.com, adrianml@alumnos.upm.es,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dmaengine: remove DMA_MEMCPY_SG once again
Date:   Mon,  6 Jun 2022 09:47:33 +0200
Message-Id: <20220606074733.622616-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This was removed before due to the complete lack of users, but
3218910fd585 ("dmaengine: Add core function and capability check for
DMA_MEMCPY_SG") and 29cf37fa6dd9 ("dmaengine: Add consumer for the new
DMA_MEMCPY_SG API function.") added it back despite still not having
any users whatsoever.

Fixes: 3218910fd585 ("dmaengine: Add core function and capability check for DMA_MEMCPY_SG")
Fixes: 29cf37fa6dd9 ("dmaengine: Add consumer for the new DMA_MEMCPY_SG API function.")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 .../driver-api/dmaengine/provider.rst         |  10 --
 drivers/dma/dmaengine.c                       |   7 -
 drivers/dma/xilinx/xilinx_dma.c               | 122 ------------------
 include/linux/dmaengine.h                     |  20 ---
 4 files changed, 159 deletions(-)

diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
index 1e0f1f85d10e5..ceac2a300e328 100644
--- a/Documentation/driver-api/dmaengine/provider.rst
+++ b/Documentation/driver-api/dmaengine/provider.rst
@@ -162,16 +162,6 @@ Currently, the types available are:
 
   - The device is able to do memory to memory copies
 
-- - DMA_MEMCPY_SG
-
-  - The device supports memory to memory scatter-gather transfers.
-
-  - Even though a plain memcpy can look like a particular case of a
-    scatter-gather transfer, with a single chunk to copy, it's a distinct
-    transaction type in the mem2mem transfer case. This is because some very
-    simple devices might be able to do contiguous single-chunk memory copies,
-    but have no support for more complex SG transfers.
-
   - No matter what the overall size of the combined chunks for source and
     destination is, only as many bytes as the smallest of the two will be
     transmitted. That means the number and size of the scatter-gather buffers in
diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index e80feeea0e018..c741b6431958c 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1153,13 +1153,6 @@ int dma_async_device_register(struct dma_device *device)
 		return -EIO;
 	}
 
-	if (dma_has_cap(DMA_MEMCPY_SG, device->cap_mask) && !device->device_prep_dma_memcpy_sg) {
-		dev_err(device->dev,
-			"Device claims capability %s, but op is not defined\n",
-			"DMA_MEMCPY_SG");
-		return -EIO;
-	}
-
 	if (dma_has_cap(DMA_XOR, device->cap_mask) && !device->device_prep_dma_xor) {
 		dev_err(device->dev,
 			"Device claims capability %s, but op is not defined\n",
diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index cd62bbb50e8b4..6276934d4d2be 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -2127,126 +2127,6 @@ xilinx_cdma_prep_memcpy(struct dma_chan *dchan, dma_addr_t dma_dst,
 	return NULL;
 }
 
-/**
- * xilinx_cdma_prep_memcpy_sg - prepare descriptors for a memcpy_sg transaction
- * @dchan: DMA channel
- * @dst_sg: Destination scatter list
- * @dst_sg_len: Number of entries in destination scatter list
- * @src_sg: Source scatter list
- * @src_sg_len: Number of entries in source scatter list
- * @flags: transfer ack flags
- *
- * Return: Async transaction descriptor on success and NULL on failure
- */
-static struct dma_async_tx_descriptor *xilinx_cdma_prep_memcpy_sg(
-			struct dma_chan *dchan, struct scatterlist *dst_sg,
-			unsigned int dst_sg_len, struct scatterlist *src_sg,
-			unsigned int src_sg_len, unsigned long flags)
-{
-	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
-	struct xilinx_dma_tx_descriptor *desc;
-	struct xilinx_cdma_tx_segment *segment, *prev = NULL;
-	struct xilinx_cdma_desc_hw *hw;
-	size_t len, dst_avail, src_avail;
-	dma_addr_t dma_dst, dma_src;
-
-	if (unlikely(dst_sg_len == 0 || src_sg_len == 0))
-		return NULL;
-
-	if (unlikely(!dst_sg  || !src_sg))
-		return NULL;
-
-	desc = xilinx_dma_alloc_tx_descriptor(chan);
-	if (!desc)
-		return NULL;
-
-	dma_async_tx_descriptor_init(&desc->async_tx, &chan->common);
-	desc->async_tx.tx_submit = xilinx_dma_tx_submit;
-
-	dst_avail = sg_dma_len(dst_sg);
-	src_avail = sg_dma_len(src_sg);
-	/*
-	 * loop until there is either no more source or no more destination
-	 * scatterlist entry
-	 */
-	while (true) {
-		len = min_t(size_t, src_avail, dst_avail);
-		len = min_t(size_t, len, chan->xdev->max_buffer_len);
-		if (len == 0)
-			goto fetch;
-
-		/* Allocate the link descriptor from DMA pool */
-		segment = xilinx_cdma_alloc_tx_segment(chan);
-		if (!segment)
-			goto error;
-
-		dma_dst = sg_dma_address(dst_sg) + sg_dma_len(dst_sg) -
-			dst_avail;
-		dma_src = sg_dma_address(src_sg) + sg_dma_len(src_sg) -
-			src_avail;
-		hw = &segment->hw;
-		hw->control = len;
-		hw->src_addr = dma_src;
-		hw->dest_addr = dma_dst;
-		if (chan->ext_addr) {
-			hw->src_addr_msb = upper_32_bits(dma_src);
-			hw->dest_addr_msb = upper_32_bits(dma_dst);
-		}
-
-		if (prev) {
-			prev->hw.next_desc = segment->phys;
-			if (chan->ext_addr)
-				prev->hw.next_desc_msb =
-					upper_32_bits(segment->phys);
-		}
-
-		prev = segment;
-		dst_avail -= len;
-		src_avail -= len;
-		list_add_tail(&segment->node, &desc->segments);
-
-fetch:
-		/* Fetch the next dst scatterlist entry */
-		if (dst_avail == 0) {
-			if (dst_sg_len == 0)
-				break;
-			dst_sg = sg_next(dst_sg);
-			if (dst_sg == NULL)
-				break;
-			dst_sg_len--;
-			dst_avail = sg_dma_len(dst_sg);
-		}
-		/* Fetch the next src scatterlist entry */
-		if (src_avail == 0) {
-			if (src_sg_len == 0)
-				break;
-			src_sg = sg_next(src_sg);
-			if (src_sg == NULL)
-				break;
-			src_sg_len--;
-			src_avail = sg_dma_len(src_sg);
-		}
-	}
-
-	if (list_empty(&desc->segments)) {
-		dev_err(chan->xdev->dev,
-			"%s: Zero-size SG transfer requested\n", __func__);
-		goto error;
-	}
-
-	/* Link the last hardware descriptor with the first. */
-	segment = list_first_entry(&desc->segments,
-				struct xilinx_cdma_tx_segment, node);
-	desc->async_tx.phys = segment->phys;
-	prev->hw.next_desc = segment->phys;
-
-	return &desc->async_tx;
-
-error:
-	xilinx_dma_free_tx_descriptor(chan, desc);
-	return NULL;
-}
-
 /**
  * xilinx_dma_prep_slave_sg - prepare descriptors for a DMA_SLAVE transaction
  * @dchan: DMA channel
@@ -3240,9 +3120,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 					  DMA_RESIDUE_GRANULARITY_SEGMENT;
 	} else if (xdev->dma_config->dmatype == XDMA_TYPE_CDMA) {
 		dma_cap_set(DMA_MEMCPY, xdev->common.cap_mask);
-		dma_cap_set(DMA_MEMCPY_SG, xdev->common.cap_mask);
 		xdev->common.device_prep_dma_memcpy = xilinx_cdma_prep_memcpy;
-		xdev->common.device_prep_dma_memcpy_sg = xilinx_cdma_prep_memcpy_sg;
 		/* Residue calculation is supported by only AXI DMA and CDMA */
 		xdev->common.residue_granularity =
 					  DMA_RESIDUE_GRANULARITY_SEGMENT;
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index b46b88e6aa0d1..c923f4e60f240 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -50,7 +50,6 @@ enum dma_status {
  */
 enum dma_transaction_type {
 	DMA_MEMCPY,
-	DMA_MEMCPY_SG,
 	DMA_XOR,
 	DMA_PQ,
 	DMA_XOR_VAL,
@@ -887,11 +886,6 @@ struct dma_device {
 	struct dma_async_tx_descriptor *(*device_prep_dma_memcpy)(
 		struct dma_chan *chan, dma_addr_t dst, dma_addr_t src,
 		size_t len, unsigned long flags);
-	struct dma_async_tx_descriptor *(*device_prep_dma_memcpy_sg)(
-		struct dma_chan *chan,
-		struct scatterlist *dst_sg, unsigned int dst_nents,
-		struct scatterlist *src_sg, unsigned int src_nents,
-		unsigned long flags);
 	struct dma_async_tx_descriptor *(*device_prep_dma_xor)(
 		struct dma_chan *chan, dma_addr_t dst, dma_addr_t *src,
 		unsigned int src_cnt, size_t len, unsigned long flags);
@@ -1060,20 +1054,6 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_memcpy(
 						    len, flags);
 }
 
-static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_memcpy_sg(
-		struct dma_chan *chan,
-		struct scatterlist *dst_sg, unsigned int dst_nents,
-		struct scatterlist *src_sg, unsigned int src_nents,
-		unsigned long flags)
-{
-	if (!chan || !chan->device || !chan->device->device_prep_dma_memcpy_sg)
-		return NULL;
-
-	return chan->device->device_prep_dma_memcpy_sg(chan, dst_sg, dst_nents,
-						       src_sg, src_nents,
-						       flags);
-}
-
 static inline bool dmaengine_is_metadata_mode_supported(struct dma_chan *chan,
 		enum dma_desc_metadata_mode mode)
 {
-- 
2.30.2

