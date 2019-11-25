Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83AB9108B15
	for <lists+dmaengine@lfdr.de>; Mon, 25 Nov 2019 10:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfKYJl5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Nov 2019 04:41:57 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45884 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbfKYJl5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Nov 2019 04:41:57 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAP9fo0H047014;
        Mon, 25 Nov 2019 03:41:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574674910;
        bh=BHjdmBMXCMcSGb88sm3bp+JyzgDIOeOSY4gWD4Khgwg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YR/avMkwc/DqOMGkO+XmNiAFMOwoyWsQ1tVsmD1KqwYFAzncs20ndywNuM+A3rVPE
         u3Kzc/ZrcIXTMfhYVOqGpJRVwYRrCzg52MGOiaIKNWlUS31MiCsJh86Eg2PaC83QlC
         28CW8ao2jSCFt0cUcItHqxE7eS5Sb8Cw4d/irp/w=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAP9foS7059430;
        Mon, 25 Nov 2019 03:41:50 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 25
 Nov 2019 03:41:49 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 25 Nov 2019 03:41:49 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAP9fl96024639;
        Mon, 25 Nov 2019 03:41:48 -0600
Subject: Re: [PATCH v2] dmaengine: ti: edma: add missed operations
To:     Chuhong Yuan <hslester96@gmail.com>
CC:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20191124052855.6472-1-hslester96@gmail.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <e4b05132-df91-f53d-158c-793fdfd56f25@ti.com>
Date:   Mon, 25 Nov 2019 11:41:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191124052855.6472-1-hslester96@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 24/11/2019 7.28, Chuhong Yuan wrote:
> The driver forgets to call pm_runtime_disable and pm_runtime_put_sync in
> probe failure and remove.
> Add the calls and modify probe failure handling to fix it.
> 
> To simplify the fix, the patch adjusts the calling order and merges checks
> for devm_kcalloc.
> 
> Fixes: 2b6b3b742019 ("ARM/dmaengine: edma: Merge the two drivers under drivers/dma/")
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
> Changes in v2:
>   - Add the missed pm_runtime_put_sync.
>   - Simplify the patch.
>   - Rebase to dma-next.

Thank you,

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> 
>  drivers/dma/ti/edma.c | 37 ++++++++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> index 756a3c951dc7..0628ee4bf1b4 100644
> --- a/drivers/dma/ti/edma.c
> +++ b/drivers/dma/ti/edma.c
> @@ -2289,13 +2289,6 @@ static int edma_probe(struct platform_device *pdev)
>  	if (!info)
>  		return -ENODEV;
>  
> -	pm_runtime_enable(dev);
> -	ret = pm_runtime_get_sync(dev);
> -	if (ret < 0) {
> -		dev_err(dev, "pm_runtime_get_sync() failed\n");
> -		return ret;
> -	}
> -
>  	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>  	if (ret)
>  		return ret;
> @@ -2326,27 +2319,31 @@ static int edma_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, ecc);
>  
> +	pm_runtime_enable(dev);
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "pm_runtime_get_sync() failed\n");
> +		pm_runtime_disable(dev);
> +		return ret;
> +	}
> +
>  	/* Get eDMA3 configuration from IP */
>  	ret = edma_setup_from_hw(dev, info, ecc);
>  	if (ret)
> -		return ret;
> +		goto err_disable_pm;
>  
>  	/* Allocate memory based on the information we got from the IP */
>  	ecc->slave_chans = devm_kcalloc(dev, ecc->num_channels,
>  					sizeof(*ecc->slave_chans), GFP_KERNEL);
> -	if (!ecc->slave_chans)
> -		return -ENOMEM;
>  
>  	ecc->slot_inuse = devm_kcalloc(dev, BITS_TO_LONGS(ecc->num_slots),
>  				       sizeof(unsigned long), GFP_KERNEL);
> -	if (!ecc->slot_inuse)
> -		return -ENOMEM;
>  
>  	ecc->channels_mask = devm_kcalloc(dev,
>  					   BITS_TO_LONGS(ecc->num_channels),
>  					   sizeof(unsigned long), GFP_KERNEL);
> -	if (!ecc->channels_mask)
> -		return -ENOMEM;
> +	if (!ecc->slave_chans || !ecc->slot_inuse || !ecc->channels_mask)
> +		goto err_disable_pm;
>  
>  	/* Mark all channels available initially */
>  	bitmap_fill(ecc->channels_mask, ecc->num_channels);
> @@ -2388,7 +2385,7 @@ static int edma_probe(struct platform_device *pdev)
>  				       ecc);
>  		if (ret) {
>  			dev_err(dev, "CCINT (%d) failed --> %d\n", irq, ret);
> -			return ret;
> +			goto err_disable_pm;
>  		}
>  		ecc->ccint = irq;
>  	}
> @@ -2404,7 +2401,7 @@ static int edma_probe(struct platform_device *pdev)
>  				       ecc);
>  		if (ret) {
>  			dev_err(dev, "CCERRINT (%d) failed --> %d\n", irq, ret);
> -			return ret;
> +			goto err_disable_pm;
>  		}
>  		ecc->ccerrint = irq;
>  	}
> @@ -2412,7 +2409,8 @@ static int edma_probe(struct platform_device *pdev)
>  	ecc->dummy_slot = edma_alloc_slot(ecc, EDMA_SLOT_ANY);
>  	if (ecc->dummy_slot < 0) {
>  		dev_err(dev, "Can't allocate PaRAM dummy slot\n");
> -		return ecc->dummy_slot;
> +		ret = ecc->dummy_slot;
> +		goto err_disable_pm;
>  	}
>  
>  	queue_priority_mapping = info->queue_priority_mapping;
> @@ -2512,6 +2510,9 @@ static int edma_probe(struct platform_device *pdev)
>  
>  err_reg1:
>  	edma_free_slot(ecc, ecc->dummy_slot);
> +err_disable_pm:
> +	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);
>  	return ret;
>  }
>  
> @@ -2542,6 +2543,8 @@ static int edma_remove(struct platform_device *pdev)
>  	if (ecc->dma_memcpy)
>  		dma_async_device_unregister(ecc->dma_memcpy);
>  	edma_free_slot(ecc, ecc->dummy_slot);
> +	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);
>  
>  	return 0;
>  }
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
