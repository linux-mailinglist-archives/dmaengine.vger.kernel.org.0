Return-Path: <dmaengine+bounces-1981-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8958BBB33
	for <lists+dmaengine@lfdr.de>; Sat,  4 May 2024 14:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD021F21D46
	for <lists+dmaengine@lfdr.de>; Sat,  4 May 2024 12:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E4B2901;
	Sat,  4 May 2024 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnedLGBx"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E889F1C695
	for <dmaengine@vger.kernel.org>; Sat,  4 May 2024 12:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714825718; cv=none; b=AsP9remALGGuSLotSNJWfw2FVpJ9MjR8yPFyVFQg2f7d//cfURCkcSTVgDQdDm3rebv/f+oqztmTQgbi5rh3FZ6IBuSrAyz0A2Oe5Y3/BeFR8ArEEnBhIMuhmf8o12Ck5ecd1DvtIxRC87sIzprSLGAEeKP/brqD6ufaZxSHKLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714825718; c=relaxed/simple;
	bh=KnP465IC+3Nw5xdTWB06A2JDWAVk30Tb1K9tT0j30/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjOMI/0SFtofqaf5RcixFPAtqM1o4y5OvgwyxF4qRdix+7NbZT11c89kP6YDukDZO8ektRYy2XcqBEQKCVPcq/vgqcbbQ8+XHPq0cJKSIgXl9oYXMMKKb3GCjDZddVxRvFOmx57zSXygR3LJfFiMwbL3ejn7eLK8cWsux7i26i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnedLGBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A76BC072AA;
	Sat,  4 May 2024 12:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714825717;
	bh=KnP465IC+3Nw5xdTWB06A2JDWAVk30Tb1K9tT0j30/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KnedLGBxSEXAmXQ8BGvO5JSxXp8LQClvaar0R+Df2v8Y6LtOU5WmMshaoR15DnYNc
	 lIGaEB6iUadxIurXWrcUNeZXUBhiTMfoM3w1VXTVZzbI/blYMCjbjcFs9FnD3JajYa
	 4TwugFUtyHr4Cy4K5ACV+RdzOBN5mIf+a+9TqS10o2YVEg4tiW0bLQC2G3A8ve6y3S
	 SyaUdBahYQiV+WkubW3X281zMU4Sm88y6pMUfCzdmZTaLJMcTZuL4BNJlbrkx5Xx7X
	 I1e37F6iLhL9V5yRJv5KL53L5lGkH/S7qhPGgKwOLR1ovsXhgMvrwnOZAB3T5+eYi5
	 r1b7abbKzEMpA==
Date: Sat, 4 May 2024 17:58:31 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Eric Debief <debief@digigram.com>
Cc: dmaengine@vger.kernel.org
Subject: Re: [PATCH]: Fix DMAR Error NO_PASID when IOMMU is enabled
Message-ID: <ZjYp7958XYW5vn4a@matsya>
References: <CALYqZ9mmA5RUNn=vn9OxPToDCYzB3RS_3MC2rE9BEQzS4e_nSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALYqZ9mmA5RUNn=vn9OxPToDCYzB3RS_3MC2rE9BEQzS4e_nSQ@mail.gmail.com>

Hi Eric,

On 29-04-24, 15:49, Eric Debief wrote:
> Hi,
> 
> We had a "DMAR Error  NO PASID" error reported in the kernel's log
> when the IOMMU was enabled.
> 
> This is due to the missing WriteBack area for the C2H stream.
> Below my patch.
> One point : I didn't compile it within the latest kernel's sources'
> tree as it is an extract of our backport of the XDMA support.
> Feel free to contact me on any issue with this.

Again, I would request you to copy relevant folks.

Also patch formatting below is gone bad, pls resend with proper
formatting... (checkpatch is your friend, use it)


