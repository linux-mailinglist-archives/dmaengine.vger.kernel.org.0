Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671D9438F28
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 08:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhJYGM7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 02:12:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229850AbhJYGM7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 02:12:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C06936023D;
        Mon, 25 Oct 2021 06:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635142237;
        bh=htjBfDAv/fbf9E0uZNabYl3KsNaiUTRrvgCjUk0Ec04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E3HGJ0X8Z47zZOrQl2+GK+0V+9R/+ONSk8UadSPQPRsIsmBG9tOD5J3OpeEQLQjJ9
         V7TdkbUSu3FunLXNCpguIwBT32gNlXNzzD/ITEH+rZM7ny79nLeZVQ6QdH1U1xzyg5
         mOGgAAnwcZcZsW+Fc8uNgjGG0e5CALTsHz+DToeI4If+z7O+ZbeHyDiTASlldfH3Bq
         u675CeNJSwy8sUtgrTVh0s+a2Q9w0zL0eJBlbesH0YInqz/8VUAeW2amStkvP2rKQV
         f4ji8KJo3V8+jle0AmnxCQ8CcGZ1fnq78Zk6tonne7PLOcHw/yig3Q97nP26Zk8VOU
         R2UlzFJbr0Wdw==
Date:   Mon, 25 Oct 2021 11:40:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Harini Katakam <harini.katakam@xilinx.com>
Cc:     romain.perier@gmail.com, allen.lkml@gmail.com, yukuai3@huawei.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, harinikatakamlinux@gmail.com,
        michal.simek@xilinx.com, radhey.shyam.pandey@xilinx.com,
        shravya.kumbham@xilinx.com
Subject: Re: [PATCH 1/4] dmaengine: zynqmp_dma: Typecast the variable to
 handle overflow
Message-ID: <YXZKWVsDU+067GCz@matsya>
References: <20210914082817.22311-1-harini.katakam@xilinx.com>
 <20210914082817.22311-2-harini.katakam@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914082817.22311-2-harini.katakam@xilinx.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-09-21, 13:58, Harini Katakam wrote:
> From: Shravya Kumbham <shravya.kumbham@xilinx.com>
> 
> In zynqmp_dma_alloc/free_chan_resources functions there is a
> potential overflow in the below expressions.
> 
> dma_alloc_coherent(chan->dev, (2 * chan->desc_size *
> 		   ZYNQMP_DMA_NUM_DESCS),
> 		   &chan->desc_pool_p, GFP_KERNEL);
> 
> dma_free_coherent(chan->dev,(2 * ZYNQMP_DMA_DESC_SIZE(chan) *
>                  ZYNQMP_DMA_NUM_DESCS),
>                 chan->desc_pool_v, chan->desc_pool_p);
> 
> The arguments desc_size and ZYNQMP_DMA_NUM_DESCS are 32 bit. Though
> this overflow condition is not observed but it is a potential problem
> in the case of 32-bit multiplication. Hence fix it by using typecast.
> 
> Addresses-Coverity: Event overflow_before_widen.
> Signed-off-by: Shravya Kumbham <shravya.kumbham@xilinx.com>

Patch was sent by Harini Katakam <harini.katakam@xilinx.com> and SOB not
available for person sending this patch, sorry cant accept it with
s-o-b...

> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> ---
>  drivers/dma/xilinx/zynqmp_dma.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
> index 5fecf5aa6e85..2d0eba25739d 100644
> --- a/drivers/dma/xilinx/zynqmp_dma.c
> +++ b/drivers/dma/xilinx/zynqmp_dma.c
> @@ -490,7 +490,8 @@ static int zynqmp_dma_alloc_chan_resources(struct dma_chan *dchan)
>  	}
>  
>  	chan->desc_pool_v = dma_alloc_coherent(chan->dev,
> -					       (2 * chan->desc_size * ZYNQMP_DMA_NUM_DESCS),
> +					       ((size_t)(2 * chan->desc_size) *
> +						ZYNQMP_DMA_NUM_DESCS),
>  					       &chan->desc_pool_p, GFP_KERNEL);
>  	if (!chan->desc_pool_v)
>  		return -ENOMEM;
> @@ -677,7 +678,8 @@ static void zynqmp_dma_free_chan_resources(struct dma_chan *dchan)
>  	zynqmp_dma_free_descriptors(chan);
>  	spin_unlock_irqrestore(&chan->lock, irqflags);
>  	dma_free_coherent(chan->dev,
> -		(2 * ZYNQMP_DMA_DESC_SIZE(chan) * ZYNQMP_DMA_NUM_DESCS),
> +		((size_t)(2 * ZYNQMP_DMA_DESC_SIZE(chan)) *
> +		 ZYNQMP_DMA_NUM_DESCS),
>  		chan->desc_pool_v, chan->desc_pool_p);
>  	kfree(chan->sw_desc_pool);
>  	pm_runtime_mark_last_busy(chan->dev);
> -- 
> 2.17.1

-- 
~Vinod
