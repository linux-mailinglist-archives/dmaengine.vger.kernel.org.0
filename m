Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5A1613ADE1
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jan 2020 16:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgANPnk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jan 2020 10:43:40 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3047 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgANPnk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Jan 2020 10:43:40 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1de1740000>; Tue, 14 Jan 2020 07:42:44 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 14 Jan 2020 07:43:39 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 14 Jan 2020 07:43:39 -0800
Received: from [10.21.133.51] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 Jan
 2020 15:43:37 +0000
Subject: Re: [PATCH v4 05/14] dmaengine: tegra-apb: Prevent race conditions of
 tasklet vs free list
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200112173006.29863-1-digetx@gmail.com>
 <20200112173006.29863-6-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <1331b7c1-3839-69cb-4de2-16771c652d41@nvidia.com>
Date:   Tue, 14 Jan 2020 15:43:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200112173006.29863-6-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579016564; bh=TOxcfPb22CxCMWcfOogB2CSM8aUSAE1trXziDRi5ilw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=oN1q3vz+2upl5Id8/Ezu9QGXscK1EDXlatHEjHm92sS3Sgz3M/8hykNnkNL1LGVKy
         GhzHjpvpgb8xzu0TrZB6xwM23YSezV3NDesny5xhQYPgJvQzWRJ9NoOxxQEcDbXBQv
         s1Y8Av7MbeV49VHdMwlaf6ZWLwRkQ9Rvcf5lReG/vXBpEnZOaJTBI0GvE1oL7uPBwc
         qZ7+jOdIwjjNPOjwVaDmA3HTMlqOmydvRD1L1Iv52k8Q6o42PCXmogIwaVjrmTy5zq
         xARprz5pRqvfwRoQ+fiV+a5e++fagBamDmGwkJLL9ahXs5AeD/zxWw4jevDpZxtoTQ
         0nU16Tz2jPBzA==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 12/01/2020 17:29, Dmitry Osipenko wrote:
> The interrupt handler puts a half-completed DMA descriptor on a free list
> and then schedules tasklet to process bottom half of the descriptor that
> executes client's callback, this creates possibility to pick up the busy
> descriptor from the free list. Thus let's disallow descriptor's re-use
> until it is fully processed.
> 
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

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
