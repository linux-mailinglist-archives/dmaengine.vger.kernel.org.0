Return-Path: <dmaengine+bounces-1753-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BD789B091
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 13:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAAD11C21135
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 11:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD901CFAF;
	Sun,  7 Apr 2024 11:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrFuU9bA"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91344C74;
	Sun,  7 Apr 2024 11:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712488844; cv=none; b=NxkrNnyfwlwDeQKT0sDWzZDGZR94ERb2bB9jW8nAEcBEVYO85BRF1BM69hatm5L3Nh+sHI8lL16DHGlz2s0mBnkASeSEXiRUGpcWsYb9+iLU6IMGau18GX07OscMN1S90qjvu7wfwAb6+uhxW1C+6v4krkbid5NPOMuLCVJEJlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712488844; c=relaxed/simple;
	bh=B8qP/5qR0tCYxniedXWZSEKIbjIGnreM1D7dmEkoxQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2icW3QknwJWWldfXuCkwGJljRwuXtfAxudiu0ecsIEF9Kp4/w29CAUd1v1NB87I5zObCxD6l9NODbQnrUMxMHug0eplu3j0yRV0/0lMzvrE91UkkpUZrtTY+R9BLAKL5VKoMa+p4JrvR9W/if4R5htN/cEQuU2fpN1+G8PkjGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrFuU9bA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E0EC433F1;
	Sun,  7 Apr 2024 11:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712488843;
	bh=B8qP/5qR0tCYxniedXWZSEKIbjIGnreM1D7dmEkoxQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RrFuU9bA/ly7QQL6Z4zjQ76Q+behnyXwOKFXBlJhtL9erAnOO73B8Dsn7krUtdb4K
	 URCYy2SPBMfkwDZdJRrQxcArmZBQC1qxNE785MUIYYadRPcd/Z208VE7+9Ks2qi3bG
	 Bgb6hrx6VkYFNDTgpqJLltJIBMkQFT3amheMrboIfu8BgXiyoZnpxfnvborIYJYFAk
	 LZ8VzMiMKmUZSchC3pAw9DsjyNa4nuLtrecUfzBzXWPdr1DVGVxAHSxZxCHDcq4RG/
	 5n0KGumriCC8m6O1MH9scj3Q5MfSzY3pUhK9xkr4Gu8Z6t4TghdTaBxNTpzLD53vS4
	 sxsQDiby4psWw==
Date: Sun, 7 Apr 2024 16:50:38 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, Robin Gong <yibin.gong@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH v4 5/5] dmaengine: imx-sdma: Add i2c dma support
Message-ID: <ZhKBhqCv22D1VewL@matsya>
References: <20240329-sdma_upstream-v4-0-daeb3067dea7@nxp.com>
 <20240329-sdma_upstream-v4-5-daeb3067dea7@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329-sdma_upstream-v4-5-daeb3067dea7@nxp.com>

On 29-03-24, 10:34, Frank Li wrote:
> From: Robin Gong <yibin.gong@nxp.com>
> 
> New sdma script (sdma-6q: v3.6, sdma-7d: v4.6) support i2c at imx8mp and
> imx6ull. So add I2C dma support.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> Acked-by: Clark Wang <xiaoning.wang@nxp.com>
> Reviewed-by: Joy Zou <joy.zou@nxp.com>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/dma/imx-sdma.c      | 7 +++++++
>  include/linux/dma/imx-dma.h | 1 +
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index f68ab34a3c880..1ab8a7d3a50dc 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -251,6 +251,8 @@ struct sdma_script_start_addrs {
>  	s32 sai_2_mcu_addr;
>  	s32 uart_2_mcu_rom_addr;
>  	s32 uartsh_2_mcu_rom_addr;
> +	s32 i2c_2_mcu_addr;
> +	s32 mcu_2_i2c_addr;
>  	/* End of v3 array */
>  	s32 mcu_2_zqspi_addr;
>  	/* End of v4 array */
> @@ -1081,6 +1083,11 @@ static int sdma_get_pc(struct sdma_channel *sdmac,
>  		per_2_emi = sdma->script_addrs->sai_2_mcu_addr;
>  		emi_2_per = sdma->script_addrs->mcu_2_sai_addr;
>  		break;
> +	case IMX_DMATYPE_I2C:
> +		per_2_emi = sdma->script_addrs->i2c_2_mcu_addr;
> +		emi_2_per = sdma->script_addrs->mcu_2_i2c_addr;
> +		sdmac->is_ram_script = true;
> +		break;
>  	case IMX_DMATYPE_HDMI:
>  		emi_2_per = sdma->script_addrs->hdmi_dma_addr;
>  		sdmac->is_ram_script = true;
> diff --git a/include/linux/dma/imx-dma.h b/include/linux/dma/imx-dma.h
> index cfec5f946e237..76a8de9ae1517 100644
> --- a/include/linux/dma/imx-dma.h
> +++ b/include/linux/dma/imx-dma.h
> @@ -41,6 +41,7 @@ enum sdma_peripheral_type {
>  	IMX_DMATYPE_SAI,	/* SAI */
>  	IMX_DMATYPE_MULTI_SAI,	/* MULTI FIFOs For Audio */
>  	IMX_DMATYPE_HDMI,       /* HDMI Audio */
> +	IMX_DMATYPE_I2C,	/* I2C */

I have HDMI Audio: 26 already?

-- 
~Vinod

