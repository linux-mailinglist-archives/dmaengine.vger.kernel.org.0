Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B99581321
	for <lists+dmaengine@lfdr.de>; Tue, 26 Jul 2022 14:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiGZM17 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Jul 2022 08:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiGZM17 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 Jul 2022 08:27:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3DE186C0
        for <dmaengine@vger.kernel.org>; Tue, 26 Jul 2022 05:27:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE6906145E
        for <dmaengine@vger.kernel.org>; Tue, 26 Jul 2022 12:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B845DC341C8;
        Tue, 26 Jul 2022 12:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658838477;
        bh=71WGJ+ddeaNYXnRcbdLsJLTfJ87onvlps03sKSKWcV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M1AIVihUFlMZe/kEA5CY+O4fvy0wk279ofzNNL3WNdtEmwtnhmUF82vcXmhshs5Iz
         vyFKbhr0BtMVPqmo8hrr+8yeoQB1rgMZ9/V3xTa4XmTqR7Qns04eS44jYmVKDJCJll
         HebxHnzZtcBNqD+8x/KsDuwLdloaTnueVBW8h7It16iolZpZ+Bh1CG0rnZbLAQijVs
         1XgP2bzS5Vp6gSxbvMLILZ0ddyGSbRTiEzvyKkne5zylM7iRoGkTu3+KVU10BroeiU
         pBfxps8jOj4uCs/QWCHcPKSpdnYX7CQGW+wv8ZWtqB80ImkLzCMB1Lv2MzhXYAwmub
         5+CKNsTGnlPgw==
Date:   Tue, 26 Jul 2022 17:57:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Adrian Larumbe <adrian.larumbe@collabora.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: Remove DMA_MEMCPY_SG operation as it has no
 consumers
Message-ID: <Yt/dyVXRQ3vxzufo@matsya>
References: <20220726094323.566140-1-adrian.larumbe@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726094323.566140-1-adrian.larumbe@collabora.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-07-22, 10:43, Adrian Larumbe wrote:
> There are no in kernel consumers for DMA_MEMCPY_SG. Remove operation and
> Xilinx CDMA driver code which implemented it.

What was this based on?
> 
> This reverts the following commits:

Did you see 0cae04373b77 ("dmaengine: remove DMA_MEMCPY_SG once again")

