Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1415315D92F
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2020 15:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgBNOQa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Feb 2020 09:16:30 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19999 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729092AbgBNOQa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 14 Feb 2020 09:16:30 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e46abaf0000>; Fri, 14 Feb 2020 06:16:15 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 14 Feb 2020 06:16:29 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 14 Feb 2020 06:16:29 -0800
Received: from [10.21.133.51] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Feb
 2020 14:16:27 +0000
Subject: Re: [PATCH v8 19/19] dmaengine: tegra-apb: Improve error message
 about DMA underflow
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200209163356.6439-1-digetx@gmail.com>
 <20200209163356.6439-20-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <f26f9a99-a044-a0ed-d845-5c93628d29d4@nvidia.com>
Date:   Fri, 14 Feb 2020 14:16:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200209163356.6439-20-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581689775; bh=e8YDGG5SBKWvch6oV9YVb5CtuyrsWgVzbSEi0lh2ydE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=XkntFlzoon0L80vKlRoIPbHq/UEAFGYcr20kuca+URiHavLLTta6pgPqRUNksvuea
         QTG9w5Q3dCzslsi/hC4/c897Ny3ORs8UGN9+QnP8lYy/+NMnj7eInhw4EGVxhgEHbu
         pWext/H213rbfDyD+sf1sDoCxMYOUyVIELQ54ZCPwq+hPXes2hcre4jreqh7ke5xJe
         PAApGvRUAWfn//sRevKraW5HezcGwpeC7z8YVHLxH+2rfIz7tlAaivH2we/XeL7mbu
         wkidO+C3FRQgGrNptiDQXkl8JdVVGAz4ZAxyxbvK7fB1efhgEEbFlM65HtLwzVWEmp
         P6VKrK9wWqqLQ==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 09/02/2020 16:33, Dmitry Osipenko wrote:
> Technically it is possible that DMA could be misconfigured in a way that
> cyclic DMA transfer is processed slower than it takes to complete the
> cycle and in this case the DMA is getting aborted with a not very
> informative message about the problem, let's improve it.
> 
> Suggested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/dma/tegra20-apb-dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index 3e0373b89195..1a9b37c102ba 100644
> --- a/drivers/dma/tegra20-apb-dma.c
> +++ b/drivers/dma/tegra20-apb-dma.c
> @@ -566,7 +566,7 @@ static bool handle_continuous_head_request(struct tegra_dma_channel *tdc,
>  	if (!hsgreq->configured) {
>  		tegra_dma_stop(tdc);
>  		pm_runtime_put(tdc->tdma->dev);
> -		dev_err(tdc2dev(tdc), "Error in DMA transfer, aborting DMA\n");
> +		dev_err(tdc2dev(tdc), "DMA transfer underflow, aborting DMA\n");
>  		tegra_dma_abort_all(tdc);
>  		return false;
>  	}
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic
