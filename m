Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F8A305099
	for <lists+dmaengine@lfdr.de>; Wed, 27 Jan 2021 05:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbhA0ERo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Jan 2021 23:17:44 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:57542 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbhAZV4N (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 Jan 2021 16:56:13 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 04FC22C1;
        Tue, 26 Jan 2021 22:54:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1611698100;
        bh=6BWbUKR91ADGnZ02nuVVFTAFGyDAa2wt/lrzHx3tIdw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VX55vkH6fSA893DrzRnA355OHv0k8PpqWr4WrrHJorDWxUS+HNG5O86NlOAcD7KWK
         dmofmJpOWOZKP7v0OLc1PtSSBxe09WqAL5UeAPXFK9Xgdi/WT8uBVuQSEMDRRwXy2v
         3By4Z2J4x6qxAAiob+1NVzoYyvp4bAVu+oauFghk=
Date:   Tue, 26 Jan 2021 23:54:40 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dmaengine: rcar-dmac: Add
 for_each_rcar_dmac_chan() helper
Message-ID: <YBCPoOKGRZYkdfPn@pendragon.ideasonboard.com>
References: <20210125142431.1049668-1-geert+renesas@glider.be>
 <20210125142431.1049668-3-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210125142431.1049668-3-geert+renesas@glider.be>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Mon, Jan 25, 2021 at 03:24:29PM +0100, Geert Uytterhoeven wrote:
> Add and helper macro for iterating over all DMAC channels, taking into

s/and helper/a helper/

> account the channel mask.  Use it where appropriate, to simplify code.
> 
> Restore "reverse Christmas tree" order of local variables while adding a
> new variable.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Put the full loop control of for_each_rcar_dmac_chan() on a single
>     line, to improve readability.
> ---
>  drivers/dma/sh/rcar-dmac.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> index a57705356e8bb796..537550b4121bbc22 100644
> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -209,6 +209,10 @@ struct rcar_dmac {
>  
>  #define to_rcar_dmac(d)		container_of(d, struct rcar_dmac, engine)
>  
> +#define for_each_rcar_dmac_chan(i, chan, dmac)						\

I would have placed the iterator (chan) after the container being
iterated (dmac), but it seems there are some for_each_* macros doing it
the other way around (they may be older though).

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +	for (i = 0, chan = &(dmac)->channels[0]; i < (dmac)->n_channels; i++, chan++)	\
> +		if (!((dmac)->channels_mask & BIT(i))) continue; else
> +
>  /*
>   * struct rcar_dmac_of_data - This driver's OF data
>   * @chan_offset_base: DMAC channels base offset
> @@ -817,15 +821,11 @@ static void rcar_dmac_chan_reinit(struct rcar_dmac_chan *chan)
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
> @@ -1828,9 +1828,10 @@ static int rcar_dmac_probe(struct platform_device *pdev)
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
> @@ -1916,11 +1917,8 @@ static int rcar_dmac_probe(struct platform_device *pdev)
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

-- 
Regards,

Laurent Pinchart
