Return-Path: <dmaengine+bounces-2335-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BCF904225
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 19:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2541C2301B
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 17:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F1F3D971;
	Tue, 11 Jun 2024 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1lU0Dfa"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D351A1D556
	for <dmaengine@vger.kernel.org>; Tue, 11 Jun 2024 17:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718125756; cv=none; b=Xocu6wZOc5V4uw4OVos/UmI0J7YCZnvVJ5P74Zxr20R2xitKurMwXGRIOiAmdjaU2SLEgfVfVpCm0brwN6fgHjNBDWnqQwctFewLqa1JJfm8EPZD65sg42AKllirK12U8DfPy5YjRHshLNnLClOeLnxxZCTfairOieRH8rbZcY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718125756; c=relaxed/simple;
	bh=cFSK5nmT7LP10kC71IXmKt1WwLwkc2kijAGZKRVRAV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jG7k+kQuzG5msemHOo8UMQ6IWPi3lnqiRt0z6RPo0u99B/Uljg/d2VJ2H8BDeZm5SecxAUshyfrMjZi+rWyah9/We0mAI/vae0MBalIK2Mdv2Zof96tYUw9X8GBO8KkQ1e/o7qGVIYUdmKlzCANq9qrbSe7zzpfLqRkxK7NEfhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1lU0Dfa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049ABC2BD10;
	Tue, 11 Jun 2024 17:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718125756;
	bh=cFSK5nmT7LP10kC71IXmKt1WwLwkc2kijAGZKRVRAV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L1lU0DfaIc5noEupfGys7AMToZOQn4puJZ6GGTQiyxQfKPOHyMN2Aru/5CEoRDRr7
	 DPqd6EweyPhhRaxdFuThs7nA8hj3rmpNvlwA+Hatd0DimKJwaMpuAt1u7lEGSjdZ7a
	 u5XwGtrdfXMv6Zmd5c9wpiDWuiGItP/j1RlDr6kcOGcfRijQzFPPnKN9ae/pjTGm6U
	 BCmOd8LERLdjVTXrk6vo2wdJ2ZyweMorCY6Pc5ukEX9zk7jeJEqnRzBsgfwquRlaQj
	 76I/G4BIcUhrkfOLHD7ZqpOFocsdWe2x767I9O+uxeGvXYQg8v3E2YPw1t0Zswf8c7
	 t5i83ulMMeAKQ==
Date: Tue, 11 Jun 2024 22:39:13 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Eric Debief <debief@digigram.com>
Cc: dmaengine@vger.kernel.org, Lizhi Hou <lizhi.hou@amd.com>
Subject: Re: [PATCH 1/3] : XDMA's channel Stream mode support
Message-ID: <ZmiEuWX6pXrYRfb5@matsya>
References: <CALYqZ9=rqzRHn4en0oXSx0QNybizqq2hMbsO6+X_hLynT5RXZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALYqZ9=rqzRHn4en0oXSx0QNybizqq2hMbsO6+X_hLynT5RXZw@mail.gmail.com>

On 05-06-24, 12:07, Eric Debief wrote:
> >From ffe05a12ee7d9e9450f24deb54c2b5b901a5eebb Mon Sep 17 00:00:00 2001
> From: Eric DEBIEF <debief@digigram.com>
> Date: Thu, 23 May 2024 17:21:23 +0200
> Subject: XDMA stream mode initial support.

Please send the patches as a series, not disjoint patches

Second please use susbystem tag which is dmaengine: xilinx: ...

