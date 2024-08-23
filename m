Return-Path: <dmaengine+bounces-2949-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B149C95CC19
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2024 14:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72431C23713
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2024 12:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3A0185932;
	Fri, 23 Aug 2024 12:08:41 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C83818594F;
	Fri, 23 Aug 2024 12:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414921; cv=none; b=LQKMdB06XdCaOxe9FkM4fOGnbazYaKS9+mWYIBr5hi61I4TqVMs2Vm5rvwDzKhI+NGdZk+6BkDQQQHnVejoeptJYnAUbtonA5Rrd2/n0mO5R7B2jShtqY4QP1NvjDWpSImJNvDSQeJvdSizYCbenVEYdIcTTfbtEzz6wIoHfT6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414921; c=relaxed/simple;
	bh=dNBStzrtWTFyKpVGUObU1OtKpxEfWtJX2uO8TQ2gpLA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S8o2FU0OLcLYDepDkVIz5UKg62krLHk+L2fKhvgVgXYzEU0TcnvDUzXuyC6BXHotAEfJIEs27+Fzybd4c/eWaeIb//TglmyDufCYgIhPgUGH6VOAy3AzCxNeO91l49cuIurmCikf0C+FrV4ZeJy10+D1wKvdSH4u72azMScIQM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WqzJz6wy7z6G9M8;
	Fri, 23 Aug 2024 20:04:51 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id F1A4B1400DD;
	Fri, 23 Aug 2024 20:08:36 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 23 Aug
 2024 13:08:36 +0100
Date: Fri, 23 Aug 2024 13:08:35 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
CC: <vkoul@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] dma:imx-sdma:Use devm_clk_get_enabled() helpers
Message-ID: <20240823130835.00003495@Huawei.com>
In-Reply-To: <20240823101933.9517-5-liaoyuanhong@vivo.com>
References: <20240823101933.9517-1-liaoyuanhong@vivo.com>
	<20240823101933.9517-5-liaoyuanhong@vivo.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 23 Aug 2024 18:19:31 +0800
Liao Yuanhong <liaoyuanhong@vivo.com> wrote:

> Use devm_clk_get_enabled() instead of clk functions in imx-sdma.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
No.
Consider why the clocks are adjusted where they are in existing code
before 'cleaning' it up.

> ---
>  drivers/dma/imx-sdma.c | 57 ++++--------------------------------------
>  1 file changed, 5 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 72299a08af44..af972a4b6ce1 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1493,24 +1493,11 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
>  	sdmac->event_id0 = data->dma_request;
>  	sdmac->event_id1 = data->dma_request2;
>  
> -	ret = clk_enable(sdmac->sdma->clk_ipg);
> -	if (ret)
> -		return ret;
> -	ret = clk_enable(sdmac->sdma->clk_ahb);
> -	if (ret)
> -		goto disable_clk_ipg;
> -
>  	ret = sdma_set_channel_priority(sdmac, prio);
>  	if (ret)
> -		goto disable_clk_ahb;
> +		return ret;
>  
>  	return 0;
> -
> -disable_clk_ahb:
> -	clk_disable(sdmac->sdma->clk_ahb);
> -disable_clk_ipg:
> -	clk_disable(sdmac->sdma->clk_ipg);
> -	return ret;
>  }
>  
>  static void sdma_free_chan_resources(struct dma_chan *chan)
> @@ -1530,9 +1517,6 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
>  	sdmac->event_id1 = 0;
>  
>  	sdma_set_channel_priority(sdmac, 0);
> -
> -	clk_disable(sdma->clk_ipg);
> -	clk_disable(sdma->clk_ahb);
>  }
>  
>  static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
> @@ -2015,14 +1999,10 @@ static void sdma_load_firmware(const struct firmware *fw, void *context)
>  	addr = (void *)header + header->script_addrs_start;
>  	ram_code = (void *)header + header->ram_code_start;
>  
> -	clk_enable(sdma->clk_ipg);
> -	clk_enable(sdma->clk_ahb);
>  	/* download the RAM image for SDMA */
>  	sdma_load_script(sdma, ram_code,
>  			 header->ram_code_size,
>  			 addr->ram_code_start_addr);
> -	clk_disable(sdma->clk_ipg);
> -	clk_disable(sdma->clk_ahb);
Why do you think it is suddenly fine to leave the locks on here and it
wasn't before?

