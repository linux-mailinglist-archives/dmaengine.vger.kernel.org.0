Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 299B713BD11
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2020 11:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbgAOKIa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jan 2020 05:08:30 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2987 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbgAOKIa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Jan 2020 05:08:30 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1ee4880001>; Wed, 15 Jan 2020 02:08:09 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 Jan 2020 02:08:29 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 Jan 2020 02:08:29 -0800
Received: from [10.21.133.51] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Jan
 2020 10:08:26 +0000
Subject: Re: [PATCH v4 10/14] dmaengine: tegra-apb: Keep clock enabled only
 during of DMA transfer
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200112173006.29863-1-digetx@gmail.com>
 <20200112173006.29863-11-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <5ae55a09-a1be-d93b-80f5-6ad3d712cb93@nvidia.com>
Date:   Wed, 15 Jan 2020 10:08:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200112173006.29863-11-digetx@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579082889; bh=2WCvvHC7kFg363zM5VkyslK3KnGcvXX8sJysuykqAbA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=SVRBmT1mnmC8LCLZh8Q1p6BsxL0IUywOntmNqs3+X40cuU2wmtqAPcRtIjcwA4job
         n/h000BpbrYFjypisz9Zd1+lGUMeMvaZvEfA+OrXswWX6ofQpeu1Jt/b/vmAXRDDGN
         blWjlYQInfSh/m2qtDIr6SUYQv0PHtvV00i4tM1RufGF3ZlmBWqr/eWDmn+WYzdu+A
         ON4dqeqSYU33NQRQmUa3p8VjhWZk2Mmgd1hRpKd7epI0rpSev4+qyO8VEIuw9YHOFi
         QKul/u9Nu62hCxwHbMc+negz/+FpwK8rd18RwvDakGf5quyvGNOYkSjJsAVj2PNR3m
         aGt+LAw6ZmV0w==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 12/01/2020 17:30, Dmitry Osipenko wrote:
> It's a bit impractical to enable hardware's clock at the time of DMA
> channel's allocation because most of DMA client drivers allocate DMA
> channel at the time of the driver's probing and thus DMA clock is kept
> always-enabled in practice, defeating the whole purpose of runtime PM.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/dma/tegra20-apb-dma.c | 43 ++++++++++++++++++++++-------------
>  1 file changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index cc4a9ca20780..b9d8e57eaf54 100644
> --- a/drivers/dma/tegra20-apb-dma.c
> +++ b/drivers/dma/tegra20-apb-dma.c
> @@ -436,6 +436,8 @@ static void tegra_dma_stop(struct tegra_dma_channel *tdc)
>  		tdc_write(tdc, TEGRA_APBDMA_CHAN_STATUS, status);
>  	}
>  	tdc->busy = false;
> +
> +	pm_runtime_put(tdc->tdma->dev);

Is this the right place to call put? Seems that in terminate_all resume
is called after stop which will access the registers.

>  }
>  
>  static void tegra_dma_start(struct tegra_dma_channel *tdc,
> @@ -500,18 +502,25 @@ static void tegra_dma_configure_for_next(struct tegra_dma_channel *tdc,
>  	tegra_dma_resume(tdc);
>  }
>  
> -static void tdc_start_head_req(struct tegra_dma_channel *tdc)
> +static bool tdc_start_head_req(struct tegra_dma_channel *tdc)
>  {
>  	struct tegra_dma_sg_req *sg_req;
> +	int err;
>  
>  	if (list_empty(&tdc->pending_sg_req))
> -		return;
> +		return false;
> +
> +	err = pm_runtime_get_sync(tdc->tdma->dev);
> +	if (WARN_ON_ONCE(err < 0))
> +		return false;
>  
>  	sg_req = list_first_entry(&tdc->pending_sg_req, typeof(*sg_req), node);
>  	tegra_dma_start(tdc, sg_req);
>  	sg_req->configured = true;
>  	sg_req->words_xferred = 0;
>  	tdc->busy = true;
> +
> +	return true;
>  }
>  
>  static void tdc_configure_next_head_desc(struct tegra_dma_channel *tdc)
> @@ -615,6 +624,8 @@ static void handle_once_dma_done(struct tegra_dma_channel *tdc,
>  	}
>  	list_add_tail(&sgreq->node, &tdc->free_sg_req);
>  
> +	pm_runtime_put(tdc->tdma->dev);
> +
>  	/* Do not start DMA if it is going to be terminate */
>  	if (to_terminate || list_empty(&tdc->pending_sg_req))
>  		return;
> @@ -730,9 +741,7 @@ static void tegra_dma_issue_pending(struct dma_chan *dc)
>  		dev_err(tdc2dev(tdc), "No DMA request\n");
>  		goto end;
>  	}
> -	if (!tdc->busy) {
> -		tdc_start_head_req(tdc);
> -
> +	if (!tdc->busy && tdc_start_head_req(tdc)) {
>  		/* Continuous single mode: Configure next req */
>  		if (tdc->cyclic) {
>  			/*
> @@ -1280,22 +1289,15 @@ tegra_dma_prep_dma_cyclic(struct dma_chan *dc, dma_addr_t buf_addr,
>  static int tegra_dma_alloc_chan_resources(struct dma_chan *dc)
>  {
>  	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
> -	struct tegra_dma *tdma = tdc->tdma;
> -	int ret;
>  
>  	dma_cookie_init(&tdc->dma_chan);
>  
> -	ret = pm_runtime_get_sync(tdma->dev);
> -	if (ret < 0)
> -		return ret;
> -
>  	return 0;
>  }
>  
>  static void tegra_dma_free_chan_resources(struct dma_chan *dc)
>  {
>  	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
> -	struct tegra_dma *tdma = tdc->tdma;
>  	struct tegra_dma_desc *dma_desc;
>  	struct tegra_dma_sg_req *sg_req;
>  	struct list_head dma_desc_list;
> @@ -1328,7 +1330,6 @@ static void tegra_dma_free_chan_resources(struct dma_chan *dc)
>  		list_del(&sg_req->node);
>  		kfree(sg_req);
>  	}
> -	pm_runtime_put(tdma->dev);
>  
>  	tdc->slave_id = TEGRA_APBDMA_SLAVE_ID_INVALID;
>  }
> @@ -1428,11 +1429,16 @@ static int tegra_dma_probe(struct platform_device *pdev)
>  
>  	spin_lock_init(&tdma->global_lock);
>  
> +	ret = clk_prepare(tdma->dma_clk);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_irq_safe(&pdev->dev);
>  	pm_runtime_enable(&pdev->dev);
>  	if (!pm_runtime_enabled(&pdev->dev)) {
>  		ret = tegra_dma_runtime_resume(&pdev->dev);
>  		if (ret)
> -			return ret;
> +			goto err_clk_unprepare;
>  	} else {
>  		ret = pm_runtime_get_sync(&pdev->dev);

There is a get here but I don't see a put in probe.

Jon

-- 
nvpublic
