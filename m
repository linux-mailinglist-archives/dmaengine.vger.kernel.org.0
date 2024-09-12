Return-Path: <dmaengine+bounces-3151-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E879976050
	for <lists+dmaengine@lfdr.de>; Thu, 12 Sep 2024 07:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1DC1F23791
	for <lists+dmaengine@lfdr.de>; Thu, 12 Sep 2024 05:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CD3188910;
	Thu, 12 Sep 2024 05:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JlDq3dDc"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5035928F4;
	Thu, 12 Sep 2024 05:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726118833; cv=none; b=rXAMZPNvskossW9DAju5Bcdj27LznpJ01XCylzjsQuYtcu2Hjm6opGcQmHLzN48D4HA+eC1lMH5vrbnJ1q9IHYWqRYFoJ4JltoaJIXCfgN25zHw2x4uHSyUI9RChNQQ+2Ao4IhkxyVDAKjvF5EMB75kBFGdTZTfcncf7Z8YtPeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726118833; c=relaxed/simple;
	bh=7eh51Scz69ixvcvPbWXHztOiazCKgp5VwmoMmo0IOAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nr4TIgZ/0U2CxNukIlAIHKlSf7tENOYaHWmBih3ZKuZpymQIxjaCKjG0+IaL4WSmJsziiGAYD4lMZ3h+Vmqxgf06/fjZVHMvqs6UEp40b/5aiQaavjYnAtLruAu+NgKVkDc/NDjaid6ZZTWAXT09QPK9QfmrhvAjZyis1tVg5Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JlDq3dDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E212C4CEC3;
	Thu, 12 Sep 2024 05:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726118832;
	bh=7eh51Scz69ixvcvPbWXHztOiazCKgp5VwmoMmo0IOAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JlDq3dDcZjTc0lYUdf1YAK7Ic40SMrul8b7V8NDqoZk7tWG9xvT02YjBVjap64wpI
	 Nk3PO+KezY8SHJ497JcuxGqDrIVgc6CbCRdZxG1MmBCUa9Z/u3VZ1HZFdOfDon3D54
	 /+V7AUhCpp8Bd21meNOigYyhsLVACY+XF3khqs6Q=
Date: Thu, 12 Sep 2024 07:27:09 +0200
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
Subject: Re: [PATCH 2/2] dmaengine: dw: Fix XFER bit set, but channel not
 idle error
Message-ID: <2024091200-clubhouse-royal-44f3@gregkh>
References: <20240911184710.4207-1-fancer.lancer@gmail.com>
 <20240911184710.4207-3-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911184710.4207-3-fancer.lancer@gmail.com>

