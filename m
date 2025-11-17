Return-Path: <dmaengine+bounces-7235-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DA53BC65F83
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 20:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5162B355F77
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 19:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE21330B35;
	Mon, 17 Nov 2025 19:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="N96Yf/uX";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="N96Yf/uX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB74E32F759;
	Mon, 17 Nov 2025 19:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763407493; cv=none; b=IKIEHAamf5tBDjeqwZNZAm3qeg0zFov5zl9nF6deOrDGm5g2pGpjMz2DUZqcB4q/+s83T2Y4lvFg3VvmyJxIk72N7WxwqXuZ6EjbPZeVpCrJiTWQMhV3NxnXnpfEDNqQ0vjerHyFNQrDM5ZXygekHw/2KjGulljo51vDknao2m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763407493; c=relaxed/simple;
	bh=kr8XYJleaZfABLzNB9f0KF+kt7RreSx+5YDnN5v88/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RVr0N/an4W0RbzE8A3y6cvwhb/4AvUNSTfJKuIV9caWQ01oTyYEk0bME5FRXPQdstzvmYsYVZj/ld8TSj+yhmzUWWtUaigfCpM34eAdXsHgCUA6ISuUGgwrd7/PPq2bCbUYFSYZ/pBnPJ+Xrz9kBivIVOtO42exkmkmzC3+138Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=N96Yf/uX; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=N96Yf/uX; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1763407490; bh=kr8XYJleaZfABLzNB9f0KF+kt7RreSx+5YDnN5v88/A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N96Yf/uXnQGAbBQ7h+v7vk0gHzSdE5njoIWpMim1QTrz4+lSMUxS8UMdjb2y8DrTP
	 4GW6SxUkawU5qDC6BeS+c+Z29r6xXVcdZgOgrH2Ck5zd02WPhDJt1+hFDD++arttlU
	 Yrmsdpb/OByV/dOp/ZQp7aMah4b+XoTs2xSelo1zBfvTflKS4F/U5kWhGDVOyOqdvV
	 cQH+dO7+K5QQg49oDbreJmldl0nicvr2LiXMHG5idKBOx3ETWL28Kx0FHA/n2WsKhR
	 eRo562GmAHL8O4AofPrwEf61QcFg8STkauP+ghYK8xkWp0n44Op4IbNXPiagaqgp/W
	 FoXX2aqV3wMmw==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 49C4C3E1D1D;
	Mon, 17 Nov 2025 19:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1763407490; bh=kr8XYJleaZfABLzNB9f0KF+kt7RreSx+5YDnN5v88/A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N96Yf/uXnQGAbBQ7h+v7vk0gHzSdE5njoIWpMim1QTrz4+lSMUxS8UMdjb2y8DrTP
	 4GW6SxUkawU5qDC6BeS+c+Z29r6xXVcdZgOgrH2Ck5zd02WPhDJt1+hFDD++arttlU
	 Yrmsdpb/OByV/dOp/ZQp7aMah4b+XoTs2xSelo1zBfvTflKS4F/U5kWhGDVOyOqdvV
	 cQH+dO7+K5QQg49oDbreJmldl0nicvr2LiXMHG5idKBOx3ETWL28Kx0FHA/n2WsKhR
	 eRo562GmAHL8O4AofPrwEf61QcFg8STkauP+ghYK8xkWp0n44Op4IbNXPiagaqgp/W
	 FoXX2aqV3wMmw==
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi [91.159.24.186])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mleia.com (Postfix) with ESMTPSA id 707A73E1D02;
	Mon, 17 Nov 2025 19:24:49 +0000 (UTC)
Message-ID: <2e38039b-f136-44c6-829c-1d98783bbb1a@mleia.com>
Date: Mon, 17 Nov 2025 21:24:48 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/15] dmaengine: lpc18xx-dmamux: fix device leak on route
 allocation
