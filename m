Return-Path: <dmaengine+bounces-218-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C8F7F7452
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 13:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E20EB20DCB
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 12:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3441D55E;
	Fri, 24 Nov 2023 12:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZqKYnIU"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE451D53B
	for <dmaengine@vger.kernel.org>; Fri, 24 Nov 2023 12:53:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79279C433C7;
	Fri, 24 Nov 2023 12:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700830401;
	bh=jDYI24ELCvDTS98bS4B1Y7XrA4wLz6GtcIczEr1aodo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VZqKYnIUVvr1DuFPlEOpgbiwKJCCFaOv9LTFqBLeA49yywjaB//k5rEIoc1JXAOsY
	 2i0pGQMJAXMYKG5I+cdNY2IkGLkKsdXdF+OSrHDGdZf8rAYJzwkbaC1ENFQfHybCXT
	 CytGgpbeaPCx14LaK4fE8BdabYgwAgSUXC6IOnzpZxEw8ikqAwUfT+4keNaPPJ7FPL
	 lGC0q8PKYO1q7bqvLg5drluWEJ+AumO59ntpiiJeMvN6Aq4n90etbh8kgWvIA7lFws
	 480LN64i6+4az6DfNu3nYKzU3ybINn6hrKWZEXvnnjxkCDqmYOShWEFWVeTyJwxpMD
	 2yOegHEH77jSQ==
Date: Fri, 24 Nov 2023 18:23:16 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Thomas Pfaff <tpfaff@pcs.com>
Cc: ludovic.desroches@microchip.com, tudor.ambarus@microchip.com,
	nicolas.ferre@microchip.com, linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2 stable-6.1] dmaengine: at_hdmac: get next dma
 transfer from the right list
Message-ID: <ZWCcvK5L9vHwSfb2@matsya>
References: <15c92c2f-71e7-f4fd-b90b-412ab53e5a25@pcs.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15c92c2f-71e7-f4fd-b90b-412ab53e5a25@pcs.com>

On 14-11-23, 13:22, Thomas Pfaff wrote:
> From: Thomas Pfaff <tpfaff@pcs.com>
> 
> In kernel 6.1, atc_advance_work and atc_handle_error are checking for the 
> next dma transfer inside active list, but the descriptor is taken from the 
> queue instead.

Sorry that is not how this works. Please send the patch for mainline and
add a stable tag to the patches. They will be backported to stable
kernels

Also, your patch threading is broken, they appear disjoint and not as a
series

Thanks

> 
> Signed-off-by: Thomas Pfaff <tpfaff@pcs.com>
> ---
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index 858bd64f1313..68c1bfbefc5c 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -490,6 +490,27 @@ atc_chain_complete(struct at_dma_chan *atchan, struct at_desc *desc)
>  	}
>  }
>  
> +/**
> + * atc_start_next - start next pending transaction if any
> + * @atchan: channel where the transaction ended
> + *
> + * Called with atchan->lock held
> + */
> +static void atc_start_next(struct at_dma_chan *atchan)
> +{
> +	struct at_desc *desc = NULL;
> +
> +	if (!list_empty(&atchan->active_list))
> +		desc = atc_first_active(atchan);
> +	else if (!list_empty(&atchan->queue)) {
> +		desc = atc_first_queued(atchan);
> +		list_move_tail(&desc->desc_node, &atchan->active_list);
> +	}
> +
> +	if (desc)
> +		atc_dostart(atchan, desc);
> +}
> +
>  /**
>   * atc_advance_work - at the end of a transaction, move forward
>   * @atchan: channel where the transaction ended
> @@ -513,11 +534,7 @@ static void atc_advance_work(struct at_dma_chan *atchan)
>  
>  	/* advance work */
>  	spin_lock_irqsave(&atchan->lock, flags);
> -	if (!list_empty(&atchan->active_list)) {
> -		desc = atc_first_queued(atchan);
> -		list_move_tail(&desc->desc_node, &atchan->active_list);
> -		atc_dostart(atchan, desc);
> -	}
> +	atc_start_next(atchan);
>  	spin_unlock_irqrestore(&atchan->lock, flags);
>  }
>  
> @@ -529,7 +546,6 @@ static void atc_advance_work(struct at_dma_chan *atchan)
>  static void atc_handle_error(struct at_dma_chan *atchan)
>  {
>  	struct at_desc *bad_desc;
> -	struct at_desc *desc;
>  	struct at_desc *child;
>  	unsigned long flags;
>  
> @@ -543,11 +559,7 @@ static void atc_handle_error(struct at_dma_chan *atchan)
>  	list_del_init(&bad_desc->desc_node);
>  
>  	/* Try to restart the controller */
> -	if (!list_empty(&atchan->active_list)) {
> -		desc = atc_first_queued(atchan);
> -		list_move_tail(&desc->desc_node, &atchan->active_list);
> -		atc_dostart(atchan, desc);
> -	}
> +	atc_start_next(atchan);
>  
>  	/*
>  	 * KERN_CRITICAL may seem harsh, but since this only happens
> 

-- 
~Vinod

