Return-Path: <dmaengine+bounces-7674-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C737CC4333
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 17:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00E043069143
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 16:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878BF1A9F9F;
	Tue, 16 Dec 2025 15:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEEP6BY0"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E92E3A1E96;
	Tue, 16 Dec 2025 15:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765898302; cv=none; b=YL4iudZqLmGrtbcZKfHHIsOp9oxuUPRklNTNZ71uoQtwtoUJLFmX0dhCBFYfYR8wbCz/MdDx7z90nRIkzR1ulclF+wOBQZqhN9xZLzqEUVyPxtKx0e00vzNt/4em6X+K1yuJRMAWORdUZVwLiPtBtOJmVluMvzUe0BxXXQ6M9d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765898302; c=relaxed/simple;
	bh=Rc9QWypacPW0opXZqakR+OAZltI43nP1321U9t1LsW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyz6+bMsq7a2m7ysHNnZQlcqJZQF71xYbIliyEjd5gg+I+OLGvEv4junoZ1fDZbE2uC66c9s0DkN8qH4rVagsoUaHM1dUKfegmO76qSK8VcLoCwWso31Uy4g31Ay/3GK9/t0nO9s/A4f/qz7ejt23LAitx5TwUVmsaZU1wePzJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEEP6BY0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5924BC4CEF1;
	Tue, 16 Dec 2025 15:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765898300;
	bh=Rc9QWypacPW0opXZqakR+OAZltI43nP1321U9t1LsW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jEEP6BY0usHguzaAQwBi5NkXSnXsBrko70JF7jFK7FEg/pKRRk924djRN1a7lTJDz
	 Wu98lY7g5MvzBkG8xK67S9xbn3ZmNvFa4B7PXtH/Hbgf8rjBTMwaxNz0jsAMw3Cm78
	 07Gi9aMWPMvQQ9Ep5SxHQcyoGyMvvwvActBfLHprv/q+XOxp+BcHI4CCrp2y8QEM16
	 9vs+/uZhoNJN/U7j+fF421T8R+MOUoNcJkJACAOVveqfrt9gH+Gj/B/lDKu0Gm1wVg
	 C7bLjzgEwFVwwef4C9TNrSco9U78Kt/EE9aEM49APsxn4nHRVgUa8sWbLb3+0H/gej
	 EzfLupT5t6wBw==
Date: Tue, 16 Dec 2025 20:48:17 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Robert Marko <robert.marko@sartura.hr>
Cc: ludovic.desroches@microchip.com, linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.machon@microchip.com, luka.perkov@sartura.hr,
	Tony Han <tony.han@microchip.com>
Subject: Re: [PATCH RESEND] dmaengine: at_xdmac: get the number of DMA
 channels from device tree
Message-ID: <aUF4OS4DsmRlQQt3@vaman>
References: <20251203121208.1269487-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203121208.1269487-1-robert.marko@sartura.hr>

On 03-12-25, 13:11, Robert Marko wrote:
> From: Tony Han <tony.han@microchip.com>
> 
> In case of kernel runs in non-secure mode, the number of DMA channels can
> be got from device tree since the value read from GTYPE register is "0" as
> it's always secured.
> 
> As the number of channels can never be negative, update them to the type
> "unsigned".
> 
> This is required for LAN969x.

You updated the changelog, but tagged it as resend. It should be v2!

> 
> Signed-off-by: Tony Han <tony.han@microchip.com>
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  drivers/dma/at_xdmac.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index 3fbc74710a13..acabf82e293c 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -2257,12 +2257,29 @@ static int __maybe_unused atmel_xdmac_runtime_resume(struct device *dev)
>  	return clk_enable(atxdmac->clk);
>  }
>  
> +static inline int at_xdmac_get_channel_number(struct platform_device *pdev,
> +					      u32 reg, u32 *pchannels)
> +{
> +	int	ret;
> +
> +	if (reg) {
> +		*pchannels = AT_XDMAC_NB_CH(reg);
> +		return 0;
> +	}
> +
> +	ret = of_property_read_u32(pdev->dev.of_node, "dma-channels", pchannels);
> +	if (ret)
> +		dev_err(&pdev->dev, "can't get number of channels\n");

Do we need to log error, I thought the API did that...

> +
> +	return ret;
> +}
> +
>  static int at_xdmac_probe(struct platform_device *pdev)
>  {
>  	struct at_xdmac	*atxdmac;
> -	int		irq, nr_channels, i, ret;
> +	int		irq, ret;
>  	void __iomem	*base;
> -	u32		reg;
> +	u32		nr_channels, i, reg;
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0)
> @@ -2278,7 +2295,10 @@ static int at_xdmac_probe(struct platform_device *pdev)
>  	 * of channels to do the allocation.
>  	 */
>  	reg = readl_relaxed(base + AT_XDMAC_GTYPE);
> -	nr_channels = AT_XDMAC_NB_CH(reg);
> +	ret = at_xdmac_get_channel_number(pdev, reg, &nr_channels);
> +	if (ret)
> +		return ret;
> +
>  	if (nr_channels > AT_XDMAC_MAX_CHAN) {
>  		dev_err(&pdev->dev, "invalid number of channels (%u)\n",
>  			nr_channels);
> -- 
> 2.52.0

-- 
~Vinod

