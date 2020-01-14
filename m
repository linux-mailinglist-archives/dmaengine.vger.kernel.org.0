Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89F4A13AD47
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jan 2020 16:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgANPQu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jan 2020 10:16:50 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1647 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgANPQu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Jan 2020 10:16:50 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1ddb2a0000>; Tue, 14 Jan 2020 07:15:54 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 14 Jan 2020 07:16:49 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 14 Jan 2020 07:16:49 -0800
Received: from [10.21.133.51] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 Jan
 2020 15:16:47 +0000
Subject: Re: [PATCH v4 03/14] dmaengine: tegra-apb: Prevent race conditions on
 channel's freeing
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200112173006.29863-1-digetx@gmail.com>
 <20200112173006.29863-4-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <b99f455c-edd8-1a84-337a-fa0dc4ecb16a@nvidia.com>
Date:   Tue, 14 Jan 2020 15:16:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200112173006.29863-4-digetx@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579014954; bh=k/wRed/cBeFlQnmA2AHyddPhCZsFdx4iEANjqjBOrzI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Y9McB/OFldXkh5PGu7wzBoklXoqzt81w4R7aWhTIUtbjYxpic8yuQATq0gQLl2cJf
         6njViWHWYmoT+ymMYdYNDBKARwRNgQWhiE2T2z/LwXhgNepedOjoQTwrB7WvJ2i9ml
         W0pEhK8+Qm1AcszKKHEjynir+BAA68H0VFy6PiNRP5zZCRrjIc7NrIXMjgmoMHh3Fo
         3dFR/uetZ9rzwfZqiwMA7LTVwmg2eEDexZ3GnxL1eMTklNcE2/RCKXB2JNVjMozNnT
         9ZzdxeinUPOHHCpGCkSk3Zv/zUXT0RlWVajF3n3EHa8S7tRi0kLNBNa6pldjqN/OaD
         hLA54HEZg3t2w==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 12/01/2020 17:29, Dmitry Osipenko wrote:
> It's incorrect to check the channel's "busy" state without taking a lock.
> That shouldn't cause any real troubles, nevertheless it's always better
> not to have any race conditions in the code.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/dma/tegra20-apb-dma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index 664e9c5df3ba..24ad3a5a04e3 100644
> --- a/drivers/dma/tegra20-apb-dma.c
> +++ b/drivers/dma/tegra20-apb-dma.c
> @@ -1294,8 +1294,7 @@ static void tegra_dma_free_chan_resources(struct dma_chan *dc)
>  
>  	dev_dbg(tdc2dev(tdc), "Freeing channel %d\n", tdc->id);
>  
> -	if (tdc->busy)
> -		tegra_dma_terminate_all(dc);
> +	tegra_dma_terminate_all(dc);
>  
>  	spin_lock_irqsave(&tdc->lock, flags);
>  	list_splice_init(&tdc->pending_sg_req, &sg_req_list);

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
