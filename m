Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49FFE483096
	for <lists+dmaengine@lfdr.de>; Mon,  3 Jan 2022 12:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiACLeK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Jan 2022 06:34:10 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45428 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiACLeK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Jan 2022 06:34:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E548161029;
        Mon,  3 Jan 2022 11:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87687C36AEE;
        Mon,  3 Jan 2022 11:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641209649;
        bh=/lhs4d41GymbMsZ45EixKLn5HsmUCmIdUyyiZbhb7fo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gsZxuN/uY+z1XU2mvZv4qiGsLHPc14/2rGbA4eONCdMwVjKDc3PKYjEyfAlql+sq7
         6E45+H2VBJSIPS21lkB/W58ymFXvnNynamfEPflZCu1b7kmld2qsCmHECSBaWykN/d
         4pt7VBT867WhwM/75jSWCvQBjqodfDYPy00r795MDTnk5hucFtwZQfQZQ95LNXXmBO
         MSgFX8He+W5ER0y10cYkAbw5dtQPjOjoE6ni9ZJDQK1aEMFWx+zJdiIJ6Z1MT3Y3ph
         GVeWKO8rGnPra+pTzJGgTqZHQ6De9VCUKIcprelTc8rRTgud1v8odysjo6MuLxyKX2
         5C2yP+wmUhVUw==
Date:   Mon, 3 Jan 2022 17:04:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ptdma: fix concurrency issue with multiple
 dma transfer
Message-ID: <YdLfLc8lfOektWmi@matsya>
References: <1639735118-9798-1-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1639735118-9798-1-git-send-email-Sanju.Mehta@amd.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-12-21, 03:58, Sanjay R Mehta wrote:
> From: Sanjay R Mehta <sanju.mehta@amd.com>
> 
> The command should be submitted only if the engine is idle,
> for this, the next available descriptor is checked and set the flag
> to false in case the descriptor is non-empty.
> 
> Also need to segregate the cases when DMA is complete or not.
> In case if DMA is already complete there is no need to handle it
> again and gracefully exit from the function.
> 
> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> ---
>  drivers/dma/ptdma/ptdma-dmaengine.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/ptdma/ptdma-dmaengine.c b/drivers/dma/ptdma/ptdma-dmaengine.c
> index c9e52f6..91b93e8 100644
> --- a/drivers/dma/ptdma/ptdma-dmaengine.c
> +++ b/drivers/dma/ptdma/ptdma-dmaengine.c
> @@ -100,12 +100,17 @@ static struct pt_dma_desc *pt_handle_active_desc(struct pt_dma_chan *chan,
>  		spin_lock_irqsave(&chan->vc.lock, flags);
>  
>  		if (desc) {
> -			if (desc->status != DMA_ERROR)
> -				desc->status = DMA_COMPLETE;
> -
> -			dma_cookie_complete(tx_desc);
> -			dma_descriptor_unmap(tx_desc);
> -			list_del(&desc->vd.node);
> +			if (desc->status != DMA_COMPLETE) {
> +				if (desc->status != DMA_ERROR)
> +					desc->status = DMA_COMPLETE;
> +
> +				dma_cookie_complete(tx_desc);
> +				dma_descriptor_unmap(tx_desc);
> +				list_del(&desc->vd.node);
> +			} else {
> +				/* Don't handle it twice */
> +				tx_desc = NULL;
> +			}
>  		}
>  
>  		desc = pt_next_dma_desc(chan);
> @@ -233,9 +238,14 @@ static void pt_issue_pending(struct dma_chan *dma_chan)
>  	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
>  	struct pt_dma_desc *desc;
>  	unsigned long flags;
> +	bool engine_is_idle = true;
>  
>  	spin_lock_irqsave(&chan->vc.lock, flags);
>  
> +	desc = pt_next_dma_desc(chan);
> +	if (desc)
> +		engine_is_idle = false;
> +
>  	vchan_issue_pending(&chan->vc);
>  
>  	desc = pt_next_dma_desc(chan);
> @@ -243,7 +253,7 @@ static void pt_issue_pending(struct dma_chan *dma_chan)
>  	spin_unlock_irqrestore(&chan->vc.lock, flags);
>  
>  	/* If there was nothing active, start processing */
> -	if (desc)
> +	if (engine_is_idle)

Can you explain why do you need this flag and why desc is not
sufficient..

It also sounds like 2 patches to me...

>  		pt_cmd_callback(desc, 0);
>  }
>  
> -- 
> 2.7.4

-- 
~Vinod