> If the Channel is in STREAM Mode, a C2H Write back
> structure is allocated and used.
> This is an initial support as the write back is allocated
> even if the feature is disabled for the Channel.
> The End of Packet condition is not handled yet.
> So, the stream CAN only be correctly closed
> by the host and not the XDMA.
> 
> Signed-off-by: Eric DEBIEF <debief@digigram.com>
> ---
>  drivers/dma/xilinx/xdma-regs.h |  5 +++
>  drivers/dma/xilinx/xdma.c      | 64 +++++++++++++++++++++++++++++++---
>  2 files changed, 65 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xdma-regs.h b/drivers/dma/xilinx/xdma-regs.h
> index 6ad08878e938..780ac3c9d34d 100644
> --- a/drivers/dma/xilinx/xdma-regs.h
> +++ b/drivers/dma/xilinx/xdma-regs.h
> @@ -95,6 +95,11 @@ struct xdma_hw_desc {
>  #define XDMA_CHAN_CHECK_TARGET(id, target)        \
>      (((u32)(id) >> 16) == XDMA_CHAN_MAGIC + (target))
> 
> +/* macro about channel's interface mode */
> +#define XDMA_CHAN_ID_STREAM_BIT        BIT(15)
> +#define XDMA_CHAN_IN_STREAM_MODE(id)    \
> +    (((u32)(id) & XDMA_CHAN_ID_STREAM_BIT) != 0)
> +
>  /* bits of the channel control register */
>  #define CHAN_CTRL_RUN_STOP            BIT(0)
>  #define CHAN_CTRL_IE_DESC_STOPPED        BIT(1)
> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
> index e2c3f629681e..c2a56f8ff1ac 100644
> --- a/drivers/dma/xilinx/xdma.c
> +++ b/drivers/dma/xilinx/xdma.c
> @@ -51,6 +51,20 @@ struct xdma_desc_block {
>      dma_addr_t    dma_addr;
>  };
> 
> +/**
> + * struct xdma_c2h_stream_write_back  - Write back block , written by the XDMA.
> + * @magic_status_bit : magic (0x52B4) once written
> + * @length: effective transfer length (in bytes)
> + * @PADDING to be aligned on 32 bytes
> + * @associated dma address
> + */
> +struct xdma_c2h_stream_write_back {
> +    __le32 magic_status_bit;
> +    __le32 length;
> +    u32 padding_1[6];
> +    dma_addr_t dma_addr;
> +};
> +
>  /**
>   * struct xdma_chan - Driver specific DMA channel structure
>   * @vchan: Virtual channel
> @@ -61,6 +75,8 @@ struct xdma_desc_block {
>   * @dir: Transferring direction of the channel
>   * @cfg: Transferring config of the channel
>   * @irq: IRQ assigned to the channel
> + * @c2h_wback : Meta data write back only for C2H channels in stream mode
> +
>   */
>  struct xdma_chan {
>      struct virt_dma_chan        vchan;
> @@ -73,6 +89,8 @@ struct xdma_chan {
>      u32                irq;
>      struct completion        last_interrupt;
>      bool                stop_requested;
> +    bool                stream_mode;
> +    struct xdma_c2h_stream_write_back *c2h_wback;
>  };
> 
>  /**
> @@ -472,6 +490,8 @@ static int xdma_alloc_channels(struct xdma_device *xdev,
>          xchan->base = base + i * XDMA_CHAN_STRIDE;
>          xchan->dir = dir;
>          xchan->stop_requested = false;
> +        xchan->stream_mode = XDMA_CHAN_IN_STREAM_MODE(identifier);
> +        xchan->c2h_wback = NULL;
>          init_completion(&xchan->last_interrupt);
> 
>          ret = xdma_channel_init(xchan);
> @@ -480,6 +500,11 @@ static int xdma_alloc_channels(struct xdma_device *xdev,
>          xchan->vchan.desc_free = xdma_free_desc;
>          vchan_init(&xchan->vchan, &xdev->dma_dev);
> 
> +        dev_dbg(&xdev->pdev->dev, "configured channel %s[%d] in %s Interface",
> +            (dir == DMA_MEM_TO_DEV) ? "H2C" : "C2H",
> +            j,
> +            (xchan->stream_mode == false) ? "Memory Mapped" : "Stream");
> +
>          j++;
>      }
> 
> @@ -628,7 +653,8 @@ xdma_prep_device_sg(struct dma_chan *chan, struct
> scatterlist *sgl,
>          src = &addr;
>          dst = &dev_addr;
>      } else {
> -        dev_addr = xdma_chan->cfg.src_addr;
> +        dev_addr = xdma_chan->cfg.src_addr ?
> +            xdma_chan->cfg.src_addr : xdma_chan->c2h_wback->dma_addr;
>          src = &dev_addr;
>          dst = &addr;
>      }
> @@ -705,7 +731,8 @@ xdma_prep_dma_cyclic(struct dma_chan *chan,
> dma_addr_t address,
>          src = &addr;
>          dst = &dev_addr;
>      } else {
> -        dev_addr = xdma_chan->cfg.src_addr;
> +        dev_addr = xdma_chan->cfg.src_addr ?
> +            xdma_chan->cfg.src_addr : xdma_chan->c2h_wback->dma_addr;
>          src = &dev_addr;
>          dst = &addr;
>      }
> @@ -801,8 +828,16 @@ static int xdma_device_config(struct dma_chan *chan,
>  static void xdma_free_chan_resources(struct dma_chan *chan)
>  {
>      struct xdma_chan *xdma_chan = to_xdma_chan(chan);
> +    struct xdma_device *xdev = xdma_chan->xdev_hdl;
> +    struct device *dev = xdev->dma_dev.dev;
> 
>      vchan_free_chan_resources(&xdma_chan->vchan);
> +    if (xdma_chan->c2h_wback != NULL) {
> +        dev_dbg(dev, "Free C2H write back: %p", xdma_chan->c2h_wback);
> +        dma_pool_free(xdma_chan->desc_pool,
> +                    xdma_chan->c2h_wback,
> +                xdma_chan->c2h_wback->dma_addr);
> +    }
>      dma_pool_destroy(xdma_chan->desc_pool);
>      xdma_chan->desc_pool = NULL;
>  }
> @@ -816,6 +851,7 @@ static int xdma_alloc_chan_resources(struct dma_chan *chan)
>      struct xdma_chan *xdma_chan = to_xdma_chan(chan);
>      struct xdma_device *xdev = xdma_chan->xdev_hdl;
>      struct device *dev = xdev->dma_dev.dev;
> +    dma_addr_t c2h_wback_addr;
> 
>      while (dev && !dev_is_pci(dev))
>          dev = dev->parent;
> @@ -824,13 +860,33 @@ static int xdma_alloc_chan_resources(struct
> dma_chan *chan)
>          return -EINVAL;
>      }
> 
> -    xdma_chan->desc_pool = dma_pool_create(dma_chan_name(chan), dev,
> XDMA_DESC_BLOCK_SIZE,
> -                           XDMA_DESC_BLOCK_ALIGN, XDMA_DESC_BLOCK_BOUNDARY);
> +    //Allocate the pool WITH the C2H write back
> +    xdma_chan->desc_pool = dma_pool_create(dma_chan_name(chan),
> +                dev,
> +                XDMA_DESC_BLOCK_SIZE +
> +                    sizeof(struct xdma_c2h_stream_write_back),
> +                XDMA_DESC_BLOCK_ALIGN,
> +                XDMA_DESC_BLOCK_BOUNDARY);
>      if (!xdma_chan->desc_pool) {
>          xdma_err(xdev, "unable to allocate descriptor pool");
>          return -ENOMEM;
>      }
> 
> +    /* Allocate the C2H write back out of the pool in streaming mode only*/
> +    if ((xdma_chan->dir == DMA_DEV_TO_MEM) &&
> +        (xdma_chan->stream_mode == true)) {
> +        xdma_chan->c2h_wback = dma_pool_alloc(xdma_chan->desc_pool,
> +                              GFP_NOWAIT,
> +                              &c2h_wback_addr);
> +        if (!xdma_chan->c2h_wback) {
> +            xdma_err(xdev, "unable to allocate C2H write back block");
> +            return -ENOMEM;
> +        }
> +        xdma_chan->c2h_wback->dma_addr = c2h_wback_addr;
> +        dev_dbg(dev, "Allocate C2H write back: %p", xdma_chan->c2h_wback);
> +    }
> +
> +
>      return 0;
>  }
> 
> -- 
> 2.34.1
> 
> -- 
>  
> <https://www.digigram.com/digigram-critical-audio-at-eurosatory-2024-in-paris/>

-- 
~Vinod

