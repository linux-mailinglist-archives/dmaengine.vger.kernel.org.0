Return-Path: <dmaengine+bounces-5543-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B27A8AE14A6
	for <lists+dmaengine@lfdr.de>; Fri, 20 Jun 2025 09:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 715113B8513
	for <lists+dmaengine@lfdr.de>; Fri, 20 Jun 2025 07:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D9E220F53;
	Fri, 20 Jun 2025 07:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQxUOoag"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699F81E9B0D;
	Fri, 20 Jun 2025 07:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750403737; cv=none; b=hkmHzUF6vt2hKP8IaxEgoPj+1jZ13kc8vH9RrDqQGMbYi6LVrUoTRWeMKK9EngTLUraetVAWMwShe73ovJlzFsSaXPHNj4/mftVLZiaNfxYif/XXNTop8tq5vVss7/f+dhf3N4fsXlNM7yx3qEhwylH5wWrvV1J+c0UfiMwe3Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750403737; c=relaxed/simple;
	bh=v3mtiZeGxwoM0Zn8x7gunb1hV1Q+FzEs5OHsTLW9vlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8qu6vfQgLXZYplBd5IZ6Fr4zbXQvyX1u91DlxTmGpL/DKHxxTvRGi4H36CpPotccrQzc5J4gLMsNL6sIDIYn+3j8dgN8jCVQs5d1j41Bm/BO2xasgODI/tAQ3pjdZ4sMWSytN4oZUxUE2gKEMDbAV1Db2zJn1xd/GuMxraR/4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQxUOoag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D85C4CEE3;
	Fri, 20 Jun 2025 07:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750403737;
	bh=v3mtiZeGxwoM0Zn8x7gunb1hV1Q+FzEs5OHsTLW9vlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KQxUOoagr+qLKJ/vTC2ET012o/PR8g0pgyrEtL5AzxiQqBM2Um5UST9LZ2C/P0bml
	 V8sMsRAEdLH+czGVL7hPaOCN+r5vhS/qifEs7e2bjr5fVHE/WsrQP3mReaswIUiyZf
	 OlKxUiC7luSQj1fM7V+mlyhNAkDdVEqo8PNXTKOFNLxm4thgjqyI2kW6fCtaaUhKFn
	 ptlFWlP3VjsPLi0Tna8bh4zcgJYtoLG2Pv4PiW5N0jZEJDeHwM4AvRrojqrdpyT9AJ
	 3rXKx+7pvVgza0T/V43jnsIl89vQWSzcz0InCr99OI2kuykXffC0ztlOHXdQJ+RyFl
	 +XtN2vY0+amCw==
Date: Fri, 20 Jun 2025 12:45:32 +0530
From: Vinod Koul <vkoul@kernel.org>
To: adrianhoyin.ng@altera.com
Cc: dinguyen@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Eugeniy.Paltsev@synopsys.com,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	Matthew Gerlach <matthew.gerlach@altrera.com>
Subject: Re: [PATCH v3 4/4] dma: dw-axi-dmac: Add support for dma-bit-mask
 property
Message-ID: <aFUKlJchclJSZgib@vaman>
References: <cover.1750084527.git.adrianhoyin.ng@altera.com>
 <d28a649938adec18bb0a550b28ed86b4c711cfc1.1750084527.git.adrianhoyin.ng@altera.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d28a649938adec18bb0a550b28ed86b4c711cfc1.1750084527.git.adrianhoyin.ng@altera.com>

On 16-06-25, 22:40, adrianhoyin.ng@altera.com wrote:
> From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

Please change subsystem tag to dmanegine: xxx

> 
> Intel Agilex5 address bus only supports up to 40 bits. Add dma-bit-mask
> property support where configure dma-bit-mask based on dma-bit-mask
> property or fallback to default value if property is not present.
> 
> Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@altrera.com>
> 
> v3:
> -update to read from updated property name.
> 
> v2:
> -Fix build errors and warning
> ---
>  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index b23536645ff7..e56ff7aadafd 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -265,13 +265,23 @@ static inline bool axi_chan_is_hw_enable(struct axi_dma_chan *chan)
>  static void axi_dma_hw_init(struct axi_dma_chip *chip)
>  {
>  	int ret;
> -	u32 i;
> +	u32 i, tmp;
>  
>  	for (i = 0; i < chip->dw->hdata->nr_channels; i++) {
>  		axi_chan_irq_disable(&chip->dw->chan[i], DWAXIDMAC_IRQ_ALL);
>  		axi_chan_disable(&chip->dw->chan[i]);
>  	}
> -	ret = dma_set_mask_and_coherent(chip->dev, DMA_BIT_MASK(64));
> +
> +	ret = device_property_read_u32(chip->dev, "snps,dma-addressable-bits", &tmp);
> +	if (ret)
> +		ret = dma_set_mask_and_coherent(chip->dev, DMA_BIT_MASK(64));
> +	else {
> +		if (tmp == 0 || tmp < 32 || tmp > 64)
> +			dev_err(chip->dev, "Invalid dma bit mask\n");
> +
> +		ret = dma_set_mask_and_coherent(chip->dev, DMA_BIT_MASK(tmp));

why not check the mask value and set that only once irrespective of
mask, it can tmp or 64!

-- 
~Vinod

