Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A67438F2D
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 08:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhJYGOz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 02:14:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229841AbhJYGOy (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 02:14:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1767A60F02;
        Mon, 25 Oct 2021 06:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635142353;
        bh=Eyk0/QdwLpez3FKx+3E7de9QeAfVV2V9Ch+6XzrvUZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eYmziX4j5TuXVhGhtIhsPPnR5gUqCohOyvqZxGi+Uu5umIX0sdpYwHGUPkMw8Ck4d
         82VVMFOm6iduRvUtFwUFtQTYNfcqrtPsO1eDW05/9BKpLzLwNBlCtPHjYZG8tFojT7
         IaudZWZo/GBlwBi++f4XiHbU+eeQ2mmDjlZa7JtII8PBHZZndb4ibwFa82uUnkGOnV
         EBQs1+0fw+KzcMqS5zyYKxb8IAZE8r4whMru4XtmAaA3xN1VIQJcY+3Do1hxvmDQGj
         LozKe04iLhC0+MWMxun7mIR96dB+mHZSje+S8JmKwkH78RnRbCd429Ln2xG5yD3HLY
         wFHi57TKivojg==
Date:   Mon, 25 Oct 2021 11:42:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Harini Katakam <harini.katakam@xilinx.com>
Cc:     romain.perier@gmail.com, allen.lkml@gmail.com, yukuai3@huawei.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, harinikatakamlinux@gmail.com,
        michal.simek@xilinx.com, radhey.shyam.pandey@xilinx.com,
        shravya.kumbham@xilinx.com
Subject: Re: [PATCH 3/4] dmaengine: zynqmp_dma: Add conditions for return
 value check
Message-ID: <YXZKzMmw9ga6hCcC@matsya>
References: <20210914082817.22311-1-harini.katakam@xilinx.com>
 <20210914082817.22311-4-harini.katakam@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914082817.22311-4-harini.katakam@xilinx.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-09-21, 13:58, Harini Katakam wrote:
> From: Shravya Kumbham <shravya.kumbham@xilinx.com>
> 
> Add condition to check the return value of dma_async_device_register
> and pm_runtime_get_sync functions.
> 
> Addresses-Coverity: Event check_return.
> Signed-off-by: Shravya Kumbham <shravya.kumbham@xilinx.com>

sob missing

> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> ---
>  drivers/dma/xilinx/zynqmp_dma.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
> index d28b9ffb4309..588460e56ab8 100644
> --- a/drivers/dma/xilinx/zynqmp_dma.c
> +++ b/drivers/dma/xilinx/zynqmp_dma.c
> @@ -1080,7 +1080,11 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
>  	pm_runtime_set_autosuspend_delay(zdev->dev, ZDMA_PM_TIMEOUT);
>  	pm_runtime_use_autosuspend(zdev->dev);
>  	pm_runtime_enable(zdev->dev);
> -	pm_runtime_get_sync(zdev->dev);
> +	ret = pm_runtime_get_sync(zdev->dev);
> +	if (ret < 0) {
> +		dev_err(zdev->dev, "pm_runtime_get_sync() failed\n");
> +		pm_runtime_disable(zdev->dev);

disable is okay but it wont fix the count, you should call put and then
disable if required

> +	}
>  	if (!pm_runtime_enabled(zdev->dev)) {
>  		ret = zynqmp_dma_runtime_resume(zdev->dev);
>  		if (ret)
> @@ -1096,7 +1100,11 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
>  	p->dst_addr_widths = BIT(zdev->chan->bus_width / 8);
>  	p->src_addr_widths = BIT(zdev->chan->bus_width / 8);
>  
> -	dma_async_device_register(&zdev->common);
> +	ret = dma_async_device_register(&zdev->common);
> +	if (ret) {
> +		dev_err(zdev->dev, "failed to register the dma device\n");
> +		goto free_chan_resources;
> +	}
>  
>  	ret = of_dma_controller_register(pdev->dev.of_node,
>  					 of_zynqmp_dma_xlate, zdev);
> -- 
> 2.17.1

-- 
~Vinod
