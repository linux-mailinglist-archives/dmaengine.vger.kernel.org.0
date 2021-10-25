Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E86438E7B
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 06:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbhJYErC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 00:47:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230004AbhJYErC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 00:47:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA9C960FBF;
        Mon, 25 Oct 2021 04:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635137080;
        bh=sOhHF+HAnRoEIqH19QgSH9mZon6LU9SS6cFQOHW/XKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fXkfEU/RowxRIqyNz781xmT/AtHIyBELbIK0hw32+2rGJcYmWkVmoyjnEA/hnIo10
         vwo2VYnwXIEb7O59Ws4YkADa0NpE8ATi+cJ/NxQIsFseO8LzobCID6pVXOKKbGINu4
         SeVW04XVRw/XA3HuAFFJQWAIxUrhddp8ptamlUjBLkuDhQaOiuKNHkNp8kmhQDMZgQ
         Oqtn53v7ppjrN4+moHDju3sRVRHdfGf6i38dZSsB+Z0PeR/RGyjBmcHtpSPW2WHak9
         skn5BmGIF87XBHuRfRXgdCQ3k9iY1VSHd4EDh2C7IKWxIHMPttiqPlSjaNXXs2js34
         w7QCyswT10YTA==
Date:   Mon, 25 Oct 2021 10:14:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Joy Zou <joy.zou@nxp.com>
Cc:     yibin.gong@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dmaengine: imx-sdma: support hdmi audio
Message-ID: <YXY2M0td08eDCi+9@matsya>
References: <20211021051611.3155385-1-joy.zou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021051611.3155385-1-joy.zou@nxp.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-10-21, 13:16, Joy Zou wrote:
> Add hdmi audio support in sdma.

Pls send a series together and chained. They appear here as disjoint
patches

> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
>  drivers/dma/imx-sdma.c                | 38 +++++++++++++++++++++------
>  include/linux/platform_data/dma-imx.h |  1 +
>  2 files changed, 31 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index cacc725ca545..3a0e408f7741 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -907,7 +907,10 @@ static irqreturn_t sdma_int_handler(int irq, void *dev_id)
>  		desc = sdmac->desc;
>  		if (desc) {
>  			if (sdmac->flags & IMX_DMA_SG_LOOP) {
> -				sdma_update_channel_loop(sdmac);
> +				if (sdmac->peripheral_type != IMX_DMATYPE_HDMI)
> +					sdma_update_channel_loop(sdmac);
> +				else
> +					vchan_cyclic_callback(&desc->vd);
>  			} else {
>  				mxc_sdma_handle_channel_normal(sdmac);
>  				vchan_cookie_complete(&desc->vd);
> @@ -1023,6 +1026,10 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
>  	case IMX_DMATYPE_IPU_MEMORY:
>  		emi_2_per = sdma->script_addrs->ext_mem_2_ipu_addr;
>  		break;
> +	case IMX_DMATYPE_HDMI:
> +		emi_2_per = sdma->script_addrs->hdmi_dma_addr;
> +		sdmac->is_ram_script = true;
> +		break;
>  	default:
>  		break;
>  	}
> @@ -1070,11 +1077,16 @@ static int sdma_load_context(struct sdma_channel *sdmac)
>  	/* Send by context the event mask,base address for peripheral
>  	 * and watermark level
>  	 */
> -	context->gReg[0] = sdmac->event_mask[1];
> -	context->gReg[1] = sdmac->event_mask[0];
> -	context->gReg[2] = sdmac->per_addr;
> -	context->gReg[6] = sdmac->shp_addr;
> -	context->gReg[7] = sdmac->watermark_level;
> +	if (sdmac->peripheral_type == IMX_DMATYPE_HDMI) {
> +		context->gReg[4] = sdmac->per_addr;
> +		context->gReg[6] = sdmac->shp_addr;
> +	} else {
> +		context->gReg[0] = sdmac->event_mask[1];
> +		context->gReg[1] = sdmac->event_mask[0];
> +		context->gReg[2] = sdmac->per_addr;
> +		context->gReg[6] = sdmac->shp_addr;
> +		context->gReg[7] = sdmac->watermark_level;
> +	}
>  
>  	bd0->mode.command = C0_SETDM;
>  	bd0->mode.status = BD_DONE | BD_WRAP | BD_EXTD;
> @@ -1420,7 +1432,7 @@ static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
>  	desc->sdmac = sdmac;
>  	desc->num_bd = bds;
>  
> -	if (sdma_alloc_bd(desc))
> +	if (bds && sdma_alloc_bd(desc))
>  		goto err_desc_out;
>  
>  	/* No slave_config called in MEMCPY case, so do here */
> @@ -1585,13 +1597,16 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
>  {
>  	struct sdma_channel *sdmac = to_sdma_chan(chan);
>  	struct sdma_engine *sdma = sdmac->sdma;
> -	int num_periods = buf_len / period_len;
> +	int num_periods = 0;
>  	int channel = sdmac->channel;
>  	int i = 0, buf = 0;
>  	struct sdma_desc *desc;
>  
>  	dev_dbg(sdma->dev, "%s channel: %d\n", __func__, channel);
>  
> +	if (sdmac->peripheral_type != IMX_DMATYPE_HDMI)
> +		num_periods = buf_len / period_len;
> +
>  	sdma_config_write(chan, &sdmac->slave_config, direction);
>  
>  	desc = sdma_transfer_init(sdmac, direction, num_periods);
> @@ -1608,6 +1623,9 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
>  		goto err_bd_out;
>  	}
>  
> +	if (sdmac->peripheral_type == IMX_DMATYPE_HDMI)
> +		return vchan_tx_prep(&sdmac->vc, &desc->vd, flags);
> +
>  	while (buf < buf_len) {
>  		struct sdma_buffer_descriptor *bd = &desc->bd[i];
>  		int param;
> @@ -1668,6 +1686,10 @@ static int sdma_config_write(struct dma_chan *chan,
>  		sdmac->watermark_level |= (dmaengine_cfg->dst_maxburst << 16) &
>  			SDMA_WATERMARK_LEVEL_HWML;
>  		sdmac->word_size = dmaengine_cfg->dst_addr_width;
> +	} else if (sdmac->peripheral_type == IMX_DMATYPE_HDMI) {
> +		sdmac->per_address = dmaengine_cfg->dst_addr;
> +		sdmac->per_address2 = dmaengine_cfg->src_addr;
> +		sdmac->watermark_level = 0;
>  	} else {
>  		sdmac->per_address = dmaengine_cfg->dst_addr;
>  		sdmac->watermark_level = dmaengine_cfg->dst_maxburst *

You missed adding cyclic capability, pls add that

> diff --git a/include/linux/platform_data/dma-imx.h b/include/linux/platform_data/dma-imx.h
> index 281adbb26e6b..29ac21d40f28 100644
> --- a/include/linux/platform_data/dma-imx.h
> +++ b/include/linux/platform_data/dma-imx.h
> @@ -39,6 +39,7 @@ enum sdma_peripheral_type {
>  	IMX_DMATYPE_SSI_DUAL,	/* SSI Dual FIFO */
>  	IMX_DMATYPE_ASRC_SP,	/* Shared ASRC */
>  	IMX_DMATYPE_SAI,	/* SAI */
> +	IMX_DMATYPE_HDMI,	/* HDMI Audio */

Why is this in latform_data, these should be moved to
include/dt-bindings

-- 
~Vinod
