Return-Path: <dmaengine+bounces-4874-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBADA85014
	for <lists+dmaengine@lfdr.de>; Fri, 11 Apr 2025 01:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A205C4A8094
	for <lists+dmaengine@lfdr.de>; Thu, 10 Apr 2025 23:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1DD1E231F;
	Thu, 10 Apr 2025 23:25:05 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCE320E334
	for <dmaengine@vger.kernel.org>; Thu, 10 Apr 2025 23:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744327505; cv=none; b=UyNSDGne5kbD9hpAOLo6DME/HtIWmwjkYClbemhyYPHaIXfDqMlg1do6wUOWpiK9arvPWJaJp3GCaDTRMHwHIH54iwqGtUXUB4GGCktQ2NtlQPde76rbnyB7VFSYKkpVoklTZojS7V+qx0o2UFXRDDTWs0hhyQI8wcXLa4TCUL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744327505; c=relaxed/simple;
	bh=MOakOH7mYm88UkVKU/M+qhZLIisGmXpRjDCxOJZUo10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eucIGnpQOBiLsd1QDHue+OOcV8OtJ42saWprBLFrIpx7LqjPr4tP1p//69/3tseO95iRHLtMmfPi1fW2hLzAmND7WSXvKCY82qhBPytj4UnroIr0yhIalevzboQfl1314WFZAum5GhHmkW6NEpcqvYukn4DGyekulZRUtDY7Ncw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1u31GX-0004GK-7Y; Fri, 11 Apr 2025 01:25:01 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1u31GX-004LKx-08;
	Fri, 11 Apr 2025 01:25:01 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1u31GW-00AVe0-32;
	Fri, 11 Apr 2025 01:25:00 +0200
Date: Fri, 11 Apr 2025 01:25:00 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: kernel@pengutronix.de,
	"vkoul@kernel.org, shawnguo@kernel.org, Sascha Hauer" <s.hauer@pengutronix.de>
Cc: dmaengine@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/10] dmaengine: imx-sdma: drop legacy device_node np
 check
Message-ID: <20250410232500.fnk2puzykihkcbna@pengutronix.de>
References: <20250410232247.1434659-1-m.felsch@pengutronix.de>
 <20250410232247.1434659-2-m.felsch@pengutronix.de>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410232247.1434659-2-m.felsch@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org

On 25-04-11, Marco Felsch wrote:
> The legacy 'if (np)' was required in past where we had pdata and dt.
> Nowadays the driver binds only to dt platforms. So using a new kernel
> but still use pdata is not possible, therefore we can drop the legacy
> 'if' code path.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Please ignore this patch, I had issues with my mail setup.

Regards,
  Marco


> ---
>  drivers/dma/imx-sdma.c | 32 ++++++++++++++------------------
>  1 file changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 3449006cd14b..699f0c6b5ae5 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -2326,11 +2326,9 @@ static int sdma_probe(struct platform_device *pdev)
>  			vchan_init(&sdmac->vc, &sdma->dma_device);
>  	}
>  
> -	if (np) {
> -		sdma->iram_pool = of_gen_pool_get(np, "iram", 0);
> -		if (sdma->iram_pool)
> -			dev_info(&pdev->dev, "alloc bd from iram.\n");
> -	}
> +	sdma->iram_pool = of_gen_pool_get(np, "iram", 0);
> +	if (sdma->iram_pool)
> +		dev_info(&pdev->dev, "alloc bd from iram.\n");
>  
>  	ret = sdma_init(sdma);
>  	if (ret)
> @@ -2370,21 +2368,19 @@ static int sdma_probe(struct platform_device *pdev)
>  		goto err_init;
>  	}
>  
> -	if (np) {
> -		ret = of_dma_controller_register(np, sdma_xlate, sdma);
> -		if (ret) {
> -			dev_err(&pdev->dev, "failed to register controller\n");
> -			goto err_register;
> -		}
> +	ret = of_dma_controller_register(np, sdma_xlate, sdma);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register controller\n");
> +		goto err_register;
> +	}
>  
> -		spba_bus = of_find_compatible_node(NULL, NULL, "fsl,spba-bus");
> -		ret = of_address_to_resource(spba_bus, 0, &spba_res);
> -		if (!ret) {
> -			sdma->spba_start_addr = spba_res.start;
> -			sdma->spba_end_addr = spba_res.end;
> -		}
> -		of_node_put(spba_bus);
> +	spba_bus = of_find_compatible_node(NULL, NULL, "fsl,spba-bus");
> +	ret = of_address_to_resource(spba_bus, 0, &spba_res);
> +	if (!ret) {
> +		sdma->spba_start_addr = spba_res.start;
> +		sdma->spba_end_addr = spba_res.end;
>  	}
> +	of_node_put(spba_bus);
>  
>  	/*
>  	 * Because that device tree does not encode ROM script address,
> -- 
> 2.39.5
> 
> 
> 

