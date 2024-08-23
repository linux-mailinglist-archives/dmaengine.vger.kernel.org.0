Return-Path: <dmaengine+bounces-2948-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 628BA95CC08
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2024 14:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E4CF2846D5
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2024 12:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2CC16D33F;
	Fri, 23 Aug 2024 12:07:07 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6A3183CD9;
	Fri, 23 Aug 2024 12:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414827; cv=none; b=ShdNwJVMt8DieQ3rn2vl0lbJOOugzuXNi06ZlHkKN4KtitY686AEvOiO2cUzk+UzozNWIXCx+xJzcOSIcU1cgL3l4A/v8dgMJ+HA2fNZ0CXYMfWX5C9uIYeaTczEAkS455EyGTuEN0Fdje9mP2Lv+MdXu5g9Yq+ETsAtJWe/Q1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414827; c=relaxed/simple;
	bh=D3yKVFJHRjCo+h2Wmva6B0U7vTuDz3ZLroD2abWNKYA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8I3VM4jZ/IRGZJ2XoEJebRyPArJ1irT3ucekkWkVs/M6GspwwaUXUQIw5HgwrKhmyjAQSMOR1Vfcfivphh73oByMyYU1zKmS4zPPQcfEmJ2g1DWwwLTk2zaLghcERoQnOzHzIPtlZodEMOujZdmowCB+gdnaqHg6US9a877L0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WqzH85xDmz6G9Kd;
	Fri, 23 Aug 2024 20:03:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id CF335140594;
	Fri, 23 Aug 2024 20:07:01 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 23 Aug
 2024 13:07:01 +0100
Date: Fri, 23 Aug 2024 13:07:00 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
CC: <vkoul@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] dma:imx-dma:Use devm_clk_get_enabled() helpers
Message-ID: <20240823130700.00001d6d@Huawei.com>
In-Reply-To: <20240823101933.9517-4-liaoyuanhong@vivo.com>
References: <20240823101933.9517-1-liaoyuanhong@vivo.com>
	<20240823101933.9517-4-liaoyuanhong@vivo.com>
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

On Fri, 23 Aug 2024 18:19:30 +0800
Liao Yuanhong <liaoyuanhong@vivo.com> wrote:

> Use devm_clk_get_enabled() instead of clk functions in imx-dma.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
Straight forward case, but nice to combine this with
use of return dev_err_probe() in the paths where you now have
direct returns.  Other comments below.

 
> ---
>  drivers/dma/imx-dma.c | 38 +++++++++++++-------------------------
>  1 file changed, 13 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
> index ebf7c115d553..1ef926304d0e 100644
> --- a/drivers/dma/imx-dma.c
> +++ b/drivers/dma/imx-dma.c
> @@ -1039,6 +1039,8 @@ static int __init imxdma_probe(struct platform_device *pdev)
>  	struct imxdma_engine *imxdma;
>  	int ret, i;
>  	int irq, irq_err;
> +	struct clk *dma_ahb;
> +	struct clk *dma_ipg;
	struct clk *dma_ahb, *dma_ipg;
should be fine.
>  
>  	imxdma = devm_kzalloc(&pdev->dev, sizeof(*imxdma), GFP_KERNEL);
>  	if (!imxdma)
> @@ -1055,20 +1057,13 @@ static int __init imxdma_probe(struct platform_device *pdev)
>  	if (irq < 0)
>  		return irq;
>  
> -	imxdma->dma_ipg = devm_clk_get(&pdev->dev, "ipg");
> -	if (IS_ERR(imxdma->dma_ipg))
> -		return PTR_ERR(imxdma->dma_ipg);
> +	dma_ipg = devm_clk_get_enabled(&pdev->dev, "ipg");
> +	if (IS_ERR(dma_ipg))
> +		return PTR_ERR(dma_ipg);
>  
> -	imxdma->dma_ahb = devm_clk_get(&pdev->dev, "ahb");
> -	if (IS_ERR(imxdma->dma_ahb))
> -		return PTR_ERR(imxdma->dma_ahb);
> -
> -	ret = clk_prepare_enable(imxdma->dma_ipg);
> -	if (ret)
> -		return ret;
> -	ret = clk_prepare_enable(imxdma->dma_ahb);
> -	if (ret)
> -		goto disable_dma_ipg_clk;
> +	dma_ahb = devm_clk_get_enabled(&pdev->dev, "ahb");
> +	if (IS_ERR(dma_ahb))
> +		return PTR_ERR(dma_ahb);
>  
>  	/* reset DMA module */
>  	imx_dmav1_writel(imxdma, DCR_DRST, DMA_DCR);
> @@ -1078,21 +1073,21 @@ static int __init imxdma_probe(struct platform_device *pdev)
>  				       dma_irq_handler, 0, "DMA", imxdma);
>  		if (ret) {
>  			dev_warn(imxdma->dev, "Can't register IRQ for DMA\n");
> -			goto disable_dma_ahb_clk;
> +			return ret;
Odd not to make that a dev_error given driver fails to probe as a result.
I'd switch to return dev_err_rpobe()
>  		}
>  		imxdma->irq = irq;
>  
>  		irq_err = platform_get_irq(pdev, 1);
>  		if (irq_err < 0) {
>  			ret = irq_err;
> -			goto disable_dma_ahb_clk;
> +			return ret;
>  		}
>  
>  		ret = devm_request_irq(&pdev->dev, irq_err,
>  				       imxdma_err_handler, 0, "DMA", imxdma);
>  		if (ret) {
>  			dev_warn(imxdma->dev, "Can't register ERRIRQ for DMA\n");
> -			goto disable_dma_ahb_clk;
> +			return ret;
Here as well.

>  		}
>  		imxdma->irq_err = irq_err;
>  	}
> @@ -1130,7 +1125,7 @@ static int __init imxdma_probe(struct platform_device *pdev)
>  				dev_warn(imxdma->dev, "Can't register IRQ %d "
>  					 "for DMA channel %d\n",
>  					 irq + i, i);
> -				goto disable_dma_ahb_clk;
> +				return ret;
and here.

>  			}
>  
>  			imxdmac->irq = irq + i;
> @@ -1174,7 +1169,7 @@ static int __init imxdma_probe(struct platform_device *pdev)
>  	ret = dma_async_device_register(&imxdma->dma_device);
>  	if (ret) {
>  		dev_err(&pdev->dev, "unable to register\n");
> -		goto disable_dma_ahb_clk;
> +		return ret;
and finaly here.

>  	}
>  
>  	if (pdev->dev.of_node) {
> @@ -1190,10 +1185,6 @@ static int __init imxdma_probe(struct platform_device *pdev)
>  
>  err_of_dma_controller:
>  	dma_async_device_unregister(&imxdma->dma_device);
Maybe use a local callback and 
devm_add_action_or_reset() to get automate handling of this call as well.

> -disable_dma_ahb_clk:
> -	clk_disable_unprepare(imxdma->dma_ahb);
> -disable_dma_ipg_clk:
> -	clk_disable_unprepare(imxdma->dma_ipg);
>  	return ret;
>  }
>  
> @@ -1226,9 +1217,6 @@ static void imxdma_remove(struct platform_device *pdev)
>  
>  	if (pdev->dev.of_node)
>  		of_dma_controller_free(pdev->dev.of_node);
The ordering of the two items above here looks suspicious as it doesn't
reverse order of probably. Maybe worth cleaning that up whilst here.

> -
> -	clk_disable_unprepare(imxdma->dma_ipg);
> -	clk_disable_unprepare(imxdma->dma_ahb);
>  }
>  
>  static struct platform_driver imxdma_driver = {


