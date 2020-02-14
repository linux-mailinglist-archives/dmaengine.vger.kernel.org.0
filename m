Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8062515D929
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2020 15:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgBNOPP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Feb 2020 09:15:15 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14231 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbgBNOPO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 14 Feb 2020 09:15:14 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e46ab2f0004>; Fri, 14 Feb 2020 06:14:07 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 14 Feb 2020 06:15:14 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 14 Feb 2020 06:15:14 -0800
Received: from [10.21.133.51] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Feb
 2020 14:15:11 +0000
Subject: Re: [PATCH v8 12/19] dmaengine: tegra-apb: Keep clock enabled only
 during of DMA transfer
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200209163356.6439-1-digetx@gmail.com>
 <20200209163356.6439-13-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <e446d1b5-4aec-70fb-b0b8-5f2127c48cf8@nvidia.com>
Date:   Fri, 14 Feb 2020 14:15:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200209163356.6439-13-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581689647; bh=0lgJPUG73bATzz8SB8TuCQIcob3pNRGhHkhwJhUA28I=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=oAPqFbWCKPcgHLfkaWXudnHr5p8BU2bhNl0pBHKfRYRd5BhScN4mdirDvW4xIj3/l
         BbcivKJA0PZ6gaJNJiaLAvLZMoE2hoLRxAikZh0yE44bFEHxJIADXTxPa7ki8rjUmo
         zv3cAuRb4kBsKyddmmX9qsxw+8Z++CmKTUvF+XFKrDTK4o9RpOXqeUtfNRLGOxFyyL
         UHfixXTzr9breTyRlERZTKL/mWThmCvXzn0cUUK0uiRtpglDYLeugnMoZZ+M6Elv2s
         /y/NtYCEDdUOp2nuF9x86sGgZ1O/hf8wBIu3iInjfM271WrhVf3kE4kBIFXLhs6e4V
         +0ywkUOEqQ34w==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 09/02/2020 16:33, Dmitry Osipenko wrote:
> It's a bit impractical to enable hardware's clock at the time of DMA
> channel's allocation because most of DMA client drivers allocate DMA
> channel at the time of the driver's probing, and thus, DMA clock is kept
> always-enabled in practice, defeating the whole purpose of runtime PM.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/dma/tegra20-apb-dma.c | 36 ++++++++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index 049e98ae1240..6e057a9f0e46 100644
> --- a/drivers/dma/tegra20-apb-dma.c
> +++ b/drivers/dma/tegra20-apb-dma.c
> @@ -569,6 +569,7 @@ static bool handle_continuous_head_request(struct tegra_dma_channel *tdc,
>  	hsgreq = list_first_entry(&tdc->pending_sg_req, typeof(*hsgreq), node);
>  	if (!hsgreq->configured) {
>  		tegra_dma_stop(tdc);
> +		pm_runtime_put(tdc->tdma->dev);
>  		dev_err(tdc2dev(tdc), "Error in DMA transfer, aborting DMA\n");
>  		tegra_dma_abort_all(tdc);
>  		return false;
> @@ -604,9 +605,14 @@ static void handle_once_dma_done(struct tegra_dma_channel *tdc,
>  	list_add_tail(&sgreq->node, &tdc->free_sg_req);
>  
>  	/* Do not start DMA if it is going to be terminate */
> -	if (to_terminate || list_empty(&tdc->pending_sg_req))
> +	if (to_terminate)
>  		return;
>  
> +	if (list_empty(&tdc->pending_sg_req)) {
> +		pm_runtime_put(tdc->tdma->dev);
> +		return;
> +	}
> +
>  	tdc_start_head_req(tdc);
>  }
>  
> @@ -712,6 +718,7 @@ static void tegra_dma_issue_pending(struct dma_chan *dc)
>  {
>  	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
>  	unsigned long flags;
> +	int err;
>  
>  	spin_lock_irqsave(&tdc->lock, flags);
>  	if (list_empty(&tdc->pending_sg_req)) {
> @@ -719,6 +726,12 @@ static void tegra_dma_issue_pending(struct dma_chan *dc)
>  		goto end;
>  	}
>  	if (!tdc->busy) {
> +		err = pm_runtime_get_sync(tdc->tdma->dev);
> +		if (err < 0) {
> +			dev_err(tdc2dev(tdc), "Failed to enable DMA\n");
> +			goto end;
> +		}
> +
>  		tdc_start_head_req(tdc);
>  
>  		/* Continuous single mode: Configure next req */
> @@ -774,6 +787,8 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
>  	}
>  	tegra_dma_resume(tdc);
>  
> +	pm_runtime_put(tdc->tdma->dev);
> +
>  skip_dma_stop:
>  	tegra_dma_abort_all(tdc);
>  
> @@ -1268,22 +1283,15 @@ tegra_dma_prep_dma_cyclic(struct dma_chan *dc, dma_addr_t buf_addr,
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
> @@ -1316,7 +1324,6 @@ static void tegra_dma_free_chan_resources(struct dma_chan *dc)
>  		list_del(&sg_req->node);
>  		kfree(sg_req);
>  	}
> -	pm_runtime_put(tdma->dev);
>  
>  	tdc->slave_id = TEGRA_APBDMA_SLAVE_ID_INVALID;
>  }
> @@ -1416,6 +1423,11 @@ static int tegra_dma_probe(struct platform_device *pdev)
>  
>  	spin_lock_init(&tdma->global_lock);
>  
> +	ret = clk_prepare(tdma->dma_clk);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_irq_safe(&pdev->dev);
>  	pm_runtime_enable(&pdev->dev);
>  
>  	ret = pm_runtime_get_sync(&pdev->dev);
> @@ -1531,6 +1543,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
>  
>  err_pm_disable:
>  	pm_runtime_disable(&pdev->dev);
> +	clk_unprepare(tdma->dma_clk);
>  
>  	return ret;
>  }
> @@ -1541,6 +1554,7 @@ static int tegra_dma_remove(struct platform_device *pdev)
>  
>  	dma_async_device_unregister(&tdma->dma_dev);
>  	pm_runtime_disable(&pdev->dev);
> +	clk_unprepare(tdma->dma_clk);
>  
>  	return 0;
>  }
> @@ -1569,7 +1583,7 @@ static int tegra_dma_runtime_suspend(struct device *dev)
>  						  TEGRA_APBDMA_CHAN_WCOUNT);
>  	}
>  
> -	clk_disable_unprepare(tdma->dma_clk);
> +	clk_disable(tdma->dma_clk);
>  
>  	return 0;
>  }
> @@ -1580,7 +1594,7 @@ static int tegra_dma_runtime_resume(struct device *dev)
>  	unsigned int i;
>  	int ret;
>  
> -	ret = clk_prepare_enable(tdma->dma_clk);
> +	ret = clk_enable(tdma->dma_clk);
>  	if (ret < 0) {
>  		dev_err(dev, "clk_enable failed: %d\n", ret);
>  		return ret;
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic
