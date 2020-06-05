Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4437D1EF0FE
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2020 07:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgFEF4X (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 Jun 2020 01:56:23 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12144 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgFEF4X (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 5 Jun 2020 01:56:23 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed9de7a0002>; Thu, 04 Jun 2020 22:56:10 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 04 Jun 2020 22:56:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 04 Jun 2020 22:56:22 -0700
Received: from [10.26.75.201] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Jun
 2020 05:56:16 +0000
Subject: Re: [PATCH] dmaengine: tegra210-adma: handle pm_runtime_get_sync
 failure cases
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <emamd001@umn.edu>, <wu000273@umn.edu>, <kjlu@umn.edu>,
        <mccamant@cs.umn.edu>
References: <20200604201058.86457-1-navid.emamdoost@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <103127de-ff57-d033-5794-71effc032e9a@nvidia.com>
Date:   Fri, 5 Jun 2020 06:56:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200604201058.86457-1-navid.emamdoost@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1591336570; bh=WlWaFRsE4QHRYgg3PJsHxTPc4ovoB/3ghesZk3APzdo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=L1+Wk6txMgumNeQHCnVfktQ/01eRVwvG3UMhaMp845RNTG6U+3Xw2ykDtLY72DLUI
         2HsLyHgSNgDbDD/idY3VyQLSDvteAgjSBj0ub8Fu8PHPjFHIFP4Co6ne3754rHBn/t
         HWEkG2pE8HuiZRIJKXTDQChZUE2WVv5OeKA9YsN21CanxNyk+SM6OwzKiqFOfDcZLZ
         hCfCpCEcWUw2s+crKygKZP4gcEWJEt5co7PVi2mWKdRy0LBAtNtuFZdYV8zUU71FcN
         fsTjQsbTQKp/fXYf3wqu2aRPu+5CinMIeO2RnPR9SDNPB4FHPNF7QfbO/avTt5+flm
         aHttn9iZaJmpw==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 04/06/2020 21:10, Navid Emamdoost wrote:
> Calling pm_runtime_get_sync increments the counter even in case of
> failure, causing incorrect ref count. Call pm_runtime_put if
> pm_runtime_get_sync fails.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/dma/tegra210-adma.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index c4ce5dfb149b..899eaaf9fc48 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -659,6 +659,7 @@ static int tegra_adma_alloc_chan_resources(struct dma_chan *dc)
>  	ret = pm_runtime_get_sync(tdc2dev(tdc));
>  	if (ret < 0) {
>  		free_irq(tdc->irq, tdc);
> +		pm_runtime_put(tdc2dev(tdc));
>  		return ret;
>  	}
>  
> @@ -870,7 +871,7 @@ static int tegra_adma_probe(struct platform_device *pdev)
>  
>  	ret = pm_runtime_get_sync(&pdev->dev);
>  	if (ret < 0)
> -		goto rpm_disable;
> +		goto rpm_put;
>  
>  	ret = tegra_adma_init(tdma);
>  	if (ret)
> 

The label rpm_disable should now be removed. You should also update the
subject-prefix to be [PATCH V2] to make it clear that this is the
updated patch.

Jon

-- 
nvpublic
