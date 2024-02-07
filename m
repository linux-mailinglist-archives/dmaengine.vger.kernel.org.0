Return-Path: <dmaengine+bounces-967-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2CC84C624
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 09:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 704A6B24FE1
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 08:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C31200C1;
	Wed,  7 Feb 2024 08:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWPrJ4RU"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28287200C0;
	Wed,  7 Feb 2024 08:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707294372; cv=none; b=SPUobpHmh+HSm11OnTJIzoDK0A4igFS0F3jczyNV8mprEkJhs6dEOnciIfQutt+CDZ/mjTe1dK3/0o0AML8/4Cu3VAkbS/mrtOuq1LJT4hIerVIha6tSfhPoTh6Qz1K6IFi1SWrc2w/FyUvYEBvgICbffRg3JiS9vnEOvz3Bvhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707294372; c=relaxed/simple;
	bh=kk20eFR8A8AL7SqwOYmg4eexD2O3SgXOEqjTFOgwVRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0aVnFQ8oysHJxQyAXOHS3CoU/QCQQ04Y+d9vUr4zsk9t6o6FlbCOMZHafHSu1hspCSCAPp2YiqbmVOFLt5x4kYyUrUUj9c39T8JwY3dCvICrGCny5TaNJNGwo0HXAq/rzcOL+oxXnb3OYc6PBmHbMv6xDysDt/8CbXbaJcOHBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWPrJ4RU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45325C433F1;
	Wed,  7 Feb 2024 08:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707294371;
	bh=kk20eFR8A8AL7SqwOYmg4eexD2O3SgXOEqjTFOgwVRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AWPrJ4RUBls+adUHSEXRulzNK+6ChFb4CV9ebbET9ywxL4dISfgLEPuKySzfXgvl9
	 c9RODstJiLO9yEDjcSuJV7vf4ILx+pJ+ogeREZ2Ccrrc7sWaoFsGPmOX8aZeC8wLDl
	 vKfxzFRy8q5U5CQvpJyeQub4u6wwhmX/ya7hHUSVbiGOwjV6JWH/nPuWB2wpOsLEW7
	 xRjRWUyS5G+wxnkTW/OmWcc9JJd0L5AgYx88gpoFFZQ7w7Wuvmqlxb2rEgBnLKu3Oe
	 mxfoY9ZjuY7XYZVD3C8yaKp1tsmwtyMvaow5utqWQAWPOGD5+5CUsjG9bIFXmzj9KV
	 nhIkPAdK8CbYQ==
Date: Wed, 7 Feb 2024 09:26:08 +0100
From: Vinod Koul <vkoul@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	dmaengine@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Maxime Ripard <maxime@cerno.tech>,
	Dom Cobley <popcornmix@gmail.com>,
	Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH 10/12] dmaengine: bcm2835: Support DMA-Lite channels
Message-ID: <ZcM-oM2hySPlOcyp@matsya>
References: <cover.1706948717.git.andrea.porta@suse.com>
 <ca956587595954525fca0b635a66ca78b7000bf4.1706948717.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca956587595954525fca0b635a66ca78b7000bf4.1706948717.git.andrea.porta@suse.com>

On 04-02-24, 07:59, Andrea della Porta wrote:
> From: Maxime Ripard <maxime@cerno.tech>
> 
> The BCM2712 has a DMA-Lite controller that is basically a BCM2835-style
> DMA controller that supports 40 bits DMA addresses.
> 
> We need it for HDMI audio to work.
> 
> Cc: Maxime Ripard <maxime@cerno.tech>
> Cc: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  drivers/dma/bcm2835-dma.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> index 548cf7343d83..055c558caa0e 100644
> --- a/drivers/dma/bcm2835-dma.c
> +++ b/drivers/dma/bcm2835-dma.c
> @@ -100,6 +100,7 @@ struct bcm2835_chan {
>  
>  	bool is_lite_channel;
>  	bool is_40bit_channel;
> +	bool is_2712;

why not use is_40bit_channel..? also this can be applicable for more
soc, make it generic flag if you cant reuse this one

>  };
>  
>  struct bcm2835_desc {
> @@ -545,7 +546,11 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
>  			control_block->info = info;
>  			control_block->src = src;
>  			control_block->dst = dst;
> -			control_block->stride = 0;
> +			if (c->is_2712)
> +				control_block->stride = (upper_32_bits(dst) << 8) |
> +							upper_32_bits(src);
> +			else
> +				control_block->stride = 0;
>  			control_block->next = 0;
>  		}
>  
> @@ -570,7 +575,8 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
>  			 d->cb_list[frame - 1].cb)->next_cb =
>  				to_bcm2711_cbaddr(cb_entry->paddr);
>  		if (frame && !c->is_40bit_channel)
> -			d->cb_list[frame - 1].cb->next = cb_entry->paddr;
> +			d->cb_list[frame - 1].cb->next = c->is_2712 ?
> +			to_bcm2711_cbaddr(cb_entry->paddr) : cb_entry->paddr;
>  
>  		/* update src and dst and length */
>  		if (src && (info & BCM2835_DMA_S_INC)) {
> @@ -750,7 +756,10 @@ static void bcm2835_dma_start_desc(struct bcm2835_chan *c)
>  		writel(BCM2711_DMA40_ACTIVE | BCM2711_DMA40_PROT | BCM2711_DMA40_CS_FLAGS(c->dreq),
>  		       c->chan_base + BCM2711_DMA40_CS);
>  	} else {
> -		writel(d->cb_list[0].paddr, c->chan_base + BCM2835_DMA_ADDR);
> +		writel(BIT(31), c->chan_base + BCM2835_DMA_CS);
> +
> +		writel(c->is_2712 ? to_bcm2711_cbaddr(d->cb_list[0].paddr) : d->cb_list[0].paddr,
> +		       c->chan_base + BCM2835_DMA_ADDR);
>  		writel(BCM2835_DMA_ACTIVE | BCM2835_DMA_CS_FLAGS(c->dreq),
>  		       c->chan_base + BCM2835_DMA_CS);
>  	}
> @@ -1119,7 +1128,8 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
>  		 d->cb_list[frames - 1].cb)->next_cb =
>  			to_bcm2711_cbaddr(d->cb_list[0].paddr);
>  	else
> -		d->cb_list[d->frames - 1].cb->next = d->cb_list[0].paddr;
> +		d->cb_list[d->frames - 1].cb->next = c->is_2712 ?
> +		to_bcm2711_cbaddr(d->cb_list[0].paddr) : d->cb_list[0].paddr;
>  
>  	return vchan_tx_prep(&c->vc, &d->vd, flags);
>  }
> @@ -1186,6 +1196,8 @@ static int bcm2835_dma_chan_init(struct bcm2835_dmadev *d, int chan_id,
>  	else if (readl(c->chan_base + BCM2835_DMA_DEBUG) &
>  		 BCM2835_DMA_DEBUG_LITE)
>  		c->is_lite_channel = true;
> +	if (d->cfg_data->dma_mask == DMA_BIT_MASK(40))
> +		c->is_2712 = true;
>  
>  	return 0;
>  }
> -- 
> 2.41.0

-- 
~Vinod

