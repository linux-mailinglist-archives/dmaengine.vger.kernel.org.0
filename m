Return-Path: <dmaengine+bounces-1025-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B604C857C75
	for <lists+dmaengine@lfdr.de>; Fri, 16 Feb 2024 13:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4583C1F2111A
	for <lists+dmaengine@lfdr.de>; Fri, 16 Feb 2024 12:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8974B78680;
	Fri, 16 Feb 2024 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3VHpeUP"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656EA78664
	for <dmaengine@vger.kernel.org>; Fri, 16 Feb 2024 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708086125; cv=none; b=F0zHcGNoa7VtFSSz/KePvsSAS4d3/i6Irv/uAAT6FicbIygwucs3Xaa5mGyHSt85gVO4nPNMyJo9J8trGKGveQmA8yFOGCrKaqyNyWI+aCtRdiTe7a0RtWVkS06fIWjUHbpzgeC7Qfz7V+pz1mOiI2OCmrNfduZBTbsAmi9iY6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708086125; c=relaxed/simple;
	bh=UjwC62UPSvpLC4JmMFYI2PLmcIU0Q4HcACqZO58TDAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxlaKNVGdMWVvMutu93heREL7OB4xMRNQR9Asij10OFd4bjDlUhE6QhCtUeMz3APOAlgBzlkhowjWuyzRL1uVDm8mMxwyJWD8ZrJqZ/t9J3RodZJ8q9bkJYMx0KC8L6Ai+GI/GGzNM5iuyEYSJhcQPlW5HuFu3zWjtycOmUE4Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3VHpeUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68624C433F1;
	Fri, 16 Feb 2024 12:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708086124;
	bh=UjwC62UPSvpLC4JmMFYI2PLmcIU0Q4HcACqZO58TDAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P3VHpeUP0n4abfHKvrZn+eE6PAOullHY8gL/OrWkjzffbQAvynRG0RK6jeWcTlf5O
	 CSktuTx6Wsw9z6zbGyfRatnyTICbG71VRY9KbwUmPoQlZR7u8ZLc6wKYWOgvqf4/yz
	 oJ8KjJZwaOtv5iRcyI5RpJRhA9fY6AWSa5xfktv5tW/mrHQRFp23trt1PCHiK1Klvn
	 +UoJJqsBeDuu6EkHqHV6S1mMBuWVfqcE07y0Y7bZsA+xCGxT0xFsaWa+vuOK14ziDh
	 FZMvkjNsnYiendqVHvNdiG3fc/4TXtZY1X6o0fG1lJNoNfWuXYoqbOVpPhQsyOfW4z
	 Xxe8EhqM1jBDw==
Date: Fri, 16 Feb 2024 17:52:00 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] dmaengine: axi-dmac: move to device managed probe
Message-ID: <Zc9TaGFInAQA-Zik@matsya>
References: <20240214-axi-dmac-devm-probe-v1-1-22d633da19cb@analog.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240214-axi-dmac-devm-probe-v1-1-22d633da19cb@analog.com>

On 14-02-24, 13:29, Nuno Sa wrote:
> In axi_dmac_probe(), there's a mix in using device managed APIs and
> explicitly cleaning things in the driver .remove() hook. Move to use
> device managed APIs and thus drop the .remove() hook.
> 
> While doing this move request_irq() before of_dma_controller_register()
> so the previous cleanup order in the .remove() hook is preserved.

It is good that we are doing this, but moving irq to devm doesnt help a
lot, there exists a race

I would suggest you use the axi_dmac_free_dma_controller() to all free
up irq explicitly, that will ensure things no chance of irq firing and
scheduling tasklet when we are removing

> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/dma/dma-axi-dmac.c | 80 ++++++++++++++++++++--------------------------
>  1 file changed, 35 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> index 4e339c04fc1e..24c911dc3161 100644
> --- a/drivers/dma/dma-axi-dmac.c
> +++ b/drivers/dma/dma-axi-dmac.c
> @@ -1002,6 +1002,16 @@ static int axi_dmac_detect_caps(struct axi_dmac *dmac, unsigned int version)
>  	return 0;
>  }
>  
> +static void axi_dmac_tasklet_kill(void *task)
> +{
> +	tasklet_kill(task);
> +}
> +
> +static void axi_dmac_free_dma_controller(void *of_node)
> +{
> +	of_dma_controller_free(of_node);
> +}
> +
>  static int axi_dmac_probe(struct platform_device *pdev)
>  {
>  	struct dma_device *dma_dev;
> @@ -1025,14 +1035,10 @@ static int axi_dmac_probe(struct platform_device *pdev)
>  	if (IS_ERR(dmac->base))
>  		return PTR_ERR(dmac->base);
>  
> -	dmac->clk = devm_clk_get(&pdev->dev, NULL);
> +	dmac->clk = devm_clk_get_enabled(&pdev->dev, NULL);
>  	if (IS_ERR(dmac->clk))
>  		return PTR_ERR(dmac->clk);
>  
> -	ret = clk_prepare_enable(dmac->clk);
> -	if (ret < 0)
> -		return ret;
> -
>  	version = axi_dmac_read(dmac, ADI_AXI_REG_VERSION);
>  
>  	if (version >= ADI_AXI_PCORE_VER(4, 3, 'a'))
> @@ -1041,7 +1047,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
>  		ret = axi_dmac_parse_dt(&pdev->dev, dmac);
>  
>  	if (ret < 0)
> -		goto err_clk_disable;
> +		return ret;
>  
>  	INIT_LIST_HEAD(&dmac->chan.active_descs);
>  
> @@ -1072,7 +1078,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
>  
>  	ret = axi_dmac_detect_caps(dmac, version);
>  	if (ret)
> -		goto err_clk_disable;
> +		return ret;
>  
>  	dma_dev->copy_align = (dmac->chan.address_align_mask + 1);
>  
> @@ -1088,57 +1094,42 @@ static int axi_dmac_probe(struct platform_device *pdev)
>  		    !AXI_DMAC_DST_COHERENT_GET(ret)) {
>  			dev_err(dmac->dma_dev.dev,
>  				"Coherent DMA not supported in hardware");
> -			ret = -EINVAL;
> -			goto err_clk_disable;
> +			return -EINVAL;
>  		}
>  	}
>  
> -	ret = dma_async_device_register(dma_dev);
> +	ret = dmaenginem_async_device_register(dma_dev);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Put the action in here so it get's done before unregistering the DMA
> +	 * device.
> +	 */
> +	ret = devm_add_action_or_reset(&pdev->dev, axi_dmac_tasklet_kill,
> +				       &dmac->chan.vchan.task);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_request_irq(&pdev->dev, dmac->irq, axi_dmac_interrupt_handler,
> +			       IRQF_SHARED, dev_name(&pdev->dev), dmac);
>  	if (ret)
> -		goto err_clk_disable;
> +		return ret;
>  
>  	ret = of_dma_controller_register(pdev->dev.of_node,
>  		of_dma_xlate_by_chan_id, dma_dev);
>  	if (ret)
> -		goto err_unregister_device;
> +		return ret;
>  
> -	ret = request_irq(dmac->irq, axi_dmac_interrupt_handler, IRQF_SHARED,
> -		dev_name(&pdev->dev), dmac);
> +	ret = devm_add_action_or_reset(&pdev->dev, axi_dmac_free_dma_controller,
> +				       pdev->dev.of_node);
>  	if (ret)
> -		goto err_unregister_of;
> -
> -	platform_set_drvdata(pdev, dmac);
> +		return ret;
>  
>  	regmap = devm_regmap_init_mmio(&pdev->dev, dmac->base,
>  		 &axi_dmac_regmap_config);
> -	if (IS_ERR(regmap)) {
> -		ret = PTR_ERR(regmap);
> -		goto err_free_irq;
> -	}
> -
> -	return 0;
> -
> -err_free_irq:
> -	free_irq(dmac->irq, dmac);
> -err_unregister_of:
> -	of_dma_controller_free(pdev->dev.of_node);
> -err_unregister_device:
> -	dma_async_device_unregister(&dmac->dma_dev);
> -err_clk_disable:
> -	clk_disable_unprepare(dmac->clk);
> -
> -	return ret;
> -}
> -
> -static void axi_dmac_remove(struct platform_device *pdev)
> -{
> -	struct axi_dmac *dmac = platform_get_drvdata(pdev);
>  
> -	of_dma_controller_free(pdev->dev.of_node);
> -	free_irq(dmac->irq, dmac);
> -	tasklet_kill(&dmac->chan.vchan.task);
> -	dma_async_device_unregister(&dmac->dma_dev);
> -	clk_disable_unprepare(dmac->clk);
> +	return PTR_ERR_OR_ZERO(regmap);
>  }
>  
>  static const struct of_device_id axi_dmac_of_match_table[] = {
> @@ -1153,7 +1144,6 @@ static struct platform_driver axi_dmac_driver = {
>  		.of_match_table = axi_dmac_of_match_table,
>  	},
>  	.probe = axi_dmac_probe,
> -	.remove_new = axi_dmac_remove,
>  };
>  module_platform_driver(axi_dmac_driver);
>  
> 
> ---
> base-commit: de7d9cb3b064fdfb2e0e7706d14ffee20b762ad2
> change-id: 20240214-axi-dmac-devm-probe-d718ef36fb58
> --
> 
> Thanks!
> - Nuno Sá

-- 
~Vinod

