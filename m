Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7C3416142
	for <lists+dmaengine@lfdr.de>; Thu, 23 Sep 2021 16:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241680AbhIWOmI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Sep 2021 10:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241698AbhIWOmH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Sep 2021 10:42:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395B8C061574
        for <dmaengine@vger.kernel.org>; Thu, 23 Sep 2021 07:40:35 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1mTPti-0001xl-9G; Thu, 23 Sep 2021 16:40:26 +0200
Received: from mtr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1mTPth-0001lR-0r; Thu, 23 Sep 2021 16:40:25 +0200
Date:   Thu, 23 Sep 2021 16:40:25 +0200
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Harini Katakam <harini.katakam@xilinx.com>
Cc:     vkoul@kernel.org, romain.perier@gmail.com, allen.lkml@gmail.com,
        yukuai3@huawei.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        harinikatakamlinux@gmail.com, michal.simek@xilinx.com,
        radhey.shyam.pandey@xilinx.com, shravya.kumbham@xilinx.com,
        kernel@pengutronix.de
Subject: Re: [PATCH 3/4] dmaengine: zynqmp_dma: Add conditions for return
 value check
Message-ID: <20210923144025.GC30905@pengutronix.de>
References: <20210914082817.22311-1-harini.katakam@xilinx.com>
 <20210914082817.22311-4-harini.katakam@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210914082817.22311-4-harini.katakam@xilinx.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 16:32:19 up 217 days, 17:56, 113 users,  load average: 0.19, 0.24,
 0.20
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 14 Sep 2021 13:58:16 +0530, Harini Katakam wrote:
> From: Shravya Kumbham <shravya.kumbham@xilinx.com>
> 
> Add condition to check the return value of dma_async_device_register
> and pm_runtime_get_sync functions.
> 
> Addresses-Coverity: Event check_return.
> Signed-off-by: Shravya Kumbham <shravya.kumbham@xilinx.com>
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
> +	}

Thanks for the patch.

You need to call pm_runtime_put() on the error path. Or you could use
pm_runtime_resume_and_get(), which does this automatically.

I am wondering, if it wouldn't be cleaner to make this dependent on
pm_runtime_enabled() and avoiding pm_runtime_disable() on the error path
altogether.

Michael

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
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
