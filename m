Return-Path: <dmaengine+bounces-1026-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE1F857C7E
	for <lists+dmaengine@lfdr.de>; Fri, 16 Feb 2024 13:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 939CC284313
	for <lists+dmaengine@lfdr.de>; Fri, 16 Feb 2024 12:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BA378B46;
	Fri, 16 Feb 2024 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6mj12HS"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EB52CCB4;
	Fri, 16 Feb 2024 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708086337; cv=none; b=QL98/3D+A6PneaIDEUBsz6nvRZWatMkIB47ld+k9dorDOQ91L9z2KLxzJ5Ih76U89U83LVsKdaZ1u8AGiMmu+6g9Y6WEhRgjkkTHbMJ/DkwhaPPIEI1Z8e++LW+J2soBcEch3/RCJk6pRed+NopSmM95iHAuajdsbYoHzuQrPR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708086337; c=relaxed/simple;
	bh=FmIAU+IEpWQlILJ7GmQtfeN0vLzjtFFadNyFsSy4thI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bV9epvPDeDgg4qMYB5eza8SZ1RnV1mp1KMSI5Crm51TPXfHV79FRMk3A+k/2A9v99zrRpp/QYiZmC0ScCku9Kj5wtCvEJ0H7EQ/ImlFbB6xje6boqI+eI+tegCeH2ClOxTSH/qPpqbMLEt8SQ82WIjVDs85mq5oDjyjVdw0Umpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6mj12HS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9052C433F1;
	Fri, 16 Feb 2024 12:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708086337;
	bh=FmIAU+IEpWQlILJ7GmQtfeN0vLzjtFFadNyFsSy4thI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g6mj12HSS2FEGCSTrLtBKrHBu/KfczPhjFNJay3ffOG12k4p7wq423tAza6grV4Qr
	 Dz8JwARSGmwS5Cf3J1Qqb9M7VmBCSEIESeldNRx4pSIiL+rDTgzKP9avMfaHtLtwkz
	 gZQGrtHmeSX7uLJkmuAVSty6wAZXqe05aKb1eiukK1iryD8otgiojZjsH9XbSvBHRF
	 YPAS7Q9WdToIzc5mNeCFaXI9ECHfMcwHfw5WH2v93jhkZbiVqkoEEEyFcELrkwzyJg
	 HNxYzLchGZOmpMca7NfZIIj3PEfatLNeW9konTCz8ECGbnLTrrpD4q6jDMlOnoVkvQ
	 D0nXWL8y4j83w==
Date: Fri, 16 Feb 2024 17:55:33 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: linux-tegra@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Sameer Pujar <spujar@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH 2/2] dmaengine: tegra210-adma: Update dependency to
 ARCH_TEGRA
Message-ID: <Zc9UPX3W6zMubgOV@matsya>
References: <20240216100246.568473-1-pbrobinson@gmail.com>
 <20240216100246.568473-2-pbrobinson@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216100246.568473-2-pbrobinson@gmail.com>

On 16-02-24, 10:02, Peter Robinson wrote:
> Update the architecture dependency to be the generic Tegra
> because the driver works on the four latest Tegra generations
> not just Tegra210, if you build a kernel with a specific
> ARCH_TEGRA_xxx_SOC option that excludes Tegra210 you don't get
> this driver.

??

This is already in linux-next, see 33b7db45533af240fe44e809f9dc4d604cf82d07

> 
> Fixes: 433de642a76c9 ("dmaengine: tegra210-adma: add support for Tegra186/Tegra194")
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> Cc: Jon Hunter <jonathanh@nvidia.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Sameer Pujar <spujar@nvidia.com>
> Cc: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> ---
> 
> v2: fix spelling of option
> v3: Update T210 -> Tegra210
>     use "and later" rather than all current devices
> 
>  drivers/dma/Kconfig | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index e928f2ca0f1e9..ae23b886a6c60 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -643,16 +643,16 @@ config TEGRA20_APB_DMA
>  
>  config TEGRA210_ADMA
>  	tristate "NVIDIA Tegra210 ADMA support"
> -	depends on (ARCH_TEGRA_210_SOC || COMPILE_TEST)
> +	depends on (ARCH_TEGRA || COMPILE_TEST)
>  	select DMA_ENGINE
>  	select DMA_VIRTUAL_CHANNELS
>  	help
> -	  Support for the NVIDIA Tegra210 ADMA controller driver. The
> -	  DMA controller has multiple DMA channels and is used to service
> -	  various audio clients in the Tegra210 audio processing engine
> -	  (APE). This DMA controller transfers data from memory to
> -	  peripheral and vice versa. It does not support memory to
> -	  memory data transfer.
> +	  Support for the NVIDIA Tegra210 and later ADMA
> +	  controller driver. The DMA controller has multiple DMA channels
> +	  and is used to service various audio clients in the Tegra210
> +	  audio processing engine (APE). This DMA controller transfers
> +	  data from memory to peripheral and vice versa. It does not
> +	  support memory to memory data transfer.
>  
>  config TIMB_DMA
>  	tristate "Timberdale FPGA DMA support"
> -- 
> 2.43.1

-- 
~Vinod

