Return-Path: <dmaengine+bounces-215-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F2A7F7370
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 13:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F333E1C20D80
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 12:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8531C23763;
	Fri, 24 Nov 2023 12:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDV2VTHm"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DF11D68D;
	Fri, 24 Nov 2023 12:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22583C433CC;
	Fri, 24 Nov 2023 12:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700827727;
	bh=GmiTsGtZkHaCeXTzHWMEwflW5T9uYFI6FuYPKmtSRmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BDV2VTHm7KKeLd+Vmf8zPIy9vQN6GsySYSxO9z9iDtyDh9QNRTyjI7lq+8w/AhcFH
	 h3MtG3dVtx0/32c4kXeUs8mYqujSf6DhPwt6ewwbT48bYifcoc04yqMxFA4AzkEajw
	 BXrlGqBu9EvIw2thyrABW9n8YByTmZ8Tt7rOF1xlAEEIaQfopXAf8mCxGmyEOiN6pa
	 S2B8WxTF9oUU/lc7LS2/fZz7Wx3Ef1CrGEAK1sZOoAvjry96M6WLR+3/zRi3zlAtWS
	 InXn9hsgZ8k6bqNR5Za3nCt7eT5sp9XDfBU/ZIDhhGkbmFDuI+tNul1HjXajqOMoux
	 bEYng6buVCr4A==
Date: Fri, 24 Nov 2023 17:38:43 +0530
From: Vinod Koul <vkoul@kernel.org>
To: shravan chippa <shravan.chippa@microchip.com>
Cc: green.wan@sifive.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
	paul.walmsley@sifive.com, conor+dt@kernel.org,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	nagasuresh.relli@microchip.com, praveen.kumar@microchip.com
Subject: Re: [PATCH v4 1/4] dmaengine: sf-pdma: Support
 of_dma_controller_register()
Message-ID: <ZWCSS+UXpRO+4y9h@matsya>
References: <20231031052753.3430169-1-shravan.chippa@microchip.com>
 <20231031052753.3430169-2-shravan.chippa@microchip.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031052753.3430169-2-shravan.chippa@microchip.com>

On 31-10-23, 10:57, shravan chippa wrote:
> From: Shravan Chippa <shravan.chippa@microchip.com>
> 
> Update sf-pdma driver to adopt generic DMA device tree bindings.
> It calls of_dma_controller_register() with sf-pdma specific
> of_dma_xlate to get the generic DMA device tree helper support
> and the DMA clients can look up the sf-pdma controller using
> standard APIs.
> 
> Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> ---
>  drivers/dma/sf-pdma/sf-pdma.c | 44 +++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
> index d1c6956af452..4c456bdef882 100644
> --- a/drivers/dma/sf-pdma/sf-pdma.c
> +++ b/drivers/dma/sf-pdma/sf-pdma.c
> @@ -20,6 +20,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/of.h>
> +#include <linux/of_dma.h>
>  #include <linux/slab.h>
>  
>  #include "sf-pdma.h"
> @@ -490,6 +491,33 @@ static void sf_pdma_setup_chans(struct sf_pdma *pdma)
>  	}
>  }
>  
> +static struct dma_chan *sf_pdma_of_xlate(struct of_phandle_args *dma_spec,
> +					 struct of_dma *ofdma)
> +{
> +	struct sf_pdma *pdma = ofdma->of_dma_data;
> +	struct device *dev = pdma->dma_dev.dev;
> +	struct sf_pdma_chan *chan;
> +	struct dma_chan *c;
> +	u32 channel_id;
> +
> +	if (dma_spec->args_count != 1) {
> +		dev_err(dev, "Bad number of cells\n");
> +		return NULL;
> +	}
> +
> +	channel_id = dma_spec->args[0];
> +
> +	chan = &pdma->chans[channel_id];
> +
> +	c = dma_get_slave_channel(&chan->vchan.chan);
> +	if (!c) {
> +		dev_err(dev, "No more channels available\n");
> +		return NULL;
> +	}
> +
> +	return c;
> +}

This seems could be replaced by of_dma_xlate_by_chan_id() can you tell
me why that cant be used?

> +
>  static int sf_pdma_probe(struct platform_device *pdev)
>  {
>  	struct sf_pdma *pdma;
> @@ -563,7 +591,20 @@ static int sf_pdma_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	ret = of_dma_controller_register(pdev->dev.of_node,
> +					 sf_pdma_of_xlate, pdma);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +			"Can't register SiFive Platform OF_DMA. (%d)\n", ret);
> +		goto err_unregister;
> +	}
> +
>  	return 0;
> +
> +err_unregister:
> +	dma_async_device_unregister(&pdma->dma_dev);
> +
> +	return ret;
>  }
>  
>  static int sf_pdma_remove(struct platform_device *pdev)
> @@ -583,6 +624,9 @@ static int sf_pdma_remove(struct platform_device *pdev)
>  		tasklet_kill(&ch->err_tasklet);
>  	}
>  
> +	if (pdev->dev.of_node)
> +		of_dma_controller_free(pdev->dev.of_node);
> +
>  	dma_async_device_unregister(&pdma->dma_dev);
>  
>  	return 0;
> -- 
> 2.34.1

-- 
~Vinod

