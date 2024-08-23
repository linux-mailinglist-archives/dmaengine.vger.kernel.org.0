Return-Path: <dmaengine+bounces-2947-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7914995CBEE
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2024 14:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF35BB22336
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2024 12:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6BD18452B;
	Fri, 23 Aug 2024 12:01:22 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7754B183CDB;
	Fri, 23 Aug 2024 12:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414482; cv=none; b=VyzWrwUDK10s3IWeiZ4g8R0vLMc78/CT9cjndQ7PRivRG67V4UPaJSeoUJlY/er20pTHvciFOm3sQ4HH1/vQqnf6Sr7zN+QMcKDPkMUGwHLT0Bw4s9GgYF0gdpOWALEHnJyfPAMPFK/env5ph5VyU+B7lHuEItPs/OfOPqsjiyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414482; c=relaxed/simple;
	bh=6PpYxNS8qVA36ojjUbXHaYuk4vc2SmHCjKEs8RoPkDY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gLpwjrpoQpRTEEtQ2c3qT2aE6TRNRqRmbnHAjWgAqR6U2mcwke2Tkhafwvb49WPOKyuGktQjq3hvCy9OJDtq/qXHDXdSUVqCef5Kwa+2vPnXF6C62hGp8IrOSUYxl1SO8fYWLfph0K1lnQ3n2FxJYZ0ZbL9nh6Bt+uZCWFdpII0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wqz8Y2c24z6GBpb;
	Fri, 23 Aug 2024 19:57:33 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 57A781400DB;
	Fri, 23 Aug 2024 20:01:18 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 23 Aug
 2024 13:01:17 +0100
Date: Fri, 23 Aug 2024 13:01:17 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
CC: <vkoul@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] dma:dma-jz4780:Use devm_clk_get_enabled() helpers
Message-ID: <20240823130117.00007e25@Huawei.com>
In-Reply-To: <20240823101933.9517-3-liaoyuanhong@vivo.com>
References: <20240823101933.9517-1-liaoyuanhong@vivo.com>
	<20240823101933.9517-3-liaoyuanhong@vivo.com>
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

On Fri, 23 Aug 2024 18:19:29 +0800
Liao Yuanhong <liaoyuanhong@vivo.com> wrote:

> Use devm_clk_get_enabled() instead of clk functions in dma-jz4780.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
Original code has some odd ordering.  The error path order
and remove order should be the same and aren't.

Even with that tidied up this reorders clock disable and tasklet
killing. So I think this is fine, but needs more eyes on it.

> ---
>  drivers/dma/dma-jz4780.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
> index c9cfa341db51..151a85516419 100644
> --- a/drivers/dma/dma-jz4780.c
> +++ b/drivers/dma/dma-jz4780.c
> @@ -149,7 +149,6 @@ struct jz4780_dma_dev {
>  	struct dma_device dma_device;
>  	void __iomem *chn_base;
>  	void __iomem *ctrl_base;
> -	struct clk *clk;
>  	unsigned int irq;
>  	const struct jz4780_dma_soc_data *soc_data;
>  
> @@ -857,6 +856,7 @@ static int jz4780_dma_probe(struct platform_device *pdev)
>  	struct dma_device *dd;
>  	struct resource *res;
>  	int i, ret;
> +	struct clk *clk;
>  
>  	if (!dev->of_node) {
>  		dev_err(dev, "This driver must be probed from devicetree\n");
> @@ -896,15 +896,13 @@ static int jz4780_dma_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	jzdma->clk = devm_clk_get(dev, NULL);
> -	if (IS_ERR(jzdma->clk)) {
> +	clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(clk)) {
>  		dev_err(dev, "failed to get clock\n");
> -		ret = PTR_ERR(jzdma->clk);
> +		ret = PTR_ERR(clk);
>  		return ret;
>  	}
>  
> -	clk_prepare_enable(jzdma->clk);
> -
>  	/* Property is optional, if it doesn't exist the value will remain 0. */
>  	of_property_read_u32_index(dev->of_node, "ingenic,reserved-channels",
>  				   0, &jzdma->chan_reserved);
> @@ -972,7 +970,7 @@ static int jz4780_dma_probe(struct platform_device *pdev)
>  
>  	ret = platform_get_irq(pdev, 0);
>  	if (ret < 0)
> -		goto err_disable_clk;
> +		return ret;
>  
>  	jzdma->irq = ret;
>  
> @@ -980,7 +978,7 @@ static int jz4780_dma_probe(struct platform_device *pdev)
>  			  jzdma);
>  	if (ret) {
>  		dev_err(dev, "failed to request IRQ %u!\n", jzdma->irq);
> -		goto err_disable_clk;
> +		return ret;
>  	}
>  
>  	ret = dmaenginem_async_device_register(dd);
> @@ -1002,9 +1000,6 @@ static int jz4780_dma_probe(struct platform_device *pdev)
>  
>  err_free_irq:
>  	free_irq(jzdma->irq, jzdma);
> -
> -err_disable_clk:
> -	clk_disable_unprepare(jzdma->clk);
>  	return ret;
>  }
>  
> @@ -1015,7 +1010,6 @@ static void jz4780_dma_remove(struct platform_device *pdev)
>  
>  	of_dma_controller_free(pdev->dev.of_node);
>  
> -	clk_disable_unprepare(jzdma->clk);
>  	free_irq(jzdma->irq, jzdma);
Hmm. Ordering wise this is not great.

>  
>  	for (i = 0; i < jzdma->soc_data->nb_channels; i++)


