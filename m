Return-Path: <dmaengine+bounces-3045-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AFF966191
	for <lists+dmaengine@lfdr.de>; Fri, 30 Aug 2024 14:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27C1F1F2823A
	for <lists+dmaengine@lfdr.de>; Fri, 30 Aug 2024 12:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF8F19ABB6;
	Fri, 30 Aug 2024 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="F1HE8OVo"
X-Original-To: dmaengine@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA4615C12D;
	Fri, 30 Aug 2024 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725020666; cv=none; b=aG/lWWS906nkr5DYu89X6XT5gqOpQDbK6nFmSUl9N3v/zUFQtG1dc2a2pm7kZk39gJDpK8BhI8n56kwLzan2Gw6GP+mgKU74XmiVlodN1Kg1fO+pXBWrrN0jJkUtEjfpfTUojhtFnJoOZ7TxQoXUQ4PXUjDWHbAhI2fI0thyQng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725020666; c=relaxed/simple;
	bh=cLyAG02PLUqREwBipCL05oGCPOekRFHbgr03E3ZyY1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ssk8C/SVnI5nZXHPWYPPPp37cV3hHO9+/4z8qi6KITtJEL0B+JfDvQ+lQM6agoNCB/t/Eo+qJZyiSXvqzB89PerNC+w6Zaey56hsBYJYDvPiBg6XjFMpLy7llq7OWJa2DGqHL9uXx2CJk0KiwyTLQETW0G1Kc9NtqGkteVnm9C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=F1HE8OVo; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725020665; x=1756556665;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cLyAG02PLUqREwBipCL05oGCPOekRFHbgr03E3ZyY1Q=;
  b=F1HE8OVo/jy4yPEP3wIwAB4wTXSXRWIj8sUsJKuXkyj9uptMK8nJgECt
   CArhlwsHbJcOYUH6MKYB/YjPVLYvvgR7Yj199zyeU7RaqIqbgXALMZ3mi
   g5+8AKWj3SHWjsNYMgX/8FrrBrRd7cFOo+SZkT8rKxMjGDJKg8LsDIexZ
   h5dsmDuC2Kvk5dI8lDOSxMMK2hyVez2/Fk2rkOX8k6l7tP0mwg8/k9tQc
   ejmdxNdyi1W9Q4OqJ91Gbq0981j/6mtLD/9XNTmZZK3J3lls9P1hPLgLw
   B2O4q5I8YAFh77AKuCtRURefqijh9T9tEw4etssvw16bF+KZ1VDuAmWmn
   Q==;
X-CSE-ConnectionGUID: jhUv9V1rRKaOEQO/6ledWg==
X-CSE-MsgGUID: NRqdXd9sSZeGPjy2o7JxcQ==
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="31097803"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Aug 2024 05:24:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 30 Aug 2024 05:23:58 -0700
Received: from [10.159.224.217] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 30 Aug 2024 05:23:57 -0700
Message-ID: <8ddf8cc7-0611-4c04-b814-be13ae14dedf@microchip.com>
Date: Fri, 30 Aug 2024 14:24:18 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] dmaengine:at_hdmac:Use devm_clk_get_enabled()
 helpers
Content-Language: en-US, fr-FR
To: Liao Yuanhong <liaoyuanhong@vivo.com>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <imx@lists.linux.dev>
References: <20240830094118.15458-1-liaoyuanhong@vivo.com>
 <20240830094118.15458-3-liaoyuanhong@vivo.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20240830094118.15458-3-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 30/08/2024 at 11:41, Liao Yuanhong wrote:
> Use devm_clk_get_enabled() instead of clk functions in at_hdmac.

I don't see how it could work: so please disregard at_hdmac when playing 
with "simplification". No subsequent version of this thing please.

NACK (again).

Best regards,
   Nicolas

> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
> v2:remove modifications related to the resume operation.
> ---
>   drivers/dma/at_hdmac.c | 16 ++--------------
>   1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index 40052d1bd0b5..2274aeb58271 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -1975,20 +1975,16 @@ static int __init at_dma_probe(struct platform_device *pdev)
>          atdma->dma_device.cap_mask = plat_dat->cap_mask;
>          atdma->all_chan_mask = (1 << plat_dat->nr_channels) - 1;
> 
> -       atdma->clk = devm_clk_get(&pdev->dev, "dma_clk");
> +       atdma->clk = devm_clk_get_enabled(&pdev->dev, "dma_clk");
>          if (IS_ERR(atdma->clk))
>                  return PTR_ERR(atdma->clk);
> 
> -       err = clk_prepare_enable(atdma->clk);
> -       if (err)
> -               return err;
> -
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
> @@ -2105,8 +2101,6 @@ static int __init at_dma_probe(struct platform_device *pdev)
>          dma_pool_destroy(atdma->lli_pool);
>   err_desc_pool_create:
>          free_irq(platform_get_irq(pdev, 0), atdma);
> -err_irq:
> -       clk_disable_unprepare(atdma->clk);
>          return err;
>   }
> 
> @@ -2130,16 +2124,11 @@ static void at_dma_remove(struct platform_device *pdev)
>                  atc_disable_chan_irq(atdma, chan->chan_id);
>                  list_del(&chan->device_node);
>          }
> -
> -       clk_disable_unprepare(atdma->clk);
>   }
> 
>   static void at_dma_shutdown(struct platform_device *pdev)
>   {
> -       struct at_dma   *atdma = platform_get_drvdata(pdev);
> -
>          at_dma_off(platform_get_drvdata(pdev));
> -       clk_disable_unprepare(atdma->clk);
>   }
> 
>   static int at_dma_prepare(struct device *dev)
> @@ -2194,7 +2183,6 @@ static int at_dma_suspend_noirq(struct device *dev)
> 
>          /* disable DMA controller */
>          at_dma_off(atdma);
> -       clk_disable_unprepare(atdma->clk);
>          return 0;
>   }
> 
> --
> 2.25.1
> 
> 


