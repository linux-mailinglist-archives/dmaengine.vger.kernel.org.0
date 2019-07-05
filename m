Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33D8C60100
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2019 08:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfGEG0z (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 Jul 2019 02:26:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:38594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbfGEG0z (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 5 Jul 2019 02:26:55 -0400
Received: from localhost (unknown [122.167.76.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44EF721852;
        Fri,  5 Jul 2019 06:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562308013;
        bh=OPPgzlGrMc090YOE4UlzaNMP/7utaboAXG3uVsjalPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kUeuuzfenwPI+0LckEUWN5ahEROyyvBFDjsMS8EbzSJE/G5C3fNS1V4kh2H1wtytu
         BviG6dkYb0wfVvq8GpV9M6IhCez7uvjL9K//hvHa2mxat+IkYmvGOW9OtC78nEQb+6
         SEYbvDy8Mz/EvPY985no/CD0I6ZeWL5go0bfSwFY=
Date:   Fri, 5 Jul 2019 11:53:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Improved memcpy polling support
Message-ID: <20190705062334.GV2911@vkoul-mobl>
References: <20190618132416.26874-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618132416.26874-1-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-06-19, 16:24, Peter Ujfalusi wrote:
> When a DMA client driver does not set the DMA_PREP_INTERRUPT because it
> does not want to use interrupts for DMA completion or because it can not
> rely on DMA interrupts due to executing the memcpy when interrupts are
> disabled it will poll the status of the transfer.
> 
> If the interrupts are enabled then the cookie will be set completed in the
> interrupt handler so only check in HW completion when the polling is really
> needed.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi,
> 
> This patch fine-tunes the omap-dma polled memcpy support to be inline with how
> the EDMA driver is handling it.
> 
> The polled completion can be tested by applying:
> https://patchwork.kernel.org/patch/10966499/
> 
> and run the dmatest with polled = 1 on boards where sDMA is used.
> 
> Or boot up any dra7 family device with display enabled. The workaround for DMM
> errata i878 uses polled DMA memcpy.
> 
> Regards,
> Peter
> 
>  drivers/dma/ti/omap-dma.c | 37 ++++++++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> index 5ba7d8485026..75d8f7e13c8d 100644
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c
> @@ -94,6 +94,7 @@ struct omap_desc {
>  	bool using_ll;
>  	enum dma_transfer_direction dir;
>  	dma_addr_t dev_addr;
> +	bool polled;
>  
>  	int32_t fi;		/* for OMAP_DMA_SYNC_PACKET / double indexing */
>  	int16_t ei;		/* for double indexing */
> @@ -834,20 +835,10 @@ static enum dma_status omap_dma_tx_status(struct dma_chan *chan,
>  
>  	ret = dma_cookie_status(chan, cookie, txstate);
>  
> -	if (!c->paused && c->running) {
> -		uint32_t ccr = omap_dma_chan_read(c, CCR);
> -		/*
> -		 * The channel is no longer active, set the return value
> -		 * accordingly
> -		 */
> -		if (!(ccr & CCR_ENABLE))
> -			ret = DMA_COMPLETE;
> -	}
> -
> +	spin_lock_irqsave(&c->vc.lock, flags);
>  	if (ret == DMA_COMPLETE || !txstate)
> -		return ret;
> +		goto out;
>  
> -	spin_lock_irqsave(&c->vc.lock, flags);
>  	vd = vchan_find_desc(&c->vc, cookie);
>  	if (vd) {
>  		txstate->residue = omap_dma_desc_size(to_omap_dma_desc(&vd->tx));
> @@ -868,6 +859,23 @@ static enum dma_status omap_dma_tx_status(struct dma_chan *chan,
>  	}
>  	if (ret == DMA_IN_PROGRESS && c->paused)
>  		ret = DMA_PAUSED;
> +
> +out:
> +	if (ret == DMA_IN_PROGRESS && c->running && c->desc &&
> +	    c->desc->polled && c->desc->vd.tx.cookie == cookie) {

heh, that makes quite a read!

checking DMA_IN_PROGRESS should not make sense, as we should bail out at
the start if it is completed

I think other can be optimzed to make it a better read!

> +		uint32_t ccr = omap_dma_chan_read(c, CCR);
> +		/*
> +		 * The channel is no longer active, set the return value
> +		 * accordingly
> +		 */
> +		if (!(ccr & CCR_ENABLE)) {
> +			struct omap_desc *d = c->desc;
> +			ret = DMA_COMPLETE;
> +			omap_dma_start_desc(c);
> +			vchan_cookie_complete(&d->vd);
> +		}
> +	}
> +
>  	spin_unlock_irqrestore(&c->vc.lock, flags);
>  
>  	return ret;
> @@ -1233,7 +1241,10 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_memcpy(
>  	d->ccr = c->ccr;
>  	d->ccr |= CCR_DST_AMODE_POSTINC | CCR_SRC_AMODE_POSTINC;
>  
> -	d->cicr = CICR_DROP_IE | CICR_FRAME_IE;
> +	if (tx_flags & DMA_PREP_INTERRUPT)
> +		d->cicr |= CICR_FRAME_IE;
> +	else
> +		d->polled = true;
>  
>  	d->csdp = data_type;
>  
> -- 
> Peter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-- 
~Vinod
