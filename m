Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671DC3C7DB8
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 06:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237798AbhGNFBc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jul 2021 01:01:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhGNFBb (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Jul 2021 01:01:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05EAF613B0;
        Wed, 14 Jul 2021 04:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626238720;
        bh=57uyjWb1vkjk8cZqvrEzkwC2Qt1GOznoyRM/A/pQdlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b/fJ/IspzfCGsykNR+zzUiqyBw3iY2ELv1ffvswxOC5HCz2mVuL9grGlYpct4awNa
         ZFsDUjh/aCyD1xN9mJWJLqIjVarN7EJhHlM53alIf6NFjQRzxQJqQj/Z8PxqzEf8L4
         Ugtyuhr4i8KwWId/hqwaMwQjTCpF7EPRu57C7I1xihpTiEPVj3v8kLbdk99y4z8hBz
         +N61annmNbdP5l6F425SdPysbXHQvhysEv73GNXz8KWZQVe3zATCSUXzPCPb2czuDw
         U/E9JABQ9MGHeXJetMa9zHCptALQ4WW96+LEJHzrCZl+LDgacf7SJgeSw3hdOUvzVP
         YN0lQd+vH0BeA==
Date:   Wed, 14 Jul 2021 10:28:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Adrian Larumbe <adrian.martinezlarumbe@imgtec.com>
Cc:     dmaengine@vger.kernel.org, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dmaengine: xilinx_dma: Restore support for memcpy SG
 transfers
Message-ID: <YO5u/ZK4njSpYrwN@matsya>
References: <20210706234338.7696-1-adrian.martinezlarumbe@imgtec.com>
 <20210706234338.7696-2-adrian.martinezlarumbe@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706234338.7696-2-adrian.martinezlarumbe@imgtec.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-07-21, 00:43, Adrian Larumbe wrote:
> This is the old DMA_SG interface that was removed in commit
> c678fa66341c ("dmaengine: remove DMA_SG as it is dead code in kernel"). It
> has been renamed to DMA_MEMCPY_SG to better match the MEMSET and MEMSET_SG
> naming convention.
> 
> It should only be used for mem2mem copies, either main system memory or
> CPU-addressable device memory (like video memory on a PCI graphics card).
> 
> Bringing back this interface was prompted by the need to use the Xilinx
> CDMA device for mem2mem SG transfers. The current CDMA binding for
> device_prep_dma_memcpy_sg was partially borrowed from xlnx kernel tree, and
> expanded with extended address space support when linking descriptor
> segments and checking for incorrect zero transfer size.
> 
> Signed-off-by: Adrian Larumbe <adrian.martinezlarumbe@imgtec.com>
> ---
>  .../driver-api/dmaengine/provider.rst         |  11 ++
>  drivers/dma/dmaengine.c                       |   7 +
>  drivers/dma/xilinx/xilinx_dma.c               | 122 ++++++++++++++++++

Can you make this split... documentation patch, core change and then
driver

>  include/linux/dmaengine.h                     |  20 +++
>  4 files changed, 160 insertions(+)
> 
> diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
> index ddb0a81a796c..9f0efe9e9952 100644
> --- a/Documentation/driver-api/dmaengine/provider.rst
> +++ b/Documentation/driver-api/dmaengine/provider.rst
> @@ -162,6 +162,17 @@ Currently, the types available are:
>  
>    - The device is able to do memory to memory copies
>  
> +- - DMA_MEMCPY_SG
> +
> +  - The device supports memory to memory scatter-gather transfers.
> +
> +  - Even though a plain memcpy can look like a particular case of a
> +    scatter-gather transfer, with a single chunk to transfer, it's a
> +    distinct transaction type in the mem2mem transfer case. This is
> +    because some very simple devices might be able to do contiguous
> +    single-chunk memory copies, but have no support for more
> +    complex SG transfers.

How does one deal with cases where
 - src_sg_len and dstn_sg_len are different?
 - src_sg and dstn_sg are different lists (maybe different number of
   entries with different lengths..)

I think we need to document these cases or limitations..


> +
>  - DMA_XOR
>  
>    - The device is able to perform XOR operations on memory areas
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index af3ee288bc11..c4e3334b04cf 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -1160,6 +1160,13 @@ int dma_async_device_register(struct dma_device *device)
>  		return -EIO;
>  	}
>  
> +	if (dma_has_cap(DMA_MEMCPY_SG, device->cap_mask) && !device->device_prep_dma_memcpy_sg) {
> +		dev_err(device->dev,
> +			"Device claims capability %s, but op is not defined\n",
> +			"DMA_MEMCPY_SG");
> +		return -EIO;
> +	}
> +
>  	if (dma_has_cap(DMA_XOR, device->cap_mask) && !device->device_prep_dma_xor) {
>  		dev_err(device->dev,
>  			"Device claims capability %s, but op is not defined\n",
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 75c0b8e904e5..0e2bf75d42d3 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -2108,6 +2108,126 @@ xilinx_cdma_prep_memcpy(struct dma_chan *dchan, dma_addr_t dma_dst,
>  	return NULL;
>  }
>  
> +/**
> + * xilinx_cdma_prep_memcpy_sg - prepare descriptors for a memcpy_sg transaction
> + * @dchan: DMA channel
> + * @dst_sg: Destination scatter list
> + * @dst_sg_len: Number of entries in destination scatter list
> + * @src_sg: Source scatter list
> + * @src_sg_len: Number of entries in source scatter list
> + * @flags: transfer ack flags
> + *
> + * Return: Async transaction descriptor on success and NULL on failure
> + */
> +static struct dma_async_tx_descriptor *xilinx_cdma_prep_memcpy_sg(
> +			struct dma_chan *dchan, struct scatterlist *dst_sg,
> +			unsigned int dst_sg_len, struct scatterlist *src_sg,
> +			unsigned int src_sg_len, unsigned long flags)
> +{
> +	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
> +	struct xilinx_dma_tx_descriptor *desc;
> +	struct xilinx_cdma_tx_segment *segment, *prev = NULL;
> +	struct xilinx_cdma_desc_hw *hw;
> +	size_t len, dst_avail, src_avail;
> +	dma_addr_t dma_dst, dma_src;
> +
> +	if (unlikely(dst_sg_len == 0 || src_sg_len == 0))
> +		return NULL;
> +
> +	if (unlikely(!dst_sg  || !src_sg))
> +		return NULL;

no check for dst_sg_len == src_sg_len or it doesnt matter here?

> +
> +	desc = xilinx_dma_alloc_tx_descriptor(chan);
> +	if (!desc)
> +		return NULL;
> +
> +	dma_async_tx_descriptor_init(&desc->async_tx, &chan->common);
> +	desc->async_tx.tx_submit = xilinx_dma_tx_submit;
> +
> +	dst_avail = sg_dma_len(dst_sg);
> +	src_avail = sg_dma_len(src_sg);
> +	/*
> +	 * loop until there is either no more source or no more destination
> +	 * scatterlist entry
> +	 */
> +	while (true) {
> +		len = min_t(size_t, src_avail, dst_avail);
> +		len = min_t(size_t, len, chan->xdev->max_buffer_len);
> +		if (len == 0)
> +			goto fetch;
> +
> +		/* Allocate the link descriptor from DMA pool */
> +		segment = xilinx_cdma_alloc_tx_segment(chan);
> +		if (!segment)
> +			goto error;
> +
> +		dma_dst = sg_dma_address(dst_sg) + sg_dma_len(dst_sg) -
> +			dst_avail;
> +		dma_src = sg_dma_address(src_sg) + sg_dma_len(src_sg) -
> +			src_avail;
> +		hw = &segment->hw;
> +		hw->control = len;
> +		hw->src_addr = dma_src;
> +		hw->dest_addr = dma_dst;
> +		if (chan->ext_addr) {
> +			hw->src_addr_msb = upper_32_bits(dma_src);
> +			hw->dest_addr_msb = upper_32_bits(dma_dst);
> +		}
> +
> +		if (prev) {
> +			prev->hw.next_desc = segment->phys;
> +			if (chan->ext_addr)
> +				prev->hw.next_desc_msb =
> +					upper_32_bits(segment->phys);
> +		}
> +
> +		prev = segment;
> +		dst_avail -= len;
> +		src_avail -= len;
> +		list_add_tail(&segment->node, &desc->segments);
> +
> +fetch:
> +		/* Fetch the next dst scatterlist entry */
> +		if (dst_avail == 0) {
> +			if (dst_sg_len == 0)
> +				break;
> +			dst_sg = sg_next(dst_sg);
> +			if (dst_sg == NULL)
> +				break;
> +			dst_sg_len--;
> +			dst_avail = sg_dma_len(dst_sg);
> +		}
> +		/* Fetch the next src scatterlist entry */
> +		if (src_avail == 0) {
> +			if (src_sg_len == 0)
> +				break;
> +			src_sg = sg_next(src_sg);
> +			if (src_sg == NULL)
> +				break;
> +			src_sg_len--;
> +			src_avail = sg_dma_len(src_sg);
> +		}
> +	}
> +
> +	if (list_empty(&desc->segments)) {
> +		dev_err(chan->xdev->dev,
> +			"%s: Zero-size SG transfer requested\n", __func__);
> +		goto error;
> +	}
> +
> +	/* Link the last hardware descriptor with the first. */
> +	segment = list_first_entry(&desc->segments,
> +				struct xilinx_cdma_tx_segment, node);
> +	desc->async_tx.phys = segment->phys;
> +	prev->hw.next_desc = segment->phys;
> +
> +	return &desc->async_tx;
> +
> +error:
> +	xilinx_dma_free_tx_descriptor(chan, desc);
> +	return NULL;
> +}
> +
>  /**
>   * xilinx_dma_prep_slave_sg - prepare descriptors for a DMA_SLAVE transaction
>   * @dchan: DMA channel
> @@ -3094,7 +3214,9 @@ static int xilinx_dma_probe(struct platform_device *pdev)
>  					  DMA_RESIDUE_GRANULARITY_SEGMENT;
>  	} else if (xdev->dma_config->dmatype == XDMA_TYPE_CDMA) {
>  		dma_cap_set(DMA_MEMCPY, xdev->common.cap_mask);
> +		dma_cap_set(DMA_MEMCPY_SG, xdev->common.cap_mask);
>  		xdev->common.device_prep_dma_memcpy = xilinx_cdma_prep_memcpy;
> +		xdev->common.device_prep_dma_memcpy_sg = xilinx_cdma_prep_memcpy_sg;
>  		/* Residue calculation is supported by only AXI DMA and CDMA */
>  		xdev->common.residue_granularity =
>  					  DMA_RESIDUE_GRANULARITY_SEGMENT;
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 004736b6a9c8..7c342f77d8eb 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -50,6 +50,7 @@ enum dma_status {
>   */
>  enum dma_transaction_type {
>  	DMA_MEMCPY,
> +	DMA_MEMCPY_SG,
>  	DMA_XOR,
>  	DMA_PQ,
>  	DMA_XOR_VAL,
> @@ -891,6 +892,11 @@ struct dma_device {
>  	struct dma_async_tx_descriptor *(*device_prep_dma_memcpy)(
>  		struct dma_chan *chan, dma_addr_t dst, dma_addr_t src,
>  		size_t len, unsigned long flags);
> +	struct dma_async_tx_descriptor *(*device_prep_dma_memcpy_sg)(
> +		struct dma_chan *chan,
> +		struct scatterlist *dst_sg, unsigned int dst_nents,
> +		struct scatterlist *src_sg, unsigned int src_nents,
> +		unsigned long flags);
>  	struct dma_async_tx_descriptor *(*device_prep_dma_xor)(
>  		struct dma_chan *chan, dma_addr_t dst, dma_addr_t *src,
>  		unsigned int src_cnt, size_t len, unsigned long flags);
> @@ -1053,6 +1059,20 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_memcpy(
>  						    len, flags);
>  }
>  
> +static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_memcpy_sg(
> +		struct dma_chan *chan,
> +		struct scatterlist *dst_sg, unsigned int dst_nents,
> +		struct scatterlist *src_sg, unsigned int src_nents,
> +		unsigned long flags)
> +{
> +	if (!chan || !chan->device || !chan->device->device_prep_dma_memcpy_sg)
> +		return NULL;
> +
> +	return chan->device->device_prep_dma_memcpy_sg(chan, dst_sg, dst_nents,
> +						       src_sg, src_nents,
> +						       flags);
> +}
> +
>  static inline bool dmaengine_is_metadata_mode_supported(struct dma_chan *chan,
>  		enum dma_desc_metadata_mode mode)
>  {
> -- 
> 2.17.1

-- 
~Vinod
