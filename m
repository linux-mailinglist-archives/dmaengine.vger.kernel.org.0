Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B8B1FCF5D
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2020 16:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgFQOUk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 Jun 2020 10:20:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgFQOUj (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 17 Jun 2020 10:20:39 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 422B3206D8;
        Wed, 17 Jun 2020 14:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592403639;
        bh=es6gd2lpsks8Rqxa3Nt/7/Rb1b/bXmRiwKWOAkQ+yUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ODe0yVNs1KAQ24D2fWezug19Zyymep+xR8TF1FcTpbNVqLUdjMgVBPdErhwB1PGVt
         XoUp/nNr8I/FTob6H+IT1jdITFJTGr4F3NnlnibYRuUW2L0B0TqAQQfUlXcdcDGWL9
         nQ3kRmTKdjptrjw5vaS87DWApeYOeRShztwnzsaA=
Date:   Wed, 17 Jun 2020 19:50:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] dmaengine: tegra210-adma: Fix runtime PM imbalance
 on error
Message-ID: <20200617142034.GW2324254@vkoul-mobl>
References: <20200522114824.8554-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522114824.8554-1-dinghao.liu@zju.edu.cn>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-05-20, 19:48, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> when it returns an error code. Thus a pairing decrement is needed on
> the error handling path to keep the counter balanced.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
> 
> Changelog:
> 
> v2: - Merge two patches that fix runtime PM imbalance in
>       tegra_adma_probe() and tegra_adma_alloc_chan_resources()
>       respectively.
> ---
>  drivers/dma/tegra210-adma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index c4ce5dfb149b..2d6e419b6eac 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -658,6 +658,7 @@ static int tegra_adma_alloc_chan_resources(struct dma_chan *dc)
>  
>  	ret = pm_runtime_get_sync(tdc2dev(tdc));
>  	if (ret < 0) {
> +		pm_runtime_put_sync(tdc2dev(tdc));

Pls dont use _sync() here

>  		free_irq(tdc->irq, tdc);
>  		return ret;
>  	}
> @@ -870,7 +871,7 @@ static int tegra_adma_probe(struct platform_device *pdev)
>  
>  	ret = pm_runtime_get_sync(&pdev->dev);
>  	if (ret < 0)
> -		goto rpm_disable;
> +		goto rpm_put;
>  
>  	ret = tegra_adma_init(tdma);
>  	if (ret)
> @@ -921,7 +922,6 @@ static int tegra_adma_probe(struct platform_device *pdev)
>  	dma_async_device_unregister(&tdma->dma_dev);
>  rpm_put:
>  	pm_runtime_put_sync(&pdev->dev);
> -rpm_disable:
>  	pm_runtime_disable(&pdev->dev);
>  irq_dispose:
>  	while (--i >= 0)
> -- 
> 2.17.1

-- 
~Vinod
