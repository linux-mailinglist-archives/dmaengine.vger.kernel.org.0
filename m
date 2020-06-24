Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8A4206DEB
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2020 09:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389844AbgFXHkT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jun 2020 03:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389583AbgFXHkT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Jun 2020 03:40:19 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CC7F206E2;
        Wed, 24 Jun 2020 07:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592984419;
        bh=o/fY5o8l3XzcwfN68Ui0RNm993lL6busdrWA2kWSPmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d37aL8ZJa79rDa/qeKgRVhGdn06DVd1IKAaH+VR6AMLLeB/CwI7sbIUVZp+6/eBVz
         wTdzu0d5M/eomjUo/ARHtVANB1s0XrLnVmFrNJsfYm28zZDGwQgL54Nn8jr76Q/plN
         4Vf3dZpGwaPZv2tKdOyru/hCvQogy7+Yk9gZ9mKI=
Date:   Wed, 24 Jun 2020 13:10:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu
Subject: Re: [PATCH] dmaengine: stm32-dmamux: fix pm_runtime_get_sync fialure
 cases
Message-ID: <20200624074015.GP2324254@vkoul-mobl>
References: <20200603193648.19190-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603193648.19190-1-navid.emamdoost@gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-06-20, 14:36, Navid Emamdoost wrote:

s/fialure/failure

> Calling pm_runtime_get_sync increments the counter even in case of
> failure, causing incorrect ref count. Call pm_runtime_put_sync if
> pm_runtime_get_sync fails.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/dma/stm32-dmamux.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/stm32-dmamux.c b/drivers/dma/stm32-dmamux.c
> index 12f7637e13a1..ab250d7eed29 100644
> --- a/drivers/dma/stm32-dmamux.c
> +++ b/drivers/dma/stm32-dmamux.c
> @@ -140,6 +140,7 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
>  	ret = pm_runtime_get_sync(&pdev->dev);
>  	if (ret < 0) {
>  		spin_unlock_irqrestore(&dmamux->lock, flags);
> +		pm_runtime_put_sync(&pdev->dev);

why put_sync()

>  		goto error;
>  	}
>  	spin_unlock_irqrestore(&dmamux->lock, flags);
> @@ -340,8 +341,10 @@ static int stm32_dmamux_suspend(struct device *dev)
>  	int i, ret;
>  
>  	ret = pm_runtime_get_sync(dev);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		pm_runtime_put_sync(dev);

here too

>  		return ret;
> +	}
>  
>  	for (i = 0; i < stm32_dmamux->dma_requests; i++)
>  		stm32_dmamux->ccr[i] = stm32_dmamux_read(stm32_dmamux->iomem,
> -- 
> 2.17.1

-- 
~Vinod
