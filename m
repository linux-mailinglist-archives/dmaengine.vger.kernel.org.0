Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7778113ADEC
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jan 2020 16:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgANPo7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jan 2020 10:44:59 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:5534 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgANPo7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Jan 2020 10:44:59 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1de1e60000>; Tue, 14 Jan 2020 07:44:38 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 14 Jan 2020 07:44:58 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 14 Jan 2020 07:44:58 -0800
Received: from [10.21.133.51] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 Jan
 2020 15:44:56 +0000
Subject: Re: [PATCH v4 07/14] dmaengine: tegra-apb: Use devm_request_irq
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200112173006.29863-1-digetx@gmail.com>
 <20200112173006.29863-8-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <915e9583-7f1e-a045-1ced-cb0e60cb156c@nvidia.com>
Date:   Tue, 14 Jan 2020 15:44:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200112173006.29863-8-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579016678; bh=WKV89CKnbPQ4ptWtTZGhSK4VZA9YeMZfVCrzVyqodcQ=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=YVN4xbNZA2b7rEMlxqyY+7HCY2L5IOVPVph1W4uv0Ud09clm5nAXWsacDJ1ExVL8X
         d3UrQAbgY0RaPU4EAc2k3lwPbU5FKeqoOo7T3+Wis1JPWV89qlBROWNP8+DXMa7UIU
         WB+z3rRV1jYK+M/loEmdet4Q9RqKoaLbrWaItlywH2hJke7/CB9spIk5Vt0HyxhmIO
         GG+BidwLVqfYsdBe4KQTN0wOcjNIL1PpNTtmxOhbhBpDRSxJjTfW1kdiOyfjGFHxdo
         FcIWoRKuYM8MrvZ5ZSNbIDTOaAB5+QnkfIWG3hg0QHlPpHxEhFgLDjkfOGIqEECDyI
         zRCBBySSfL4vA==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 12/01/2020 17:29, Dmitry Osipenko wrote:
> Use resource-managed variant of request_irq for brevity.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/dma/tegra20-apb-dma.c | 35 +++++++++++------------------------
>  1 file changed, 11 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index f44291207928..dff21e80ffa4 100644
> --- a/drivers/dma/tegra20-apb-dma.c
> +++ b/drivers/dma/tegra20-apb-dma.c
> @@ -182,7 +182,6 @@ struct tegra_dma_channel {
>  	char			name[12];
>  	bool			config_init;
>  	int			id;
> -	int			irq;
>  	void __iomem		*chan_addr;
>  	spinlock_t		lock;
>  	bool			busy;
> @@ -1380,7 +1379,6 @@ static const struct tegra_dma_chip_data tegra148_dma_chip_data = {
>  
>  static int tegra_dma_probe(struct platform_device *pdev)
>  {
> -	struct resource *res;
>  	struct tegra_dma *tdma;
>  	int ret;
>  	int i;
> @@ -1446,25 +1444,27 @@ static int tegra_dma_probe(struct platform_device *pdev)
>  	INIT_LIST_HEAD(&tdma->dma_dev.channels);
>  	for (i = 0; i < cdata->nr_channels; i++) {
>  		struct tegra_dma_channel *tdc = &tdma->channels[i];
> +		int irq;
>  
>  		tdc->chan_addr = tdma->base_addr +
>  				 TEGRA_APBDMA_CHANNEL_BASE_ADD_OFFSET +
>  				 (i * cdata->channel_reg_size);
>  
> -		res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
> -		if (!res) {
> -			ret = -EINVAL;
> +		irq = platform_get_irq(pdev, i);
> +		if (irq < 0) {
> +			ret = irq;
>  			dev_err(&pdev->dev, "No irq resource for chan %d\n", i);
> -			goto err_irq;
> +			goto err_pm_disable;
>  		}
> -		tdc->irq = res->start;
> +
>  		snprintf(tdc->name, sizeof(tdc->name), "apbdma.%d", i);
> -		ret = request_irq(tdc->irq, tegra_dma_isr, 0, tdc->name, tdc);
> +		ret = devm_request_irq(&pdev->dev, irq, tegra_dma_isr, 0,
> +				       tdc->name, tdc);
>  		if (ret) {
>  			dev_err(&pdev->dev,
>  				"request_irq failed with err %d channel %d\n",
>  				ret, i);
> -			goto err_irq;
> +			goto err_pm_disable;
>  		}
>  
>  		tdc->dma_chan.device = &tdma->dma_dev;
> @@ -1517,7 +1517,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
>  	if (ret < 0) {
>  		dev_err(&pdev->dev,
>  			"Tegra20 APB DMA driver registration failed %d\n", ret);
> -		goto err_irq;
> +		goto err_pm_disable;
>  	}
>  
>  	ret = of_dma_controller_register(pdev->dev.of_node,
> @@ -1534,13 +1534,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
>  
>  err_unregister_dma_dev:
>  	dma_async_device_unregister(&tdma->dma_dev);
> -err_irq:
> -	while (--i >= 0) {
> -		struct tegra_dma_channel *tdc = &tdma->channels[i];
> -
> -		free_irq(tdc->irq, tdc);
> -	}
> -
> +err_pm_disable:
>  	pm_runtime_disable(&pdev->dev);
>  	if (!pm_runtime_status_suspended(&pdev->dev))
>  		tegra_dma_runtime_suspend(&pdev->dev);
> @@ -1550,16 +1544,9 @@ static int tegra_dma_probe(struct platform_device *pdev)
>  static int tegra_dma_remove(struct platform_device *pdev)
>  {
>  	struct tegra_dma *tdma = platform_get_drvdata(pdev);
> -	int i;
> -	struct tegra_dma_channel *tdc;
>  
>  	dma_async_device_unregister(&tdma->dma_dev);
>  
> -	for (i = 0; i < tdma->chip_data->nr_channels; ++i) {
> -		tdc = &tdma->channels[i];
> -		free_irq(tdc->irq, tdc);
> -	}
> -
>  	pm_runtime_disable(&pdev->dev);
>  	if (!pm_runtime_status_suspended(&pdev->dev))
>  		tegra_dma_runtime_suspend(&pdev->dev);
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
