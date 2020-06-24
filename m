Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A986206F88
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2020 10:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387568AbgFXI7K (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jun 2020 04:59:10 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15545 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728732AbgFXI7I (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Jun 2020 04:59:08 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef3157f0000>; Wed, 24 Jun 2020 01:57:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 24 Jun 2020 01:59:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 24 Jun 2020 01:59:07 -0700
Received: from [10.26.73.205] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 24 Jun
 2020 08:59:01 +0000
Subject: Re: [PATCH] [v5] dmaengine: tegra210-adma: Fix runtime PM imbalance
 on error
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, <kjlu@umn.edu>
CC:     Laxman Dewangan <ldewangan@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200624064626.19855-1-dinghao.liu@zju.edu.cn>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <ff88aac0-3ba7-f8e5-7ea6-c77550bc936b@nvidia.com>
Date:   Wed, 24 Jun 2020 09:58:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624064626.19855-1-dinghao.liu@zju.edu.cn>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592989055; bh=KRUKpnItOq0WncTXpPUtQ2pqVUvwLgoZiV+ZoufP/1Y=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=XKluAPRSpjLoGzLPLu/+G9Ld/cD8H2ukgd9kRBkglFxIu6eN7b+NsxSGOktEUSafD
         6jL997xgojrnlvMxj1Tuci3g+kZGQDwun3bJfQsS9EUq0Agwc7yX+L2nTte/TE2Zjp
         Z8g3/q3xpIRBiYiHSbIEpdoNuRts4qvWUsU7g0Jtzm2H4fvjBbQo4jEVwbtEoyrj6L
         m9XjlZ19xmys1lNu2MHL8qRQSNIvlBtYahBT9NPhS5iLJ+LWImbbRhf7jmfMvk7DeK
         xeKegA1mbDdeQyRjl6hI8SLIRb3StImYMjalgLAHIw21UJd1c+hmnqkwNl+3XcKzTy
         czUgCPRg7QnKw==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 24/06/2020 07:46, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> when it returns an error code. Thus a pairing decrement is needed on
> the error handling path to keep the counter balanced.

I was hoping you would mention explicitly why we are using _noidle in
the changelog. However, let's not beat the dead horse any more and just
merge this. So ...

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks
Jon

> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
> 
> Changelog:
> 
> v2: - Merge two patches that fix runtime PM imbalance in
>       tegra_adma_probe() and tegra_adma_alloc_chan_resources()
>       respectively.
> 
> v3: - Use pm_runtime_put_noidle() instead of pm_runtime_put_sync()
>       in tegra_adma_alloc_chan_resources(). _noidle() is the simplest
>       one and it is sufficient for fixing this bug.
> 
> v4: - Use pm_runtime_put_noidle() instead of pm_runtime_put_sync()
>       in tegra_adma_probe(). _noidle() is the simplest one and it is
>       sufficient for fixing this bug.
> 
> v5: - Refine commit message.
> ---
>  drivers/dma/tegra210-adma.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index db58d7e4f9fe..c5fa2ef74abc 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -658,6 +658,7 @@ static int tegra_adma_alloc_chan_resources(struct dma_chan *dc)
>  
>  	ret = pm_runtime_get_sync(tdc2dev(tdc));
>  	if (ret < 0) {
> +		pm_runtime_put_noidle(tdc2dev(tdc));
>  		free_irq(tdc->irq, tdc);
>  		return ret;
>  	}
> @@ -869,8 +870,10 @@ static int tegra_adma_probe(struct platform_device *pdev)
>  	pm_runtime_enable(&pdev->dev);
>  
>  	ret = pm_runtime_get_sync(&pdev->dev);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(&pdev->dev);
>  		goto rpm_disable;
> +	}
>  
>  	ret = tegra_adma_init(tdma);
>  	if (ret)
> 

-- 
nvpublic
