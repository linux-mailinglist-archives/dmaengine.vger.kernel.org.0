Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B67285832
	for <lists+dmaengine@lfdr.de>; Wed,  7 Oct 2020 07:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgJGFoK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Oct 2020 01:44:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgJGFoK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 7 Oct 2020 01:44:10 -0400
Received: from localhost (unknown [122.171.222.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 533C1208C7;
        Wed,  7 Oct 2020 05:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602049449;
        bh=szK29eB1aaDwRPv2AAeq7Q2s91RHTL+W1LUcPPKFjlI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FGgaMjpcC8fbyiin8nYnw/U/7+ET6l+beTO3vqzZNA2Bdfz2Uvh+pSNsXRUfM6+1r
         YdTagc9UNzaXvyTNxTVgl3Y+cvMcXoWB7YyvBp6ZLreZjrkVnK3BpnbHjYWwCjveGD
         nn50PNOd5b3ebFvLXrhhwQ704jY/nOdoCMhVmDEg=
Date:   Wed, 7 Oct 2020 11:14:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     nm@ti.com, ssantosh@kernel.org, robh+dt@kernel.org,
        vigneshr@ti.com, dan.j.williams@intel.com, t-kristo@ti.com,
        lokeshvutla@ti.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH 01/18] dmaengine: of-dma: Add support for optional router
 configuration callback
Message-ID: <20201007054404.GR2968@vkoul-mobl>
References: <20200930091412.8020-1-peter.ujfalusi@ti.com>
 <20200930091412.8020-2-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930091412.8020-2-peter.ujfalusi@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,

On 30-09-20, 12:13, Peter Ujfalusi wrote:
> Additional configuration for the DMA event router might be needed for a
> channel which can not be done during device_alloc_chan_resources callback
> since the router information is not yet present for the drivers.
> 
> If there is a need for additional configuration for the channel if DMA
> router is in use, then the driver can implement the device_router_config
> callback.

So what is the additional information you need, I am looking at the code
below and xlate invokes device_router_config() which driver will
implement..

Are you using this to configure channels based on info from DT?

> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/of-dma.c      | 10 ++++++++++
>  include/linux/dmaengine.h |  2 ++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
> index 8a4f608904b9..ec00b20ae8e4 100644
> --- a/drivers/dma/of-dma.c
> +++ b/drivers/dma/of-dma.c
> @@ -75,8 +75,18 @@ static struct dma_chan *of_dma_router_xlate(struct of_phandle_args *dma_spec,
>  		ofdma->dma_router->route_free(ofdma->dma_router->dev,
>  					      route_data);
>  	} else {
> +		int ret = 0;
> +
>  		chan->router = ofdma->dma_router;
>  		chan->route_data = route_data;
> +
> +		if (chan->device->device_router_config)
> +			ret = chan->device->device_router_config(chan);
> +
> +		if (ret) {
> +			dma_release_channel(chan);
> +			chan = ERR_PTR(ret);
> +		}
>  	}
>  
>  	/*
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index dd357a747780..d6197fe875af 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -800,6 +800,7 @@ struct dma_filter {
>   *	by tx_status
>   * @device_alloc_chan_resources: allocate resources and return the
>   *	number of allocated descriptors
> + * @device_router_config: optional callback for DMA router configuration
>   * @device_free_chan_resources: release DMA channel's resources
>   * @device_prep_dma_memcpy: prepares a memcpy operation
>   * @device_prep_dma_xor: prepares a xor operation
> @@ -874,6 +875,7 @@ struct dma_device {
>  	enum dma_residue_granularity residue_granularity;
>  
>  	int (*device_alloc_chan_resources)(struct dma_chan *chan);
> +	int (*device_router_config)(struct dma_chan *chan);
>  	void (*device_free_chan_resources)(struct dma_chan *chan);
>  
>  	struct dma_async_tx_descriptor *(*device_prep_dma_memcpy)(
> -- 
> Peter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-- 
~Vinod
