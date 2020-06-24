Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB87206DE7
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2020 09:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389789AbgFXHjh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jun 2020 03:39:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389583AbgFXHjh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Jun 2020 03:39:37 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4A2B206E2;
        Wed, 24 Jun 2020 07:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592984376;
        bh=8jDjWnLW/FFZI3XS5aeybGak7b73D3MKBl8isxyOXsU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VkKK6reH+MS6Axa7CgTPj8Y1fc71ufcxFrtM+XOSGNURxVsX4MN1HoqSkc84Z2jR2
         P6SEz6rkALPwTsG5FzyUxErLRmAa3cyvV0Cb/Eww4Snvm+jPeXE56BzOvx0CUKflAF
         CWkLutlXs90qbZO+W0S8RzD+VfuWNiODyiY7jMJw=
Date:   Wed, 24 Jun 2020 13:09:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu
Subject: Re: [PATCH] engine: stm32-dma: call pm_runtime_put if
 pm_runtime_get_sync fails
Message-ID: <20200624073932.GO2324254@vkoul-mobl>
References: <20200603183410.76764-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603183410.76764-1-navid.emamdoost@gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-06-20, 13:34, Navid Emamdoost wrote:
> Calling pm_runtime_get_sync increments the counter even in case of
> failure, causing incorrect ref count. Call pm_runtime_put if
> pm_runtime_get_sync fails.

pls fix subsystem name as dmaengine: ...
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/dma/stm32-dma.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
> index 0ddbaa4b4f0b..0aab86bd97fe 100644
> --- a/drivers/dma/stm32-dma.c
> +++ b/drivers/dma/stm32-dma.c
> @@ -1169,8 +1169,10 @@ static int stm32_dma_alloc_chan_resources(struct dma_chan *c)
>  	chan->config_init = false;
>  
>  	ret = pm_runtime_get_sync(dmadev->ddev.dev);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		pm_runtime_put(dmadev->ddev.dev);
>  		return ret;
> +	}
>  
>  	ret = stm32_dma_disable_chan(chan);
>  	if (ret < 0)
> @@ -1439,8 +1441,10 @@ static int stm32_dma_suspend(struct device *dev)
>  	int id, ret, scr;
>  
>  	ret = pm_runtime_get_sync(dev);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		pm_runtime_put_sync(dev);

why put_sync()
>  		return ret;
> +	}
>  
>  	for (id = 0; id < STM32_DMA_MAX_CHANNELS; id++) {
>  		scr = stm32_dma_read(dmadev, STM32_DMA_SCR(id));
> -- 
> 2.17.1

-- 
~Vinod
