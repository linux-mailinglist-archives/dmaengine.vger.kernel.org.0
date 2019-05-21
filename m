Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 323F62473F
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2019 07:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbfEUFEf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 May 2019 01:04:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfEUFEf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 May 2019 01:04:35 -0400
Received: from localhost (unknown [106.201.107.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A86CB21019;
        Tue, 21 May 2019 05:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558415074;
        bh=TfFWdXCeoIR0c8wyuyKa6CqTWu3M6JCEGZ9N8xiq7m8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s7w+Sgp8oeO7blYnKIbuQOYp6RKAvpl2MPaclzdnzxXh9Opd//lT1jzxWxj72KySj
         V7SkCfz1pPRQOTlDEfa0hwnDZm7PW1g7i2pVyALv9MjilWRdos5jWP2OPtz7aUNH1/
         lRX7H3tZ44JFVZEX5s62q1Ka+KcLJdbs+MIDthSY=
Date:   Tue, 21 May 2019 10:34:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: edma: Enable support for polled (memcpy)
 completion
Message-ID: <20190521050430.GS15118@vkoul-mobl>
References: <20190514080909.10306-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514080909.10306-1-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-05-19, 11:09, Peter Ujfalusi wrote:
> When a DMA client driver decides that it is not providing callback for
> completion of a transfer (and/or does not set the DMA_PREP_INTERRUPT) but
> it will poll the status of the transfer (in case of short memcpy for
> example) we will not get interrupt for the completion of the transfer and
> will not mark the transaction as done.
> 
> Check the event registers (ER and EER) and if the channel is inactive then
> return wioth DMA_COMPLETE to let the client know that the transfer is
        ^^^^^
Typo

> completed.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/ti/edma.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> index ceabdea40ae0..7501445af069 100644
> --- a/drivers/dma/ti/edma.c
> +++ b/drivers/dma/ti/edma.c
> @@ -1211,8 +1211,9 @@ static struct dma_async_tx_descriptor *edma_prep_dma_memcpy(
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
> @@ -1239,7 +1240,9 @@ static struct dma_async_tx_descriptor *edma_prep_dma_memcpy(
>  		}
>  
>  		edesc->pset[1].param.opt |= ITCCHEN;
> -		edesc->pset[1].param.opt |= TCINTEN;
> +		/* Enable transfer complete interrupt if requested */
> +		if (tx_flags & DMA_PREP_INTERRUPT)
> +			edesc->pset[1].param.opt |= TCINTEN;
>  	}
>  
>  	return vchan_tx_prep(&echan->vchan, &edesc->vdesc, tx_flags);
> @@ -1801,6 +1804,20 @@ static enum dma_status edma_tx_status(struct dma_chan *chan,
>  	unsigned long flags;
>  
>  	ret = dma_cookie_status(chan, cookie, txstate);
> +
> +	if (ret != DMA_COMPLETE && echan->edesc && !echan->edesc->cyclic) {
> +		struct edma_cc *ecc = echan->ecc;
> +		int channel = EDMA_CHAN_SLOT(echan->ch_num);
> +		int j = (channel >> 5);
> +		unsigned int mask = BIT(channel & 0x1f);

GENMASK or define a macro instead of a magic number?

> +		unsigned int sh_er = edma_shadow0_read_array(ecc, SH_ER, j);
> +		unsigned int sh_eer = edma_shadow0_read_array(ecc, SH_EER, j);
> +
> +		/* The channel is no longer active */
> +		if (!(sh_er & mask) && !(sh_eer & mask))
> +			ret = DMA_COMPLETE;
> +	}
> +
>  	if (ret == DMA_COMPLETE || !txstate)
>  		return ret;
>  
> -- 
> Peter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-- 
~Vinod
