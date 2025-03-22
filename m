Return-Path: <dmaengine+bounces-4764-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F84A6CBFC
	for <lists+dmaengine@lfdr.de>; Sat, 22 Mar 2025 20:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35FBD1892D1D
	for <lists+dmaengine@lfdr.de>; Sat, 22 Mar 2025 19:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89EB1552E0;
	Sat, 22 Mar 2025 19:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="chkbeUwC"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2694C6C;
	Sat, 22 Mar 2025 19:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742670881; cv=none; b=utX0G+oM/Bt9oxv528LwzLD6+jM3Gwy6FVCRZK+R9dfnRsaVW3MraYbIg9XHkGhMG6c4Nkbe4hxr+0N0nQh74zXNbMM9VNi5s+l4KHUZV0z4osWq+vbRwy2f0yit8skmAjQSKIVupNmZmfZJgUeTxCvgILsNxV69EDB/ionvS2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742670881; c=relaxed/simple;
	bh=nEsJrPXDuUDUnVZqh+LzUHVUldO9ZA1Z3xqg76FiNjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gYgg4TCJxnA2OrCG+g+AdQLsyVOX1nObYQNn/jHFYpaS2KAqqgYt+sQ5rW0vk/kWS/FGR7JBB5A78T8WadMO8MeleTzFH9IUu8fCb+0LpmAJFIF4Cp6FrJTY+khfMuT9M1Oh4JDvNi+BTrAxjFEUOWlwH6tQk7FkNdCYc8CQuDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=chkbeUwC; arc=none smtp.client-ip=80.12.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id w4HatCTnVU7JGw4HdttFBn; Sat, 22 Mar 2025 20:13:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1742670809;
	bh=GqgZb+i4yK7dllKvScRefHtLnN0CzsolWUusRpWEKms=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=chkbeUwCg3qyuRb1U/Z0WzAnX1ytRARN9GoxhKsieeXc5u2nlg3VLIgE7bhuqm/kh
	 AAS5cViru+62geZRjjAH1E1acxK5eYKLSzBN18Ud0T4qmhh6Ww8Mo4GKnJibU51tvD
	 atFAa+EweyZxqFHqhE9HuJlYw+a1jJdM5ZwuAChc68bElWHF6HM/P70UkzFKZuQw0l
	 7QHK9qS2wF53Upq0r43tmZ3cQbN5MIUOGnSqo3q8TfPlr0/cyDoUC+wCboeQKGWGRg
	 PLd1vLFkc7CerQzeKNNLK4od8KLCxTvfKJBKG6ALDMGeae1rKOaNqDJH/++onTxLe5
	 V1rf8ry8fwoHw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 22 Mar 2025 20:13:29 +0100
X-ME-IP: 90.11.132.44
Message-ID: <e4249f3c-ca05-4fc7-b367-6ce280d0d749@wanadoo.fr>
Date: Sat, 22 Mar 2025 20:13:21 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dma-engine: sun4i: Use devm functions in probe()
To: =?UTF-8?B?QmVuY2UgQ3PDs2vDoXM=?= <csokas.bence@prolan.hu>,
 dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Vinod Koul <vkoul@kernel.org>, Samuel Holland <samuel@sholland.org>
References: <20250311180254.149484-1-csokas.bence@prolan.hu>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250311180254.149484-1-csokas.bence@prolan.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 11/03/2025 à 19:02, Bence Csókás a écrit :
> Clean up error handling by using devm functions
> and dev_err_probe(). This should make it easier
> to add new code, as we can eliminate the "goto
> ladder" in probe().
> 
> Suggested-by: Chen-Yu Tsai <wens@kernel.org>
> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
> ---
> 
> Notes:
>      Changes in v2:
>      * rebase on current next
>      Changes in v3:
>      * rebase on current next
>      * collect Jernej's tag
>      Changes in v4:
>      * rebase on current next
>      * collect Chen-Yu's tag
> 
>   drivers/dma/sun4i-dma.c | 31 ++++++-------------------------
>   1 file changed, 6 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
> index 24796aaaddfa..b10639720efd 100644
> --- a/drivers/dma/sun4i-dma.c
> +++ b/drivers/dma/sun4i-dma.c
> @@ -1249,10 +1249,9 @@ static int sun4i_dma_probe(struct platform_device *pdev)
>   	if (priv->irq < 0)
>   		return priv->irq;
>   
> -	priv->clk = devm_clk_get(&pdev->dev, NULL);
> +	priv->clk = devm_clk_get_enabled(&pdev->dev, NULL);
>   	if (IS_ERR(priv->clk)) {
> -		dev_err(&pdev->dev, "No clock specified\n");
> -		return PTR_ERR(priv->clk);
> +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk), "Couldn't start the clock");

Why removing the trailing \n everywhere?

Any reference esxplaing why it is correct?

CJ

>   	}
>   
>   	if (priv->cfg->has_reset) {
> @@ -1328,12 +1327,6 @@ static int sun4i_dma_probe(struct platform_device *pdev)
>   		vchan_init(&vchan->vc, &priv->slave);
>   	}
>   
> -	ret = clk_prepare_enable(priv->clk);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Couldn't enable the clock\n");
> -		return ret;
> -	}
> -
>   	/*
>   	 * Make sure the IRQs are all disabled and accounted for. The bootloader
>   	 * likes to leave these dirty
> @@ -1344,32 +1337,23 @@ static int sun4i_dma_probe(struct platform_device *pdev)
>   	ret = devm_request_irq(&pdev->dev, priv->irq, sun4i_dma_interrupt,
>   			       0, dev_name(&pdev->dev), priv);
>   	if (ret) {
> -		dev_err(&pdev->dev, "Cannot request IRQ\n");
> -		goto err_clk_disable;
> +		return dev_err_probe(&pdev->dev, ret, "Cannot request IRQ");
>   	}
>   
> -	ret = dma_async_device_register(&priv->slave);
> +	ret = dmaenginem_async_device_register(&priv->slave);
>   	if (ret) {
> -		dev_warn(&pdev->dev, "Failed to register DMA engine device\n");
> -		goto err_clk_disable;
> +		return dev_err_probe(&pdev->dev, ret, "Failed to register DMA engine device");
>   	}
>   
>   	ret = of_dma_controller_register(pdev->dev.of_node, sun4i_dma_of_xlate,
>   					 priv);
>   	if (ret) {
> -		dev_err(&pdev->dev, "of_dma_controller_register failed\n");
> -		goto err_dma_unregister;
> +		return dev_err_probe(&pdev->dev, ret, "Failed to register translation function");
>   	}
>   
>   	dev_dbg(&pdev->dev, "Successfully probed SUN4I_DMA\n");
>   
>   	return 0;
> -
> -err_dma_unregister:
> -	dma_async_device_unregister(&priv->slave);
> -err_clk_disable:
> -	clk_disable_unprepare(priv->clk);
> -	return ret;
>   }
>   
>   static void sun4i_dma_remove(struct platform_device *pdev)
> @@ -1380,9 +1364,6 @@ static void sun4i_dma_remove(struct platform_device *pdev)
>   	disable_irq(priv->irq);
>   
>   	of_dma_controller_free(pdev->dev.of_node);
> -	dma_async_device_unregister(&priv->slave);
> -
> -	clk_disable_unprepare(priv->clk);
>   }
>   
>   static struct sun4i_dma_config sun4i_a10_dma_cfg = {


