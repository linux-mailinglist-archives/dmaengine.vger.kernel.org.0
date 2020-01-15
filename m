Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D144213BCEC
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2020 10:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbgAOJ5t (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jan 2020 04:57:49 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2563 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbgAOJ5t (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Jan 2020 04:57:49 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1ee2080000>; Wed, 15 Jan 2020 01:57:28 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 15 Jan 2020 01:57:48 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 15 Jan 2020 01:57:48 -0800
Received: from [10.21.133.51] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Jan
 2020 09:57:45 +0000
Subject: Re: [PATCH v4 09/14] dmaengine: tegra-apb: Clean up runtime PM
 teardown
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200112173006.29863-1-digetx@gmail.com>
 <20200112173006.29863-10-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <9a5c4f82-5653-8d81-e304-76675aff5d8f@nvidia.com>
Date:   Wed, 15 Jan 2020 09:57:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200112173006.29863-10-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579082248; bh=zz/qU+cZAGvVsTNHrvVUkHRpZit86IKQXIet8SZGC3E=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=oN8OIJeXfJI5R42dB3Zmv1fPVyPb10M6sVEVnOnjgOVvEQfBRVL6GxasBQhVLDcw4
         7jtSnLOLYmcMWSqyEvuQzL2eLWFEOLX24elY27AuAupiST8VQtoDnjvF9rAvHkZ/TR
         P/AONv/v6Mafe7roi7BuM31Fli0iGcflijwY1CxwilZnsm9fMx5IvXTBvS+7rpFibQ
         FldMETisaWYj0sWfvJ9S3oyTBQ2gLtrqNLDYb1dXiURw5lRtpfmItGuRRJGoPOztfi
         l9ZoJuEsQzW+Scg99TSw/5ch7JMN3xkB7ilaHu/PzCCA3UCcCvtRdqSSnS87hDfqJn
         nyHX/WPXpYikg==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 12/01/2020 17:30, Dmitry Osipenko wrote:
> It's cleaner to teardown RPM by revering the enable sequence, which makes
> code much easier to follow.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/dma/tegra20-apb-dma.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index 7158bd3145c4..cc4a9ca20780 100644
> --- a/drivers/dma/tegra20-apb-dma.c
> +++ b/drivers/dma/tegra20-apb-dma.c
> @@ -1429,13 +1429,15 @@ static int tegra_dma_probe(struct platform_device *pdev)
>  	spin_lock_init(&tdma->global_lock);
>  
>  	pm_runtime_enable(&pdev->dev);
> -	if (!pm_runtime_enabled(&pdev->dev))
> +	if (!pm_runtime_enabled(&pdev->dev)) {
>  		ret = tegra_dma_runtime_resume(&pdev->dev);
> -	else
> +		if (ret)
> +			return ret;
> +	} else {
>  		ret = pm_runtime_get_sync(&pdev->dev);
> -
> -	if (ret < 0)
> -		goto err_pm_disable;
> +		if (ret < 0)
> +			goto err_pm_disable;
> +	}
>  
>  	/* Reset DMA controller */
>  	reset_control_assert(tdma->rst);
> @@ -1545,9 +1547,10 @@ static int tegra_dma_probe(struct platform_device *pdev)
>  	dma_async_device_unregister(&tdma->dma_dev);
>  
>  err_pm_disable:
> -	pm_runtime_disable(&pdev->dev);
> -	if (!pm_runtime_status_suspended(&pdev->dev))
> +	if (!pm_runtime_enabled(&pdev->dev))
>  		tegra_dma_runtime_suspend(&pdev->dev);
> +	else
> +		pm_runtime_disable(&pdev->dev);
>  
>  	return ret;
>  }
> @@ -1558,9 +1561,10 @@ static int tegra_dma_remove(struct platform_device *pdev)
>  
>  	dma_async_device_unregister(&tdma->dma_dev);
>  
> -	pm_runtime_disable(&pdev->dev);
> -	if (!pm_runtime_status_suspended(&pdev->dev))
> +	if (!pm_runtime_enabled(&pdev->dev))
>  		tegra_dma_runtime_suspend(&pdev->dev);
> +	else
> +		pm_runtime_disable(&pdev->dev);

Looks like dma_async_device_unregister() will warn if a client still has
a channel requested but does not prevent the unregister from completing.
So it could be possible that we could be leaving the controller active now.

Jon

-- 
nvpublic