> 
> - commit 58fe10766048 ("dmaengine: Add documentation for new memcpy
> scatter-gather function")
> - commit 3218910fd585 ("dmaengine: Add core function and capability check
> for DMA_MEMCPY_SG")
> - commit 29cf37fa6dd9 ("dmaengine: Add consumer for the new DMA_MEMCPY_SG
> API function.")
> 
> Signed-off-by: Adrian Larumbe <adrian.larumbe@collabora.com>
> ---
>  .../driver-api/dmaengine/provider.rst         |  23 ----
>  drivers/dma/dmaengine.c                       |   7 -
>  drivers/dma/xilinx/xilinx_dma.c               | 122 ------------------
>  include/linux/dmaengine.h                     |  20 ---
>  4 files changed, 172 deletions(-)
> 
> diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
> index 1e0f1f85d10e..8cf704332bb4 100644
> --- a/Documentation/driver-api/dmaengine/provider.rst
> +++ b/Documentation/driver-api/dmaengine/provider.rst
> @@ -162,29 +162,6 @@ Currently, the types available are:
>  
>    - The device is able to do memory to memory copies
>  
> -- - DMA_MEMCPY_SG
> -
> -  - The device supports memory to memory scatter-gather transfers.
> -
> -  - Even though a plain memcpy can look like a particular case of a
> -    scatter-gather transfer, with a single chunk to copy, it's a distinct
> -    transaction type in the mem2mem transfer case. This is because some very
> -    simple devices might be able to do contiguous single-chunk memory copies,
> -    but have no support for more complex SG transfers.
> -
> -  - No matter what the overall size of the combined chunks for source and
> -    destination is, only as many bytes as the smallest of the two will be
> -    transmitted. That means the number and size of the scatter-gather buffers in
> -    both lists need not be the same, and that the operation functionally is
> -    equivalent to a ``strncpy`` where the ``count`` argument equals the smallest
> -    total size of the two scatter-gather list buffers.
> -
> -  - It's usually used for copying pixel data between host memory and
> -    memory-mapped GPU device memory, such as found on modern PCI video graphics
> -    cards. The most immediate example is the OpenGL API function
> -    ``glReadPielx()``, which might require a verbatim copy of a huge framebuffer
> -    from local device memory onto host memory.
> -
>  - DMA_XOR
>  
>    - The device is able to perform XOR operations on memory areas
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index e80feeea0e01..c741b6431958 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -1153,13 +1153,6 @@ int dma_async_device_register(struct dma_device *device)
>  		return -EIO;
>  	}
>  
> -	if (dma_has_cap(DMA_MEMCPY_SG, device->cap_mask) && !device->device_prep_dma_memcpy_sg) {
> -		dev_err(device->dev,
> -			"Device claims capability %s, but op is not defined\n",
> -			"DMA_MEMCPY_SG");
> -		return -EIO;
> -	}
> -
>  	if (dma_has_cap(DMA_XOR, device->cap_mask) && !device->device_prep_dma_xor) {
>  		dev_err(device->dev,
>  			"Device claims capability %s, but op is not defined\n",
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index cd62bbb50e8b..6276934d4d2b 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -2127,126 +2127,6 @@ xilinx_cdma_prep_memcpy(struct dma_chan *dchan, dma_addr_t dma_dst,
>  	return NULL;
>  }
>  
> -/**
> - * xilinx_cdma_prep_memcpy_sg - prepare descriptors for a memcpy_sg transaction
> - * @dchan: DMA channel
> - * @dst_sg: Destination scatter list
> - * @dst_sg_len: Number of entries in destination scatter list
> - * @src_sg: Source scatter list
> - * @src_sg_len: Number of entries in source scatter list
> - * @flags: transfer ack flags
> - *
> - * Return: Async transaction descriptor on success and NULL on failure
> - */
> -static struct dma_async_tx_descriptor *xilinx_cdma_prep_memcpy_sg(
> -			struct dma_chan *dchan, struct scatterlist *dst_sg,
> -			unsigned int dst_sg_len, struct scatterlist *src_sg,
> -			unsigned int src_sg_len, unsigned long flags)
> -{
> -	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
> -	struct xilinx_dma_tx_descriptor *desc;
> -	struct xilinx_cdma_tx_segment *segment, *prev = NULL;
> -	struct xilinx_cdma_desc_hw *hw;
> -	size_t len, dst_avail, src_avail;
> -	dma_addr_t dma_dst, dma_src;
> -
> -	if (unlikely(dst_sg_len == 0 || src_sg_len == 0))
> -		return NULL;
> -
> -	if (unlikely(!dst_sg  || !src_sg))
> -		return NULL;
> -
> -	desc = xilinx_dma_alloc_tx_descriptor(chan);
> -	if (!desc)
> -		return NULL;
> -
> -	dma_async_tx_descriptor_init(&desc->async_tx, &chan->common);
> -	desc->async_tx.tx_submit = xilinx_dma_tx_submit;
> -
> -	dst_avail = sg_dma_len(dst_sg);
> -	src_avail = sg_dma_len(src_sg);
> -	/*
> -	 * loop until there is either no more source or no more destination
> -	 * scatterlist entry
> -	 */
> -	while (true) {
> -		len = min_t(size_t, src_avail, dst_avail);
> -		len = min_t(size_t, len, chan->xdev->max_buffer_len);
> -		if (len == 0)
> -			goto fetch;
> -
> -		/* Allocate the link descriptor from DMA pool */
> -		segment = xilinx_cdma_alloc_tx_segment(chan);
> -		if (!segment)
> -			goto error;
> -
> -		dma_dst = sg_dma_address(dst_sg) + sg_dma_len(dst_sg) -
> -			dst_avail;
> -		dma_src = sg_dma_address(src_sg) + sg_dma_len(src_sg) -
> -			src_avail;
> -		hw = &segment->hw;
> -		hw->control = len;
> -		hw->src_addr = dma_src;
> -		hw->dest_addr = dma_dst;
> -		if (chan->ext_addr) {
> -			hw->src_addr_msb = upper_32_bits(dma_src);
> -			hw->dest_addr_msb = upper_32_bits(dma_dst);
> -		}
> -
> -		if (prev) {
> -			prev->hw.next_desc = segment->phys;
> -			if (chan->ext_addr)
> -				prev->hw.next_desc_msb =
> -					upper_32_bits(segment->phys);
> -		}
> -
> -		prev = segment;
> -		dst_avail -= len;
> -		src_avail -= len;
> -		list_add_tail(&segment->node, &desc->segments);
> -
> -fetch:
> -		/* Fetch the next dst scatterlist entry */
> -		if (dst_avail == 0) {
> -			if (dst_sg_len == 0)
> -				break;
> -			dst_sg = sg_next(dst_sg);
> -			if (dst_sg == NULL)
> -				break;
> -			dst_sg_len--;
> -			dst_avail = sg_dma_len(dst_sg);
> -		}
> -		/* Fetch the next src scatterlist entry */
> -		if (src_avail == 0) {
> -			if (src_sg_len == 0)
> -				break;
> -			src_sg = sg_next(src_sg);
> -			if (src_sg == NULL)
> -				break;
> -			src_sg_len--;
> -			src_avail = sg_dma_len(src_sg);
> -		}
> -	}
> -
> -	if (list_empty(&desc->segments)) {
> -		dev_err(chan->xdev->dev,
> -			"%s: Zero-size SG transfer requested\n", __func__);
> -		goto error;
> -	}
> -
> -	/* Link the last hardware descriptor with the first. */
> -	segment = list_first_entry(&desc->segments,
> -				struct xilinx_cdma_tx_segment, node);
> -	desc->async_tx.phys = segment->phys;
> -	prev->hw.next_desc = segment->phys;
> -
> -	return &desc->async_tx;
> -
> -error:
> -	xilinx_dma_free_tx_descriptor(chan, desc);
> -	return NULL;
> -}
> -
>  /**
>   * xilinx_dma_prep_slave_sg - prepare descriptors for a DMA_SLAVE transaction
>   * @dchan: DMA channel
> @@ -3240,9 +3120,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
>  					  DMA_RESIDUE_GRANULARITY_SEGMENT;
>  	} else if (xdev->dma_config->dmatype == XDMA_TYPE_CDMA) {
>  		dma_cap_set(DMA_MEMCPY, xdev->common.cap_mask);
> -		dma_cap_set(DMA_MEMCPY_SG, xdev->common.cap_mask);
>  		xdev->common.device_prep_dma_memcpy = xilinx_cdma_prep_memcpy;
> -		xdev->common.device_prep_dma_memcpy_sg = xilinx_cdma_prep_memcpy_sg;
>  		/* Residue calculation is supported by only AXI DMA and CDMA */
>  		xdev->common.residue_granularity =
>  					  DMA_RESIDUE_GRANULARITY_SEGMENT;
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index b46b88e6aa0d..c923f4e60f24 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -50,7 +50,6 @@ enum dma_status {
>   */
>  enum dma_transaction_type {
>  	DMA_MEMCPY,
> -	DMA_MEMCPY_SG,
>  	DMA_XOR,
>  	DMA_PQ,
>  	DMA_XOR_VAL,
> @@ -887,11 +886,6 @@ struct dma_device {
>  	struct dma_async_tx_descriptor *(*device_prep_dma_memcpy)(
>  		struct dma_chan *chan, dma_addr_t dst, dma_addr_t src,
>  		size_t len, unsigned long flags);
> -	struct dma_async_tx_descriptor *(*device_prep_dma_memcpy_sg)(
> -		struct dma_chan *chan,
> -		struct scatterlist *dst_sg, unsigned int dst_nents,
> -		struct scatterlist *src_sg, unsigned int src_nents,
> -		unsigned long flags);
>  	struct dma_async_tx_descriptor *(*device_prep_dma_xor)(
>  		struct dma_chan *chan, dma_addr_t dst, dma_addr_t *src,
>  		unsigned int src_cnt, size_t len, unsigned long flags);
> @@ -1060,20 +1054,6 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_memcpy(
>  						    len, flags);
>  }
>  
> -static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_memcpy_sg(
> -		struct dma_chan *chan,
> -		struct scatterlist *dst_sg, unsigned int dst_nents,
> -		struct scatterlist *src_sg, unsigned int src_nents,
> -		unsigned long flags)
> -{
> -	if (!chan || !chan->device || !chan->device->device_prep_dma_memcpy_sg)
> -		return NULL;
> -
> -	return chan->device->device_prep_dma_memcpy_sg(chan, dst_sg, dst_nents,
> -						       src_sg, src_nents,
> -						       flags);
> -}
> -
>  static inline bool dmaengine_is_metadata_mode_supported(struct dma_chan *chan,
>  		enum dma_desc_metadata_mode mode)
>  {
> -- 
> 2.37.0

-- 
~Vinod
