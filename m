Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035B3395628
	for <lists+dmaengine@lfdr.de>; Mon, 31 May 2021 09:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhEaHfU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 May 2021 03:35:20 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:41314 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhEaHfS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 May 2021 03:35:18 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A2CC38A1;
        Mon, 31 May 2021 09:33:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1622446417;
        bh=QV2di8bMFCT6TQbdHb9uCxp+ZShAB+swwpLoWysFISw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kPi8jEOTPd8cY7Wx2+KPAk9D4Cx1Fsdvo2cSyc/dY4PGYk8sfUQARLD0SjYye3Zxr
         FJmDA2122y0wh3/Ate4b3E0NaijzFQ2++0oattA4wvHqUhZduwfvmvgrH7KELeszEp
         OWyLXo7lA56b3ScyewLsAdrtLj8xVnVpPndwaluA=
Date:   Mon, 31 May 2021 10:33:27 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     vkoul@kernel.org, yoshihiro.shimoda.uh@renesas.com,
        geert+renesas@glider.be, wsa+renesas@sang-engineering.com,
        robin.murphy@arm.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] dmaengine: rcar-dmac: Fix PM reference leak in
 rcar_dmac_probe()
Message-ID: <YLSRR7kHZF+fj7k4@pendragon.ideasonboard.com>
References: <1622442963-54095-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1622442963-54095-1-git-send-email-zou_wei@huawei.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Zou,

Thank you for the patch.

On Mon, May 31, 2021 at 02:36:03PM +0800, Zou Wei wrote:
> pm_runtime_get_sync will increment pm usage counter even it failed.
> Forgetting to putting operation will result in reference leak here.
> Fix it by replacing it with pm_runtime_resume_and_get to keep usage
> counter balanced.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/dma/sh/rcar-dmac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> index d530c1b..6885b3d 100644
> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -1913,7 +1913,7 @@ static int rcar_dmac_probe(struct platform_device *pdev)
>  
>  	/* Enable runtime PM and initialize the device. */
>  	pm_runtime_enable(&pdev->dev);
> -	ret = pm_runtime_get_sync(&pdev->dev);
> +	ret = pm_runtime_resume_and_get(&pdev->dev);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "runtime PM get sync failed (%d)\n", ret);
>  		return ret;

-- 
Regards,

Laurent Pinchart
