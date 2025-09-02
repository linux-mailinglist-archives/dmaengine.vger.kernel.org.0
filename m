Return-Path: <dmaengine+bounces-6308-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CD5B3F5BC
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 08:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D3D205B76
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 06:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46E22E425E;
	Tue,  2 Sep 2025 06:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keYJIQTo"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB480202F93;
	Tue,  2 Sep 2025 06:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756795371; cv=none; b=XfGvFMpHKm3HsVdbTlfzaGJ5fO1C/Nz4jqcAoZXvVERDjzMgpN9Rwr3cGGjme1pwmeoYwWHE6sEcydhnn0UM1C1PZ2/dYFte6zc5WXGNVhVB4+VHNmoAwGMp/u5vmxX1cTUxDJ/T2jyn9zqLoBv/MKTu0tIr9Rw0xlDwcoGwAkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756795371; c=relaxed/simple;
	bh=y7s8e1sMMgSXAhYXT1RwdXoiI3R/OI16P+7SfsNDucI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOKcxtxDMtvqK0atWFd4cGLPDum4nVa5D7SpC6PgBgxaHElANe4iz9/QMR0ZQ86AEs+tsteobcE6ecnzzdwkMFTxHjF1I4Ncsn2ctsfIV3sNJPQ1aHNzUGutbkVZu1/1E3MvOoKVBSw5hUHAiW2LdvOMAxO/Fvxmwt1WE8GJxlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keYJIQTo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8506DC4CEED;
	Tue,  2 Sep 2025 06:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756795371;
	bh=y7s8e1sMMgSXAhYXT1RwdXoiI3R/OI16P+7SfsNDucI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=keYJIQToD0aTRfLwaWLaM1SCTQ7lYH7nbDFRimcZPUTw/HZedUD4LEebvrazvdxDv
	 E63omAIioz1NiNnSnqFHv3SRXXhYijPjqcL22psmRAHtAcslDf71YXST2HdQ4rZJ5r
	 LKxD9QmM3POWIVhbVJDQJ4iYFyYx2mgOc8g77DeWJfIXWqXickk2SuEuTSijhACzda
	 q2SofWoNU+8brT/Z8gF2+JeY+2/KTFZhCImPkyvbJB3dfrZ8suWqh4XtCyRbpptOiV
	 8qmF1U6gWyT9r9K3mg9PInKS9lrQShrhDZNhT/8+Lw68qDOTVvzlS6/hEGwDzCs8Pi
	 KlkrMz3++0fUw==
Date: Tue, 2 Sep 2025 12:12:46 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3 3/3] dmaengine: mv_xor: use devm for request_irq
Message-ID: <aLaR5saI469MsgAT@vaman>
References: <20250827220005.82899-1-rosenp@gmail.com>
 <20250827220005.82899-4-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827220005.82899-4-rosenp@gmail.com>

On 27-08-25, 15:00, Rosen Penev wrote:
> This is only called in _probe. Removes the need to manually free_irq.

That can be intentional! We need to ensure the device is quiesced before
teardown...

> 
> Same with irq_dispose_mapping.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/dma/mv_xor.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
> index d15a1990534b..81799ac2f48b 100644
> --- a/drivers/dma/mv_xor.c
> +++ b/drivers/dma/mv_xor.c
> @@ -1025,8 +1025,6 @@ static int mv_xor_channel_remove(struct mv_xor_chan *mv_chan)
>  		list_del(&chan->device_node);
>  	}
>  
> -	free_irq(mv_chan->irq, mv_chan);
> -
>  	return 0;
>  }
>  
> @@ -1112,8 +1110,9 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
>  	/* clear errors before enabling interrupts */
>  	mv_chan_clear_err_status(mv_chan);
>  
> -	ret = request_irq(mv_chan->irq, mv_xor_interrupt_handler,
> -			  0, dev_name(&pdev->dev), mv_chan);
> +	ret = devm_request_irq(&pdev->dev, mv_chan->irq,
> +			       mv_xor_interrupt_handler, 0,
> +			       dev_name(&pdev->dev), mv_chan);
>  	if (ret)
>  		goto err_free_dma;
>  
> @@ -1138,14 +1137,14 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
>  		ret = mv_chan_memcpy_self_test(mv_chan);
>  		dev_dbg(&pdev->dev, "memcpy self test returned %d\n", ret);
>  		if (ret)
> -			goto err_free_irq;
> +			goto err_free_dma;
>  	}
>  
>  	if (dma_has_cap(DMA_XOR, dma_dev->cap_mask)) {
>  		ret = mv_chan_xor_self_test(mv_chan);
>  		dev_dbg(&pdev->dev, "xor self test returned %d\n", ret);
>  		if (ret)
> -			goto err_free_irq;
> +			goto err_free_dma;
>  	}
>  
>  	dev_info(&pdev->dev, "Marvell XOR (%s): ( %s%s%s)\n",
> @@ -1156,12 +1155,10 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
>  
>  	ret = dma_async_device_register(dma_dev);
>  	if (ret)
> -		goto err_free_irq;
> +		goto err_free_dma;
>  
>  	return mv_chan;
>  
> -err_free_irq:
> -	free_irq(mv_chan->irq, mv_chan);
>  err_free_dma:
>  	dma_free_wc(&pdev->dev, MV_XOR_POOL_SIZE,
>  			  mv_chan->dma_desc_pool_virt, mv_chan->dma_desc_pool);
> @@ -1400,7 +1397,6 @@ static int mv_xor_probe(struct platform_device *pdev)
>  						  cap_mask, irq);
>  			if (IS_ERR(chan)) {
>  				ret = PTR_ERR(chan);
> -				irq_dispose_mapping(irq);
>  				goto err_channel_add;
>  			}
>  
> @@ -1435,11 +1431,8 @@ static int mv_xor_probe(struct platform_device *pdev)
>  
>  err_channel_add:
>  	for (i = 0; i < MV_XOR_MAX_CHANNELS; i++)
> -		if (xordev->channels[i]) {
> +		if (xordev->channels[i])
>  			mv_xor_channel_remove(xordev->channels[i]);
> -			if (pdev->dev.of_node)
> -				irq_dispose_mapping(xordev->channels[i]->irq);
> -		}
>  
>  	return ret;
>  }
> -- 
> 2.51.0

-- 
~Vinod

