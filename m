Return-Path: <dmaengine+bounces-440-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F7880C89C
	for <lists+dmaengine@lfdr.de>; Mon, 11 Dec 2023 12:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CC98B20DA5
	for <lists+dmaengine@lfdr.de>; Mon, 11 Dec 2023 11:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68F838DDD;
	Mon, 11 Dec 2023 11:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJCFuiwC"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A987738DD4
	for <dmaengine@vger.kernel.org>; Mon, 11 Dec 2023 11:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360A5C433C8;
	Mon, 11 Dec 2023 11:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702295849;
	bh=f7zaWwRmNF7dE+t0wkFnZGPtHDh8NCiV/vSatviei50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iJCFuiwCrgd/gJPq0nQBruKCePHfDzR5dGgp2MEcGBnmLCO7wjWQNGthFNuvx1gv0
	 HUJRiYO+ovvN5g8zsr6LEfl5U6P2WFdlXDE5wqKSjl8rkpyAxHiNFgiVRxeLFncil4
	 DzF4lJOJwc/HcW3vmxzkv7HQEUhz6wBP0VbOLuxjoXmY8Rua/ejtiSOEaPzIKlzbMx
	 zjNTQYqPn3HhXem6Mv/FfimjAHoxVJppHZAOhCVpvd4YW5GvWza2rjsgN04B1MPcuw
	 YeBCT/rNvxq9WEK+36Qhf06h9bHtJdsRuHt2HxgMt4MDT6iblhxHVPWxEz8N/1Q88k
	 AGhcerK4ZwGgg==
Date: Mon, 11 Dec 2023 17:27:22 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dmaengine: axi-dmac: Small code cleanup
Message-ID: <ZXb5IhaNiKJufH/k@matsya>
References: <20231204140352.30420-1-paul@crapouillou.net>
 <20231204140352.30420-2-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204140352.30420-2-paul@crapouillou.net>

On 04-12-23, 15:03, Paul Cercueil wrote:
> Use a for() loop instead of a while() loop in axi_dmac_fill_linear_sg().

Why?

> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/dma/dma-axi-dmac.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> index 2457a420c13d..760940b21eab 100644
> --- a/drivers/dma/dma-axi-dmac.c
> +++ b/drivers/dma/dma-axi-dmac.c
> @@ -508,16 +508,13 @@ static struct axi_dmac_sg *axi_dmac_fill_linear_sg(struct axi_dmac_chan *chan,
>  	segment_size = ((segment_size - 1) | chan->length_align_mask) + 1;
>  
>  	for (i = 0; i < num_periods; i++) {
> -		len = period_len;
> -
> -		while (len > segment_size) {
> +		for (len = period_len; len > segment_size; sg++) {
>  			if (direction == DMA_DEV_TO_MEM)
>  				sg->dest_addr = addr;
>  			else
>  				sg->src_addr = addr;
>  			sg->x_len = segment_size;
>  			sg->y_len = 1;
> -			sg++;
>  			addr += segment_size;
>  			len -= segment_size;
>  		}
> -- 
> 2.42.0
> 

-- 
~Vinod

