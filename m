Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0606600F7
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2019 08:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfGEGUf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 Jul 2019 02:20:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727702AbfGEGUf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 5 Jul 2019 02:20:35 -0400
Received: from localhost (unknown [122.167.76.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35436218A4;
        Fri,  5 Jul 2019 06:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562307634;
        bh=DIUX77w8sRwnwNuafe4OdZKSUe7g9Mr+grIEjaDuID4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ODWmce1FMUhZAak0sVROZZmgaXIn/Ar9YylrqoPlQzlobp7Ux+rJLVsNJM10uiURc
         FeaJ7wHFRrWKYUledq/zOgjBorN6vzTzgL6c98GZsW3UrDpu8Z73FFzA65QlCAZen5
         ENa6tK7nO5btUSKVT7jltReFhRy5+udN/fxAafLY=
Date:   Fri, 5 Jul 2019 11:47:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v4 3/3] dmaengine: ti: edma: Support for polled (memcpy)
 completion
Message-ID: <20190705061714.GU2911@vkoul-mobl>
References: <20190618132148.26468-1-peter.ujfalusi@ti.com>
 <20190618132148.26468-4-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618132148.26468-4-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-06-19, 16:21, Peter Ujfalusi wrote:
> When a DMA client driver does not set the DMA_PREP_INTERRUPT because it
> does not want to use interrupts for DMA completion or because it can not
> rely on DMA interrupts due to executing the memcpy when interrupts are
> disabled it will poll the status of the transfer.
> 
> Since we can not tell from any EDMA register that the transfer is
> completed, we can only know that the paRAM set has been sent to TPTC for
> processing we need to check the residue of the transfer, if it is 0 then
> the transfer is completed.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/ti/edma.c | 37 +++++++++++++++++++++++++++++++++----
>  1 file changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> index 48b155cab822..87d7fdaa204b 100644
> --- a/drivers/dma/ti/edma.c
> +++ b/drivers/dma/ti/edma.c
> @@ -171,6 +171,7 @@ struct edma_desc {
>  	struct list_head		node;
>  	enum dma_transfer_direction	direction;
>  	int				cyclic;
> +	bool				polled;
>  	int				absync;
>  	int				pset_nr;
>  	struct edma_chan		*echan;
> @@ -1240,8 +1241,9 @@ static struct dma_async_tx_descriptor *edma_prep_dma_memcpy(
>  
>  	edesc->pset[0].param.opt |= ITCCHEN;
>  	if (nslots == 1) {
> -		/* Enable transfer complete interrupt */
> -		edesc->pset[0].param.opt |= TCINTEN;
> +		/* Enable transfer complete interrupt if requested */
> +		if (tx_flags & DMA_PREP_INTERRUPT)
> +			edesc->pset[0].param.opt |= TCINTEN;
>  	} else {
>  		/* Enable transfer complete chaining for the first slot */
>  		edesc->pset[0].param.opt |= TCCHEN;
> @@ -1268,9 +1270,14 @@ static struct dma_async_tx_descriptor *edma_prep_dma_memcpy(
>  		}
>  
>  		edesc->pset[1].param.opt |= ITCCHEN;
> -		edesc->pset[1].param.opt |= TCINTEN;
> +		/* Enable transfer complete interrupt if requested */
> +		if (tx_flags & DMA_PREP_INTERRUPT)
> +			edesc->pset[1].param.opt |= TCINTEN;
>  	}
>  
> +	if (!(tx_flags & DMA_PREP_INTERRUPT))
> +		edesc->polled = true;
> +
>  	return vchan_tx_prep(&echan->vchan, &edesc->vdesc, tx_flags);
>  }
>  
> @@ -1840,18 +1847,40 @@ static enum dma_status edma_tx_status(struct dma_chan *chan,
>  {
>  	struct edma_chan *echan = to_edma_chan(chan);
>  	struct virt_dma_desc *vdesc;
> +	struct dma_tx_state txstate_tmp;
>  	enum dma_status ret;
>  	unsigned long flags;
>  
>  	ret = dma_cookie_status(chan, cookie, txstate);
> -	if (ret == DMA_COMPLETE || !txstate)
> +
> +	/* Provide a dummy dma_tx_state for completion checking */
> +	if (ret != DMA_COMPLETE && !txstate)
> +		txstate = &txstate_tmp;
> +
> +	if (ret == DMA_COMPLETE)
>  		return ret;

why not do:

        if (ret == DMA_COMPLETE)
                return ret;

        if (!txstate)
                txstate = &txstate_tmp;

> +	txstate->residue = 0;
>  	spin_lock_irqsave(&echan->vchan.lock, flags);
>  	if (echan->edesc && echan->edesc->vdesc.tx.cookie == cookie)
>  		txstate->residue = edma_residue(echan->edesc);
>  	else if ((vdesc = vchan_find_desc(&echan->vchan, cookie)))
>  		txstate->residue = to_edma_desc(&vdesc->tx)->residue;
> +
> +	/*
> +	 * Mark the cookie completed if the residue is 0 for non cyclic
> +	 * transfers
> +	 */
> +	if (ret != DMA_COMPLETE && !txstate->residue &&
> +	    echan->edesc && echan->edesc->polled &&
> +	    echan->edesc->vdesc.tx.cookie == cookie) {
> +		edma_stop(echan);
> +		vchan_cookie_complete(&echan->edesc->vdesc);
> +		echan->edesc = NULL;
> +		edma_execute(echan);
> +		ret = DMA_COMPLETE;
> +	}
> +
>  	spin_unlock_irqrestore(&echan->vchan.lock, flags);
>  
>  	return ret;
> -- 
> Peter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-- 
~Vinod
