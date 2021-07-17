Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84AA53CC2D8
	for <lists+dmaengine@lfdr.de>; Sat, 17 Jul 2021 13:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbhGQLjU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 17 Jul 2021 07:39:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhGQLjU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 17 Jul 2021 07:39:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3A7F613D0;
        Sat, 17 Jul 2021 11:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626521783;
        bh=YgnRb9wEmbR2+0qQRxIjEfPfTdADIP+V9QESY9Nosy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kfUi429C4RI0mkfztwpAv+adQQf1SPm+QnJWjmJPfC4PNhrZDsFgprebcPpVZsHGF
         tNsvRECBRgHyjsDHMUE+IFNnL4QNsHB0ng+Xn6de8A/jfmPBNuHk9/9nGtc8zhkn8U
         I4oH+B93x21hA+kYIWKGDzSnq/8KrKWidCRZBHXg2jDCQdmWwrHNv6HsI+QzdrFsfY
         ld0NlKpdDhBjiFg1ql2R6y7OdqrN9KXJ4wn3d6toHLDO78XydNUmnWdRYMWsvQOODQ
         sDzoNN+kQjgVpr4PnL+cQMYCg0nkJnXI5EIySilG7wSZv+ShR4gkcntVHB1EfBjT/K
         KTTG8cEnDXGUA==
Date:   Sat, 17 Jul 2021 17:06:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     dmaengine@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>,
        Kedareswara rao Appana <appana.durga.rao@xilinx.com>,
        Michal Simek <monstr@monstr.eu>,
        Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] dmaengine: xilinx: Add empty device_config function
Message-ID: <YPLAs49jy3OGF1aT@matsya>
References: <20210716182241.218705-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716182241.218705-1-marex@denx.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-07-21, 20:22, Marek Vasut wrote:
> Various DMA users call the dmaengine_slave_config() and expect it to
> succeed, but that can only succeed if .device_config is implemented.
> Add empty device_config function rather than patching all the places
> which use dmaengine_slave_config().

.device_config is optional, Yes the dmaengine_slave_config() will check
and return error...

I think it would make sense to handle this in caller... (ignore
ENOSYS..) rather than add a dummy one

> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Kedareswara rao Appana <appana.durga.rao@xilinx.com>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Vinod Koul <vinod.koul@intel.com>

ummm..? you really need to update this :)

> ---
>  drivers/dma/xilinx/xilinx_dma.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 4b9530a7bf65..d6f4bf0d50e8 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1658,6 +1658,17 @@ static void xilinx_dma_issue_pending(struct dma_chan *dchan)
>  	spin_unlock_irqrestore(&chan->lock, flags);
>  }
>  
> +/**
> + * xilinx_dma_issue_pending - Configure the DMA channel
> + * @dchan: DMA channel
> + * @config: channel configuration
> + */
> +static int xilinx_dma_device_config(struct dma_chan *dchan,
> +				    struct dma_slave_config *config)
> +{
> +	return 0;
> +}
> +
>  /**
>   * xilinx_dma_complete_descriptor - Mark the active descriptor as complete
>   * @chan : xilinx DMA channel
> @@ -3096,6 +3107,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
>  	xdev->common.device_synchronize = xilinx_dma_synchronize;
>  	xdev->common.device_tx_status = xilinx_dma_tx_status;
>  	xdev->common.device_issue_pending = xilinx_dma_issue_pending;
> +	xdev->common.device_config = xilinx_dma_device_config;
>  	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
>  		dma_cap_set(DMA_CYCLIC, xdev->common.cap_mask);
>  		xdev->common.device_prep_slave_sg = xilinx_dma_prep_slave_sg;
> -- 
> 2.30.2

-- 
~Vinod
