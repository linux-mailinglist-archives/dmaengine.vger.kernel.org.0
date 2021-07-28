Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7ED3D8873
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jul 2021 09:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhG1HBm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Jul 2021 03:01:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229939AbhG1HBl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Jul 2021 03:01:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE4D960C3F;
        Wed, 28 Jul 2021 07:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627455700;
        bh=Pe0ZHMvG6qcMakxU7KrbLnoLHeVkuUbgO2phXsQdKIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FDM94G/gs3YI/de0Hn+IFf1JEtQUWdlfETwkJAOFV/i1q1p/7EwnNxCO4pG+tq0NS
         uUDsd0J27wKzd7zHuWRyOYZM9zNM5WzWE3jN7aDlMk/4MSUQlEFE0Baroz3Z2Bh8N9
         HoLOvWVluDlimoejnxJNxv4VbL4ceF6w3n9xJfiB7Ry0zHK+yvzI9cqhCkm9p4UgEj
         j46t6kJxIUq7Uru/pBwHNfj1ZBjwA6CeNDDu9KLkVgQtsqG7/FEX3EkeaNDUFYnZPZ
         X7KORUm6AScHYRX1b/sGowGkEsqxnEaxSAxdCMbqqUK5uj3siEZxqTzqWOvIwIFy9a
         1MXRU16KRCb3A==
Date:   Wed, 28 Jul 2021 12:31:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Harini Katakam <harini.katakam@xilinx.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        harinikatakamlinux@gmail.com, michal.simek@xilinx.com,
        radhey.shyam.pandey@xilinx.com, shravya.kumbham@xilinx.com
Subject: Re: [PATCH] dmaengine: pl330: Typecast with enum to fix the coverity
 warning
Message-ID: <YQEA0DWG4X8U83/z@matsya>
References: <20210629103710.24828-1-harini.katakam@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629103710.24828-1-harini.katakam@xilinx.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-06-21, 16:07, Harini Katakam wrote:
> From: Shravya Kumbham <shravya.kumbham@xilinx.com>
> 
> Typecast the flags and flg variables with (enum dma_ctrl_flags) in
> pl330_prep_dma_cyclic, pl330_prep_dma_memcpy and pl330_prep_slave_sg
> functions to fix the coverity warning.
> 
> Addresses-Coverity: Event mixed_enum_type.
> Signed-off-by: Shravya Kumbham <shravya.kumbham@xilinx.com>
> Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> ---
>  drivers/dma/pl330.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index 110de8a60058..35afbad2e1a7 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -2752,7 +2752,7 @@ static struct dma_async_tx_descriptor *pl330_prep_dma_cyclic(
>  		return NULL;
>  
>  	pch->cyclic = true;
> -	desc->txd.flags = flags;
> +	desc->txd.flags = (enum dma_ctrl_flags)flags;

Does this driver use the txd.flags?

>  
>  	return &desc->txd;
>  }
> @@ -2804,7 +2804,7 @@ pl330_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dst,
>  
>  	desc->bytes_requested = len;
>  
> -	desc->txd.flags = flags;
> +	desc->txd.flags = (enum dma_ctrl_flags)flags;
>  
>  	return &desc->txd;
>  }
> @@ -2889,7 +2889,7 @@ pl330_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  	}
>  
>  	/* Return the last desc in the chain */
> -	desc->txd.flags = flg;
> +	desc->txd.flags = (enum dma_ctrl_flags)flg;
>  	return &desc->txd;
>  }
>  
> -- 
> 2.17.1

-- 
~Vinod
