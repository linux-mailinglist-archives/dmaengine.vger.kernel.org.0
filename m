Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B106C74FB1
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jul 2019 15:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389363AbfGYNjD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Jul 2019 09:39:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387959AbfGYNjC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 25 Jul 2019 09:39:02 -0400
Received: from localhost (unknown [106.200.241.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CAAA2238C;
        Thu, 25 Jul 2019 13:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564061941;
        bh=GNnRLDXagjW24uJjaZ+NEZpnlhAqk6UFVb6NIhulu8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rXj010Fl0AHCZLs0iIYnzBuO54f2B51sWeruKH8aY5fRC17oXxueIGxOyFSHjUhpC
         tXTU2wyNx3FHOOqAMpCYMO0oX1X9FpRfkzWusLcxCb3v8ckoNxft9V/rpoT9GlsjCz
         bAU7oHic/n3Cgbi9l8Ivc+fTApDA/O7SxAwxD0n8=
Date:   Thu, 25 Jul 2019 19:07:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dmaengine: ti: omap-dma: Improved memcpy polling
 support
Message-ID: <20190725133748.GX12733@vkoul-mobl.Dlink>
References: <20190716082459.1222-1-peter.ujfalusi@ti.com>
 <20190716082459.1222-3-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716082459.1222-3-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-07-19, 11:24, Peter Ujfalusi wrote:
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
>  drivers/dma/ti/omap-dma.c | 44 +++++++++++++++++++++++++--------------
>  1 file changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> index 029c0bd550d5..966d8f0323b5 100644
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c
> @@ -91,6 +91,7 @@ struct omap_desc {
>  	bool using_ll;
>  	enum dma_transfer_direction dir;
>  	dma_addr_t dev_addr;
> +	bool polled;
>  
>  	int32_t fi;		/* for OMAP_DMA_SYNC_PACKET / double indexing */
>  	int16_t ei;		/* for double indexing */
> @@ -815,26 +816,20 @@ static enum dma_status omap_dma_tx_status(struct dma_chan *chan,
>  	struct virt_dma_desc *vd;
>  	enum dma_status ret;
>  	unsigned long flags;
> +	struct omap_desc *d = NULL;
>  
>  	ret = dma_cookie_status(chan, cookie, txstate);
> -
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
> -	if (ret == DMA_COMPLETE || !txstate)
> +	if (ret == DMA_COMPLETE)

why do you want to continue for txstate being null?
Also it would lead to NULL ptr deref for txstate

>  		return ret;
>  
>  	spin_lock_irqsave(&c->vc.lock, flags);
> +	if (c->desc && c->desc->vd.tx.cookie == cookie)
> +		d = c->desc;
> +
> +	if (!txstate)
> +		goto out;
>  
> -	if (c->desc && c->desc->vd.tx.cookie == cookie) {
> -		struct omap_desc *d = c->desc;
> +	if (d) {
>  		dma_addr_t pos;
>  
>  		if (d->dir == DMA_MEM_TO_DEV)
> @@ -851,8 +846,22 @@ static enum dma_status omap_dma_tx_status(struct dma_chan *chan,
>  		txstate->residue = 0;
>  	}
>  
> -	if (ret == DMA_IN_PROGRESS && c->paused)
> +out:
> +	if (ret == DMA_IN_PROGRESS && c->paused) {
>  		ret = DMA_PAUSED;
> +	} else if (d && d->polled && c->running) {
> +		uint32_t ccr = omap_dma_chan_read(c, CCR);
> +		/*
> +		 * The channel is no longer active, set the return value
> +		 * accordingly and mark it as completed
> +		 */
> +		if (!(ccr & CCR_ENABLE)) {
> +			struct omap_desc *d = c->desc;
> +			ret = DMA_COMPLETE;
> +			omap_dma_start_desc(c);
> +			vchan_cookie_complete(&d->vd);
> +		}
> +	}
>  
>  	spin_unlock_irqrestore(&c->vc.lock, flags);
>  
> @@ -1180,7 +1189,10 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_memcpy(
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
