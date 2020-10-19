Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E76C2925DF
	for <lists+dmaengine@lfdr.de>; Mon, 19 Oct 2020 12:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgJSKbS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Oct 2020 06:31:18 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15562 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgJSKbS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Oct 2020 06:31:18 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f8d6ae90001>; Mon, 19 Oct 2020 03:31:05 -0700
Received: from [10.26.45.122] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 19 Oct
 2020 10:31:16 +0000
Subject: Re: [PATCH 04/10] dmaengine: tegra210-adma: remove redundant irqsave
 and irqrestore in hardIRQ
To:     Barry Song <song.bao.hua@hisilicon.com>, <vkoul@kernel.org>,
        <dmaengine@vger.kernel.org>
CC:     Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
References: <20201015235921.21224-1-song.bao.hua@hisilicon.com>
 <20201015235921.21224-5-song.bao.hua@hisilicon.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <6323bdbf-03d5-947f-690a-359bfbe09fc6@nvidia.com>
Date:   Mon, 19 Oct 2020 11:31:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201015235921.21224-5-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603103466; bh=mJs1EXJx/WG4SdRVgxB97piSZ3lMg+E51vxN+3lnzZo=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=P7+jani6hSUcJEzHnoCKxB03tZv28/xOcEVvmUSRDPUzBBpehKa3P/9gGx7fJybWx
         4Z3QQuabd/IqCl0t7IUDM3pnU1Bz65e8B/mILiTLBS1PYg5GDSmPPbWT/HnEJV+0vx
         EZincWZV1v5ycSXbs5ZZwPHeI4FwZOOBAozijjIgXfwvrXnrNkrpMCO+/AamP0nJm6
         4toOHYS7jYdLa4xxB/7bZkA8nOWyipUlWLfY7YWP/ndy6mOH43edWy816/tWyDfGgw
         /SqMwhLM7IfyjXvPvzKUWhOgFQzIrfzyv+0gHZUSaVNFfD7cH08ph7SS2WWbV9rSIp
         7BjqXrv0RihfA==
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 16/10/2020 00:59, Barry Song wrote:
> Running in hardIRQ, disabling IRQ is redundant.
> 
> Cc: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: Jon Hunter <jonathanh@nvidia.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  drivers/dma/tegra210-adma.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index c5fa2ef74abc..4735742e826d 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -408,19 +408,18 @@ static irqreturn_t tegra_adma_isr(int irq, void *dev_id)
>  {
>  	struct tegra_adma_chan *tdc = dev_id;
>  	unsigned long status;
> -	unsigned long flags;
>  
> -	spin_lock_irqsave(&tdc->vc.lock, flags);
> +	spin_lock(&tdc->vc.lock);
>  
>  	status = tegra_adma_irq_clear(tdc);
>  	if (status == 0 || !tdc->desc) {
> -		spin_unlock_irqrestore(&tdc->vc.lock, flags);
> +		spin_unlock(&tdc->vc.lock);
>  		return IRQ_NONE;
>  	}
>  
>  	vchan_cyclic_callback(&tdc->desc->vd);
>  
> -	spin_unlock_irqrestore(&tdc->vc.lock, flags);
> +	spin_unlock(&tdc->vc.lock);
>  
>  	return IRQ_HANDLED;
>  }
> 


Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