Check all the paths.

>  
>  	sdma_add_scripts(sdma, addr);
>  
> @@ -2119,13 +2099,6 @@ static int sdma_init(struct sdma_engine *sdma)
>  	dma_addr_t ccb_phys;
>  	int ccbsize;
>  
> -	ret = clk_enable(sdma->clk_ipg);
> -	if (ret)
> -		return ret;
> -	ret = clk_enable(sdma->clk_ahb);
> -	if (ret)
> -		goto disable_clk_ipg;
> -
>  	if (sdma->drvdata->check_ratio &&
>  	    (clk_get_rate(sdma->clk_ahb) == clk_get_rate(sdma->clk_ipg)))
>  		sdma->clk_ratio = 1;
> @@ -2180,15 +2153,9 @@ static int sdma_init(struct sdma_engine *sdma)
>  	/* Initializes channel's priorities */
>  	sdma_set_channel_priority(&sdma->channel[0], 7);
>  
> -	clk_disable(sdma->clk_ipg);
> -	clk_disable(sdma->clk_ahb);
> -
>  	return 0;
>  
>  err_dma_alloc:
> -	clk_disable(sdma->clk_ahb);
> -disable_clk_ipg:
> -	clk_disable(sdma->clk_ipg);
>  	dev_err(sdma->dev, "initialisation failed with %d\n", ret);
>  	return ret;
>  }
> @@ -2266,33 +2233,25 @@ static int sdma_probe(struct platform_device *pdev)
>  	if (IS_ERR(sdma->regs))
>  		return PTR_ERR(sdma->regs);
>  
> -	sdma->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
> +	sdma->clk_ipg = devm_clk_get_enabled(&pdev->dev, "ipg");
>  	if (IS_ERR(sdma->clk_ipg))
>  		return PTR_ERR(sdma->clk_ipg);
>  
> -	sdma->clk_ahb = devm_clk_get(&pdev->dev, "ahb");
> +	sdma->clk_ahb = devm_clk_get_enabled(&pdev->dev, "ahb");
>  	if (IS_ERR(sdma->clk_ahb))
>  		return PTR_ERR(sdma->clk_ahb);
>  
> -	ret = clk_prepare(sdma->clk_ipg);
> -	if (ret)
> -		return ret;
> -
> -	ret = clk_prepare(sdma->clk_ahb);
> -	if (ret)
> -		goto err_clk;
> -
>  	ret = devm_request_irq(&pdev->dev, irq, sdma_int_handler, 0,
>  				dev_name(&pdev->dev), sdma);
>  	if (ret)
> -		goto err_irq;
> +		return ret;
>  
>  	sdma->irq = irq;
>  
>  	sdma->script_addrs = kzalloc(sizeof(*sdma->script_addrs), GFP_KERNEL);
>  	if (!sdma->script_addrs) {
>  		ret = -ENOMEM;
> -		goto err_irq;
> +		return ret;
>  	}
>  
>  	/* initially no scripts available */
> @@ -2407,10 +2366,6 @@ static int sdma_probe(struct platform_device *pdev)
>  	dma_async_device_unregister(&sdma->dma_device);
>  err_init:
>  	kfree(sdma->script_addrs);
> -err_irq:
> -	clk_unprepare(sdma->clk_ahb);
> -err_clk:
> -	clk_unprepare(sdma->clk_ipg);
>  	return ret;
>  }
>  
> @@ -2422,8 +2377,6 @@ static void sdma_remove(struct platform_device *pdev)
>  	devm_free_irq(&pdev->dev, sdma->irq, sdma);
>  	dma_async_device_unregister(&sdma->dma_device);
>  	kfree(sdma->script_addrs);
> -	clk_unprepare(sdma->clk_ahb);
> -	clk_unprepare(sdma->clk_ipg);
>  	/* Kill the tasklet */
>  	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
>  		struct sdma_channel *sdmac = &sdma->channel[i];


