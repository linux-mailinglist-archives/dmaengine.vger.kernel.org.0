Return-Path: <dmaengine+bounces-3152-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC97976052
	for <lists+dmaengine@lfdr.de>; Thu, 12 Sep 2024 07:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C22001F23F53
	for <lists+dmaengine@lfdr.de>; Thu, 12 Sep 2024 05:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D8F188910;
	Thu, 12 Sep 2024 05:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0ROEZC7K"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88B228F4;
	Thu, 12 Sep 2024 05:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726118846; cv=none; b=XNTOvJOBrUNRHv2O/swFYe9q7A1m6iDv36xAhfAzFa6rX5LyW4l6Mfo7vuL7WtnU9e963HW4SR6tHY04MUgUO2tQjbdpnx8LJAsVMQzEg8mdnwCb25JLynZRhDHX9DC0yBJOK79fiYbHuyORtBNfXx1WFCrJcmlRSAkfWlgE110=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726118846; c=relaxed/simple;
	bh=FBoKZW8go4jR8d468STNkw8a4R5bxPadQKoaIPJ6Lto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbatRMJbNfpVgxhPO9p6m2UfajEVCgz2OjHsL03d6YzR6KHFiTZ1asgpyiGBC9SMZHPb8JLUwsQGHKUAbduKbjDW9LL77F+BNfiMltXZosQ+YSPzkivC7BdnKn4IxOGPlwJiXuAffPec1rr35/Cr96y8BkT0O/AzEOoW4CnX/Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0ROEZC7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D011CC4CEC3;
	Thu, 12 Sep 2024 05:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726118845;
	bh=FBoKZW8go4jR8d468STNkw8a4R5bxPadQKoaIPJ6Lto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0ROEZC7KnK0p3MCfhRsJQdBQ5pM7kguH/EZPbFusSLn5FegiImEfW00oL8AYBk5Rq
	 ZrcSafNiHxyEcC9fpIz6/S0NH2OhYbPH1jid+cUzp0yjUFPM/lSVqcwJ3EFfw2zriX
	 q8iuR+TXHCnzrdd9tMQq9uIjSDZ12tFa+zM8t8JM=
Date: Thu, 12 Sep 2024 07:27:22 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Maciej Sosnowski <maciej.sosnowski@intel.com>,
	Haavard Skinnemoen <haavard.skinnemoen@atmel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dmaengine: dw: Prevent tx-status calling DMA-desc
 callback
Message-ID: <2024091215-appraisal-rocket-45d6@gregkh>
References: <20240911184710.4207-1-fancer.lancer@gmail.com>
 <20240911184710.4207-2-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911184710.4207-2-fancer.lancer@gmail.com>

