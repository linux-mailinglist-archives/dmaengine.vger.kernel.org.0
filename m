Return-Path: <dmaengine+bounces-4377-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0998A2EA80
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 12:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D843D164732
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 11:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B711E32CD;
	Mon, 10 Feb 2025 11:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFi9RzOL"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7561DFE0A;
	Mon, 10 Feb 2025 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739185341; cv=none; b=LbV7u3Zv+bg7ROKw+JsRFoIJKP4Cm5ClglK+0CT9I0CTqP2ggg1YbglcLB8YDWgqBPjKgn9J+GEQiZBcox5LHudrPouiougQxIFeJSMfDbpIq/OYGenZaed8LqVVVPhHPJyNfiit+9QhK5pDhmGx+FyAFbhymDsKdMU0auMRWsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739185341; c=relaxed/simple;
	bh=+bQSTsB4Vv/HxWV6R2rogqlCT+gRGmi76Ize4bLvKOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dq45tyHmK+7RstHfyoaQ7qjYvSj7hHkPb5oAa54oZWYfinkiYX7Yu2u2Ykd7eTX2KKXgqkVJ9ydy6F6A1bbxyBnZXwf1ORmKOosm6tXthritZly4FBsc+cRQPRqV6uJxsyyNOlFKQ6JmBv0sFwaeJgKU89GjKQ9oxHNH0P2nZl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFi9RzOL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1768C4CED1;
	Mon, 10 Feb 2025 11:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739185340;
	bh=+bQSTsB4Vv/HxWV6R2rogqlCT+gRGmi76Ize4bLvKOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NFi9RzOL1k+ov+pc74A7K5ye6mCYgMOvRO8KUzA6AkGEMjzA9wG90kVDi/DfMWNdO
	 gQnsEv6rir1+/d9fl7HS04QqUN4coTk7t6aQMqWInRzJLB8yC6JHfXAhSanHHotMm8
	 kDSdJd5wfz5PRBaAmWaUOXyUaQeL2sUq2ZWunma8XlYFdl2xoVVATSiHALipP8CT7Y
	 JJ5AI7Sgk9IecQfVKi/LO4r5oArqXnj1ypTUBp2JG1SyqN6jOC3NPENe/sbK5ZBaLa
	 yCsb4PqMvUztQFfbhBZxONxMD9GQ5AMHU5wVaIoUG1m0YmQ39MJre4+XPgpllvihTR
	 0r2zZU+mrsXGA==
Date: Mon, 10 Feb 2025 16:32:16 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Mohan Kumar D <mkumard@nvidia.com>
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com,
	dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4 1/2] dmaengine: tegra210-adma: Fix build error due to
 64-by-32 division
Message-ID: <Z6ncuLHotCAw61b5@vaman>
References: <20250205033131.3920801-1-mkumard@nvidia.com>
 <20250205033131.3920801-2-mkumard@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205033131.3920801-2-mkumard@nvidia.com>

Hi Mohan,

On 05-02-25, 09:01, Mohan Kumar D wrote:
> Kernel test robot reported the build errors on 32-bit platforms due to
> plain 64-by-32 division. Following build erros were reported.

Patch should describe the change! Please revise subject to describe that
and not fix build error... This can come in changelog and below para is
apt

> 
>    "ERROR: modpost: "__udivdi3" [drivers/dma/tegra210-adma.ko] undefined!
>     ld: drivers/dma/tegra210-adma.o: in function `tegra_adma_probe':
>     tegra210-adma.c:(.text+0x12cf): undefined reference to `__udivdi3'"
> 
> This can be fixed by using div_u64() for the adma address space
> 
> Fixes: 68811c928f88 ("dmaengine: tegra210-adma: Support channel page")
> Cc: stable@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202412250204.GCQhdKe3-lkp@intel.com/
> Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
> ---
>  drivers/dma/tegra210-adma.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index 6896da8ac7ef..a0bd4822ed80 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -887,7 +887,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
>  	const struct tegra_adma_chip_data *cdata;
>  	struct tegra_adma *tdma;
>  	struct resource *res_page, *res_base;
> -	int ret, i, page_no;
> +	u64 page_no, page_offset;
> +	int ret, i;
>  
>  	cdata = of_device_get_match_data(&pdev->dev);
>  	if (!cdata) {
> @@ -914,10 +915,16 @@ static int tegra_adma_probe(struct platform_device *pdev)
>  
>  		res_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "global");
>  		if (res_base) {
> -			page_no = (res_page->start - res_base->start) / cdata->ch_base_offset;
> -			if (page_no <= 0)
> +			if (WARN_ON(res_page->start <= res_base->start))
>  				return -EINVAL;
> -			tdma->ch_page_no = page_no - 1;
> +
> +			page_offset = res_page->start - res_base->start;
> +			page_no = div_u64(page_offset, cdata->ch_base_offset);
> +
> +			if (WARN_ON(page_no == 0))
> +				return -EINVAL;
> +
> +			tdma->ch_page_no = lower_32_bits(page_no) - 1;
>  			tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
>  			if (IS_ERR(tdma->base_addr))
>  				return PTR_ERR(tdma->base_addr);
> -- 
> 2.25.1

-- 
~Vinod

