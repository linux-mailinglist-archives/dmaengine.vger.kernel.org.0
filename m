Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2164E1EE9A3
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jun 2020 19:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbgFDRpW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 4 Jun 2020 13:45:22 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3877 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729998AbgFDRpV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 4 Jun 2020 13:45:21 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed932cf0000>; Thu, 04 Jun 2020 10:43:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 04 Jun 2020 10:45:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 04 Jun 2020 10:45:21 -0700
Received: from [10.26.72.155] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Jun
 2020 17:45:14 +0000
Subject: Re: [PATCH] dmaengine: tegra210-adma: fix pm_runtime_get_sync failure
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <emamd001@umn.edu>, <wu000273@umn.edu>, <kjlu@umn.edu>,
        <smccaman@umn.edu>
References: <20200603184104.4475-1-navid.emamdoost@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <900909fe-fa15-fbca-80f7-79aeee721ed9@nvidia.com>
Date:   Thu, 4 Jun 2020 18:45:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200603184104.4475-1-navid.emamdoost@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1591292623; bh=Yp8fGQ4ljGEnhEj26i/7HtUSVGFm0+/zLsIjNIponmI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=LjpZ15h1i0/8xqTnfyw8GNkYEjTi3RjUqRjkRosKkcJTC4WsjIoFu2YCEr3SlmLxW
         Zxfvhan8phHdoRyFU8sP+IG1uV0KM5UblaMiEsosQbTJqF+dYdY/ApewLIFlC3rLpv
         Zj6FL1mKos+YSkr0y3uj1oMtmcX7LcWngN8hM+bv4exSVfuCTX0Yo75lJ/kB2ddjcW
         6UjWjM8QiEWA2YjHMvgK9Wckow01aE5/rTN1e2vIe8lkReY/jATAhQhiecn5xrNYC1
         O1Iwkjp4J5AJobfPS3dk1cW0odnHJPQh3NdUPnt7MCqoGVoN6PleYe7JoJKFZgjV9F
         mDa3CaODQaOqA==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 03/06/2020 19:41, Navid Emamdoost wrote:
> Calling pm_runtime_get_sync increments the counter even in case of
> failure, causing incorrect ref count. Call pm_runtime_put if
> pm_runtime_get_sync fails.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/dma/tegra210-adma.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index c4ce5dfb149b..e8c749cd3fe8 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -659,6 +659,7 @@ static int tegra_adma_alloc_chan_resources(struct dma_chan *dc)
>  	ret = pm_runtime_get_sync(tdc2dev(tdc));
>  	if (ret < 0) {
>  		free_irq(tdc->irq, tdc);
> +		pm_runtime_put(tdc2dev(tdc));
>  		return ret;
>  	}


Please do not send two patches with the same $subject that are fixing
two different areas of the driver. In fact, please squash these two
patches into a single fix and resend because they are fixing the same issue.

Jon

-- 
nvpublic
