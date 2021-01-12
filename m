Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150292F2C89
	for <lists+dmaengine@lfdr.de>; Tue, 12 Jan 2021 11:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405998AbhALKUg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Jan 2021 05:20:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:48538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404149AbhALKUg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 12 Jan 2021 05:20:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E206224BD;
        Tue, 12 Jan 2021 10:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610446795;
        bh=FNpEb72c5pqR6E4bU7eT/lMCgosF1SZkjNrLmosOVMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lyr68qWFnk6McHbvp0iBrUhJPYvZH3JNCC7U130LFsoOxSZIa/DRHWGZYnKNpvTRO
         HXS9pA5fLb2PakTj2XWAz+fsojSU77W+ATKJpVuKZO3nroFI9TVgWqmAsUtoCWapnS
         KMeLFDDOwxvjn8Ctb6EJQpTo00Wbpn/ZOfoGVMEyW5vrlJdR3SOWM1JH7RyDVslyjT
         32rjTvVq9vuVUTs7uVLA8nT2LtYTFJL5vzHTdgn4LA8tq2dRdZGgs2IHYlX+rdFgpz
         Utup91WfQTeFU6mq2cCp32hxvJ/9J5vyepLB5aVCKIvUPfMKZDJERQxF2CNFdirEKY
         wgBPWVffYV0NA==
Date:   Tue, 12 Jan 2021 15:49:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Phong Hoang <phong.hoang.wz@renesas.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dmaengine: rcar-dmac: Add for_each_rcar_dmac_chan()
 helper
Message-ID: <20210112101950.GK2771@vkoul-mobl>
References: <20210107181524.1947173-1-geert+renesas@glider.be>
 <20210107181524.1947173-3-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107181524.1947173-3-geert+renesas@glider.be>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-01-21, 19:15, Geert Uytterhoeven wrote:
> Add and helper macro for iterating over all DMAC channels, taking into
> account the channel mask.  Use it where appropriate, to simplify code.
> 
> Restore "reverse Christmas tree" order of local variables while adding a
> new variable.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/dma/sh/rcar-dmac.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> index a57705356e8bb796..71cdaf446fcaeba5 100644
> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -209,6 +209,11 @@ struct rcar_dmac {
>  
>  #define to_rcar_dmac(d)		container_of(d, struct rcar_dmac, engine)
>  
> +#define for_each_rcar_dmac_chan(i, chan, dmac)				 \
> +	for (i = 0, chan = &(dmac)->channels[0]; i < (dmac)->n_channels; \
> +	     i++, chan++)						 \

single line to make it more readable? we have limit of 100 now :)


> +		if (!((dmac)->channels_mask & BIT(i))) continue; else
> +
>  /*
>   * struct rcar_dmac_of_data - This driver's OF data
>   * @chan_offset_base: DMAC channels base offset
> @@ -817,15 +822,11 @@ static void rcar_dmac_chan_reinit(struct rcar_dmac_chan *chan)
>  
>  static void rcar_dmac_stop_all_chan(struct rcar_dmac *dmac)
>  {
> +	struct rcar_dmac_chan *chan;
>  	unsigned int i;
>  
>  	/* Stop all channels. */
> -	for (i = 0; i < dmac->n_channels; ++i) {
> -		struct rcar_dmac_chan *chan = &dmac->channels[i];
> -
> -		if (!(dmac->channels_mask & BIT(i)))
> -			continue;
> -
> +	for_each_rcar_dmac_chan(i, chan, dmac) {
>  		/* Stop and reinitialize the channel. */
>  		spin_lock_irq(&chan->lock);
>  		rcar_dmac_chan_halt(chan);
> @@ -1828,9 +1829,10 @@ static int rcar_dmac_probe(struct platform_device *pdev)
>  		DMA_SLAVE_BUSWIDTH_2_BYTES | DMA_SLAVE_BUSWIDTH_4_BYTES |
>  		DMA_SLAVE_BUSWIDTH_8_BYTES | DMA_SLAVE_BUSWIDTH_16_BYTES |
>  		DMA_SLAVE_BUSWIDTH_32_BYTES | DMA_SLAVE_BUSWIDTH_64_BYTES;
> +	const struct rcar_dmac_of_data *data;
> +	struct rcar_dmac_chan *chan;
>  	struct dma_device *engine;
>  	struct rcar_dmac *dmac;
> -	const struct rcar_dmac_of_data *data;
>  	unsigned int i;
>  	int ret;
>  
> @@ -1916,11 +1918,8 @@ static int rcar_dmac_probe(struct platform_device *pdev)
>  
>  	INIT_LIST_HEAD(&engine->channels);
>  
> -	for (i = 0; i < dmac->n_channels; ++i) {
> -		if (!(dmac->channels_mask & BIT(i)))
> -			continue;
> -
> -		ret = rcar_dmac_chan_probe(dmac, &dmac->channels[i], data, i);
> +	for_each_rcar_dmac_chan(i, chan, dmac) {
> +		ret = rcar_dmac_chan_probe(dmac, chan, data, i);
>  		if (ret < 0)
>  			goto error;
>  	}
> -- 
> 2.25.1

-- 
~Vinod
