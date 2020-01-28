Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9F714B092
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jan 2020 08:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgA1HxW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Jan 2020 02:53:22 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43642 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgA1HxW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Jan 2020 02:53:22 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00S7qwsh032869;
        Tue, 28 Jan 2020 01:52:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580197978;
        bh=nDdLPYZ6LprTv2NjVWGFnvSMmFg46W0Ix7XgkSNJ8EY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=d/UvB+j8pNRgH37eFe3kuwKD0BAbukWFdtwrecsE/2l1bXd64J0e4b9QYHtjxaUPy
         11s0Zq9X2odVsawhOPTRqfO0GzLmj1WHKC63LGAh7XAM+CJ5VhhyohIH/mjTQM91fR
         Kx+AU9NJG9N9U6NcKEYJRGny7lpKBOuaQLmaCTsM=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00S7qwCT050697
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Jan 2020 01:52:58 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 28
 Jan 2020 01:52:57 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 28 Jan 2020 01:52:57 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00S7qtWf064227;
        Tue, 28 Jan 2020 01:52:55 -0600
Subject: Re: [PATCH] dma: ti: dma-crossbar: convert to
 devm_platform_ioremap_resource()
To:     <qiwuchen55@gmail.com>, <vkoul@kernel.org>,
        <dan.j.williams@intel.com>, <allison@lohutok.net>,
        <kstewart@linuxfoundation.org>
CC:     <tglx@linutronix.de>, <wenwen@cs.uga.edu>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        chenqiwu <chenqiwu@xiaomi.com>
References: <1580189746-2864-1-git-send-email-qiwuchen55@gmail.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <2d85b488-6cc1-f062-c926-b17d1165bde1@ti.com>
Date:   Tue, 28 Jan 2020 09:53:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1580189746-2864-1-git-send-email-qiwuchen55@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 28/01/2020 7.35, qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> Use a new API devm_platform_ioremap_resource() to simplify code.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> ---
>  drivers/dma/ti/dma-crossbar.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/ti/dma-crossbar.c b/drivers/dma/ti/dma-crossbar.c
> index f255056..4ba8fa5 100644
> --- a/drivers/dma/ti/dma-crossbar.c
> +++ b/drivers/dma/ti/dma-crossbar.c
> @@ -133,7 +133,6 @@ static int ti_am335x_xbar_probe(struct platform_device *pdev)
>  	const struct of_device_id *match;
>  	struct device_node *dma_node;
>  	struct ti_am335x_xbar_data *xbar;
> -	struct resource *res;
>  	void __iomem *iomem;
>  	int i, ret;
>  
> @@ -173,8 +172,7 @@ static int ti_am335x_xbar_probe(struct platform_device *pdev)
>  		xbar->xbar_events = TI_AM335X_XBAR_LINES;
>  	}
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	iomem = devm_ioremap_resource(&pdev->dev, res);
> +	iomem = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(iomem))
>  		return PTR_ERR(iomem);
>  
> @@ -323,7 +321,6 @@ static int ti_dra7_xbar_probe(struct platform_device *pdev)
>  	struct device_node *dma_node;
>  	struct ti_dra7_xbar_data *xbar;
>  	struct property *prop;
> -	struct resource *res;
>  	u32 safe_val;
>  	int sz;
>  	void __iomem *iomem;
> @@ -403,8 +400,7 @@ static int ti_dra7_xbar_probe(struct platform_device *pdev)
>  		kfree(rsv_events);
>  	}
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	iomem = devm_ioremap_resource(&pdev->dev, res);
> +	iomem = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(iomem))
>  		return PTR_ERR(iomem);
>  
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
