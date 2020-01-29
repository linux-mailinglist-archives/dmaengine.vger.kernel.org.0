Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D86A14C931
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jan 2020 12:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgA2LB2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jan 2020 06:01:28 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5027 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgA2LB2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jan 2020 06:01:28 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3165d40009>; Wed, 29 Jan 2020 03:00:36 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 29 Jan 2020 03:01:27 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 29 Jan 2020 03:01:27 -0800
Received: from [10.21.133.51] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 29 Jan
 2020 11:01:25 +0000
Subject: Re: [PATCH v5 05/14] dmaengine: tegra-apb: Prevent race conditions of
 tasklet vs free list
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200123230325.3037-1-digetx@gmail.com>
 <20200123230325.3037-6-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <cd1da99a-e52e-e202-257d-17466132d088@nvidia.com>
Date:   Wed, 29 Jan 2020 11:01:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200123230325.3037-6-digetx@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580295636; bh=IfKZdGdepzhRKX00fBnJencRopRc26wyCay/acOGi4Q=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=e6wu75GhRTBJDe5OiSXPn3K8HO9yRcymv9AH+Q0x2tE12qNP4EEqItT13VtfkB2EC
         jmuULTNVE67Y+T1MtFg0IcnUNveYUmVJj3TqfNFXjzttlbg5pXS9QWAkq7/Kt8GTVZ
         K3VAxpxg/+4xvBx/gfNI/qDnBJFICIWuu7RAZL/DcnLhkeuTBQd2Zxtu047/ieBoVE
         lJs30ynrLNNj62/qvQrklbUyc0il+aRpq8aU/xjFemaVcrUohRRwmaImt64XEKS8n5
         gFoUaaAtZNY5wPN26RK/s64LpHjxB4OLWwihlr6pGpvLnACDHzRX1oIfXm0Qb5zypd
         L4NWI+5Rmr82g==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 23/01/2020 23:03, Dmitry Osipenko wrote:
> The interrupt handler puts a half-completed DMA descriptor on a free list
> and then schedules tasklet to process bottom half of the descriptor that
> executes client's callback, this creates possibility to pick up the busy
> descriptor from the free list. Thus let's disallow descriptor's re-use
> until it is fully processed.
> 
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/dma/tegra20-apb-dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index 1b8a11804962..aafad50d075e 100644
> --- a/drivers/dma/tegra20-apb-dma.c
> +++ b/drivers/dma/tegra20-apb-dma.c
> @@ -281,7 +281,7 @@ static struct tegra_dma_desc *tegra_dma_desc_get(
>  
>  	/* Do not allocate if desc are waiting for ack */
>  	list_for_each_entry(dma_desc, &tdc->free_dma_desc, node) {
> -		if (async_tx_test_ack(&dma_desc->txd)) {
> +		if (async_tx_test_ack(&dma_desc->txd) && !dma_desc->cb_count) {
>  			list_del(&dma_desc->node);
>  			spin_unlock_irqrestore(&tdc->lock, flags);
>  			dma_desc->txd.flags = 0;
> 

I think we should mark this for stable as well. I would make this the
2nd patch in the series as it is related to #1.

Jon

-- 
nvpublic
