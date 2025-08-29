Return-Path: <dmaengine+bounces-6295-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A19B3C3D6
	for <lists+dmaengine@lfdr.de>; Fri, 29 Aug 2025 22:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC01170574
	for <lists+dmaengine@lfdr.de>; Fri, 29 Aug 2025 20:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D6F33EAF0;
	Fri, 29 Aug 2025 20:38:04 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FFA265CB3;
	Fri, 29 Aug 2025 20:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756499884; cv=none; b=UfJAqP8Smzp1RiriY8fM/u8bzyNIHKUMw1GgrmCeTdDo6i+mtYKHALz9RaauNKvvwWO/eNQJ2NGtlDNniICK0++zM621nJ65fT9KXt/W69e28rY71aIhtt61DC0rsroKfYD3wVpnZLyAeyHFu10PdFMvb21au9fiHjt0jYFYroY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756499884; c=relaxed/simple;
	bh=VdyVIwGgGCcRDMlwtZ1rKUBY8IL4eB0Lh3n+XkQ6ZYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptWiqYVXVu2sNBd9QHKCNIrNbMhc+kWuSZeHq85gw6gPHvziL14gGUrH2Ae4kaS3qzESHBl3+NvlVmx3AbwhBwYr5ygX1ySXCzCpT/8OmZ9S7vRGpgb1Zmlg7xJ24PjQVD9zl3sumt7t1JQg53WPXuw4gD5UidmHOlsOE2/z6YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EF7B1BA8;
	Fri, 29 Aug 2025 13:37:52 -0700 (PDT)
Received: from [10.57.3.75] (unknown [10.57.3.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 373033F63F;
	Fri, 29 Aug 2025 13:37:59 -0700 (PDT)
Message-ID: <12082d54-6014-4a63-8c51-8353f9dd6613@arm.com>
Date: Fri, 29 Aug 2025 21:37:56 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] dmaengine: dma350: Register the DMA controller to
 DT DMA helpers
To: Jisheng Zhang <jszhang@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250823154009.25992-1-jszhang@kernel.org>
 <20250823154009.25992-6-jszhang@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250823154009.25992-6-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-08-23 4:40 pm, Jisheng Zhang wrote:
> Register the DMA controller to DT DMA helpers so that we convert a DT
> phandle to a dma_chan structure.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   drivers/dma/arm-dma350.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
> index 17af9bb2a18f..6a9f81f941b0 100644
> --- a/drivers/dma/arm-dma350.c
> +++ b/drivers/dma/arm-dma350.c
> @@ -7,6 +7,7 @@
>   #include <linux/dma-mapping.h>
>   #include <linux/io.h>
>   #include <linux/of.h>
> +#include <linux/of_dma.h>
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
>   
> @@ -635,7 +636,7 @@ static int d350_probe(struct platform_device *pdev)
>   	if (ret)
>   		return dev_err_probe(dev, ret, "Failed to register DMA device\n");
>   
> -	return 0;
> +	return of_dma_controller_register(dev->of_node, of_dma_xlate_by_chan_id, &dmac->dma);

This only works for channels with HAS_TRIGSEL=0 (where I guess HAS_TRIG 
can be assumed from DT describing one) - with selectable triggers the 
trigger number (which the dma-cell specifier actually is) doesn't bear 
any relation to the channel number, so channel selection is both simpler 
and more complicated at the same time, since we could pick any free 
channel with HAS_TRIGSEL, but that's not necessarily just *any* free 
channel...

Given that at this point the driver only considers nominal trigger 
capability for channels with HAS_TRIGSEL=1, this patch seems effectively 
broken.

Thanks,
Robin.

>   }
>   
>   static void d350_remove(struct platform_device *pdev)
> @@ -643,6 +644,7 @@ static void d350_remove(struct platform_device *pdev)
>   	struct d350 *dmac = platform_get_drvdata(pdev);
>   
>   	dma_async_device_unregister(&dmac->dma);
> +	of_dma_controller_free(pdev->dev.of_node);
>   }
>   
>   static const struct of_device_id d350_of_match[] __maybe_unused = {

