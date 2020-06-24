Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0D7206E1E
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2020 09:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390133AbgFXHqR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jun 2020 03:46:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389948AbgFXHqR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Jun 2020 03:46:17 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DFFF20874;
        Wed, 24 Jun 2020 07:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592984777;
        bh=Pqvog+kc4WzGeG+jHR1QQdfOtKiGAH+Ios6F59XvbQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TZsT3ySZDW0LMtJpGzvg+4Fl8S+NyPsoQC/i70Ntirwdan/z//IH8ph1ANhyMctlG
         NFo04JeMLcMP2Apt1SAHCWUy2OdGFs8rlqcWmhqJoHvQVQGU46XpUdWwA36LzEfyBQ
         ANtdxTKJU7fH9TZ99SaTNnEg2mBG52JQIggjrgSI=
Date:   Wed, 24 Jun 2020 13:16:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu
Subject: Re: [PATCH] dmaengine: stm32-mdma: call pm_runtime_put if
 pm_runtime_get_sync fails
Message-ID: <20200624074613.GS2324254@vkoul-mobl>
References: <20200603182850.66692-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603182850.66692-1-navid.emamdoost@gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-06-20, 13:28, Navid Emamdoost wrote:
> Calling pm_runtime_get_sync increments the counter even in case of
> failure, causing incorrect ref count. Call pm_runtime_put if
> pm_runtime_get_sync fails.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/dma/stm32-mdma.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
> index 5469563703d1..79bee1bb73f6 100644
> --- a/drivers/dma/stm32-mdma.c
> +++ b/drivers/dma/stm32-mdma.c
> @@ -1449,8 +1449,10 @@ static int stm32_mdma_alloc_chan_resources(struct dma_chan *c)
>  	}
>  
>  	ret = pm_runtime_get_sync(dmadev->ddev.dev);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		pm_runtime_put(dmadev->ddev.dev);
>  		return ret;
> +	}
>  
>  	ret = stm32_mdma_disable_chan(chan);
>  	if (ret < 0)
> @@ -1718,8 +1720,10 @@ static int stm32_mdma_pm_suspend(struct device *dev)
>  	int ret;
>  
>  	ret = pm_runtime_get_sync(dev);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		pm_runtime_put_sync(dev);

Not put_sync()...

>  		return ret;
> +	}
>  
>  	for (id = 0; id < dmadev->nr_channels; id++) {
>  		ccr = stm32_mdma_read(dmadev, STM32_MDMA_CCR(id));
> -- 
> 2.17.1

-- 
~Vinod
