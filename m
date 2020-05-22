Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40C71DE4B5
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2020 12:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgEVKoF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 May 2020 06:44:05 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12462 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728640AbgEVKoF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 May 2020 06:44:05 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec7ace80001>; Fri, 22 May 2020 03:43:52 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 22 May 2020 03:44:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 22 May 2020 03:44:04 -0700
Received: from [10.26.74.233] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 22 May
 2020 10:44:02 +0000
Subject: Re: [PATCH] dmaengine: tegra210-adma: Fix runtime PM imbalance on
 error
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, <kjlu@umn.edu>
CC:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200522075846.30706-1-dinghao.liu@zju.edu.cn>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <967c17d2-6b57-27f0-7762-cd0835caaec9@nvidia.com>
Date:   Fri, 22 May 2020 11:43:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200522075846.30706-1-dinghao.liu@zju.edu.cn>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590144232; bh=xtgWWsjcP6ZNZENOPLR8tiW6V23Hn5QNs7Y0J6/9PQs=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=o/MiK8V3/4ZeX7LaWuBYGUkLdr53KoorpJF8Ga2q0C69t1nVWAQqLNqN5UjFMOgUX
         NKaMOCHW6XL+0xOPFSNzGI9mAU8VH2LDpq+bdGP3w9s40XMwKf+DELY8Q89KRmNOGI
         FNqHcRB7ZXGHwpxV2PouIpFCQhu6n/MJ7MvQwhPh4W1zw5ztPYavzYUgJuYWtshpZW
         vgu3vUmg/W9DMYUMT0kNhEQwsxWrCwCK2VKVeK2JrLLErms5DSBILMpIFxuOszUXiQ
         XoGP233+Cd65c78w07gZFOctFFpDXEkmFJfEJppSuTS9z6yjqKH7C8VbEHLluJyTsd
         YZmf4lb8bQW3A==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 22/05/2020 08:58, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> when it returns an error code. Thus a pairing decrement is needed on
> the error handling path to keep the counter balanced.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/dma/tegra210-adma.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index c4ce5dfb149b..803e1f4d5dac 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -658,6 +658,7 @@ static int tegra_adma_alloc_chan_resources(struct dma_chan *dc)
>  
>  	ret = pm_runtime_get_sync(tdc2dev(tdc));
>  	if (ret < 0) {
> +		pm_runtime_put_sync(tdc2dev(tdc));
>  		free_irq(tdc->irq, tdc);
>  		return ret;
>  	}
> 


There is another place in probe that needs to be fixed as well. Can you
correct this while you are at it?

Thanks
Jon

-- 
nvpublic
