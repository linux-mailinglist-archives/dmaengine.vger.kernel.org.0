Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E753F1EE99A
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jun 2020 19:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbgFDRnc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 4 Jun 2020 13:43:32 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3723 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729998AbgFDRnc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 4 Jun 2020 13:43:32 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed932610001>; Thu, 04 Jun 2020 10:41:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 04 Jun 2020 10:43:31 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 04 Jun 2020 10:43:31 -0700
Received: from [10.26.72.155] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Jun
 2020 17:43:25 +0000
Subject: Re: [PATCH] dmaengine: tegra210-adma: fix pm_runtime_get_sync failure
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <emamd001@umn.edu>, <wu000273@umn.edu>, <kjlu@umn.edu>,
        <smccaman@umn.edu>
References: <20200603183845.91054-1-navid.emamdoost@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <eb3e65fa-0ab6-a448-e5c8-e95561b6e4e9@nvidia.com>
Date:   Thu, 4 Jun 2020 18:43:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200603183845.91054-1-navid.emamdoost@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1591292513; bh=ZHcZTR0+Fn9VncgxZEaHqLU+bBLnTpMfnNu+8OCdCzs=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=qz4+VFqIzmYTK/IU8ojHSoNULssifQRbkr0G1WTnRjv5lhh+EWgXrXwQaMupgYwNb
         RVrUAupngeAoB4sH8wGv281nV51HhZhNLNuxRvhgO0lnvNfIvOHMe8PZBOX3S0syJ6
         GySvJWmE0cxwildAuNWQn6W2eHp/DJmlTAr8wEj2Y2iNgUP+b1rpVf0/uqftg3sVIj
         Up5x7X8NGwfr1AUpGCUefXN2xpe8bM5EgXD8gpRcf5500Fn/wGDmqO9JJ8BoPcsyMb
         N1XK8rqZifrR/sWM6I9kNwRDlGH9ePhghPJR1JPhbaNtyS7nuqgxzZJh+PNPKyJq7c
         sYj8CMSQgl/EA==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 03/06/2020 19:38, Navid Emamdoost wrote:
> Calling pm_runtime_get_sync increments the counter even in case of
> failure, causing incorrect ref count. Call pm_runtime_put if
> pm_runtime_get_sync fails.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/dma/tegra210-adma.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index c4ce5dfb149b..87f2a1bed3aa 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -869,8 +869,10 @@ static int tegra_adma_probe(struct platform_device *pdev)
>  	pm_runtime_enable(&pdev->dev);
>  
>  	ret = pm_runtime_get_sync(&pdev->dev);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		pm_runtime_put_sync(&pdev->dev);
>  		goto rpm_disable;
> +	}

I would prefer it if you did not add the pm_runtime_put_sync() call here
because there is already one in the error path that can be used.

Jon

-- 
nvpublic
