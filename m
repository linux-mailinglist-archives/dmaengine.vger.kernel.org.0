Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955031B552A
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2020 09:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgDWHHC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Apr 2020 03:07:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbgDWHHC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 23 Apr 2020 03:07:02 -0400
Received: from localhost (unknown [49.207.59.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4995208E4;
        Thu, 23 Apr 2020 07:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587625621;
        bh=dqOAH6f+q0EsFhUG8mK6iVhk6XGZrFa8diYIKEfHARs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YWXxvT27gIOMUwaVeCCRelYlSwvfPbErLib5+ZaS+D6wXfO4XdOb9Ew3kYjK4iZz4
         dTnTJ91p2Kw+fLQo4f/j1ta5Q3PMBEClBwYOOTWjorHL3eBm5CUKi8DLHEQpIveHSg
         U0T+P78Jxc4r2EK1rVS1INybje4pUz5lyxCZoFXI=
Date:   Thu, 23 Apr 2020 12:36:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] dmaengine: mmp_tdma: Validate the transfer direction
Message-ID: <20200423070657.GW72691@vkoul-mobl>
References: <20200419164912.670973-1-lkundrak@v3.sk>
 <20200419164912.670973-4-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419164912.670973-4-lkundrak@v3.sk>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-04-20, 18:49, Lubomir Rintel wrote:
> We only support DMA_DEV_TO_MEM and DMA_MEM_TO_DEV. Let's not do
> undefined things with other values and reject them.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/dma/mmp_tdma.c | 37 ++++++++++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
> index d559bb4d6a31d..d574641791598 100644
> --- a/drivers/dma/mmp_tdma.c
> +++ b/drivers/dma/mmp_tdma.c
> @@ -207,10 +207,17 @@ static int mmp_tdma_config_chan(struct dma_chan *chan)
>  
>  	mmp_tdma_disable_chan(chan);
>  
> -	if (tdmac->dir == DMA_MEM_TO_DEV)
> -		tdcr = TDCR_DSTDIR_ADDR_HOLD | TDCR_SRCDIR_ADDR_INC;
> -	else if (tdmac->dir == DMA_DEV_TO_MEM)
> +	switch (tdmac->dir) {
> +	case DMA_DEV_TO_MEM:
>  		tdcr = TDCR_SRCDIR_ADDR_HOLD | TDCR_DSTDIR_ADDR_INC;
> +		break;
> +	case DMA_MEM_TO_DEV:
> +		tdcr = TDCR_DSTDIR_ADDR_HOLD | TDCR_SRCDIR_ADDR_INC;
> +		break;
> +	default:
> +		dev_err(tdmac->dev, "invalid transfer direction\n");
> +		return -EINVAL;
> +	}

You can use macros is_slave_direction() to validate

>  	if (tdmac->type == MMP_AUD_TDMA) {
>  		tdcr |= TDCR_PACKMOD;
> @@ -455,12 +462,18 @@ static struct dma_async_tx_descriptor *mmp_tdma_prep_dma_cyclic(
>  			desc->nxt_desc = tdmac->desc_arr_phys +
>  				sizeof(*desc) * (i + 1);
>  

It would make more sense to use is_slave_direction() and reject up early
in the function and proceed only when good :)

> -		if (direction == DMA_MEM_TO_DEV) {
> -			desc->src_addr = dma_addr;
> -			desc->dst_addr = tdmac->dev_addr;
> -		} else {
> +		switch (direction) {
> +		case DMA_DEV_TO_MEM:
>  			desc->src_addr = tdmac->dev_addr;
>  			desc->dst_addr = dma_addr;
> +			break;
> +		case DMA_MEM_TO_DEV:
> +			desc->src_addr = dma_addr;
> +			desc->dst_addr = tdmac->dev_addr;
> +			break;
> +		default:
> +			dev_err(tdmac->dev, "invalid transfer direction\n");
> +			goto err_out;
>  		}
>  		desc->byte_cnt = period_len;
>  		dma_addr += period_len;
> @@ -510,14 +523,20 @@ static int mmp_tdma_config_write(struct dma_chan *chan,
>  {
>  	struct mmp_tdma_chan *tdmac = to_mmp_tdma_chan(chan);
>  
> -	if (dir == DMA_DEV_TO_MEM) {
> +	switch (dir) {
> +	case DMA_DEV_TO_MEM:
>  		tdmac->dev_addr = dmaengine_cfg->src_addr;
>  		tdmac->burst_sz = dmaengine_cfg->src_maxburst;
>  		tdmac->buswidth = dmaengine_cfg->src_addr_width;
> -	} else {
> +		break;
> +	case DMA_MEM_TO_DEV:
>  		tdmac->dev_addr = dmaengine_cfg->dst_addr;
>  		tdmac->burst_sz = dmaengine_cfg->dst_maxburst;
>  		tdmac->buswidth = dmaengine_cfg->dst_addr_width;
> +		break;
> +	default:
> +		dev_err(tdmac->dev, "invalid transfer direction\n");
> +		return -EINVAL;

is this required, if you have checked in all _prep() fns then you are
guaranteed that this will never hit, right?

-- 
~Vinod
