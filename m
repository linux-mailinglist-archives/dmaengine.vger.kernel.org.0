Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B071D7789
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2020 13:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgERLnV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 May 2020 07:43:21 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13725 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgERLnV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 18 May 2020 07:43:21 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec274cc0000>; Mon, 18 May 2020 04:43:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 18 May 2020 04:43:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 18 May 2020 04:43:21 -0700
Received: from [10.26.74.226] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 May
 2020 11:43:18 +0000
Subject: Re: [PATCH] dmaengine: tegra210-adma: Fix an error handling path in
 'tegra_adma_probe()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        <ldewangan@nvidia.com>, <dan.j.williams@intel.com>,
        <vkoul@kernel.org>, <thierry.reding@gmail.com>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20200516214205.276266-1-christophe.jaillet@wanadoo.fr>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <899a62c8-b4fa-b1cc-6e3a-bbfb680e5d41@nvidia.com>
Date:   Mon, 18 May 2020 12:43:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200516214205.276266-1-christophe.jaillet@wanadoo.fr>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589802188; bh=DzIgCyZcvN9rr4wBAYpZeYTa28sgNw2eUicDprROQHc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=OU82ecs4nx6r/Bhm6rWg7Ij3YNHy1BdCCslIYShViREuXGKDQrfsQaLZ/cn2XKssS
         B5RFjpGeQL8GSFZ3chXe2/0LzC3LBkhkFIRjAmnsKSf39z3tKVHEAmNRi7OtQLwJIB
         QNA9Hq2+CpjJuTtvKi3VzDIVpj0thoZdU1Eg3795DxpWI3nF0j9FRux3sE/hB3ZnWE
         Voo62VH+eq60SIisbJ/MJRMWqWBqODPh84jNVbtilQGzNw71b9XYYcAdRAoCQTo8vS
         jGmAvmuKuEIQXyGquQXBJmQj+sFfEcfEN3VAqMiqMELLkEaLrvOSiZMNp1hqb4eUIy
         5DjRWhHPLk3Lw==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 16/05/2020 22:42, Christophe JAILLET wrote:
> Commit b53611fb1ce9 ("dmaengine: tegra210-adma: Fix crash during probe")
> has moved some code in the probe function and reordered the error handling
> path accordingly.
> However, a goto has been missed.
> 
> Fix it and goto the right label if 'dma_async_device_register()' fails, so
> that all resources are released.
> 
> Fixes: b53611fb1ce9 ("dmaengine: tegra210-adma: Fix crash during probe")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/dma/tegra210-adma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index c4ce5dfb149b..db58d7e4f9fe 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -900,7 +900,7 @@ static int tegra_adma_probe(struct platform_device *pdev)
>  	ret = dma_async_device_register(&tdma->dma_dev);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "ADMA registration failed: %d\n", ret);
> -		goto irq_dispose;
> +		goto rpm_put;
>  	}
>  
>  	ret = of_dma_controller_register(pdev->dev.of_node,


Thanks for fixing this!

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
