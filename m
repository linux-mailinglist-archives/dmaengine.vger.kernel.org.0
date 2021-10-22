Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAECD4371D6
	for <lists+dmaengine@lfdr.de>; Fri, 22 Oct 2021 08:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhJVGib (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Oct 2021 02:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhJVGib (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Oct 2021 02:38:31 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AC5C061764;
        Thu, 21 Oct 2021 23:36:14 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 512632BA;
        Fri, 22 Oct 2021 08:36:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1634884571;
        bh=U0FboxTA05+7tjiLG4A0dtnQ8ZEIufZXGq7gnRwqHfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ItsoRW+YZGu9L4r6FrQktDN4gkFX/Nlyd/U8K/sQNqUdl3XeKmREGHLA4iFDPDS8x
         sA0JkVV2/zkKulOopLxLzeTszBdYcfmlwxAncG0ew6Ppd12imPm+j4S47oC7ir8/5S
         YCs8SQJO7QLyy7SfNz9kIsnoNv+vIDlx6Q/9KfVI=
Date:   Fri, 22 Oct 2021 09:35:52 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Zou Wei <zou_wei@huawei.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: rcar-dmac: refactor the error handling code
 of rcar_dmac_probe
Message-ID: <YXJbyF3cY7cPpYsi@pendragon.ideasonboard.com>
References: <20211020143546.3436205-1-mudongliangabcd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211020143546.3436205-1-mudongliangabcd@gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Dongliang,

Thank you for the patch.

On Wed, Oct 20, 2021 at 10:35:33PM +0800, Dongliang Mu wrote:
> In rcar_dmac_probe, if pm_runtime_resume_and_get fails, it forgets to
> disable runtime PM. And of_dma_controller_free should only be invoked
> after the success of of_dma_controller_register.
> 
> Fix this by refactoring the error handling code.
> 
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/dma/sh/rcar-dmac.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> index 6885b3dcd7a9..5c7716fd6bc5 100644
> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -1916,7 +1916,7 @@ static int rcar_dmac_probe(struct platform_device *pdev)
>  	ret = pm_runtime_resume_and_get(&pdev->dev);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "runtime PM get sync failed (%d)\n", ret);
> -		return ret;
> +		goto err_pm_disable;
>  	}
>  
>  	ret = rcar_dmac_init(dmac);
> @@ -1924,7 +1924,7 @@ static int rcar_dmac_probe(struct platform_device *pdev)
>  
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to reset device\n");
> -		goto error;
> +		goto err_pm_disable;
>  	}
>  
>  	/* Initialize engine */
> @@ -1958,14 +1958,14 @@ static int rcar_dmac_probe(struct platform_device *pdev)
>  	for_each_rcar_dmac_chan(i, dmac, chan) {
>  		ret = rcar_dmac_chan_probe(dmac, chan);
>  		if (ret < 0)
> -			goto error;
> +			goto err_pm_disable;
>  	}
>  
>  	/* Register the DMAC as a DMA provider for DT. */
>  	ret = of_dma_controller_register(pdev->dev.of_node, rcar_dmac_of_xlate,
>  					 NULL);
>  	if (ret < 0)
> -		goto error;
> +		goto err_pm_disable;
>  
>  	/*
>  	 * Register the DMA engine device.
> @@ -1974,12 +1974,13 @@ static int rcar_dmac_probe(struct platform_device *pdev)
>  	 */
>  	ret = dma_async_device_register(engine);
>  	if (ret < 0)
> -		goto error;
> +		goto err_dma_free;
>  
>  	return 0;
>  
> -error:
> +err_dma_free:
>  	of_dma_controller_free(pdev->dev.of_node);
> +err_pm_disable:
>  	pm_runtime_disable(&pdev->dev);
>  	return ret;
>  }

-- 
Regards,

Laurent Pinchart
