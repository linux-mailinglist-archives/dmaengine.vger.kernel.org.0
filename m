Return-Path: <dmaengine+bounces-1068-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB9385FA6E
	for <lists+dmaengine@lfdr.de>; Thu, 22 Feb 2024 14:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C94F1F21C83
	for <lists+dmaengine@lfdr.de>; Thu, 22 Feb 2024 13:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431A6134CDC;
	Thu, 22 Feb 2024 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgED2uSd"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5D41332B1;
	Thu, 22 Feb 2024 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610188; cv=none; b=ZBxJRX7hk5imfW4VO2a4AEhtXrRiUvhfxFwOJiaRznofjd7KXhrmrabk/um16t5xrpW+4JVuEFmABpeQlD/lWsCnQkHg/MZXEMetSkExmPJ34tphXq4hq12BfBhk+fSbcy56DxqBSYqLKfwcpsc19ukKzN9jHFh/odOTkMZww2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610188; c=relaxed/simple;
	bh=MqoH/IOMmub+1LbZRsNMRZZ4RRoQgIMbnId83nDHWHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eruveQ22c/S1SugcOO/oFMiCQbnw0XGIhRijT9GA96p6ty97XzR0TfJ8NNTihcdZJ1cEpYGXnELoVpBXIlW9msgF2ct6murzjtxf/Ish06coka7kwwHTIJse+NEws/+dyN4h9lHMFlkmwNN8RRcJ1cDHzkH04gZGgoQbobjEhXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgED2uSd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27054C433C7;
	Thu, 22 Feb 2024 13:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708610187;
	bh=MqoH/IOMmub+1LbZRsNMRZZ4RRoQgIMbnId83nDHWHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fgED2uSdV26bmPjcjKgSvl5QoBplk92aKt2fml1vwu6eyULr31kq1flV8HdEnXHiZ
	 FqmiL3243+Cvi/pepo5M7OMjS+cFk9TSQuj0YF5sry40RskU7G5BytN7NTwvPjWdGR
	 RjGgKxy9U/tmjE29F0l9AyG8ZjxUUWt/ZCrNP+lVPNSqlyNgBoBY/ztfNikMQ4aYUQ
	 YPtrCQ4x3cJvlK6Jd2hm7t8ETlERCYLHulHJDEavef/dCaA0feyGwUkAjoZE//Raxt
	 E5byi1qXLbiVoVQAaGSIe9OMCoWp6vsCblZhQkqYhJJ4SjAx3bzmZU/4IfIaI5YYKt
	 OtzTMGBv58jiA==
Date: Thu, 22 Feb 2024 19:26:23 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Tadeusz Struk <tstruk@gmail.com>
Cc: Raju Rangoju <Raju.Rangoju@amd.com>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Sanjay R Mehta <sanju.mehta@amd.com>,
	Eric Pilmore <epilmore@gigaio.com>, dmaengine@vger.kernel.org,
	Tadeusz Struk <tstruk@gigaio.com>, stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ptdma: use consistent DMA masks
Message-ID: <ZddShyFNaozKwB66@matsya>
References: <6a447bd4-f6f1-fc1f-9a0d-2810357fb1b5@amd.com>
 <20240219201039.40379-1-tstruk@gigaio.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219201039.40379-1-tstruk@gigaio.com>

On 19-02-24, 21:10, Tadeusz Struk wrote:
> The PTDMA driver sets DMA masks in two different places for the same
> device inconsistently. First call is in pt_pci_probe(), where it uses
> 48bit mask. The second call is in pt_dmaengine_register(), where it
> uses a 64bit mask. Using 64bit dma mask causes IO_PAGE_FAULT errors
> on DMA transfers between main memory and other devices.
> Without the extra call it works fine. Additionally the second call
> doesn't check the return value so it can silently fail.
> Remove the superfluous dma_set_mask() call and only use 48bit mask.
> 
> Cc: stable@vger.kernel.org
> Fixes: b0b4a6b10577 ("dmaengine: ptdma: register PTDMA controller as a DMA resource")
> 
No empty line here please

> Signed-off-by: Tadeusz Struk <tstruk@gigaio.com>

I cant pick this, it was sent by email which this patch was not
signed-off by, please either resend from same id as sob or sign with
both

> ---
>  drivers/dma/ptdma/ptdma-dmaengine.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/dma/ptdma/ptdma-dmaengine.c b/drivers/dma/ptdma/ptdma-dmaengine.c
> index 1aa65e5de0f3..f79240734807 100644
> --- a/drivers/dma/ptdma/ptdma-dmaengine.c
> +++ b/drivers/dma/ptdma/ptdma-dmaengine.c
> @@ -385,8 +385,6 @@ int pt_dmaengine_register(struct pt_device *pt)
>  	chan->vc.desc_free = pt_do_cleanup;
>  	vchan_init(&chan->vc, dma_dev);
>  
> -	dma_set_mask_and_coherent(pt->dev, DMA_BIT_MASK(64));
> -
>  	ret = dma_async_device_register(dma_dev);
>  	if (ret)
>  		goto err_reg;
> -- 
> 2.43.2

-- 
~Vinod

