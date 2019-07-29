Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7CE784DD
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jul 2019 08:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfG2GRs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Jul 2019 02:17:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfG2GRs (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 29 Jul 2019 02:17:48 -0400
Received: from localhost (unknown [122.178.221.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34E9A20578;
        Mon, 29 Jul 2019 06:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564381067;
        bh=SzvnrYeZ/XVMFTRV94yVm4GxaXQLhbrOmoBn0kkt5WA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NEJHkhIRe3vLDfy4/gTgsVp62iujdtY5y67s5hPGe2OzXzQbgUR7lpQhcgd61inXL
         qUStUbcCTjjyD5EYIU/1BUbc0pIGXDfSeWzoPAzHZt5aibsI/EZkl02fqyKzLIX4yc
         mM32MaHU+ycs/lyOjtTIft+tIE84XRl5cNhHYaE8=
Date:   Mon, 29 Jul 2019 11:46:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dmaengine: ti: omap-dma: Improved memcpy polling
 support
Message-ID: <20190729061634.GD12733@vkoul-mobl.Dlink>
References: <20190716082459.1222-1-peter.ujfalusi@ti.com>
 <20190716082459.1222-3-peter.ujfalusi@ti.com>
 <20190725133748.GX12733@vkoul-mobl.Dlink>
 <59794775-95e6-04c3-2660-9344c89df9a1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59794775-95e6-04c3-2660-9344c89df9a1@ti.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-07-19, 17:07, Peter Ujfalusi wrote:
> 
> 
> On 25/07/2019 16.37, Vinod Koul wrote:
> > On 16-07-19, 11:24, Peter Ujfalusi wrote:
> >> When a DMA client driver does not set the DMA_PREP_INTERRUPT because it
> >> does not want to use interrupts for DMA completion or because it can not
> >> rely on DMA interrupts due to executing the memcpy when interrupts are
> >> disabled it will poll the status of the transfer.
> >>
> >> If the interrupts are enabled then the cookie will be set completed in the
> >> interrupt handler so only check in HW completion when the polling is really
> >> needed.
> >>
> >> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >> ---
> >>  drivers/dma/ti/omap-dma.c | 44 +++++++++++++++++++++++++--------------
> >>  1 file changed, 28 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> >> index 029c0bd550d5..966d8f0323b5 100644
> >> --- a/drivers/dma/ti/omap-dma.c
> >> +++ b/drivers/dma/ti/omap-dma.c
> >> @@ -91,6 +91,7 @@ struct omap_desc {
> >>  	bool using_ll;
> >>  	enum dma_transfer_direction dir;
> >>  	dma_addr_t dev_addr;
> >> +	bool polled;
> >>  
> >>  	int32_t fi;		/* for OMAP_DMA_SYNC_PACKET / double indexing */
> >>  	int16_t ei;		/* for double indexing */
> >> @@ -815,26 +816,20 @@ static enum dma_status omap_dma_tx_status(struct dma_chan *chan,
> >>  	struct virt_dma_desc *vd;
> >>  	enum dma_status ret;
> >>  	unsigned long flags;
> >> +	struct omap_desc *d = NULL;
> >>  
> >>  	ret = dma_cookie_status(chan, cookie, txstate);
> >> -
> >> -	if (!c->paused && c->running) {
> >> -		uint32_t ccr = omap_dma_chan_read(c, CCR);
> >> -		/*
> >> -		 * The channel is no longer active, set the return value
> >> -		 * accordingly
> >> -		 */
> >> -		if (!(ccr & CCR_ENABLE))
> >> -			ret = DMA_COMPLETE;
> >> -	}
> >> -
> >> -	if (ret == DMA_COMPLETE || !txstate)
> >> +	if (ret == DMA_COMPLETE)
> > 
> > why do you want to continue for txstate being null?
> 
> The caller could opt to not provide txstate and I still need to check if
> the non completed transfer is actually done by the HW or not.
> 
> > Also it would lead to NULL ptr deref for txstate
> 
> There is a !txstate check to avoid that.
> 
> > 
> >>  		return ret;
> >>  
> >>  	spin_lock_irqsave(&c->vc.lock, flags);
> >> +	if (c->desc && c->desc->vd.tx.cookie == cookie)
> >> +		d = c->desc;
> >> +
> >> +	if (!txstate)
> >> +		goto out;

Oops missed that, let me check again and do the needful

-- 
~Vinod
