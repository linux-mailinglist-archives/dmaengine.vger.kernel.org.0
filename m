Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF6F10674C
	for <lists+dmaengine@lfdr.de>; Fri, 22 Nov 2019 08:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfKVHvC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Nov 2019 02:51:02 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53710 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfKVHvC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Nov 2019 02:51:02 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAM7oqIF090014;
        Fri, 22 Nov 2019 01:50:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574409052;
        bh=nk1aJbB0a61/1Y1yPPwV+6t0qLWNrPuDsFJe8epqbXk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Lxvz5WrumkO9Y0+xYGbcNQITZuVwBsh5WkKCnzF9iqEyr/w4Mf3wKm0IklS/a1El8
         Z3aBWniIxJ6e789rxLCYhjStqkdkkXcaV1uZy4uOKWe4WTLjbiFLsAzN9G7myzzZbi
         wV76fDBnNXIF2tMQENeLVu3wfa714o1yHSXnAyVk=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAM7oq4J066898
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Nov 2019 01:50:52 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 22
 Nov 2019 01:50:50 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 22 Nov 2019 01:50:50 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAM7onVe123373;
        Fri, 22 Nov 2019 01:50:49 -0600
Subject: Re: [PATCH 1/2] dmaengine: ti: edma: add missed pm_runtime_disable
To:     Chuhong Yuan <hslester96@gmail.com>
CC:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20191118073728.28366-1-hslester96@gmail.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <9ce1c3bb-3af8-6f6e-6f8f-cf2ab091de84@ti.com>
Date:   Fri, 22 Nov 2019 09:50:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191118073728.28366-1-hslester96@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On 18/11/2019 9.37, Chuhong Yuan wrote:
> The driver forgets to call pm_runtime_disable in probe failure and
> remove.
> Add the calls and modify probe failure handling to fix it.
> 
> Fixes: 2b6b3b742019 ("ARM/dmaengine: edma: Merge the two drivers under drivers/dma/")
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  drivers/dma/ti/edma.c | 43 ++++++++++++++++++++++++++++---------------
>  1 file changed, 28 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> index ba7c4f07fcd6..8be32fd9f762 100644
> --- a/drivers/dma/ti/edma.c
> +++ b/drivers/dma/ti/edma.c
> @@ -2282,16 +2282,18 @@ static int edma_probe(struct platform_device *pdev)

Please move the pm_runtime_enable/get section just before
edma_setup_from_hw()

>  	ret = pm_runtime_get_sync(dev);
>  	if (ret < 0) {
>  		dev_err(dev, "pm_runtime_get_sync() failed\n");
> -		return ret;
> +		goto err_disable_pm;

Here you need:
	pm_runtime_disable(dev);
	return ret;

>  	}
>  
>  	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>  	if (ret)
> -		return ret;
> +		goto err_disable_pm;
>  
>  	ecc = devm_kzalloc(dev, sizeof(*ecc), GFP_KERNEL);
> -	if (!ecc)
> -		return -ENOMEM;
> +	if (!ecc) {
> +		ret = -ENOMEM;
> +		goto err_disable_pm;
> +	}
>  
>  	ecc->dev = dev;
>  	ecc->id = pdev->id;
> @@ -2306,30 +2308,37 @@ static int edma_probe(struct platform_device *pdev)
>  		mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  		if (!mem) {
>  			dev_err(dev, "no mem resource?\n");
> -			return -ENODEV;
> +			ret = -ENODEV;
> +			goto err_disable_pm;
>  		}
>  	}
>  	ecc->base = devm_ioremap_resource(dev, mem);
> -	if (IS_ERR(ecc->base))
> -		return PTR_ERR(ecc->base);
> +	if (IS_ERR(ecc->base)) {
> +		ret = PTR_ERR(ecc->base);
> +		goto err_disable_pm;
> +	}

None of the above changes needed since the pm_runtime initialization is
moved

>  	platform_set_drvdata(pdev, ecc);

here.

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
> +	if (!ecc->slave_chans) {
> +		ret = -ENOMEM;
> +		goto err_disable_pm;
> +	}
>  
>  	ecc->slot_inuse = devm_kcalloc(dev, BITS_TO_LONGS(ecc->num_slots),
>  				       sizeof(unsigned long), GFP_KERNEL);
> -	if (!ecc->slot_inuse)
> -		return -ENOMEM;
> +	if (!ecc->slot_inuse) {
> +		ret = -ENOMEM;
> +		goto err_disable_pm;
> +	}

and this does not apply since we have the
	ecc->channels_mask = devm_kcalloc()
in here.

If you rebase, then I would suggest to combine the memory allocation
checks into one:
if (!ecc->slave_chans || !ecc->slot_inuse | !ecc->channels_mask) {
	ret = -ENOMEM;
	goto err_disable_pm;
}

>  
>  	ecc->default_queue = info->default_queue;
>  
> @@ -2368,7 +2377,7 @@ static int edma_probe(struct platform_device *pdev)
>  				       ecc);
>  		if (ret) {
>  			dev_err(dev, "CCINT (%d) failed --> %d\n", irq, ret);
> -			return ret;
> +			goto err_disable_pm;
>  		}
>  		ecc->ccint = irq;
>  	}
> @@ -2384,7 +2393,7 @@ static int edma_probe(struct platform_device *pdev)
>  				       ecc);
>  		if (ret) {
>  			dev_err(dev, "CCERRINT (%d) failed --> %d\n", irq, ret);
> -			return ret;
> +			goto err_disable_pm;
>  		}
>  		ecc->ccerrint = irq;
>  	}
> @@ -2392,7 +2401,8 @@ static int edma_probe(struct platform_device *pdev)
>  	ecc->dummy_slot = edma_alloc_slot(ecc, EDMA_SLOT_ANY);
>  	if (ecc->dummy_slot < 0) {
>  		dev_err(dev, "Can't allocate PaRAM dummy slot\n");
> -		return ecc->dummy_slot;
> +		ret = ecc->dummy_slot;
> +		goto err_disable_pm;
>  	}
>  
>  	queue_priority_mapping = info->queue_priority_mapping;
> @@ -2473,6 +2483,8 @@ static int edma_probe(struct platform_device *pdev)
>  
>  err_reg1:
>  	edma_free_slot(ecc, ecc->dummy_slot);
> +err_disable_pm:

Please add:
	pm_runtime_put_sync(dev);

> +	pm_runtime_disable(dev);
>  	return ret;
>  }
>  
> @@ -2503,6 +2515,7 @@ static int edma_remove(struct platform_device *pdev)
>  	if (ecc->dma_memcpy)
>  		dma_async_device_unregister(ecc->dma_memcpy);
>  	edma_free_slot(ecc, ecc->dummy_slot);

Here also:
	pm_runtime_put_sync(dev);


> +	pm_runtime_disable(dev);
>  
>  	return 0;
>  }
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