> 
> Hope this helps,
> Eric.
> 
> 
> ================================================
> >From 7db026854cd291677b08e8d137ef4238c8ea96db Mon Sep 17 00:00:00 2001
> From: Eric DEBIEF <debief@digigram.com>
> Date: Mon, 29 Apr 2024 15:36:24 +0200
> Subject: FIX: DMAR Error with IO_MMU.C2H write-back was not set and leads to
>  DMAR Error with IOMMU. Add the Writeback structure, allocate it, set it as
>  the Src field in the descriptor. Done for all preps functions.
> 
> ---
>  drivers/dma/xilinx/xdma.c | 41 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
> index 9c84211d26a1..306099c920bb 100644
> --- a/drivers/dma/xilinx/xdma.c
> +++ b/drivers/dma/xilinx/xdma.c
> @@ -51,6 +51,20 @@ struct xdma_desc_block {
>   dma_addr_t dma_addr;
>  };
> 
> +/**
> + * struct xdma_c2h_write_back  - Write back block , written by the XDMA.
> + * @magic_status_bit : magic (0x52B4) once written
> + * @length: effective transfer length (in bytes)
> + * @PADDING to be aligned on 32 bytes
> + * @associated dma address
> + */
> +struct xdma_c2h_write_back {
> + __le32 magic_status_bit;
> + __le32 length;
> + u32 padding_1[6];
> + dma_addr_t dma_addr;
> +};
> +
>  /**
>   * struct xdma_chan - Driver specific DMA channel structure
>   * @vchan: Virtual channel
> @@ -61,6 +75,8 @@ struct xdma_desc_block {
>   * @dir: Transferring direction of the channel
>   * @cfg: Transferring config of the channel
>   * @irq: IRQ assigned to the channel
> + * @write_back : C2H meta data write back
> +
>   */
>  struct xdma_chan {
>   struct virt_dma_chan vchan;
> @@ -73,6 +89,7 @@ struct xdma_chan {
>   u32 irq;
>   struct completion last_interrupt;
>   bool stop_requested;
> + struct xdma_c2h_write_back* write_back;
>  };
> 
>  /**
> @@ -628,7 +645,7 @@ xdma_prep_device_sg(struct dma_chan *chan, struct
> scatterlist *sgl,
>   src = &addr;
>   dst = &dev_addr;
>   } else {
> - dev_addr = xdma_chan->cfg.src_addr;
> + dev_addr = xdma_chan->cfg.src_addr ? xdma_chan->cfg.src_addr :
> xdma_chan->write_back->dma_addr;
>   src = &dev_addr;
>   dst = &addr;
>   }
> @@ -705,7 +722,7 @@ xdma_prep_dma_cyclic(struct dma_chan *chan,
> dma_addr_t address,
>   src = &addr;
>   dst = &dev_addr;
>   } else {
> - dev_addr = xdma_chan->cfg.src_addr;
> + dev_addr = xdma_chan->cfg.src_addr ? xdma_chan->cfg.src_addr :
> xdma_chan->write_back->dma_addr;
>   src = &dev_addr;
>   dst = &addr;
>   }
> @@ -803,6 +820,9 @@ static void xdma_free_chan_resources(struct dma_chan *chan)
>   struct xdma_chan *xdma_chan = to_xdma_chan(chan);
> 
>   vchan_free_chan_resources(&xdma_chan->vchan);
> + dma_pool_free(xdma_chan->desc_pool,
> + xdma_chan->write_back,
> +   xdma_chan->write_back->dma_addr);
>   dma_pool_destroy(xdma_chan->desc_pool);
>   xdma_chan->desc_pool = NULL;
>  }
> @@ -816,6 +836,7 @@ static int xdma_alloc_chan_resources(struct dma_chan *chan)
>   struct xdma_chan *xdma_chan = to_xdma_chan(chan);
>   struct xdma_device *xdev = xdma_chan->xdev_hdl;
>   struct device *dev = xdev->dma_dev.dev;
> + dma_addr_t write_back_addr;
> 
>   while (dev && !dev_is_pci(dev))
>   dev = dev->parent;
> @@ -824,13 +845,25 @@ static int xdma_alloc_chan_resources(struct
> dma_chan *chan)
>   return -EINVAL;
>   }
> 
> - xdma_chan->desc_pool = dma_pool_create(dma_chan_name(chan), dev,
> XDMA_DESC_BLOCK_SIZE,
> -       XDMA_DESC_BLOCK_ALIGN, XDMA_DESC_BLOCK_BOUNDARY);
> + //Allocate the pool WITH the H2C write back
> + xdma_chan->desc_pool = dma_pool_create(dma_chan_name(chan),
> + dev,
> + XDMA_DESC_BLOCK_SIZE + sizeof(struct xdma_c2h_write_back),
> + XDMA_DESC_BLOCK_ALIGN,
> + XDMA_DESC_BLOCK_BOUNDARY);
>   if (!xdma_chan->desc_pool) {
>   xdma_err(xdev, "unable to allocate descriptor pool");
>   return -ENOMEM;
>   }
> 
> + /* Allocate the C2H write back out of the pool*/
> + xdma_chan->write_back = dma_pool_alloc(xdma_chan->desc_pool,
> GFP_NOWAIT, &write_back_addr);
> + if (!xdma_chan->write_back) {
> + xdma_err(xdev, "unable to allocate C2H write back block");
> + return -ENOMEM;
> + }
> + xdma_chan->write_back->dma_addr = write_back_addr;
> +
>   return 0;
>  }
> 
> -- 
> 2.34.1
> 
> -- 
>  
> <https://www.digigram.com/digigram-critical-audio-at-critical-communications-world/>

-- 
~Vinod

