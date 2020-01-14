Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3527C13ADC4
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jan 2020 16:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgANPgF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jan 2020 10:36:05 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:5190 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgANPgF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Jan 2020 10:36:05 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1ddfd00000>; Tue, 14 Jan 2020 07:35:44 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 14 Jan 2020 07:36:04 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 14 Jan 2020 07:36:04 -0800
Received: from [10.21.133.51] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 Jan
 2020 15:36:02 +0000
Subject: Re: [PATCH v4 04/14] dmaengine: tegra-apb: Clean up tasklet releasing
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200112173006.29863-1-digetx@gmail.com>
 <20200112173006.29863-5-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <2395e415-c435-0305-b53e-81278ff24d30@nvidia.com>
Date:   Tue, 14 Jan 2020 15:36:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200112173006.29863-5-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579016144; bh=4nzaSqhuTxBtHcd2ez0EJ4Bfl+5vH4h40EZkwwGBUgA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=bCRhGJGpIM4zf0HkZYKQe4MwSUQPwKEpXlAxKLWJPIIp/CT1afIFYr0HYE6BWgEzx
         m9HFHWr9g41QOPxlyoBFcpZ25fLuDO5vb47QTrFtNFIv15WTgNZbVT2io0IIY4FFAC
         rChsqV8tzUaIGtJ/mjdd+VqZEnKPFxdkKES013iVV8XCkiQDow4oSA/WOjrfYDn3NX
         /JHzeNXuidGr7MM2A4oA+Qnh79VfoQDCK50tPbYqZMWPRl+KTAquKDRh1WXaJcvzuF
         vR4ZdEKaGBcQVhWvLyA0VVyNukqnS8igFknhOuqn91X1vRT4yJ3hB9RTbjQD1a+iWr
         vENEnpNAnkruw==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 12/01/2020 17:29, Dmitry Osipenko wrote:
> There is no need to kill tasklet when driver's probe fails because tasklet
> can't be scheduled at this time. It is also cleaner to kill tasklet on
> channel's freeing rather than to kill it on driver's removal, otherwise
> tasklet could perform a dummy execution after channel's releasing, which
> isn't very nice.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/dma/tegra20-apb-dma.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index 24ad3a5a04e3..1b8a11804962 100644
> --- a/drivers/dma/tegra20-apb-dma.c
> +++ b/drivers/dma/tegra20-apb-dma.c
> @@ -1287,7 +1287,6 @@ static void tegra_dma_free_chan_resources(struct dma_chan *dc)
>  	struct tegra_dma_sg_req *sg_req;
>  	struct list_head dma_desc_list;
>  	struct list_head sg_req_list;
> -	unsigned long flags;
>  
>  	INIT_LIST_HEAD(&dma_desc_list);
>  	INIT_LIST_HEAD(&sg_req_list);
> @@ -1295,15 +1294,14 @@ static void tegra_dma_free_chan_resources(struct dma_chan *dc)
>  	dev_dbg(tdc2dev(tdc), "Freeing channel %d\n", tdc->id);
>  
>  	tegra_dma_terminate_all(dc);
> +	tasklet_kill(&tdc->tasklet);
>  
> -	spin_lock_irqsave(&tdc->lock, flags);
>  	list_splice_init(&tdc->pending_sg_req, &sg_req_list);
>  	list_splice_init(&tdc->free_sg_req, &sg_req_list);
>  	list_splice_init(&tdc->free_dma_desc, &dma_desc_list);
>  	INIT_LIST_HEAD(&tdc->cb_desc);
>  	tdc->config_init = false;
>  	tdc->isr_handler = NULL;
> -	spin_unlock_irqrestore(&tdc->lock, flags);
>  
>  	while (!list_empty(&dma_desc_list)) {
>  		dma_desc = list_first_entry(&dma_desc_list,
> @@ -1542,7 +1540,6 @@ static int tegra_dma_probe(struct platform_device *pdev)
>  		struct tegra_dma_channel *tdc = &tdma->channels[i];
>  
>  		free_irq(tdc->irq, tdc);
> -		tasklet_kill(&tdc->tasklet);
>  	}
>  
>  	pm_runtime_disable(&pdev->dev);
> @@ -1562,7 +1559,6 @@ static int tegra_dma_remove(struct platform_device *pdev)
>  	for (i = 0; i < tdma->chip_data->nr_channels; ++i) {
>  		tdc = &tdma->channels[i];
>  		free_irq(tdc->irq, tdc);
> -		tasklet_kill(&tdc->tasklet);
>  	}
>  
>  	pm_runtime_disable(&pdev->dev);

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
