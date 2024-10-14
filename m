Return-Path: <dmaengine+bounces-3342-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E6B99D63E
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2024 20:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21EDD1C2144E
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2024 18:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9181AC8AE;
	Mon, 14 Oct 2024 18:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPcYicls"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18CE1AA79A;
	Mon, 14 Oct 2024 18:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728929792; cv=none; b=nPSB5jUjAF7cuDiqLtYBoS/aXIqTtHZGJD+KwzsVw9mREtnmMx5/U5TfdqqBgV14Wkgba2VErhUCJS0FKQ5PlEx8ev7aE0RNY4a5wo91F/nKaAlltBVPRkMal617DZqibAD3owzdPoBezQMKCA9fXicxx2vYrreZ0xZG44OQMAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728929792; c=relaxed/simple;
	bh=or/9n08L+r2SABq92t68DUSRRGWy7/LVH1rEDc0EUWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yz8SaGkhsKJPmp2WDMlJrK4+B/b/CzrAaeRHveDgTJwLfoUD3RdDr8VuKqPVAgns+2ZWR55xkItln1HLQWJIgo/545zMtItJ7D2Jm64o15IR4wVL7YiFPX6dHXrc3wCQnBMYUnowBRmlft62B36yF3Y7BVu/LczTPACHAeL2xXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPcYicls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB251C4CEC3;
	Mon, 14 Oct 2024 18:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728929792;
	bh=or/9n08L+r2SABq92t68DUSRRGWy7/LVH1rEDc0EUWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gPcYicls39vMcuFBiXJL6KRWsMx7FtrVHF41K9xQ/H/8bDe2ikLmvVpb158lvyySi
	 C6fM528gm3lcYB8+1tpko9Nn1gs0U5wCbMfuS5wUx24Ubpmhvm4rhqVmCM4BSQZnKG
	 sAWn9c36rQ3H/ZFXh5IYTMouykwZF2KsAGhObcUuc2Vk1WEJ9e2M52FNrhZcOhA1cn
	 o+YgulxJozGPOiXsUtfud5pY1wo+WtMNGbElgjDDndUJG2S8s1N0Uun2lkcHiVtjqb
	 L8VJAvWlx/qdefDgo2nuCaRNYGq4G3M8ftira90XnBQUJH9+X61S8x88luFVyugZPZ
	 7y1bevdj5IZow==
Date: Mon, 14 Oct 2024 23:46:28 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Advait Dhamorikar <advaitdhamorikar@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, anupnewsmail@gmail.com
Subject: Re: [PATCH] drivers/dma: Fix unsigned compared against 0
Message-ID: <Zw1f/OviOSJ9eqJE@vaman>
References: <20241005093436.27728-1-advaitdhamorikar@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241005093436.27728-1-advaitdhamorikar@gmail.com>

On 05-10-24, 15:04, Advait Dhamorikar wrote:
> An unsigned value can never be negative,
> so this test will always evaluate the same way.
> In ep93xx_dma_alloc_chan_resources: An unsigned dma_cfg.port's
> value is checked against EP93XX_DMA_I2S1 which is 0.

Please use subject line dmaengine: ... git log will tell you the tags to
use

I am fixing it up and applying

> 
> Signed-off-by: Advait Dhamorikar <advaitdhamorikar@gmail.com>
> ---
>  drivers/dma/ep93xx_dma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
> index 995427afe077..6d7f6bd12d76 100644
> --- a/drivers/dma/ep93xx_dma.c
> +++ b/drivers/dma/ep93xx_dma.c
> @@ -929,8 +929,7 @@ static int ep93xx_dma_alloc_chan_resources(struct dma_chan *chan)
>  
>  	/* Sanity check the channel parameters */
>  	if (!edmac->edma->m2m) {
> -		if (edmac->dma_cfg.port < EP93XX_DMA_I2S1 ||
> -		    edmac->dma_cfg.port > EP93XX_DMA_IRDA)
> +		if (edmac->dma_cfg.port > EP93XX_DMA_IRDA)
>  			return -EINVAL;
>  		if (edmac->dma_cfg.dir != ep93xx_dma_chan_direction(chan))
>  			return -EINVAL;
> -- 
> 2.34.1

-- 
~Vinod

