Return-Path: <dmaengine+bounces-2946-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B559F95CBEA
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2024 14:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69B501F23119
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2024 12:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FF8183CD3;
	Fri, 23 Aug 2024 12:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QUIOtHhn"
X-Original-To: dmaengine@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8600B17CA19;
	Fri, 23 Aug 2024 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414460; cv=none; b=lWYXqfJLMNH4EsqbDwrgv+0yiYzD9uYiNYI4l8iW2xkjbdCcnEogodVeJYrSAIjGdyrJsFrCIZp27vnXgjthPBmroR7brQ5tgWY328jvmukOtlcTJVkwPnNYXBhEtbDYdAbTzzeNl1pRCRp7W22vwjBjo630wOXHtU1PUw2N2xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414460; c=relaxed/simple;
	bh=zE6JwXga1hToBEut5TxRw4ysd3nAAB29rvqujAOt11k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aeDDoKNFzDXfmvtWQqQiz1Qkk+n9gXnU3mzPDguyTnmDDssborGu4sG82/qAC4LGeDeazGfi4lmriU2nZZNs2FuFoDFPfNfNMfIelDXK5H4a1jG5mcqb518kOZDrGrBsTVkCJ637w7O2CLWdxBK1gQzBhln16Y7n6yRi3rgdXyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QUIOtHhn; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1724414458; x=1755950458;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zE6JwXga1hToBEut5TxRw4ysd3nAAB29rvqujAOt11k=;
  b=QUIOtHhnYU+A2tXQgMbDaiu1nq2CskUeuHQ2z+IvQtKkyri+4FtKKbzl
   NvJCwKW1A9AfJthSRS0RyztDLIQC2gdya8929RPpbBiXJUKxZGt8jSLxe
   BXcIaaEnjrRVgozdmLP8nSXN8OywxB90Pbu9D5Gf1NAFj+JiIYJ8tPmSp
   K6IZmXHhL14Q3N7i1pK0n1jDmLgZ2ShW09vPpYCkR5I/8Zn8YsstUBkMz
   QFSOdFakMIyYPFNq3sW5Q6LHz+G9MvrzeGlYF1wEKBMQnWhOetcQo92NP
   RkEyr9VWkepsFc+e6dyXiCMUqCIRd1jRaBpJTMWI3O3dhJ3L+T5lsf3/b
   g==;
X-CSE-ConnectionGUID: KWwyA0NBRzO+vNq7XEnCpw==
X-CSE-MsgGUID: GqZHtg4dREmSm3J/70wCIQ==
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="31490812"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Aug 2024 05:00:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Aug 2024 05:00:53 -0700
Received: from [10.159.224.217] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 23 Aug 2024 05:00:51 -0700
Message-ID: <2bfd8efc-b52b-46c0-a43f-7acccfbee4f5@microchip.com>
Date: Fri, 23 Aug 2024 14:01:15 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dma:at_hdmac:Use devm_clk_get_enabled() helpers
To: Liao Yuanhong <liaoyuanhong@vivo.com>, <vkoul@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240823101933.9517-1-liaoyuanhong@vivo.com>
 <20240823101933.9517-2-liaoyuanhong@vivo.com>
Content-Language: en-US, fr-FR
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20240823101933.9517-2-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 23/08/2024 at 12:19, Liao Yuanhong wrote:
> Use devm_clk_get_enabled() instead of clk functions in at_hdmac.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>

With this patch, you remove the possibility to stop the clock during a 
suspend/resume cycle: why avoid to gain power during... low power phases?

NACK.

Regards,
   Nicolas