On Wed, Sep 11, 2024 at 09:46:10PM +0300, Serge Semin wrote:
> If a client driver gets to use the DW DMAC engine device tougher
> than usual, with occasional DMA-transfers termination and restart, then
> the next error can be randomly spotted in the system log:
> 
> > dma dma0chan0: BUG: XFER bit set, but channel not idle!
> 
> For instance that happens in case of the 8250 UART port driver handling
> the looped back high-speed traffic (in my case > 1.5Mbaud) by means of the
> DMA-engine interface.
> 
> The error happens due to the two-staged nature of the DW DMAC IRQs
> handling procedure and due to the critical section break in the meantime.
> In particular in case if the DMA-transfer is terminated and restarted:
> 1. after the IRQ-handler submitted the tasklet but before the tasklet
>    started handling the DMA-descriptors in dwc_scan_descriptors();
> 2. after the XFER completion flag was detected in the
>    dwc_scan_descriptors() method, but before the dwc_complete_all() method
>    is called
> the error denoted above is printed due to the overlap of the last transfer
> completion and the new transfer execution stages.
> 
> There are two places need to be altered in order to fix the problem.
> 1. Clear the IRQs in the dwc_chan_disable() method. That will prevent the
>    dwc_scan_descriptors() method call in case if the DMA-transfer is
>    restarted in the middle of the two-staged IRQs-handling procedure.
> 2. Move the dwc_complete_all() code to being executed inseparably (in the
>    same atomic section) from the DMA-descriptors scanning procedure. That
>    will prevent the DMA-transfer restarts after the DMA-transfer completion
>    was spotted but before the actual completion is executed.
> 
> Fixes: 69cea5a00d31 ("dmaengine/dw_dmac: Replace spin_lock* with irqsave variants and enable submission from callback")
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  drivers/dma/dw/core.c | 54 ++++++++++++++++++++-----------------------
>  1 file changed, 25 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index af1871646eb9..fbc46cbfe259 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -143,6 +143,12 @@ static inline void dwc_chan_disable(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  	channel_clear_bit(dw, CH_EN, dwc->mask);
>  	while (dma_readl(dw, CH_EN) & dwc->mask)
>  		cpu_relax();
> +
> +	dma_writel(dw, CLEAR.XFER, dwc->mask);
> +	dma_writel(dw, CLEAR.BLOCK, dwc->mask);
> +	dma_writel(dw, CLEAR.SRC_TRAN, dwc->mask);
> +	dma_writel(dw, CLEAR.DST_TRAN, dwc->mask);
> +	dma_writel(dw, CLEAR.ERROR, dwc->mask);
>  }
>  
>  /*----------------------------------------------------------------------*/
> @@ -259,34 +265,6 @@ dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc,
>  	dmaengine_desc_callback_invoke(&cb, NULL);
>  }
>  
> -static void dwc_complete_all(struct dw_dma *dw, struct dw_dma_chan *dwc)
> -{
> -	struct dw_desc *desc, *_desc;
> -	LIST_HEAD(list);
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&dwc->lock, flags);
> -	if (dma_readl(dw, CH_EN) & dwc->mask) {
> -		dev_err(chan2dev(&dwc->chan),
> -			"BUG: XFER bit set, but channel not idle!\n");
> -
> -		/* Try to continue after resetting the channel... */
> -		dwc_chan_disable(dw, dwc);
> -	}
> -
> -	/*
> -	 * Submit queued descriptors ASAP, i.e. before we go through
> -	 * the completed ones.
> -	 */
> -	list_splice_init(&dwc->active_list, &list);
> -	dwc_dostart_first_queued(dwc);
> -
> -	spin_unlock_irqrestore(&dwc->lock, flags);
> -
> -	list_for_each_entry_safe(desc, _desc, &list, desc_node)
> -		dwc_descriptor_complete(dwc, desc, true);
> -}
> -
>  /* Returns how many bytes were already received from source */
>  static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
>  {
> @@ -303,6 +281,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  	struct dw_desc *child;
>  	u32 status_xfer;
>  	unsigned long flags;
> +	LIST_HEAD(list);
>  
>  	spin_lock_irqsave(&dwc->lock, flags);
>  	status_xfer = dma_readl(dw, RAW.XFER);
> @@ -341,9 +320,26 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  			clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
>  		}
>  
> +		/*
> +		 * No more active descriptors left to handle. So submit the
> +		 * queued descriptors and finish up the already handled ones.
> +		 */
> +		if (dma_readl(dw, CH_EN) & dwc->mask) {
> +			dev_err(chan2dev(&dwc->chan),
> +				"BUG: XFER bit set, but channel not idle!\n");
> +
> +			/* Try to continue after resetting the channel... */
> +			dwc_chan_disable(dw, dwc);
> +		}
> +
> +		list_splice_init(&dwc->active_list, &list);
> +		dwc_dostart_first_queued(dwc);
> +
>  		spin_unlock_irqrestore(&dwc->lock, flags);
>  
> -		dwc_complete_all(dw, dwc);
> +		list_for_each_entry_safe(desc, _desc, &list, desc_node)
> +			dwc_descriptor_complete(dwc, desc, true);
> +
>  		return;
>  	}
>  
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

