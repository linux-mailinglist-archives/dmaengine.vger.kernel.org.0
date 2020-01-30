Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21C9514DC7E
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 15:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgA3OJJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jan 2020 09:09:09 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15367 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgA3OJJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jan 2020 09:09:09 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e32e3500000>; Thu, 30 Jan 2020 06:08:16 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 30 Jan 2020 06:09:08 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 30 Jan 2020 06:09:08 -0800
Received: from [10.26.11.91] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 30 Jan
 2020 14:09:05 +0000
Subject: Re: [PATCH v6 10/16] dmaengine: tegra-apb: Remove assumptions about
 unavailable runtime PM
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200130043804.32243-1-digetx@gmail.com>
 <20200130043804.32243-11-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <24ca0a86-032f-2686-4dd2-6e4c5cf60223@nvidia.com>
Date:   Thu, 30 Jan 2020 14:09:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200130043804.32243-11-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580393296; bh=KJgXa4zfX87+bxWY3bif1JVu28xO50calGRRSABfXWc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ToaKl1X/Fed8Dfu6I3GsF5ou1UjrEaoqwLc5ltxew+2d/s8BIzWQYgFye5SQjBHqz
         rrU6c7IVSfn3QlhXTgshO7b62h0Kdz4jC2NVlrtq/Qdvrsdu+050NDL5YWjKxclWQ7
         UN9YrVKi/f6MbdCIdwHt/WN6xMDRbjSqkC4NG34107W6RLSGXINZllIMoa7YmMkGBb
         L8R8FTjI1R/E9GgjY3QVXLdR4aV894hdGuxx+y5xdpehizw6GudWrRHUO6raXqI83A
         qu2HGsJ/LAyd8Fj3adBTh0+190tQs1Rce3k3AeE2IkrN0MYmo6226JJ6AlYcPIhsSu
         ZWrOYw7+XI+Vw==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 30/01/2020 04:37, Dmitry Osipenko wrote:
> The runtime PM is always available on all Tegra SoCs since the commit
> 40b2bb1b132a ("ARM: tegra: enforce PM requirement"), so there is no
> need to handle the case of unavailable RPM in the code anymore.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/dma/tegra20-apb-dma.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index 7158bd3145c4..22b88ccff05d 100644
> --- a/drivers/dma/tegra20-apb-dma.c
> +++ b/drivers/dma/tegra20-apb-dma.c
> @@ -1429,11 +1429,8 @@ static int tegra_dma_probe(struct platform_device *pdev)
>  	spin_lock_init(&tdma->global_lock);
>  
>  	pm_runtime_enable(&pdev->dev);
> -	if (!pm_runtime_enabled(&pdev->dev))
> -		ret = tegra_dma_runtime_resume(&pdev->dev);
> -	else
> -		ret = pm_runtime_get_sync(&pdev->dev);
>  
> +	ret = pm_runtime_get_sync(&pdev->dev);
>  	if (ret < 0)
>  		goto err_pm_disable;
>  
> @@ -1546,8 +1543,6 @@ static int tegra_dma_probe(struct platform_device *pdev)
>  
>  err_pm_disable:
>  	pm_runtime_disable(&pdev->dev);
> -	if (!pm_runtime_status_suspended(&pdev->dev))
> -		tegra_dma_runtime_suspend(&pdev->dev);
>  
>  	return ret;
>  }
> @@ -1557,10 +1552,7 @@ static int tegra_dma_remove(struct platform_device *pdev)
>  	struct tegra_dma *tdma = platform_get_drvdata(pdev);
>  
>  	dma_async_device_unregister(&tdma->dma_dev);
> -
>  	pm_runtime_disable(&pdev->dev);
> -	if (!pm_runtime_status_suspended(&pdev->dev))
> -		tegra_dma_runtime_suspend(&pdev->dev);
>  
>  	return 0;
>  }

I wonder if we need to make the pm_runtime_put a pm_runtime_put_sync or
call pm_runtime_barrier() here, to ensure it has called the callback
when freeing the channel? Otherwise this is fine.

Jon

-- 
nvpublic
