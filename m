Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A052C82F0
	for <lists+dmaengine@lfdr.de>; Mon, 30 Nov 2020 12:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgK3LNk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 Nov 2020 06:13:40 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3205 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgK3LNk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 30 Nov 2020 06:13:40 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc4d3be0000>; Mon, 30 Nov 2020 03:13:03 -0800
Received: from [10.26.72.142] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 30 Nov
 2020 11:12:48 +0000
Subject: Re: [PATCH] dmaengine: tegra-apb: fix reference leak in
 tegra_dma_issue_pending and tegra_dma_synchronize
To:     Qinglang Miao <miaoqinglang@huawei.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20201127094431.120771-1-miaoqinglang@huawei.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <b7871cf9-9f3e-1b8e-028b-73bd703411f7@nvidia.com>
Date:   Mon, 30 Nov 2020 11:12:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201127094431.120771-1-miaoqinglang@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606734783; bh=lcK1YEl/L4MjUjqxhnW4k9aJmOIQTqHyqj06Q0RHP44=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=DEtXi/tG6kC58tw1ZuacwKWGo+iXVKxDmmpsOwQ3kvJAbRttpcvB67IWOjwY91L5r
         I40RfErKGaO6ruhTvW5bQXrfK7rqIsFSF+dGVPnkPTxt5lSONG1zROIZySaeC3aBPz
         cEGR6CVt2FqZd+rxmL8xNUjEyRL+41qMFNRNFFI3y58mW6Q8YW/T7wfQjSJCs3yEeB
         Y+8s59VZECNFx/GymDRUrzTd66yK11CtJZzLeSV5+6i/1SI2e2VRgY3BXRHMDuvAgD
         CzlAlVa0w+1eucmF8/6ustl1YzsQd7jgwA7CRrMcC0FNhOSe+VlSY0fPLO0ls+G7nU
         dDcrQSjIDlsFA==
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 27/11/2020 09:44, Qinglang Miao wrote:
> pm_runtime_get_sync will increment pm usage counter even it
> failed. Forgetting to putting operation will result in a
> reference leak here.
> 
> A new function pm_runtime_resume_and_get is introduced in
> [0] to keep usage counter balanced. So We fix the reference
> leak by replacing it with new funtion.
> 
> [0] dd8088d5a896 ("PM: runtime: Add  pm_runtime_resume_and_get to deal with usage counter")
> 
> Fixes: 84a3f375eea9 ("dmaengine: tegra-apb: Keep clock enabled only during of DMA transfer")
> Fixes: 664475cffb8c ("dmaengine: tegra-apb: Ensure that clock is enabled during of DMA synchronization")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  drivers/dma/tegra20-apb-dma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index 71827d9b0..b7260749e 100644
> --- a/drivers/dma/tegra20-apb-dma.c
> +++ b/drivers/dma/tegra20-apb-dma.c
> @@ -723,7 +723,7 @@ static void tegra_dma_issue_pending(struct dma_chan *dc)
>  		goto end;
>  	}
>  	if (!tdc->busy) {
> -		err = pm_runtime_get_sync(tdc->tdma->dev);
> +		err = pm_runtime_resume_and_get(tdc->tdma->dev);
>  		if (err < 0) {
>  			dev_err(tdc2dev(tdc), "Failed to enable DMA\n");
>  			goto end;
> @@ -818,7 +818,7 @@ static void tegra_dma_synchronize(struct dma_chan *dc)
>  	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
>  	int err;
>  
> -	err = pm_runtime_get_sync(tdc->tdma->dev);
> +	err = pm_runtime_resume_and_get(tdc->tdma->dev);
>  	if (err < 0) {
>  		dev_err(tdc2dev(tdc), "Failed to synchronize DMA: %d\n", err);
>  		return;


Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
