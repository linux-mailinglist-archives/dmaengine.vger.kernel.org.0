Return-Path: <dmaengine+bounces-957-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDD484A1BB
	for <lists+dmaengine@lfdr.de>; Mon,  5 Feb 2024 19:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43AEE1C21D5E
	for <lists+dmaengine@lfdr.de>; Mon,  5 Feb 2024 18:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4961445BF8;
	Mon,  5 Feb 2024 18:04:00 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CAB44C66;
	Mon,  5 Feb 2024 18:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707156240; cv=none; b=HpXDpaOdxUl2mFDeVzKKGninC0v64FRZU9dCNveFEvj7MSYo1pVmazHsb/AnF9aD55vIoRdETF4O7UYMzWDYAFPZn420Wh3b46oXuDJWREZTkesFyOLo3aixPDfsbDhr0IQIJJDPfEwlMq6sjDudl7bdmcTpg1CS1mzRod6LGYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707156240; c=relaxed/simple;
	bh=acHH8lLMt/+fXy9cDtqL91wGghvqnB/fGWuddTkpbls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Os0AYlcbGpQOajvi6FoCkJsMSl71ZLlon7WDJquF/37rXpdpgqLzY+y2BSh8K5sFl6K9kjyHU5AiyedGPvNc85kV+Ho5zlyMMkW1czVjDNvT1e26XXRb6B9n8RtqnKgRp7H/u7ZFQlbtsw0llbcjgp29eR4hAswpN9J+UO9QPYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D0E212FC;
	Mon,  5 Feb 2024 10:04:39 -0800 (PST)
Received: from [10.57.48.140] (unknown [10.57.48.140])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 651753F5A1;
	Mon,  5 Feb 2024 10:03:54 -0800 (PST)
Message-ID: <ee19a95d-fe1e-4f3f-bc81-bdef38475469@arm.com>
Date: Mon, 5 Feb 2024 18:03:53 +0000
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] bcm2835-dma: Derive slave DMA addresses correctly
Content-Language: en-GB
To: Andrea della Porta <andrea.porta@suse.com>, Vinod Koul
 <vkoul@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, dmaengine@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Cc: Maxime Ripard <maxime@cerno.tech>, Dom Cobley <popcornmix@gmail.com>,
 Phil Elwell <phil@raspberrypi.com>
References: <cover.1706948717.git.andrea.porta@suse.com>
 <30da53ebdf43b712da790fd2ae0f0040f71762b8.1706948717.git.andrea.porta@suse.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <30da53ebdf43b712da790fd2ae0f0040f71762b8.1706948717.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-04 6:59 am, Andrea della Porta wrote:
> From: Phil Elwell <phil@raspberrypi.com>
> 
> Slave addresses for DMA are meant to be supplied as physical addresses
> (contrary to what struct snd_dmaengine_dai_dma_data does). It is up to
> the DMA controller driver to perform the translation based on its own
> view of the world, as described in Device Tree.
> 
> Now that the Pi Device Trees have the correct peripheral mappings,
> replace the hacky address munging with phys_to_dma().
> 
> Signed-off-by: Phil Elwell <phil@raspberrypi.com>
> ---
>   drivers/dma/bcm2835-dma.c | 23 +++++------------------
>   1 file changed, 5 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> index 237dcdb8d726..077812eda609 100644
> --- a/drivers/dma/bcm2835-dma.c
> +++ b/drivers/dma/bcm2835-dma.c
> @@ -18,6 +18,7 @@
>    *	Copyright 2012 Marvell International Ltd.
>    */
>   #include <linux/dmaengine.h>
> +#include <linux/dma-direct.h>

Please read the comment at the top of that file; this driver is 
definitely not a DMA API implementation, and should not be including it.

>   #include <linux/dma-mapping.h>
>   #include <linux/dmapool.h>
>   #include <linux/err.h>
> @@ -980,22 +981,12 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_slave_sg(
>   	if (direction == DMA_DEV_TO_MEM) {
>   		if (c->cfg.src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
>   			return NULL;
> -		src = c->cfg.src_addr;
> -		/*
> -		 * One would think it ought to be possible to get the physical
> -		 * to dma address mapping information from the dma-ranges DT
> -		 * property, but I've not found a way yet that doesn't involve
> -		 * open-coding the whole thing.
> -		 */
> -		if (c->is_40bit_channel)
> -			src |= 0x400000000ull;
> +		src = phys_to_dma(chan->device->dev, c->cfg.src_addr);

FWIW I'd argue that abusing DMA API internals like this is even more 
hacky than bypassing it entirely. The appropriate public API for setting 
up the device end of a transfer is dma_map_resource(). Now, it *is* the 
case currently that the dma-direct implementation of that does not take 
dma_range_map into account, but that's already an open question:

https://lore.kernel.org/linux-iommu/20220610080802.11147-1-Sergey.Semin@baikalelectronics.ru/

Thanks,
Robin.

>   		info |= BCM2835_DMA_S_DREQ | BCM2835_DMA_D_INC;
>   	} else {
>   		if (c->cfg.dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
>   			return NULL;
> -		dst = c->cfg.dst_addr;
> -		if (c->is_40bit_channel)
> -			dst |= 0x400000000ull;
> +		dst = phys_to_dma(chan->device->dev, c->cfg.dst_addr);
>   		info |= BCM2835_DMA_D_DREQ | BCM2835_DMA_S_INC;
>   	}
>   
> @@ -1064,17 +1055,13 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
>   	if (direction == DMA_DEV_TO_MEM) {
>   		if (c->cfg.src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
>   			return NULL;
> -		src = c->cfg.src_addr;
> -		if (c->is_40bit_channel)
> -			src |= 0x400000000ull;
> +		src = phys_to_dma(chan->device->dev, c->cfg.src_addr);
>   		dst = buf_addr;
>   		info |= BCM2835_DMA_S_DREQ | BCM2835_DMA_D_INC;
>   	} else {
>   		if (c->cfg.dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
>   			return NULL;
> -		dst = c->cfg.dst_addr;
> -		if (c->is_40bit_channel)
> -			dst |= 0x400000000ull;
> +		dst = phys_to_dma(chan->device->dev, c->cfg.dst_addr);
>   		src = buf_addr;
>   		info |= BCM2835_DMA_D_DREQ | BCM2835_DMA_S_INC;
>   

