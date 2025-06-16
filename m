Return-Path: <dmaengine+bounces-5496-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31628ADB535
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 17:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 273957A2379
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 15:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EBA21B9E1;
	Mon, 16 Jun 2025 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="AKLj9123";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="AKLj9123"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642F81C5D7D;
	Mon, 16 Jun 2025 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750087443; cv=none; b=DkmIgkOmEiWfa6FyYWBzSd4eDZUC7feTgIaxFWJ3COCVXRsUO6415UZpVl/6qjQ8k2NaRgVo4ppVGlgUY+7fDK+ZVe2SVNsGazyPfiNNMD/Atc6GWy9O1o9Ry7dvCNIK9bHJkaQ6FQpVbWh7VGq88V2OjwOW/dTcS6tAXf3QlwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750087443; c=relaxed/simple;
	bh=L36apx6YOkPsOESPZl+PN5JV6EhSIQk7MGDOTD2LIn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o44rU3cAKBlWuMz79s9ZTpiK9Q9Ld4hnW3ZC+tCGV2V8FdmjNjQvgF1yz+ETunMmuw1vKkInqeP6eMJ5c2UUYJ65ayH3Bz6Nir+58eqbsNoH1slxLIWLBUH+KBpSbnAjj/F6FsWfZnVFvfJ6TFBFc4/tByVlDeECQADmkUiFhAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=AKLj9123; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=AKLj9123; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1750087439; bh=L36apx6YOkPsOESPZl+PN5JV6EhSIQk7MGDOTD2LIn0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AKLj9123NMxLszeoYR6I6PlazpsTSs7ZuytuhKzTYO9PmXqJ8qPY5w9foRHVqdyg9
	 rc/zvKVsGus8EPwITYAuMrq/3S08T7A2Ly27QJhEzOXyUYGfI8LrhMPdaVH2w+T1FN
	 fqvCybkYPZHEJvkP2nUNdQ9ktqDBoCmhZeyW7OjfEpC0QNpLYohTlvIF103EiGDirP
	 r6agla+tn0FhwKJPIl6BU2kuqkapWiVVCzGdJWguj+QOEvgYOeAreIqqnxiZmOyiRQ
	 lasGynJtjeDMMbENbqtKmdY8t/v84iwdtBXtH4AgpbWy9zUwkM4CeU3TWQuY72Ordw
	 wXpoURDNrRPqw==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 76B103C2957;
	Mon, 16 Jun 2025 15:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1750087439; bh=L36apx6YOkPsOESPZl+PN5JV6EhSIQk7MGDOTD2LIn0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AKLj9123NMxLszeoYR6I6PlazpsTSs7ZuytuhKzTYO9PmXqJ8qPY5w9foRHVqdyg9
	 rc/zvKVsGus8EPwITYAuMrq/3S08T7A2Ly27QJhEzOXyUYGfI8LrhMPdaVH2w+T1FN
	 fqvCybkYPZHEJvkP2nUNdQ9ktqDBoCmhZeyW7OjfEpC0QNpLYohTlvIF103EiGDirP
	 r6agla+tn0FhwKJPIl6BU2kuqkapWiVVCzGdJWguj+QOEvgYOeAreIqqnxiZmOyiRQ
	 lasGynJtjeDMMbENbqtKmdY8t/v84iwdtBXtH4AgpbWy9zUwkM4CeU3TWQuY72Ordw
	 wXpoURDNrRPqw==
Message-ID: <3ed9f3bc-60f5-4c40-97b5-53d6af4d78c9@mleia.com>
Date: Mon, 16 Jun 2025 18:23:58 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] dmaengine: Add NULL check in lpc18xx_dmamux_reserve()
Content-Language: ru-RU
To: Charles Han <hanchunchao@inspur.com>, eugen.hristev@linaro.org,
 vkoul@kernel.org, manabian@gmail.com
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250616104420.1720-1-hanchunchao@inspur.com>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20250616104420.1720-1-hanchunchao@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20250616_152359_501906_5283B328 
X-CRM114-Status: GOOD (  21.31  )

On 6/16/25 13:44, Charles Han wrote:
> The function of_find_device_by_node() may return NULL if the device
> node is not found or CONFIG_OF not defined.

DMA_OF depends on OF, and the driver depends on OF as it's stated
in the drivers/dma/Kconfig, so this is not an issue.

Next, is it possible here to get of_find_device_by_node() returning
NULL? I don't think so, and then it's unclear which problem is supposed
to be fixed by this change, and therefore the change should be dropped.

> Add  check whether the return value is NULL and set the error code
> to be returned as -ENODEV.
> 
> Fixes: e5f4ae84be74 ("dmaengine: add driver for lpc18xx dmamux")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>   drivers/dma/lpc18xx-dmamux.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/lpc18xx-dmamux.c b/drivers/dma/lpc18xx-dmamux.c
> index 2b6436f4b193..f61183a1d0ba 100644
> --- a/drivers/dma/lpc18xx-dmamux.c
> +++ b/drivers/dma/lpc18xx-dmamux.c
> @@ -53,11 +53,17 @@ static void lpc18xx_dmamux_free(struct device *dev, void *route_data)
>   static void *lpc18xx_dmamux_reserve(struct of_phandle_args *dma_spec,
>   				    struct of_dma *ofdma)
>   {
> -	struct platform_device *pdev = of_find_device_by_node(ofdma->of_node);
> -	struct lpc18xx_dmamux_data *dmamux = platform_get_drvdata(pdev);
> +	struct platform_device *pdev;
> +	struct lpc18xx_dmamux_data *dmamux;

The list of declared/initialized local variables is deliberately sorted
in so called reverse Christmas tree order, please keep the sorting order.

>   	unsigned long flags;
>   	unsigned mux;
>   
> +	pdev = of_find_device_by_node(ofdma->of_node);
> +	if (!pdev)
> +		return ERR_PTR(-ENODEV);
> +
> +	dmamux = platform_get_drvdata(pdev);
> +
>   	if (dma_spec->args_count != 3) {
>   		dev_err(&pdev->dev, "invalid number of dma mux args\n");
>   		return ERR_PTR(-EINVAL);

--
Best wishes,
Vladimir

