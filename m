Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D70E3151C92
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2020 15:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbgBDOvY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Feb 2020 09:51:24 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8010 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgBDOvX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Feb 2020 09:51:23 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3984dc0000>; Tue, 04 Feb 2020 06:51:08 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 04 Feb 2020 06:51:22 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 04 Feb 2020 06:51:22 -0800
Received: from [10.21.133.51] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Feb
 2020 14:51:20 +0000
Subject: Re: [PATCH v7 10/19] dmaengine: tegra-apb: Remove assumptions about
 unavailable runtime PM
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200202222854.18409-1-digetx@gmail.com>
 <20200202222854.18409-11-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <9671058d-6fe1-2d1b-9aca-3d943dafeb04@nvidia.com>
Date:   Tue, 4 Feb 2020 14:51:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200202222854.18409-11-digetx@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580827868; bh=YlB0hyncMtxlGcVgLfgkMbZcAfow8+8s3gntXqlFKj4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=l1lYopHxJTiQVZHrcoIoFS9qJz9QFl4Iru3uJPuZDnSVNC8uO8unKQBdKBXULfdMS
         jY8m9B3Bsi3ZBFw/zo12zaM2o2TCJeHRmwwchA+ji59PS4T4Nw4C39+iYZVPzpbNTK
         1un1yIfem1domNld3YOiyqa70T/gZH8ium8P9k3OSmPJCc5FMulz/QF8MimIdfM5YD
         WK28AKg/uxxpb1rKhaeJxMLamu2zEAVV4nyhkOha8512sTM4OS1yGjsk9pm42fboW7
         CTHItkJdPzzKhy6zO4IdA1V7AMI9YXdwGB7mLpvgOmnz90LilRAN73XqCdkaGtm9Tt
         bcKPoTltg8RnQ==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 02/02/2020 22:28, Dmitry Osipenko wrote:
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
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
