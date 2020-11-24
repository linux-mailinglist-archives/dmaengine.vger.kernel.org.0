Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651232C2E84
	for <lists+dmaengine@lfdr.de>; Tue, 24 Nov 2020 18:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390791AbgKXR2T (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Nov 2020 12:28:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:37782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728749AbgKXR2T (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Nov 2020 12:28:19 -0500
Received: from localhost (unknown [122.167.149.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DD24206F7;
        Tue, 24 Nov 2020 17:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606238898;
        bh=FSsQGN9s28M1af89fp7wMR+IUUPe0xlY7Oy+cTFL50Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oiiuroBPzCdSWH1kVzIYp7jRKhZo0+3fB80YGyQ+gjQHAyn8w7npNxsovRSlZ5a9X
         WLC6NBTf1C6j6Kix0SdBzCa/s7t4WKIYHtXw40oes+gPsg2KRQ1kHdbT3JdMC1QN1C
         4zqD7xwMWiyLS/3mtskEp05MGclbKgcgjaX+gv5o=
Date:   Tue, 24 Nov 2020 22:58:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     kernel@pengutronix.de, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: mxs-dma: Remove the unused .id_table
Message-ID: <20201124172812.GY8403@vkoul-mobl>
References: <20201123193051.17285-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123193051.17285-1-festevam@gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-11-20, 16:30, Fabio Estevam wrote:
> The mxs-dma driver is only used by DT platforms and the .id_table
> is unused.

Applied, thanks

> 
> Get rid of it to simplify the code.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  drivers/dma/mxs-dma.c | 37 +++++--------------------------------
>  1 file changed, 5 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
> index 65f816b40c32..994fc4d2aca4 100644
> --- a/drivers/dma/mxs-dma.c
> +++ b/drivers/dma/mxs-dma.c
> @@ -167,29 +167,11 @@ static struct mxs_dma_type mxs_dma_types[] = {
>  	}
>  };
>  
> -static const struct platform_device_id mxs_dma_ids[] = {
> -	{
> -		.name = "imx23-dma-apbh",
> -		.driver_data = (kernel_ulong_t) &mxs_dma_types[0],
> -	}, {
> -		.name = "imx23-dma-apbx",
> -		.driver_data = (kernel_ulong_t) &mxs_dma_types[1],
> -	}, {
> -		.name = "imx28-dma-apbh",
> -		.driver_data = (kernel_ulong_t) &mxs_dma_types[2],
> -	}, {
> -		.name = "imx28-dma-apbx",
> -		.driver_data = (kernel_ulong_t) &mxs_dma_types[3],
> -	}, {
> -		/* end of list */
> -	}
> -};
> -
>  static const struct of_device_id mxs_dma_dt_ids[] = {
> -	{ .compatible = "fsl,imx23-dma-apbh", .data = &mxs_dma_ids[0], },
> -	{ .compatible = "fsl,imx23-dma-apbx", .data = &mxs_dma_ids[1], },
> -	{ .compatible = "fsl,imx28-dma-apbh", .data = &mxs_dma_ids[2], },
> -	{ .compatible = "fsl,imx28-dma-apbx", .data = &mxs_dma_ids[3], },
> +	{ .compatible = "fsl,imx23-dma-apbh", .data = &mxs_dma_types[0], },
> +	{ .compatible = "fsl,imx23-dma-apbx", .data = &mxs_dma_types[1], },
> +	{ .compatible = "fsl,imx28-dma-apbh", .data = &mxs_dma_types[2], },
> +	{ .compatible = "fsl,imx28-dma-apbx", .data = &mxs_dma_types[3], },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, mxs_dma_dt_ids);
> @@ -762,8 +744,6 @@ static struct dma_chan *mxs_dma_xlate(struct of_phandle_args *dma_spec,
>  static int __init mxs_dma_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> -	const struct platform_device_id *id_entry;
> -	const struct of_device_id *of_id;
>  	const struct mxs_dma_type *dma_type;
>  	struct mxs_dma_engine *mxs_dma;
>  	struct resource *iores;
> @@ -779,13 +759,7 @@ static int __init mxs_dma_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	of_id = of_match_device(mxs_dma_dt_ids, &pdev->dev);
> -	if (of_id)
> -		id_entry = of_id->data;
> -	else
> -		id_entry = platform_get_device_id(pdev);
> -
> -	dma_type = (struct mxs_dma_type *)id_entry->driver_data;
> +	dma_type = (struct mxs_dma_type *)of_device_get_match_data(&pdev->dev);
>  	mxs_dma->type = dma_type->type;
>  	mxs_dma->dev_id = dma_type->id;
>  
> @@ -865,7 +839,6 @@ static struct platform_driver mxs_dma_driver = {
>  		.name	= "mxs-dma",
>  		.of_match_table = mxs_dma_dt_ids,
>  	},
> -	.id_table	= mxs_dma_ids,
>  };
>  
>  static int __init mxs_dma_module_init(void)
> -- 
> 2.17.1

-- 
~Vinod