> ---
>   drivers/dma/at_hdmac.c | 22 +++++-----------------
>   1 file changed, 5 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index 40052d1bd0b5..b1e10541cb12 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -337,7 +337,6 @@ static inline u8 convert_buswidth(enum dma_slave_buswidth addr_width)
>    * struct at_dma - internal representation of an Atmel HDMA Controller
>    * @dma_device: dmaengine dma_device object members
>    * @regs: memory mapped register base
> - * @clk: dma controller clock
>    * @save_imr: interrupt mask register that is saved on suspend/resume cycle
>    * @all_chan_mask: all channels availlable in a mask
>    * @lli_pool: hw lli table
> @@ -347,7 +346,6 @@ static inline u8 convert_buswidth(enum dma_slave_buswidth addr_width)
>   struct at_dma {
>          struct dma_device       dma_device;
>          void __iomem            *regs;
> -       struct clk              *clk;
>          u32                     save_imr;
> 
>          u8                      all_chan_mask;
> @@ -1942,6 +1940,7 @@ static int __init at_dma_probe(struct platform_device *pdev)
>          int                     err;
>          int                     i;
>          const struct at_dma_platform_data *plat_dat;
> +       struct clk      *clk;
> 
>          /* setup platform data for each SoC */
>          dma_cap_set(DMA_MEMCPY, at91sam9rl_config.cap_mask);
> @@ -1975,20 +1974,16 @@ static int __init at_dma_probe(struct platform_device *pdev)
>          atdma->dma_device.cap_mask = plat_dat->cap_mask;
>          atdma->all_chan_mask = (1 << plat_dat->nr_channels) - 1;
> 
> -       atdma->clk = devm_clk_get(&pdev->dev, "dma_clk");
> -       if (IS_ERR(atdma->clk))
> -               return PTR_ERR(atdma->clk);
> -
> -       err = clk_prepare_enable(atdma->clk);
> -       if (err)
> -               return err;
> +       clk = devm_clk_get_enabled(&pdev->dev, "dma_clk");
> +       if (IS_ERR(clk))
> +               return PTR_ERR(clk);
> 
>          /* force dma off, just in case */
>          at_dma_off(atdma);
> 
>          err = request_irq(irq, at_dma_interrupt, 0, "at_hdmac", atdma);
>          if (err)
> -               goto err_irq;
> +               return err;
> 
>          platform_set_drvdata(pdev, atdma);
> 
> @@ -2105,8 +2100,6 @@ static int __init at_dma_probe(struct platform_device *pdev)
>          dma_pool_destroy(atdma->lli_pool);
>   err_desc_pool_create:
>          free_irq(platform_get_irq(pdev, 0), atdma);
> -err_irq:
> -       clk_disable_unprepare(atdma->clk);
>          return err;
>   }
> 
> @@ -2130,8 +2123,6 @@ static void at_dma_remove(struct platform_device *pdev)
>                  atc_disable_chan_irq(atdma, chan->chan_id);
>                  list_del(&chan->device_node);
>          }
> -
> -       clk_disable_unprepare(atdma->clk);
>   }
> 
>   static void at_dma_shutdown(struct platform_device *pdev)
> @@ -2139,7 +2130,6 @@ static void at_dma_shutdown(struct platform_device *pdev)
>          struct at_dma   *atdma = platform_get_drvdata(pdev);
> 
>          at_dma_off(platform_get_drvdata(pdev));
> -       clk_disable_unprepare(atdma->clk);
>   }
> 
>   static int at_dma_prepare(struct device *dev)
> @@ -2194,7 +2184,6 @@ static int at_dma_suspend_noirq(struct device *dev)
> 
>          /* disable DMA controller */
>          at_dma_off(atdma);
> -       clk_disable_unprepare(atdma->clk);
>          return 0;
>   }
> 
> @@ -2223,7 +2212,6 @@ static int at_dma_resume_noirq(struct device *dev)
>          struct dma_chan *chan, *_chan;
> 
>          /* bring back DMA controller */
> -       clk_prepare_enable(atdma->clk);
>          dma_writel(atdma, EN, AT_DMA_ENABLE);
> 
>          /* clear any pending interrupt */
> --
> 2.25.1
> 
> 


