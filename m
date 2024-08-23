Return-Path: <dmaengine+bounces-2945-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A15095CBD0
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2024 13:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEB121C23D88
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2024 11:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02ECD17E01E;
	Fri, 23 Aug 2024 11:58:27 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C65469D;
	Fri, 23 Aug 2024 11:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414306; cv=none; b=eY0xHHzoyOsLt7yvGKHReLS3lz23w8X8KtWaNZ0W2HoPh0arvL7MY9eUt2Fw7cSmaN72hmsSLkSuIgZ5/M/mQiC06LkPJj0G3HEe/8uvYyoWbwlFqo00Uzj0icVHugSBZgjgs//+ORaesqsK8JZ7+Mp94OXgqWElCPQ4I/0u+B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414306; c=relaxed/simple;
	bh=9GIYemtz5qiYNCnX3D/zATMXs/6JTh+JyVpzxZFb7w0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sJ+J932V3TJz9ZdgWnVQvYy95yA60NEK9nMk/jtu9AJz5PZmWNuQCnRy4ws7GCOBSzZlOIFo4jpTBx+/6e/sO+cJPUy5PxGvQv9woXtHIFjwByz1vg/NznHWFueqGTgc3GXKMojhdD5dbcTimRoEcnQo+g2/UpVNeWSBSBjbDCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wqz5t164tz6DBWm;
	Fri, 23 Aug 2024 19:55:14 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id F2E0E140A70;
	Fri, 23 Aug 2024 19:58:22 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 23 Aug
 2024 12:58:22 +0100
Date: Fri, 23 Aug 2024 12:58:21 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
CC: <vkoul@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] dma:at_hdmac:Use devm_clk_get_enabled() helpers
Message-ID: <20240823125821.000032c2@Huawei.com>
In-Reply-To: <20240823101933.9517-2-liaoyuanhong@vivo.com>
References: <20240823101933.9517-1-liaoyuanhong@vivo.com>
	<20240823101933.9517-2-liaoyuanhong@vivo.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 23 Aug 2024 18:19:28 +0800
Liao Yuanhong <liaoyuanhong@vivo.com> wrote:

> Use devm_clk_get_enabled() instead of clk functions in at_hdmac.

Doesn't this stop the clock being turned of in suspend?

Or is there some magic handling that which I'm not aware of?


> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  drivers/dma/at_hdmac.c | 22 +++++-----------------
>  1 file changed, 5 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index 40052d1bd0b5..b1e10541cb12 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -337,7 +337,6 @@ static inline u8 convert_buswidth(enum dma_slave_buswidth addr_width)
>   * struct at_dma - internal representation of an Atmel HDMA Controller
>   * @dma_device: dmaengine dma_device object members
>   * @regs: memory mapped register base
> - * @clk: dma controller clock
>   * @save_imr: interrupt mask register that is saved on suspend/resume cycle
>   * @all_chan_mask: all channels availlable in a mask
>   * @lli_pool: hw lli table
> @@ -347,7 +346,6 @@ static inline u8 convert_buswidth(enum dma_slave_buswidth addr_width)
>  struct at_dma {
>  	struct dma_device	dma_device;
>  	void __iomem		*regs;
> -	struct clk		*clk;
>  	u32			save_imr;
>  
>  	u8			all_chan_mask;
> @@ -1942,6 +1940,7 @@ static int __init at_dma_probe(struct platform_device *pdev)
>  	int			err;
>  	int			i;
>  	const struct at_dma_platform_data *plat_dat;
> +	struct clk	*clk;
>  
>  	/* setup platform data for each SoC */
>  	dma_cap_set(DMA_MEMCPY, at91sam9rl_config.cap_mask);
> @@ -1975,20 +1974,16 @@ static int __init at_dma_probe(struct platform_device *pdev)
>  	atdma->dma_device.cap_mask = plat_dat->cap_mask;
>  	atdma->all_chan_mask = (1 << plat_dat->nr_channels) - 1;
>  
> -	atdma->clk = devm_clk_get(&pdev->dev, "dma_clk");
> -	if (IS_ERR(atdma->clk))
> -		return PTR_ERR(atdma->clk);
> -
> -	err = clk_prepare_enable(atdma->clk);
> -	if (err)
> -		return err;
> +	clk = devm_clk_get_enabled(&pdev->dev, "dma_clk");
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
>  
>  	/* force dma off, just in case */
>  	at_dma_off(atdma);
>  
>  	err = request_irq(irq, at_dma_interrupt, 0, "at_hdmac", atdma);
>  	if (err)
> -		goto err_irq;
> +		return err;
>  
>  	platform_set_drvdata(pdev, atdma);
>  
> @@ -2105,8 +2100,6 @@ static int __init at_dma_probe(struct platform_device *pdev)
>  	dma_pool_destroy(atdma->lli_pool);
>  err_desc_pool_create:
>  	free_irq(platform_get_irq(pdev, 0), atdma);
> -err_irq:
> -	clk_disable_unprepare(atdma->clk);
>  	return err;
>  }
>  
> @@ -2130,8 +2123,6 @@ static void at_dma_remove(struct platform_device *pdev)
>  		atc_disable_chan_irq(atdma, chan->chan_id);
>  		list_del(&chan->device_node);
>  	}
> -
> -	clk_disable_unprepare(atdma->clk);
>  }
>  
>  static void at_dma_shutdown(struct platform_device *pdev)
> @@ -2139,7 +2130,6 @@ static void at_dma_shutdown(struct platform_device *pdev)
>  	struct at_dma	*atdma = platform_get_drvdata(pdev);
>  
>  	at_dma_off(platform_get_drvdata(pdev));
> -	clk_disable_unprepare(atdma->clk);
>  }
>  
>  static int at_dma_prepare(struct device *dev)
> @@ -2194,7 +2184,6 @@ static int at_dma_suspend_noirq(struct device *dev)
>  
>  	/* disable DMA controller */
>  	at_dma_off(atdma);
> -	clk_disable_unprepare(atdma->clk);
>  	return 0;
>  }
>  
> @@ -2223,7 +2212,6 @@ static int at_dma_resume_noirq(struct device *dev)
>  	struct dma_chan *chan, *_chan;
>  
>  	/* bring back DMA controller */
> -	clk_prepare_enable(atdma->clk);
>  	dma_writel(atdma, EN, AT_DMA_ENABLE);
>  
>  	/* clear any pending interrupt */