On Wed, Sep 11, 2024 at 09:46:09PM +0300, Serge Semin wrote:
> The dmaengine_tx_status() method implemented in the DW DMAC driver is
> responsible for not just DMA-transfer status getting, but may also cause
> the transfer finalization with the Tx-descriptors callback invocation.
> This makes the simple DMA-transfer status getting being much more complex
> than it seems with a wider room for possible bugs.
> 
> In particular a deadlock has been discovered in the DW 8250 UART device
> driver interacting with the DW DMA controller channels. Here is the
> call-trace causing the deadlock:
> 
> serial8250_handle_irq()
>   uart_port_lock_irqsave(port); ----------------------+
>   handle_rx_dma()                                     |
>     serial8250_rx_dma_flush()                         |
>       __dma_rx_complete()                             |
>         dmaengine_tx_status()                         |
>           dwc_scan_descriptors()                      |
>             dwc_complete_all()                        |
>               dwc_descriptor_complete()               |
>                 dmaengine_desc_callback_invoke()      |
>                   cb->callback(cb->callback_param);   |
>                   ||                                  |
>                   dma_rx_complete();                  |
>                     uart_port_lock_irqsave(port); ----+ <- Deadlock!
> 
> So in case if the DMA-engine finished working at some point before the
> serial8250_rx_dma_flush() invocation and the respective tasklet hasn't
> been executed yet to finalize the DMA transfer, then calling the
> dmaengine_tx_status() will cause the DMA-descriptors status update and the
> Tx-descriptor callback invocation.
> 
> Generalizing the case up: if the dmaengine_tx_status() method callee and
> the Tx-descriptor callback refer to the related critical section, then
> calling dmaengine_tx_status() from the Tx-descriptor callback will
> inevitably cause a deadlock around the guarding lock as it happens in the
> Serial 8250 DMA implementation above. (Note the deadlock doesn't happen
> very often, but can be eventually discovered if the being received data
> size is greater than the Rx DMA-buffer size defined in the 8250_dma.c
> driver. In my case reducing the Rx DMA-buffer size increased the deadlock
> probability.)
> 
> Alas there is no obvious way to prevent the deadlock by fixing the
> 8250-port drivers because the UART-port lock must be held for the entire
> port IRQ handling procedure. Thus the best way to fix the discovered
> problem (and prevent similar ones in the drivers using the DW DMAC device
> channels) is to simplify the DMA-transfer status getter by removing the
> Tx-descriptors state update from there and making the function to serve
> just one purpose - calculate the DMA-transfer residue and return the
> transfer status. The DMA-transfer status update will be performed in the
> bottom-half procedure only.
> 
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> 
> ---
> 
> Changelog RFC:
> - Instead of just dropping the dwc_scan_descriptors() method invocation
>   calculate the residue in the Tx-status getter.
> ---
>  drivers/dma/dw/core.c | 90 ++++++++++++++++++++++++-------------------
>  1 file changed, 50 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index dd75f97a33b3..af1871646eb9 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -39,6 +39,8 @@
>  	BIT(DMA_SLAVE_BUSWIDTH_2_BYTES)		| \
>  	BIT(DMA_SLAVE_BUSWIDTH_4_BYTES)
>  
> +static u32 dwc_get_hard_llp_desc_residue(struct dw_dma_chan *dwc, struct dw_desc *desc);
> +
>  /*----------------------------------------------------------------------*/
>  
>  static struct device *chan2dev(struct dma_chan *chan)
> @@ -297,14 +299,12 @@ static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
>  
>  static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  {
> -	dma_addr_t llp;
>  	struct dw_desc *desc, *_desc;
>  	struct dw_desc *child;
>  	u32 status_xfer;
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&dwc->lock, flags);
> -	llp = channel_readl(dwc, LLP);
>  	status_xfer = dma_readl(dw, RAW.XFER);
>  
>  	if (status_xfer & dwc->mask) {
> @@ -358,41 +358,16 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  		return;
>  	}
>  
> -	dev_vdbg(chan2dev(&dwc->chan), "%s: llp=%pad\n", __func__, &llp);
> +	dev_vdbg(chan2dev(&dwc->chan), "%s: hard LLP mode\n", __func__);
>  
>  	list_for_each_entry_safe(desc, _desc, &dwc->active_list, desc_node) {
> -		/* Initial residue value */
> -		desc->residue = desc->total_len;
> -
> -		/* Check first descriptors addr */
> -		if (desc->txd.phys == DWC_LLP_LOC(llp)) {
> -			spin_unlock_irqrestore(&dwc->lock, flags);
> -			return;
> -		}
> -
> -		/* Check first descriptors llp */
> -		if (lli_read(desc, llp) == llp) {
> -			/* This one is currently in progress */
> -			desc->residue -= dwc_get_sent(dwc);
> +		desc->residue = dwc_get_hard_llp_desc_residue(dwc, desc);
> +		if (desc->residue) {
>  			spin_unlock_irqrestore(&dwc->lock, flags);
>  			return;
>  		}
>  
> -		desc->residue -= desc->len;
> -		list_for_each_entry(child, &desc->tx_list, desc_node) {
> -			if (lli_read(child, llp) == llp) {
> -				/* Currently in progress */
> -				desc->residue -= dwc_get_sent(dwc);
> -				spin_unlock_irqrestore(&dwc->lock, flags);
> -				return;
> -			}
> -			desc->residue -= child->len;
> -		}
> -
> -		/*
> -		 * No descriptors so far seem to be in progress, i.e.
> -		 * this one must be done.
> -		 */
> +		/* No data left to be send. Finalize the transfer then */
>  		spin_unlock_irqrestore(&dwc->lock, flags);
>  		dwc_descriptor_complete(dwc, desc, true);
>  		spin_lock_irqsave(&dwc->lock, flags);
> @@ -976,6 +951,45 @@ static struct dw_desc *dwc_find_desc(struct dw_dma_chan *dwc, dma_cookie_t c)
>  	return NULL;
>  }
>  
> +static u32 dwc_get_soft_llp_desc_residue(struct dw_dma_chan *dwc, struct dw_desc *desc)
> +{
> +	u32 residue = desc->residue;
> +
> +	if (residue)
> +		residue -= dwc_get_sent(dwc);
> +
> +	return residue;
> +}
> +
> +static u32 dwc_get_hard_llp_desc_residue(struct dw_dma_chan *dwc, struct dw_desc *desc)
> +{
> +	u32 residue = desc->total_len;
> +	struct dw_desc *child;
> +	dma_addr_t llp;
> +
> +	llp = channel_readl(dwc, LLP);
> +
> +	/* Check first descriptor for been pending to be fetched by DMAC */
> +	if (desc->txd.phys == DWC_LLP_LOC(llp))
> +		return residue;
> +
> +	/* Check first descriptor LLP to see if it's currently in-progress */
> +	if (lli_read(desc, llp) == llp)
> +		return residue - dwc_get_sent(dwc);
> +
> +	/* Check subordinate LLPs to find the currently in-progress desc */
> +	residue -= desc->len;
> +	list_for_each_entry(child, &desc->tx_list, desc_node) {
> +		if (lli_read(child, llp) == llp)
> +			return residue - dwc_get_sent(dwc);
> +
> +		residue -= child->len;
> +	}
> +
> +	/* Shall return zero if no in-progress desc found */
> +	return residue;
> +}
> +
>  static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cookie,
>  				      enum dma_status *status)
>  {
> @@ -988,9 +1002,11 @@ static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cook
>  	desc = dwc_find_desc(dwc, cookie);
>  	if (desc) {
>  		if (desc == dwc_first_active(dwc)) {
> -			residue = desc->residue;
> -			if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags) && residue)
> -				residue -= dwc_get_sent(dwc);
> +			if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags))
> +				residue = dwc_get_soft_llp_desc_residue(dwc, desc);
> +			else
> +				residue = dwc_get_hard_llp_desc_residue(dwc, desc);
> +
>  			if (test_bit(DW_DMA_IS_PAUSED, &dwc->flags))
>  				*status = DMA_PAUSED;
>  		} else {
> @@ -1012,12 +1028,6 @@ dwc_tx_status(struct dma_chan *chan,
>  	struct dw_dma_chan	*dwc = to_dw_dma_chan(chan);
>  	enum dma_status		ret;
>  
> -	ret = dma_cookie_status(chan, cookie, txstate);
> -	if (ret == DMA_COMPLETE)
> -		return ret;
> -
> -	dwc_scan_descriptors(to_dw_dma(chan->device), dwc);
> -
>  	ret = dma_cookie_status(chan, cookie, txstate);
>  	if (ret == DMA_COMPLETE)
>  		return ret;
> -- 
> 2.43.0
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

