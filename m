Return-Path: <dmaengine+bounces-4767-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DB7A6CCC2
	for <lists+dmaengine@lfdr.de>; Sat, 22 Mar 2025 22:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB713188FF31
	for <lists+dmaengine@lfdr.de>; Sat, 22 Mar 2025 21:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53191EF38A;
	Sat, 22 Mar 2025 21:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="jmU14P3a"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BF8481A3;
	Sat, 22 Mar 2025 21:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742679556; cv=none; b=keOZOMSqKVgez5eK90F96pjo9fvoxXt99e9FDGMvytiOIymH18iShwkzLorT78ynw8lmEK/tbfYbZMYrQtewhwd1upfDLccaDMEtQcBZhxQ/NDFAWZ1zm8flLKWTf49PeWDW8daJZA8wqWYoz3PYpRt21sKilHJcE17GzmLZB6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742679556; c=relaxed/simple;
	bh=ey3g6nGUBCIH6tf4twd1/6puXRbl6nW4ZWV5q1/KhPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MMT7cYr/SlQKfsNQodpZ6cgJrXWMmDOW2FBeh/SUbx2KfS9IpAiCmvs32gMAq5bPopRR3cAsK+qzuqwChFXwqjqW/Qt4v4jFPl2UqrKZgGZE+O8/MbInzOLmNTnvcXDJT0b0mwgldfz0xcWOZOoql3lUVYZaRXlbSrqUorpFvdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=jmU14P3a; arc=none smtp.client-ip=80.12.242.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id w6XTtGGb67I4cw6XWtwDSM; Sat, 22 Mar 2025 22:38:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1742679482;
	bh=1jP1iD/XB5t52+KeZ1FsE4W0vWyW8Ips9m8Lf+NGpwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=jmU14P3aY7umyeNggwmyo3m3SSEPB7x7iI9RakbnjWSc7xkOvb1vVF4ih0Mw0PHwJ
	 jCRI/cSo9UCOV8YFL4MGU01vkq2IA63Vo7PXpMRBlJq3uPNc94NJfhYu9vtSvQeVDS
	 3bz0TDBvtHn+2m3Di7r/BMKo2lI30qENa+N/v2ST4GUUJ5GVjQ1X0KA2NKiDXdOcfN
	 A2Q+AjZNvVfPqheMeUWb/Q7z2wQIdUVDPX2us8iLwNRjVfn8Y2SRPExz2Oh1+SfX03
	 UqufGvWPz4SHYI1PCpPXfAgEPMOHGpf3TN19VQTsNmw8p2C+FqDX1DxbQCnu2ILpmd
	 y4YU0IykOxLTw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 22 Mar 2025 22:38:02 +0100
X-ME-IP: 90.11.132.44
Message-ID: <071b4cf6-df18-4232-b2ae-6b8bee48899d@wanadoo.fr>
Date: Sat, 22 Mar 2025 22:37:55 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] dma-engine: sun4i: Use devm functions in probe()
To: =?UTF-8?B?QmVuY2UgQ3PDs2vDoXM=?= <csokas.bence@prolan.hu>,
 dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Markus Elfring <Markus.Elfring@web.de>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Vinod Koul <vkoul@kernel.org>, Samuel Holland <samuel@sholland.org>
References: <20250322193640.246382-2-csokas.bence@prolan.hu>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250322193640.246382-2-csokas.bence@prolan.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 22/03/2025 à 20:36, Bence Csókás a écrit :
> Clean up error handling by using devm functions and dev_err_probe(). This
> should make it easier to add new code, as we can eliminate the "goto
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
>      Changes in v5:
>      * reformat msg to 75 cols
>      * keep `\n`s in error messages
> 
>   drivers/dma/sun4i-dma.c | 31 ++++++-------------------------
>   1 file changed, 6 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
> index 24796aaaddfa..59ecebfc8eed 100644
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
> +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk), "Couldn't start the clock\n");

I think that it would be better to keep the message on another line, to 
avoid too long lines.

>   	}

In several places, now {} around a single statement looks unneeded.

CJ

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
> +		return dev_err_probe(&pdev->dev, ret, "Cannot request IRQ\n");
>   	}
>   
> -	ret = dma_async_device_register(&priv->slave);
> +	ret = dmaenginem_async_device_register(&priv->slave);
>   	if (ret) {
> -		dev_warn(&pdev->dev, "Failed to register DMA engine device\n");
> -		goto err_clk_disable;
> +		return dev_err_probe(&pdev->dev, ret, "Failed to register DMA engine device\n");
>   	}
>   
>   	ret = of_dma_controller_register(pdev->dev.of_node, sun4i_dma_of_xlate,
>   					 priv);
>   	if (ret) {
> -		dev_err(&pdev->dev, "of_dma_controller_register failed\n");
> -		goto err_dma_unregister;
> +		return dev_err_probe(&pdev->dev, ret, "Failed to register translation function\n");
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


