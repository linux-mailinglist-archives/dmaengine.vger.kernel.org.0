Return-Path: <dmaengine+bounces-1071-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF9F85FAC5
	for <lists+dmaengine@lfdr.de>; Thu, 22 Feb 2024 15:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40E09287A0A
	for <lists+dmaengine@lfdr.de>; Thu, 22 Feb 2024 14:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E32F14691F;
	Thu, 22 Feb 2024 14:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+NyHl2g"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3EE14A4E4
	for <dmaengine@vger.kernel.org>; Thu, 22 Feb 2024 14:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610774; cv=none; b=bg0uQBRRK1wW9A4SQIbrUx021SWOqtjQX103YPAe2gxGEyUWV5TyMIM+GknHVesQqRkVu+qjyRduDfAWwplBfxRA+15nKANi82zBmB2e2Mq5qE3tZyWROGZhVhHNEtvDqZytD4wmN+89XVk/rUUeylSwZSbYwN8Xeu+Ks4eiKNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610774; c=relaxed/simple;
	bh=whB5aLDVQI+QzQKk7qssaJUU3gWEdKCsJubaDWjnUhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvETe8zUjq6aCxBn5FKhCdMnlCc9pGLvvQufn7Nf2Kg0F77pxhZ9osZ66LSkoN9/wMoRT9hsYDaMSYZhwrb566i/gW5C/tWf3VpU8THRTOZVfqnZqK1nKowMmv22rpzw88Fe0unVoSZtcI2R6kaMTdtrHp9nYZGNaRjpErU+3HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+NyHl2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8ADC433F1;
	Thu, 22 Feb 2024 14:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708610773;
	bh=whB5aLDVQI+QzQKk7qssaJUU3gWEdKCsJubaDWjnUhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K+NyHl2gbVXAXTlX6jxdlQLJ7xNDD6vcXY/sWElbXwGX1YBjVVvrOXaRi34eXp+cu
	 7FXWp9ANlAtSuqHbHH1zSB5KWTH0NTZKd+Z/1xTFPBMNUCQoE8e9zDqT/yAnckrmGg
	 1V0/1X5YutvGYWOuMbqZkSjnv42ejFxVTGROf4fJiyXXiGpRqzbBRqRtQlqddOunUT
	 0GJOO0PkS1VOx/9WPIUXT79NqJnb1XU00v0NUCDHHqGVknysJAStqNSt+cpj27AUea
	 H7Klmpl2TgKN8zEEAIjcSz052d07Zv1mrDM3+G+sLCaasKSpaCXoYJJgUIHG8X7uzU
	 9FJ+xCxfhTEmg==
Date: Thu, 22 Feb 2024 19:36:09 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2] dmaengine: axi-dmac: move to device managed probe
Message-ID: <ZddU0YQGh-HOmmOZ@matsya>
References: <20240219-axi-dmac-devm-probe-v2-1-1a6737294f69@analog.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240219-axi-dmac-devm-probe-v2-1-1a6737294f69@analog.com>

On 19-02-24, 11:20, Nuno Sa wrote:
> In axi_dmac_probe(), there's a mix in using device managed APIs and
> explicitly cleaning things in the driver .remove() hook. Move to use
> device managed APIs and thus drop the .remove() hook.
> 
> While doing this move request_irq() before of_dma_controller_register()
> so the previous cleanup order in the .remove() hook is preserved.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
> Changes in v2:
> - Keep devm_request_irq() after of_dma_controller_register() so we free
>   the irq first and avoid any possible race agains
>   of_dma_controller_register().
> - Link to v1: https://lore.kernel.org/r/20240214-axi-dmac-devm-probe-v1-1-22d633da19cb@analog.com
> 
> Vinod,
> 
> This actually made me think if I shouldn't have a preliminary patch
> just moving free_irq() before of_dma_controller_register() and treating
> it as bug (adding a proper fixes tag). Then moving to devm_ in a follow up
> patch.

That does sound better

> 
> What do you think? Is it worth it to backport this?

Yes bugs should be backported

> ---
>  drivers/dma/dma-axi-dmac.c | 78 ++++++++++++++++++++--------------------------
>  1 file changed, 34 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> index 4e339c04fc1e..bdb752f11869 100644
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
> +		return ret;
>  
> -	platform_set_drvdata(pdev, dmac);
> +	ret = devm_request_irq(&pdev->dev, dmac->irq, axi_dmac_interrupt_handler,
> +			       IRQF_SHARED, dev_name(&pdev->dev), dmac);
> +	if (ret)
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

