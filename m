Return-Path: <dmaengine+bounces-2797-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A00F1947F9F
	for <lists+dmaengine@lfdr.de>; Mon,  5 Aug 2024 18:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 567A828163E
	for <lists+dmaengine@lfdr.de>; Mon,  5 Aug 2024 16:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FE915B984;
	Mon,  5 Aug 2024 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsVKimyh"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944062C684;
	Mon,  5 Aug 2024 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722876790; cv=none; b=K1APdFhdZ9Ki3whi1rtMYEmoi/b3BXXu4l7jWyZ06mMkC8XZtrbDdR7tOm+Rb2aDTwRDe0NGyFWxXUENZpNbU8vCByp38/EThbJ0rQ0MMsedAEZYnHZBbbpzcMOrAJfvQZVV13ew6wBiVggGex9gQiaOh0PfURw1e659EKNEWYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722876790; c=relaxed/simple;
	bh=o9ugM3P0drPcA1zifw1SGACj0yG51DJhSlYgmmJa+2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P48f6SYFF/a0WK+lycHnlct6hVFaBTwCwaM9wKrUab/wZlDbRH8nDx/IWecwyFnjQTwBIqUkEYUzAK7bl8wtTvL6qEd7jO86qaIa8CGrVP64VqcNJOESjs3CDL3yGQ2AW+oRCwV8U09HEkMcEFElhF3wpNqQ3x1rWlEYMokGhps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsVKimyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5472DC32782;
	Mon,  5 Aug 2024 16:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722876790;
	bh=o9ugM3P0drPcA1zifw1SGACj0yG51DJhSlYgmmJa+2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DsVKimyh3athBWR61d5V+zWcMbrGm0KNFU0aqiYQyyEChSGD97CArvLf6R/PCv1Kx
	 QJbMA5a3gBih/V0ziYR6u3/0LfI7tQdM+ZAN5L1l67k88eQwBIcrxl3JTJlk1j3jfc
	 qYHfEzhESzRY1WWY6AL3BXPVG/rPjEnpJVIdQxy3yZnu+rLa//MdmQdIQ7rb70lUzF
	 av9frt1FOdyg/C06WJdaSoztX4s3PwZzMDsVQ0kwOoBZvX3aiz/AbeDpiVQzvyzaWE
	 XQxafxShE42D7/4Fh489pgfX1Wc9ANJmfrdXE1ObX+7aJFKj7UaxVBTs90eAEmJ2ZH
	 dU2Z49Prd6JAg==
Date: Mon, 5 Aug 2024 22:23:05 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Abin Joseph <abin.joseph@amd.com>
Cc: michal.simek@amd.com, robh@kernel.org, u.kleine-koenig@pengutronix.de,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	radhey.shyam.pandey@amd.com, harini.katakam@amd.com, git@amd.com,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dmaengine: zynqmp_dma: Add support for AMD Versal
 Gen 2 DMA IP
Message-ID: <ZrEDcQLWCbKbCRaL@matsya>
References: <20240726062639.2609974-1-abin.joseph@amd.com>
 <20240726062639.2609974-3-abin.joseph@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726062639.2609974-3-abin.joseph@amd.com>

On 26-07-24, 11:56, Abin Joseph wrote:
> ZynqMp DMA IP and AMD Versal Gen 2 DMA IP are similar but have different
> interrupt register offset. Create a dedicated compatible string to
> support Versal Gen 2 DMA IP with Irq register offset for interrupt
> Enable/Disable/Status/Mask functionality.
> 
> Signed-off-by: Abin Joseph <abin.joseph@amd.com>
> ---
>  drivers/dma/xilinx/zynqmp_dma.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
> index f31631bef961..a5d84d746929 100644
> --- a/drivers/dma/xilinx/zynqmp_dma.c
> +++ b/drivers/dma/xilinx/zynqmp_dma.c
> @@ -22,10 +22,10 @@
>  #include "../dmaengine.h"
>  
>  /* Register Offsets */
> -#define ZYNQMP_DMA_ISR			0x100
> -#define ZYNQMP_DMA_IMR			0x104
> -#define ZYNQMP_DMA_IER			0x108
> -#define ZYNQMP_DMA_IDS			0x10C
> +#define ZYNQMP_DMA_ISR			(chan->irq_offset + 0x100)
> +#define ZYNQMP_DMA_IMR			(chan->irq_offset + 0x104)
> +#define ZYNQMP_DMA_IER			(chan->irq_offset + 0x108)
> +#define ZYNQMP_DMA_IDS			(chan->irq_offset + 0x10C)

Lower case please

>  #define ZYNQMP_DMA_CTRL0		0x110
>  #define ZYNQMP_DMA_CTRL1		0x114
>  #define ZYNQMP_DMA_DATA_ATTR		0x120
> @@ -145,6 +145,9 @@
>  #define tx_to_desc(tx)		container_of(tx, struct zynqmp_dma_desc_sw, \
>  					     async_tx)
>  
> +/* IRQ Register offset for VersalGen2 */
> +#define IRQ_REG_OFFSET			0x308
> +
>  /**
>   * struct zynqmp_dma_desc_ll - Hw linked list descriptor
>   * @addr: Buffer address
> @@ -211,6 +214,7 @@ struct zynqmp_dma_desc_sw {
>   * @bus_width: Bus width
>   * @src_burst_len: Source burst length
>   * @dst_burst_len: Dest burst length
> + * @irq_offset: Irq register offset
>   */
>  struct zynqmp_dma_chan {
>  	struct zynqmp_dma_device *zdev;
> @@ -235,6 +239,7 @@ struct zynqmp_dma_chan {
>  	u32 bus_width;
>  	u32 src_burst_len;
>  	u32 dst_burst_len;
> +	u32 irq_offset;
>  };
>  
>  /**
> @@ -919,6 +924,9 @@ static int zynqmp_dma_chan_probe(struct zynqmp_dma_device *zdev,
>  		return -EINVAL;
>  	}
>  
> +	if (of_device_is_compatible(node, "amd,versal2-dma-1.0"))
> +		chan->irq_offset = IRQ_REG_OFFSET;

This should be added as driver_data

> +
>  	chan->is_dmacoherent =  of_property_read_bool(node, "dma-coherent");
>  	zdev->chan = chan;
>  	tasklet_setup(&chan->tasklet, zynqmp_dma_do_tasklet);
> @@ -1162,6 +1170,7 @@ static void zynqmp_dma_remove(struct platform_device *pdev)
>  
>  static const struct of_device_id zynqmp_dma_of_match[] = {
>  	{ .compatible = "xlnx,zynqmp-dma-1.0", },
> +	{ .compatible = "amd,versal2-dma-1.0", },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, zynqmp_dma_of_match);
> -- 
> 2.25.1

-- 
~Vinod

