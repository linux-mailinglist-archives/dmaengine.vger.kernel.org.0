Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D037861F4
	for <lists+dmaengine@lfdr.de>; Thu,  8 Aug 2019 14:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390083AbfHHMdF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 8 Aug 2019 08:33:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389923AbfHHMdF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 8 Aug 2019 08:33:05 -0400
Received: from localhost (unknown [122.178.245.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 778AA21883;
        Thu,  8 Aug 2019 12:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565267584;
        bh=KMINRkuYBok2QumR2R4JgROUPh1CgGn+fh9C0MQuJiE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rRHR+XO248Pa0ZDXn56QqJWmT9Z/E/aSJJ7Hi4HzJvTCl2kb91e3emsYz6phOwGU8
         UDvpi8rzBAx/NX6r7HDbIBq+yDdlaqDK3fxdcC8fWu20Tr6kgV5WSSFnrCEglGU7Tj
         jLjsCWLb4MmUXsT7LQEfxdO4j60jkFPsgcJcC5zY=
Date:   Thu, 8 Aug 2019 18:01:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>, Stefan Wahren <wahrenst@gmx.net>,
        linux-spi@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>, Nuno Sa <nuno.sa@analog.com>,
        Martin Sperl <kernel@martin.sperl.org>,
        Noralf Tronnes <noralf@tronnes.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Florian Kauer <florian.kauer@koalo.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH 09/10] dmaengine: bcm2835: Avoid accessing memory when
 copying zeroes
Message-ID: <20190808123152.GW12733@vkoul-mobl.Dlink>
References: <cover.1564825752.git.lukas@wunner.de>
 <a8efa43470bc5092b8727a93c9cf694c80e0c8c4.1564825752.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8efa43470bc5092b8727a93c9cf694c80e0c8c4.1564825752.git.lukas@wunner.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-08-19, 12:10, Lukas Wunner wrote:
> The BCM2835 DMA controller is capable of synthesizing zeroes instead of
> copying them from a source address. The feature is enabled by setting
> the SRC_IGNORE bit in the Transfer Information field of a Control Block:
> 
> "Do not perform source reads.
>  In addition, destination writes will zero all the write strobes.
>  This is used for fast cache fill operations."
> https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf
> 
> The feature is only available on 8 of the 16 channels. The others are
> so-called "lite" channels with a limited feature set and performance.
> 
> Enable the feature if a cyclic transaction copies from the zero page.
> This reduces traffic on the memory bus.
> 
> A forthcoming use case is the BCM2835 SPI driver, which will cyclically
> copy from the zero page to the TX FIFO. The idea to use SRC_IGNORE was
> taken from an ancient GitHub conversation between Martin and Noralf:
> https://github.com/msperl/spi-bcm2835/issues/13#issuecomment-98180451

Acked-by: Vinod Koul <vkoul@kernel.org>

> 
> Tested-by: Nuno Sá <nuno.sa@analog.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Martin Sperl <kernel@martin.sperl.org>
> Cc: Noralf Trønnes <noralf@tronnes.org>
> Cc: Florian Kauer <florian.kauer@koalo.de>
> ---
>  drivers/dma/bcm2835-dma.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> index 14358faf3bff..67100e4e1083 100644
> --- a/drivers/dma/bcm2835-dma.c
> +++ b/drivers/dma/bcm2835-dma.c
> @@ -42,11 +42,14 @@
>   * @ddev: DMA device
>   * @base: base address of register map
>   * @dma_parms: DMA parameters (to convey 1 GByte max segment size to clients)
> + * @zero_page: bus address of zero page (to detect transactions copying from
> + *	zero page and avoid accessing memory if so)
>   */
>  struct bcm2835_dmadev {
>  	struct dma_device ddev;
>  	void __iomem *base;
>  	struct device_dma_parameters dma_parms;
> +	dma_addr_t zero_page;
>  };
>  
>  struct bcm2835_dma_cb {
> @@ -693,6 +696,7 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
>  	size_t period_len, enum dma_transfer_direction direction,
>  	unsigned long flags)
>  {
> +	struct bcm2835_dmadev *od = to_bcm2835_dma_dev(chan->device);
>  	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
>  	struct bcm2835_desc *d;
>  	dma_addr_t src, dst;
> @@ -743,6 +747,10 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
>  		dst = c->cfg.dst_addr;
>  		src = buf_addr;
>  		info |= BCM2835_DMA_D_DREQ | BCM2835_DMA_S_INC;
> +
> +		/* non-lite channels can write zeroes w/o accessing memory */
> +		if (buf_addr == od->zero_page && !c->is_lite_channel)
> +			info |= BCM2835_DMA_S_IGNORE;
>  	}
>  
>  	/* calculate number of frames */
> @@ -845,6 +853,9 @@ static void bcm2835_dma_free(struct bcm2835_dmadev *od)
>  		list_del(&c->vc.chan.device_node);
>  		tasklet_kill(&c->vc.task);
>  	}
> +
> +	dma_unmap_page_attrs(od->ddev.dev, od->zero_page, PAGE_SIZE,
> +			     DMA_TO_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
>  }
>  
>  static const struct of_device_id bcm2835_dma_of_match[] = {
> @@ -927,6 +938,14 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, od);
>  
> +	od->zero_page = dma_map_page_attrs(od->ddev.dev, ZERO_PAGE(0), 0,
> +					   PAGE_SIZE, DMA_TO_DEVICE,
> +					   DMA_ATTR_SKIP_CPU_SYNC);
> +	if (dma_mapping_error(od->ddev.dev, od->zero_page)) {
> +		dev_err(&pdev->dev, "Failed to map zero page\n");
> +		return -ENOMEM;
> +	}
> +
>  	/* Request DMA channel mask from device tree */
>  	if (of_property_read_u32(pdev->dev.of_node,
>  			"brcm,dma-channel-mask",
> -- 
> 2.20.1

-- 
~Vinod
