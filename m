Return-Path: <dmaengine+bounces-3850-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7848C9E0870
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 17:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44ADE28227B
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 16:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FB5199235;
	Mon,  2 Dec 2024 16:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqDFWYx7"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052A5AD51;
	Mon,  2 Dec 2024 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733156824; cv=none; b=RVtYv/cIKvSql9Dhgb9bT9Gsxqhq5xYyUVbJXQNsDwjPhO5eZVzxoNmV9fCdBKXSavN3QEVYgtZdhP2hPhqupn1k7y8T5a0A0rIE6aJ1zAlvj0i8KFnW/F45XX5QVlEeINbR7NqXiOW++fkX/uXqNmbqXyTpj4OQi2pIvQYQooA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733156824; c=relaxed/simple;
	bh=nPtb1zSByJeaDM0DUV8mbGmOuC3IvCO7oLz660454R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnEVsCFSlU2D/h/xY+hNFFCENKNOJW/T/qrS5VSWUhOeT4XCfQu01k6TCKQO3PaPzY4vC+DG8Dbj2R+gnKIgR9/ZO5PFhH+Hp/X3oc9U4LBT6e7ZP+iKBERKg7m/cWw3SrepFJ3c8/2n4EGIDkD0wAlok5JFycqBMXlQyt60xiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqDFWYx7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3500C4CED6;
	Mon,  2 Dec 2024 16:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733156823;
	bh=nPtb1zSByJeaDM0DUV8mbGmOuC3IvCO7oLz660454R8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tqDFWYx7tpuPs3199TfcyJNFHIKuE9dIV29mA/Za4FBuKVG04CgyqNFfqVNTXOkGE
	 j5u+kEm6H5NIy4FvI/Jo5lXhzQcMhvrPpRtT8TWqTy7jrTDrJcy08aqMoaDKDlnm04
	 7uEsw71bbPEAa8jiTRrjUn58w39Tc5IKSbLrELF05NTtzs5FfsAOG2S8Dna5J0Adcl
	 UVmAVfjsJy/+ZFFf2p7UB0mixrpNIiVPGsC88kxq88WslnlWxI22tRcX6Sxnw1wEle
	 v9Y2UOyFEOOcY/Xs9QtBR/R3fae/o17hjvAfF/yhxhjKHJkbkQhJ54Fa9/2nhy8cgN
	 pr9+jf6ygE3zQ==
Date: Mon, 2 Dec 2024 21:56:59 +0530
From: Vinod Koul <vkoul@kernel.org>
To: fnkl.kernel@gmail.com
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: apple-admac: Avoid accessing registers in
 probe
Message-ID: <Z03f08Os/csGbMap@vaman>
References: <20241124-admac-power-v1-1-58f2165a4d55@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241124-admac-power-v1-1-58f2165a4d55@gmail.com>

On 24-11-24, 16:48, Sasha Finkelstein via B4 Relay wrote:
> From: Sasha Finkelstein <fnkl.kernel@gmail.com>
> 
> The ADMAC attached to the AOP has complex power sequencing, and is
> power gated when the probe callback runs. Move the register reads
> to other functions, where we can guarantee that the hardware is
> switched on.

So looking at the driver, there is code to turn power, so what ensures
that power is up while we are in alloc callback

> 
> Fixes: 568aa6dd641f ("dmaengine: apple-admac: Allocate cache SRAM to channels")
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
>  drivers/dma/apple-admac.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/apple-admac.c b/drivers/dma/apple-admac.c
> index 9588773dd2eb670a2f6115fdaef39a0e88248015..037ec38730cf980eee11ebb8ec17be7623879cf8 100644
> --- a/drivers/dma/apple-admac.c
> +++ b/drivers/dma/apple-admac.c
> @@ -153,6 +153,8 @@ static int admac_alloc_sram_carveout(struct admac_data *ad,
>  {
>  	struct admac_sram *sram;
>  	int i, ret = 0, nblocks;

Empty line before this please

> +	ad->txcache.size = readl_relaxed(ad->base + REG_TX_SRAM_SIZE);
> +	ad->rxcache.size = readl_relaxed(ad->base + REG_RX_SRAM_SIZE);
>  
>  	if (dir == DMA_MEM_TO_DEV)
>  		sram = &ad->txcache;
> @@ -912,12 +914,7 @@ static int admac_probe(struct platform_device *pdev)
>  		goto free_irq;
>  	}
>  
> -	ad->txcache.size = readl_relaxed(ad->base + REG_TX_SRAM_SIZE);
> -	ad->rxcache.size = readl_relaxed(ad->base + REG_RX_SRAM_SIZE);
> -
>  	dev_info(&pdev->dev, "Audio DMA Controller\n");
> -	dev_info(&pdev->dev, "imprint %x TX cache %u RX cache %u\n",
> -		 readl_relaxed(ad->base + REG_IMPRINT), ad->txcache.size, ad->rxcache.size);
>  
>  	return 0;
>  
> 
> ---
> base-commit: 9f16d5e6f220661f73b36a4be1b21575651d8833
> change-id: 20241124-admac-power-7f32c2a1850a
> 

-- 
~Vinod

