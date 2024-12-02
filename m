Return-Path: <dmaengine+bounces-3852-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3469E091F
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 17:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70A97164256
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 16:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0AE1B6D0A;
	Mon,  2 Dec 2024 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGGQsHoE"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638B66FC3
	for <dmaengine@vger.kernel.org>; Mon,  2 Dec 2024 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733157786; cv=none; b=YukGiOi/CkpAD4mZlGmquuSMVhHg5mnIwF/oHTqbUxCRrE8ZeZcqyKRyHRl5xXs2Z2CQ5cY8RxiX1Kh70c8ePBwWh4zME1VTa+yYYLqtc7rnigHDqcIy2X3YExVo4V5YIrhMJ1O7nca9KEcZeFWJ9zxDn60RqI/pFoNl54fB8zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733157786; c=relaxed/simple;
	bh=PSBmCq5pmS5kmYAqcdxhLpaB+jhw+KU6vu5dU/m4jh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7kY3QjS/MIJhIHyyMA6Km/rzJ9cYbYKvjU9SaLB81wp6Fr5G+GqxN+18FMFMgk4syc47VsTQZHLkNfSKl6kTT2WOaP+gn/ebKJwNHmknmA4Cc+DkFtqinhwgsET28ubEZUYtzRySJ+CGgFfFv/1iMcGuuerKtVPtNOB17eoUV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGGQsHoE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C026C4CED1;
	Mon,  2 Dec 2024 16:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733157786;
	bh=PSBmCq5pmS5kmYAqcdxhLpaB+jhw+KU6vu5dU/m4jh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VGGQsHoEc5ThE1dOxsXy4fdtqdEFJdto/mhxyX04MnqAu7fblOKLM83kCNHrNkuXY
	 V549WkoMo9p/hRONSpB8VI5Luva42hgjagZq9Z4DsMlNpS676IJWYtulPtYmVXusW8
	 viJyeJBqD76C76YAm/yhJh2PZ3YUFkW/6vbPXyOo9NXchrt8NwdQkZlSk2vr2WaJwP
	 pusahJ/OOjEZA8x3ITKQ7NRAdVfdZp/1IZKgKAqibi0IKUAGJDu7bfp/GXSNiWmi4m
	 xG/SCEzxoHkgqyNSpv/KG2w4LgdN8dB0YekCzSyEEpV9VgWkgm5F+HdwJ35RCr+pLk
	 aF7qZb0w4NUOQ==
Date: Mon, 2 Dec 2024 22:13:01 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Charles Han <hanchunchao@inspur.com>
Cc: peter.ujfalusi@gmail.com, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Add NULL check in udma_probe
Message-ID: <Z03jlQBuYt9iOLj+@vaman>
References: <20241115060336.3610-1-hanchunchao@inspur.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115060336.3610-1-hanchunchao@inspur.com>

On 15-11-24, 14:03, Charles Han wrote:
> devm_kasprintf() can return a NULL pointer on failure,but this
> returned value udma_probe() is not checked.
> Add NULL check in udma_probe(), to handle kernel NULL
> pointer dereference error.
> 
> Fixes: 25dcb5dd7b7c ("dmaengine: ti: New driver for K3 UDMA")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>  drivers/dma/ti/k3-udma.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index b3f27b3f9209..e940753a8ab1 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -5566,6 +5566,8 @@ static int udma_probe(struct platform_device *pdev)
>  		uc->config.dir = DMA_MEM_TO_MEM;
>  		uc->name = devm_kasprintf(dev, GFP_KERNEL, "%s chan%d",
>  					  dev_name(dev), i);
> +		if (!uc->name)
> +			return -ENOMEM;

what is the condition when this can occur?

>  
>  		vchan_init(&uc->vc, &ud->ddev);
>  		/* Use custom vchan completion handling */
> -- 
> 2.31.1

-- 
~Vinod

