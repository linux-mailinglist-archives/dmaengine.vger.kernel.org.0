Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5C5BE6D0
	for <lists+dmaengine@lfdr.de>; Wed, 25 Sep 2019 23:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfIYVC0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Sep 2019 17:02:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:35486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbfIYVC0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 25 Sep 2019 17:02:26 -0400
Received: from localhost (unknown [12.206.46.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6AA021D7A;
        Wed, 25 Sep 2019 21:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569445345;
        bh=M+B8df4fO4o89VpMqPKNuKEjwPg7hrJVm8CXtJbPfpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nyesKN0zIRju+7ohgZtmjiQv6iwSxtzL9B2KQQEyubes9NNcNft+/D1Pzib/vv01g
         ab90kuOZuvY96c1vWP4tZoRrvBhq0oVnFzGEdte4CJSmUbU4kut6LyHtsXWmi0lR/T
         jC86A7nX5bMYYCy4tMPsxvOrsSxq5cWEY3sAzVrI=
Date:   Wed, 25 Sep 2019 14:01:23 -0700
From:   Vinod Koul <vkoul@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     dan.j.williams@intel.com, michal.simek@xilinx.com,
        nick.graumann@gmail.com, andrea.merello@gmail.com,
        appana.durga.rao@xilinx.com, mcgrof@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 3/8] dmaengine: xilinx_dma: Introduce
 xilinx_dma_get_residue
Message-ID: <20190925210123.GL3824@vkoul-mobl>
References: <1567701424-25658-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1567701424-25658-4-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567701424-25658-4-git-send-email-radhey.shyam.pandey@xilinx.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-09-19, 22:06, Radhey Shyam Pandey wrote:
> From: Nicholas Graumann <nick.graumann@gmail.com>
> 
> Introduce a function that can calculate residues for IPs that support it:
> AXI DMA and CDMA.
> 
> Signed-off-by: Nicholas Graumann <nick.graumann@gmail.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 75 ++++++++++++++++++++++++++++++-----------
>  1 file changed, 56 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 9909bfb..4094adb 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -787,6 +787,51 @@ static void xilinx_dma_free_chan_resources(struct dma_chan *dchan)
>  }
>  
>  /**
> + * xilinx_dma_get_residue - Compute residue for a given descriptor
> + * @chan: Driver specific dma channel
> + * @desc: dma transaction descriptor
> + *
> + * Return: The number of residue bytes for the descriptor.
> + */
> +static u32 xilinx_dma_get_residue(struct xilinx_dma_chan *chan,
> +				  struct xilinx_dma_tx_descriptor *desc)
> +{
> +	struct xilinx_cdma_tx_segment *cdma_seg;
> +	struct xilinx_axidma_tx_segment *axidma_seg;
> +	struct xilinx_cdma_desc_hw *cdma_hw;
> +	struct xilinx_axidma_desc_hw *axidma_hw;
> +	struct list_head *entry;
> +	u32 residue = 0;
> +
> +	/**

it should be:
        /*
         * comment...

> +	 * VDMA and simple mode do not support residue reporting, so the
> +	 * residue field will always be 0.
> +	 */
> +	if (chan->xdev->dma_config->dmatype == XDMA_TYPE_VDMA || !chan->has_sg)
> +		return residue;

why not check this in status callback?

> +
> +	list_for_each(entry, &desc->segments) {
> +		if (chan->xdev->dma_config->dmatype == XDMA_TYPE_CDMA) {
> +			cdma_seg = list_entry(entry,
> +					      struct xilinx_cdma_tx_segment,
> +					      node);
> +			cdma_hw = &cdma_seg->hw;
> +			residue += (cdma_hw->control - cdma_hw->status) &
> +				   chan->xdev->max_buffer_len;
> +		} else {
> +			axidma_seg = list_entry(entry,
> +						struct xilinx_axidma_tx_segment,
> +						node);
> +			axidma_hw = &axidma_seg->hw;
> +			residue += (axidma_hw->control - axidma_hw->status) &
> +				   chan->xdev->max_buffer_len;
> +		}
> +	}
> +
> +	return residue;
> +}
> +
> +/**
>   * xilinx_dma_chan_handle_cyclic - Cyclic dma callback
>   * @chan: Driver specific dma channel
>   * @desc: dma transaction descriptor
> @@ -995,33 +1040,22 @@ static enum dma_status xilinx_dma_tx_status(struct dma_chan *dchan,
>  {
>  	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
>  	struct xilinx_dma_tx_descriptor *desc;
> -	struct xilinx_axidma_tx_segment *segment;
> -	struct xilinx_axidma_desc_hw *hw;
>  	enum dma_status ret;
>  	unsigned long flags;
> -	u32 residue = 0;
>  
>  	ret = dma_cookie_status(dchan, cookie, txstate);
>  	if (ret == DMA_COMPLETE || !txstate)
>  		return ret;
>  
> -	if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
> -		spin_lock_irqsave(&chan->lock, flags);
> +	spin_lock_irqsave(&chan->lock, flags);
>  
> -		desc = list_last_entry(&chan->active_list,
> -				       struct xilinx_dma_tx_descriptor, node);
> -		if (chan->has_sg) {
> -			list_for_each_entry(segment, &desc->segments, node) {
> -				hw = &segment->hw;
> -				residue += (hw->control - hw->status) &
> -					   chan->xdev->max_buffer_len;
> -			}
> -		}
> -		spin_unlock_irqrestore(&chan->lock, flags);
> +	desc = list_last_entry(&chan->active_list,
> +			       struct xilinx_dma_tx_descriptor, node);
> +	chan->residue = xilinx_dma_get_residue(chan, desc);
>  
> -		chan->residue = residue;
> -		dma_set_residue(txstate, chan->residue);
> -	}
> +	spin_unlock_irqrestore(&chan->lock, flags);
> +
> +	dma_set_residue(txstate, chan->residue);
>  
>  	return ret;
>  }
> @@ -2701,12 +2735,15 @@ static int xilinx_dma_probe(struct platform_device *pdev)
>  					  xilinx_dma_prep_dma_cyclic;
>  		xdev->common.device_prep_interleaved_dma =
>  					xilinx_dma_prep_interleaved;
> -		/* Residue calculation is supported by only AXI DMA */
> +		/* Residue calculation is supported by only AXI DMA and CDMA */
>  		xdev->common.residue_granularity =
>  					  DMA_RESIDUE_GRANULARITY_SEGMENT;
>  	} else if (xdev->dma_config->dmatype == XDMA_TYPE_CDMA) {
>  		dma_cap_set(DMA_MEMCPY, xdev->common.cap_mask);
>  		xdev->common.device_prep_dma_memcpy = xilinx_cdma_prep_memcpy;
> +		/* Residue calculation is supported by only AXI DMA and CDMA */
> +		xdev->common.residue_granularity =
> +					DMA_RESIDUE_GRANULARITY_SEGMENT;
>  	} else {
>  		xdev->common.device_prep_interleaved_dma =
>  				xilinx_vdma_dma_prep_interleaved;
> -- 
> 2.7.4

-- 
~Vinod
