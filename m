Return-Path: <dmaengine+bounces-5847-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E45B0F1E4
	for <lists+dmaengine@lfdr.de>; Wed, 23 Jul 2025 14:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A621154153D
	for <lists+dmaengine@lfdr.de>; Wed, 23 Jul 2025 12:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B1B2DEA7C;
	Wed, 23 Jul 2025 12:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDuDHOtX"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3074115A87C;
	Wed, 23 Jul 2025 12:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753272398; cv=none; b=NYfdwsbGFQeIGu565lXWviR2paiSt+CQGfeX/+3km31H39yxD+lrdnG9X8ACjJRMFR9uG5s+t9rus8Thcz+y8JaXCOssJev87xvEc4GYok/TVuMRDrqPt/gh0q3wP7xuaMLHTtJ8CLr12mjR9eK6vMsliToDhuqULp6vN/rKvJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753272398; c=relaxed/simple;
	bh=Ki0wS+eLFaawMwxNorwdBa8X/r8ESGBorw2LEHlzP64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSl+7K1o/4PS9rVFeEv1BbQaLkHxbvQoZHGLlU8v8y97rXyTCvuLeawcrzJ3em4+Uy6/jjYUOPz1inax3LjFDAsnHw1CHjid+PLtRnFe57gxPMNV16WacKtRjFgSVqGWexddq/Bn7K75TRjcB6GcriGtEMBzxO8NTex8EqJTZ+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDuDHOtX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D065C4CEE7;
	Wed, 23 Jul 2025 12:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753272396;
	bh=Ki0wS+eLFaawMwxNorwdBa8X/r8ESGBorw2LEHlzP64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vDuDHOtXLjH2SJhmmCSo7ZDFdRpQ+zKISQBN24mNxe0C6UutefOLuuyLt7TVdpu4l
	 sSSsEbLDGqA8/FkUROyO8q2DI4NoR3pQ9rJzRbJAxStkxhAfsWqGc1A8scHQQBrjCN
	 oIxCzHhci60unI5k+iHROJosSb9f/g/O6AtU++jUDSPEe0NMX7kyUPRIGiWBBcfsGW
	 XDQORnlYoMjzOumNyFNSjJ4yQOFr0E/gP7dYhVs/cy0eZ2rHu6OfIsHSn7YKNEdPpx
	 i8T3hjk7bh1UpTQIzb8ImtfPRhrSzDqdlPeapvqWvhDsTGBZ9HDfkjTgEcR5awsYn/
	 wrLfr/55W7RnQ==
Date: Wed, 23 Jul 2025 17:36:32 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: nbpfaxi:  Add missing check after DMA map
Message-ID: <aIDQSA3JFbyyaWkM@vaman>
References: <20250707075752.28674-2-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707075752.28674-2-fourier.thomas@gmail.com>

On 07-07-25, 09:57, Thomas Fourier wrote:
> The DMA map functions can fail and should be tested for errors.
> If the mapping fails, unmap and return an error.

Pls change this to dmaengine: xxx that is the subsystem name as show in
the Fixes tag that you picked up below

Meanwhile this does not apply for me, pls rebase

> 
> Fixes: b45b262cefd5 ("dmaengine: add a driver for AMBA AXI NBPF DMAC IP cores")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
>  drivers/dma/nbpfaxi.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
> index 0d6324c4e2be..0b75bb122898 100644
> --- a/drivers/dma/nbpfaxi.c
> +++ b/drivers/dma/nbpfaxi.c
> @@ -711,6 +711,9 @@ static int nbpf_desc_page_alloc(struct nbpf_channel *chan)
>  		list_add_tail(&ldesc->node, &lhead);
>  		ldesc->hwdesc_dma_addr = dma_map_single(dchan->device->dev,
>  					hwdesc, sizeof(*hwdesc), DMA_TO_DEVICE);
> +		if (dma_mapping_error(dchan->device->dev,
> +				      ldesc->hwdesc_dma_addr))
> +			goto unmap_error;
>  
>  		dev_dbg(dev, "%s(): mapped 0x%p to %pad\n", __func__,
>  			hwdesc, &ldesc->hwdesc_dma_addr);
> @@ -737,6 +740,16 @@ static int nbpf_desc_page_alloc(struct nbpf_channel *chan)
>  	spin_unlock_irq(&chan->lock);
>  
>  	return ARRAY_SIZE(dpage->desc);
> +
> +unmap_error:
> +	while (i--) {
> +		ldesc--; hwdesc--;
> +
> +		dma_unmap_single(dchan->device->dev, ldesc->hwdesc_dma_addr,
> +				 sizeof(hwdesc), DMA_TO_DEVICE);
> +	}
> +
> +	return -ENOMEM;
>  }
>  
>  static void nbpf_desc_put(struct nbpf_desc *desc)
> -- 
> 2.43.0

-- 
~Vinod

