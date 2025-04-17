Return-Path: <dmaengine+bounces-4907-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F68A914EA
	for <lists+dmaengine@lfdr.de>; Thu, 17 Apr 2025 09:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB3B217C245
	for <lists+dmaengine@lfdr.de>; Thu, 17 Apr 2025 07:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C2C21ADA2;
	Thu, 17 Apr 2025 07:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOxPi/dQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2E121ABCA
	for <dmaengine@vger.kernel.org>; Thu, 17 Apr 2025 07:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744874331; cv=none; b=fYmqLyhYN3/PYVjaBtu8hEtD5cyqiGq2bUEAoitIwRYiTOnVo8MG2a7d/UqLfwsqNg37z/+sWMxvb3+Czddas+7g/Kx0NEXEhTs67F7rirNN6vi1t6183vnCpyJ3Nbuxotir96NH8QOxzXUiRSKBluA7u1q15QaiUe2uzHcPs6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744874331; c=relaxed/simple;
	bh=aJKMOYjG1BrtOdW9pAiHboevORr6+Q5bAJAsjwPlj8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chqR14eX87biJKZi5T7rXl7KjWAhb+YG1rZI4Fha2+j8f/uqc53V/OWX6ucB2W7+mq4lTVVL56ZfPzFhaqhCX5ga9fEF6m83Htsk+C0f5W4jx0OvSd0c048+SwQfSzwOkkG0n6IaRjuUCq4pzqlGEOw82ZeudjxZzFi2t0eLXnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOxPi/dQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96352C4CEE7;
	Thu, 17 Apr 2025 07:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744874331;
	bh=aJKMOYjG1BrtOdW9pAiHboevORr6+Q5bAJAsjwPlj8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vOxPi/dQyHdrJQexs8Dyc9kX4mTHN8uxsB6kok5JZK8dL6PmjHhKG6LcdthBOrWV9
	 KhNMPH2HDaA3ecA+boWb/mxJnCWhiz1BZ4UyVt4DdP6kGWhGom6t5BcGSl7m0/oz8q
	 2HfGxKa/lb6rS1r5Q5AzROmBpGQ7wLqqzrloYTCC3FqW+S0usXg5qf9QZGH4ROygXz
	 vmrxgwSiQooFqR2U+3JhsYAqOOBYfdqBC+HvIBAQUNRL9k+p+xlZ+8cDBv6/HQukk1
	 GA9sYvU/+Z3wTifZNh46W2iBW8mo0MioIbzVq21x/WcuIzXZqKuyn9LYvE1XUG/HvZ
	 V3VojM8Ru5p+A==
Date: Thu, 17 Apr 2025 12:48:47 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: dmaengine@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH -next] dmaengine: ptdma: Fix static checker warnings
Message-ID: <aACrV/Qwesp1lcJk@vaman>
References: <20250312121044.3638028-1-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312121044.3638028-1-Basavaraj.Natikar@amd.com>

Hi,

On 12-03-25, 17:40, Basavaraj Natikar wrote:

Patch title should mention the changes and not cause, please revise
title

> An unnecessary extra check leads to the following static code checker
> warning:
> 
>     drivers/dma/amd/ptdma/ptdma-dmaengine.c: pt_cmd_callback_work()
>     warn: variable dereferenced before check 'desc'

Describe the fix please

> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/bfa0a979-ce9f-422d-92c3-34921155d048@stanley.mountain/
> Fixes: 656543989457 ("dmaengine: ptdma: Utilize the AE4DMA engine's multi-queue functionality")
> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> ---
>  drivers/dma/amd/ptdma/ptdma-dmaengine.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> index 715ac3ae067b..d1d38ed811c2 100644
> --- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> +++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> @@ -355,16 +355,14 @@ static void pt_cmd_callback_work(void *data, int err)
>  		desc->status = DMA_ERROR;
>  
>  	spin_lock_irqsave(&chan->vc.lock, flags);
> -	if (desc) {
> -		if (desc->status != DMA_COMPLETE) {
> -			if (desc->status != DMA_ERROR)
> -				desc->status = DMA_COMPLETE;
> +	if (desc->status != DMA_COMPLETE) {
> +		if (desc->status != DMA_ERROR)
> +			desc->status = DMA_COMPLETE;
>  
> -			dma_cookie_complete(tx_desc);
> -			dma_descriptor_unmap(tx_desc);
> -		} else {
> -			tx_desc = NULL;
> -		}
> +		dma_cookie_complete(tx_desc);
> +		dma_descriptor_unmap(tx_desc);
> +	} else {
> +		tx_desc = NULL;
>  	}
>  	spin_unlock_irqrestore(&chan->vc.lock, flags);
>  
> -- 
> 2.34.1

-- 
~Vinod