To: Johan Hovold <johan@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>,
 Viresh Kumar <vireshk@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 =?UTF-8?Q?Am=C3=A9lie_Delaunay?= <amelie.delaunay@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251117161258.10679-1-johan@kernel.org>
 <20251117161258.10679-8-johan@kernel.org>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20251117161258.10679-8-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20251117_192450_322343_1DBD9D04 
X-CRM114-Status: GOOD (  20.21  )

Hi Johan.

On 11/17/25 18:12, Johan Hovold wrote:
> Make sure to drop the reference taken when looking up the DMA mux
> platform device during route allocation.
> 
> Note that holding a reference to a device does not prevent its driver
> data from going away so there is no point in keeping the reference.
> 
> Fixes: e5f4ae84be74 ("dmaengine: add driver for lpc18xx dmamux")
> Cc: stable@vger.kernel.org	# 4.3
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>   drivers/dma/lpc18xx-dmamux.c | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/lpc18xx-dmamux.c b/drivers/dma/lpc18xx-dmamux.c
> index 2b6436f4b193..d3ff521951b8 100644
> --- a/drivers/dma/lpc18xx-dmamux.c
> +++ b/drivers/dma/lpc18xx-dmamux.c
> @@ -57,30 +57,31 @@ static void *lpc18xx_dmamux_reserve(struct of_phandle_args *dma_spec,
>   	struct lpc18xx_dmamux_data *dmamux = platform_get_drvdata(pdev);
>   	unsigned long flags;
>   	unsigned mux;
> +	int ret = -EINVAL;
>   
>   	if (dma_spec->args_count != 3) {
>   		dev_err(&pdev->dev, "invalid number of dma mux args\n");
> -		return ERR_PTR(-EINVAL);
> +		goto err_put_pdev;
>   	}
>   
>   	mux = dma_spec->args[0];
>   	if (mux >= dmamux->dma_master_requests) {
>   		dev_err(&pdev->dev, "invalid mux number: %d\n",
>   			dma_spec->args[0]);
> -		return ERR_PTR(-EINVAL);
> +		goto err_put_pdev;
>   	}
>   
>   	if (dma_spec->args[1] > LPC18XX_DMAMUX_MAX_VAL) {
>   		dev_err(&pdev->dev, "invalid dma mux value: %d\n",
>   			dma_spec->args[1]);
> -		return ERR_PTR(-EINVAL);
> +		goto err_put_pdev;
>   	}
>   
>   	/* The of_node_put() will be done in the core for the node */
>   	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", 0);
>   	if (!dma_spec->np) {
>   		dev_err(&pdev->dev, "can't get dma master\n");
> -		return ERR_PTR(-EINVAL);
> +		goto err_put_pdev;
>   	}
>   
>   	spin_lock_irqsave(&dmamux->lock, flags);
> @@ -89,7 +90,8 @@ static void *lpc18xx_dmamux_reserve(struct of_phandle_args *dma_spec,
>   		dev_err(&pdev->dev, "dma request %u busy with %u.%u\n",
>   			mux, mux, dmamux->muxes[mux].value);
>   		of_node_put(dma_spec->np);
> -		return ERR_PTR(-EBUSY);
> +		ret = -EBUSY;
> +		goto err_put_pdev;
>   	}
>   
>   	dmamux->muxes[mux].busy = true;
> @@ -106,7 +108,14 @@ static void *lpc18xx_dmamux_reserve(struct of_phandle_args *dma_spec,
>   	dev_dbg(&pdev->dev, "mapping dmamux %u.%u to dma request %u\n", mux,
>   		dmamux->muxes[mux].value, mux);
>   
> +	put_device(&pdev->dev);
> +
>   	return &dmamux->muxes[mux];
> +
> +err_put_pdev:
> +	put_device(&pdev->dev);
> +
> +	return ERR_PTR(ret);
>   }
>   
>   static int lpc18xx_dmamux_probe(struct platform_device *pdev)

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

-- 
Best wishes,
Vladimir

