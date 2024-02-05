Return-Path: <dmaengine+bounces-956-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C11584A16F
	for <lists+dmaengine@lfdr.de>; Mon,  5 Feb 2024 18:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88344B20CC9
	for <lists+dmaengine@lfdr.de>; Mon,  5 Feb 2024 17:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8948F45946;
	Mon,  5 Feb 2024 17:55:16 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138AD45BF8;
	Mon,  5 Feb 2024 17:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155716; cv=none; b=XbXNJISwqB8Bsi6EnEvVBb95w4Qyl4UyhTuk+Wg4LRYZTqVg4GBUvr+7HmMq8hhvvaaDOwtZf7FjX6rEWzmOgzYumXwDLra95Xo0gxUEQlJ7vvCOJqJJ3Fi6SNw9w+l2CdEtMAHUUxPb0Knr47A3c9YUcXgJyaE8CDLbLNj5zGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155716; c=relaxed/simple;
	bh=eESW3XSM+ZIUv4q6feb/lSGwXUw4fd1vqphbOEDleeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ICRaZN9dEU3Rww+vyRseuCRujW3RzmSeUaKR8KJurxoVBEVjB/X4iy2XRf+6RkqSdnib1H9X/w2btzPpEVQ1yRsLwE14n+JaYnDOx5kvFFyoQtucz/Ji9v/6aLgv9Da3XldUrzyEk4pQGS3rPldepC76O4HB2/6eV6DDOZYsm34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADC1612FC;
	Mon,  5 Feb 2024 09:55:50 -0800 (PST)
Received: from [10.57.48.140] (unknown [10.57.48.140])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25BB73F5A1;
	Mon,  5 Feb 2024 09:55:06 -0800 (PST)
Message-ID: <1e71c153-e482-409c-b229-9b9c0662b67e@arm.com>
Date: Mon, 5 Feb 2024 17:55:03 +0000
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] bcm2835-dma: Advertise the full DMA range
Content-Language: en-GB
To: Andrea della Porta <andrea.porta@suse.com>, Vinod Koul
 <vkoul@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, dmaengine@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Maxime Ripard <maxime@cerno.tech>, Dom Cobley <popcornmix@gmail.com>,
 Phil Elwell <phil@raspberrypi.com>
References: <cover.1706948717.git.andrea.porta@suse.com>
 <a56a6d24066a64598efe4343090e51e2223475b8.1706948717.git.andrea.porta@suse.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <a56a6d24066a64598efe4343090e51e2223475b8.1706948717.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-04 6:59 am, Andrea della Porta wrote:
> From: Phil Elwell <phil@raspberrypi.com>
> 
> Unless the DMA mask is set wider than 32 bits, DMA mapping will use a
> bounce buffer.
> 
> Signed-off-by: Phil Elwell <phil@raspberrypi.com>
> ---
>   drivers/dma/bcm2835-dma.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> index 36bad198b655..237dcdb8d726 100644
> --- a/drivers/dma/bcm2835-dma.c
> +++ b/drivers/dma/bcm2835-dma.c
> @@ -39,6 +39,7 @@
>   #define BCM2711_DMA_MEMCPY_CHAN 14
>   
>   struct bcm2835_dma_cfg_data {
> +	u64	dma_mask;
>   	u32	chan_40bit_mask;
>   };
>   
> @@ -308,10 +309,12 @@ DEFINE_SPINLOCK(memcpy_lock);
>   
>   static const struct bcm2835_dma_cfg_data bcm2835_dma_cfg = {
>   	.chan_40bit_mask = 0,
> +	.dma_mask = DMA_BIT_MASK(32),
>   };
>   
>   static const struct bcm2835_dma_cfg_data bcm2711_dma_cfg = {
>   	.chan_40bit_mask = BIT(11) | BIT(12) | BIT(13) | BIT(14),
> +	.dma_mask = DMA_BIT_MASK(36),
>   };
>   
>   static inline size_t bcm2835_dma_max_frame_length(struct bcm2835_chan *c)
> @@ -1263,6 +1266,8 @@ static struct dma_chan *bcm2835_dma_xlate(struct of_phandle_args *spec,
>   
>   static int bcm2835_dma_probe(struct platform_device *pdev)
>   {
> +	const struct bcm2835_dma_cfg_data *cfg_data;
> +	const struct of_device_id *of_id;
>   	struct bcm2835_dmadev *od;
>   	struct resource *res;
>   	void __iomem *base;
> @@ -1272,13 +1277,20 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
>   	int irq_flags;
>   	uint32_t chans_available;
>   	char chan_name[BCM2835_DMA_CHAN_NAME_SIZE];
> -	const struct of_device_id *of_id;
>   	int chan_count, chan_start, chan_end;
>   
> +	of_id = of_match_node(bcm2835_dma_of_match, pdev->dev.of_node);
> +	if (!of_id) {
> +		dev_err(&pdev->dev, "Failed to match compatible string\n");
> +		return -EINVAL;
> +	}
> +
> +	cfg_data = of_id->data;

We've had of_device_get_match_data() for nearly 9 years now, and even a 
generic device_get_match_data() for 6 ;)

> +
>   	if (!pdev->dev.dma_mask)
>   		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;

[ Passing nit: that also really shouldn't be there, especially since 
cdfee5623290 ]

>   
> -	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +	rc = dma_set_mask_and_coherent(&pdev->dev, cfg_data->dma_mask);

Wait, does chan_40bit_mask mean that you still have some channels which 
*can't* address this full mask? If so this can't work properly. You may 
well need to redesign a bit further to have a separate DMA device for 
each channel such they can each have different masks.

Thanks,
Robin.

>   	if (rc) {
>   		dev_err(&pdev->dev, "Unable to set DMA mask\n");
>   		return rc;
> @@ -1342,7 +1354,7 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
>   		return -EINVAL;
>   	}
>   
> -	od->cfg_data = of_id->data;
> +	od->cfg_data = cfg_data;
>   
>   	/* Request DMA channel mask from device tree */
>   	if (of_property_read_u32(pdev->dev.of_node,

